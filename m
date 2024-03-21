Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F073482E1
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049189; cv=none; b=GQMlyi7D8NtlBmK1mhc2YPs6qYVKuip+dDjefPVJzcsLKWVOi9hnYa96mYz+784GALnjsnHQpjRKEtbp6tQAmKpkn+0M/d9y5n/NxmkZi40108rOkIpDFoLtoFatwWVws4HnNxialxnduNDZtCPkuFafjVUV13VZMi/R4RyGBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049189; c=relaxed/simple;
	bh=aCY9v01nqeLfyYh5fzBZMiUeeSlIEjhfyMaDLrnnxxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGrzVvA038o+xg1KupSzYmqQWOxFatqFjf2uFfdlxnYBsbqdT889Xy+Hs+32p3ZWJMTErfUwhlVzia98KqB/dZzsuyC40e/qxF+olfwVRNSjEXhFHsp5UAks62vzrJC2/2EAIO++5HHf7HMyiCC7ZPX9L8ypfGdZjz1Eb++3rKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeDjwjxY; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeDjwjxY"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78822e21a9dso78134385a.2
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711049185; x=1711653985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Qf5KjN7YDiwKjFXwIyZJsJJ7I9JqvGRzr23PgTJYBU=;
        b=BeDjwjxY5Ldauu7zzrHPei9kcmwBHlPQ5Bp5Kd8F2CuC+y8VT2Thwydk1OCOhnxYY5
         QPfhd0HnDFFleqL7myehoXCV+0YvHme3cp8QGtRbhbD9EbME9/CWBGpK8aMZhpyQCQFc
         tPvZD/UjhS/ckx45Vqz4vSi4zhDgiXbp5AuudqBlZfsrClR21vQw5pc81T3qARiGLsrR
         n+KbFsaPdtTeonb1m82bhTcL97wnwkiCumG4CLsrUnK1HHP3sgI9tuJwSq8/lW9svT5r
         PAefd+W2lcUSm9JbbLgJw33Aff4YCYWgWEjz91nGBS6fmnEq/rF8gLxiXZ7I82Bk37aJ
         CIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711049185; x=1711653985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Qf5KjN7YDiwKjFXwIyZJsJJ7I9JqvGRzr23PgTJYBU=;
        b=V3dllhp4qvr7Om9WkFOj9/KN1J/1v5MCe0nT4Fw1uw/1kk5axVEKiPtoz4RFYaFMGu
         xoJRRCR3BOxL63+uMD0NiY2Yr1gh7BAncjh3B5BDl2gKWbQW+OjNpufS7pU4cCG4CCuB
         Hg8gjbwp3tvTWI41KTv0tA4JcmJX32rUX7w3q+Vj9mTCHQlH/YwKFegRWAgzqoqOAASn
         qqkN5/a68FQNKvaZGhbwKL7gR14luhW+HHoVWA2e2hmUyvzAsLIYy1ePQ0d+2vISSug5
         /Y1mBHvlCRhTZRPiJCUP+yS1mY96830CGlCcvjEizEpz7eWyuu2DGaDj3H2A/Q5vEo0D
         vW2g==
X-Forwarded-Encrypted: i=1; AJvYcCWE1gtimpxxispVjpbbZmov7Lu1Tlj42OXJj8bYy88HomY0zmvYnjx0mCTwi7PeauRb0dDtbaLtgamKhROcDnNFAiz8
X-Gm-Message-State: AOJu0YzlplHYYqdEd9Mpf4ropXBdvC83xP94fytSNAsMDeJkQwRn1hTD
	vz0JsrrgPNUIy4WEPUHDtwFn5+1XLWwO3fH+rjzGsPB/+q/Dd3wFOcskvoprZNY=
X-Google-Smtp-Source: AGHT+IGV5qSKJraxcTj7PjF1NN21HlyiqRpjHMy3aUHAaKklATi3yqfOsv8wHe5ysiynzrGXlYSNSQ==
X-Received: by 2002:a05:6a20:3ca0:b0:19e:ac58:7b0d with SMTP id b32-20020a056a203ca000b0019eac587b0dmr595435pzj.5.1711048835857;
        Thu, 21 Mar 2024 12:20:35 -0700 (PDT)
Received: from valdaarhun.. ([223.233.84.240])
        by smtp.gmail.com with ESMTPSA id j26-20020a62e91a000000b006e6813f2301sm197748pfh.56.2024.03.21.12.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:20:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v3] bpftool: Mount bpffs on provided dir instead of parent dir
Date: Fri, 22 Mar 2024 00:49:55 +0530
Message-ID: <20240321191955.24992-1-icegambit91@gmail.com>
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

Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>
---
 tools/bpf/bpftool/common.c     | 93 ++++++++++++++++++++++++++++++----
 tools/bpf/bpftool/iter.c       |  2 +-
 tools/bpf/bpftool/main.h       |  3 +-
 tools/bpf/bpftool/prog.c       |  5 +-
 tools/bpf/bpftool/struct_ops.c |  2 +-
 5 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447..dce73105b0a5 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -244,24 +244,95 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
 	return fd;
 }
 
-int mount_bpffs_for_pin(const char *name, bool is_dir)
+int create_and_mount_bpffs_dir(const char *dir_name)
 {
 	char err_str[ERR_MAX_LEN];
-	char *file;
-	char *dir;
 	int err = 0;
+	bool dir_exists;
 
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
+			p_err("bpf object can't be pinned since dir (%s) does not exist",
+			      parent_name);
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
+			p_err("failed to create dir (%s): %s", dir_name, strerror(errno));
+			return err;
+		}
+	}
+
+	err = mnt_fs(dir_name, "bpf", err_str, ERR_MAX_LEN);
+	if (err) {
+		err_str[ERR_MAX_LEN - 1] = '\0';
+		p_err("can't mount BPF file system on given dir (%s): %s",
+		      dir_name, err_str);
+
+		if (!dir_exists) {
+			if (rmdir(dir_name) == -1)
+				p_err("failed to remove newly created dir (%s): %s",
+				      dir_name, strerror(errno));
+		}
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
@@ -277,11 +348,11 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
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
 
@@ -289,7 +360,7 @@ int do_pin_fd(int fd, const char *name)
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

