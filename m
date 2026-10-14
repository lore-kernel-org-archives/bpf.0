Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C64A207C
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968096; cv=none; b=Oh34vboORrGaS+QGqNYbCRcsiGNeWCqtoZ0LV8PjU9b+B3MnuXe433Pk6xkJka06jTAVaPCPObCKUr51uEzrEoBsp5PDsXL67Bykdg88vUczc6qIp/z8sxZKxHIF4ZjCPVaUAl7zqMcuCPhY0lMt7ZjkMptLGOipQVDNaTLfbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968096; c=relaxed/simple;
	bh=RlFawbJs2N+QyvZd4Dpj39Eh5a59JR2bXsm1NqBP6JI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DF3dn2mqHNLsmhpOUMiqaaTjeJPJ80nQPVc5aaKJ2B1h/R902YU9TF7SkagN/AMVtY0NCW/x6p8UB/sqfqO852nS41rJIbMOFycrj2LUMNDno/2wTtywzkS0XwSvjaHrIEYv+iXUp5murHM6S1ET2cZxnxuTrfnHM4LKSvGYcmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz8Tdtd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz8Tdtd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53221F000FF;
	Wed, 14 Oct 2026 08:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968095;
	bh=3pdN0/Pah8VvPAbyKk1W6iv6yYX3OM5OjILyyXLEojQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bz8Tdtd5b8nC42uJE1og93EaNQKabWaVfjlDOURYTvmDDikpZZr2LC9GZEOBW4h/x
	 DR+57NR8GKtbfZUpvErFZ9jPpEZBL03uoTY/bw/BgTVngwepuVBItlGJUOdOsa3CIy
	 gnFisDoZP2rmVOZjNkEtqoDDr/FRPnXu74PWZ/O89ZvHPRmfRkPFlo8yuYfWhXbHT4
	 W6zHkVHqfjYkGJ8xm0FeSaZ1WWEZHem/ykvim1NcGPZX2f04qPOmjSMT7Nn907S4am
	 N+n24hOPicC2D4o3Q39ecls5N6NYbDXhdHVhBm5nG/PraiyXHZwuBEutCWEH0lxNJs
	 1oPLQq1BkxwWA==
Message-ID: <sashiko-outbox-171044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/5] net/sched: act_gate: reject oversized
 dumps instead of wrapping them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <QDISC-H19Z.v3.r0.20261012193813-1@mojatatu.com>
References: <QDISC-H19Z.v3.r0.20261012193813@mojatatu.com>
 <QDISC-H19Z.v3.r0.20261012193813-1@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 08:54:54 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] net/sched: missing error propagation and wrong extack in tcf_get_no=
tify
--

commit 98a2c073503c58fa744586844b669ba5ddd1bfc0
Author: Jamal Hadi Salim <jhs@mojatatu.com>

net/sched: act_gate: reject oversized dumps instead of wrapping them

This commit fixes an issue where oversized action dumps wrap their u16 nest
lengths, resulting in structurally corrupt netlink messages. It uses
nla_nest_end_safe() to report -EMSGSIZE instead, preventing unrepresentable
dumps from vetoing deletes and allowing correct handling.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.41=
43642-1-victor@mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-H19Z.v2.202=
61007062551%40mojatatu.com
Link: https://lore.kernel.org/netdev/QDISC-H19Z.v2.20261007062551@mojatatu.=
com/
Link: https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.=
com/
Link: https://lore.kernel.org/netdev/179111893181.434549.134496606702670489=
94@kernel.org/

> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 6e48b4bc2d75d..4b4b5d37d2206 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c

[ ... ]

> @@ -1701,7 +1719,7 @@ static int tca_get_fill(struct sk_buff *skb, struct=
 tc_action *actions[],
> =20
>  out_nlmsg_trim:
>  	nlmsg_trim(skb, b);
> -	return -1;
> +	return err;
>  }
> =20
>  static int
>  tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
>  	       struct tc_action *actions[], size_t attr_size, int event,
>  	       struct netlink_ext_ack *extack)
>  {
>  	struct sk_buff *skb;
> =20
>  	skb =3D alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
>  	if (!skb)
>  		return -ENOBUFS;
>  	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
>  			 0, 1, NULL) <=3D 0) {
>  		NL_SET_ERR_MSG(extack, "Failed to fill netlink attributes while adding=
 TC action");
>  		kfree_skb(skb);
>  		return -EINVAL;
>  	}

[Severity: Low]
Since tca_get_fill() now returns actual error codes like -EMSGSIZE instead =
of
just -1, shouldn't tcf_get_notify() also be updated to propagate these erro=
rs?

If an oversized RTM_GETACTION request fails with -EMSGSIZE, it appears it
will incorrectly return -EINVAL to userspace and display an inaccurate
extack message ("while adding TC action").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/QDISC-H19Z.v3.r0.20=
261012193813@mojatatu.com?part=3D1
