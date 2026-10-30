Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386279;
	b=RIfDd+4C6gGPq6cz2X7gOrqehWyrU8Rs/+S3WDSRRmCc9IwE1Qij2BUcVAjMwM6P/QdY
	 lZzYgjW4/JV8yIkbBKvstLvhJ0vhu1ZcK40T/v5mGTFkJo86gE7EjzLZKuvKLZ0RG7wqd
	 6CJTQgNTIWu2ILXYAmjXPMKVdjX5Vfgwy4hoKnNyxNCtY88ggaXl04WRiQLHYuhvVqyGO
	 6bQzcAphgNhvaHMtJ5z5zviyp67DtmrTPzzQ4kP8MxLuj8UrSIM4+N3HosCUW6zjr/c3L
	 SL2ShJ52hFtLuwH6CB0yHp0gACtYOi+mUA+DxTcWXu9L8bB154r9BMO4fimFtt6/itg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386279;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=tGPD1kG0muCiRaH+onMJbF8McQXw/3iybmvF3qayq9M=;
	b=VoLg3GpVNmec21mJ3hsT1qeHUjAV3yqracK+nFXFJj2IwI42pEsglzrg6CWCKMq8bvtY
	 GmwWGSu8QkRBhuL3sNJfdpYvH0Jg3ULtYLlAPw9/enfEglLtbHgDH6YOFjiXa16gYYPfo
	 t0x4Agu+y5BdWwoJwE1cgu/je4JXI5H9Pk6Sok8WYiEP1xZKGKrPf7vuFg8oZ9aoqqLm+
	 PJRpE2rYj760/qJl9xxcRE9+bIxkfaegiyDBXRE8xXFWosGkxdFiFQfhyReHekDXjr2j/
	 Vzn1ltyJ81kxE10tTJ0XfunJ00fYOh6/5tLwstRCpHneUHF7SJCsKRlGorJUHnplB4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Qw57GVyK;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16215606A324
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16215606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Qw57GVyK
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1F307C49F67;
	Fri, 30 Oct 2026 18:52:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 37E91603C2;
	Fri, 30 Oct 2026 18:51:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B4D1103290EE;
	Fri, 30 Oct 2026 19:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793386270; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tGPD1kG0muCiRaH+onMJbF8McQXw/3iybmvF3qayq9M=;
	b=Qw57GVyKDhm66E50/4M5x8JdNW3QxpdeVHS09WY2sC399HrrlHeDaQjSES0W8b/aHJr3aj
	1kj+Ml0n2AJMr/wFRaJvq06j3maHegSC2tVAQTSvmk2zgLefhSfGwKseQPLRr2yMb/yKl1
	BCVOFEhpsl4BsOWju5FFycYRdLdEWxylEXvB23NUP92h+27NPS9rjWddWAPCYRHumj85uZ
	cil3sLuqvNaj+lhDhgoRfbEbWahg59PxxtMkpUUIFdZTKXmy7PUX7BmlMsO1M3fFpjK56Y
	rpUstMBq/LY4ebEmiDVY3vvREYNBqeNIWlCpB0iIF+5Opv9R3G7ijrNFtDzG/w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 30 Oct 2026 19:50:40 +0100
Subject: [PATCH bpf-next 1/2] selftests/bpf: add helpers to manipulate
 ftrace
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-ftrace_in_test_progs-v1-1-aa50c5dd1ccc@bootlin.com>
References: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
In-Reply-To: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Add helpers to allow a test_progs test to tune ftrace configuration.
This new set of helpers work with an opaque structure: this one is used
to record any change performed on ftrace, so that we can restore those
automatically once the test is done.

The new helpers distinguish between two entries types:
- basic controls, that are "knobs"
- filters, for which writes are "additive"

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/trace_helpers.c | 247 +++++++++++++++++++++++++++-
 tools/testing/selftests/bpf/trace_helpers.h |   9 +
 2 files changed, 254 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 6d7a4b8c4ab8..1f26a057a810 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -21,8 +21,12 @@
 #include "bpf/libbpf_internal.h"
 #include "bpf_util.h"
 
-#define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
-#define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
+#define TRACEFS		"/sys/kernel/tracing"
+#define TRACEFS_PIPE	TRACEFS "/trace_pipe"
+#define DEBUGFS		"/sys/kernel/debug/tracing"
+#define DEBUGFS_PIPE	DEBUGFS "/trace_pipe"
+
+#define CHUNK_SIZE	128
 
 static struct ksyms *ksyms;
 static pthread_mutex_t ksyms_mutex = PTHREAD_MUTEX_INITIALIZER;
@@ -557,6 +561,245 @@ void read_trace_pipe(void)
 	read_trace_pipe_iter(trace_pipe_cb, NULL, 0);
 }
 
+static const char *tracefs_mountpoint(void)
+{
+	return access(TRACEFS_PIPE, F_OK) == 0 ? TRACEFS : DEBUGFS;
+}
+
+static int tracefs_path(char *buf, size_t size, const char *file)
+{
+	int ret = snprintf(buf, size, "%s/%s", tracefs_mountpoint(), file);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int tracefs_read(int fd, char **content)
+{
+	size_t len = 0;
+	char tmp[CHUNK_SIZE];
+	char *buf = NULL;
+	ssize_t n;
+	int ret;
+
+	ret = lseek(fd, 0, SEEK_SET);
+	if (ret < 0)
+		return ret;
+
+	do {
+		n = read(fd, tmp, CHUNK_SIZE);
+		if (n < 0) {
+			if (buf)
+				free(buf);
+			return n;
+		}
+		if (!n)
+			break;
+		buf = realloc(buf, len + n + 1);
+		memcpy(buf + len, tmp, n);
+		len += n;
+	} while (1);
+
+	/* No data read at all, file was empty */
+	if (!buf) {
+		buf = malloc(1);
+		if (!buf)
+			return -ENOMEM;
+	}
+	buf[len] = '\0';
+	*content = buf;
+	return 0;
+}
+
+static int tracefs_write(int fd, const char *str)
+{
+	ssize_t ret;
+
+	ret = lseek(fd, 0, SEEK_SET);
+	if (ret < 0)
+		return ret;
+
+	ret = write(fd, str, strlen(str));
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int tracefs_write_file(const char *path, const char *str)
+{
+	int fd, err;
+
+	fd = open(path, O_CLOEXEC | O_WRONLY | (*str ? 0 : O_TRUNC));
+	if (fd < 0)
+		return fd;
+
+	err = tracefs_write(fd, str);
+	close(fd);
+	return err;
+}
+
+enum tracefs_ctl_kind {
+	TRACEFS_CTL_FILTER,
+	TRACEFS_CTL_VALUE,
+};
+
+struct tracefs_ctl_entry {
+	char path[PATH_MAX];
+	char *old;
+	enum tracefs_ctl_kind kind;
+};
+
+struct tracefs_ctl {
+	struct tracefs_ctl_entry *entries;
+	size_t cnt;
+};
+
+struct tracefs_ctl *tracefs_ctl_init(void)
+{
+	return calloc(1, sizeof(struct tracefs_ctl));
+}
+
+static int tracefs_ctl_update(struct tracefs_ctl *ctl, const char *file,
+			      const char *str, enum tracefs_ctl_kind kind)
+{
+	struct tracefs_ctl_entry *entry, *tmp;
+	char path[PATH_MAX];
+	char *old = NULL;
+	bool recorded = false;
+	size_t i;
+	int fd, err;
+
+	if (!ctl)
+		return -EINVAL;
+
+	err = tracefs_path(path, sizeof(path), file);
+	if (err)
+		return err;
+
+	for (i = 0; i < ctl->cnt; i++) {
+		if (strcmp(ctl->entries[i].path, path))
+			continue;
+		if (ctl->entries[i].kind != kind)
+			return -EINVAL;
+		/* Already altered, keep the value read on the first write. */
+		return tracefs_write_file(ctl->entries[i].path, str);
+	}
+
+	fd = open(path, O_CLOEXEC | O_RDWR);
+	if (fd < 0)
+		return fd;
+
+	err = tracefs_read(fd, &old);
+	if (!err) {
+		tmp = realloc(ctl->entries, (ctl->cnt + 1) * sizeof(*tmp));
+		if (!tmp) {
+			free(old);
+			close(fd);
+			return -ENOMEM;
+		}
+		ctl->entries = tmp;
+		entry = &ctl->entries[ctl->cnt];
+		strcpy(entry->path, path);
+		entry->old = old;
+		entry->kind = kind;
+		recorded = true;
+	}
+
+	err = tracefs_write(fd, str);
+	close(fd);
+	if (err) {
+		free(old);
+		return err;
+	}
+
+	if (recorded)
+		ctl->cnt++;
+	return 0;
+}
+
+int tracefs_ctl_filter_write(struct tracefs_ctl *ctl, const char *file,
+			     const char *pattern)
+{
+	return tracefs_ctl_update(ctl, file, pattern, TRACEFS_CTL_FILTER);
+}
+
+int tracefs_ctl_set(struct tracefs_ctl *ctl, const char *file, const char *value)
+{
+	return tracefs_ctl_update(ctl, file, value, TRACEFS_CTL_VALUE);
+}
+
+static const char *tracefs_next_line(const char *content, char *buf, size_t size,
+				     int *err)
+{
+	const char *end;
+	size_t len;
+
+	*err = 0;
+	while (*content) {
+		end = strchrnul(content, '\n');
+		len = end - content;
+		content = *end ? end + 1 : end;
+
+		if (!len || end[-len] == '#')
+			continue;
+
+		if (len + 2 > size) {
+			*err = -ENAMETOOLONG;
+			return NULL;
+		}
+		memcpy(buf, end - len, len);
+		buf[len++] = '\n';
+		buf[len] = '\0';
+		return content;
+	}
+
+	return NULL;
+}
+
+static int tracefs_restore_file(const struct tracefs_ctl_entry *entry)
+{
+	char buf[CHUNK_SIZE];
+	const char *content = entry->old;
+	int err = 0;
+
+	if (!content)
+		return 0;
+
+	if (entry->kind == TRACEFS_CTL_FILTER) {
+		err = tracefs_write_file(entry->path, "");
+		if (err)
+			return err;
+	}
+
+	while ((content = tracefs_next_line(content, buf, sizeof(buf), &err))) {
+		err = tracefs_write_file(entry->path, buf);
+		if (err)
+			return err;
+	}
+
+	return err;
+}
+
+void tracefs_ctl_restore(struct tracefs_ctl *ctl)
+{
+	size_t i;
+	int err;
+
+	if (!ctl)
+		return;
+
+	for (i = ctl->cnt; i > 0; i--) {
+		struct tracefs_ctl_entry *entry = &ctl->entries[i - 1];
+
+		err = tracefs_restore_file(entry);
+		if (err)
+			fprintf(stderr, "Failed to restore %s: %s\n",
+				entry->path, strerror(-err));
+		free(entry->old);
+	}
+	free(ctl->entries);
+	free(ctl);
+}
+
 static size_t symbol_hash(long key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
index 0f8d99746084..432a95016b69 100644
--- a/tools/testing/selftests/bpf/trace_helpers.h
+++ b/tools/testing/selftests/bpf/trace_helpers.h
@@ -57,6 +57,15 @@ void read_trace_pipe(void);
 int read_trace_pipe_iter(void (*cb)(const char *str, void *data),
 			 void *data, int iter);
 
+struct tracefs_ctl;
+
+struct tracefs_ctl *tracefs_ctl_init(void);
+int tracefs_ctl_filter_write(struct tracefs_ctl *ctl, const char *file,
+			     const char *pattern);
+int tracefs_ctl_set(struct tracefs_ctl *ctl, const char *file,
+		    const char *value);
+void tracefs_ctl_restore(struct tracefs_ctl *ctl);
+
 ssize_t get_uprobe_offset(const void *addr);
 ssize_t get_rel_offset(uintptr_t addr);
 

-- 
2.56.0

