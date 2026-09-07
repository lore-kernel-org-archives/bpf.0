Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD44F6461
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788790005; cv=none; b=qIWJFIONBFnENNbAA3XvrUWTK0GCWBCTi0DbW14BNX0oSeNgc3pH0vCZzuxKjjm7jQ21dFu9f1eFu6Cr0bR4Qcoith4hW4eUe3LNkeR3gzcyB1iOhePncFQNQo76ux8/c+GuZ4ZLCNVxKkZp5Ar7i4TmVOpQMsDvSOQhd/0/G84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788790005; c=relaxed/simple;
	bh=2iif40BKrjLBLOwmPmmiP6ZdfmVx449NucJYxyL58V0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m2RDhLZA5WVQYtXATehGCPQmqXnucgEWq0fAD6B37334vbY8HuMGJChf/GJnmShRhKDDqgprN6MV4AARvOwpyo0TWeL7UnRs87bscr4XiLbXs4r6F3XyQa1xvH3euSnB+ijAkjdU/ZQ9zVAqgLmPMLnPnmBA5LXFlhZ+BTV9PME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyIiNM3i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyIiNM3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02581F00A3A;
	Mon,  7 Sep 2026 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788790002;
	bh=6Jh00Q2hvZt9pERXK2R/PL2wNu612R+JSzF4ND9P0JY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZyIiNM3ikOjsk+6vx6YgrwcN34mHsDCbvO0BXWbNG5RlGwQKXKbDjQEXo82ZN0s+m
	 FYT4B7MnzhcZ5IyjoCCGhzoswbq8NBtKOodV0lZjGdoPM+qe+i8/N1W6B1TPZLMZqv
	 sTHg/MoD4BChs67mJ+KUiJQRPODNxoSa7Dpo4u7UidX+wwk7fa8Y8sqzgNS/tZtnS9
	 zsQELp+QHuMBxsiQtUGDO9B+W31+Io6i5pXta1mTGQhT8Z/ps/XAAo/lGwBTm2A7D1
	 eqH0Gcbo2gclFj8UagThW7SXnAunITylB+vO0cKjh71DRMR4QXSYxIE8ySxMcb0Hxs
	 4EtlqI7KG8Ymw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/4] bpf: Add bpf_call_rcu() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260907134552.1772405-2-puranjay@kernel.org>
References: <20260907134552.1772405-1-puranjay@kernel.org>
 <20260907134552.1772405-2-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 14:06:42 +0000
Message-Id: <20260907140642.B02581F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `bpf_call_rcu` from NMI context causes a raw spinlock dead=
lock because `call_rcu()` is not NMI-safe.
--

commit 3385037afe11a72dffbb6db99b4174626596c231
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Add bpf_call_rcu() kfunc

This commit adds a new bpf_call_rcu kfunc that allows BPF programs to defer
operations using RCU grace periods.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
[ ... ]
> +__bpf_kfunc int bpf_call_rcu(struct bpf_rcu_head *rh, void *map__const_m=
ap,
> +			     bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
> +{
[ ... ]
> +	rhk->callback_fn =3D (bpf_callback_t)(void *)callback;
> +	rhk->map =3D map;
> +	rhk->prog =3D prog;
> +	call_rcu(&rhk->rcu, bpf_rcu_run_callback);

[Severity: High]
Does this code risk a raw spinlock deadlock if called from an NMI context?

Because bpf_call_rcu is exposed to tracing programs, it can be invoked from
NMI contexts, such as when a tracing program is attached to a perf event.
However, call_rcu acquires rcu_node raw spinlocks and is not NMI-safe. If
the NMI interrupts a path that already holds the same rcu_node lock, the
system will attempt to re-acquire the lock, resulting in a deadlock.

Should the verifier restrict this kfunc from being called in NMI contexts,
similar to how it uses btf_record_has_nmi_unsafe_fields for bpf_obj_drop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907134552.1772=
405-1-puranjay@kernel.org?part=3D1
