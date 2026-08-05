Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2AA3EB7F4
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921654; cv=none; b=RmhtSAUwbaA18vFMZBDTfaurkmxZdHDSOZk6reGB/xooFiLe1FZp+HM2J9e38GcfDrxpuMtM3HREuk/duHRBnJxnQAw++OnDm8/41NwIgagPHA+lndcOS9rFNXvgqB6nj+maCBcvyMljh84wLP05NGyDC0D5uPHjjdGuzY7EiPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921654; c=relaxed/simple;
	bh=FP5V+/ygynVfbTL23lPPyV9rBlyavXD/fkc1dieAk/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhcNlDJfARj3AyowFMi6n7aQTfl9VCPfK1vehFlWjyFKTjtKTdb1pAEiiQRAXC0tYRxD6HClsyHrW+fTzs4wbI22QvPkrQk9kuBoncETP1U1GuUqB6iM61xCG0JlB/Qfc9d95JwZQ+c4m+uMZBmVJ8dOtqd+UPfFNOQ0m4cMz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mz4neGt7; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mz4neGt7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785921651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aP+xZvCeYjCPMovU6nFO+tDWTQv8q8MytFmDoJ6Dhdo=;
	b=mz4neGt7wz1ImmnvDP2k2qZuzSwKoxRlR/kfSeuCBLZl7b5prSOiTtkpI7LzchFW2P5zA+
	UQkQvpNvyN11shJ7kDnknweZFCwVC6vj0mY1EMin5AvXw+ipEOZZNFjNI9Kc1WBkeaZcS5
	kQGZMMrbE1fC53+HvknVcOZ1ZYEwYyw=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Add read_cgroup_file() to cgroup_helpers
Date: Wed,  5 Aug 2026 17:15:56 +0800
Message-ID: <20260805091720.139924-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260805091720.139924-1-jiayuan.chen@linux.dev>
References: <20260805091720.139924-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

cgroup_helpers has write_cgroup_file()/write_cgroup_file_parent() but no
read counterpart. Add read_cgroup_file() and read_cgroup_file_parent() so
a forked child can read a cgroup file (e.g. memory.current) from the work
dir owned by the parent that set the environment up, without hand-building
the /mnt/... path.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 67 ++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  4 ++
 2 files changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 45cd0b479fe3..4183ff6150c2 100644
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
index 3857304be874..d42d2e13044e 100644
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

