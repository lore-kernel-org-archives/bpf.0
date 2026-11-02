Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659087;
	b=UKN7nbZrKQjKgdkDX70JY9axKXNV36WoZSaTsM9PJg/KnowfQ33/sdv7R5e9eC7MvvHb
	 e/FYG6nlNWYdAdHsOC/iIPgCxI0o/St5QIB43gUunFcZEbuJcEaOg5IgP3KNHlMk45vBq
	 W+R5lnSsYc/XSbSR2axtIchZNHbxM0bt0zL/UNpPYW2kH9KICEdRKauSMT8JEWksZ3rg1
	 rf74GcCknfefZzbls5GXJo47iz+lgUJsgdfM5GUs7/8x6tA1CzxzsamtevF7X7WpPI4Bp
	 DmGIVtwen9czc3GpW2Orol5L8s5vsbcogA6V6TiHLnMkytaS8pHDhjeZBuI9vTp4tcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=h+ZF210fax8HjS8szV9XHjrNkBuZH/bj1V8SNZNkYcY=;
	b=ILmwxgAkyey/x+mlml57K0oEHBoChybpkz2n7w8peiwckbXImAwQH3x3+gMoNWquim2J
	 1kJzevefHgUBNy/Fabj/sMX2/nWi1I1ibSMxNYS7iDlxehqfuhkYkT5gQaX3lhevYtmrs
	 VMnqVpRwvGdjQzzTjiQ6TwXwjNdZz9GhyX6MzBfO0hUqKBFbKIugiUY8/7njZo/m94YQi
	 F0LaBE4dX+7BtjegTN+h1qdT4NhMpoTbj9Pmokb5tw19vvhoYPKXS9tQucwsHl9vv6jyB
	 81vKpS1PxxRbU539DVLuexAYLKvRSb/SZkGr1V1FFy25neBiIltv3Vk2QrnE0fd0SQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvJUmZK9;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F3606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF8F3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kvJUmZK9
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so1051800a12.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 14:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793659086; x=1794263886; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h+ZF210fax8HjS8szV9XHjrNkBuZH/bj1V8SNZNkYcY=;
        b=kvJUmZK9vmuMJAdL0K4EFwjLGSetSR58lljEn9BsFrCBTRaoiP+Q1QDXZTajenGWBW
         JC5oooWXUbO2abypveTsQu6paZzBPM0fC4UoUzM82GBbBxtnzIbtPgJsKTpVMfr+Wlp+
         Zjks5E32OWXwRfoMX6veCGB9+HBplceJGXbJsdd1Pt7jVsOjmZRYA4QYT4m1JPIdzz27
         BqC7LSsHg7jcOG1jNIIaqz8LnYOhtOv5KoMYd9u2gkUPvRcqquk5TfJRT+mqzTbwAU0D
         hQ+6E+jAwKRaGtpsRaXZZG/JIipaJt7k9BFt5sqsj18xnSIawpZM6gyf5w/WaD+SAtsg
         Cl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793659086; x=1794263886;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h+ZF210fax8HjS8szV9XHjrNkBuZH/bj1V8SNZNkYcY=;
        b=E8MQ6mw5RBjnK2JC/RwKNIi95FKr/7sra9G0I00gE+d9cK4f2QunSwHiIluq9x8tHB
         x3y1GALEwUjIHB0EZL5EVmBDB+4D/4DMx7Sjhrz9RFMOxPH8bxQ1t3CCXX2CsrZkMuK+
         6nrgeq6xRrwgMlffGLanGWe3xAkimwEMNgmFBPSD1MycrZSYoEvkJ/aFDQx1H5Ee4SGK
         VdmB6YirxnXwAn6wu067UUj3kMC4v+EWmCs+hHKGqvPgD5rH+yBZfpBiQnBxrKbAaSuu
         1ImvebI0sofAiKjmWOJXREk85ObMMLhqNtsMSeLE3lA7SGu1b0tJNeUBItuiOwJSwEMD
         RSFg==
X-Forwarded-Encrypted: i=1; AKwUvBycbgR3nsGVQlD+Ot2gRiF1ozWCoJPASmurbs+r9KOfVxN+GJr1SAUxGPGCIeVHY/O8flw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ79H5T9yeuuBOP4DlmMbFkInb0D1dW4ihZoS9J7LfVg5GQS/rH
	falm3ZQLdeGZYpI3lrFPV2oA05LdeU6qy8itHXOUIwUIRrE/EiyrynB9
X-Gm-Gg: AYBFou1ZdsN7AiS+c5yH2bZjqA4URdCSgeq/HaYHD7SA9dUlXXiVLCndTzCfKfOCb++
	LaO18abFDmr1qLS4gurBjHjJFp0NLy83s7ZE8tED647affuYHNLhktIyU15xMXsrVu1Gw0G9o1Z
	KQfyhVE8HvutKmIDROVXa7WugjfgRag96A1JkMsEUaswuO8+00W6wJ3WKRs2rKfHVlTh9DlaqCw
	Z/a5BvrHiccWGTKQV5O/eUlmT7AuN26AsrPgJ+9afHcfUz5G2xv67VqMmjo7LYXNucu16taPo/9
	35iKP7kdey9Nc4YECOM1qxYweYkkzGc0l6b+VZ/KAKtvKHYDhtN3+wU1Im/lNCMUsT6mGRyz3IC
	By5SVElAjhBWNgAf+XC1Ak/OQTBIoWfnbX6FlVBiBsve+V9d3GpFc1/RTFN82gW3UkPg6IRcT9o
	GxmTeVXIYgnEdGCCbdfpLoWGlAutlCx+biiz+dyljbv6xqnLgtXTwSXORkCP/dP2Xbfm+1vNLFP
	pQDUFFVViuZOCXcG+b6y5GCmvgDx0hlzYTQqwqlRCUL0SfyAgS9vyu9Sa3e6AJ14+2PHwZfC1ln
	+KAzdFtsgb+cED1wQ5ynXvex11BlHZ37QuzWQp5Uq2ui8Ih4aBXfplITUeXuuJ24PMoeDygrhfK
	kTDpT6RiPo5WvTn0Jm1K6ShhvwhMf6ZmVPA==
X-Received: by 2002:a05:6a21:39a:b0:3de:b120:bb88 with SMTP id adf61e73a8af0-3e928b88d42mr9530537637.2.1793659085876;
        Mon, 02 Nov 2026 14:38:05 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aadac9c505sm2511972b3a.53.2026.11.02.14.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 14:38:05 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:38:05 +0000
Message-Id: <DML32WAB5JZD.1LR3JA1OYY6A5@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>, <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <jose.marchesi@oracle.com>, <david.faust@oss.qualcomm.com>
Subject: Re: [PATCH bpf-next v3 4/8] selftests/bpf: make arena_base() opaque
 to GCC's -Warray-bounds
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <20261102220717.4079739-5-vineet.gupta@linux.dev>
References: <20261102220717.4079739-1-vineet.gupta@linux.dev> <20261102220717.4079739-5-vineet.gupta@linux.dev>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 02:07 PM Vineet Gupta <vineet.gupta@linux.dev> wrote:
> The barrier is behind #ifdef __clang__ so clang keeps the plain macro.
> It does not need it, and the barrier is not free: it blocks reuse of
> the map address, so each call site reloads it.  Across the five progs
> and 20 call sites that is +35 instructions under GCC
> (2528 -> 2563), about 1.4% on those objects and nothing elsewhere.
> Clang output is unchanged, bit for bit.

stream.c already has barrier_var() for both compilers.

How about this one instead:

diff --git a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
index 82aafe8..0eba529 100644
--- a/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
+++ b/tools/testing/selftests/bpf/libarena/include/bpf_arena_common.h
@@ -49,7 +49,16 @@ void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cn
 int bpf_arena_reserve_pages(void *map, void __arena *addr, __u32 page_cnt) __ksym __weak;
 void bpf_arena_free_pages(void *map, void __arena *ptr, __u32 page_cnt) __ksym __weak;

-#define arena_base(map) ((void __arena *)((struct bpf_arena *)(map))->user_vm_start)
+/*
+ * The map definition is smaller than struct bpf_arena.
+ * barrier_var() hides that from -Warray-bounds of GCC.
+ */
+#define arena_base(map)							\
+	({								\
+		struct bpf_arena *___arena = (void *)(map);		\
+		barrier_var(___arena);					\
+		(void __arena *)___arena->user_vm_start;		\
+	})

 #else /* when compiled as user space code */

diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 1ae015c..b4d88d0 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -178,16 +178,8 @@ __stderr("Call trace:\n"
 "|[ \t]+[^\n]+\n)*}}")
 int stream_arena_write_fault(void *ctx)
 {
-	struct bpf_arena *ptr = (void *)&arena;
-	u64 user_vm_start;
+	u64 user_vm_start = (u64)arena_base(&arena);

-	/* Prevent GCC bounds warning: casting &arena to struct bpf_arena *
-	 * triggers bounds checking since the map definition is smaller than struct
-	 * bpf_arena. barrier_var() makes the pointer opaque to GCC, preventing the
-	 * bounds analysis
-	 */
-	barrier_var(ptr);
-	user_vm_start = ptr->user_vm_start;
 	fault_addr = user_vm_start + 0x7fff;
 	bpf_addr_space_cast(user_vm_start, 0, 1);
 	asm volatile (
@@ -212,16 +204,8 @@ __stderr("Call trace:\n"
 "|[ \t]+[^\n]+\n)*}}")
 int stream_arena_read_fault(void *ctx)
 {
-	struct bpf_arena *ptr = (void *)&arena;
-	u64 user_vm_start;
+	u64 user_vm_start = (u64)arena_base(&arena);

-	/* Prevent GCC bounds warning: casting &arena to struct bpf_arena *
-	 * triggers bounds checking since the map definition is smaller than struct
-	 * bpf_arena. barrier_var() makes the pointer opaque to GCC, preventing the
-	 * bounds analysis
-	 */
-	barrier_var(ptr);
-	user_vm_start = ptr->user_vm_start;
 	fault_addr = user_vm_start + 0x7fff;
 	bpf_addr_space_cast(user_vm_start, 0, 1);
 	asm volatile (
@@ -252,17 +236,9 @@ int stream_arena_load_acquire_fault(void *ctx)
 		.off	 = 0x7fff,
 		.imm	 = 0x100,	/* BPF_LOAD_ACQ */
 	};
-	struct bpf_arena *ptr = (void *)&arena;
-	u64 user_vm_start, val;
+	u64 user_vm_start = (u64)arena_base(&arena);
+	u64 val;

-	/*
-	 * Prevent GCC bounds warning: casting &arena to struct bpf_arena *
-	 * triggers bounds checking since the map definition is smaller than
-	 * struct bpf_arena. barrier_var() makes the pointer opaque to GCC,
-	 * preventing the bounds analysis.
-	 */
-	barrier_var(ptr);
-	user_vm_start = ptr->user_vm_start;
 	fault_addr = user_vm_start + 0x7fff;
 	bpf_addr_space_cast(user_vm_start, 0, 1);
 	asm volatile (
@@ -296,17 +272,9 @@ int stream_arena_xchg_fault(void *ctx)
 		.off	 = 0x7fff,
 		.imm	 = 0xe1,	/* BPF_XCHG */
 	};
-	struct bpf_arena *ptr = (void *)&arena;
-	u64 user_vm_start, val;
+	u64 user_vm_start = (u64)arena_base(&arena);
+	u64 val;

-	/*
-	 * Prevent GCC bounds warning: casting &arena to struct bpf_arena *
-	 * triggers bounds checking since the map definition is smaller than
-	 * struct bpf_arena. barrier_var() makes the pointer opaque to GCC,
-	 * preventing the bounds analysis.
-	 */
-	barrier_var(ptr);
-	user_vm_start = ptr->user_vm_start;
 	fault_addr = user_vm_start + 0x7fff;
 	bpf_addr_space_cast(user_vm_start, 0, 1);
 	/*
@@ -346,17 +314,9 @@ int stream_arena_cmpxchg_fault(void *ctx)
 		.off	 = 0x7fff,
 		.imm	 = 0xf1,	/* BPF_CMPXCHG */
 	};
-	struct bpf_arena *ptr = (void *)&arena;
-	u64 user_vm_start, val;
+	u64 user_vm_start = (u64)arena_base(&arena);
+	u64 val;

-	/*
-	 * Prevent GCC bounds warning: casting &arena to struct bpf_arena *
-	 * triggers bounds checking since the map definition is smaller than
-	 * struct bpf_arena. barrier_var() makes the pointer opaque to GCC,
-	 * preventing the bounds analysis.
-	 */
-	barrier_var(ptr);
-	user_vm_start = ptr->user_vm_start;
 	fault_addr = user_vm_start + 0x7fff;
 	bpf_addr_space_cast(user_vm_start, 0, 1);
 	/*
