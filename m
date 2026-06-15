Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538BC3ACA48;
	Mon, 15 Jun 2026 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781522543; cv=none; b=GZfubddX2pZrqpxLU7V3AMzSXSM15MIRqfkTOGNZHUJQmx7X7oQtSCHSPn+N+hM42uKwGGlxMcoMpGtnb3QVogSzlCPVJYP7zsXhtJ6X0NZBmLKmRio23T13/Q44HFmMbKShRf8nIfevrNNnqjy/ZAGaUz9UW1h9PFWwBEUrWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781522543; c=relaxed/simple;
	bh=R5Vxr1enOSt36i634b81N8gVxFr7bYa/wy8GMSm+FdY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YaOTAdyz0zHMXtIKeV39vebRKZmR4UzK4ydOYYzZIN4tn3xWEXN3Vav3K6yNU7bJWgLejZjec9p1oRKLqya1xXFGwAS43TJ5xPxg/4tDnzfd3L4JCEGAJhsFk3UoQkjGSGr3qISbHyGwCBrQMsIGqZ3g1DuIWoYvXrU4+zLHnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwOVrtSC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwOVrtSC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746001F000E9;
	Mon, 15 Jun 2026 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781522541;
	bh=zgApymF6n3g4SvUM9OzQPU/TyiAc4bFE+hB65nGEMOU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QwOVrtSCsW4xJHiFS0JJb4orWcjEBtuQ+qF39eI2ruTxEH1eAyQSrADEJ6jYu3kuc
	 rXTBeOSygZsP+uKUtXcVfdhlSxp8Ef/OMbtrNOiEWgDC5a8JpF30PAq3tqypteI8xq
	 Q5RSQwPZ1awqfAt9wSKD/5uvXyxt8rR1p0ZuRzDLBlu6nt0Js09slGJRPuQ3bFKtPL
	 1I5GGtobdvEFHy/QXZo13Rcqpz9lsirszmncqnQDr9icEJrWeZplxGQX8rQvTGRq+P
	 49d7EdsAi4hDEReCXJXo4tWAC2kPtPZFjRjPsnbYlrjBpt5pEi7Rt7nlAuJANaUXyA
	 liFibzNWK7l/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-next v3 8/9] mm/slab: introduce struct
 kfree_rcu_head and use in kfree_rcu_nolock()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260615-kfree_rcu_nolock-v3-8-70a54f3775bb@kernel.org>
References: <20260615-kfree_rcu_nolock-v3-8-70a54f3775bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 11:22:21 +0000
Message-Id: <20260615112221.746001F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unbounded iteration over deferred RCU objects in the workqueue l=
acks `cond_resched()`, risking soft lockups.
--

commit 300f5714ccdf41bb1175c5f608a81c4624b37553
Author: Harry Yoo (Oracle) <harry@kernel.org>

mm/slab: introduce struct kfree_rcu_head and use in kfree_rcu_nolock()

This commit introduces struct kfree_rcu_head to reduce memory overhead for
kfree_rcu_nolock(). It adds a global fallback list and a deferred workqueue
to handle cases where trylock fails or no empty sheaves are available.

> diff --git a/mm/slub.c b/mm/slub.c
> index 19018a979445e..853430c7fbe06 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
[ ... ]
> @@ -6431,12 +6435,50 @@ static void deferred_percpu_work_fn(struct irq_wo=
rk *work)
[ ... ]
> +static void deferred_work_fn(struct work_struct *w)
> +{
> +	struct llist_node *llnode, *pos, *t;
> +
> +	llnode =3D llist_del_all(&deferred_free_by_rcu);
> +	if (!llnode)
> +		return;
> +
> +	synchronize_rcu();
> =20
> -	llnode =3D llist_del_all(objs_by_rcu);
>  	llist_for_each_safe(pos, t, llnode) {
> -		struct rcu_head *head =3D (struct rcu_head *)pos;
> +		void *obj =3D object_start_address(pos);
> =20
> -		call_rcu(head, kvfree_rcu_cb);
> +		kfree(obj);
>  	}
>  }

[Severity: Medium]
Could this loop cause soft lockups on kernels without preemption?

Since deferred_free_by_rcu is a global list aggregating objects from all
CPUs when the fallback path is taken, it could potentially grow very large.
Executing kfree() on an unbounded number of objects in a single continuous
loop without yielding the CPU might trigger soft lockup warnings.

Would it be safer to add cond_resched() inside this loop to prevent hogging
the CPU?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615-kfree_rcu_=
nolock-v3-0-70a54f3775bb@kernel.org?part=3D8
