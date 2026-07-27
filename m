Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4331A3F8234
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146406; cv=none; b=ExXFKxk7+ldb81PEeps+h7umHXTMn1siR9uxVAIR5hOraGtWU7zxQ+gPTLyiaPvjlnrapjebfUH/uqUofH+yZPB5xZh+VTs2vm8sZQyJGVK8d7x4E/YAG9+6p2d2icR/AF2SJZlrpvqJ3t6V9wGMnlP0Z0vLtzi/ujX7U1nqETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146406; c=relaxed/simple;
	bh=7OoQDeBF3GFw6aM2HPw7KOuLKsTP085ZF2rW1Y4BziE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E56mu0ZiNt1HHNvarC3e2LBFOWVL0DGzcgwqx7cZ5sgpQ4/Mb0Zb6EG4ZIX2XO2ZP8+f1FaEZXazNjwCL//rkV9acxtL6f0mLoAejxEAr+rBAuvXj9H+SN3T7Z5HBkdvw8yIsyuLuO6+bjdZ3HbTAavnAiydmQVufF4w4BRqNJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca/fRwyN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca/fRwyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29E01F00A3D;
	Mon, 27 Jul 2026 10:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146404;
	bh=rKgU0nZNH2+Bl2hh/4Ob5jS3EzQyYYk6MdawHU+Fpz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ca/fRwyNtrdLDAtDI6QX6B+VCCdwBmFFcvo/kky27umwmLyW5p765Tk2PpXLatJM8
	 X7Asy2CFFVJuxe64oryOo75WRldvpJGA+CF2k4YVLfCefdN9fFwGfNJpW2kCXwE9FK
	 Lf4ErVy2/1EJOziqQA3CmdMKDWP7Z61A6d4Gp89tN422hbXg/3ms5mT6vIdV3Yhp10
	 5INXY83vcSz4a5wWXGY8qa/S5JtuIg+MekUk+Uiwznu509OHGZvJChd5LREP7GI/hW
	 U1v4jukgjaAduPkKCnsMnxRrTP/78YHIzGcGhqpW4T3vT0yueRH3OVwopMWrRVeDcA
	 OyPsk8SH2U3fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add __bpfcall attribute to
 bpf_task_work_callback()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260727093834.2178900-1-hca@linux.ibm.com>
References: <20260727093834.2178900-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:00:03 +0000
Message-Id: <20260727100004.B29E01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete Fix / Missing kCFI Annotations for BPF indirect cal=
ls
--

--- Patch [1]: [PATCH bpf-next] bpf: Add __bpfcall attribute to bpf_task_wo=
rk_callback() ---
commit 96f705949126224922cfe1979dd000057319d199
Author: Heiko Carstens <hca@linux.ibm.com>

bpf: Add __bpfcall attribute to bpf_task_work_callback()

This commit adds the __bpfcall attribute to bpf_task_work_callback() to
avoid CFI checks for indirect calls to BPF programs. This addresses kCFI
issues on architectures that do not provide default BPF kCFI support.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 88b38db47de92..9bf82c9ea1dac 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4447,7 +4447,7 @@ static void bpf_task_work_cancel(struct bpf_task_wo=
rk_ctx *ctx)
>  		bpf_task_work_ctx_put(ctx);
>  }
> =20
> -static void bpf_task_work_callback(struct callback_head *cb)
> +static __bpfcall void bpf_task_work_callback(struct callback_head *cb)
>  {

[Severity: Critical]
This isn't a bug introduced by this patch, but are there other BPF indirect=
=20
calls that also need the __bpfcall attribute to prevent kCFI panics?

For example, bpf_timer_cb() and bpf_wq_work() in kernel/bpf/helpers.c also=
=20
perform indirect calls to callback_fn().=20

Other locations like bpf_for_each_array_elem() in kernel/bpf/arraymap.c and=
=20
bpf_find_vma() in kernel/bpf/task_iter.c appear to have the same pattern.=20

Could unprivileged users loading BPF programs that use timers, workqueues,=
=20
or map iterators trigger the same kCFI violation on architectures lacking B=
PF=20
kCFI support?

>  	struct bpf_task_work_ctx *ctx =3D container_of(cb, struct bpf_task_work=
_ctx, work);
>  	enum bpf_task_work_state state;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727093834.2178=
900-1-hca@linux.ibm.com?part=3D1
