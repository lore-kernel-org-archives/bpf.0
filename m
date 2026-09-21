Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E73AFAF1
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019560; cv=none; b=DK5lD7jzHLDjsSplZu+L1t2gFiYKv9RfZc214weXgzLBqJ/6VbasRof12nrN7pC8nrNPObMaFbmzb2Can80KKGWkI+vwQhYclq5m2ilLFmIJBRnf+dimvhXSr92zWEtm/X61Dkjrn7ifvf4gMC+/GPfPgHgdrnKwSRpjEYJwvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019560; c=relaxed/simple;
	bh=bWPK2JrOTm64fqqeRN/3xyAsQnzt0VT+MobDzKxoYxM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qp6dyAvzmqjAdE78WHO08hWePmJevGz+c+WpqIsmgv2Sytmt/4SqBnOTNFpyhMPWBwJIBc1pSeuVeRb1J2MMDfdkZquBZeGBl4j+Nl+nppjX3KH+PtfiYEOoKpjLPwg8m9RRI8Cakh7wbZ+OYODtkPwR15uQY0eQNYInnhz8vQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua2Xa+nW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua2Xa+nW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864841F000FF;
	Mon, 21 Sep 2026 19:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790019555;
	bh=HQb1XfRFfRnCG6p/cSdaKo29TgrmT52asGMumzFp71Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ua2Xa+nW42JBtwAozH5EEhk/5P03tEtprzCmqtsguvmNpdYY+iU7ioGoLs9FWHM0C
	 v45v3XDg/7zRxWnE8biQGkV4IdD3ApKksWsvK77AXmdrh4+7v5UnBU5rQX0HAqP9hl
	 +KatMyDS2OcQ1SrysFk1l2kq6t5nvjBJXFtUI0qkTD5w9FErAJYf7SmtergRLbl7dE
	 PS2Id/lGxobAj+EUrhC7RZkf6vSA4SuMk1N2W5/elPPhlR4hThGHZSXSMYf8PXRINU
	 SB6aq+g/cvg/qhI3uDbJLRpT2MuZBwnIHfuiU35MwKKqzn2fjFdOZmsyPsmaxbUNhr
	 ay5nfknOjjECA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 1/4] bpf: Add bpf_call_rcu() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921191407.1742386-2-puranjay@kernel.org>
References: <20260921191407.1742386-1-puranjay@kernel.org>
 <20260921191407.1742386-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:39:15 +0000
Message-Id: <20260921193915.864841F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_call_rcu() causes deadlock when called from NMI context
--

commit 088862a20bc8f57242ca8bd55ca1e35a37a5380f
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Add bpf_call_rcu() kfunc

This commit adds a bpf_call_rcu() kfunc, allowing BPF programs to
queue custom callbacks to run after an RCU grace period. It embeds
a struct bpf_rcu_head inside a BPF map value to hold the callback state.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 501c7ce35cba9..8a01dd4058a03 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -4805,6 +4805,80 @@ __bpf_kfunc int bpf_task_work_schedule_resume(stru=
ct task_struct *task, struct b

[ ... ]

> +__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_m=
ap,
> +			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
> +{
> +	struct bpf_rcu_head_kern *rhk =3D (void *)rh;
> +	struct bpf_map *map =3D map__const_map;
> +	struct bpf_prog *prog;

[ ... ]

> +	rhk->callback_fn =3D (bpf_callback_t)(void *)callback;
> +	rhk->map =3D map;
> +	rhk->prog =3D prog;
> +	call_rcu(&rhk->rcu, bpf_rcu_run_callback);

[Severity: High]
Does this code trigger a deadlock if bpf_call_rcu() is called from an NMI
context?=20

The call_rcu() function acquires raw spinlocks internally. If a BPF program
executing in NMI context (such as a kprobe or BPF_PROG_TYPE_PERF_EVENT) cal=
ls
this while interrupting a thread that already holds the same RCU lock, the =
CPU
will try to acquire the non-reentrant raw spinlock again and hard deadlock.

Should there be an in_nmi() check here or deferral via irq_work_queue() when
called from an NMI context?

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191407.1742=
386-1-puranjay@kernel.org?part=3D1
