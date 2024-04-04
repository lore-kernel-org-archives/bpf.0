Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E476F133426
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258556; cv=none; b=Xpm+F4plw8VzN/hVgHqjc8lnoQdblbPSvd6Cllab0sd31rpkOkZ5muwzwPubKCgBSKBEDjqaluG3m+OAfDkQpJg2VGYZuabgGcNgxBJUWcvFTX2L766ytVAA6prOje4ouKbPTKl9tpxhU7xHrtOS+TUNAnNC80DkG+EOYd2GA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258556; c=relaxed/simple;
	bh=ZkIQPsz6PGxLjM1b2ssyddl6G+RJibszQR1V25OlZD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SaJ2+yyGr/5IY/8wsOVZ0V457yYSii1EgSGUIIbMFx8UhVeZayhKUWuftC24vdJgHo+jloVsuP9XzCbSR18w3QBtJuf/L/C3p02gsCzRzEvmKHnlumVaHOMlBMD7AHn9r4kcEQCaepH07qLp/A//K+/lN1WJXCokDCfn5srzs+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEGoOUDW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEGoOUDW"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1936726a12.0
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 12:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712258554; x=1712863354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dZBLjG3sLYaCNu66so30vyYYjIFhpip65JSkNnOU1E=;
        b=mEGoOUDWFO+IJw2FjyY6YZwUvmYxmVHKUpRDA0lBWkIj5AGN3dtYEFfhgpw4ixk7rg
         V9TUm793owEJgnl1di6KkOrF705IBvAYbuanFEadBCCjukju1HlEIuEa1lW47xAgIfN1
         zy7pdJl5CZ+FUoqAHGghYt9cazf1rReJMIoXekYZMHnn3bFSh7SLM/Oxgz1mBtoU1kYR
         23P6+JQ24850iyQH+HBYwugyvSgsQOPskHHibdaFpOm4YNnLJXSUDDQK0UJXbEmm39Ut
         Wge6LPxLJ7xklTQfzEGXdVFUKqJBkWfFUmfXNn3QWH/woBHonXYUSGVq3y7XIEUl6YVw
         YyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258554; x=1712863354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dZBLjG3sLYaCNu66so30vyYYjIFhpip65JSkNnOU1E=;
        b=sNry97bA07NO51ntdZL39qRJXSuJnQAMrF9cN1/EdzBDXtwQzPtJAqhOD1FXZts2Po
         NVZf8tVVqifzp1c2xeVQRSol+1DeS2DUVkbgOtpt7N/DIxAfR0Wm0GLOhfG7bFtrscne
         WiuH3BSniYZflIbRIEs07TO/la/2YE5uPQ36BPt3hBoPu6QV5cjTlNSTnHgKwpepirsR
         hRI2G89LhjqDF73sZ2DXh2a1ZYh7R+TbdIwiUKj/wiVgkMb1fUbK0v0esGOqKPEc042Z
         OFiqU20zT2AIHwRxENvqe2cuPesJNDEVlzj8SerE1ZhRRkhV9YQYPb6/s/4SHRWkvWbl
         LYXA==
X-Forwarded-Encrypted: i=1; AJvYcCUHZTskuvgkEkAOu7RehbyxC+v0dpvyhsUAVEFSogcvRkibMH0e6j9msM1fN34xADnfD4+4RpdMTsyptFZO++TqsUCy
X-Gm-Message-State: AOJu0Yz0ADwIj9HH9Gqsk1rUdhmESyQxNafZScL2dy7TNYKsQqbG5fyM
	ca8ORzBHPQFRq1YVX0JEYDjy91tHxWZfAR4AAoAYe6F9CZDiQSsi
X-Google-Smtp-Source: AGHT+IEp581PRzLwoLZXmicEbzKlmyPTJ0ipZseM+2QHoJVo1PKcwI74/x1lZhwgZ6/1Atiwbdk+Tg==
X-Received: by 2002:a17:90a:3885:b0:2a2:da08:67db with SMTP id x5-20020a17090a388500b002a2da0867dbmr597746pjb.6.1712258554100;
        Thu, 04 Apr 2024 12:22:34 -0700 (PDT)
Received: from valdaarhun.. ([223.233.80.57])
        by smtp.gmail.com with ESMTPSA id d12-20020a17090a498c00b002a04eef22c5sm53265pjh.44.2024.04.04.12.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 12:22:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v5] bpftool: Mount bpffs on provided dir instead of parent dir
Date: Fri,  5 Apr 2024 00:52:19 +0530
Message-ID: <20240404192219.52373-1-icegambit91@gmail.com>
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

Changes since v1:
 - Split "mount_bpffs_for_pin" into two functions.
   This is done to improve maintainability and readability.

Changes since v2:
- mount_bpffs_for_pin: rename to "create_and_mount_bpffs_dir".
- mount_bpffs_given_file: rename to "mount_bpffs_given_file".
- create_and_mount_bpffs_dir:
  - introduce "dir_exists" boolean.
  - remove new dir if "mnt_fs" fails.
- improve error handling and error messages.

Changes since v3:
- Rectify function name.
- Improve error messages and formatting.
- mount_bpffs_for_file:
  - Check if dir exists before block_mount check.

Changes since v4:
- Use strdup instead of strcpy.
- create_and_mount_bpffs_dir:
  - Use S_IRWXU instead of 0700.
- Improve error handling and formatting.

Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>
---
I should mention that running checkpatch.pl --strict gave
a warning suggesting that 0700 be used in place of S_IRWXU.

 tools/bpf/bpftool/common.c     | 96 +++++++++++++++++++++++++++++-----
 tools/bpf/bpftool/iter.c       |  2 +-
 tools/bpf/bpftool/main.h       |  3 +-
 tools/bpf/bpftool/prog.c       |  5 +-
 tools/bpf/bpftool/struct_ops.c |  2 +-
 5 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447..958e92acca8e 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -244,29 +244,101 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
 	return fd;
 }
 
-int mount_bpffs_for_pin(const char *name, bool is_dir)
+int create_and_mount_bpffs_dir(const char *dir_name)
 {
 	char err_str[ERR_MAX_LEN];
-	char *file;
-	char *dir;
+	bool dir_exists;
 	int err = 0;
 
-	if (is_dir && is_bpffs(name))
+	if (is_bpffs(dir_name))
 		return err;
 
-	file = malloc(strlen(name) + 1);
-	if (!file) {
+	dir_exists = access(dir_name, F_OK) == 0;
+
+	if (!dir_exists) {
+		char *temp_name;
+		char *parent_name;
+
+		temp_name = strdup(dir_name);
+		if (!temp_name) {
+			p_err("mem alloc failed");
+			return -1;
+		}
+
+		parent_name = dirname(temp_name);
+
+		if (is_bpffs(parent_name)) {
+			/* nothing to do if already mounted */
+			free(temp_name);
+			return err;
+		}
+
+		if (access(parent_name, F_OK) == -1) {
+			p_err("can't create dir '%s' to pin BPF object: parent dir '%s' doesn't exist",
+			      dir_name, parent_name);
+			free(temp_name);
+			return -1;
+		}
+
+		free(temp_name);
+	}
+
+	if (block_mount) {
+		p_err("no BPF file system found, not mounting it due to --nomount option");
+		return -1;
+	}
+
+	if (!dir_exists) {
+		err = mkdir(dir_name, S_IRWXU);
+		if (err) {
+			p_err("failed to create dir '%s': %s", dir_name, strerror(errno));
+			return err;
+		}
+	}
+
+	err = mnt_fs(dir_name, "bpf", err_str, ERR_MAX_LEN);
+	if (err) {
+		err_str[ERR_MAX_LEN - 1] = '\0';
+		p_err("can't mount BPF file system on given dir '%s': %s",
+		      dir_name, err_str);
+
+		if (!dir_exists)
+			rmdir(dir_name);
+	}
+
+	return err;
+}
+
+int mount_bpffs_for_file(const char *file_name)
+{
+	char err_str[ERR_MAX_LEN];
+	char *temp_name;
+	char *dir;
+	int err = 0;
+
+	if (access(file_name, F_OK) != -1) {
+		p_err("can't pin BPF object: path '%s' already exists", file_name);
+		return -1;
+	}
+
+	temp_name = strdup(file_name);
+	if (!temp_name) {
 		p_err("mem alloc failed");
 		return -1;
 	}
 
-	strcpy(file, name);
-	dir = dirname(file);
+	dir = dirname(temp_name);
 
 	if (is_bpffs(dir))
 		/* nothing to do if already mounted */
 		goto out_free;
 
+	if (access(dir, F_OK) == -1) {
+		p_err("can't pin BPF object: dir '%s' doesn't exist", dir);
+		err = -1;
+		goto out_free;
+	}
+
 	if (block_mount) {
 		p_err("no BPF file system found, not mounting it due to --nomount option");
 		err = -1;
@@ -276,12 +348,12 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
 	err = mnt_fs(dir, "bpf", err_str, ERR_MAX_LEN);
 	if (err) {
 		err_str[ERR_MAX_LEN - 1] = '\0';
-		p_err("can't mount BPF file system to pin the object (%s): %s",
-		      name, err_str);
+		p_err("can't mount BPF file system to pin the object '%s': %s",
+		      file_name, err_str);
 	}
 
 out_free:
-	free(file);
+	free(temp_name);
 	return err;
 }
 
@@ -289,7 +361,7 @@ int do_pin_fd(int fd, const char *name)
 {
 	int err;
 
-	err = mount_bpffs_for_pin(name, false);
+	err = mount_bpffs_for_file(name);
 	if (err)
 		return err;
 
diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
index 6b0e5202ca7a..5c39c2ed36a2 100644
--- a/tools/bpf/bpftool/iter.c
+++ b/tools/bpf/bpftool/iter.c
@@ -76,7 +76,7 @@ static int do_pin(int argc, char **argv)
 		goto close_obj;
 	}
 
-	err = mount_bpffs_for_pin(path, false);
+	err = mount_bpffs_for_file(path);
 	if (err)
 		goto close_link;
 
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index b8bb08d10dec..9eb764fe4cc8 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -142,7 +142,8 @@ const char *get_fd_type_name(enum bpf_obj_type type);
 char *get_fdinfo(int fd, const char *key);
 int open_obj_pinned(const char *path, bool quiet);
 int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
-int mount_bpffs_for_pin(const char *name, bool is_dir);
+int mount_bpffs_for_file(const char *file_name);
+int create_and_mount_bpffs_dir(const char *dir_name);
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
 int do_pin_fd(int fd, const char *name);
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9cb42a3366c0..4c4cf16a40ba 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1778,7 +1778,10 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		goto err_close_obj;
 	}
 
-	err = mount_bpffs_for_pin(pinfile, !first_prog_only);
+	if (first_prog_only)
+		err = mount_bpffs_for_file(pinfile);
+	else
+		err = create_and_mount_bpffs_dir(pinfile);
 	if (err)
 		goto err_close_obj;
 
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index d573f2640d8e..aa43dead249c 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -515,7 +515,7 @@ static int do_register(int argc, char **argv)
 	if (argc == 1)
 		linkdir = GET_ARG();
 
-	if (linkdir && mount_bpffs_for_pin(linkdir, true)) {
+	if (linkdir && create_and_mount_bpffs_dir(linkdir)) {
 		p_err("can't mount bpffs for pinning");
 		return -1;
 	}
-- 
2.44.0

