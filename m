Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1284B1473
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488254; cv=none; b=qb4akSzHgG8W0fyusXCbBiBsKazdjTEbvm5E19C+tGsYumsjdsf7gT7V0KlIaaFSIz1vX1MssnL0zDOnGHzLmWRBWsBsp92sN9iy5imx7Sf5c//UD1Z6nou58WaKFpTFGlV/iLNgCJlrgvz/xAh72agXaPmyD11PQdWFdf84Scs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488254; c=relaxed/simple;
	bh=+K7ORehzgf2IisWL5IuC7KdTf9PhSO3dpkrC/EHWCX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iPgzg6Bk9JOz9dXDYSf4hedRNxLCxF2wzbO1pMMmhR/sZWYPv+wotMEoudSyaf9ITGhLl3pEW9uOs8oyjY1/2hVssE9bgNkCNx5H1rZYmUiAJ8zGaHvwt6tEAMAcvFv5LpRLyW+dGuub8KGDRTpHgT5D/xMP99F44O7Vl4tqdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/jhtK47; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/jhtK47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7391F000FF;
	Tue, 15 Sep 2026 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789488252;
	bh=PXpB3ZiMF0OFDQtsYXQD/kqdzxmjbokZvDWfD1vOqco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/jhtK47V1cDzBmcBLYxN1Y3D9qv0yyYwtHqj6HYNq5PPIgJfeYMDOTkjqVHGRujH
	 vl2lZOt4jg9b169PYpi6kAjmje8RvzR9qREhf7oKQZqJZJ4WTiMLWnTSIMPoWAwg2R
	 5tSvvYsF5kWc5gpahmIa9lNQjb9XaBgcYfqfKs+aoXqkoVKrA0USsSUV09aHkrYnpa
	 LYDL2Cu1NDdjSCThTi0irz39uL/Rcg0bODApVEWR3Q9ncS0GrgmGRM+7LkhoIjfHb+
	 YYiwNyIyzqX0NYjiOVrhkj1Cy4lbiRM36z4NYymRxqWPNWYylYvGtOeGqHuYJhnZ2l
	 0SP7dTq4BKFKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add bpf_call_rcu() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915154248.3612028-2-puranjay@kernel.org>
References: <20260915154248.3612028-1-puranjay@kernel.org>
 <20260915154248.3612028-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 16:04:12 +0000
Message-Id: <20260915160412.9D7391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: deadlock when bpf_call_rcu() is called from NMI context
--

commit af52c52f0edbfb5e1da2aca1dc782426e0ea9091
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Add bpf_call_rcu() kfunc

This patch adds a new bpf_call_rcu() kfunc that allows BPF programs to
execute a callback after an RCU grace period. This is primarily useful
for programs managing their own objects that need to defer free operations.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 051b6654e57c6..6debb92fc8740 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

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
Could this lead to a deadlock if called from an NMI context?

Tracing BPF programs (like those attached to perf_events or NMI-based
kprobes) can execute in NMI context. If such a program calls this kfunc,
it unconditionally invokes call_rcu().

Since call_rcu() is not NMI-safe and acquires internal raw spinlocks
(like rdp->nocb_lock or rcu_node locks), an NMI interrupting a CPU already
holding one of these locks would try to acquire it again, deadlocking the
CPU.

Is there a way to prevent bpf_call_rcu() from being called in NMI
context, or use an NMI-safe alternative?

> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915154248.3612=
028-1-puranjay@kernel.org?part=3D1
