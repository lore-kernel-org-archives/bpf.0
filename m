Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611349;
	b=AUN+ISRF28i6kWlgLBLxsFO0LmE+V0KxOkAUeOWAQacZ86ZDY7CZZ8op3G4SiJDkcbC0
	 YFlu4kIrRP6MunqCHoJdui6Ez/kHSDLhX/UdlLuic/tjcopAxpDkXp9xUce5kAKPf8L+U
	 1awDi8FUBRNK/80zzuc2Fl4c69ra8naC6OAU250C2va83xwlNF5l4xmHglzP31ugsY91I
	 HbAI9EriDmAKbjlzFlsyOfSD7nP42LY9E4RBus1zeYE+jM6xaKdw8lEALlCVKYPwHWvT+
	 AiLOC7MmUC1cfjG6kxtGQeK9FniL1RVFtNRrMEeqJq9ncWMhHYpgRILNcnAwix9C+Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=/G+bOxTG2IO0hTPOmd+yi4dtBw5yWnY/A/ot1dOD19U=;
	b=CHuPFlkI060bDuEsJNhdAkWeGIrG53a7GMNhd2lxTEyX/npwvkxyBtqXIC7nlmPihVzN
	 R1tIAAskqvW2CtWf5NcBXOdG6fw0bxMtCiFGvSQSK7IxYfCmVQMPjKDLwHSjpM3/5XdYG
	 TRxNdh+RgpkFyXQRYfkkHOYCncRNYi+lbMBuLJuYYnRfBKJiVcTJx3TZQaaGjKTVwohNA
	 5wyI7FOYowZKit1p+aPs0qB7QSn42xXvRjyupj4+dkv1WG/yVgDp0XMG+8KTBaBRe7p6B
	 ckusQlWHhWM2Ych2/tFjbcOCxIxcmsW5h8sslD0jVP8AEpiWUJULZicRNwgzsnx0k9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPAEYFN2;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9064606A329
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9064606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPAEYFN2
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67c05273c38so1927606d50.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611348; x=1795216148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/G+bOxTG2IO0hTPOmd+yi4dtBw5yWnY/A/ot1dOD19U=;
        b=zPAEYFN2Jryi+9p1+LZ/nPbHgn6Wtc/WPR7OQCbL6icJIHpU6qbLQLLCsDmuoHaV1W
         7PWZpwd9Rp6kGyFu87lkZolAN1xdWJa7ph6JswFh0vj6xhz0ZSKm7qYsdUfIKXn5FXoQ
         pv3ar5xevihgKAQaZG0dA8O9s7slK+9J3o/syyNNsQXnIhMp/rJi9iMIdDw00YwGYy1p
         9JXAkYjXDWAtKsUDoxb1p5gbBhWDZHJdUCeezt+4aXaBEA0LUO/jilvazlCEIAbtpaVN
         FzeR1uwNDbsoWyKEjuC7wXSD3vn1qb0P4XpAvdimWqIsrOBEXd9FW5E3xIAeRrpxLVUA
         Z+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611348; x=1795216148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/G+bOxTG2IO0hTPOmd+yi4dtBw5yWnY/A/ot1dOD19U=;
        b=hZZcNYXcFQgB9BjZpFCbRoFI3Vi1myIWUqu4tG8wETvlsAnVViu5ubbhlylmnpPrpF
         mg+wgpTI//hDWrLirKzbSnJ3dR3dqsZh0K28hWcc2TyaDS5VYh1MIM5aUTgq10tTf9zL
         lWCwXDf/YaG404kgLq0sc3g399edgtjwut1qW1YHyYbK+FamcNJiqCFjt9Q9MR+BQrxc
         a3edQbRTKc4syF4UGaRqe2ZGUNk593m2csvDkr3FJKJN0yMzd/FJ1TAsK5w405O4D2Ay
         iR7LQzJNpPrNDdQnCpp0ASFyazI6lV9f+4B7p4m33YaGqDNxYYMVMxaoVeBPEvuThqKy
         UpbA==
X-Gm-Message-State: APuU4Z9A6maz0H30VvvOl2ZMmOMNbACBeUROUnOOIqXnXh4V0xwolocq
	YnUZmBMnBYefnQ0zAyCGVODakuDXaJQAQqPquo1oqgffBVYobvemLKpP
X-Gm-Gg: AYBFou3++s06mJ0YzcIgEE8UwgqDHAiJddYxp56Mj+JIak4WoLe8P92lcdsAKzzWuhG
	IQCQWvVSh52vdVbfDotXve2BP31ks42UIRi3JDUtdgFc9oqjIvmeERT2RIOxrUugf/Ek4VVoCpP
	UR/qzVovswz6wPYKQMPk6ENqBPxESy7X8ZqECRDV6bbVBt5edCUPkI7q/bYTDPuF/zVlUiqGW+Z
	3VCZ5WYS9bjjMN7paBMaJBCJLDJ/YwRIhRlh5rcqS97grX7b8F9atAZylqP6DuppwqV2a+S9JoN
	728BDxwasmKRg0Mol/PT7XKBQt10NndJlBL1cmoPTX0hn2YgNtahJDdko41bA080bFhQPFa2YzF
	LmhOJ2Irg12jhLn2Fsqj1ZJtgK43HApNQY+bnNrFiYjyZKXJmHCEEKIjlplMcn8f3aXFse91Yf2
	tIUebpADs6eSbEjKY6RmgxhKcZrY3ewmC5i/q79Lt/vZyMQ7l8YJHPWJI4DiCXGsCrIkQpXp9t6
	iQzyUBU/P0g2gV4nXfDt0qR/WesMSn6HGSx2GfbDuH0sWd9QCY4Oq7UqQxoAAghik5ECIp5zVZt
	WfQvRdJ3QLhbr0OQ5ObtVDUqohQ9FNkYyNmeDngG7A==
X-Received: by 2002:a05:690e:4146:b0:67c:1dca:7e0 with SMTP id 956f58d0204a3-67d8935088cmr2674682d50.14.1794611347778;
        Fri, 13 Nov 2026 15:09:07 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a59e70asm3307552d50.10.2026.11.13.15.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:09:07 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:35 -0800
Subject: [PATCH RFC bpf-next 12/13] selftests/bpf: Test BPF_F_INLINE_VALUE
 local storage maps
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-sls_f1-v1-12-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=23212;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=+Pip1cYgEE5TNSVK5KPNsxYV0R0zXa30CqIm5fDU0b4=;
 b=8AoVptu7knm0ToFO31/3NpXEtyeIGCUM3g7oDrdC4Qw4JSpGUOBPsNAAi1JPkVjWNbwWO2ZSw
 WH/2nn8IQehA9ekxQq3ozdx0obsk/P2P5MaUMEkOU3zNBTqMJRV33Uu
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Inline maps keep values in a slot of the storage object and have new
limits. Make sure that they behave as normal maps and that the limits
hold.

Test that sk and task values in the slot are the same through the
syscall and a program, also after a delete in a program. The program
records where each value is, so the test proves that the slot path runs.
Test the map limits and errors: -E2BIG for a value that never fits, also
through libbpf, -ENOSPC for a full area and after 16 maps, and the undo
of a slot claim. Test the fallback for an object with no room for the
slot. Test that a new map at the offset of a freed map sees no old value.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../bpf/prog_tests/local_storage_inline.c          | 591 +++++++++++++++++++++
 .../selftests/bpf/progs/local_storage_inline.c     | 123 +++++
 2 files changed, 714 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/local_storage_inline.c b/tools/testing/selftests/bpf/prog_tests/local_storage_inline.c
new file mode 100644
index 000000000000..1ff830474142
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/local_storage_inline.c
@@ -0,0 +1,591 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <fcntl.h>
+#include <netinet/in.h>
+#include <pthread.h>
+#include <sys/socket.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "task_local_storage_helpers.h"
+
+/* The same as in progs/local_storage_inline.c */
+#define LS_VAL_WORDS	4
+#define NR_MAPS		4
+
+struct ls_val {
+	__u64 w[LS_VAL_WORDS];
+};
+
+#include "local_storage_inline.skel.h"
+
+#ifndef PIDFD_THREAD
+#define PIDFD_THREAD	O_EXCL
+#endif
+
+#define INLINE_FLAGS	(BPF_F_NO_PREALLOC | BPF_F_INLINE_VALUE)
+/* All inline maps of one owner type share an area that ends at 1 KB */
+#define AREA_END	1024
+#define MAX_INLINE_MAPS	16
+#define NR_SOCKS	2
+/*
+ * Map free is deferred: the slot of a closed map can stay taken for a time.
+ * All waits share one time budget, so that the test fails fast after the
+ * first timeout.
+ */
+#define WAIT_BUDGET_NS	(30ULL * 1000 * 1000 * 1000)
+#define WAIT_US		10000
+
+static __u64 wait_end;
+
+/* Sleep a little and return true, or return false if the budget is spent */
+static bool wait_more(void)
+{
+	if (get_time_ns() >= wait_end)
+		return false;
+	usleep(WAIT_US);
+	return true;
+}
+
+/* A create that must fail with err. Close the map if it worked */
+static void assert_err(int fd, int err, const char *name)
+{
+	if (!ASSERT_EQ(fd, err, name) && fd >= 0)
+		close(fd);
+}
+
+/* A create that must work. The test needs only the result */
+static void assert_fd_close(int fd, const char *name)
+{
+	if (ASSERT_OK_FD(fd, name))
+		close(fd);
+}
+
+static void close_fds(const int *fds, int n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		if (fds[i] >= 0)
+			close(fds[i]);
+}
+
+struct socks {
+	int fd[NR_SOCKS];
+	bool ok;	/* All sockets are open */
+};
+
+static struct socks open_socks(void)
+{
+	struct socks s = { .ok = true };
+	int i;
+
+	for (i = 0; i < NR_SOCKS; i++) {
+		s.fd[i] = socket(AF_INET, SOCK_STREAM, 0);
+		if (!ASSERT_OK_FD(s.fd[i], "socket"))
+			s.ok = false;
+	}
+	return s;
+}
+
+/* BTF with an int key (id 1) and, as the last type, a value of value_size bytes */
+static struct btf *load_btf(__u32 value_size)
+{
+	struct btf *btf;
+
+	btf = btf__new_empty();
+	if (!btf)
+		return NULL;
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	btf__add_int(btf, "char", 1, 0);
+	btf__add_array(btf, 1, 2, value_size);
+	if (btf__load_into_kernel(btf)) {
+		btf__free(btf);
+		return NULL;
+	}
+	return btf;
+}
+
+static int map_create_btf(struct btf *btf, enum bpf_map_type type, __u32 flags,
+			  __u32 value_size)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = flags,
+		    .btf_fd = btf__fd(btf), .btf_key_type_id = 1,
+		    .btf_value_type_id = btf__type_cnt(btf) - 1);
+
+	return bpf_map_create(type, "ls_inline", sizeof(int), value_size, 0, &opts);
+}
+
+/* Make a local storage map with an int key */
+static int create_map(enum bpf_map_type type, __u32 flags, __u32 value_size)
+{
+	struct btf *btf = load_btf(value_size);
+	int fd;
+
+	if (!ASSERT_OK_PTR(btf, "load_btf"))
+		return -ENOMEM;
+	fd = map_create_btf(btf, type, flags, value_size);
+	btf__free(btf);
+	return fd;
+}
+
+/* An inline map. Retry while the slots of closed maps are not free */
+static int create_inline(enum bpf_map_type type, __u32 value_size)
+{
+	struct btf *btf = load_btf(value_size);
+	int fd;
+
+	if (!ASSERT_OK_PTR(btf, "load_btf"))
+		return -ENOMEM;
+	do {
+		fd = map_create_btf(btf, type, INLINE_FLAGS, value_size);
+	} while (fd == -ENOSPC && wait_more());
+	btf__free(btf);
+	return fd;
+}
+
+/*
+ * The largest inline value. The area starts after struct bpf_local_storage,
+ * aligned to 8 B. A slot is an 8 B tag and the value, aligned to 8 B.
+ */
+static int read_value_max(void)
+{
+	const struct btf_type *t;
+	struct btf *btf;
+	int id, max = -1;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return -1;
+	id = btf__find_by_name_kind(btf, "bpf_local_storage", BTF_KIND_STRUCT);
+	if (id > 0) {
+		t = btf__type_by_id(btf, id);
+		max = AREA_END - (t->size + 7) / 8 * 8 - 8;
+	}
+	btf__free(btf);
+	return max;
+}
+
+static void fill_val(struct ls_val *v, __u64 first)
+{
+	int i;
+
+	for (i = 0; i < LS_VAL_WORDS; i++)
+		v->w[i] = first + i;
+}
+
+/* Run the program on sk and on the current task. Return the number of NULL gets */
+static int run_prog(struct local_storage_inline *skel, int sk, __u64 get_flags)
+{
+	socklen_t len = sizeof(int);
+	int ttl;
+
+	skel->bss->get_flags = get_flags;
+	skel->bss->nr_null = 0;
+	ASSERT_OK(getsockopt(sk, SOL_IP, IP_TTL, &ttl, &len), "getsockopt");
+	return skel->bss->nr_null;
+}
+
+/* The value that get i saw is in the storage object of its owner: a slot */
+static bool in_obj(struct local_storage_inline *skel, int i)
+{
+	__u64 off = skel->bss->val_addr[i] - skel->bss->obj_addr[i];
+
+	return skel->bss->obj_addr[i] && off < skel->bss->obj_size[i];
+}
+
+/* The program and the syscall must see the same value */
+static void check_values(struct local_storage_inline *skel, const int *fds,
+			 const int *keys, const struct ls_val *v)
+{
+	struct ls_val out;
+	int i;
+
+	for (i = 0; i < NR_MAPS; i++) {
+		ASSERT_MEMEQ(&skel->bss->seen_val[i], v, sizeof(*v), "seen");
+		ASSERT_OK(bpf_map_lookup_elem(fds[i], &keys[i], &out), "lookup");
+		ASSERT_MEMEQ(&out, v, sizeof(*v), "lookup value");
+	}
+}
+
+enum { OP_UPDATE, OP_DELETE, OP_LOOKUP };
+
+/* All maps get the same ops: an inline map must give the codes of a normal map */
+static void check_ops(int fd, int key)
+{
+	static const struct {
+		int op;
+		__u64 flags;
+		int ret;
+	} ops[] = {
+		{ OP_DELETE, 0, 0 },
+		{ OP_DELETE, 0, -ENOENT },
+		{ OP_LOOKUP, 0, -ENOENT },
+		{ OP_UPDATE, BPF_EXIST, -ENOENT },
+		{ OP_UPDATE, BPF_NOEXIST, 0 },
+		{ OP_UPDATE, BPF_NOEXIST, -EEXIST },
+		{ OP_UPDATE, BPF_F_LOCK, -EINVAL },
+		{ OP_UPDATE, BPF_ANY, 0 },
+		{ OP_DELETE, 0, 0 },
+		{ OP_UPDATE, BPF_ANY, 0 },
+		{ OP_UPDATE, BPF_EXIST, 0 },
+		{ OP_LOOKUP, 0, 0 },
+	};
+	struct ls_val v, out;
+	char name[16];
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(ops); i++) {
+		fill_val(&v, 0x4000 + i * 0x10);
+		if (ops[i].op == OP_UPDATE)
+			ret = bpf_map_update_elem(fd, &key, &v, ops[i].flags);
+		else if (ops[i].op == OP_DELETE)
+			ret = bpf_map_delete_elem(fd, &key);
+		else
+			ret = bpf_map_lookup_elem(fd, &key, &out);
+		snprintf(name, sizeof(name), "op %d", i);
+		ASSERT_EQ(ret, ops[i].ret, name);
+	}
+	/* The last op reads the value of the update before it */
+	fill_val(&v, 0x4000 + (i - 2) * 0x10);
+	ASSERT_MEMEQ(&out, &v, sizeof(v), "last value");
+}
+
+/* Runs in a new thread: the task is the owner of the task values */
+static void test_values(int max)
+{
+	struct local_storage_inline *skel;
+	int fds[NR_MAPS], keys[NR_MAPS], i, j, sk = -1, pidfd = -1;
+	struct ls_val v, zero = {};
+
+	skel = local_storage_inline__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+	if (!ASSERT_OK(bpf_map__set_map_flags(skel->maps.sk_inline, INLINE_FLAGS), "flags") ||
+	    !ASSERT_OK(bpf_map__set_map_flags(skel->maps.task_inline, INLINE_FLAGS), "flags") ||
+	    !ASSERT_OK(local_storage_inline__load(skel), "skel load") ||
+	    !ASSERT_OK(local_storage_inline__attach(skel), "attach"))
+		goto out;
+	sk = socket(AF_INET, SOCK_STREAM, 0);
+	pidfd = sys_pidfd_open(sys_gettid(), PIDFD_THREAD);
+	if (!ASSERT_OK_FD(sk, "socket") || !ASSERT_OK_FD(pidfd, "pidfd"))
+		goto out;
+
+	/* The order of the maps in the program */
+	fds[0] = bpf_map__fd(skel->maps.sk_inline);
+	fds[1] = bpf_map__fd(skel->maps.sk_normal);
+	fds[2] = bpf_map__fd(skel->maps.task_inline);
+	fds[3] = bpf_map__fd(skel->maps.task_normal);
+	for (i = 0; i < NR_MAPS; i++)
+		keys[i] = i < 2 ? sk : pidfd;
+	skel->bss->target_tid = sys_gettid();
+
+	fill_val(&skel->bss->init_val, 0x1000);
+	skel->bss->use_init = true;
+	ASSERT_EQ(run_prog(skel, sk, BPF_LOCAL_STORAGE_GET_F_CREATE), 0,
+		  "create with init");
+	check_values(skel, fds, keys, &skel->bss->init_val);
+	/* The program finds inline values in a slot, normal values elsewhere */
+	for (i = 0; i < NR_MAPS; i++)
+		ASSERT_EQ(in_obj(skel, i), !(i & 1), "value in object");
+
+	fill_val(&v, 0x2000);
+	for (i = 0; i < NR_MAPS; i++)
+		ASSERT_OK(bpf_map_update_elem(fds[i], &keys[i], &v, BPF_EXIST), "update");
+	skel->bss->val_add = 0x100;
+	ASSERT_EQ(run_prog(skel, sk, 0), 0, "get");
+	fill_val(&v, 0x2100);
+	check_values(skel, fds, keys, &v);
+
+	/* A slot keeps its bytes after a delete, but they must not show */
+	for (i = 0; i < NR_MAPS; i++)
+		ASSERT_OK(bpf_map_delete_elem(fds[i], &keys[i]), "delete");
+	ASSERT_EQ(run_prog(skel, sk, 0), NR_MAPS, "get after delete");
+	skel->bss->use_init = false;
+	skel->bss->val_add = 0;
+	ASSERT_EQ(run_prog(skel, sk, BPF_LOCAL_STORAGE_GET_F_CREATE), 0, "create");
+	check_values(skel, fds, keys, &zero);
+
+	/* A delete in the program must give the codes of a normal map too */
+	skel->bss->do_delete = true;
+	for (i = 0; i < 2; i++) {
+		run_prog(skel, sk, 0);
+		for (j = 0; j < NR_MAPS; j++)
+			ASSERT_EQ(skel->bss->del_ret[j], i ? -ENOENT : 0, "prog delete");
+	}
+	skel->bss->do_delete = false;
+	ASSERT_EQ(run_prog(skel, sk, BPF_LOCAL_STORAGE_GET_F_CREATE), 0, "create again");
+
+	skel->bss->target_tid = 0;
+	for (i = 0; i < NR_MAPS; i++)
+		check_ops(fds[i], keys[i]);
+out:
+	if (sk >= 0)
+		close(sk);
+	if (pidfd >= 0)
+		close(pidfd);
+	local_storage_inline__destroy(skel);
+}
+
+/*
+ * A value that never fits gets -E2BIG at once, with no retry. The biggest
+ * value takes the full area: retry until the maps of earlier subtests are
+ * freed.
+ */
+static void check_biggest(int max)
+{
+	int big;
+
+	assert_err(create_map(BPF_MAP_TYPE_TASK_STORAGE, INLINE_FLAGS, max + 1),
+		   -E2BIG, "value too big");
+	big = create_inline(BPF_MAP_TYPE_TASK_STORAGE, max);
+	if (!ASSERT_OK_FD(big, "biggest value"))
+		return;
+	/* No room now: the biggest value takes the full area */
+	assert_err(create_map(BPF_MAP_TYPE_TASK_STORAGE, INLINE_FLAGS, 8),
+		   -ENOSPC, "no room now");
+	close(big);
+	assert_fd_close(create_inline(BPF_MAP_TYPE_TASK_STORAGE, 8), "room after free");
+}
+
+static const char excl_hash[32];
+
+/* A create that fails after the slot claim gives the slot back */
+static void check_claim_undo(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = INLINE_FLAGS,
+		    .btf_key_type_id = 1, .excl_prog_hash = excl_hash,
+		    .excl_prog_hash_size = 1);
+	struct btf *btf = load_btf(8);
+	int i, fd = -EINVAL;
+
+	if (!ASSERT_OK_PTR(btf, "load_btf"))
+		return;
+	opts.btf_fd = btf__fd(btf);
+	opts.btf_value_type_id = btf__type_cnt(btf) - 1;
+	/* More failures than table entries: each must give its entry back */
+	for (i = 0; i <= MAX_INLINE_MAPS && fd == -EINVAL; i++)
+		fd = bpf_map_create(BPF_MAP_TYPE_TASK_STORAGE, "ls_inline",
+				    sizeof(int), 8, 0, &opts);
+	assert_err(fd, -EINVAL, "bad excl_prog_hash_size");
+	btf__free(btf);
+}
+
+/* libbpf gives the error of the kernel, not -EINVAL of a retry without BTF */
+static void check_load_err(int max)
+{
+	struct local_storage_inline *skel;
+
+	skel = local_storage_inline__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return;
+	if (ASSERT_OK(bpf_map__set_map_flags(skel->maps.task_inline, INLINE_FLAGS), "flags") &&
+	    ASSERT_OK(bpf_map__set_value_size(skel->maps.task_inline, max + 1), "value size"))
+		ASSERT_EQ(local_storage_inline__load(skel), -E2BIG, "skeleton load");
+	local_storage_inline__destroy(skel);
+}
+
+static void test_limits(int max)
+{
+	int fds[MAX_INLINE_MAPS], i;
+
+	check_biggest(max);
+	check_load_err(max);
+
+	for (i = 0; i < MAX_INLINE_MAPS; i++) {
+		fds[i] = create_inline(BPF_MAP_TYPE_TASK_STORAGE, 8);
+		if (!ASSERT_OK_FD(fds[i], "inline map"))
+			break;
+		/* The first map proves room: the failed creates need no retry */
+		if (!i)
+			check_claim_undo();
+	}
+	if (i == MAX_INLINE_MAPS) {
+		/* The area has room, but the owner type has 16 inline maps */
+		assert_err(create_map(BPF_MAP_TYPE_TASK_STORAGE, INLINE_FLAGS, 8),
+			   -ENOSPC, "too many maps");
+		/* Each owner type has its own limit */
+		assert_fd_close(create_inline(BPF_MAP_TYPE_SK_STORAGE, 8),
+				"other owner type");
+	}
+	close_fds(fds, i);
+}
+
+/* Load the program with map_fd in place of sk_reuse, and attach it */
+static struct local_storage_inline *load_reuse(int map_fd)
+{
+	struct local_storage_inline *skel;
+
+	skel = local_storage_inline__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		return NULL;
+	if (!ASSERT_OK(bpf_map__reuse_fd(skel->maps.sk_reuse, map_fd), "reuse_fd") ||
+	    !ASSERT_OK(local_storage_inline__load(skel), "skel load") ||
+	    !ASSERT_OK(local_storage_inline__attach(skel), "attach")) {
+		local_storage_inline__destroy(skel);
+		return NULL;
+	}
+	skel->bss->target_tid = sys_gettid();
+	skel->bss->reuse_test = true;
+	return skel;
+}
+
+static void test_fallback(int max)
+{
+	struct socks s = open_socks();
+	struct local_storage_inline *skel;
+	int normal, map = -1, i;
+	char val[AREA_END], out[AREA_END];
+
+	normal = create_map(BPF_MAP_TYPE_SK_STORAGE, BPF_F_NO_PREALLOC, 4);
+	if (!s.ok || !ASSERT_OK_FD(normal, "normal map"))
+		goto out;
+
+	/* sk 0 gets its storage before the inline map exists, sk 1 after */
+	ASSERT_OK(bpf_map_update_elem(normal, &s.fd[0], &s.fd[0], 0), "normal update");
+	/* The slot takes the full area, so the storage of sk 0 has no room */
+	map = create_inline(BPF_MAP_TYPE_SK_STORAGE, max);
+	if (!ASSERT_OK_FD(map, "inline map"))
+		goto out;
+
+	for (i = 0; i < 2; i++) {
+		memset(val, 0x5a + i, max);
+		ASSERT_OK(bpf_map_update_elem(map, &s.fd[i], val, BPF_NOEXIST), "update");
+	}
+	/* sk 0 keeps the value in a normal element, sk 1 in the slot */
+	skel = load_reuse(map);
+	for (i = 0; skel && i < 2; i++) {
+		ASSERT_EQ(run_prog(skel, s.fd[i], 0), 0, "prog get");
+		ASSERT_EQ(in_obj(skel, 0), i, "value in object");
+	}
+	local_storage_inline__destroy(skel);
+	for (i = 0; i < 2; i++) {
+		memset(val, 0x5a + i, max);
+		ASSERT_OK(bpf_map_lookup_elem(map, &s.fd[i], out), "lookup");
+		ASSERT_MEMEQ(out, val, max, "lookup value");
+		ASSERT_OK(bpf_map_delete_elem(map, &s.fd[i]), "delete");
+	}
+	ASSERT_OK(bpf_map_lookup_elem(normal, &s.fd[0], out), "normal lookup");
+	ASSERT_EQ(*(int *)out, s.fd[0], "normal value");
+out:
+	close_fds(s.fd, NR_SOCKS);
+	if (normal >= 0)
+		close(normal);
+	if (map >= 0)
+		close(map);
+}
+
+/*
+ * Map B gets the slot of the freed map A in a live object. The old tag and
+ * value bytes of A must not show as a value of B.
+ */
+static void test_reuse(int max)
+{
+	struct local_storage_inline *skel = NULL;
+	struct socks s = open_socks();
+	int a, b = -1, i;
+	char val[AREA_END], out[AREA_END];
+	struct ls_val zero = {};
+
+	if (!s.ok)
+		goto out;
+	/* The biggest value: the slot of A and of B starts at the area start */
+	a = create_inline(BPF_MAP_TYPE_SK_STORAGE, max);
+	if (!ASSERT_OK_FD(a, "map A"))
+		goto out;
+	memset(val, 0x5a, max);
+	for (i = 0; i < 2; i++)
+		ASSERT_OK(bpf_map_update_elem(a, &s.fd[i], val, BPF_NOEXIST), "update A");
+	close(a);
+
+	/* B gets room only after the deferred free of A, with a new tag */
+	b = create_inline(BPF_MAP_TYPE_SK_STORAGE, max);
+	if (!ASSERT_OK_FD(b, "map B"))
+		goto out;
+	for (i = 0; i < 2; i++)
+		ASSERT_EQ(bpf_map_lookup_elem(b, &s.fd[i], out), -ENOENT, "lookup B");
+
+	memset(val, 0xa5, max);
+	ASSERT_OK(bpf_map_update_elem(b, &s.fd[0], val, BPF_NOEXIST), "syscall create");
+	ASSERT_OK(bpf_map_lookup_elem(b, &s.fd[0], out), "lookup syscall value");
+	ASSERT_MEMEQ(out, val, max, "syscall value");
+
+	skel = load_reuse(b);
+	if (!skel)
+		goto out;
+	ASSERT_EQ(run_prog(skel, s.fd[1], BPF_LOCAL_STORAGE_GET_F_CREATE), 0,
+		  "prog create");
+	ASSERT_MEMEQ(&skel->bss->seen_val[0], &zero, sizeof(zero), "prog value");
+	memset(val, 0, max);
+	ASSERT_OK(bpf_map_lookup_elem(b, &s.fd[1], out), "lookup prog value");
+	ASSERT_MEMEQ(out, val, max, "prog value zero");
+out:
+	local_storage_inline__destroy(skel);
+	close_fds(s.fd, NR_SOCKS);
+	if (b >= 0)
+		close(b);
+}
+
+struct subtest {
+	const char *name;
+	void (*fn)(int max);
+	bool thread;	/* Task storage: a new task has a new storage object */
+};
+
+struct thread_arg {
+	const struct subtest *t;
+	int max;
+};
+
+static void *subtest_thread(void *arg)
+{
+	struct thread_arg *a = arg;
+
+	a->t->fn(a->max);
+	return NULL;
+}
+
+static void run_subtest(const struct subtest *t, int max)
+{
+	struct thread_arg a = { t, max };
+	pthread_t thread;
+
+	if (!t->thread) {
+		t->fn(max);
+		return;
+	}
+	if (ASSERT_OK(pthread_create(&thread, NULL, subtest_thread, &a), "pthread_create"))
+		pthread_join(thread, NULL);
+}
+
+/* Serial: all inline maps of an owner type share one area and one limit */
+void serial_test_local_storage_inline(void)
+{
+	static const struct subtest tests[] = {
+		{ "values", test_values, true },
+		{ "limits", test_limits },
+		{ "fallback", test_fallback },
+		{ "reuse", test_reuse },
+	};
+	int fd, i, max;
+
+	wait_end = get_time_ns() + WAIT_BUDGET_NS;
+	assert_fd_close(create_map(BPF_MAP_TYPE_SK_STORAGE, BPF_F_NO_PREALLOC, 8),
+			"normal map");
+	/* 32-bit kernels refuse the flag */
+	fd = create_inline(BPF_MAP_TYPE_SK_STORAGE, 8);
+	if (fd == -EOPNOTSUPP) {
+		test__skip();
+		return;
+	}
+	assert_fd_close(fd, "inline map");
+	max = read_value_max();
+	if (!ASSERT_GT(max, 0, "inline value max"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!test__start_subtest(tests[i].name))
+			continue;
+		run_subtest(&tests[i], max);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/local_storage_inline.c b/tools/testing/selftests/bpf/progs/local_storage_inline.c
new file mode 100644
index 000000000000..aef16b6947ec
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/local_storage_inline.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define LS_VAL_WORDS	4
+/* Maps that getsockopt_enter gets values from */
+#define NR_MAPS		4
+
+struct ls_val {
+	__u64 w[LS_VAL_WORDS];
+};
+
+/* User space sets BPF_F_INLINE_VALUE on the *_inline maps before load */
+#define STORAGE_MAP(name, map_type)				\
+	struct {						\
+		__uint(type, map_type);				\
+		__uint(map_flags, BPF_F_NO_PREALLOC);		\
+		__type(key, int);				\
+		__type(value, struct ls_val);			\
+	} name SEC(".maps")
+
+STORAGE_MAP(sk_inline, BPF_MAP_TYPE_SK_STORAGE);
+STORAGE_MAP(sk_normal, BPF_MAP_TYPE_SK_STORAGE);
+STORAGE_MAP(task_inline, BPF_MAP_TYPE_TASK_STORAGE);
+STORAGE_MAP(task_normal, BPF_MAP_TYPE_TASK_STORAGE);
+/* User space can replace it with a map of a bigger value */
+STORAGE_MAP(sk_reuse, BPF_MAP_TYPE_SK_STORAGE);
+
+int target_tid;
+__u64 get_flags;
+bool use_init;
+__u64 val_add;
+struct ls_val init_val;
+/* The value that each get saw, in the order of the maps above */
+struct ls_val seen_val[NR_MAPS];
+int nr_null;
+bool reuse_test;
+bool do_delete;
+/* The return code of each delete, in the order of the maps above */
+int del_ret[NR_MAPS];
+/*
+ * Where each value is: its address, and the address and size of the
+ * storage object of its owner. User space checks if the value is in it.
+ */
+__u64 val_addr[NR_MAPS];
+__u64 obj_addr[NR_MAPS];
+__u32 obj_size[NR_MAPS];
+
+static __always_inline void record(struct ls_val *v, int i,
+				   struct bpf_local_storage *obj)
+{
+	int j;
+
+	if (!v) {
+		nr_null++;
+		return;
+	}
+	val_addr[i] = (__u64)v;
+	obj_addr[i] = (__u64)obj;
+	obj_size[i] = obj ? obj->obj_size : 0;
+	/* Write, so that user space sees that the program found the value */
+	for (j = 0; j < LS_VAL_WORDS; j++)
+		v->w[j] += val_add;
+	seen_val[i] = *v;
+}
+
+/*
+ * Get first, then read the storage pointer of the owner: the get can make
+ * the storage object.
+ */
+static __always_inline void record_sk(void *map, struct sock *sk, void *v, int i)
+{
+	v = bpf_sk_storage_get(map, sk, v, get_flags);
+	record(v, i, sk->sk_bpf_storage);
+}
+
+static __always_inline void record_task(void *map, struct task_struct *task,
+					void *v, int i)
+{
+	v = bpf_task_storage_get(map, task, v, get_flags);
+	record(v, i, task->bpf_storage);
+}
+
+static __always_inline bool is_target(void)
+{
+	return (__u32)bpf_get_current_pid_tgid() == target_tid;
+}
+
+/* getsockopt(SOL_IP) on a TCP socket gives the socket and the task */
+SEC("fentry/sock_common_getsockopt")
+int BPF_PROG(getsockopt_enter, struct socket *sock)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct sock *sk = sock->sk;
+	void *v;
+
+	if (!is_target() || !sk)
+		return 0;
+
+	if (reuse_test) {
+		/* The value of sk_reuse can be bigger than init_val: no init */
+		record_sk(&sk_reuse, sk, NULL, 0);
+		return 0;
+	}
+
+	v = use_init ? &init_val : NULL;
+	record_sk(&sk_inline, sk, v, 0);
+	record_sk(&sk_normal, sk, v, 1);
+	record_task(&task_inline, task, v, 2);
+	record_task(&task_normal, task, v, 3);
+	if (do_delete) {
+		del_ret[0] = bpf_sk_storage_delete(&sk_inline, sk);
+		del_ret[1] = bpf_sk_storage_delete(&sk_normal, sk);
+		del_ret[2] = bpf_task_storage_delete(&task_inline, task);
+		del_ret[3] = bpf_task_storage_delete(&task_normal, task);
+	}
+	return 0;
+}

-- 
2.53.1-Meta

