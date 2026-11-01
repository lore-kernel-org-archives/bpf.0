Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793498329;
	b=jr0mLu5pP6jGj2ejLIhs7QeKROFe25iSxN7e4KwZUL4TsVpI4mWRD1MzReaeD5fG9JQg
	 Gi7l12CxIT9tzC4u1R+O7ZrA7vWo1OwcOQjuYxi1mxPDPYs+MxV42kFUxJ7tbctXb0afW
	 p9lILY8R69LRMy4yRGfDvsuMcoiTszT/ckxf6ILUusHbBfS3tWPqXWZL5wa67KPUfZP0l
	 OBDqdMLXeYix5iDshJSAmZVZnTpSiK2rOPwuo9ghLhSHi43dUgtFUEYAdZ6nc4AgEng+E
	 6LdboVS//NRcsAnKFMJU6Q14fvmrbGki1yshrth2BR1u1A9vRUeV2dBoVVy3Z2hN3Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793498329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=rOIWSuL2N1a+TYX1q0PtYO/YK05uUhrjj5MavVHBPr4=;
	b=tgjQNpRAgdK9DXclaiEbYrzZrrpLuxhPPCdgsRVXvD7oBVZtNw2aBzXY8n7XR/6SPLyG
	 60Pp1ToC50gjXwOJtwcz5Ct8M4AxF0gPtddSoKqsL+oKkY+MaKxoajZZhnDCMPXldwaJJ
	 kmuGnpQ7PB0BiBenT4SXmpEEqkzGLMHm/UZl9ucCOlyc71OP8Sepxs/JSMEp7ivOQ2kuH
	 lzBzOHNbXE6VpN1/WsFET/IeTd8JkVVnoQQ16NX/RUQCg00ocNoiyIoa806pZwJZJzql1
	 4raStjZD+khHdsNDHeOvkrz8j20c2ay7ggxcPnXky9EmyvaCzH1++l8FmKERLRS0jfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdod4j5S;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6169C606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 01:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6169C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdod4j5S
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adac5c10e3so1194962a91.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 18:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793498329; x=1794103129; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOIWSuL2N1a+TYX1q0PtYO/YK05uUhrjj5MavVHBPr4=;
        b=sdod4j5Sujls0jLTZ4rnZDwJZTLxKuMkDIg3UR2n8aW83kciygOSB18HhRqMzxv3/w
         lyGSBgvn4lXrrPG3EONsI7xfVYDWoTG4I9+L1vQvrM+0M4rJ+FBoHChekHgbzpFJyq7m
         KwFP63tG6lkmC+WBjNn3UjsLLmmu4yj8JwSe0gmTWkinEHi1yydyp31Qq+WFI+rPOUbF
         nCfI+VR5Ootxne2h61Hszt/XJLunuA2u3aE54PgWZ2QUbN7Te2u7p720LlE9qEe499Gg
         N393dZlmuIkBTbuh6aVwQEYMfb2l+4wR2iBPr0dFzDsGcwdPZjwUgRvijSW17ARZ0Lz5
         jLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793498329; x=1794103129;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOIWSuL2N1a+TYX1q0PtYO/YK05uUhrjj5MavVHBPr4=;
        b=GYiLZkB/mAkRa0puqiKk8QmfKri0leyOwUP76t1nF9Tt0Dl+g61LismwYVaNHvI0Af
         sKvq86tvPh7EQUBJtOWnkfleuxmxMYlrpkK0aLQWlsLv2yw2V4TIXBj6OtiRxxA509eo
         p2SWRMIoTs7i6KzfX8TI+VE0r5zfPcrKKsrEof3rfBQnhWSnxno4Sr3uFkUov3K/RZKy
         Wfi0+wSj64EVbWKMZTzPsd22/vmVQDLhyBNYsz4geZ24WN0e2T5gRG591/9g+a5OMQJ7
         +2bnbpsHUtHR4ao931jeviIsoITTmPStjuP3tdhfUIY0AM66tS5deiVmBnIdMluYU/0w
         UkCw==
X-Forwarded-Encrypted: i=1; AKwUvBw/9vO/NBujafstr5OgFGPzETa6AV7XsDEHpd03PBI8EasHE2O1ZrEql4a5964yxKrKRBM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YCOmF8apvv4rNBJYw5iPqFE82Ckv1lFVp6Ve4LYEXpBgKGeM+
	cW4bsPcNfvZq5ppkoxvuE+vGYdf7P4QqL+sC6k4i9pZ7+JhMG+aAMEFn
X-Gm-Gg: AYBFou2UyGLBfvJWZ3V9Ss+oz7orFKagbiSsJBfjziWqF2vhej5NHtuouFndG+9XT6m
	ZN2zROxZf7Uz/pcRSY0OD8sF9EDvg+y8kqU9GRMXcnLPOK+tF+T/fYQ2g9dkbotyVSGlueIMu6U
	V1Z8ELvT24NpJsBrtjWIqbZ4b67lhf+XP8vOmF5f51+uz8BqAaAFLqBaca+FhDlxQ4PnDb22eyv
	VHaRDF9m2p5HMXP9WcPCfiQh+d84E/BwEvooIewUYny9BqwkNV2UZ8//MgFu0dFNzL8ddgWkISb
	LKpjnITKYrlDJomGBn2xWBlR+gpgzEXU/4UfUs/2nlmCo08RQJvhAI573yzQsW1oPpgnloFI+kz
	9M3N/ombN4deIb969HORqNtqD/DbuN3F04ehoshe+UVvKtpQTAtO6klXnvQD+dT2waDf/TlIXkx
	o5PzYqUZkDak1n0ioS8+nXKEL5y62p004mhRxr6Se+56i4STy08Qhm3p2Yv/VusO1LyqFVwACH3
	Zb7e/fzZLVIQZeMuNv+0Gv8JbU5EAd6YZJkqPKxIWJr5nSeVsOZoTxGEk7FttXG88t7Pz4i6P9o
	Til2JkBl6Ssd5Vzpwjv7q/595AWaPFOdZJuJm7tPCEiMECYyLbyl0rCVD7nJ7+DdrKOIHbBMuy5
	6dhR4i8YwrY0TwNuotpGP+Wn59JvljLe/Bg==
X-Received: by 2002:a17:90b:4d05:b0:3ad:c482:ae93 with SMTP id 98e67ed59e1d1-3ae897f55f1mr5511772a91.27.1793498328478;
        Sat, 31 Oct 2026 18:58:48 -0700 (PDT)
Received: from localhost ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87ee7765sm5238022a91.2.2026.10.31.18.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 18:58:47 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 01:58:46 +0000
Message-Id: <DMJI3GWXQOC9.UA3K9X139AR@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Yonghong Song"
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Exercise stack argument
 precision on state reuse
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Xu Yunxiang" <xyx2021@mail.ustc.edu.cn>, <bpf@vger.kernel.org>
In-Reply-To: <20261027061303.1754535-3-xyx2021@mail.ustc.edu.cn>
References: <20261027061303.1754535-1-xyx2021@mail.ustc.edu.cn> <20261027061303.1754535-3-xyx2021@mail.ustc.edu.cn>
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

On Mon, Oct 26, 2026 at 11:13 PM Xu Yunxiang <xyx2021@mail.ustc.edu.cn> wrote:
> Build instructions and BTF directly so these tests run even when Clang
> does not yet support emitting stack arguments.

All other stack arg tests need a clang with __BPF_FEATURE_STACK_ARGUMENT.
This one doesn't have to be different.
No need for emit(), jump_to(), add_func() and a prog builder with five knobs.

>  .../prog_tests/stack_arg_precision_reuse.c    | 300 ++++++++++++++++++
>  1 file changed, 300 insertions(+)

300 lines of selftest for a 25 line fix ?
I feel our selftests are growing too fast.

Two asm progs in progs/verifier_stack_arg.c are enough. Like:

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 15a1249..abf319c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -552,6 +552,121 @@ __naked void stack_arg_may_goto_in_caller(void)
 	);
 }

+/* arg6 is an offset into the value of map_hash_8b. 0-7 are in bounds. */
+__naked __noinline __used
+static long arg6_is_map_value_off(long a, long b, long c, long d, long e, long off)
+{
+	asm volatile (
+		"r6 = *(u64 *)(r11 + 8);"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"r1 = %[map_hash_8b] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto l0_%=;"
+		"r0 += r6;"
+		"r0 = *(u8 *)(r0 + 0);"
+	"l0_%=:"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(map_hash_8b)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: a pruned state propagates precision of arg6")
+__failure __msg("invalid access to map value")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void stack_arg_precision_pruned_state(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 0 goto l0_%=;"
+		/* Path 1: arg6 = 0. It makes arg6 precise at l3. */
+		"*(u64 *)(r11 - 8) = 0;"
+		"goto l3_%=;"
+	"l0_%=:"
+		"if r0 == 1 goto l1_%=;"
+		/* Path 2: arg6 = r6 = 0. Pruned at l3. It has to make r6 precise at l2. */
+		"r6 = 0;"
+		"goto l2_%=;"
+	"l1_%=:"
+		/* Path 3: arg6 = r6 = 8. Out of bounds. */
+		"r6 = 8;"
+	"l2_%=:"
+		"*(u64 *)(r11 - 8) = r6;"
+	"l3_%=:"
+		"r1 = 0;"
+		"r2 = 0;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"r5 = 0;"
+		"call arg6_is_map_value_off;"
+		"exit;"
+		:: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
+/* The same, but backtracking of r1 sees a store through r1 and marks all scalars precise. */
+__naked __noinline __used
+static long arg6_is_map_value_off_fallback(long a, long b, long c, long d, long e, long off)
+{
+	asm volatile (
+		"r6 = *(u64 *)(r11 + 8);"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"r1 = %[map_hash_8b] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto l0_%=;"
+		"r1 = r0;"
+		"*(u8 *)(r1 + 0) = 0;"
+		"r1 -= r0;"
+		"r1 &= 0;"
+		"r1 += r6;"
+		"r0 += r1;"
+		"r0 = *(u8 *)(r0 + 0);"
+	"l0_%=:"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(map_hash_8b)
+		: __clobber_all
+	);
+}
+
+SEC("tc")
+__description("stack_arg: forcing all scalars precise covers arg6")
+__failure __msg("invalid access to map value")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void stack_arg_precision_fallback(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"if r0 != 0 goto l0_%=;"
+		"*(u64 *)(r11 - 8) = 0;"
+		"goto l1_%=;"
+	"l0_%=:"
+		/* Out of bounds. Must not be pruned at l1. */
+		"*(u64 *)(r11 - 8) = 8;"
+	"l1_%=:"
+		"r1 = 0;"
+		"r2 = 0;"
+		"r3 = 0;"
+		"r4 = 0;"
+		"r5 = 0;"
+		"call arg6_is_map_value_off_fallback;"
+		"exit;"
+		:: __imm(bpf_get_prandom_u32)
+		: __clobber_all
+	);
+}
+
 #else

 SEC("socket")

Patch 1 looks good.

pw-bot: cr
