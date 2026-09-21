Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7723B2D10
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790020361; cv=none; b=teoHnclfWrG7U1HpFUV11qKSEDgA9kduQMIVFdmDBiwYuSTVXjYqnfruzOd+CH46a0l0hqvIUjtzyjZCCqfURTPmTlCDFijRCtIe3CU8y+iS3cyCvfx+u67iHelW9A8yKCr/6bvBhp8xEqVIEG5a4kIF49ZC2hrvX6wCOGyqJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790020361; c=relaxed/simple;
	bh=BbUEJDrUmESjCvTHQt4Gp1JdUDhrG6ufmgbzZehZJb4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h/FxUCmIyg3erPgsFXEUi6h6bQpo5o+slDh3j7rbhXfGKxwvG49Ydy8KxjeRCWcEG0+0I+++hxOo5rVZOjjokAF2avYDAofN/djTjnNY9Bf8csra/PQZsVk2+jjn3Whd70vBSLpTcRi788lQurKK9tqSI08bxgeGpO8BN652EA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1O9RO81; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1O9RO81"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BF41F000FF;
	Mon, 21 Sep 2026 19:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790020358;
	bh=VvsaT526LJ8u6KUrOOb71Q42ZWexHe1meMYQEnqC7GQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m1O9RO81/aON3GvyCijTznXhtkgPhzYWGboWwE8lOSnUCIMTbl46moEfOVdCT5d96
	 06qm+cF9TbJZ/wgYMyzTNACtewCDyrJpu2NyIpt+lLH/EyYijRvZRhLtMYNgdpD/E+
	 vOoMRaS9yPza3mykJuP/QfM0j+Tg3MlJ1gJyEL1ndnm7EI4PC5dXG/XAKOXKBWkWDK
	 vzZqT4kTUy3KCWFCCMgdNeVUkwYqWwftTGGK58GiOYLVnXx7PJu84TIHrfNEGMWS8B
	 4Lu9djxmILeQiLZVyf5sR2rsW1BsQZjFItG77NtoT7fUcW3F0qbZ5mxH/qJJYwh+gZ
	 Gk0XFv5LbVY2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 3/4] bpf: Add bpf_call_rcu_tasks_trace()
 kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921191407.1742386-4-puranjay@kernel.org>
References: <20260921191407.1742386-1-puranjay@kernel.org>
 <20260921191407.1742386-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 19:52:37 +0000
Message-Id: <20260921195238.67BF41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_call_rcu/tasks_trace() deadlock and corruption from NMI c=
ontext
--

commit 7357eb51c5d591938af8ac0c27619c6dee0b07c7
Author: Puranjay Mohan <puranjay@kernel.org>

    bpf: Add bpf_call_rcu_tasks_trace() kfunc

    This commit adds a new bpf kfunc, bpf_call_rcu_tasks_trace(), to defer
    reclaim until after an RCU tasks trace grace period. It is intended for
    sleepable BPF programs and shares the backend __bpf_call_rcu() with
    bpf_call_rcu().

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 8a01dd4058a03..301b35bd85c8a 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> @@ -4872,13 +4861,50 @@ __bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head =
*rh, void *map__const_map,
>  		return -EBADF;
>  	}
> =20
> -	rhk->callback_fn =3D (bpf_callback_t)(void *)callback;
> +	rhk->callback_fn =3D (bpf_callback_t)callback;
>  	rhk->map =3D map;
>  	rhk->prog =3D prog;
> -	call_rcu(&rhk->rcu, bpf_rcu_run_callback);
> +	if (trace)
> +		call_rcu_tasks_trace(&rhk->rcu, bpf_rcu_run_callback);

[Severity: High]
Can this branch cause a deadlock if called from NMI context?

A BPF program of type BPF_PROG_TYPE_PERF_EVENT executing in NMI context
could call bpf_call_rcu_tasks_trace(), which delegates to
call_rcu_tasks_trace() and ultimately call_srcu().

Since call_srcu() relies on acquiring a raw spinlock, could an NMI
interrupting a CPU already holding that lock lead to a guaranteed deadlock?

> +	else
> +		call_rcu(&rhk->rcu, bpf_rcu_run_callback);

[Severity: High]
Can this branch corrupt RCU callback lists if called from NMI context?

Similarly, bpf_call_rcu() delegates to call_rcu(), which modifies CPU-local
lists under local_irq_save(). Since local_irq_save() does not block NMIs,
could an NMI interrupting an existing call_rcu() on the same CPU result
in list corruption?

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921191407.1742=
386-1-puranjay@kernel.org?part=3D3
