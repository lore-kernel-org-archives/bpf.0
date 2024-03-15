Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEE7499
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 02:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469127; cv=none; b=PmGrOfq382EMpRKlS2V0symvrGYeSnNYafMNT8BTWN8ZbXQyibbzSIGxwYMEwb1Q2u8zNh6TdSKPkhb1tl52/3Arj9b/7jAfyo7h03LQ/ZL2mw6Xe69V89+MoigsXPs1FbgMbtICQnAY3aahbOUUVe7Zsl5UU2LY27JzLnzE50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469127; c=relaxed/simple;
	bh=Q9ogDrVBReMWJF93xhEiBRaSk+I0x49qVjP+LojR4bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6OXAnJJAL4mDmByCPhXVo5AsUL/zqF83yZg9Jynl8eSDGzW7g6GaUCiOHT5V1x6OlcjCG7AEXUdboUfhHFhVb7bYm5wpydi62dgJYV1Ii8jbORJTq/+nVfBey63ot0gqLwtz12hJGwiInPiFC1sKQcmIxjb1JGbXdrJD0dmETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi5Y2QOJ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi5Y2QOJ"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6eb891db9so1164599b3a.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710469124; x=1711073924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17f+nEHPgSpLlniyWNzznar1mNYCf92rMKqwvSNOLng=;
        b=Zi5Y2QOJ5z4DGE2lEkT/PPqEpOLXoRSw/xujDEfaV0q1gKFggU5A0OyESi4vnmHjyh
         Hl6Tt/6jlSL33GyuofNnXWbM8IgyO4mx2eocNcwXb6EUV8vl3kuMvRVtKUWtYfui5u+w
         qqKBpQ/aTairDSjB+47vBEEP0CjXKUCEV1C1Dv0PcQu+zl0pWFZWpCqUYMjK2PshKjxc
         IymlAGnAj4jNOw/3wyG5Hyo2a3iYwltAaq6yoeE9xFauSos9C1V9oJUv1AO4Z2SJ2dub
         3Fgk1rXC7IwtW2FPrM27H/e3F+6aUv8EnXe46jj/xuUTn3Soc4tGsJgVXKBkYcmJgeCr
         /img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710469124; x=1711073924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17f+nEHPgSpLlniyWNzznar1mNYCf92rMKqwvSNOLng=;
        b=C5Gvhlq9I7cq1pspZl7+mTMPDHzuHuxj6S2Dxai54qaNu3KAK6fqXVoFTbVyQ0vqx0
         CeUqXTNZML9lezh7UUr83NTEH0X0M29yoNCGxnE35MR4x9VytJu+bOPAwbUbdbv7Qi6S
         ET517WI2DZYZCLShTGBZgQqBYtSJ+6+nlGGoIRzx2+DWAQpTnBEuSI2myGtfFRFz3ZFf
         teV0+mpLFNXTAfFM0JgUJXhvQvc3fyn/YV5zYwk4sVhDAlvBqNMl46U66jtIva0NqnNQ
         wCXhG1N1yNWYOQoljcy/VrX/lTyiab1a8+psj8lZUEXcNZ50kCDHi674qHbQAfJdNjbO
         WGxQ==
X-Gm-Message-State: AOJu0YxCHSdnSHAn5mASMRw5DNr945whVRhZB8RvyjM4w+GB64KLITY7
	1mAKeOH80WoKdNqYAbAnNhuLUPElmwaS2hBjNvG9VLK7mDiBQius4hbqMzfK
X-Google-Smtp-Source: AGHT+IGJ9nXaLzS/lLGz1jxPzJqQkolv5kHyDrH/luDRxTS0vnsYAZ23OGYyWxGcrxSSH90oW80QCQ==
X-Received: by 2002:a05:6a00:23c6:b0:6e5:e7c5:9120 with SMTP id g6-20020a056a0023c600b006e5e7c59120mr3948190pfc.19.1710469124559;
        Thu, 14 Mar 2024 19:18:44 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:12e])
        by smtp.gmail.com with ESMTPSA id gx20-20020a056a001e1400b006e6bcbccda9sm2232547pfb.59.2024.03.14.19.18.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Mar 2024 19:18:44 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf 2/4] libbpf, selftests/bpf: Adjust libbpf, bpftool, selftests to match LLVM
Date: Thu, 14 Mar 2024 19:18:32 -0700
Message-Id: <20240315021834.62988-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
References: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The selftests use
to tell LLVM about special pointers. For LLVM there is nothing "arena"
about them. They are simply pointers in a different address space.
Hence LLVM diff https://github.com/llvm/llvm-project/pull/85161 renamed:
. macro __BPF_FEATURE_ARENA_CAST -> __BPF_FEATURE_ADDR_SPACE_CAST
. global variables in __attribute__((address_space(N))) are now
  placed in section named ".address_space.N" instead of ".arena.N".

Adjust libbpf, bpftool, and selftests to match LLVM.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/gen.c                            |  2 +-
 tools/lib/bpf/libbpf.c                             |  2 +-
 tools/testing/selftests/bpf/bpf_arena_common.h     |  2 +-
 tools/testing/selftests/bpf/progs/arena_htab.c     |  2 +-
 tools/testing/selftests/bpf/progs/arena_list.c     | 10 +++++-----
 tools/testing/selftests/bpf/progs/verifier_arena.c |  4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 4fa4ade1ce74..540c0f2c4fda 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -121,7 +121,7 @@ static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
 	int i, n;
 
 	/* recognize hard coded LLVM section name */
-	if (strcmp(sec_name, ".arena.1") == 0) {
+	if (strcmp(sec_name, ".addr_space.1") == 0) {
 		/* this is the name to use in skeleton */
 		snprintf(buf, buf_sz, "arena");
 		return true;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index efab29b8935b..36e26f4f5997 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -498,7 +498,7 @@ struct bpf_struct_ops {
 #define KSYMS_SEC ".ksyms"
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
-#define ARENA_SEC ".arena.1"
+#define ARENA_SEC ".addr_space.1"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
diff --git a/tools/testing/selftests/bpf/bpf_arena_common.h b/tools/testing/selftests/bpf/bpf_arena_common.h
index bcf195c64a45..567491f3e1b5 100644
--- a/tools/testing/selftests/bpf/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/bpf_arena_common.h
@@ -32,7 +32,7 @@
  */
 #endif
 
-#if defined(__BPF_FEATURE_ARENA_CAST) && !defined(BPF_ARENA_FORCE_ASM)
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && !defined(BPF_ARENA_FORCE_ASM)
 #define __arena __attribute__((address_space(1)))
 #define cast_kern(ptr) /* nop for bpf prog. emitted by LLVM */
 #define cast_user(ptr) /* nop for bpf prog. emitted by LLVM */
diff --git a/tools/testing/selftests/bpf/progs/arena_htab.c b/tools/testing/selftests/bpf/progs/arena_htab.c
index b7bb712cacfd..1e6ac187a6a0 100644
--- a/tools/testing/selftests/bpf/progs/arena_htab.c
+++ b/tools/testing/selftests/bpf/progs/arena_htab.c
@@ -22,7 +22,7 @@ int zero = 0;
 SEC("syscall")
 int arena_htab_llvm(void *ctx)
 {
-#if defined(__BPF_FEATURE_ARENA_CAST) || defined(BPF_ARENA_FORCE_ASM)
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) || defined(BPF_ARENA_FORCE_ASM)
 	struct htab __arena *htab;
 	__u64 i;
 
diff --git a/tools/testing/selftests/bpf/progs/arena_list.c b/tools/testing/selftests/bpf/progs/arena_list.c
index cd35b8448435..c0422c58cee2 100644
--- a/tools/testing/selftests/bpf/progs/arena_list.c
+++ b/tools/testing/selftests/bpf/progs/arena_list.c
@@ -30,13 +30,13 @@ int list_sum;
 int cnt;
 bool skip = false;
 
-#ifdef __BPF_FEATURE_ARENA_CAST
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
 long __arena arena_sum;
 int __arena test_val = 1;
 struct arena_list_head __arena global_head;
 #else
-long arena_sum SEC(".arena.1");
-int test_val SEC(".arena.1");
+long arena_sum SEC(".addr_space.1");
+int test_val SEC(".addr_space.1");
 #endif
 
 int zero;
@@ -44,7 +44,7 @@ int zero;
 SEC("syscall")
 int arena_list_add(void *ctx)
 {
-#ifdef __BPF_FEATURE_ARENA_CAST
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
 	__u64 i;
 
 	list_head = &global_head;
@@ -66,7 +66,7 @@ int arena_list_add(void *ctx)
 SEC("syscall")
 int arena_list_del(void *ctx)
 {
-#ifdef __BPF_FEATURE_ARENA_CAST
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
 	struct elem __arena *n;
 	int sum = 0;
 
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 5540b05ff9ee..969bc091060b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -19,7 +19,7 @@ SEC("syscall")
 __success __retval(0)
 int basic_alloc1(void *ctx)
 {
-#if defined(__BPF_FEATURE_ARENA_CAST)
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	volatile int __arena *page1, *page2, *no_page, *page3;
 
 	page1 = bpf_arena_alloc_pages(&arena, NULL, 1, NUMA_NO_NODE, 0);
@@ -58,7 +58,7 @@ SEC("syscall")
 __success __retval(0)
 int basic_alloc2(void *ctx)
 {
-#if defined(__BPF_FEATURE_ARENA_CAST)
+#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
 	volatile char __arena *page1, *page2, *page3, *page4;
 
 	page1 = bpf_arena_alloc_pages(&arena, NULL, 2, NUMA_NO_NODE, 0);
-- 
2.43.0

