Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B883A961F;
	Tue, 10 Mar 2026 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773127779; cv=none; b=LLUiyT7SXi49k/8YtaWs3iSz3jrUMaPi2fQXdSOWyrqnyJ8ZUnTFBMYG1z4KA4wAx82cBMOW2YeCWOiLfZMQ4KDO5S9L/To2qBqBikrGnVnV6ElSUomBbJ1nP07CQJflDUOfJG7clxSfUg8VyiE+HTR3N70CbpJILQlcHuPFzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773127779; c=relaxed/simple;
	bh=CMqsrQUPybQdjV2uvX1ukTo3S1N3bl3uFt8kMxHhogs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hUjN1VoadmxNfcUXcKb2IDbsUk55HAF/W8HHmVG/Vdx7KBt2wCsKZs9gk3rHoAsBHTjK0d0MEo4JwpPSgq7ZcEFdCbbGQEABk3JzdX+jnl55iJtbA4bXpeaad7GbyMVuUJGlPGhjM3aIGrAEM74FGCgdLFQzIyQZel+jA+t2KPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojyR+eLh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojyR+eLh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB79C19423;
	Tue, 10 Mar 2026 07:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773127778;
	bh=CMqsrQUPybQdjV2uvX1ukTo3S1N3bl3uFt8kMxHhogs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ojyR+eLhafshvkoMfJKJ/VLucEhhE23KJL0p+DjM29iYtssPXZVVe2DGQjZPW1pMt
	 pN4IRBULUkBPQCsYKDea7GmfmUCEbSpgeU8+G4bLu51bTmUV4ddVhZqXW8c9sgNBO2
	 4k89CY2zO6fcv7DohI/vS8OITqIB5cjuNPhiiWANfPGr4DfW5krKvuERxbeB1+H8WM
	 dpZRll0NLHeThxhsDxz2NKMSM9UjSBi4eVxoRNyO6k4FV9T0Fyw2G/gWxHnlNzd1+g
	 y/4RP1tklYt4a+NL/aGwy7QVRrM1xDa4DdpF863LCO4ESWypI5QS8etVj87FuUn3v/
	 Q/D8QPJkALtcA==
Content-Type: multipart/mixed; boundary="===============7609470448589289696=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eb603d18eb0634a5cb8de531b12479a8c7e00f2893a0415536c33f9a76ee9535@mail.kernel.org>
In-Reply-To: <20260310064706.4985-1-yangtiezhu@loongson.cn>
References: <20260310064706.4985-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v1] LoongArch: BPF: Make arch_protect_bpf_trampoline() return 0
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Mar 2026 07:29:38 +0000 (UTC)

--===============7609470448589289696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3bd89f55960d..4f1af3b7a363 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1568,6 +1568,11 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
>  	bpf_prog_pack_free(image, size);
>  }
>
> +int arch_protect_bpf_trampoline(void *image, unsigned int size)
> +{
> +	return 0;
> +}

The fix itself looks correct and is consistent with x86, arm64, and
powerpc which all override arch_protect_bpf_trampoline() to return 0
when using the prog pack allocator.

Should this have a Fixes: tag? The race was introduced when LoongArch
switched to the prog pack allocator without overriding the protect
function. Consider adding:

Fixes: 4ab17e762b34 ("LoongArch: BPF: Use BPF prog pack allocator")

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22891104109
--===============7609470448589289696==--
