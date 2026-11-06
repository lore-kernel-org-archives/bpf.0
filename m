Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959133;
	b=z+yktFF+YvPSkKbHAxRMqJaeiqD0b/qgHAKur7DQOrDMRdvNXiOMW4kcAcW5ri0ljAoM
	 R2CP30bGuInqzgtlrT+v3TkLATs7q0ZhxRr761TIf539N3bkA1oJ2Zn9GXwLXakzf+rPv
	 fD1bHDAck2EkmgmXe2bLvruvdk1pLfjqC/YTA+SXwELIRH6fz7NPATqnNUvMqAKhDzkjh
	 +1kfGarpEi3P23yjM5QKRy0NNdv/V1a/1oJKqCrwFrCD3w3Ni0gv5QmnnS6kLAZyCCfWc
	 U9a7FIWtw435bytLOgHzhDFfgDgP2+vGe34guRJczhjnfq9gu+FYesL6cnPWunzWVAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959133;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ALkRGfSKNtqtdsrk2ozGeSX87ptSZKuyWog86n/J+yc=;
	b=YSWKGBa1XLM1iRcz909ZHS/CLSoHUypysClK9/jMNyLioylEa+rObk7Tsoao72NicFEC
	 hwablZhvBNi0eMLjxh0sEhreBu2CL4A9OIpn0D6Ec9iP8jKkl5Sgu5/Vhj6gwTgyYBbT2
	 gAhxMa8nsvSKdNzMGWjHF8drXdmlSg0LvE1CjN9IwU++1qTpTQgia5sLQFnkOF+hWKobw
	 m3PIFBVkFoGY2jM4ckZJk6lvFsapm8xeYSQvSJT3qwXu2APAcidFxPNrT2DUE+5yleLXB
	 jwpr65KoNUOlh727eqoBpJ2+xiZUuTdENw+xwyIlc7ZKpn0SuXslNLZWvi1Ug7rkQYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ft8gUfXZ;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903C606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D903C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ft8gUfXZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=AL
	kRGfSKNtqtdsrk2ozGeSX87ptSZKuyWog86n/J+yc=; b=ft8gUfXZlERSh4e+1z
	97NCTGEqdzLzxOryxZRunZtvl1UiOPgVumu9vZlPK7P7pvQcZ7O3T2auiBnPLXOZ
	mJRnlxxi0ius23SVDwzQxwZOZxxJaOBUn49iZ+JduxJJBCYQtMdzzLJxsIA73biP
	ug6vs8p56uAzeoDSzi6IL4ftQ=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3JjikpO1qsU61Fg--.28308S10;
	Fri, 06 Nov 2026 17:58:02 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: Check bpf_timer value membership
Date: Fri,  6 Nov 2026 17:57:47 +0800
Message-ID: <20261106095747.471718-9-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106095747.471718-1-luyun_611@163.com>
References: <20261106095747.471718-1-luyun_611@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3JjikpO1qsU61Fg--.28308S10
X-Coremail-Antispam: 1Uf129KBjvJXoWfGFyDZr43KrWfGr17Kr1rZwb_yoWkGw47pa
	ykWrW3Kr1UXa1xtr4Iy3yxWFyavw4Fqw17GFZ0ga4fArn7AF93JF18K3WUtFnxu398Wa4f
	AayFga13A3y8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQTmDUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AppOGrtpKrC6AAA3U

From: Yun Lu <luyun@kylinos.cn>

Add seven subtests to distinguish removed-value rejection from normal
bpf_timer operation: delete from HASH with and without preallocation,
RHASH and LRU HASH; replace a HASH element; and run live HASH/ARRAY timers.

Delete or replace the element while retaining its old value pointer in
the same read-side section, then require init through that pointer to
return -ENOENT. Stop after recording the stale init result even if an
unfixed kernel returns success; do not configure or arm that object.

For replacement, assert that the old and new addresses differ and verify
a callback from the new member. The two live cases also initialize, set
and arm a timer, then wait for an actual callback. This checks that the
new rejection path leaves linked values usable.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 .../bpf/prog_tests/bpf_timer_membership.c     | 199 ++++++++++++++++++
 .../bpf/progs/bpf_timer_membership.c          | 161 ++++++++++++++
 2 files changed, 360 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_timer_membership.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_timer_membership.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_timer_membership.c b/tools/testing/selftests/bpf/prog_tests/bpf_timer_membership.c
new file mode 100644
index 000000000000..b0b880ba71a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_timer_membership.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Corporation. */
+
+/* Five stale-init cases and two live callback cases. */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+#include "bpf_timer_membership.skel.h"
+
+#define CB_SLOTS 64
+#define CB_WAIT_ITERS 3000
+
+enum {
+	CMD_INIT_START = 1,
+	CMD_DELETE_INIT,
+	CMD_REPLACE_INIT,
+};
+
+struct timer_case {
+	struct bpf_timer_membership *skel;
+	struct bpf_map *map;
+	struct bpf_program *prog;
+	bool array;
+	int fd;
+};
+
+static struct timer_case open_case(enum bpf_map_type type, __u32 flags)
+{
+	struct timer_case c = {};
+	int err;
+
+	c.skel = bpf_timer_membership__open();
+	if (!ASSERT_OK_PTR(c.skel, "open"))
+		return c;
+	c.map = c.skel->maps.values;
+	c.prog = c.skel->progs.values_run;
+	c.array = type == BPF_MAP_TYPE_ARRAY;
+	err = bpf_map__set_type(c.map, type);
+	if (!ASSERT_OK(err, "set_type"))
+		goto fail;
+	err = bpf_map__set_map_flags(c.map, flags);
+	if (!ASSERT_OK(err, "set_flags"))
+		goto fail;
+	err = bpf_timer_membership__load(c.skel);
+	if (!ASSERT_OK(err, "load"))
+		goto fail;
+	c.fd = bpf_map__fd(c.map);
+	if (!ASSERT_GE(c.fd, 0, "map_fd"))
+		goto fail;
+	return c;
+fail:
+	bpf_timer_membership__destroy(c.skel);
+	c.skel = NULL;
+	return c;
+}
+
+static int run_cmd(struct timer_case *c, u32 cmd, u64 cookie)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	c->skel->bss->cmd = cmd;
+	c->skel->bss->cookie = cookie;
+	err = bpf_prog_test_run_opts(bpf_program__fd(c->prog), &opts);
+	if (!ASSERT_OK(err, "test_run"))
+		return err;
+	if (!ASSERT_OK((int)opts.retval, "prog_retval"))
+		return -EINVAL;
+	return 0;
+}
+
+static u64 cb_count(struct timer_case *c, u64 cookie)
+{
+	return __atomic_load_n(&c->skel->bss->cb_count[cookie & (CB_SLOTS - 1)],
+			       __ATOMIC_ACQUIRE);
+}
+
+static bool wait_cb(struct timer_case *c, u64 cookie, u64 want)
+{
+	int i;
+
+	for (i = 0; i < CB_WAIT_ITERS; i++) {
+		if (cb_count(c, cookie) >= want)
+			return ASSERT_EQ(cb_count(c, cookie), want, "callback_count");
+		usleep(1000);
+	}
+	return ASSERT_EQ(cb_count(c, cookie), want, "callback_timeout");
+}
+
+static bool seed(struct timer_case *c)
+{
+	size_t size = bpf_map__value_size(c->map);
+	void *val = calloc(1, size);
+	int key = 0, err;
+
+	if (!ASSERT_OK_PTR(val, "calloc"))
+		return false;
+	err = bpf_map_update_elem(c->fd, &key, val, BPF_ANY);
+	free(val);
+	return ASSERT_OK(err, "insert");
+}
+
+static void drop_elem(struct timer_case *c)
+{
+	int key = 0;
+
+	if (c->array)
+		return;
+	bpf_map_delete_elem(c->fd, &key);
+}
+
+static bool check_init_start(struct timer_case *c)
+{
+	return ASSERT_OK(c->skel->bss->res_lookup_err, "lookup_err") &&
+	       ASSERT_OK(c->skel->bss->res_init_err, "init_err") &&
+	       ASSERT_OK(c->skel->bss->res_set_err, "set_err") &&
+	       ASSERT_OK(c->skel->bss->res_start_err, "start_err");
+}
+
+static void subtest_live(enum bpf_map_type type, __u32 flags)
+{
+	struct timer_case c = open_case(type, flags);
+
+	if (!c.skel)
+		return;
+	if (!seed(&c))
+		goto out;
+	if (run_cmd(&c, CMD_INIT_START, 1))
+		goto out;
+	if (!check_init_start(&c))
+		goto out;
+	wait_cb(&c, 1, 1);
+out:
+	drop_elem(&c);
+	bpf_timer_membership__destroy(c.skel);
+}
+
+static void subtest_delete(enum bpf_map_type type, __u32 flags)
+{
+	struct timer_case c = open_case(type, flags);
+
+	if (!c.skel)
+		return;
+	if (!seed(&c))
+		goto out;
+	if (run_cmd(&c, CMD_DELETE_INIT, 1))
+		goto out;
+	ASSERT_OK(c.skel->bss->res_lookup_err, "lookup_err");
+	ASSERT_OK(c.skel->bss->res_delete_err, "delete_err");
+	ASSERT_EQ(c.skel->bss->res_init_err, -ENOENT, "init_err");
+	ASSERT_EQ(cb_count(&c, 1), 0, "no_callback");
+out:
+	bpf_timer_membership__destroy(c.skel);
+}
+
+static void subtest_replace(void)
+{
+	struct timer_case c = open_case(BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC);
+
+	if (!c.skel)
+		return;
+	if (!seed(&c))
+		goto out;
+	if (run_cmd(&c, CMD_REPLACE_INIT, 1))
+		goto out;
+	ASSERT_OK(c.skel->bss->res_lookup_err, "lookup_err");
+	ASSERT_OK(c.skel->bss->res_update_err, "update_err");
+	ASSERT_NEQ(c.skel->bss->res_old_addr, c.skel->bss->res_new_addr,
+		   "distinct_address");
+	ASSERT_EQ(c.skel->bss->res_init_err, -ENOENT, "init_err");
+	ASSERT_OK(c.skel->bss->res_new_init_err, "new_init_err");
+	ASSERT_OK(c.skel->bss->res_set_err, "set_err");
+	ASSERT_OK(c.skel->bss->res_start_err, "start_err");
+	wait_cb(&c, 1, 1);
+out:
+	drop_elem(&c);
+	bpf_timer_membership__destroy(c.skel);
+}
+
+void test_bpf_timer_membership(void)
+{
+	if (test__start_subtest("live_hash_np"))
+		subtest_live(BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC);
+	if (test__start_subtest("live_array"))
+		subtest_live(BPF_MAP_TYPE_ARRAY, 0);
+	if (test__start_subtest("delete_hash_np"))
+		subtest_delete(BPF_MAP_TYPE_HASH, BPF_F_NO_PREALLOC);
+	if (test__start_subtest("delete_hash_pre"))
+		subtest_delete(BPF_MAP_TYPE_HASH, 0);
+	if (test__start_subtest("delete_rhash"))
+		subtest_delete(BPF_MAP_TYPE_RHASH, BPF_F_NO_PREALLOC);
+	if (test__start_subtest("delete_lru"))
+		subtest_delete(BPF_MAP_TYPE_LRU_HASH, 0);
+	if (test__start_subtest("replace_hash_np"))
+		subtest_replace();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpf_timer_membership.c b/tools/testing/selftests/bpf/progs/bpf_timer_membership.c
new file mode 100644
index 000000000000..b7a10a80f2cf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_timer_membership.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 KylinSoft Corporation. */
+
+/* Run one command per test_run; stale-pointer commands only record init. */
+
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+#define CB_SLOTS 64
+#define CLOCK_MONOTONIC 1
+#define TIMER_NS 1000000ULL
+
+struct timer_value {
+	struct bpf_timer timer;
+	__u64 cookie;
+};
+
+enum timer_cmd {
+	CMD_INIT_START = 1,
+	CMD_DELETE_INIT,
+	CMD_REPLACE_INIT,
+};
+
+/* Results reset before each command. */
+int res_lookup_err;
+int res_delete_err;
+int res_update_err;
+int res_init_err;
+int res_new_init_err;
+int res_set_err;
+int res_start_err;
+__u64 res_old_addr;
+__u64 res_new_addr;
+u32 cmd;
+u64 cookie;
+u64 cb_count[CB_SLOTS];
+
+static __always_inline void reset_result(void)
+{
+	res_lookup_err = 0;
+	res_delete_err = 0;
+	res_update_err = 0;
+	res_init_err = 0;
+	res_new_init_err = 0;
+	res_set_err = 0;
+	res_start_err = 0;
+	res_old_addr = 0;
+	res_new_addr = 0;
+}
+
+/* Configure and start only a current map member. */
+#define TIMER_INIT_START(v, map_sym, cb)				\
+	({								\
+		long __e;						\
+		(v)->cookie = cookie;					\
+		__e = bpf_timer_init(&(v)->timer, &map_sym, CLOCK_MONOTONIC); \
+		if (!__e) {						\
+			res_set_err = bpf_timer_set_callback(&(v)->timer, cb); \
+			if (!res_set_err)				\
+				res_start_err = bpf_timer_start(&(v)->timer, \
+								TIMER_NS, 0); \
+		}							\
+		__e;							\
+	})
+
+/* Delete and initialize through the retained pointer in one RCU section.
+ * Never configure or start a timer through that pointer, even if init succeeds.
+ */
+#define TIMER_DELETE_INIT(map_sym, v)					\
+	({								\
+		long __e;						\
+		bpf_rcu_read_lock();					\
+		res_delete_err = bpf_map_delete_elem(&map_sym, &key);	\
+		__e = res_delete_err;					\
+		if (!__e)						\
+			res_init_err = bpf_timer_init(&(v)->timer, &map_sym, \
+						      CLOCK_MONOTONIC);	\
+		bpf_rcu_read_unlock();					\
+		__e;							\
+	})
+
+#define DEFINE_TIMER_MAP(map_sym, value_type)				\
+static int map_sym##_cb(void *map, int *key, void *value)		\
+{									\
+	value_type *v = value;						\
+									\
+	__sync_fetch_and_add(&cb_count[v->cookie & (CB_SLOTS - 1)], 1);	\
+	return 0;							\
+}									\
+									\
+SEC("syscall")								\
+int map_sym##_run(void *ctx)						\
+{									\
+	value_type *v, *nv, zero = {};					\
+	int key = 0;							\
+									\
+	reset_result();							\
+									\
+	switch (cmd) {							\
+	case CMD_INIT_START:						\
+		v = bpf_map_lookup_elem(&map_sym, &key);		\
+		if (!v) {						\
+			res_lookup_err = -ENOENT;			\
+			break;						\
+		}							\
+		res_old_addr = (__u64)v;				\
+		res_init_err = TIMER_INIT_START(v, map_sym, map_sym##_cb); \
+		break;							\
+	case CMD_DELETE_INIT:						\
+		v = bpf_map_lookup_elem(&map_sym, &key);		\
+		if (!v) {						\
+			res_lookup_err = -ENOENT;			\
+			break;						\
+		}							\
+		res_old_addr = (__u64)v;				\
+		TIMER_DELETE_INIT(map_sym, v);				\
+		break;							\
+	case CMD_REPLACE_INIT:						\
+		v = bpf_map_lookup_elem(&map_sym, &key);		\
+		if (!v) {						\
+			res_lookup_err = -ENOENT;			\
+			break;						\
+		}							\
+		res_old_addr = (__u64)v;				\
+		bpf_rcu_read_lock();					\
+		res_update_err = bpf_map_update_elem(&map_sym, &key, &zero, 0); \
+		if (res_update_err) {					\
+			bpf_rcu_read_unlock();				\
+			break;						\
+		}							\
+		nv = bpf_map_lookup_elem(&map_sym, &key);		\
+		if (!nv) {						\
+			res_lookup_err = -ENOENT;			\
+			bpf_rcu_read_unlock();				\
+			break;						\
+		}							\
+		res_new_addr = (__u64)nv;				\
+		res_init_err = bpf_timer_init(&v->timer, &map_sym,	\
+					      CLOCK_MONOTONIC);		\
+		bpf_rcu_read_unlock();					\
+		res_new_init_err = TIMER_INIT_START(nv, map_sym, map_sym##_cb); \
+		break;							\
+	default:							\
+		res_lookup_err = -EINVAL;				\
+		break;							\
+	}								\
+	return 0;							\
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 4);
+	__type(key, int);
+	__type(value, struct timer_value);
+} values SEC(".maps");
+
+DEFINE_TIMER_MAP(values, struct timer_value)
-- 
2.43.0

