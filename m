Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ACE1D52B
	for <bpf@vger.kernel.org>; Fri,  8 Mar 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903238; cv=none; b=ndi8PWvjtq4s2FNeCkFHOxOxoAVNz6fbVIestuz4KGr9nGhMM5XqgTPAAqk0QmOtWNOUA3ixRNqQgiN76ZTtc7gWszJdZEgpeNzRN7j4gYQu6NgWmAEHaKfQY6xDS9Ewmmk6tRBL8cw7vPdOisGpgb32sweQTWdrH9XdWmZDEhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903238; c=relaxed/simple;
	bh=ul/92kVbq3hoXw6DV/+iIjp9XFF9KXLUaejhczl8Auc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InxcuM8eaA76nH6YVJcZHpHJXEedIrzwSQPd0oFAnG1XauBtK6GeFZuJMONj088SfNRa9EBlU3uHxJSVrJbGfhCECfTihRUxb5clmp3ujwV0aDev3ingT8jRREXzNkM/xmn6rzNnRUoTj84y2PDvq5vKV/hVV2tB1hPI3Bk6PDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrlXcuLo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrlXcuLo"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e55731af5cso599336b3a.0
        for <bpf@vger.kernel.org>; Fri, 08 Mar 2024 05:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709903236; x=1710508036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6JBIiA7snPXQC91EmSjQtdStb4kybeMyqJyIjHTQc5Q=;
        b=BrlXcuLoIgYnSPlCJeKrxV+kG0L/Wepve0wfP3f9O8COLzf07mC1luhg3A+DMnjQfB
         FytZQzOsQRo04Yb8BIwOhY2vTW/ANolJsykJ0VI1T0cp5rTJmVlas9f3vqo7rV8XXEEL
         NsUaX61SQut++ov5RUaeyKz5gQAYOxeZpShB+E/7o8h5ZZ5c+In0W5GMsA5L/QAwY3wv
         HrMec1DkA39tYEMwhIF5ji/krODRdtdw9/8LcDxR1nUsnYLFOT7czrePDTzYcf/OpqMI
         expL1Wgg097qLT6E1kEqXIJaMRvgaWyPJR0p4sNGJ5fe5lpWE4kVrY8yJAxipe9FVXYK
         9saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709903236; x=1710508036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6JBIiA7snPXQC91EmSjQtdStb4kybeMyqJyIjHTQc5Q=;
        b=hf31Ru/hdmaSvwKk4BbJ3Sj8q7cBD6Gfa/wLpqGWbBdIjIzVgAWLtJQGngAxh1hZhh
         +x6HebbTXEmX41fCA8rnp2rViBmUgO79Mh7WCRUw06CX78kIitxj7WJunbbY0dISbGU4
         7i+YnT+0LYoRW306OCR5bco+AyGniWDmgimnUOZHfcaVH7n9VnJlj7LHgTVxDqUaOPBt
         2NFFBWtcDFXEwIWnyee/IWA5hEJ5apg2WWqs7x5yV0UWv1fvtnKe6T5Kcan3FNPzDvHn
         IVIegWe3CFw9SSxZDQ9QPUAwXRh5YEFJfalfMjHOKGV7osQUIQjvycW9J3qy3t+1MFNH
         A1zg==
X-Forwarded-Encrypted: i=1; AJvYcCUQpwEKwokkkfomtDBiFaR7JIuiJXl8tl3Et0GZPyY3Nro/UzjkD+2m9k9eoJijHtksScfGxZ+ANTMgWhJATdh4ixF7
X-Gm-Message-State: AOJu0YxTTnNFLCBad9eYyVM8Vgcl4rr4NBZI4zK767fsoll2X9WlYdLR
	Tk+SfgSEVzerFVsoEOb1c2jdruqrm57jH32i9boircsTI/shoHHy
X-Google-Smtp-Source: AGHT+IHa7gqsRi91JtMKNVnW/oIPSlnybcyQgmSx9QEPuEePHwy1MCiUbT6PlSLMrBJZTIin9JNQWw==
X-Received: by 2002:a05:6a21:32a9:b0:1a1:72aa:11b0 with SMTP id yt41-20020a056a2132a900b001a172aa11b0mr5689883pzb.32.1709903236120;
        Fri, 08 Mar 2024 05:07:16 -0800 (PST)
Received: from valdaarhun.. ([2409:4081:2c0a:51c8:7b2d:2fd4:2d14:6e3b])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090abc8f00b0029bc0a9e366sm132480pjr.30.2024.03.08.05.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 05:07:15 -0800 (PST)
From: Sahil Siddiq <icegambit91@gmail.com>
To: quentin@isovalent.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	Sahil Siddiq <icegambit91@gmail.com>
Subject: [PATCH bpf-next v2] bpftool: Mount bpffs on provided dir instead of parent dir
Date: Fri,  8 Mar 2024 18:36:19 +0530
Message-ID: <20240308130619.28123-1-icegambit91@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pinning programs/objects under PATH (eg: during "bpftool prog
loadall") the bpffs is mounted on the parent dir of PATH in the
following situations:
- the given dir exists but it is not bpffs.
- the given dir doesn't exist and the parent dir is not bpffs.

Mounting on the parent dir can also have the unintentional side-
effect of hiding other files located under the parent dir.

If the given dir exists but is not bpffs, then the bpffs should
be mounted on the given dir and not its parent dir.

Similarly, if the given dir doesn't exist and its parent dir is not
bpffs, then the given dir should be created and the bpffs should be
mounted on this new dir.

Link: https://lore.kernel.org/bpf/2da44d24-74ae-a564-1764-afccf395eeec@isovalent.com/T/#t

Closes: https://github.com/libbpf/bpftool/issues/100

Fixes: 2a36c26fe3b8 ("bpftool: Support bpffs mountpoint as pin path for prog loadall")

Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>
---
Changes since v1:
 - Split "mount_bpffs_for_pin" into two functions:
   - mount_bpffs_on_dir
   - mount_bpffs_given_file
   This is done to improve maintainability and readability.
 - Improve error messages
 - (mount_bpffs_given_file): If the file already exists, throw an
   error instead of waiting for bpf_obj_pin() to throw an error
 - Code style changes

 tools/bpf/bpftool/common.c     | 78 +++++++++++++++++++++++++++++-----
 tools/bpf/bpftool/iter.c       |  2 +-
 tools/bpf/bpftool/main.h       |  3 +-
 tools/bpf/bpftool/prog.c       |  5 ++-
 tools/bpf/bpftool/struct_ops.c |  2 +-
 5 files changed, 75 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447..d2746681200e 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -244,24 +244,80 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
 	return fd;
 }
 
-int mount_bpffs_for_pin(const char *name, bool is_dir)
+int mount_bpffs_on_dir(const char *dir_name)
 {
 	char err_str[ERR_MAX_LEN];
-	char *file;
-	char *dir;
 	int err = 0;
 
-	if (is_dir && is_bpffs(name))
+	if (is_bpffs(dir_name))
 		return err;
 
-	file = malloc(strlen(name) + 1);
-	if (!file) {
+	if (access(dir_name, F_OK) == -1) {
+		char *temp_name;
+		char *parent_name;
+
+		temp_name = malloc(strlen(dir_name) + 1);
+		if (!temp_name) {
+			p_err("mem alloc failed");
+			return -1;
+		}
+
+		strcpy(temp_name, dir_name);
+		parent_name = dirname(temp_name);
+
+		if (is_bpffs(parent_name)) {
+			/* nothing to do if already mounted */
+			free(temp_name);
+			return err;
+		}
+
+		free(temp_name);
+
+		if (block_mount) {
+			p_err("no BPF file system found, not mounting it due to --nomount option");
+			return -1;
+		}
+
+		err = mkdir(dir_name, 0700);
+		if (err) {
+			p_err("failed to create dir (%s): %s", dir_name, strerror(errno));
+			return err;
+		}
+	} else if (block_mount) {
+		p_err("no BPF file system found, not mounting it due to --nomount option");
+		return -1;
+	}
+
+	err = mnt_fs(dir_name, "bpf", err_str, ERR_MAX_LEN);
+	if (err) {
+		err_str[ERR_MAX_LEN - 1] = '\0';
+		p_err("can't mount BPF file system on given dir (%s): %s",
+		      dir_name, err_str);
+	}
+
+	return err;
+}
+
+int mount_bpffs_given_file(const char *file_name)
+{
+	char err_str[ERR_MAX_LEN];
+	char *temp_name;
+	char *dir;
+	int err = 0;
+
+	if (access(file_name, F_OK) != -1) {
+		p_err("bpf object can't be pinned since file (%s) already exists", file_name);
+		return -1;
+	}
+
+	temp_name = malloc(strlen(file_name) + 1);
+	if (!temp_name) {
 		p_err("mem alloc failed");
 		return -1;
 	}
 
-	strcpy(file, name);
-	dir = dirname(file);
+	strcpy(temp_name, file_name);
+	dir = dirname(temp_name);
 
 	if (is_bpffs(dir))
 		/* nothing to do if already mounted */
@@ -277,11 +333,11 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
 	if (err) {
 		err_str[ERR_MAX_LEN - 1] = '\0';
 		p_err("can't mount BPF file system to pin the object (%s): %s",
-		      name, err_str);
+		      file_name, err_str);
 	}
 
 out_free:
-	free(file);
+	free(temp_name);
 	return err;
 }
 
@@ -289,7 +345,7 @@ int do_pin_fd(int fd, const char *name)
 {
 	int err;
 
-	err = mount_bpffs_for_pin(name, false);
+	err = mount_bpffs_given_file(name);
 	if (err)
 		return err;
 
diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index 6b0e5202ca7a..3911563dcc60 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -76,7 +76,7 @@ static int do_pin(int argc, char **argv)
 		goto close_obj;
 	}
 
-	err = mount_bpffs_for_pin(path, false);
+	err = mount_bpffs_given_file(path);
 	if (err)
 		goto close_link;
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index b8bb08d10dec..20e06ad183ec 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -142,7 +142,8 @@ const char *get_fd_type_name(enum bpf_obj_type type);
 char *get_fdinfo(int fd, const char *key);
 int open_obj_pinned(const char *path, bool quiet);
 int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
-int mount_bpffs_for_pin(const char *name, bool is_dir);
+int mount_bpffs_given_file(const char *file_name);
+int mount_bpffs_on_dir(const char *dir_name);
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
 int do_pin_fd(int fd, const char *name);
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9cb42a3366c0..09b5f0415a5e 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1778,7 +1778,10 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		goto err_close_obj;
 	}
 
-	err = mount_bpffs_for_pin(pinfile, !first_prog_only);
+	if (first_prog_only)
+		err = mount_bpffs_given_file(pinfile);
+	else
+		err = mount_bpffs_on_dir(pinfile);
 	if (err)
 		goto err_close_obj;
 
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index d573f2640d8e..bf50a99b2501 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -515,7 +515,7 @@ static int do_register(int argc, char **argv)
 	if (argc == 1)
 		linkdir = GET_ARG();
 
-	if (linkdir && mount_bpffs_for_pin(linkdir, true)) {
+	if (linkdir && mount_bpffs_on_dir(linkdir)) {
 		p_err("can't mount bpffs for pinning");
 		return -1;
 	}
-- 
2.44.0

