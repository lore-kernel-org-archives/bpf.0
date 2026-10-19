Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B971448BB6
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380294; cv=none; b=YwqI9x7ItIMgCqOyaQJ1DR5Tj3CrHx+8n6Tl8j7pP2m6n5tN1ZYhXWnt5wfUC8KXUX/7V2sgYt32mjn55cvaaI8r0bGRKG+7E+2mFrvIl2fUR8n/BryEg7XqOKn2Meks1UdKaEqwXbtY5So402QbRplNBz8/BmrTnnhI05RsmYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380294; c=relaxed/simple;
	bh=xL0P9Fll0akclp3p051aboP8kSgjsC1qcGxiRV2smgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLBwl8ezrgX9/Krv3FG8PxxMYfa7TDIxAhNLt0MOfTG5Ikz74hPZgy+DFinJDbD89alh/dlNrPrzXzcWg2N0uHSS2adwRVdePZSRjt5vWxVlus/djnM5aKtId324HEtPNg4QsdN/cNIpOlFd4iB1zMA7m7YCQSm6xticdBXyIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md3R6G4D; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md3R6G4D"
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-70094949641so1893672eaf.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380291; x=1792985091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhZRFo/F7FIEM4mtz7LFgdckmmdEP/yEKbkXicbifHs=;
        b=md3R6G4DfkNr2j122GHdPcbyDke+VvXFaQihK7yPYEQnM8EsPFTi015dZ4IdvWQkoW
         GaEDtYFTH+thyy+vkQsm7L38GvDzvTeeJICzjNrTANUiRTgw9rWHpmcEfSZ7hJB/sBhq
         fx1MeZ5oiC3zvk0/w7JDdnqF+YpY1Eh/nDf5eH9J1Hq3jigI+geb1aCK9IdtL2kcEB+k
         PcpTdS+EO5OGctq3EcxAIHqAdbMb25hEtok53H3p1WzYSmnAmFcwQ6mrvoKhbSu9Hg+J
         KTNvCD3/vYgvMSHacv5485S6DOaW04TgG4EXKnOViLW+GXOQinqpPq+TirWBFO0fCcFE
         T0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380291; x=1792985091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HhZRFo/F7FIEM4mtz7LFgdckmmdEP/yEKbkXicbifHs=;
        b=PvSnZhWc+R4SDmkbC3+UI6iq6J7xM4eepXtlTuel0M5L3Vv2DldpZPgF8tAFeQl4SG
         9P7SjO/bBF+Pg80wkePBeajBO/V4Fv1btgPBkdVK6rR7aEM6ebTvw8ouKceAsZv38rez
         RITDlzPrT2M/l1wX1EnqJ6NrYoObcHLA5juk+YvBF9vp0aHGx21fye1ibm+SaxyWc/RE
         di7T+0CWHzc7MJQ7pGmMcp29ey2a18QgtIziGpw9rBmBT2574DLWxPei+YbEdt2hcAuN
         QGS5LkzailQMPtz7SxUPF3kHD1oPLF1m1Nc/1Qp+Z5Mpv1Sd5ApXhhoI5XIsnxOvXT8Y
         vNEw==
X-Gm-Message-State: AFq9FYI/0meVKl0T+zcTRUFL5ZqFm3+aHCwrdcNwPH2cmjfwei8ZNF6D
	Xq+cHx3kECDW6vZYRV5iWPMRPCn98vYQvvHrK6UCuq3k70kwDnEXMgunNMCZqlW5ySM=
X-Gm-Gg: AYBFou3oIPQCKvrfYbQGrOWxEXjXU3aSTuNGgxs72dh2H8yoBYGyHO+EVytIFKei5II
	NsgUW4o0GfkRARy3d7QbEAXAFS+yp9IwvJMZDg8CL7UHq/M/Y3AkvFhfcxi/wQBtFL+hfWKxIK4
	G/sAQ3Tl4zOFQmrtzS6bsr9E9XsE5JIjG/6m8IOXM4YpnlJMISz8A5U2vnlDB2h90SA2cFAKIFp
	4WiEh1AFDHjv+Cy3ZWJbtObhC7KBDJ0v9E0aQ2r8iU0U5JPzFae3BuMBJ9hlv5vkm+Jtt//n3RZ
	REVECOVdeca3LO1pJq2gUI8AxWpdhzqopU1jwdI+crT+WULAo5z+5U8hPoHREl6I5qVFM8F9FHZ
	xt/j+49yb7V5ynM3zMpo1jXM80eMi07H/soSUm2knE7SzqvaaXdciBFx8AfEMj6OgFTaK96bZrn
	ZmoH64wztz4m+SgKsVFP6jPBHCA32MULd8PK1zILHOaP5Uf55pNRndnw0vNiNuCwFpvB0NBVoHw
	mNf7oQUI/LOqmGxsptqeMoar96oUsiJei8uj6006KKk0RquRvHES8zZGCqck/kwT/X+H/ec2ioc
	jF/BQDEeQ7SRRmgmMg==
X-Received: by 2002:a05:6820:1797:b0:6fa:3c7:8798 with SMTP id 006d021491bc7-70116c56343mr6344262eaf.56.1792380291133;
        Sun, 18 Oct 2026 20:24:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:71::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84a4da2d675sm369455a34.10.2026.10.18.20.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 12/16] selftests/bpf: Test arena binding by libbpf
Date: Mon, 19 Oct 2026 05:23:52 +0200
Message-ID: <20261019032401.2302823-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7591; h=from:subject; bh=xL0P9Fll0akclp3p051aboP8kSgjsC1qcGxiRV2smgc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr16KtNbp7qi9y9enl6lq6aYWfnnB+NT/zLMArT25C6+V 7j7aUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIk0pjD8j1p71mf1oRoxVZPQpT/eM9 wVFZiV2eD2ODAge+pyaRsuVYb/ng8qZ6ww2Ry6wF7RtSumWL5ihk8Qo8uOa5mlPzg+at7hBgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Attach a struct_ops callback with an __arena argument from an object
whose callback and unrelated program never refer to the arena, drive it
through the kernel, and check that an unrelated program of the object
got the arena among its maps as well. Load the same object through
bpf_object__prepare() and bpf_program__clone() too, the way veristat
loads programs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 120 ++++++++++++++++++
 .../bpf/progs/struct_ops_arena_autobind.c     |  64 ++++++++++
 2 files changed, 184 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index 1c04473fb42d..e7580b9f0fc2 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -13,6 +13,7 @@
 #include "struct_ops_arena_member_fail__mismatch_mem.skel.h"
 #include "struct_ops_arena_member_fail__write.skel.h"
 #include "struct_ops_arena_member_fail__no_arena.skel.h"
+#include "struct_ops_arena_autobind.skel.h"
 
 #if defined(__x86_64__) || defined(__aarch64__)
 /*
@@ -145,6 +146,119 @@ static void arena_member(void)
 	struct_ops_arena_member__destroy(skel);
 }
 
+/* @prog_fd lists exactly one map, the one with @map_id. */
+static void assert_prog_map(int prog_fd, __u32 map_id, const char *name)
+{
+	__u32 map_ids[2] = {}, len = sizeof(struct bpf_prog_info);
+	struct bpf_prog_info info = {
+		.nr_map_ids = ARRAY_SIZE(map_ids),
+		.map_ids = ptr_to_u64(map_ids),
+	};
+	int err;
+
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &len);
+	if (!ASSERT_OK(err, name))
+		return;
+	if (!ASSERT_EQ(info.nr_map_ids, 1, name))
+		return;
+	ASSERT_EQ(map_ids[0], map_id, name);
+}
+
+/*
+ * libbpf binds the arena of an object to every program in it: a callback
+ * with an __arena argument loads without referring to the arena, and an
+ * unrelated program gets the arena as well.
+ */
+static void arena_autobind(void)
+{
+	struct struct_ops_arena_autobind *skel;
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	int err;
+
+	skel = struct_ops_arena_autobind__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_autobind__open_and_load"))
+		return;
+
+	err = bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.arena), &info, &len);
+	if (!ASSERT_OK(err, "arena_info"))
+		goto out;
+	assert_prog_map(bpf_program__fd(skel->progs.test_arena_cb), info.id, "test_arena_cb");
+	assert_prog_map(bpf_program__fd(skel->progs.unrelated), info.id, "unrelated");
+
+	attach_and_trigger(skel->maps.testmod_arena_autobind, skel->progs.trigger);
+out:
+	struct_ops_arena_autobind__destroy(skel);
+}
+
+/*
+ * The same binding through bpf_object__prepare() and bpf_program__clone(), the
+ * way veristat loads a program: the arena takes slot 0 of a continuous
+ * fd_array, next to the module BTF of the kfunc the trigger calls.
+ */
+static void arena_autobind_clone(void)
+{
+	struct struct_ops_arena_autobind *skel;
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	struct bpf_program *prog;
+	int err, fd;
+
+	skel = struct_ops_arena_autobind__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_autobind__open"))
+		return;
+
+	err = bpf_object__prepare(skel->obj);
+	if (!ASSERT_OK(err, "prepare"))
+		goto out;
+	err = bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.arena), &info, &len);
+	if (!ASSERT_OK(err, "arena_info"))
+		goto out;
+	bpf_object__for_each_program(prog, skel->obj) {
+		fd = bpf_program__clone(prog, NULL);
+		if (!ASSERT_GE(fd, 0, bpf_program__name(prog)))
+			continue;
+		assert_prog_map(fd, info.id, bpf_program__name(prog));
+		close(fd);
+	}
+out:
+	struct_ops_arena_autobind__destroy(skel);
+}
+
+/*
+ * An arena exclusive to a program is bound to that program all the same: the
+ * kernel checks an exclusive map against the digest of the final program, so
+ * the binding through the fd_array passes for the program the map is
+ * exclusive to.
+ */
+static void arena_autobind_excl(void)
+{
+	struct struct_ops_arena_autobind *skel;
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	int err;
+
+	skel = struct_ops_arena_autobind__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_autobind__open"))
+		return;
+	/* the other programs need the arena too, and cannot have it */
+	bpf_map__set_autocreate(skel->maps.testmod_arena_autobind, false);
+	bpf_program__set_autoload(skel->progs.trigger, false);
+	err = bpf_map__set_exclusive_program(skel->maps.arena, skel->progs.unrelated);
+	if (!ASSERT_OK(err, "set_exclusive_program"))
+		goto out;
+
+	err = struct_ops_arena_autobind__load(skel);
+	if (!ASSERT_OK(err, "load"))
+		goto out;
+	err = bpf_map_get_info_by_fd(bpf_map__fd(skel->maps.arena), &info, &len);
+	if (!ASSERT_OK(err, "arena_info"))
+		goto out;
+	assert_prog_map(bpf_program__fd(skel->progs.unrelated), info.id, "unrelated");
+out:
+	struct_ops_arena_autobind__destroy(skel);
+}
+
 /* The same through the vmlinux.h rendering of the members, which takes casts. */
 static void arena_member_render(void)
 {
@@ -197,6 +311,12 @@ void serial_test_struct_ops_arena(void)
 		/* so that the missing member tests show up as skipped */
 		test__skip();
 	}
+	if (test__start_subtest("arena_autobind"))
+		arena_autobind();
+	if (test__start_subtest("arena_autobind_clone"))
+		arena_autobind_clone();
+	if (test__start_subtest("arena_autobind_excl"))
+		arena_autobind_excl();
 #else
 	test__skip();
 #endif
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
new file mode 100644
index 000000000000..495faa0f4a8b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#define BPF_NO_KFUNC_PROTOTYPES
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
+#include <bpf_arena_common.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 1);
+} arena SEC(".maps");
+
+/*
+ * Neither the callback nor the unrelated program refers to the arena. libbpf
+ * binds it to them all the same, so the callback can use the __arena argument
+ * the kernel hands it.
+ */
+SEC("struct_ops/test_arena")
+int test_arena_cb(unsigned long long *ctx)
+{
+	u64 __arena *ptr = (u64 __arena *)ctx[0];
+
+	*ptr += 1;
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_arena_autobind = {
+	.test_arena = (void *)test_arena_cb,
+};
+
+SEC("syscall")
+int unrelated(void *ctx)
+{
+	return 0;
+}
+
+SEC("syscall")
+int trigger(void *ctx)
+{
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
+	u64 __arena *val;
+
+	val = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
+	if (!val)
+		return 1;
+
+	*val = 41;
+	if (bpf_testmod_ops3_call_test_arena((u64 *)val))
+		return 2;
+	if (*val != 42)
+		return 3;
+
+	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
+#endif
+	return 0;
+}
-- 
2.53.0-Meta

