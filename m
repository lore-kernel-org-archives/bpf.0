Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914524;
	b=z0oliQfZ6/Nn/elFVPVxii/3Ydyc5fuq87T191LV6pgsfa8GBPcLqnI8Opk3v0pUx7x2
	 UnXc50m2sTtrlalVeYcttgP5RK55tl1h+ZA96fpxCNBmbn29rCWKiiNOBdEBOF75YXpN8
	 Hi8xRx8a8UZy8b4sF2UZVnBspRhI/2ToF6KcvUEgA9HLemY2uuytferf2DcW6v819q3/W
	 XaERoFzsPEV0NN2vrMBg7gnR7FZlR15KV+alCsktLtWHdhfael8i+ZESph4ef9L+hbL8j
	 dVZqYeMngaH2LpeXMpfJwg3VS935a43EJ6qag8QvosFvQedVxcIJdUPZri+Ig6KbsYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914524;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=eTfcO8nYDMz5jNRQuPOXCgVW2fz7SjC57Qoa9TEuR78=;
	b=QlWGsKMOrtdBZsoYTHCn1CYl4SXpM6GLxqp9RkAIhFstt3soGEbqldRAXGrjndFlSr94
	 +RpFWhr5ieFJCMDCO8pvHTdq7I8xIIQvWHlvZExWVMYebs/jSQDeaXz/HBlqXLLdcDg6v
	 k1HwTfIHy8ETBhtUcI36OlvKvs0fzv57T7EXZKjyj10RrlCiT4agy8QHGunlEQI2MS1yr
	 iYfa22Yf4Rk7LFkFBszRhYgOzvjO3nl5teaOOO2g4QOvZNYUSsAA6+ExGEitEZRFHZ21x
	 1/C/cOhpKyoR1LMJPsslWJrQD6jYQ0reoyMd9g4upe9Pz32Y8Ft65JIfTbeJQgfYDAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRS8oIWq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F26606A338
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRS8oIWq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C911F0089F;
	Thu,  5 Nov 2026 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914523;
	bh=eTfcO8nYDMz5jNRQuPOXCgVW2fz7SjC57Qoa9TEuR78=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mRS8oIWqJENbE23ejmZ10pDhO7m/WBVG85pPit2AVwINVegcSp/hntYoCcC81NwQz
	 L9WJ/xDgi1+pWdd3pIeiI2/sPcWvE7Eur5HX1r/cuYS22+y66Wtx4rEoTH9o5e8c56
	 19vl38XEO8WDMZMbGU6d4iyR9bQdIxgXvKq86nKjDxrnvAD5J5ZmUaxOznNFMGZEHF
	 epZWE3AQR0IevEj1Dc+Tum6pvYNqhY/tHt+XO2eHdGQhs3hHfCl24fXfANKgQDu/49
	 8jo0XNC0AY1Dw7P936xObXTaQiWcPALVfM+YE5+V60buppTct6poj3wrkZ2ioKo04v
	 Z0/lpfvG9BWIQ==
Content-Type: multipart/mixed; boundary="===============1666183372540376568=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e0193c1b788365ddbef5cf2b178ea38ef239dd0ab2139e836ced033ccd3be50e@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-18-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-18-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 17/35] bpf: Enter and leave loops in the main pass, build flow.c
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:23 +0000 (UTC)

--===============1666183372540376568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Enter and leave loops in the main pass, build flow.c

TL;DR: Unused variable per_trip in bpf_flow_loop_enter() may trigger a
set-but-not-used warning with W=1, which is an error under CONFIG_WERROR=y and
could break bisection; suggests moving it to the later commit that uses it.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +int bpf_flow_loop_enter(struct bpf_verifier_env *env, bool *backedge, bool *drop, bool *ends_walk)
> +{
> +	struct bpf_verifier_state *cur = env->cur_state, *entry_state;

[ ... ]

> +	u32 trip;
> +	u64 per_trip;
> +	int err;

[ ... ]

> +	/* @per_trip: the insns of one iteration, times the walks around the loop. */
> +	per_trip = flow_walk_factor(cur) * loop->nr_insns;

Is per_trip used anywhere in this commit?  It is declared and assigned in
bpf_flow_loop_enter(), but nothing reads it here.

With W=1 the build should report "variable 'per_trip' set but not used",
and with CONFIG_WERROR=y that becomes an error, which would break a W=1
bisect build at this commit.

The first reader appears later in the series, in 6e67faec5844 ("bpf: Keep
the count of a loop when a register has no closed form"):

    if (err == 2 && per_trip <= BPF_FLOW_MAX_WALK && ...)

Could the variable and its comment move to that commit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============1666183372540376568==--
