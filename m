Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63753161E
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072379; cv=none; b=bF9A96zz2EiLZ+nkGAHakMqUwcLE3mvd7+BR8D9YEVCSa41fIUYbky8+J4YpJNRsG97bYRZnqtpYdX3JXuwNHRTQwqriJYTe+WX9KKO4Y3xysTwDu202EBlretmd+9dqgwhbIC3zgYfIpxJcaMulv9332eSxKKeL/RxnP/aiMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072379; c=relaxed/simple;
	bh=4ZMgtbSq1fLEo9A153G8EUdhTbvG1BhTa+Q06muy2Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSbxXqv6b59MRyxIp6XFmEn6s1Z5TV0ZFt8ME8mpEL4QmyMO9p6iVI4CdlIbFlma1cwaaaXS1MoZC8Og7BTGWIEFYIj9unPOKnUePK4sImLHcWC1PkAaYpeF8Qw7lPjof0pRCGcE4z0ZMAmBr6mcAl8iO8UX2F2iONBY6hhgCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GTAbz5EP; arc=none smtp.client-ip=91.218.175.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GTAbz5EP"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4ZMgtbSq1fLEo9A153G8EUdhTbvG1BhTa+Q06muy2Bc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790072374; v=1; x=1790677174;
 b=GTAbz5EPtI8jPhw/RBRS9rqQDbLqG7ZbUuAm7PZTuUoSi0pMshjlTeQoK+wp92rXZY2DiUQd
 2K9mkRzkxrWByvu4pBJvGyEHJFStvuQ7IRPT7GwZXI6AXHhk2ZNgDYFslas6uEX6RfRaiIZy2hX
 KjcJEeSSmbd1vGfvluwZeJVI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 228bac855f9d92f3;
	Tue, 22 Sep 2026 10:19:34 +0000
X-Mizu-Trace-ID: 228bac855f9d92f3
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v9 2/3] selftests/bpf: Add read_cgroup_file() to cgroup_helpers
Date: Tue, 22 Sep 2026 18:17:34 +0800
Message-ID: <20260922101831.192102-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101831.192102-1-jiayuan.chen@linux.dev>
References: <20260922101831.192102-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgroup_helpers has write_cgroup_file()/write_cgroup_file_parent() but no
read counterpart. Add read_cgroup_file() and read_cgroup_file_parent() so
a forked child can read a cgroup file (e.g. memory.current) from the work
dir owned by the parent that set the environment up, without hand-building
the /mnt/... path.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 67 ++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  4 ++
 2 files changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 45cd0b479fe35..4183ff6150c28 100644
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
index 3857304be8741..d42d2e13044e5 100644
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
2.43.0

