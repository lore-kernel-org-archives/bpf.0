Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAD2D781B
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149615; cv=none; b=T6qienKIea8rbaHaJF/g5CTC94WaM+3e30ZusuHDsOC1kaVhU2joHkSYPBGjZOhkZoL6zw48hhmA+Ohn9icSekT8iSNP+m0IDvWwDPIt1i7TmmGbEtBke+urCRPFrxsDHLnnUtuc0rAZleIH/sXkn2PWxPFKDE0MsF41Q9tfN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149615; c=relaxed/simple;
	bh=wdDdQTjLY+1E2zREvH4xxhUwU0D2DtVT4aRRjwicSNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLOqnwB00MHyTi5LUGtrlKkpAbiQpD9ilMpCbmIkg3pjLDdAqnVy0puqT4FtIVLZVps1zDl1B6+VdQzi5W57sq7ptYdXA38UAZonHRs/GiN0ViC9ddt0arYbDRmKNHOuQ9Su908AKiYusXa+JRZVEVdMCtu2k+J6l8O7g5qJj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ+ebWJF; arc=none smtp.client-ip=74.125.231.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ+ebWJF"
Received: by mail-oo2-f4.google.com with SMTP id 46e09a7af769-7e9df14804fso62272a34.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 17:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786149613; x=1786754413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YVtOCSfZiotYBiw7oHROrNX3CtlzoJrcFyoU93RYJl4=;
        b=mZ+ebWJFdd5JEzprz57SEKtVyJDj8dH5Ab1iwyAaq2Q5FNuiU2G4ltdea1uUeIwphZ
         JHptdfbEY73oVVZYbqh0g12djdcmFpyUOgU1h0n+OywJ7Evq8SqjTC/fgJZDPB38JIoD
         pNFZPdkOSZZQsZa7BIbC3s8qn0DfTxBR15cI750b1LQTuajjF4LISGl4/ba6J2oMcGwp
         eERsYpIsP2Eg/LwRIkxMn2IPaOxdKXYhx0KD3c4OkFiXHYtjwOOP9SWTGIHIGEue1RTf
         zLa7HFl+p7Q9PnkAZ28udHj0GaHMTwjR8GgoeCvApOIpHWl97RT9pOpWBHLT7NdV4ZaE
         BFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149613; x=1786754413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YVtOCSfZiotYBiw7oHROrNX3CtlzoJrcFyoU93RYJl4=;
        b=J0ka1ZN1yIL4NrNRgmr6HY2GVjuRwGi81HIqWu+Oy8M7ejrm0iMbJ6V7jOxhMF/JbP
         vG1cNTrEGe8E5xjtaKvvK3Qzy2c9oY4mRIzNGrtibFxDNkJyuDwffzvPReP/l0RBhJUf
         cOYPHl28e2fS3Imym41tr0PJEcqbeI24/t+Ne4XtzCZB/gnt6XZR9FXGJdvyTxVOuCL4
         KpnDnuQ9g7S7p6bgiYZwMlJvkA0nqAUZV4OVxhzeZstDVFSR8XyqM5lsTJJ/p9VbxtEW
         LpaE6UyRfYgOWdhxGTkH9jGZZMMGhZRXnAXKrHSeuBXpjY09AszikBvLIYXBhNAfEgz5
         7A2g==
X-Gm-Message-State: AOJu0YyIGyC92bvmAVX66KjHhFQafX4U9rUALWziv2ZHRpPG3DzBDynJ
	aA8KuwiOe5BU/rQBfYMworC/U4ZTG/qyy2L+eOBATs0bKpb9+PWES84XbR670QClv4M=
X-Gm-Gg: AR+sD13BehVZRQ0KPFzKGZM6aO2dKg+lKQs9jDP5wsV6YLg/pBpVRxEW2S98Qvex1El
	YOvpNk8iVVepwJDEKZWz3Sh4tsYcdvyfrE2UvRQTt+5KQ23SLFCxDtQk2MgoTChj4WRlaSxZuJr
	llIucGGnqCbbMH/GYGzxk1Alb+m+HZJu+s5l433CzQs7CWeK01S9TbujrPAyvSXMGXyTZifWkT8
	MNv1PJH4LrsVIgKehzwSBUDl7L7/1M0ykEUjck9oNyJ/mxE3B133Rm9V2xNRC3ChFd6U/owSLDV
	HZY2o/PbK1BGMLRLfhckuTBVvEViSop4tFtWxEeVVWUDspDP5QZNjlYbJL7pXho2jdGJ39MMyeS
	3wkr/y1xCOzCfLeHWRDtrA1WXTd2kiH1AxD4bsqFOQpyFuYO1BaLkfD6TnWSoT0pIagQdLeXDYW
	w73mDgT+S1hpeEI9Pef1+S+gqE0XdOBB5YU87OHyejKRQnQJfi6CWH6BkRrv0Ka6Aa1NIQz1rB5
	j/B/+NUPtnieH2cM2GhxxP0z9JY7Q/J5XKsBlj0WlMQL5TdeQKpJZvdgfUsy+/Hr1jFwMo=
X-Received: by 2002:a05:6830:4425:b0:7eb:c8ed:71d5 with SMTP id 46e09a7af769-7f369371f06mr2813305a34.14.1786149612806;
        Fri, 07 Aug 2026 17:40:12 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b56391dsm2289130a34.1.2026.08.07.17.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:40:11 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 12/14] selftests/bpf: Test stack-passed struct_ops arena arguments
Date: Sat,  8 Aug 2026 02:39:32 +0200
Message-ID: <20260808003938.3486067-13-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808003938.3486067-1-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5331; i=memxor@gmail.com; h=from:subject; bh=zqDiWDI3FtZy4RR5oBiCtfg7Om9kW128uckVmQVO8xM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIausqpI1mctpoeXtC6fS3mTe3piqcNohfLnCjq832p7pu2uK X+frKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwET+xTIyNOya9vS/ruzFNYVlxxveBR 5gZ124x1szdtXxUyxFKmVmfxkZmk856Tpfsv3Fe8+xNddqwlX3Xk7lEr/aPXzWbtldsz+xAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Add a test_arena_stack member with eight leading scalar arguments so the
arena pointer is passed on the stack.

The callback validates the first and last scalar ctx slots before
dereferencing the pointer in ctx[8]. This exercises the indirect
trampoline stack layout and arena conversion together, and prevents a
regression where stack arguments are read one slot late.

Signed-off-by: Tejun Heo <tj@kernel.org>
Tested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/struct_ops_arena.c    | 21 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 14 +++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  3 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 4 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
index 40c856a748d2..ba04c73d8d96 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
@@ -46,10 +46,24 @@ int test_arena_nullable_cb(unsigned long long *ctx)
 	return 0;
 }
 
+SEC("struct_ops/test_arena_stack")
+int test_arena_stack_cb(unsigned long long *ctx)
+{
+	u64 __arena *ptr = (u64 __arena *)ctx[8];
+
+	arena_touch++;
+	/* pin the slot layout: the leading args fill ctx[0]..ctx[7] */
+	if (ctx[0] != 1 || ctx[7] != 8)
+		return 0xbad;
+	*ptr += 1;
+	return 0;
+}
+
 SEC(".struct_ops.link")
 struct bpf_testmod_ops3 testmod_arena = {
 	.test_arena = (void *)test_arena_cb,
 	.test_arena_nullable = (void *)test_arena_nullable_cb,
+	.test_arena_stack = (void *)test_arena_stack_cb,
 };
 
 SEC("syscall")
@@ -88,6 +102,13 @@ int trigger(void *ctx)
 	if (ret != 0xbee)
 		return 7;
 
+	/* the arena pointer is stack-passed into the trampoline here */
+	ret = bpf_testmod_ops3_call_test_arena_stack((u64 *)val);
+	if (ret)
+		return 8;
+	if (*val != 44)
+		return 9;
+
 	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
 #endif
 	return 0;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1e6d632c6f83..a6133f7521f3 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -395,11 +395,19 @@ static int bpf_testmod_ops3__test_arena_nullable(u64 *ptr__arena__nullable)
 	return 0;
 }
 
+static int bpf_testmod_ops3__test_arena_stack(u64 a, u64 b, u64 c, u64 d,
+					      u64 e, u64 f, u64 g, u64 h,
+					      u64 *ptr__arena)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_1 = bpf_testmod_test_3,
 	.test_2 = bpf_testmod_test_4,
 	.test_arena = bpf_testmod_ops3__test_arena,
 	.test_arena_nullable = bpf_testmod_ops3__test_arena_nullable,
+	.test_arena_stack = bpf_testmod_ops3__test_arena_stack,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -428,6 +436,11 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_nullable(u64 *ptr__arena__nulla
 	return st_ops3->test_arena_nullable(ptr__arena__nullable);
 }
 
+__bpf_kfunc int bpf_testmod_ops3_call_test_arena_stack(u64 *ptr__arena)
+{
+	return st_ops3->test_arena_stack(1, 2, 3, 4, 5, 6, 7, 8, ptr__arena);
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -838,6 +851,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_1)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index c367ec856776..33f2af5b7085 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -109,6 +109,9 @@ struct bpf_testmod_ops3 {
 	/* Used to test arena pointer arguments. */
 	int (*test_arena)(u64 *ptr);
 	int (*test_arena_nullable)(u64 *ptr);
+	/* enough leading args to force @ptr onto the stack on x86 and arm64 */
+	int (*test_arena_stack)(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f,
+				u64 g, u64 h, u64 *ptr);
 };
 
 struct st_ops_args {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index ea1747e2ad1f..c4383acb53c1 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -122,6 +122,7 @@ u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused) __ksym;
 void bpf_testmod_test_mod_kfunc(int i) __ksym;
 int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena__nullable) __ksym;
+int bpf_testmod_ops3_call_test_arena_stack(__u64 *ptr__arena) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.53.0-Meta

