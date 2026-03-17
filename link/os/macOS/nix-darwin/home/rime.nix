{
  pkgs,
  lib,
  config,
  ...
}: let
  rimeIceData = "${pkgs.rime-ice}/share/rime-data";
  rimeDir = "${config.home.homeDirectory}/Library/Rime";
in {
  # home.packages = with pkgs; [
  #   rime-ls
  #   librime
  # ];

  home.activation.installRimeConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # 确保目录存在
    mkdir -p "${rimeDir}"

    # 使用 rsync 同步
    # --chmod=u+w: 关键参数！确保复制过来的文件是“可写”的，否则鼠须管部署会失败
    # --delete: 可选，如果你想让你的 Rime 目录严格与雾凇拼音保持一致（会删除多余文件），小心使用

    echo "Syncing rime-ice from Nix Store..."
    ${pkgs.rsync}/bin/rsync -avz --chmod=u+w --exclude='.git*' "${rimeIceData}/" "${rimeDir}/"
  '';

  # 自定义配置保持不变
  home.file."Library/Rime/default.custom.yaml".text = ''
    patch:
      # 仅使用「雾凇拼音」的默认配置，配置此行即可
      __include: rime_ice_suggestion:/
      # 以下根据自己所需自行定义，仅做参考。
      # 针对对应处方的定制条目，请使用 <recipe>.custom.yaml 中配置，例如 rime_ice.custom.yaml
      __patch:

        ascii_composer/switch_key:
          Shift_L: noop
          Shift_R: noop
          Control_L: noop
          Control_R: noop

        key_binder/bindings/+:
              # jk 翻页
              - { when: has_menu, accept: Control+j, send: Page_Down }
              - { when: has_menu, accept: Control+k, send: Page_Up }

              # 翻页 , .
              - { when: paging, accept: comma, send: Page_Up }
              - { when: has_menu, accept: period, send: Page_Down }

  '';

  home.file."Library/Rime/double_pinyin_flypy.custom.yaml".text = ''
    patch:
      switches:
        - name: ascii_mode
          reset: 0
          states: [ 中, Ａ ]
        - name: ascii_punct  # 中英标点
          states: [ ¥, $ ]
        - name: traditionalization
          reset: 0
          states: [ 简, 繁 ]
        - name: emoji
          states: [ 💀, 😄 ]
          reset: 1
        - name: full_shape
          states: [ 半角, 全角 ]
        - name: search_single_char  # search.lua 的功能开关，辅码查词时是否单字优先
          abbrev: [词, 单]
          states: [正常, 单字]
  '';
}
