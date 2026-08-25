Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598233EA97A
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649615; cv=none; b=a16A6nQc3Vzb/BT5iZRx0C9YMFAeEeRzFLjWdeLNrvzwBgk38MXufEGhZ+LaSjx04Z5O1SS50wKzz94e2ElN4BwbFAgaVtRt2jNO380JgOkwCR0IjjqqyffPcQ6xaJZatI/Bqai0RrQJCcrUBP270HHD0or/WoyDxIH7348dUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649615; c=relaxed/simple;
	bh=/yvTesosUitvxpBGbkVrq+T3ZwnrBfxMu1Tk0/tPvCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAATGhdhDiifGuQLombksksEZ+uT+yKWDJSOwLWCO7KhU9tZxUjQX1IqXH/6UsfMZA0slGZSzF6vwNN4GUkEa/OY2GOsQn/vaMEbn5JDJK/yWNRB7Bz43dQuPNlhy/oTp18vrt/FXbaPF5/UXNuaWOOC187LqojN+er1xSMYWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0iie5TW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0iie5TW"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so4497809a91.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649612; x=1788254412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rBrebsEU++q5oyTmtoojXSPfykwosiXDRrVD5SURpU=;
        b=V0iie5TW7J64I2H/GdYFujiQlMqRe+ajXUvwGW2hSpngsp8mtQWakparn/E4JuDzxi
         PXZfwqVOBvggzCELl1nnjMXQw29EZMK65JKrx+e/aO+AANwfqa3j219qupcpU+fl6aH1
         6OtIhJe+zwzKbJUNmjo5noMX7pXSoKm0nG2VI4YfQHL6dOwRpiP4yZBTUIZmMFDk5EHV
         +8R3HVjB4syDvKaOTNILBAWnYfMK7JiAD0d1kUzhaOD6OObIKZ2sHOG3YHGv9ucxAGd8
         URe9tdLiIH3FJAJ9fCU7JNWfIXJ743JEfncyVDt8TOZxOKueIBFO4EoJo40GKSJotgGY
         14RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649612; x=1788254412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0rBrebsEU++q5oyTmtoojXSPfykwosiXDRrVD5SURpU=;
        b=oX9eyo+Oy1gBEeG8uU+cnorwMDT0rWcVrEB/X5vhxGpoaUlKVXT8E8LbA+fIhPMcli
         s084b8kyW9dMtDZDyidkPZQdVN5GaY0ETm1zojyBOKOyJu3aS980+hM87DildCP7gCs7
         u8Ftm7eS/y+YeXh0TRMb+oTd/BRqO/DJSJSJSmXl/WRF4NgmqNzxnkct2C4kHtmUPWYy
         SV/pg3D5U94m/hRgUuhpgGN6ZZRb4CgtYuMrWK2f2HtwThvCCOHmFpdpb+bdenPdcw2P
         XBSPLjdryV7W268OKQAG8oZaCB5oa6MhWzsrXjONr1H5yP/slRDxTsQVV0ZxMTsOQ0Zv
         50kQ==
X-Gm-Message-State: AFuF++mvmIaOb6aSS3uqAPjyuFfQUY6M/qKhCiAfmPORQEeEw2N6Zqrb
	ulNYhmXqXudOIB68YDF9sfbAvYwE7ioFx4O8i8/8TQMc0RUO5C84CXEvKCql+r3sLXg=
X-Gm-Gg: AR+sD11UqqxYgavXWjON0pXhoqedvh/A9fCrTzaatuVgD/xmOFg0EyecAz0HbgbT20r
	5FcceWu6QYDQX5wKT+CqkuTn3bTfk36Qkov4H5BiuccrRj/KF7TYmvmMFUPe/9qOKKE8zfk3amk
	ufm+XUl4J6EOrgCh1ndTR3S6pMiJADVVL43/efj8DH/2/8/13zy8yuTRY+UXC5XqMD8/wrJgY5k
	3vxg1dOwhLuZstIkkZfksq6TrQAQ/1fkSi2WSh/1MVaL2wYY5bYtFWRvTcuqbOLPtZJkecCna1S
	tgfvrXx14L4JVz+uL8mcYzPLBbsKvJyXRm37//AJe8KpIpzcot7X/r/rR+QtkdzLFsHcCGX410Z
	v0+Qw8qwnoLomXPvxkoe0uP6OBJ3pmr0JNQxn8WrmIXNQB5fpLzpUZRJoCjlVpjHEQSmcxFLRxw
	NJAU260F0vgCI2UB0DW7e2OtsSFA/4Ez1gycbBZgubM7V7B1F7L7q16nl541onX9MEzsFMbRGsR
	P/PlosWkXzCfadj+mshji2z/XUUyw==
X-Received: by 2002:a17:90b:580d:b0:38f:5869:387b with SMTP id 98e67ed59e1d1-395df24e757mr49635358a91.9.1787649612347;
        Tue, 25 Aug 2026 02:20:12 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3282afb407bsm5386163eec.30.2026.08.25.02.20.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:20:11 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com
Subject: [PATCH v6 3/4] selftests/bpf: Add read_cgroup_file() to cgroup_helpers
Date: Tue, 25 Aug 2026 14:49:51 +0530
Message-ID: <20260825091952.81971-4-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
References: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

cgroup_helpers has write_cgroup_file()/write_cgroup_file_parent() but no
read counterpart. Add read_cgroup_file() and read_cgroup_file_parent() so
a forked child can read a cgroup file (e.g. memory.current) from the work
dir owned by the parent that set the environment up, without hand-building
the /mnt/... path.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 67 ++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  4 ++
 2 files changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 45cd0b479f..4183ff6150 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -188,6 +188,73 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 	return __write_cgroup_file(cgroup_path, file, buf);
 }
 
+static int __read_cgroup_file(const char *cgroup_path, const char *file,
+			      char *buf, size_t len)
+{
+	char file_path[PATH_MAX + 1];
+	ssize_t got;
+	int fd;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
+	fd = open(file_path, O_RDONLY);
+	if (fd < 0) {
+		log_err("Opening %s", file_path);
+		return 1;
+	}
+
+	got = read(fd, buf, len - 1);
+	if (got < 0) {
+		log_err("Reading %s", file_path);
+		close(fd);
+		return 1;
+	}
+	buf[got] = '\0';
+	close(fd);
+	return 0;
+}
+
+/**
+ * read_cgroup_file() - Read from a cgroup file
+ * @relative_path: The cgroup path, relative to the workdir
+ * @file: The name of the file in cgroupfs to read from
+ * @buf: Buffer to read into, NUL-terminated on success
+ * @len: Size of @buf
+ *
+ * Read from a file in the given cgroup's directory.
+ *
+ * If successful, 0 is returned.
+ */
+int read_cgroup_file(const char *relative_path, const char *file,
+		     char *buf, size_t len)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return __read_cgroup_file(cgroup_path, file, buf, len);
+}
+
+/**
+ * read_cgroup_file_parent() - Read from a cgroup file in the parent process
+ *                             workdir
+ * @relative_path: The cgroup path, relative to the parent process workdir
+ * @file: The name of the file in cgroupfs to read from
+ * @buf: Buffer to read into, NUL-terminated on success
+ * @len: Size of @buf
+ *
+ * Read from a file in the given cgroup's directory under the parent process
+ * workdir.
+ *
+ * If successful, 0 is returned.
+ */
+int read_cgroup_file_parent(const char *relative_path, const char *file,
+			    char *buf, size_t len)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_parent_cgroup_path(cgroup_path, relative_path);
+	return __read_cgroup_file(cgroup_path, file, buf, len);
+}
+
 /**
  * setup_cgroup_environment() - Setup the cgroup environment
  *
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 3857304be8..d42d2e1304 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -15,6 +15,10 @@ int write_cgroup_file(const char *relative_path, const char *file,
 		      const char *buf);
 int write_cgroup_file_parent(const char *relative_path, const char *file,
 			     const char *buf);
+int read_cgroup_file(const char *relative_path, const char *file,
+		     char *buf, size_t len);
+int read_cgroup_file_parent(const char *relative_path, const char *file,
+			    char *buf, size_t len);
 int cgroup_setup_and_join(const char *relative_path);
 int get_root_cgroup(void);
 int create_and_get_cgroup(const char *relative_path);
-- 
2.54.0 (Apple Git-157)

