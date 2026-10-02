Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610971FDE31;
	Fri,  2 Oct 2026 05:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790918179; cv=none; b=LuZ9cKfBrDF2uS4OXashBaM+enaTU00MSbM+8T0XCWLp3p0wqIsaEFkfwxMx0wpBw4RSzJyuZJMnUIXTkCmSCa6QIa4FdeacSS4Mf/S9MDBhp8v5rlPXTJrDKeaf22J6ahg1LjdwRs3FHP5xamt0L9zn8Zg2w0lDCGAnWgoNXu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790918179; c=relaxed/simple;
	bh=szMLHEIsPYGPBcNsMQqu4KTbB4Un+ASFkINpnnypcI0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pGlp518fuIH7lJ3qt5oKKJ5obNN8H5QwuXjS1Tq52MTICS5P9LogGw+ic1YYFPNZS3jGc55vekAbl5VvdIl7lhtPWZMlmV2Nc2KG6/usbE0dsP7dJfAzqlA7wasozFi1G8gx8y5QypkOvJs7s3pMfcdIBVcmSiP15jzID1cwF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WExEL4j/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WExEL4j/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD1A1F000FF;
	Fri,  2 Oct 2026 05:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790918178;
	bh=fdbq3HRFuyvrIU82ByKul8ljBnoTsSoeLo/ZpuxDclU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WExEL4j/nmjgZX+MwmgUbXFbkCu9MQ29rlxsZOcMhJC7NQkxAvsnKPvOc2O2O4wwB
	 o6Za7Pd3IChaZ/FIDw3Zua2aIwQgVtEMxOXRkuBn9VCB77tQae91seSmx9FcE9A31P
	 R+GMT2yhUnTK/qx3UGuwvjT8E71+3SCRi1N/vCXRUWrMHKpPd6/b/KaibkdkgOMQCy
	 AgN4H2YbNsTJLeyehhziFdHjtD2wRRCQPPBjDa+QpiZlaWAUTTutnxzZfqbW4LXV4F
	 TUAeE7uENVZG4VH1IYukQ5bYclyWb8e6XPpfNMKoInDrdJD0aI0icHurQFToaKCuDU
	 M4t2lRc+o04kw==
Content-Type: multipart/mixed; boundary="===============1405899604603047031=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <30d677b5656d9fe07e2dba86d2bb1f1d5f5114cfc3f36e9d96297b70c230097b@mail.kernel.org>
In-Reply-To: <20261002044050.1277356-1-thepacketgeek@gmail.com>
References: <20261002044050.1277356-1-thepacketgeek@gmail.com>
Subject: Re: [PATCH] bpf, arm64: Fix text_mutex critical section in bpf_arch_text_poke()
From: bot+bpf-ci@kernel.org
To: thepacketgeek@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,puranjay@kernel.org,xukuohai@huaweicloud.com,catalin.marinas@arm.com,will@kernel.org
Cc: leitao@debian.org,bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  2 Oct 2026 05:16:16 +0000 (UTC)

--===============1405899604603047031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arm64: Fix text_mutex critical section in bpf_arch_text_poke()

TL;DR: Nit only: the new multi-line comment in bpf_arch_text_poke() (arm64
JIT) should put '/*' on its own line, per BPF comment style. No functional
problems found.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -3338,12 +3338,20 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
>  		 */
>  		plt_target = (u64)&dummy_tramp;
>
> +	/* pages of the bpf prog pack are shared between progs, so the
> +	 * set_memory_rw()/set_memory_ro() window below must be serialized
> +	 * against other pokers too.
> +	 */
> +	mutex_lock(&text_mutex);
> +

This isn't a bug, but should the new multi-line comment put '/*' on a line
by itself, as is the convention for BPF code?

	/*
	 * Pages of the bpf prog pack are shared between progs, so the
	 * set_memory_rw()/set_memory_ro() window below must be serialized
	 * against other pokers too.
	 */

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36966917973
--===============1405899604603047031==--
