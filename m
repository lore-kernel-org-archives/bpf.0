Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC88379C5A;
	Mon, 29 Jun 2026 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728962; cv=none; b=q/4TjvkzXgWON8SlrVz92fnpwzRKWOORT1K5voZm7pQxQwnaBfJ0h7fFqGcqCMUz/VL7IargbXY46ubqgMobYEoSwc0EdrFMmZCuSE+n6DiJR42cn805hSRATfGPNkEDc+Gl+R1YwOUe/FUhlkP3w4JYL7zYuXpccg5f3Mci0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728962; c=relaxed/simple;
	bh=tbtjkuimxedkcTP+D1p4As511RP7QabYqR6uLuD5NTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuGF8bEUpx/L8IChtrGmDBSRoIBh0ROc0v1ZtY7WWhiE0JLkBZaTeTSpyHI5do7RYsAsvyUR9/v6xDwiAMFNgWYcUQqiG76VfgoO6zPMlAQOXeCY9O4IvMDALH7ypjZdHxk5FdNfLrcLWrSuvBf7iCOR08K0ukC/K2PT5LB9X7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gyzOAUYj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G9LbQTuo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gyzOAUYj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G9LbQTuo"
Date: Mon, 29 Jun 2026 12:29:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782728959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xEfDSiGwjlvL77ASnBwcZCNfzRqenYZMglXUGdb8UM=;
	b=gyzOAUYj0Vk3iynVM+tyfuK0PeB/TcI1HoJDwy4BBznezJeM2u65f5asWNAo4O8jbsI+jW
	5e3XEMPLonyIicNcJhinLigZom+cMDADxxHr/b/gudYu0xR9VB5UmL6Ws2YnYWlIG5nl/w
	GHddtahL4nUZmMRpFP0ph6RMLoS3HyIboEkkBWBOMwxHEeDPqsU6bE4rBcA3ng3kjJnelL
	QgidNJoa6so10NpKfaTO1i4e35mFr7QG+NWG7g84SPss1E1iBKHLY7NydbcRS/9/zWp87h
	CKrkb6Nx9DCvU3VBHJ4E4rV2+QDNQ7lRotZW0yxpjwsB2g0gnM1wMcMoIhQfDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782728959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xEfDSiGwjlvL77ASnBwcZCNfzRqenYZMglXUGdb8UM=;
	b=G9LbQTuo+IZbziO0S+xHdre+EMftJ8iF2yJfNW9mjYJ4K8h1xwMmi3hHKLG27VmguucbSB
	Rf2ZdbumF8u5K+AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, toke@toke.dk, jiri@resnulli.us,
	clrkwllms@kernel.org, rostedt@goodmis.org, kuniyu@google.com,
	sdf.kernel@gmail.com, skhawaja@google.com, liuhangbin@gmail.com,
	krikku@gmail.com, mkarsten@uwaterloo.ca, victor@mojatatu.com,
	ast@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	daniel@iogearbox.net, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net 1/3] net: Extend bpf_net_context lifetime to cover
 qdisc enqueue
Message-ID: <20260629102917.Ag2Vd7LR@linutronix.de>
References: <20260626165156.169012-1-jhs@mojatatu.com>
 <20260626165156.169012-2-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260626165156.169012-2-jhs@mojatatu.com>

On 2026-06-26 12:51:54 [-0400], Jamal Hadi Salim wrote:
> The bpf_net_context used by sch_handle_egress() is stack-allocated and to=
rn
> down in that function returned. By the time tcf_qevent_handle() runs
> current->bpf_net_context is NULL.
>=20
> When a filter attached to a qevent block (e.g. RED's early_drop or mark
> qevents, which always use shared blocks) returns TC_ACT_REDIRECT,
> tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf help=
er
> bpf_net_ctx_get_ri(). That helper unconditionally dereferences
> current->bpf_net_context resulting in a NULL pointer dereference.
>=20
> Note: The same holds for actions that invoke BPF redirect helpers
> (e.g. act_bpf running a program that calls bpf_redirect()) during qevent
> classification itself. And as a matter of fact the same assumption is
> made in the code outside of tc.
>=20
> Fix:
> Move the bpf_net_context lifecycle out of sch_handle_egress() into
> __dev_queue_xmit(), so that it spans both the egress TC fast path and the
> qdisc enqueue. The setup is placed outside the egress_needed_key static
> branch because qevents are independent of clsact/NF egress hooks and
> that key may stay disabled when only a qevent-bearing qdisc is
> configured. Unfortunately this adds a small unconditional penalty to the
> code path _per packet_ only guarded by CONFIG_NET_XGRESS (two writes and
> one read for bpf_net_ctx_set, plus one write for bpf_net_ctx_clear).

I fail to understand this but you and sashiko have an understanding...
If there is TC_ACT_REDIRECT returned by tc_run(), then the skb is NULL
and as such uppon return from sch_handle_egress() the control flow goes
to the out label.
As a fix you move the bpf_net_ctx assigned to before CONFIG_NET_EGRESS
and clear it on exit. What do I miss here?

> This keeps all bpf_net_context management in net/core/dev.c i.e the
> existing boundary between tc core and BPF without requiring any net/sched/
> code to know about BPF plumbing.
>=20
> Reproducer (see the accompanying tdc test):
>=20
>   tc qdisc add dev eth0 root handle 1: red limit 1MB min 10KB max 20KB \
>       avpkt 1000 burst 100 qevent early_drop block 10
>   tc qdisc add dev eth0 clsact
>   tc filter add block 10 pref 1 bpf obj redirect.o

stupid question: how do I get this redirect.o? Just a simply thing to
reproduce this=E2=80=A6

>   tc filter add dev eth0 egress protocol ip prio 1 matchall \
>       action gact pass
>=20
>   traffic through eth0 triggers red_enqueue() -> tcf_qevent_handle() and,
>   on a redirect verdict, a NULL deref in skb_do_redirect().

Sebastian
