Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738C283FCE
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782266968; cv=none; b=uHs8/CBC6gSY00XKSUZUoROK25CkCnjDHXJivxfklSuLyWEYnHoq/RjuAZXbkGbiy8vhXXyJauhLFZ6B3dU6hMQChhPwMo6e6kM8/MS7zgxZv3yxtOOJMYRASaPFR/o9UjmNTXi3GtL58hx15wGPkmVfXkv72A4XocTil4TiCgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782266968; c=relaxed/simple;
	bh=G4PMbo4gAnTzujbJkIZfw7/qAPPtRarxDgz83R4PCvw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=MLcqLOoeO0ELXwLlx7iwRwW20UhMXMC1RBpy26aRSysU9hXvnjjlfqErxsl91tDbjSX9ZkiZuM3ouzySAEiucwkR/Za1lGF+K40iKyrXDm4azSKNAsQGPkP2gnuQ+LC4ytVAbVv0unApd8m4y45s+UnvJKc8OPJetNvLxDQsaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Na6//G2Q; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Na6//G2Q"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c6040aa54so748267eec.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 19:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782266964; x=1782871764; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+uR5pjN31cxoCLjhADvr4TVIpAsDKEZa8OS2FHuarI=;
        b=Na6//G2QOQ2pdHXufiqMCilSSeGJQa3XAPAKvypst7ZiDO52u4Eub9NGmHFD0+ux24
         3oSQmYcgCcxFzSmhKnOqZsFTfbucyvXCBl/zY/Ev4l6h96NHAbcWXhPf+l3jJy0pfhF8
         sTfJWU7PqWvv/cY/PzEEozCqOJq644su5FPEtYjlyrs7vZoJZy7AZHVsWMni3v69CgTK
         oPUYNNRORBQkKoZKxRT3xR/Wgvfl4/V4s703hsVgHHTT5sQIxrjjUcMXdQbQvR3yA/tG
         3qAC8/MEmvL1Dnvm4LefVZrKXGsnDvXx49xLQ28Lv9GO0JyPkNWeh8XIdgVqbRN1vy3e
         OjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782266964; x=1782871764;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j+uR5pjN31cxoCLjhADvr4TVIpAsDKEZa8OS2FHuarI=;
        b=RpdLQg1lP65lE4rZHJyaerS45oY2FY+m3vTTjHMMfRmlEGrDgpZQu2/3YJftXJ+hZ9
         l/P5pVbBQLEQvOgt+QEQxyNzdWJ3NgOk+al1rZz/jAV6hDo0CR0DVhEcUHBTQxL6Nunl
         Ef5pE0ntFSvh4wsPSIcOgJz/wFrKKR6oq2BHx3WWGsMLU7DiWblS2xbX+XQZhxwVRied
         cKLczSBa4s3u02K/Ot10sraRHNk73v/wcQYMQR22PlJPgIL3CzomsdbVGZ+zj7TCaa+R
         04np2sJq9Ns0IAZywb5bPzLVK8lt37blDNQBCU2nY8fUY55ud4hIkikzMtK+VMxbApKO
         L2Dg==
X-Forwarded-Encrypted: i=1; AHgh+RqdYgNjAzgsxMyyuTIWqxt2S5a40QofYtWu0l4TkgWJVgAIrFOTPZvQzRmiFbfo9Q4IAyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIhHOPsO7QEWt9qHXFN6v8F0D0LLC+1X9pEVjklnpw3LPKanK5
	kweMPaTOlny28lOwqIifggJPRBzqktbVh3tvUQp3LtrF1pn7YJJFu6ltlH6v/YZTvt0=
X-Gm-Gg: AfdE7cncUHoVnavo9rk5NxSJeqUIRY4sCnfcMn+/Kd/s2k/rnveM65IMUs+PzzE5JAH
	No7ytItMOIMstgWGo42DlMe4Rk+6PznqUNa1aptDO7Wblszr25YTt4HUW+a9f3NYVmqjUp4NVXU
	rr4fXbbjWRfmBlizcFA/WDnvzG/WHxbTKKz7rjkWfenaPBY32LF/hWW2NKu5H9NuGgtCc9MEdXi
	dD4RJdTdST34fXUerM9g/XQTlU1gND311xGoxUev5xdGvIHNwpf3uRZR3nGdc70CKgbu5KcsKM/
	w49bmwa1WWC0oKxMTX1RLCXlASFqK5PZEY+vF+tuR4sCcS4Iow7YRGMZf5Kh+hjWCvIiyrRKhBP
	fpWlo2fsH3k3vjRFb6zFblxxVuWu87ITluZciSSCCTSm0ab7LhRfx2xbIAOBiwfngFwS+wDfIGZ
	JMTl/uQznmd1m0
X-Received: by 2002:a05:7300:188b:b0:30c:61d4:d463 with SMTP id 5a478bee46e88-30c69126ce2mr1814952eec.3.1782266964407;
        Tue, 23 Jun 2026 19:09:24 -0700 (PDT)
Received: from localhost ([163.114.132.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba57dc4sm19421070eec.9.2026.06.23.19.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 19:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jun 2026 22:09:20 -0400
Message-Id: <DJGWWQQD3B0P.2O1D9MO17YRK4@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <jordan@jrife.io>,
 <kuba@kernel.org>, <martin.lau@linux.dev>, <netdev@vger.kernel.org>,
 <netfilter-devel@vger.kernel.org>, <pabeni@redhat.com>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v8 3/7] bpf: add bpf_icmp_send kfunc
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
 <20260622120515.137082-4-mahe.tardy@gmail.com>
In-Reply-To: <20260622120515.137082-4-mahe.tardy@gmail.com>

On Mon Jun 22, 2026 at 8:05 AM EDT, Mahe Tardy wrote:
> This is needed in the context of Tetragon to provide improved feedback
> (in contrast to just dropping packets) to east-west traffic when blocked
> by policies using cgroup_skb programs. We also extend this kfunc to tc
> program as a convenience.
>
> This reuses concepts from netfilter reject target codepath with the
> differences that:
> * Packets are cloned since the BPF user can still let the packet pass
>   (SK_PASS from the cgroup_skb progs for example) and the current skb
>   need to stay untouched (cgroup_skb hooks only allow read-only skb
>   payload).
> * We protect against recursion since the kfunc, by generating an ICMP
>   error message, could retrigger the BPF prog that invoked it.
>
> For now, we support cgroup_skb and tc program types. For cgroup_skb and
> tc egress, almost everything should be good. However for tc ingress:
> - packet will not be routed yet: need to set the net device for
>   icmp_send, thus the call to ip[6]_route_reply_fill_dst.
> - fragments could trigger hook: icmp_send will only reply to fragment 0.
> - ensure the ip headers is linearized before processing, and zero out
>   the SKB control block after cloning to prevent icmp_send()/icmpv6_send(=
)
>   from misinterpreting garbage data as IP options.
>
> Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
> The interface accepts a type parameter to facilitate future extension to
> other ICMP control message types.
>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2e96b4b847ce..fc69a14650e4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -84,6 +84,8 @@
>  #include <linux/un.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/inet_dscp.h>
> +#include <linux/icmpv6.h>
> +#include <net/icmp.h>
>
>  #include "dev.h"
>
> @@ -12546,6 +12548,101 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md=
 *x, u32 len)
>  	return 0;
>  }
>
> +/**
> + * bpf_icmp_send - Send an ICMP control message
> + * @skb_ctx: Packet that triggered the control message
> + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supporte=
d)
> + * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
> + *
> + * Sends an ICMP control message in response to the packet. The original=
 packet
> + * is cloned before sending the ICMP message, so the BPF program can sti=
ll let
> + * the packet pass if desired.
> + *
> + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6=
) are
> + * supported.
> + *
> + * Return: 0 on success, negative error code on failure:
> + *         -EINVAL: Invalid code parameter
> + *         -EBADMSG: Packet too short or malformed
> + *         -ENOMEM: Memory allocation failed
> + *         -EBUSY: Recursion detected
> + *         -EHOSTUNREACH: Routing failed
> + *         -EPROTONOSUPPORT: Non-IP protocol
> + *         -EOPNOTSUPP: Unsupported ICMP type
> + */
> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int c=
ode)
> +{
> +	struct sk_buff *skb =3D (struct sk_buff *)skb_ctx;
> +	struct sk_buff *nskb;
> +	struct sock *sk;
> +
> +	sk =3D skb_to_full_sk(skb);
> +	if (sk && sk->sk_kern_sock &&
> +	    (sk->sk_protocol =3D=3D IPPROTO_ICMP || sk->sk_protocol =3D=3D IPPR=
OTO_ICMPV6))
> +		return -EBUSY;
> +
> +	switch (skb->protocol) {
> +#if IS_ENABLED(CONFIG_INET)
> +	case htons(ETH_P_IP):
> +		if (type !=3D ICMP_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > NR_ICMP_UNREACH)
> +			return -EINVAL;
> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
> +			kfree_skb(nskb);
> +			return -EBADMSG;
> +		}
> +
> +		if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
> +
> +		icmp_send(nskb, type, code, 0);
> +		consume_skb(nskb);
> +		break;
> +#endif
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (type !=3D ICMPV6_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> +			return -EINVAL;
> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!pskb_network_may_pull(nskb, sizeof(struct ipv6hdr))) {

Minor nit, but this may also fail with SKB_DROP_REASON_NOMEM. Now this is o=
nly
possible if the IP header is not in the linear space which may well be
impossible (?), but do we want to differentiate with
pskb_network_may_pull_reason()?

> +			kfree_skb(nskb);
> +			return -EBADMSG;
> +		}
> +
> +		if (!skb_dst(nskb) && ip6_route_reply_fill_dst(nskb) < 0) {
> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		memset(IP6CB(nskb), 0, sizeof(struct inet6_skb_parm));
> +
> +		icmpv6_send(nskb, type, code, 0);
> +		consume_skb(nskb);
> +		break;
> +#endif
> +	default:
> +		return -EPROTONOSUPPORT;
> +	}
> +
> +	return 0;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
> @@ -12588,6 +12685,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
>  BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
>
> +BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
> +BTF_ID_FLAGS(func, bpf_icmp_send)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
> +
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb =3D {
>  	.owner =3D THIS_MODULE,
>  	.set =3D &bpf_kfunc_check_set_skb,
> @@ -12618,6 +12719,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_s=
et_sock_ops =3D {
>  	.set =3D &bpf_kfunc_check_set_sock_ops,
>  };
>
> +static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send =3D {
> +	.owner =3D THIS_MODULE,
> +	.set =3D &bpf_kfunc_check_set_icmp_send,
> +};
> +
>  static int __init bpf_kfunc_init(void)
>  {
>  	int ret;
> @@ -12639,6 +12745,9 @@ static int __init bpf_kfunc_init(void)
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR=
,
>  					       &bpf_kfunc_set_sock_addr);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_=
kfunc_set_tcp_reqsk);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf=
_kfunc_set_icmp_send);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_=
kfunc_set_icmp_send);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_=
kfunc_set_icmp_send);

Based on Sashiko's feedback, since we mostly care about cgroup_skb
should we just make it exclusive to them and drop CLS_ACT?

>  	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kf=
unc_set_sock_ops);
>  }
>  late_initcall(bpf_kfunc_init);
> --
> 2.34.1

