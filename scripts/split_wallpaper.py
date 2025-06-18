import cv2
import os
import argparse


def split_image(image_path, output_dir):
    # 确保输出目录存在
    os.makedirs(output_dir, exist_ok=True)

    # 读取图像
    image = cv2.imread(image_path)
    if image is None:
        print(f"无法读取图像：{image_path}")
        return

    # 获取图像的高度和宽度
    height, width, _ = image.shape

    # 计算中间点
    mid_point = width // 2

    # 分割图像
    left_part = image[:, :mid_point]
    right_part = image[:, mid_point:]

    # 获取文件名和扩展名
    base_name = os.path.basename(image_path)
    name, ext = os.path.splitext(base_name)

    # 设置输出路径
    if output_dir == "":
        output_dir = os.path.dirname(image_path)

    left_path = os.path.join(output_dir, f"left_{name}{ext}")
    right_path = os.path.join(output_dir, f"right_{name}{ext}")

    cv2.imwrite(left_path, left_part)
    cv2.imwrite(right_path, right_part)

    print(f"左半部分保存到：{left_path}")
    print(f"右半部分保存到：{right_path}")


if __name__ == "__main__":
    # 解析命令行参数
    parser = argparse.ArgumentParser(description="将图片从中间一分为二")
    parser.add_argument("image_path", help="输入图像的路径")
    parser.add_argument(
        "output_dir", nargs="?", default="", help="输出目录（可选，默认为输入目录）"
    )

    args = parser.parse_args()

    split_image(args.image_path, args.output_dir)
