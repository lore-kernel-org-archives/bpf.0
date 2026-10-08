Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8E30F927
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455387; cv=none; b=OU8eHGy+UIWm8nVvuvjmzz+4LoOrJ46zXEyjC3onaxAHfPKWNJbX8Ns1ypy7Ix0rNHYgSfKW8boFxsBNMUzIqzqeFMVPlnrdAlUV23VFGKue3UJ96M7zH7E2SkXZD6ZJLCVdGYF6DMNczr36d7wBFPMRYFjGQo7QSnrnjys326Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455387; c=relaxed/simple;
	bh=YKOntrx8suxUq3ReCGUHOmEpfeP2X+15WIz55uaHHTo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=INA6yPbiEu8oEdYVbMgmDIjH96yILyvY/JpR/UsWjl0JkxwvnMA2MjurYGkObZ8RNwaKSxtgKIgHFm7d4CfW3hzTtc0829BSx1ARPq5MrDMXXAQfWjZpYn6sRZcy7DEqv190TZ09VgUsOAWvdukFbyJ28+Gwd+ZJ5hBQGYGEqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8tJYAHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8tJYAHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783DF1F000FF;
	Thu,  8 Oct 2026 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791455385;
	bh=yTTe5K7OYRo7FkOd4o9lWHpQ1OM2UsnM4dr4jpk7Zro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8tJYAHNYKqnvA/7TFXgKdh3/calYyikoL/aqZRTclmBoml82CGAjLvZQCS/BluM0
	 i5OkcPGT/u/oviTDxSna4fdywRCyNox9SJioPQOgTUeXfOkxOS6I8jZgadyVHsuuDE
	 NmZrM1PDe6pSr7pW8UhKGkAyB1SM/bs7txbuAMm0SDBmx2j/vEzCvsQVTBOpz0w1tr
	 H0l8fGsCzfhJaEEEO9SRUzYIry3kmok+RTu8UI3xiVimM45FcjnEy02EY8GNVouiV5
	 1t+b3TJQtJ2TMPBKhiknX7dN2jr99hORLjmsaIuK1dyo8lhSnqysd5SEju9qhKxC8u
	 8F8NxwWCIoJCg==
Message-ID: <sashiko-outbox-164016@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/2] net/sched: act_gate: reject oversized
 dumps instead of wrapping them
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jamal Hadi Salim" <jhs@mojatatu.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <QDISC-H19Z.v2.20261007062551-2@mojatatu.com>
References: <QDISC-H19Z.v2.20261007062551@mojatatu.com>
 <QDISC-H19Z.v2.20261007062551-2@mojatatu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:29:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net/sched: action leaks in IDR when tcf_add_notify fails
--

commit c1aaa71f5e62d0438d19f3c77432158d3dd8ca67
Author: Jamal Hadi Salim <jhs@mojatatu.com>

net/sched: act_gate: reject oversized dumps instead of wrapping them

This patch limits oversized action dumps by closing wrap-capable nests with
nla_nest_end_safe(). It prevents structural corruption of Netlink messages
by failing with -EMSGSIZE instead of writing a wrapped length above U16_MAX.

Link: https://lore.kernel.org/netdev/QDISC-H19Z.v1.20261001053234@mojatatu.=
com/
Link: https://lore.kernel.org/netdev/179111893181.434549.134496606702670489=
94@kernel.org/

> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 6e48b4bc2d75d..747d91ae6446a 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
[ ... ]
> @@ -1279,7 +1280,9 @@ int tcf_action_dump(struct sk_buff *skb, struct tc_=
action *actions[],
>  			tcf_action_dump_1(skb, a, bind, ref);
>  		if (err < 0)
>  			goto errout;
> -		nla_nest_end(skb, nest);
> +		err =3D nla_nest_end_safe(skb, nest);
> +		if (err < 0)
> +			goto errout;
>  	}
> =20
>  	return 0;

[Severity: Medium]
If tcf_add_notify() fails due to the new -EMSGSIZE limit introduced here
for oversized dumps, tcf_action_add() propagates the error to its caller.

However, in tcf_action_add(), tca_put_bound_many() explicitly skips
cleaning up actions where init_res[i] =3D=3D ACT_P_CREATED:

	ret =3D tcf_add_notify(net, n, actions, portid, attr_size, extack);

	/* only put bound actions */
	tca_put_bound_many(actions, init_res);

	return ret;

This appears to leave the newly created actions fully instantiated in the I=
DR
with an active reference, while userspace receives an error and assumes the
creation failed.

Does this regression cause ACT_P_CREATED actions to leak in the IDR?

The commit message acknowledges this serialization failure on the action-add
side, but leaves the necessary follow-up fix out of this patch series. Could
this state inconsistency be triggered by userspace to leak actions before
the follow-up patch is merged?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/QDISC-H19Z.v2.20261=
007062551@mojatatu.com?part=3D1
