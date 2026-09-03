Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FEA3EC69F;
	Thu,  3 Sep 2026 19:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462915; cv=none; b=jcnqH3AmPVdkKY9y8mkDqf5cu+giMbZPWe+dsSxiTQP0i1lE7FNPhL2T4LQYnbZ/bie4JKN/4dmM9OdJZDTkwYMk6lz7y2vHxqH5Wi6+koR1hdU5PR3Swb29QaQrmAT4lXkgLgl17TBTnsArjOakwZ4xzOeAv61voGaiectS3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462915; c=relaxed/simple;
	bh=xuzsxDeOafq0Ti4HnnWpCY33USgpWDwRA70AF6qUObU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HiMRuPDPuerMaH8lv6IDXE9mKa34/aIAIqMnUQ2Jr8e7/BAWSscy1Pm+4eHh2kAU6BpQU4hrJ2w35WzJcV5jpea5y2H9nrN5aruG1M3HsvhfEvxkIwyYKJHCxbhlBjn8rE/fpygkT+BC5LPT0aMuAFsrFOPqeumPIkcBpfpBxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkBmIA6I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkBmIA6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F5B1F000E9;
	Thu,  3 Sep 2026 19:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788462901;
	bh=l/h1spr7oCSCPxVLTRo/K7YmaSon0D9KsuwTbmf5ZfU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bkBmIA6ILwlQpNme5JS5EtFPVi62NQlEcXpwy2hm/QEqG2zxHptl5nSmkiV6pO1RQ
	 7uBTO+6RuLvrFEZ14OkdKu3qnohkHzOoKcj0VZ5yMFNLZAYzvfn7SBN51JfH+Dxsbc
	 i9MiJgxKMLBZJaT7SeKkv76kOavMEP7S5ZTJVzxYyQt2snbKBU6WJRuhHxp63Wu035
	 B+ROO0L5zXBaiGUew/dPpIISDgNxk0suVnFgolCYuJllWGIwG2ecQbxljSi8J410AX
	 9UNEJrJrmzNX4T/++pcNSJFEO9NpfVePaTwhiulHpC9UtjRO86KmG28YUmpt2/5yuF
	 PAzuVyrMqvXqA==
Subject: Re: [v10,net-next,1/2] net/sched: mqprio: pass qdisc handle to
 offload drivers
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, edumazet@google.com, hawk@kernel.org, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, john.fastabend@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, sdf@fomichev.me, sgoutham@marvell.com
Date: Thu, 03 Sep 2026 19:15:00 +0000
Message-ID: <178846290039.3394541.11839642753647294558@kernel.org>
In-Reply-To: <20260831131014.2639581-2-rkannoth@marvell.com>
References: <20260831131014.2639581-2-rkannoth@marvell.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Concern that the new `u32 handle` member of `struct
  tc_mqprio_qopt_offload` (include/net/pkt_sched.h:168) is added with no…
- [Low] The new `handle` member of `struct tc_mqprio_qopt_offload` is
  populated by only one of the two in-tree producers of that structure.

--

net/sched: mqprio: pass qdisc handle to offload drivers

This adds a u32 handle member to struct tc_mqprio_qopt_offload and fills it
from sch->handle in both mqprio_enable_offload() and mqprio_disable_offload()
so that offload drivers can tell mqprio setup, teardown and qdisc replace
apart.  The second patch in the series consumes the field in the octeontx2
driver.

> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 90d3e7943b19a..9f8694ecd4363 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -165,6 +165,7 @@ struct tc_mqprio_caps {
>  struct tc_mqprio_qopt_offload {
>  	/* struct tc_mqprio_qopt must always be the first element */
>  	struct tc_mqprio_qopt qopt;
> +	u32 handle;

[Severity: Low]
This isn't a bug, but could the new member get a short comment describing
its contract, next to the existing "struct tc_mqprio_qopt must always be
the first element" note?

The struct is driver facing and shared, and nothing here states that
handle carries the owning mqprio qdisc handle, that it is never
TC_H_UNSPEC when the command comes from sch_mqprio, or what a value of 0
means for a consumer.

>  	struct netlink_ext_ack *extack;
>  	u16 mode;
>  	u16 shaper;
> diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
> index 6ced7008ef5c8..adc1393f84eaa 100644
> --- a/net/sched/sch_mqprio.c
> +++ b/net/sched/sch_mqprio.c
> @@ -39,6 +39,7 @@ static int mqprio_enable_offload(struct Qdisc *sch,
>  	struct net_device *dev = qdisc_dev(sch);
>  	struct tc_mqprio_qopt_offload mqprio = {
>  		.qopt = *qopt,
> +		.handle = sch->handle,
>  		.extack = extack,
>  	};
>  	int err, i;

[Severity: Low]
Should sch_taprio also fill this field?  struct tc_mqprio_qopt_offload is
embedded in struct tc_taprio_qopt_offload, and taprio_enable_offload()
populates the embedded copy member by member:

net/sched/sch_taprio.c:taprio_enable_offload() {
	...
	offload->cmd = TAPRIO_CMD_REPLACE;
	offload->extack = extack;
	mqprio_qopt_reconstruct(dev, &offload->mqprio.qopt);
	offload->mqprio.extack = extack;
	taprio_sched_to_offload(dev, sched, offload, &caps);
	mqprio_fp_to_offload(q->fp, &offload->mqprio);
	...
}

The object comes from the kzalloc in taprio_offload_alloc(), so
offload->mqprio.handle stays 0 (TC_H_UNSPEC), which is a value the
sch_mqprio path never produces.

Several drivers feed that embedded sub-struct into the same handler they
use for TC_SETUP_QDISC_MQPRIO:

  felix_vsc9959.c    vsc9959_qos_port_tas_set() -> ocelot_port_mqprio()
  enetc_qos.c        enetc_setup_tc_taprio()    -> enetc_setup_tc_mqprio()
  am65-cpsw-qos.c    am65_cpsw_setup_taprio()   -> am65_cpsw_setup_mqprio()

am65_cpsw_setup_mqprio() memcpy-caches the whole struct, so it would cache
handle == 0 on the taprio path and a real handle on the mqprio path for the
same hardware state.

No current consumer is affected: the only reader added by this series is
octeontx2, and otx2_setup_tc() handles TC_QUERY_CAPS, TC_SETUP_BLOCK,
TC_SETUP_QDISC_HTB, TC_SETUP_QDISC_MQPRIO and TC_SETUP_ROOT_QDISC only, so
it never sees a taprio-produced struct.

Would it be better to set offload->mqprio.handle from sch->handle in
taprio_enable_offload() as well, or to document in pkt_sched.h that the
field is only meaningful for TC_SETUP_QDISC_MQPRIO issued by sch_mqprio,
before drivers start keying committed state off it?

> @@ -79,7 +80,9 @@ static int mqprio_enable_offload(struct Qdisc *sch,
>  
>  static void mqprio_disable_offload(struct Qdisc *sch)
>  {
> -	struct tc_mqprio_qopt_offload mqprio = { { 0 } };
> +	struct tc_mqprio_qopt_offload mqprio = {
> +		.handle = sch->handle,
> +	};
>  	struct mqprio_sched *priv = qdisc_priv(sch);
>  	struct net_device *dev = qdisc_dev(sch);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831131014.2639581-1-rkannoth%40marvell.com
