Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664419;
	b=XttlZmTxJJ+Sa3Kkd7VoGYvdJ0Noq4vdMOZn8ibZxvcAAp8OKPfrCJLg2IdaDw149d08
	 1QF+XPTI82gnrHNS59RhoKAvEICBsz5s/VKum3HKxWgtjiYlpPdMGvZ/wpHyihtBFghUi
	 5emUXRByLsL9RQFGyazQSVUCcyseLecBaCcqOqSP9nBC3WL0F7v7xWUbza/FzuwpuezSf
	 iq7l+FLqQE4DsrZniI2C2Mfa3/k6lBPKkkBz12TDj1qkZeK7bW4xJ6y+cyS6RKfTnIbPL
	 zJoNiyhH0AbglknXtly32Y+HTepaBSE/6o3Em1p/884zDuQauvjTY+85OSmXa+SpR9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EpSXrCFrU3s6PfZNUctQj8nq8UzW3mkfk3pre2dSBf8=;
	b=WhfqVrHUxXOfFgSYIaVlrcv2jphMZUfcX6TTX6nyZ9H5zTwruVBBLo0rwxvNtArOlu/f
	 BKjiv2PKx9p6uz2FNHme3B1lx164feOrZC/XJUtqzRaZA7xb6rkLrktD4RtEo59Lt3uZp
	 GJVUMcL+4FUB11Vqr2Sr4RQhlRQfMXReFmIyEyUlxc8oEXjnHTKNQH2IzjwC8kcrQmJI6
	 y2HiSfEocb6gfVL3bOToVfZRcuez7DgeuYswTQy66g36fu3U0PYUmfWJ5R8m+6AhGpKp/
	 akK4PJ8Spa8WgQfBVMHZcVdHpA2TFzVaasBgind0wMkoOgcQa/Q0j0C2cIBUg+QuylQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KAINYuZj;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4D606A326
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0C4D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KAINYuZj
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f052ae3c86so36101965ad.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 19:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795664418; x=1796269218; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EpSXrCFrU3s6PfZNUctQj8nq8UzW3mkfk3pre2dSBf8=;
        b=KAINYuZjzFzTcSB1W19MD7vR4KrjDmbv8GsH6sDtVjmIMhjr0wX/rkP0bq2kMmSDgY
         U+ie2Iv8tweqxtVI0igg7OivL7GDSeJQqQgvrvWmpkwr3GOypkJMAkPTpUXJwFKEhF1e
         cEfWw8A5ju2ndrUsicE2nAcV+QVr1nuf1P9rar74VCd9sIeHmf3XsvH3YCq1TvgpDIvy
         MEg7+ah7yjsU0QpY2bsD0/0I6r6eEO6uX2ve5AgrPnOsVWrDBbeSLDbaRvvbhz1poVrJ
         P941dttU6g0/HebTzwxYUvVHjm2oh/O8cy61vVJtqpAmVojYrkwI/HeEYvYB55o5gthT
         Uqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795664418; x=1796269218;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EpSXrCFrU3s6PfZNUctQj8nq8UzW3mkfk3pre2dSBf8=;
        b=YyxzSf3JVNORrflW2T8jkb1qdl0kGobAviGZ8Ybbb2HE50j819576NhOh7XYOMJ9Dr
         gOw57Hk/gAejH+GoEcNXUZ1Y/TSTqMkj93DjnI+j4d9lPagq/EYgjATSeuXyYALInbBE
         6pctoQvn2Ni190svuSDiO3uL342T88FAeREULq7BHC8eQcv0ct/+QTio7sU+wnBRauHP
         FJNuuRXlcIA3X64+i1S71L4ZvKYIKRtFmte/bDtzk4Qxu7d2hoE/IUdQRnJ/cjP6lbnJ
         Nmhay6g+T/Zua4ROCWlO5qyxNaRThcOXKFOd5JpcAU7Pw+xq1XjzN026r4WwxMMIo2Oa
         gRGQ==
X-Gm-Message-State: APuU4Z9MvNJgkCshZzbRa+iTvT5JJgLWI/ug9/rG4FyOs2XDVwnP1uBo
	UuEKvE2hNcVHhWoAj2L1km5jZKUXXZjPcMry50iUrLHqiCJL3x2Kg6/J
X-Gm-Gg: AZFdTZeVmVrLZvZrbVUzwbyvPr0iNbO1fTCxHJCSgPuddiFNTpbLK1l8UArm5Wrjjum
	hpGJ2iK+SOQdCS1kS4drFNP/WeBICXZgUH8N64nhiMRaGzF4y5S39eHDTdnHli+ArV72l4qn719
	s1TvZ/UJoAyPnrkYrM/Vlx1YDIbm+cnlr7OKtQybJZ0Q5hluCedOQ2cTuOFhmZQukoa0Ormo8Ch
	qlQUY9RyfKMrKb3mPule9vVEmNvoYBV986lrcS9fbZFyulLlZpNH0CvnG+z8yJkeeovJ6heV5RW
	2Ra6Sa50WiI71apklqsr3cz3CY9kj9G9bhWMWBrzRFV7/gIh/E92PDwfkzy/G3EsOqgF2a14Lhn
	/cefNxQh+O8Vc2x/DrLQnRix7KTkq6PQLjVF1oboFyj7+1kv2h+val2DQiHNIPqTBMMB41Q7u1m
	jSTu1DdT++0xw/C4s82ZnuKCcFIkZ873npMgA4j2hv5Y6jpwlQT6tfA9tNF30a/ucyXTYMNoSIz
	pF4h4c+DRRwvNbsO7rBgOrfljVw6FyvqKehmLnsKRf9Xc/6MFUp3VcfR0B1WDnx9ROgEFQfYx9a
	aSf/CPtkRMWqhvsZs2H2tZOVEhlRYmhdwzxBhW5lRDJSBfNvydDixW0oXs/iNBnrzY1xL9Pf9yR
	bCAiW73rwRYmEqMPgV2hWfFP/5C7m16loXA==
X-Received: by 2002:a17:903:4b04:b0:2e8:4040:792b with SMTP id d9443c01a7336-2f03f18dcbbmr192643845ad.22.1795664418052;
        Wed, 25 Nov 2026 19:40:18 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dc0f8sm95681235ad.27.2026.11.25.19.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 19:40:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 03:40:17 +0000
Message-Id: <DN4TWT5BB3DK.2AHODHZP7ADY6@gmail.com>
Subject: Re: [PATCH bpf 4/5] bpf: Emit nospec after BPF_ATOMIC stores to the
 stack
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Luis Gerhorst" <luis.gerhorst@fau.de>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>
In-Reply-To: <20261125-nospec-result-reply-d60fdc6da8ef@fau.de>
References: <20261125040820.947816-1-alexei.starovoitov@gmail.com> <20261125040820.947816-5-alexei.starovoitov@gmail.com> <20261125-nospec-result-reply-d60fdc6da8ef@fau.de>
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

On Wed, Nov 25, 2026 at 09:12 AM Luis Gerhorst <luis.gerhorst@fau.de> wrote:
> Would it not be possible to avoid the atomic/call-specific handling of
> nospec_result? We can patch in the nospec after the call (next
> patch) and avoid the speculative path analysis there. Then the design
> would treat all instructions that do safety-critical stores the same.

Yes. That is better. Patch 5 also rejects a bounded loop with such
a call when there is no CAP_PERFMON.

> In response to this you find a series that implements this idea. Main
> downside is that this requires a new instruction buffer in the
> environment, not sure if this is desired.

bpf_insert_insns() and the new buffer are not needed.
Here is what I did in new patch 4:

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 9d5f2774bf8f..8c3a17a05a4e 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -911,6 +911,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
+	bool nospec, nospec_next = false;
 	struct bpf_insn *insn;
 	u32 target_size, size_default, off;
 	struct bpf_prog *new_prog;
@@ -994,8 +995,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		enum bpf_reg_type ptr_type;
 		u8 mode;
 
-		if (env->insn_aux_data[i + delta].nospec) {
-			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
+		/* A call or an atomic gets its nospec in front of the next insn */
+		nospec = env->insn_aux_data[i + delta].nospec;
+		WARN_ON_ONCE(nospec && env->insn_aux_data[i + delta].alu_state);
+		nospec |= nospec_next;
+		nospec_next = env->insn_aux_data[i + delta].nospec_result;
+
+		if (nospec) {
 			struct bpf_insn *patch = insn_buf;
 
 			*patch++ = BPF_ST_NOSPEC();
@@ -1102,6 +1108,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			delta    += cnt - 1;
 			env->prog = new_prog;
 			insn      = new_prog->insnsi + i + delta;
+			nospec_next = false;
 			continue;
 		}
 
