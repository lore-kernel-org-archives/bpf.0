Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608078;
	b=G4/HJDwZ3oHaLYiy3aHOtMrqF3Hlw4LWfCnHE5zlr4p6GSxibvBXLklJijEh0ISLeGRP
	 8I5bZrZgAnOkC2TByzcdYcd4yYR19gSSnQSP4Rx4JQ1uhMThWREGuePJ/qEulO3zBF+sF
	 5RtxamDM4UhQWhdy+3+aGt/teS2prDaYsp82CLyUU85a3YKPkJQyYBK+MN5rfUY5fvdi7
	 462rTouT4UKY/fiuXSKGSaR6UedpnEteaN6U3T4CV3wE5mNwsggB5Qkep4QKQBtLR5xnF
	 Z2MM4pisl+ZZE6piFYIHcI3MKYqb7+oFvTgp9M32u2vNu2J/jLuQJrplEFYw1YgY7cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=+E9yv9HQNupNSs8TG1/d516U+BHXkDhMB4q2L4QWy/Y=;
	b=mG5QhgdLhEW0xBVBTsU+x4leQ/Ne59f0SW8pG0wINgFg9+Dk9lui7A6v/O4fncN2bm4M
	 r5k5NYFDyztX02N0xXvKrxAurGSCDzUvUWa2rYzLigGnRnD8Pw/PQhVTQRKrvQ5u2kjdf
	 +RRCAzARpeVSbzJXsAkdUMTbaM0GKPQZ+mHSfM+a45DAL5S9Jlfv5uW0WaRkYkM7fAiR2
	 Hcb40fij4Z0P8x2BDpYLZvfUDTorMCvVUGlZSH1Lv1mcyRkQVU6DCEfsmxkdUmK/p5nPH
	 fluHQ5qQzryEera7KKK+HGVopgRPr2/T8NSucvQBIa5hSVMlsCerv6Db1HM9At2D3IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ni2kHJAL;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AF60A380B
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 22:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D23AF60A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ni2kHJAL
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so2199199eec.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 14:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794608076; x=1795212876; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+E9yv9HQNupNSs8TG1/d516U+BHXkDhMB4q2L4QWy/Y=;
        b=Ni2kHJALCX2uu3fkoy2msesS8r8UL8byTQxV6w5uxn30B/s9YwfuCqSzGgDRwDJVIK
         Q1iV9M4RkDGp46f4wFQ/m7U0QHDvL6sIBb9lvGgfhsbmaMpNrDByYqdNx4y2TBPkA7OJ
         MUlOaPEftPA07ssofhZHD7ZfQArIww5spFaSD7oFhUro3YbpcRjEpjoc5DKm2gK1//cA
         j5dVdzz8MpcKM5JQWN7XQveWBBqy3QN7loPjV+AKJW6PX6/WADInz8Iqyl5ectmIZ6S/
         cfCeCbpsMnJFhOza/DgUF9Z+EqfGBxlz1fGJQuRWvsU9eWIvx93lANjhK6pkI86JlNH5
         EWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794608076; x=1795212876;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+E9yv9HQNupNSs8TG1/d516U+BHXkDhMB4q2L4QWy/Y=;
        b=Chqorsx+JZ/GSPdgp4cfMcG7Uam/o0alaw8aP50Zqi7TXf3qHL8kV4vpdceVy1Ecgz
         TlprPMoOZL/BOutW5s+s4F24Ebql4AQsi4VeNgLYZjjg9XL1JK4SvQz9aaPjmyofVMuz
         t0t187xo+0YGHqEf7Q96xuV+t7TVyEHuovpWPPs48A78Cu6J2mhxT89ed/8hBxNMUKz2
         GVa5WWNz4DL11OIdKuWHdCXhpkFkDowQiYwLqkOE8Q5YeJyBFYfR21uCW8lWJD3pXrwo
         FeCw9o8zpeUssTqP0kXFsyhPtJqQCfs1yleli9zY3XdFuE+bHkMXnsRa3oQKYGdC1l71
         0WBw==
X-Forwarded-Encrypted: i=1; AL+hErEJrxC+ledhnOLP2zsDxz5J97HpMK6nXqCQjFjOzHcQppTD6LIuf3o9z2MsjhcO194HFRc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ThcjIRxModUNf3c9R19c55oFAXDTxvf1nA//+PmbE3sLJ9a5m
	Z8D71hSfto4NSXCTiZkfQeZ+FozHMqvEunMamEhTAeq6zPsAQEEpZlCDDfnfafXx9zps+Con9Co
	Y7hJXDiOekY2XLA==
X-Received: from dlai16.prod.google.com ([2002:a05:701b:2710:b0:1a3:c305:2584])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:4508:20b0:14d:c7ae:85dd with SMTP id a92af1059eb24-1b5030e658bmr3609738c88.7.1794608075632;
 Fri, 13 Nov 2026 14:14:35 -0800 (PST)
Date: Fri, 13 Nov 2026 14:12:52 -0800
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261113221248.3535369-18-wusamuel@google.com>
Subject: [PATCH bpf-next v3 7/9] selftests/proc: Add KALLSYMS_QUERY_* ioctl tests
From: Samuel Wu <wusamuel@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Test KALLSYMS_QUERY_BY_NAME and KALLSYMS_QUERY_BY_ADDR against the
/proc/kallsyms text: exact and prefix names, iteration with pos and
retry after -ENAMETOOLONG, module_filter, vmlinux and module symbols,
struct size extension, and invalid input. Skip if the ioctls are
missing or addresses are hidden.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/testing/selftests/proc/.gitignore       |   1 +
 tools/testing/selftests/proc/Makefile         |   1 +
 .../selftests/proc/proc-kallsyms-query.c      | 248 ++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 tools/testing/selftests/proc/proc-kallsyms-query.c

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 9c9735570abf..1762c28f524c 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -4,6 +4,7 @@
 /fd-003-kthread
 /proc-2-is-kthread
 /proc-fsconfig-hidepid
+/proc-kallsyms-query
 /proc-loadavg-001
 /proc-maps-race
 /proc-multiple-procfs
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index a7de2bb6d8be..dc3c28e6b83b 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -29,6 +29,7 @@ TEST_GEN_PROGS += setns-sysvipc
 TEST_GEN_PROGS += thread-self
 TEST_GEN_PROGS += proc-multiple-procfs
 TEST_GEN_PROGS += proc-fsconfig-hidepid
+TEST_GEN_PROGS += proc-kallsyms-query
 TEST_GEN_PROGS += proc-pidns
 
 include ../lib.mk
diff --git a/tools/testing/selftests/proc/proc-kallsyms-query.c b/tools/testing/selftests/proc/proc-kallsyms-query.c
new file mode 100644
index 000000000000..7788cb0f30f8
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-kallsyms-query.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Tests for the KALLSYMS_QUERY_* ioctls on /proc/kallsyms */
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+#include <linux/fs.h>
+
+#include "kselftest.h"
+
+#define PTR(p) ((__u64)(uintptr_t)(p))
+#define PREFIX "vfs_"
+
+static char name_buf[512];
+static char mod_buf[64];
+
+/* Expected values, from the /proc/kallsyms text */
+static struct {
+	unsigned long long vfs_read_addr;
+	bool vfs_read_found;
+	unsigned int prefix_cnt;	/* vmlinux names with PREFIX */
+	unsigned long long mod_addr;	/* module text symbol, or 0 */
+	char mod[64];
+} ref;
+
+static void scan_text(void)
+{
+	FILE *f = fopen("/proc/kallsyms", "r");
+	unsigned long long addr;
+	char line[1024];
+	bool plain_name;
+	char name[513];
+	char mod[64];
+	bool vmlinux;
+	bool module;
+	bool text;
+	char type;
+	int n;
+
+	assert(f);
+	while (fgets(line, sizeof(line), f)) {
+		/* 3 fields for vmlinux, 4 if the line ends with [module] */
+		n = sscanf(line, "%llx %c %512s [%63[^]]]",
+			   &addr, &type, name, mod);
+		/* A longer name would be cut and parsed as vmlinux */
+		assert(n >= 3 && strlen(name) < sizeof(name) - 1);
+		vmlinux = n == 3;
+		module = n == 4 && strcmp(mod, "bpf") &&
+			 strncmp(mod, "__builtin__", strlen("__builtin__"));
+		text = type == 't' || type == 'T';
+		plain_name = name[0] != '.' && name[0] != '$';
+
+		if (vmlinux) {
+			if (!strncmp(name, PREFIX, strlen(PREFIX)))
+				ref.prefix_cnt++;
+			if (!ref.vfs_read_found && !strcmp(name, "vfs_read")) {
+				ref.vfs_read_addr = addr;
+				ref.vfs_read_found = true;
+			}
+		} else if (module && text && plain_name && !ref.mod_addr) {
+			ref.mod_addr = addr;
+			strcpy(ref.mod, mod);
+		}
+	}
+	fclose(f);
+}
+
+static struct kallsyms_query_sym bufs(size_t name_len, size_t mod_len)
+{
+	return (struct kallsyms_query_sym){
+		.sym_name = name_len ? PTR(name_buf) : 0,
+		.sym_name_len = name_len,
+		.sym_module = mod_len ? PTR(mod_buf) : 0,
+		.sym_module_len = mod_len,
+	};
+}
+
+static struct kallsyms_query_by_name name_q(const char *name, const char *mod,
+					    struct kallsyms_query_sym *sym)
+{
+	return (struct kallsyms_query_by_name){
+		.size = sizeof(struct kallsyms_query_by_name),
+		.query_name = PTR(name),
+		.module_filter = PTR(mod),
+		.sym = PTR(sym),
+		.sym_struct_size = sizeof(*sym),
+	};
+}
+
+static struct kallsyms_query_by_addr addr_q(unsigned long long addr,
+					    struct kallsyms_query_sym *sym)
+{
+	return (struct kallsyms_query_by_addr){
+		.size = sizeof(struct kallsyms_query_by_addr),
+		.query_addr = addr,
+		.sym = PTR(sym),
+		.sym_struct_size = sizeof(*sym),
+	};
+}
+
+static int by_name(int fd, void *q)
+{
+	return ioctl(fd, KALLSYMS_QUERY_BY_NAME, q) ? -errno : 0;
+}
+
+static int by_addr(int fd, void *q)
+{
+	return ioctl(fd, KALLSYMS_QUERY_BY_ADDR, q) ? -errno : 0;
+}
+
+int main(void)
+{
+	struct {
+		struct kallsyms_query_by_name q;
+		__u64 extra;
+	} qx = {};
+	struct {
+		struct kallsyms_query_sym s;
+		__u64 extra;
+	} sx = {};
+	struct kallsyms_query_by_addr qa;
+	struct kallsyms_query_by_name q;
+	struct kallsyms_query_sym sym;
+	unsigned int cnt = 0;
+	__u64 first_pos = 0;
+	char name[512];
+	__u64 size;
+	__u64 len;
+	int err;
+	int fd;
+
+	fd = open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		ksft_exit_skip("open(/proc/kallsyms): %s\n", strerror(errno));
+	scan_text();
+	if (!ref.vfs_read_found)
+		ksft_exit_skip("vfs_read is not in /proc/kallsyms\n");
+
+	/* Exact name in vmlinux, with name and module buffers */
+	sym = bufs(sizeof(name_buf), sizeof(mod_buf));
+	q = name_q("vfs_read", "vmlinux", &sym);
+	err = by_name(fd, &q);
+	if (err == -ENOTTY)
+		ksft_exit_skip("KALLSYMS_QUERY_BY_NAME is not supported\n");
+	if (!ref.vfs_read_addr) {
+		qa = addr_q(0, &sym);
+		assert(err == -EPERM && by_addr(fd, &qa) == -EPERM);
+		ksft_exit_skip("kallsyms addresses are hidden\n");
+	}
+	assert(!err);
+	assert(sym.sym_addr == ref.vfs_read_addr && sym.sym_size > 0);
+	assert(!strcmp(name_buf, "vfs_read"));
+	assert(sym.sym_name_len == sizeof("vfs_read"));
+	assert(!mod_buf[0] && sym.sym_module_len == 1);
+	size = sym.sym_size;
+
+	/* Prefix: one match per call with pos + 1, until -ENOENT */
+	q = name_q(PREFIX, "vmlinux", &sym);
+	q.query_flags = KALLSYMS_QUERY_NAME_PREFIX;
+	sym = bufs(sizeof(name_buf), 0);
+	while (!(err = by_name(fd, &q))) {
+		assert(!strncmp(name_buf, PREFIX, strlen(PREFIX)));
+		if (!cnt++)
+			first_pos = q.pos;
+		sym = bufs(sizeof(name_buf), 0);
+		q.pos++;
+	}
+	assert(err == -ENOENT && cnt == ref.prefix_cnt);
+
+	/* -ENAMETOOLONG sets pos and both sizes; a retry succeeds */
+	sym = bufs(1, 2);
+	q.pos = 0;
+	assert(by_name(fd, &q) == -ENAMETOOLONG && q.pos == first_pos);
+	assert(sym.sym_module_len == 1);
+	len = sym.sym_name_len;
+	sym.sym_name_len = sizeof(name_buf);
+	assert(by_name(fd, &q) == 0 && q.pos == first_pos);
+	assert(sym.sym_name_len == len && strlen(name_buf) + 1 == len);
+
+	/* No match */
+	sym = bufs(0, 0);
+	q = name_q("__no_such_symbol__", NULL, &sym);
+	assert(by_name(fd, &q) == -ENOENT);
+
+	/* BY_ADDR inside vfs_read */
+	sym = bufs(sizeof(name_buf), 0);
+	qa = addr_q(ref.vfs_read_addr + 1, &sym);
+	assert(by_addr(fd, &qa) == 0 && !strcmp(name_buf, "vfs_read"));
+	assert(sym.sym_addr == ref.vfs_read_addr && sym.sym_size == size);
+
+	sym = bufs(0, 0);
+	qa = addr_q(~0ULL, &sym);
+	assert(by_addr(fd, &qa) == -ENOENT);
+
+	/* Module symbol: BY_ADDR and BY_NAME with module_filter agree */
+	if (ref.mod_addr) {
+		bool found = false;
+
+		sym = bufs(sizeof(name_buf), sizeof(mod_buf));
+		qa = addr_q(ref.mod_addr, &sym);
+		assert(by_addr(fd, &qa) == 0 && sym.sym_addr == ref.mod_addr);
+		assert(!strcmp(mod_buf, ref.mod));
+		strcpy(name, name_buf);
+		size = sym.sym_size;
+
+		q = name_q(name, ref.mod, &sym);
+		sym = bufs(0, sizeof(mod_buf));
+		while (!(err = by_name(fd, &q))) {
+			assert(!strcmp(mod_buf, ref.mod));
+			if (sym.sym_addr == ref.mod_addr) {
+				assert(sym.sym_size == size);
+				found = true;
+			}
+			sym = bufs(0, sizeof(mod_buf));
+			q.pos++;
+		}
+		assert(err == -ENOENT && found);
+	}
+
+	/* Larger structs with a zero tail are accepted */
+	qx.q = name_q("vfs_read", NULL, &sx.s);
+	qx.q.size = sizeof(qx);
+	qx.q.sym_struct_size = sizeof(sx);
+	assert(by_name(fd, &qx) == 0 && sx.s.sym_addr == ref.vfs_read_addr);
+
+	/* Unknown flags and mismatched buffer pointer/length */
+	sym = bufs(0, 0);
+	q = name_q("vfs_read", NULL, &sym);
+	q.query_flags = 1ULL << 63;
+	assert(by_name(fd, &q) == -EINVAL);
+	qa = addr_q(ref.vfs_read_addr, &sym);
+	qa.query_flags = 1;
+	assert(by_addr(fd, &qa) == -EINVAL);
+	sym = (struct kallsyms_query_sym){ .sym_name = PTR(name_buf) };
+	q = name_q("vfs_read", NULL, &sym);
+	assert(by_name(fd, &q) == -EINVAL);
+	sym = (struct kallsyms_query_sym){ .sym_module_len = sizeof(mod_buf) };
+	assert(by_name(fd, &q) == -EINVAL);
+
+	close(fd);
+	return 0;
+}
-- 
2.56.0.679.gc527c65306-goog

