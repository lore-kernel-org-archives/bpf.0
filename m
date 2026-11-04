Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753067;
	b=BJHhf3JmNmOYtuOnXeNTpx0NG5WyQ8sWUgc2HXuAI9dTkZcjb8fb4EgquYcS0T6RL1XV
	 6v+mBglvR2UpjUF7Q4NOvS4cHuHm/as9qhfmYft7tMpLPpHouSKpf+QfbD5FhXtyR2oPN
	 yS5aPHG3yBAGDMLeoI5Hunp7obdzGg+RSmV+cGf1/ifB+TDTzD+TZ7bfOtYsYBsiV/Lxi
	 kZwN9xDCJiL4D1Vq2XB5e4fv5SaAt73vuda8X1CZXXrmFWNzAhT1L1pPBldnv+xqgqpyM
	 6fcoO7HNZIlOrf70dkj4BetRTc6DeNBqmFkVK7aGlhUbLFxZco5XBL8DuGYs1hhH7cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=EXDY9w4RlOwbfIpRjyMCCd2SiyWv43JxMOCKrc3iaW8=;
	b=zEsBW6nHBCMWffFaNGiR+kJpl+9/XllRFsr4xe4VFCR5C8p9vlaAz4eE/LTXGejeNl5l
	 tuvRJ6jzbYYYS1DTW0Eckr5Z27GGDadkMntU7+bO1Aw0AUW9m0y07pMvFrVtHUdgDQYEP
	 Hy/QjdSRkXIKL51xHmPT2+JxnCL8X+7EFhodlgk+fC521/mdc+fQ8b68MgSxmvCXbQMRa
	 n/0lI8qiF9Oefp8efel+Wrqy443/LxI4eWowna1Sl5Cpq0cZXO1yd9cXbnJVer1PEHmjA
	 H2SH9m67UtT3jqr62r4uXrwoCRzZMkPiuS2Kc3+YpotGsRms5MXkaus/rTCrNvoVfZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ngl98GbZ;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4566D606A328
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4566D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ngl98GbZ
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso150308a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 16:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753066; x=1794357866; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EXDY9w4RlOwbfIpRjyMCCd2SiyWv43JxMOCKrc3iaW8=;
        b=Ngl98GbZWvNp9KhithH0kX4jd3+dZnpMCeIFB+t85NCm271/mMF0fbRM4Mdf1r79jD
         g1AW9F15+84oH2lsdNfLTHD+JPME6Zp/9cO6z2r3QYVx1uoPF5jCSXmstXi7P+zxfVJk
         hWVOnUb2UIPIHAZL9unt2/Fnlw9PB2pgXeyKggwdtCsqHKyKIgKMmhpE06+Q4xzHzG3V
         YOPj/VPOWjkcfQPxAjEnJltGIDXPYrdzgLIRm5598V1Ur3yE7xZRQqFAbtajb+0L2vTD
         JUtGD6RO401EaI7b8ed08LEGDXgy+ms8UzAMBzxC+xFu0OhMvTqEVxbGGUJE8yVuHR0s
         zutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753066; x=1794357866;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXDY9w4RlOwbfIpRjyMCCd2SiyWv43JxMOCKrc3iaW8=;
        b=CLPJhfb9kG5yrqDSNY/VTIvB/BNitifEMJaC8lacIpjSTei8KmFOYo1X8l3IiuoE/L
         TSTEssEBQl7gpEcxVHCE7uI/HKXLTq3UHZuQQe2J5ZuPQlVuUepEHBfa8VSN1PbKLkhx
         gxcbGXA6duubm/Vick9B3G8sDYT9FXCs7P67j71y9gNatH2vUxRo40VKSsZaaPB+2l93
         goS+WXmAFdjdtqrW0wsuiJ0Cca7u585+rqoZFs2zLnouZDCWhuHZp8EAX5syIC6NHuIo
         KNMQQUp6nV9dUtOobbSx3x2kYhV9qG3TbMv2yL+f46xi7xG8F6Z9Tm+wEmzlWblvGNdb
         RHjQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4ngO/7ygF93fHkEdM0uWvatNpJGZGM1puBVzdGHDXwnS4PVLVWptqqK91F+aWJHy5ccs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7b2fOPLshy16Wu49LzDo2Qs3VJVf0AnzJB4PWX7yJvcrVpJ8k
	8jFhAENC+xO6ZyP0JVVFlKyhH1Rqm7o1UXp1BDiG0vDJuwebMEjL8c39
X-Gm-Gg: AYBFou1iGk0uV518w8vvla4dikcXTCZxyWNuNem0Sqrn0xQuaJ4L2lAAxd65yuBnbSh
	aGufheN8GR4w8oougpCJ5Ndx2BAzgLYK9Oh/CaUNDCFaIG7mMDmy9CA/B83MM38YLMXawLOeeyq
	OhVseA3If0b7k6kDrp67LMd+SAOhm74BPoB9PpMAfoSW9EQUFflJ4mNiFkmYFdOcV69oyt9n9KU
	6W1IJcqA4Div2cv6nHKxhKwJ7wnKP9EKgpSwm6YhABH8B19l6Bo3wGgfy17sROqubJlBBoPmzEs
	I+GF7nNGdezdbmwzsJI+0vZpFApn/15KZgPCXs5v+hIzAQkpuRVs5F5zPpLAcJjRsWw7uVODJ79
	I7ZcFgjOZQYt1mNDR1SOOSor32K22hqXRBrYxT3dYdVOPmj8YIjA5lUM5cr3COc6bwMvmDszzla
	wGsAoTbJjbLwtneejiRVfrxEp5Pa7g1SFzBVy/BQQnx/39IAcrECm9+ROBlHITFRYX7cSCp9ofI
	u/y9uKQZLMOmeoa1lPfoWeflkRf1PMHXnadsITJ8FLxqPDABHVHO9RXbnVxXQ5g02Kqm7NoH8VG
	U+WINtjY+5dykyB0TRsbdztf0+Zw9FZ4a7+ofYZAstFl7G7hoypca2C248mbKxqMvE9PtmreFpE
	Lo66+izeNOgEMXJQ6EAq59Qac71y2b6G+TK0=
X-Received: by 2002:a17:90b:1845:b0:3a5:133:ca5f with SMTP id 98e67ed59e1d1-3ae89787ea2mr10693463a91.46.1793753066335;
        Tue, 03 Nov 2026 16:44:26 -0800 (PST)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094d572e7sm567255a91.1.2026.11.03.16.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:44:25 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:44:25 +0000
Message-Id: <DMM0E6AA3KB6.28SYB9X6ZYIHL@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Account for zero extensions in
 patch list expectations
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Hungyu Lin" <dennylin0707@gmail.com>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <iii@linux.ibm.com>, <bjorn@kernel.org>,
 <pulehui@huawei.com>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20261103215309.19950-1-dennylin0707@gmail.com>
References: <20261103215309.19950-1-dennylin0707@gmail.com>
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

On Tue, Nov 03, 2026 at 01:53 PM Hungyu Lin <dennylin0707@gmail.com> wrote:
> patch_list_insert_in_front() checks the translated instructions around
> the call of an inlined bpf_loop() and its callback. On s390, the verifier
> adds zero extensions after the two 32-bit register writes in the loop.

Thanks a bunch. Applied.

But could you follow up to
remove the two 32-bit writes from inline_bpf_loop().
'w7 = 0' and 'r7 = 0' do the same thing.
'w0 = -E2BIG' is an old bug. bpf_loop() returns long.
The helper returns 0xfffffffffffffff9.
The inlined code returns 0xfffffff9.
So 'long ret = bpf_loop(...); if (ret < 0)' misses the error.
The "over max limit" check in prog_tests/bpf_loop.c doesn't see it.
The prog keeps the result in an int.

No other insn of this prog writes 32 bits.
With 64-bit writes the xlated code is the same on all five archs.
Then no need for the #if and the second copy of the expectations.

Something like this (compile tested only):

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6b719a2..321624a 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2783,7 +2783,7 @@ static int inline_bpf_loop(struct bpf_verifier_env *env, int position,
 	 * expected number of iterations is too big.
 	 */
 	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JLE, BPF_REG_1, BPF_MAX_LOOPS, 2);
-	insn_buf[cnt++] = BPF_MOV32_IMM(BPF_REG_0, -E2BIG);
+	insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, -E2BIG);
 	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JA, 0, 0, 16);
 	/* spill R6, R7, R8 to use these as loop vars */
 	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_6, r6_offset);
@@ -2791,7 +2791,7 @@ static int inline_bpf_loop(struct bpf_verifier_env *env, int position,
 	insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_8, r8_offset);
 	/* initialize loop vars */
 	insn_buf[cnt++] = BPF_MOV64_REG(reg_loop_max, BPF_REG_1);
-	insn_buf[cnt++] = BPF_MOV32_IMM(reg_loop_cnt, 0);
+	insn_buf[cnt++] = BPF_MOV64_IMM(reg_loop_cnt, 0);
 	insn_buf[cnt++] = BPF_MOV64_REG(reg_loop_ctx, BPF_REG_3);
 	/* loop header,
 	 * if reg_loop_cnt >= reg_loop_max skip the loop body

