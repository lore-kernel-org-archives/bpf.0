Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7B188596
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770682562; cv=none; b=H7BE+E52VubjxiuVGQC2Dt9XjK8yGojf7rEt0rru2g4EsGv5PHAch+QmVu6rDRaKdDacYKoGBALvcu4L5yyUlBI7RiztgIgOUHQdcj4Q1IlYsFWRqCDFVTIB0ZZQDGyDk75IG+7NZ+AYqN5MKJFc/8EKcPLEtRKfVN6PWm+9YA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770682562; c=relaxed/simple;
	bh=PsW1Yfep4EwRW0p8FAClalqH6GrejXGfFFTWywuZTnM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ZR6wy+UroOsAd/eAAye7FkXuWBs25bQP2YicYS0yyItR795QZHTxddVkqu3LMYnXvzuENQlt4Edbisd+iDHRnoNp6dBvz63gDtxtub42lAfe5+qL34RD/gTSluQgArn+rcurx6EI1OgCKAj7RSaY2uZcagfD7DHEkKp32mTCdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4b2eb9H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4b2eb9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EB8C116C6;
	Tue, 10 Feb 2026 00:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770682561;
	bh=PsW1Yfep4EwRW0p8FAClalqH6GrejXGfFFTWywuZTnM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=o4b2eb9HOkM9rzhs+rHjuMGo+iiTYxel1C9D2y3wzUSHaV/F7f2ZpOH8yBNxhk7gv
	 8NUZYFDniWDVWhFdsnLdiPg0QDxxBXBeNLSqyzZYEeiM/hOjeAGFzSX5M/66KK3fMJ
	 yaR5EfAZRzgnl8hHH2oSWwtiWilQmo3XzssNoMWV0Ld+++55tCUzOTo7y2tyVeH1Ea
	 j7kPfdxxy46qr3SCHmHhp7NQzcEXyyFc69zExk7NVPWPLNJ7dAiQQmTF0IGbufnAAy
	 E2enSyNweygXrbNj8CR2IXWJ/pel86q+4mY33qnsnCLohrw1Ie13H+owmjJpFloFF9
	 FylUHbJ6sfluw==
Content-Type: multipart/mixed; boundary="===============4131853003085178548=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c1132712047c148546e4da081ee8f2c33180faadfd08a2f581dfd5e5dc126d06@mail.kernel.org>
In-Reply-To: <20260209234850.2750149-1-emil@etsalapatis.com>
References: <20260209234850.2750149-1-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Add gating for arena globals relocation feature
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,martin.lau@kernel.org,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Feb 2026 00:16:01 +0000 (UTC)

--===============4131853003085178548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b842b83e2480..b1a088dd83ac 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c

[ ... ]

> @@ -581,6 +670,9 @@ static struct kern_feature_desc {
>  	[FEAT_BTF_QMARK_DATASEC] = {
>  		"BTF DATASEC names starting from '?'", probe_kern_btf_qmark_datasec,
>  	},
> +	[FEAT_ARENA_GLOBAL_RELOC] = {
> +		"Relocatable arena globals support", probe_kern_arena_global_reloc,
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In the v1 review, Andrii requested naming the feature based on what is
being detected rather than what the feature is used for:

    "we don't detect 'relocatable arena globals support', we detect if
    ldimm64 allows full range offsets, so call the detector as such
    (i.e., what you detect, not what for you are doing that)."

https://lore.kernel.org/bpf/CAEf4BzYz3KBUyqR+OJCMns2Edsd+Dhyij=f8cqSEyY9OG0KCdw@mail.gmail.com/

The feature name and description still describe the use case rather than
what the probe actually detects (whether ldimm64 allows full range
offsets). Should the naming be updated to reflect the detection
mechanism?

> +	},
>  };

> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index fc59b21b51b5..e0223a6e4c95 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -392,6 +392,8 @@ enum kern_feature_id {
>  	FEAT_ARG_CTX_TAG,
>  	/* Kernel supports '?' at the front of datasec names */
>  	FEAT_BTF_QMARK_DATASEC,
> +	/* Kernel supports relocating arena globals to end of the arena */
> +	FEAT_ARENA_GLOBAL_RELOC,

Same naming concern here - the comment and enum name describe the use
case rather than the actual detection mechanism.

>  	__FEAT_CNT,
>  };


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21845712046

AI-authorship-score: low
AI-authorship-explanation: The commit follows established libbpf feature probe patterns with appropriate technical detail and changelog formatting typical of experienced kernel developers.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Unaddressed maintainer request regarding naming convention - feature name describes use case rather than detection mechanism as requested by Andrii Nakryiko.

--===============4131853003085178548==--
