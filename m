Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E826C3BD
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 10:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518547; cv=none; b=XuZQN3eU98fAsrtt5lvxPvVlr4OSBwrvtxZr+wibAZViGQV4DKTIJCmZFvJjfz0dczPPmUxtUVkkYvKoGcP2OjnpQ7hYYhpj+XhxOy3DXArruFv4yE8598IRFyZKr2VS+vvDHzr3mBuqNpANsj2gsQumQ2Tu08GnrBI5fFF7mjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518547; c=relaxed/simple;
	bh=LqKvWOC0cimHI9jhRBqjODdjJ92ac+yCVwfETTwpI+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nngIU7VjDRgt6/rwiOph1hYLDr9k1zimSbzhhDwVIOzX81VOkrA/K1m9U3QOPAQuOhxSYuXL297JsKJgIhBiF1Yq2ia0d07uv7TEeqg5cNXwYeKHh6EZX7Qzx0AqKqH0mc5dnwAPD5rsYtV/P/YXq7SdzJD8+IRNo9Taul/Xt7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIebvapS; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIebvapS"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso3671585e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 03:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788518541; x=1789123341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aft0KviV9LvojLGg8Gseumwrmib9aJGZUm38z3Q/6QM=;
        b=EIebvapSfJFVLaT28ArhsmGgwRaaOUX1Co2rofGFGunfMdDa53x2QhgDZ0rdCjBJbk
         w3Fo5mIGep3OcRriVhiWuoe8YgqmJgtKVoYFFNcu+H6RG1gkIIDFqyskcI6Cum83E+0J
         8pO72rcpSczrjB5bjJ+RYMSv6WMZzMwbGJEaATfP5lgEKGYFRAQ+xLjbU8HIRypovrsu
         gJQejnWjYE8BzQtBG5KNYn+6GqdmqWWbgsQnKMWjh8lGV1ic6GFSw4sc0p1/dZSdcfwh
         mj5iTezTCEEtyw/sxMByZ47z97HbE1CtOQcUEMd3UfEnDE/ULL4q8l2CkxXZXXwZ6NyS
         BXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518541; x=1789123341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aft0KviV9LvojLGg8Gseumwrmib9aJGZUm38z3Q/6QM=;
        b=LKhnxxmwRheDhPo2SruxEGrVIgG6vEgnVtoi3Fp7mDWsInxN+xGBQhGCoY2JZT4LzN
         cGsNzgaHrWVlNPi6503m1pOAVZxgSaa02q7mzS0PL8og/zer+T9Cx5bQEcJgHeYxjlp5
         84fWT3hBhcNxMNElJfQTHr7uDpGNqTaIZaI0vUyQvSmLCL6yn1+91pjP1GDik79WZ0Cf
         CLeCSw2EVTVY2v+Ms/ac9u1mRHL/gGrdq5HXgmmHUHAo4AndhOW6zZQiFdmfh+MX5jYi
         mVsL4FfW9Gru8U01r46DeikuLFKoku6qcoo+0ie7P24s7ViwaHmtez7nH49XKk0eRuAi
         AjGg==
X-Gm-Message-State: AFuF++neH7gVxKOiQx03QfD7yVsbkMnC98ZdOc0rR2ocwUQy5QOEXp/7
	LhDGXtw8osl8YrowdOw4yi3ZAbgEZyp9MGrpTeHjAvtJFJWCSi3MkzT6Vsfivrxo
X-Gm-Gg: AYBFou0OahFoGluzHF2hG4yngkphlgCub/nLM2vI095tEroOtDkMTj+Pt+Bl+DUCaWo
	USIvUIVYLlXYN+muyxInq7iRhObCS+EYSLAsj9dXiQmas2yYTxWYwWrzTTXnWsSIfvTgHm9ewUd
	aOrWPZLSHKWzoRfCcodNPw6Nzq6nVyQrNcDQ5nunaoLVPXUStGXK2rcaUOZy88VUCZMtLs92fTM
	bOye9l3XWbsyG2J+t2mozHMw081GGMJ/cXydGxYF6Rxa99X2ws9q+A0Rw7xZkTBAwu0JThiaK+Y
	4DmMrQGs0JIB3qNeWFVo6apSyACPP65zHyWmMz5k3+vup4+H/VhIGLafgPMO4ZMfm5O4A9uPQy3
	DC6dmsBK4K6dm44DrbP877BgHqhb7Yl72FitkTP59W1zW0oITqNFh4BlC3GDGdBbOxLgnS7DA5O
	F0wOZc8ji39dFvuZwUW9GNXcMXATJHsT67WKuomG7BEWPxJ3eRCId8QXDdV/jfwCwXWq6ZSTA8C
	E7tjoauo5BXusqIIBAxbz70WvAoNzhoHoU54RBtJY+AvsUbIlfIcnXCWyOgXlwvsbZJl+m7B2gu
	orr33TqETj8NtZMy3veJMSmiWmo=
X-Received: by 2002:a05:600c:1c23:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49cf820a8e3mr57602135e9.3.1788518541271;
        Fri, 04 Sep 2026 03:42:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm60770335e9.0.2026.09.04.03.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:42:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 4/8] selftests/bpf: Test rhtab kptr cancellation semantics
Date: Fri,  4 Sep 2026 12:41:55 +0200
Message-ID: <20260904104203.345917-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904104203.345917-1-memxor@gmail.com>
References: <20260904104203.345917-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4762; i=memxor@gmail.com; h=from:subject; bh=remhb3wJMtnH0GUA3NEWaFTCYTbotDIyClUmSy0fTuk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvW/LNqGxKic886nDG2kg3o/qb0RumM/uq1eh/3R0fHS 2o+ClvXUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInYrGD4735tmnf4986WxuUr HJY/ucfKfy2Y441aSOLE+RvMHp3eepKR4cOKFYzBkXxTJfpUDeY9fN70ZOOXPbGl/w6eYIlpOte WywMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

Resizable hash-map updates and deletions must not perform full special-field
destruction in their caller context. In particular, a referenced kptr must
remain attached to the allocation until the memory allocator destructor can
release it safely.

Add separate coverage for both affected paths. The update test stores a task
kptr, replaces the ordinary value bytes with BPF_EXIST, and verifies that the
kptr survived. The delete test removes an element and exchanges its kptr
through the still-valid map-value pointer before the allocation is reclaimed.

Both cases observe a NULL kptr when rhtab uses bpf_obj_free_fields(). They
recover and release the reference after rhtab switches to cancellation
semantics.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
[ kkd: Split update and delete coverage and rewrote the commit log ]
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/rhash.c  |   6 +
 tools/testing/selftests/bpf/progs/rhash.c     | 112 ++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/rhash.c b/tools/testing/selftests/bpf/prog_tests/rhash.c
index 98bb66907b7f..0641bd5b0a9e 100644
--- a/tools/testing/selftests/bpf/prog_tests/rhash.c
+++ b/tools/testing/selftests/bpf/prog_tests/rhash.c
@@ -172,6 +172,12 @@ void test_rhash(void)
 	if (test__start_subtest("test_rhash_delete_nonexistent"))
 		rhash_run("test_rhash_delete_nonexistent");
 
+	if (test__start_subtest("test_rhash_kptr_update"))
+		rhash_run("test_rhash_kptr_update");
+
+	if (test__start_subtest("test_rhash_kptr_delete"))
+		rhash_run("test_rhash_kptr_delete");
+
 	if (test__start_subtest("test_rhash_map_extra_presize"))
 		rhash_map_extra_presize();
 
diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/selftests/bpf/progs/rhash.c
index fc2dac3a719e..aea4de8dc781 100644
--- a/tools/testing/selftests/bpf/progs/rhash.c
+++ b/tools/testing/selftests/bpf/progs/rhash.c
@@ -19,6 +19,11 @@ struct elem {
 	int val;
 };
 
+struct special_elem {
+	struct task_struct __kptr *task;
+	int val;
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_RHASH);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
@@ -27,6 +32,17 @@ struct {
 	__type(value, struct elem);
 } rhmap SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RHASH);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct special_elem);
+} special_fields SEC(".maps");
+
+extern struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+extern void bpf_task_release(struct task_struct *p) __ksym;
+
 SEC("syscall")
 int test_rhash_lookup_update(void *ctx)
 {
@@ -246,3 +262,99 @@ int test_rhash_delete_nonexistent(void *ctx)
 	err = 0;
 	return 0;
 }
+
+SEC("syscall")
+int test_rhash_kptr_update(void *ctx)
+{
+	struct special_elem val1 = { .val = 1 };
+	struct special_elem val2 = { .val = 2 };
+	struct task_struct *task, *old;
+	struct special_elem *elem;
+	int key = 0;
+
+	err = 1;
+	if (bpf_map_update_elem(&special_fields, &key, &val1, BPF_NOEXIST))
+		return 1;
+
+	err = 2;
+	elem = bpf_map_lookup_elem(&special_fields, &key);
+	if (!elem)
+		return 2;
+
+	err = 3;
+	task = bpf_task_acquire(bpf_get_current_task_btf());
+	if (!task)
+		return 3;
+
+	err = 4;
+	old = bpf_kptr_xchg(&elem->task, task);
+	if (old) {
+		bpf_task_release(old);
+		return 4;
+	}
+
+	err = 5;
+	if (bpf_map_update_elem(&special_fields, &key, &val2, BPF_EXIST))
+		return 5;
+
+	err = 6;
+	elem = bpf_map_lookup_elem(&special_fields, &key);
+	if (!elem || elem->val != 2)
+		return 6;
+
+	err = 7;
+	old = bpf_kptr_xchg(&elem->task, NULL);
+	if (!old)
+		return 7;
+	bpf_task_release(old);
+
+	err = 8;
+	if (bpf_map_delete_elem(&special_fields, &key))
+		return 8;
+
+	err = 0;
+	return 0;
+}
+
+SEC("syscall")
+int test_rhash_kptr_delete(void *ctx)
+{
+	struct special_elem val = {};
+	struct task_struct *task, *old;
+	struct special_elem *elem;
+	int key = 0;
+
+	err = 1;
+	if (bpf_map_update_elem(&special_fields, &key, &val, BPF_NOEXIST))
+		return 1;
+
+	err = 2;
+	elem = bpf_map_lookup_elem(&special_fields, &key);
+	if (!elem)
+		return 2;
+
+	err = 3;
+	task = bpf_task_acquire(bpf_get_current_task_btf());
+	if (!task)
+		return 3;
+
+	err = 4;
+	old = bpf_kptr_xchg(&elem->task, task);
+	if (old) {
+		bpf_task_release(old);
+		return 4;
+	}
+
+	err = 5;
+	if (bpf_map_delete_elem(&special_fields, &key))
+		return 5;
+
+	err = 6;
+	old = bpf_kptr_xchg(&elem->task, NULL);
+	if (!old)
+		return 6;
+	bpf_task_release(old);
+
+	err = 0;
+	return 0;
+}
-- 
2.53.0

