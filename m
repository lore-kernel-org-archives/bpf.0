Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44053373
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998284; cv=none; b=fPzGNecxTlZjRr2473egAVXp27jAR6YVTzMIkpDSPmlUQVun/a4Mjvoi81yO0HuZgx0ioD5KunfAHIgXpshAprbQgKH/MryrOBmaX1mT8obb6y4+BfkNAqJ+guL6QJZz6e80ejBFElmN7djr68Wj4U63CfTHMInXZ+PI6sEkZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998284; c=relaxed/simple;
	bh=zEt0/csqDWzojtx3Xj0Wm4Oi4CXf6tzYo7t1cDBJxp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kcl891QsEzGwdaxe3pVlnhbtx4V0AJ0rGqsJdfj2cVOQJA15oKSjEBz7FQr5MuWmf+5rRr6mElbA1D2t1lod9FT+aMeQPbRQf+dDAQGd8MZEOdI7nL+jcqOQmruyC4f2QdXkSZQ3mDbL4hrwQyC7G2AtR/uEd0+1WlIIyehqNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjDR4QV5; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjDR4QV5"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22a96054726so3501769fac.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 12:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711998282; x=1712603082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjpaLqkMmv9KUajiRq/s4UJrB/suqoG/c8BTeGSPbe0=;
        b=LjDR4QV5KoWk9c1WQHA3EdT17DLr4fZ8Hl5k3t4rVklS0+T2UxKDgxVmWABIhFlYOZ
         JFyNu4tn/T51OaSxezWeBEKHplrVyTGYv1KH7C24mnDUqqV40C5GzNiGaQsBL8kbV7ot
         vS58sCFUvhBAhMi5dLn/terWMPrhwOxOhozyqV4ajptzsQOf3NsoPQ4XEHqOOzX+LsXj
         kjtnYY/9cfhdIcqsjinsHPwPSIYv2YABD5FJR1Vo9Jyog+FT1Z85h53kVwUupbpwuprp
         u7nD5wjf/VCXXcGKN6MxqSw41+/WfX+bfbVCvNYfICdd1uPxqE72VHT6p+fFiOzM7s6q
         +uMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711998282; x=1712603082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjpaLqkMmv9KUajiRq/s4UJrB/suqoG/c8BTeGSPbe0=;
        b=UgtypyX4FUPUmKmHh7SiHqpSH8r7YW3WiAjjUmK/2ZzyuBRdkH8AtWH5JpN/tVIjDH
         BkfLs204yr4CGJWV070EcJVK9rkXOCxEywjpJgqZi9jrMGqkJ3ACjicyvi959JppPxTZ
         4vMe/ZNNiq0Tf/i9MLYDVHisbVi0IG1wlCXrkFt/nqisTM65TBcuaBKfxt4sNXj5War5
         1PKPUo6A9ItxMGiacCpmUjRJpmiJv4Mu/WdaYr62IhE/DOI0TMLWae2bzjZnx5liqe9Y
         Aj5CnBS3R70QjO680SPFTo5uehhXffCwE/thJm6V5QTOaAQA0Eur+mW6x6aPZ/IeXfMR
         9QvA==
X-Forwarded-Encrypted: i=1; AJvYcCVbx5O+N0BhxYUsQnfL4l3OckN/aPZxgdLxc4MLBLwABDAsU9i8tF7RG+y4HsoAe1ZSa8TnRP8mwujdnvJRs0T5g8wg
X-Gm-Message-State: AOJu0Ywp8lzKIozs8ZXGEtyO8vO0szcYuprdl6KeohjaZ89ANfKhG9NZ
	2pl4GzbyyO4JIMPZOavfi+dME4sLML6HJkjktbz5BLnfvMNyj2c6
X-Google-Smtp-Source: AGHT+IEbTJXMWvnZoX5BqHok9N4ZrIXFIu9wrX4DDK6D/4/ZvA2sVjnJC8bYj3phKihWiGLny11B6w==
X-Received: by 2002:a05:6358:3218:b0:183:55a6:b240 with SMTP id a24-20020a056358321800b0018355a6b240mr14022142rwe.4.1711998281998;
        Mon, 01 Apr 2024 12:04:41 -0700 (PDT)
Received: from valdaarhun.. ([223.233.80.235])
        by smtp.gmail.com with ESMTPSA id k21-20020aa792d5000000b006e6f8e9ab6asm8060730pfa.15.2024.04.01.12.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 12:04:41 -0700 (PDT)
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
Subject: [PATCH bpf-next v4] bpftool: Mount bpffs on provided dir instead of parent dir
Date: Tue,  2 Apr 2024 00:34:07 +0530
Message-ID: <20240401190407.20363-1-icegambit91@gmail.com>
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

Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>
---
 tools/bpf/bpftool/common.c     | 98 +++++++++++++++++++++++++++++-----
 tools/bpf/bpftool/iter.c       |  2 +-
 tools/bpf/bpftool/main.h       |  3 +-
 tools/bpf/bpftool/prog.c       |  5 +-
 tools/bpf/bpftool/struct_ops.c |  2 +-
 5 files changed, 94 insertions(+), 16 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447..56a5abbb1bf8 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -244,29 +244,103 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
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
+	dir_exists = (access(dir_name, F_OK) == 0);
+
+	if (!dir_exists) {
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
+		err = mkdir(dir_name, 0700);
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
 		goto out_free;
 
+	if (access(dir, F_OK) == -1) {
+		p_err("can't pin BPF object: dir '%s' doesn't exist", dir);
+		free(temp_name);
+		return -1;
+	}
+
 	if (block_mount) {
 		p_err("no BPF file system found, not mounting it due to --nomount option");
 		err = -1;
@@ -276,12 +350,12 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
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
 
@@ -289,7 +363,7 @@ int do_pin_fd(int fd, const char *name)
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

