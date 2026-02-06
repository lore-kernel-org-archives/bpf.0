Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B3B43E491
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405194; cv=none; b=AvnykNtGBwIGwHe38bKoV4GCrBK+jpvaKpbcIsc3psgFUOWuz/uuEp376Jaa0EhDPwNVPlSQWTi+JXJ5bSRDRwg+D3i03VOo6/0LxowGCkVM8+SFCifbnH1KjN98jKgO5SlqABq+Rpu7I+PQDTeharU3rJMVRJ8fmx3mnetty4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405194; c=relaxed/simple;
	bh=K/DVzBOCmPx/5xulxQPQA2jh8fJo6vYnCVmEwIInAPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOycXW+3XTpBFRZkqCqF6LUkJTn1Sdcenpxbvevy+JXKxEmC1JSbM/Q6qKT5SjcheovCeQ8Ht8Ro8bL9TaGA/XhttK22tD5PnznqQhxEVwveO2a2YO/cRNnGDCgAckPX74dA+/tc5lqn+BxwRhin8xENftUxzmVZjDkeFB7pXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=GoJSOBy5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="GoJSOBy5"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7927b1620ddso38062947b3.0
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 11:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1770405193; x=1771009993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp7dE9rfuLorTfLe8+rhBEONpAq5JPSPoipR3P8yp2s=;
        b=GoJSOBy5vbp0HCrKs9pVp1eQlwvUg7H3Me6IfbkTJqTi6s/0Scgya6AiM5ls2dOqvU
         YrF8cAmBYUjLxkGR5uGOkU8ptIX42ZPDpkLFDvuXZEmfbcakzhc60CHARBFLqNiFy2r4
         bPD+U2zxaacb6A5X3eoL8R9gj3zRSj5dWM2wthcPVvFrBGrvOEEq4QiJ6v0XuIoet4P6
         mVPzTLV9waiCKS3dlD0/kF6NZxwbMS18uC4tmKOimgew/lOdZDTyNAg4wjZ1OYBUEu4G
         p9fbruLPt9aXlkor7SYjgr5db1ODXZxeSVBOeyE6D1mcMYgEM4FLRlwzioUJ3HbhsShG
         UH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405193; x=1771009993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hp7dE9rfuLorTfLe8+rhBEONpAq5JPSPoipR3P8yp2s=;
        b=vQz1iCYgxcUZJM19fJJi81bapV0f1L/kcmqEyLtIk2kxAfVEb2KhSZwQ+/lP+i/IYb
         mVe1UHKsNECMvtbR0czlzbDWF/faTAI57WPFC/RIHZMuK9z51SX0I6KSfKBnmRwfXS6K
         6UNv1w3IcBFufDM2DQbxXphQEiFV+Snjc3IG4qEiZK+XciUinVsZmrKvlCnyK9BgjYCR
         +/aL4VcQd15Neiwb6Oqsh1vEFIZIDtRnM4DQCCaxfUU2k4bXnTXsQQBg9VqRp5yCSrN+
         HDIt/BlGnxnE1JNZw2dWM7KfzFfmxUvP/qBYWg2F4Q8W9raloqEKyNFMnAcJT3sqlP6X
         w/3A==
X-Forwarded-Encrypted: i=1; AJvYcCVpUQJHcZxwrM4WpQxwcpRliM5M3DGnHnG14HyyhXnjGzgb2CQxddSMHXdB2/K1awvd34k=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmBQfMl18eqSkzos5HN3xgTNkEAymPbSAwDBTNMJu8LHsvkwP
	YMsih/kOOG8UZtBkmJyxgI0wRrBQbruNkYeE3La3Hb8nF6hqnFJy3nS9PdOOsOnNczA=
X-Gm-Gg: AZuq6aKAypX0r/94IAy3wNhE/stORZ3JABwhbXvJn+sVYMpTX9GQOaOxoAD5qlsM5cU
	40TUbSLN2Z71hMkDIn0bl2ojDi0b4LZT2VYYGzIvTurYY+SuPKep/X+C92xFRbLOw3B3RHlzBAK
	76AMYAXVnxZtSMj9i0uTmmexN6psKU5tNLZ7zQDAvqaSdA3d74Mv03F+QHqp7YgXLYRBgUC0oQn
	WuqRuy1ofAnlBGEGai57rWw2oSOfOGRrMT7+yXlpKZHpq60mPwX2MsAxx5TPAvktFA45efgytr7
	sKmjpz18VO7v7AUg4K8A5xo33ggw+OwFCJF82UDHatSvHgiB60TILTk9bHrFDL+nb3dbH2l7FmO
	7KsI1XY/oDdJkbPZ9uIS6ZVpBzKc8c0gXwXqbTYCmIJakUf3D1FDqi0Id4/bTI4XvDpXRYJUoFr
	YDh2M50dYMHlK/aN6MYr2XWRrhZhv4l9c/iK69JwXmNrLwIIJr9YyobqngCMC7xzxEHNTHmvxUQ
	qPzVdRRnXVB
X-Received: by 2002:a05:690c:d8b:b0:788:181b:86c1 with SMTP id 00721157ae682-7952a63e4bcmr38138647b3.5.1770405193303;
        Fri, 06 Feb 2026 11:13:13 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9fc0:ed7d:72bd:ecd1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a28697fsm29051277b3.50.2026.02.06.11.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 11:13:12 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/4] ml-lib: Implement simple user-space testing application
Date: Fri,  6 Feb 2026 11:11:36 -0800
Message-Id: <20260206191136.2609767-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260206191136.2609767-1-slava@dubeyko.com>
References: <20260206191136.2609767-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement simple user-space testing application

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 .../test_application/ml_lib_char_dev_ioctl.h  |  21 ++
 .../test_application/test_ml_lib_char_dev.c   | 206 ++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 lib/ml-lib/test_driver/test_application/ml_lib_char_dev_ioctl.h
 create mode 100644 lib/ml-lib/test_driver/test_application/test_ml_lib_char_dev.c

diff --git a/lib/ml-lib/test_driver/test_application/ml_lib_char_dev_ioctl.h b/lib/ml-lib/test_driver/test_application/ml_lib_char_dev_ioctl.h
new file mode 100644
index 000000000000..7ea74e840fda
--- /dev/null
+++ b/lib/ml-lib/test_driver/test_application/ml_lib_char_dev_ioctl.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Machine Learning (ML) library
+ *
+ * Userspace API for ml_lib_dev testing driver
+ *
+ * Copyright (C) 2025-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _ML_LIB_TEST_DEV_IOCTL_H
+#define _ML_LIB_TEST_DEV_IOCTL_H
+
+#include <linux/ioctl.h>
+
+/* IOCTL commands */
+#define ML_LIB_TEST_DEV_IOC_MAGIC   'M'
+#define ML_LIB_TEST_DEV_IOCRESET    _IO(ML_LIB_TEST_DEV_IOC_MAGIC, 0)
+#define ML_LIB_TEST_DEV_IOCGETSIZE  _IOR(ML_LIB_TEST_DEV_IOC_MAGIC, 1, int)
+#define ML_LIB_TEST_DEV_IOCSETSIZE  _IOW(ML_LIB_TEST_DEV_IOC_MAGIC, 2, int)
+
+#endif /* _ML_LIB_TEST_DEV_IOCTL_H */
diff --git a/lib/ml-lib/test_driver/test_application/test_ml_lib_char_dev.c b/lib/ml-lib/test_driver/test_application/test_ml_lib_char_dev.c
new file mode 100644
index 000000000000..432b8a0ad068
--- /dev/null
+++ b/lib/ml-lib/test_driver/test_application/test_ml_lib_char_dev.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Machine Learning (ML) library
+ *
+ * Test program for ml_lib_dev testing driver
+ *
+ * Copyright (C) 2025-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Compile with: gcc -o test_ml_lib_char_dev test_ml_lib_char_dev.c
+ * Run with:     sudo ./test_ml_lib_char_dev
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+
+#include "ml_lib_char_dev_ioctl.h"
+
+#define DEVICE_PATH "/dev/mllibdev"
+#define SYSFS_BASE "/sys/class/ml_lib_test/mllibdev"
+#define PROC_PATH "/proc/mllibdev"
+
+static void print_separator(const char *title)
+{
+	printf("\n========== %s ==========\n", title);
+}
+
+static void read_sysfs_attr(const char *attr_name)
+{
+	char path[256];
+	char buffer[256];
+	FILE *fp;
+
+	snprintf(path, sizeof(path), "%s/%s", SYSFS_BASE, attr_name);
+	fp = fopen(path, "r");
+	if (!fp) {
+		perror("Failed to open sysfs attribute");
+		return;
+	}
+
+	if (fgets(buffer, sizeof(buffer), fp)) {
+		printf("  %s: %s", attr_name, buffer);
+	}
+
+	fclose(fp);
+}
+
+static void show_sysfs_info(void)
+{
+	print_separator("Sysfs Attributes");
+	read_sysfs_attr("buffer_size");
+	read_sysfs_attr("data_size");
+	read_sysfs_attr("access_count");
+	printf("\n");
+	read_sysfs_attr("stats");
+}
+
+static void show_proc_info(void)
+{
+	char buffer[1024];
+	FILE *fp;
+
+	print_separator("Procfs Information");
+
+	fp = fopen(PROC_PATH, "r");
+	if (!fp) {
+		perror("Failed to open procfs entry");
+		return;
+	}
+
+	while (fgets(buffer, sizeof(buffer), fp)) {
+		printf("%s", buffer);
+	}
+
+	fclose(fp);
+}
+
+static void test_write(int fd)
+{
+	const char *test_data = "Hello from userspace! This is a test of the mllibdev driver.";
+	ssize_t ret;
+
+	print_separator("Write Test");
+
+	ret = write(fd, test_data, strlen(test_data));
+	if (ret < 0) {
+		perror("Write failed");
+		return;
+	}
+
+	printf("Successfully wrote %zd bytes\n", ret);
+	printf("Data: \"%s\"\n", test_data);
+}
+
+static void test_read(int fd)
+{
+	char buffer[256];
+	ssize_t ret;
+
+	print_separator("Read Test");
+
+	/* Seek to beginning */
+	lseek(fd, 0, SEEK_SET);
+
+	ret = read(fd, buffer, sizeof(buffer) - 1);
+	if (ret < 0) {
+		perror("Read failed");
+		return;
+	}
+
+	buffer[ret] = '\0';
+	printf("Successfully read %zd bytes\n", ret);
+	printf("Data: \"%s\"\n", buffer);
+}
+
+static void test_ioctl(int fd)
+{
+	int size;
+	int ret;
+
+	print_separator("IOCTL Tests");
+
+	/* Get current size */
+	ret = ioctl(fd, ML_LIB_TEST_DEV_IOCGETSIZE, &size);
+	if (ret < 0) {
+		perror("IOCTL GETSIZE failed");
+		return;
+	}
+	printf("Current data size: %d bytes\n", size);
+
+	/* Set new size */
+	size = 50;
+	ret = ioctl(fd, ML_LIB_TEST_DEV_IOCSETSIZE, &size);
+	if (ret < 0) {
+		perror("IOCTL SETSIZE failed");
+		return;
+	}
+	printf("Set data size to: %d bytes\n", size);
+
+	/* Verify new size */
+	ret = ioctl(fd, ML_LIB_TEST_DEV_IOCGETSIZE, &size);
+	if (ret < 0) {
+		perror("IOCTL GETSIZE failed");
+		return;
+	}
+	printf("Verified new size: %d bytes\n", size);
+
+	/* Reset buffer */
+	ret = ioctl(fd, ML_LIB_TEST_DEV_IOCRESET);
+	if (ret < 0) {
+		perror("IOCTL RESET failed");
+		return;
+	}
+	printf("Buffer reset successfully\n");
+
+	/* Verify size after reset */
+	ret = ioctl(fd, ML_LIB_TEST_DEV_IOCGETSIZE, &size);
+	if (ret < 0) {
+		perror("IOCTL GETSIZE failed");
+		return;
+	}
+	printf("Size after reset: %d bytes\n", size);
+}
+
+int main(void)
+{
+	int fd;
+
+	printf("ML Library Testing Device Driver Test Program\n");
+	printf("==================================\n");
+
+	/* Open the device */
+	fd = open(DEVICE_PATH, O_RDWR);
+	if (fd < 0) {
+		perror("Failed to open device");
+		printf("\nMake sure:\n");
+		printf("1. The driver module is loaded (lsmod | grep mllibdev)\n");
+		printf("2. You have proper permissions (run with sudo)\n");
+		printf("3. The device node exists (ls -l /dev/mllibdev)\n");
+		return 1;
+	}
+
+	printf("Device opened successfully: %s\n", DEVICE_PATH);
+
+	/* Run tests */
+	test_write(fd);
+	test_read(fd);
+	test_ioctl(fd);
+
+	/* Show sysfs and proc information */
+	show_sysfs_info();
+	show_proc_info();
+
+	/* Final stats */
+	print_separator("Final Test");
+	printf("All tests completed successfully!\n\n");
+
+	/* Close the device */
+	close(fd);
+
+	return 0;
+}
-- 
2.34.1

