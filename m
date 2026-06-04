Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD633F54A4;
	Thu,  4 Jun 2026 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607600; cv=none; b=bUK89OW6wLosa79ZjzWuI1B6v8WFX94Pm6+kZXMxVfSwgraZmSafq/bRcpGsMKK1UcGJF+uv7ZFvXv7b6YtUbBsC/WgqSfJICq7FjW1TKQpfrMUZC6ZPKCJmnGMI28m2d9UDmF4XL3POLWGJOp8iPP2ONw9sx+sxx9HLcqbMpxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607600; c=relaxed/simple;
	bh=WBenpf6jxRLzjoE4advBbHQ44nqsrEMLRUZQhaZgaxY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cVCfd2tT6LdiYhnWLk/LkwPrRSACF4lVZWq0ZUzYnB9sRqvZKs0uHFOJ5NYn4jeeZACpzdaHcfFTF8Qe7hlooZHH0isOFRXOf/b6iQ1oWTqXk2tpaGRFpFdJ6uXQG0sFr8fA43rXGERcOiPyhKlSSFaQIv7CtEIouVTU5kH/Tfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDcxOFIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDcxOFIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685231F00898;
	Thu,  4 Jun 2026 21:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780607599;
	bh=Bvq7vOl1c1mpIND7SGq8IUzzkQicWNmeIHBCULeRYCk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MDcxOFIlJpDBkWx4G4Fyg+NRKBS8U/9nrpTIxW6hEAlPJieSOpscifAXinZHL8Pra
	 ZLcvQyU2kS2+93H6siaH+q5lJv7j+LGzr0G5gATRIramDZR8hJmQB2jAL2NvItMOwa
	 yuaA6IX9likH4SSia+VKj/6U5wccC4VyPhb5GYtrdsgtf5yx6sZ2TSBmSTmvz0A5a3
	 lDVeTJAPGhBGQSMQxXc0h41xsI9JXJ1l0XS3K8yxFPAVq7Gr95j40husFaFtoPFhFk
	 P3oAWBSjMGDNurtTa4DUHudhMuteXxxRhDtCCMKbPzSlhMjw2A2DlG56pJARAd9sxo
	 eLmhA5dVCl8aQ==
Content-Type: multipart/mixed; boundary="===============5364940318977030226=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1e7ab52954b9ff584d6871c2ec234a7155b577f29128564d0d597809cafad826@mail.kernel.org>
In-Reply-To: <20260604-kasan-v2-2-c066e627fda8@bootlin.com>
References: <20260604-kasan-v2-2-c066e627fda8@bootlin.com>
Subject: Re: [PATCH bpf-next v2 2/8] bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,tglx@kernel.org,mingo@redhat.com,bp@alien8.de,dave.hansen@linux.intel.com,x86@kernel.org,hpa@zytor.com,shuah@kernel.org,mcoquelin.stm32@gmail.com,alexandre.torgue@foss.st.com,ihor.solodrai@linux.dev
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-stm32@st-md-mailman.stormreply.com,linux-arm-kernel@lists.infradead.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 21:13:18 +0000 (UTC)

--===============5364940318977030226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f0..a8e004f88b92 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig

[ ... ]

> @@ -101,4 +105,9 @@ config BPF_LSM
>
>  	  If you are unsure how to answer this question, answer N.
>
> +config BPF_JIT_KASAN
> +	bool
> +	depends on HAVE_EBPF_JIT_KASAN
> +	default y if BPF_JIT && KASAN_GENERIC && KASAN_VMALLOC && VMAP_STACK
> +
>  endmenu # "BPF subsystem"

This isn't a bug, but a design concern raised on an earlier posting of
this work doesn't look fully resolved.

In the v1 (RFC) discussion, the suggestion was to not add a config knob
at all and instead do the instrumentation inside the JIT whenever
KASAN_GENERIC is set:

  "Let's not add more config knobs. Even this patch looks redundant.
   Inside JIT do instrumentation when KASAN_GENERIC is set."

  https://lore.kernel.org/bpf/CAADnVQLj=UosnsC-4V2+mN92Fe0-kW++U+m-O9c93kk6BwiXgw@mail.gmail.com/

The reasoning given for keeping the internal Kconfig was that it lets
selftests adapt their behavior without sprinkling arch and KASAN
conditionals, and another reviewer agreed that approach was reasonable.

That "this patch looks redundant" objection was never explicitly
retracted or re-acked, yet the BPF_JIT_KASAN config is retained here.

Has this design point been settled?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26978380520
--===============5364940318977030226==--
