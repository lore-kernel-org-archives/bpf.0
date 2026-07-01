Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B349480945;
	Wed,  1 Jul 2026 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907047; cv=none; b=OPcM+BMnRDrAbNkN26/uPnRct/EihRwFRLPwyNEo7ianDuXJGhw7zRSXH+ofOYL43Q9qt4vZT8LgRaOaBPJN/Vv+3BTNL/K7SbojLHi2y6yMIwJ5Q48hkMoasiduTRtBde1XU9fb6dGRlXANvXNvt+4/K/1e+GBnZyiFb0RCpG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907047; c=relaxed/simple;
	bh=adDfxxqNMhHTS7u8Q2Ts8gjafrimuwoyJgLXQt1HVnk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YR5Yfj8dW5QpdqGoJI/ejjmfHprsPKuucKJEJ3+kmkeRYk8yulu36Mo7IphHtNYuymdTg6PECRCl2vMAWM5u3kZ/+/vT4JlAh6WpCOT4Gtot0zk5dHL43gYqVjo79Cp++6emazXEu2CBfYrfYJAVKVM5+PaDyy5EpwlNenwyeCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPdhjtVv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPdhjtVv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DBB81F000E9;
	Wed,  1 Jul 2026 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907046;
	bh=aHTb/NZa/DTZLovWUqS7Q8/oam3WHgoOZjM/h+vRByI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dPdhjtVvadWvhsSxJX3hXPnBMA50JvjCMGvacO7PcL0Q8hqYM5wxKfZYJ3egYMJkE
	 VsLZhvL56ltDYbHC98w3Ec9TThUlfTNm95HBqPZWYl9UJZMY97MiRU3EgRBlAq78Qu
	 Km1BLKh8xN9jWevFVVAR+seAfb4O59M20dm8JnNk2sxaBw2fXopSIinXVN7o1X24tH
	 1/DigetoeVBh42k+lHFzWd4QAkanKMtM9QvGbinMWl/jnkEvKKz+Mry4rIQfYBAejV
	 qTLCaCh0Rn2QMmRTw0a8e/nhnDwcHP2tpJnUmry6mwxoU06ec5uYSfAcsIxnrFsCtl
	 jYlsvk3Rsl8dQ==
Content-Type: multipart/mixed; boundary="===============1133100935469573393=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <826d1095dbfbd8e5fe4fed1fe143dfab054c42c9ef608e120ebb73e2eb506f09@mail.kernel.org>
In-Reply-To: <20260701111337.53943-3-jolsa@kernel.org>
References: <20260701111337.53943-3-jolsa@kernel.org>
Subject: Re: [PATCHv5 02/13] uprobes/x86: Remove struct uprobe_trampoline object
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 11:57:26 +0000 (UTC)

--===============1133100935469573393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 2be6707e3320..d2933cf77cd3 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c

[ ... ]

> @@ -1111,21 +1051,19 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  				  unsigned long vaddr)
>  {
> -	struct uprobe_trampoline *tramp;
> -	struct vm_area_struct *vma;
> -	bool new = false;
> -	int err = 0;
> +	struct pt_regs *regs = task_pt_regs(current);
> +	struct vm_area_struct *vma, *tramp;
> +	int ret;
>
> +	if (!user_64bit_mode(regs))
> +		return -EINVAL;
>  	vma = find_vma(mm, vaddr);
>  	if (!vma)
>  		return -EINVAL;
> -	tramp = get_uprobe_trampoline(vaddr, &new);
> -	if (!tramp)
> -		return -EINVAL;
> -	err = swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
> -	if (WARN_ON_ONCE(err) && new)
> -		destroy_uprobe_trampoline(tramp);
> -	return err;
> +	tramp = get_uprobe_trampoline(mm, vaddr);
> +	if (IS_ERR(tramp))
> +		return PTR_ERR(tramp);
> +	return WARN_ON_ONCE(swbp_optimize(auprobe, vma, vaddr, tramp->vm_start));
>  }

The variable ret is declared but never used in the refactored
__arch_uprobe_optimize(). The old code used err which was assigned and
returned, but the new code returns directly. Should ret be removed to
avoid a compiler warning?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28514315910
--===============1133100935469573393==--
