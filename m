Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C313F7ABC
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198136; cv=none; b=l+nh5sMA0+bLlyUC4yRg112CMSEaGN+X55ku6tSu53+XE9UBAFUmtUcdJKIlYomUCLAZ0l7vRRmRWkxidoxOPjO/hX6mm5/f0Wm7tSMmHDU9IyWaLe/jVcrwvLozQ68aB08NyRhRY/DbfJiCVbvoeP5wwAX/4aLWcRJ3e8Rh4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198136; c=relaxed/simple;
	bh=FP5V+/ygynVfbTL23lPPyV9rBlyavXD/fkc1dieAk/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=na55z0UTvyIH4luuUq+6eJud0Ycjzd1QTsVXgX6lEnxdj5aiI5pW79HBdLxfAWycelKbkMKf8FkGUhZx13AKkLA/onX35iJwpHzphEx3FXdDXpoY4uIRaNhsQ6EaUdgZbDQWFhXAhSsw0lXo2gSh2bb8MnIKiFnEoBNoOMrT/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f7wT/VD8; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f7wT/VD8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786198132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aP+xZvCeYjCPMovU6nFO+tDWTQv8q8MytFmDoJ6Dhdo=;
	b=f7wT/VD88t6Or8sm4k3jWxjdEBCUEmo8imX/yDihc5asv7eVH2eTvwjF2o3SsQfOnrvoic
	8E+x2aNY96JZwalym86vRZaz2GPbBhccdfYajiGP8NbFGs63jza41YPAQrqHOW+globGih
	HxsFHpTG6CEMivzfXOVdlrO+UJO84y4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Add read_cgroup_file() to cgroup_helpers
Date: Sat,  8 Aug 2026 22:05:55 +0800
Message-ID: <20260808140720.293604-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260808140720.293604-1-jiayuan.chen@linux.dev>
References: <20260808140720.293604-1-jiayuan.chen@linux.dev>
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

