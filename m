Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA603A7F41;
	Sat, 17 Oct 2026 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257420; cv=none; b=hI30vFSiwwOqw/RRfhgjCWY1XZdv5Zfx8ZoVGQ4ocXldH3glVCYxxUVYC4/OxnVuRoYA3QzrPy83taR45DD4ReXWw1ajlvr2yd/aMQfPiuvSb6Hqha1BJWCZKHeKJcDIoGV/k5YmCkS02y6babetzMmBVrW8YJ7CN0bs7hxWx5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257420; c=relaxed/simple;
	bh=DPD/9R0avB6FY2jFkU1uGCRHhUmkd4Avmaw0OjrEAPk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mHPjaEeMS/uiCSpzHiZnPK8Mkzr0StnLV9um5N5rDAgdcDhdU+i5TVptqOS/ixZ/LAEwKt95G0c8mgBSoLY1WBKdgBAD29S2wblfDudmofcuwPdBrTCveoVrfYmTRdiwpC2sxhHo0ugbc/eyEfzVIOKXnaR7yEpTORYqGQ1eqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjE0taz9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjE0taz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3A01F000C4;
	Sat, 17 Oct 2026 17:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257418;
	bh=xBwu32tRzgrEuq9JG8gaNOJtBWCZK5VnaCyLTc2t8Co=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UjE0taz9oIbJfxRWo86qXoHrOqTFGBEDLkLrwMQXV5ZoOYmSiVozU7ibpkeJPFgYe
	 S94j16lnF1DKaX3btssLz55WjgrTaYPNWSjEns2NBkESlCowvHBwIe8MG9V+2ssAX7
	 /j2FqklYeWnvY7PQ25SUbk95p0VP5Ux9rhs2EdG8HbZiOpSF6Z7OSDPNuTH78ZjY/T
	 j1fw7Xy2FPnYMElkR2YIEuxV3E9s3RVosv0LcB+nIqNVFDlV3hQXuuRSa7yYcfU//Q
	 XkW0JazqpU51UkcqWhX6NS0rLKogog7YOVSPWTSt0HzPQrr5dBpraHG5QwoS9E8I7n
	 tNRzj+DEYB+OQ==
Content-Type: multipart/mixed; boundary="===============0189043960274367041=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9e4f2779a5571380e019033e4d1c30a14ed609bffcd34faf2074b3a9c437703d@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-6-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/43] bpf: reject sleepable programs for task_vma iterator
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:16:57 +0000 (UTC)

--===============0189043960274367041==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: reject sleepable programs for task_vma iterator

TL;DR: Documentation nit only: bpf_iterators.rst still says only
BPF_ITER_RESCHED is supported and doesn't mention the new BPF_ITER_NOSLEEP
flag. No code problems raised.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 54144372281c..46d325aa178e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3137,7 +3137,8 @@ typedef const struct bpf_func_proto *
>  			     const struct bpf_prog *prog);
>
>  enum bpf_iter_feature {
> -	BPF_ITER_RESCHED	= BIT(0),
> +	BPF_ITER_RESCHED	= BIT(0),	/* may cond_resched() between objects */
> +	BPF_ITER_NOSLEEP	= BIT(1),	/* ->show() can't run sleepable progs */
>  };
>
>  #define BPF_ITER_CTX_ARG_MAX 2

This isn't a bug, but should Documentation/bpf/bpf_iterators.rst be updated
for the new flag?

The description of the feature field in struct bpf_iter_reg still reads:

   * - feature
     - Specifies certain action requests in the kernel BPF iterator
       infrastructure. Currently, only BPF_ITER_RESCHED is supported. This
       means that the kernel function cond_resched() is called to avoid other
       kernel subsystem (e.g., rcu) misbehaving.

With BPF_ITER_NOSLEEP added, "only BPF_ITER_RESCHED is supported" is no
longer accurate.

The text also doesn't say that BPF_ITER_RESCHED is what allows a target to
accept sleepable (iter.s/) programs, or that a target whose ->show() runs
under a lock that a faulting program would need to take again (as task_vma
does with mmap_lock) has to set BPF_ITER_NOSLEEP as well.

Someone adding a new iterator target from that document would not learn
about the flag.  None of the later patches in this series touch
bpf_iterators.rst.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============0189043960274367041==--
