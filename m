Received: from mail-oo2-f1.google.com (mail-oo2-f1.google.com [74.125.231.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74E4F6465
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416167; cv=none; b=niDw24GYPMlbCSmrob8ZHq+4ImUS6R41D2n0+ZXEBVYVMBMA8vNFGc9enyTV1Nq/JTeG1KXsYbUSUyhMl1r3yONrP472BooZ2Xg/2XbXFKb42PCcaNo9CSw2/aoM9GeKkfsjqOAWaHoK3dOpdOuvFHQBSoth7KczYbksK3NJCuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416167; c=relaxed/simple;
	bh=xL0P9Fll0akclp3p051aboP8kSgjsC1qcGxiRV2smgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3sM0/+oO9oE/Z0Q3eNg4VYWdXjMkVA0r50Z6NXd9PEQh9cQjbgrfjXaEhzM2E7UxxUXTrP8H40/m14rUpeSoXw1FkLVUHF0LEEUiBj4Vg587V/3V3l1ncDIow3nTdtoL8yn15lim4Po/CnGDMQXbRqCzkjv+eROo0v8V8sSAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=riIEroOP; arc=none smtp.client-ip=74.125.231.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riIEroOP"
Received: by mail-oo2-f1.google.com with SMTP id 006d021491bc7-703c8927a65so899983eaf.0
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416165; x=1793020965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhZRFo/F7FIEM4mtz7LFgdckmmdEP/yEKbkXicbifHs=;
        b=riIEroOPm0P5LVxOYo73OghFf7g+8tmPMw/wGVr3MbIpOo6oWoOb8CWadMKdgqS+q7
         bZF8FQaNOw8ITDjYVm7RzI9JN5O6E9ePJWb2QwRGnMUKxUXHdnp9aDVekFdICiCYsA+t
         p8ocCrxOmUoIAQ44Er/hY5pDqwlB6FWJWX+Kt5bzD0ddRfvo6AB+2+8dtvN93E+SajRK
         vT6DSuUACuHrAUiN7abPTnQo1gkSroQNciAQ21QbIhu/KTQ/MY6AiM03rcfvinjQCst+
         7xI9dlk+vBK/1LRROnL/dnrgv5pFmXpneXKIJSxKNy+3mI7sf0JMhM4KvrU7mMYKXQd+
         ktog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416165; x=1793020965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HhZRFo/F7FIEM4mtz7LFgdckmmdEP/yEKbkXicbifHs=;
        b=IQOKpn6dxzUtv6AGyHfSFMggl7GFxelWTbJUqUFE+Ym6s5SmRaalwzw09RO/4/RW8q
         jt33nTqFUKbyEN3+98UVmO6C5XaNpnY5rc/XiRLXNn2RspepO9bmjQeHbZMDjCR+2AxG
         L3zMzGw7sWqQf7a2JwK3ba7AZPoVC5g55akgUJiehvx0ogSHlKnxZYjSwjEG6Mum6cSy
         PIFIUFHmgRZGqC+e7NcH6X4gJUkNJHr3jQFqjHXomMyrE2FhQvcu9p3Ld+mu+eluxkbT
         7roNkPgkdQDWrDaRcQmlYbmlalFipMgCXYn3IY3sXYb5Gdfmz8zH2xUFYAkJ1XHjTfj4
         Mx4Q==
X-Gm-Message-State: AFq9FYKuMgulwmIUvQFMFIO51IDsmsFNeDSVR7qcUbVlj8m6OmXrW5Oj
	Oo7yS8+aDrH2WqWUajfx+fMI89S1vXlf3xHPVMR1eVtJ8esIEi3pqxo6+0v3g9z39zc=
X-Gm-Gg: AYBFou0ZWxSEgQHZb+0+AYk9Z6rF5R6ngk4QhtsMubhP557Lklim0ZHNVfCIkVbcVnv
	N22IzFP130+rzcJD5sYUBOygUJB3FDrutB2s6P+JP6gyM01tDEkWYBWHCNCCetgcue4m03UCvua
	wnkNBJmf/cmsaHEo7hAGOstV5KOaFiUWRtrVCdSCvMxwlml0xvRsfBa36fEWBTIaBM0/vvbKXP5
	zwgy6IHNKQWHjKigIb/dJJxLNZ5Ivtva5pgKh5Lns971whAVKmBT9APfBDj22QWaFs+2vejmJyd
	0lTkTRo/A1gqiHQXTX2T9KYWRffdP60KW1HbC6i0i/8ntdlXg1UOG56mpa9XBp3xchSB8JPjre/
	RwgZfdXGw2bCPb2Z2RCb7LnOiRkxoPASvenhmgkxn9iRiYTm8SkbitVrdVFlsfHDMf+dumVVSNr
	z+sZVlNevlwMRXM5hkZLLCt4W6pzWugs2Xqc+KbL4JmFULCJrNvKPolVieNdE7wWSrRKggjXQv1
	X2B1zIdHH235A+LRTWEEecMyv6jcvdx1MHEJ/uLrvh9LQ36W6TESLMWoAs+iSAJcMcs5LnZL0Yl
	g6Ze
X-Received: by 2002:a4a:e906:0:b0:6f8:728d:cb0 with SMTP id 006d021491bc7-7035679f9c9mr4623255eaf.46.1792416164686;
        Mon, 19 Oct 2026 06:22:44 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70190c1d670sm7093444eaf.13.2026.10.19.06.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 12/16] selftests/bpf: Test arena binding by libbpf
Date: Mon, 19 Oct 2026 15:21:54 +0200
Message-ID: <20261019132203.3034698-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7591; h=from:subject; bh=xL0P9Fll0akclp3p051aboP8kSgjsC1qcGxiRV2smgc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxNEUaa3T3VF7l69PL1PV0k0t/PKC8an/mWcBWntyF14r 3X20o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPJWM/IsMF/v/zJB+o7v3ZY8xYs3e lprHBSZI7mzus65zaqrBO7Ys7I0HYstSPRgutQmaXK72KubNWkpSVHBE+9ZdA+deNn5gRfPgA=
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

