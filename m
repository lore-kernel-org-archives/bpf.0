Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3280B3BD225
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225652; cv=none; b=WCDTkRNfPypD0P8E4ni6FTdU25zAx7ACWsgdK+YtmOQzwYJjnJ5D6vl1WWnaq3ewGuSw3fon0Ujjx4gOGjFvh8MH7AtyLvkY+2uztBe3JnPpl/Vl0r8l2d6PTdNVEcpK6SzLd2NNlaOQbjPDSXjqcrltuLLL9TBDnoJF+7MZAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225652; c=relaxed/simple;
	bh=O+BWYgzCHwjTvXK7MA4AReNobXoJmXJlYv8uwm5nxvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9PJmDS8mCVH5DKFuWljqlH1OuO1EiQH2wtXQ/XrreBen/HkOsDgp7WWYZHTkhznTP83C88aYlg6YuDC39inAiOY5ERA+G7+2V3ctoeFM3Dt27MLSyHfye01JsGu8MbZpTH6X4y3NAuJ8dOqlN7uNCGnP3NvCBsh8YfBz8dUZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQi4rLMb; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQi4rLMb"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c801d732058so1796428a12.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779225650; x=1779830450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQE+A4dldZsiuCry6rodKF1gp5JxyNaxO+EZ49og5TE=;
        b=YQi4rLMbQW/7Dzls4euHNes99RHcOxD9zr2oTcmyjFb+EJ52aMcWa2v7+htCOkBtIP
         Qj3LfOIVws2Xo4CgbUnMHE54Y0sVpkOvls8ExCoiaQc1Yiykf2gTG5eI6Y7tKH4mpk6U
         jE5OWAovAdkQXTQL49TlatzylwX/zVZJHH8twnDonPAIG/3l3rdYnaGtIt3Co0NsvShy
         YkqdXbDBswGgSE1EZOgShanu6cBTjOO25Ml02GUL5WqqQEYjV+DdecTaac8kCXOE2xuh
         oYCW1nWkW58cchEfIKu1hayp5kg7nuf0Cm/6jKa17+FQGs/fvNe1fhffTsjliphOo+mL
         0a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779225650; x=1779830450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQE+A4dldZsiuCry6rodKF1gp5JxyNaxO+EZ49og5TE=;
        b=h3BsNvKnjQc2jIyjjOUwuCuBQxIaPtHSmgYj3g5Ndx2+vkOHLrew40SCh4FwjrKAQO
         YAzzTWlnXG0JLdNWs7nUXXuf6hqtRrgsNTgS04Xnl7SSrDaYH3O6PdRUzEU961bykYlt
         MzPFrHkRK8lx2/1hd+/is2ILDXXfvUXtYXFELA3Hm81Li4jHfwnbK6RsjwBZK8n6amLi
         5L4L0UvF3TCbMwEIFnlmiVNaQBVPAEM/UFZ35js4BJ3IELayOKuEnSmO2Tep0NLgZkth
         HSiMVBN8UsEn9XJD1Th4AHh+t/oMSq5OhxKBfFwAQxgL+rCSGNCtfueaafCu2atR+AGc
         gY+Q==
X-Gm-Message-State: AOJu0YzOjSMIIM7ChiesxTWpz+lNe9IAbAkmKuWvpA4GgpVG4+Fa83pe
	TevOgFRyT+3p3LUCTFwt7XfzYK6MJe1YlqwQAmMTxUD7kpaCgg54U1fp
X-Gm-Gg: Acq92OFZ3RRO9+JT7ktJstO7EBoV7CAmG8s7L/1yj9PKxNS4WW1rpptWCi/qdUdOK0n
	yj78+a8Z1GX95b+m4Hw6xV/3Pi4HAe9Xc+jEhOrlTq2eK2iS6xsjnl58zbhhvOH5/hYXIsMbqve
	6uC0edTE1Hj3PPIFnsC99rEyGhMTmXG9FMgYZKOrjq3hgWkdjgbXa+rYo7OJAvfkN8CuNjnHGTY
	Yq/t5rXCC2AkAowHoQ4qhN7tOeQsR0JdiFJOF6iYqRpHwxAvvrt08XXt2ge+EIQEUlbhM3DPEb7
	FWuRUQxBvJKiJ5Y1GtQ+vrq+Ray8Ctn9JE3P1vhdOygcQv1Kiq2WadZg11zGwEiVuimZr5bCnNU
	F2ifogVUp82KUgPDlqhIm6Mebjnodqz2V0MvgHEnbJkO3gygpep+TYQlCVH4d9hpabrjr0eU6/5
	vJyQXcH6w7WVJktbsY
X-Received: by 2002:a05:6a20:914f:b0:3a3:adea:83bc with SMTP id adf61e73a8af0-3b22d3369b4mr18265361637.15.1779225650394;
        Tue, 19 May 2026 14:20:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7809esm24275139b3a.44.2026.05.19.14.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:20:50 -0700 (PDT)
Date: Tue, 19 May 2026 14:20:49 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev, 
	jordan@jrife.io, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v6 3/6] bpf: add bpf_icmp_send kfunc
Message-ID: <agzUE_ky01u_YuSe@devvm7509.cco0.facebook.com>
References: <20260518122842.218522-1-mahe.tardy@gmail.com>
 <20260518122842.218522-4-mahe.tardy@gmail.com>
 <ags3HARTFYwKU8nR@devvm7509.cco0.facebook.com>
 <agtJ0e_hlHS3Es_q@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agtJ0e_hlHS3Es_q@gmail.com>

On 05/18, Mahe Tardy wrote:
> On Mon, May 18, 2026 at 09:17:45AM -0700, Stanislav Fomichev wrote:
> > On 05/18, Mahe Tardy wrote:
> > > This is needed in the context of Tetragon to provide improved feedback
> > > (in contrast to just dropping packets) to east-west traffic when blocked
> > > by policies using cgroup_skb programs. We also extend this kfunc to tc
> > > program as a convenience.
> > > 
> > > This reuses concepts from netfilter reject target codepath with the
> > > differences that:
> > > * Packets are cloned since the BPF user can still let the packet pass
> > >   (SK_PASS from the cgroup_skb progs for example) and the current skb
> > >   need to stay untouched (cgroup_skb hooks only allow read-only skb
> > >   payload).
> > > * We protect against recursion since the kfunc, by generating an ICMP
> > >   error message, could retrigger the BPF prog that invoked it.
> > > 
> > > For now, we support cgroup_skb and tc program types. For cgroup_skb and
> > > tc egress, almost everything should be good. However for tc ingress:
> > > - packet will not be routed yet: need to set the net device for
> > >   icmp_send, thus the call to ip[6]_route_reply_fill_dst.
> > > - fragments could trigger hook: icmp_send will only reply to fragment 0.
> > > - ensure the ip headers is linearized before processing, and zero out
> > >   the SKB control block after cloning to prevent icmp_send()/icmpv6_send()
> > >   from misinterpreting garbage data as IP options.
> > > 
> > > Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
> > > The interface accepts a type parameter to facilitate future extension to
> > > other ICMP control message types.
> > > 
> > > Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> > > ---
> > >  net/core/filter.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 118 insertions(+)
> > > 
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 9590877b0714..843fa775596b 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -84,6 +84,8 @@
> > >  #include <linux/un.h>
> > >  #include <net/xdp_sock_drv.h>
> > >  #include <net/inet_dscp.h>
> > > +#include <linux/icmpv6.h>
> > > +#include <net/icmp.h>
> > > 
> > >  #include "dev.h"
> > > 
> > > @@ -12464,6 +12466,110 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
> > >  	return 0;
> > >  }
> > > 
> > > +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> > > +
> > > +/**
> > > + * bpf_icmp_send - Send an ICMP control message
> > > + * @skb_ctx: Packet that triggered the control message
> > > + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> > > + * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
> > > + *
> > > + * Sends an ICMP control message in response to the packet. The original packet
> > > + * is cloned before sending the ICMP message, so the BPF program can still let
> > > + * the packet pass if desired.
> > > + *
> > > + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
> > > + * supported.
> > > + *
> > > + * Recursion protection: If called from a context that would trigger recursion
> > > + * (e.g., root cgroup processing its own ICMP packets), returns -EBUSY on
> > > + * re-entry.
> > > + *
> > > + * Return: 0 on success, negative error code on failure:
> > > + *         -EINVAL: Invalid code parameter
> > > + *         -EBADMSG: Packet too short or malformed
> > > + *         -ENOMEM: Memory allocation failed
> > > + *         -EBUSY: Recursion detected
> > > + *         -EHOSTUNREACH: Routing failed
> > > + *         -EPROTONOSUPPORT: Non-IP protocol
> > > + *         -EOPNOTSUPP: Unsupported ICMP type
> > > + */
> > > +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> > > +{
> > > +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> > > +	struct sk_buff *nskb;
> > > +	bool *in_progress;
> > > +
> > > +	in_progress = this_cpu_ptr(&bpf_icmp_send_in_progress);
> > > +	if (*in_progress)
> > > +		return -EBUSY;
> > > +
> > > +	switch (skb->protocol) {
> > > +#if IS_ENABLED(CONFIG_INET)
> > > +	case htons(ETH_P_IP):
> > > +		if (type != ICMP_DEST_UNREACH)
> > > +			return -EOPNOTSUPP;
> > > +		if (code < 0 || code > NR_ICMP_UNREACH)
> > > +			return -EINVAL;
> > > +
> > > +		nskb = skb_clone(skb, GFP_ATOMIC);
> > > +		if (!nskb)
> > > +			return -ENOMEM;
> > > +
> > > +		if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
> > > +			kfree_skb(nskb);
> > > +			return -EBADMSG;
> > > +		}
> > > +
> > > +		if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
> > > +			kfree_skb(nskb);
> > > +			return -EHOSTUNREACH;
> > > +		}
> > > +
> > > +		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
> > > +
> > > +		*in_progress = true;
> > > +		icmp_send(nskb, type, code, 0);
> > > +		*in_progress = false;
> > 
> > [..]
> > 
> > > +		kfree_skb(nskb);
> > 
> > I was going to suggest to use consume_skb here, I think it is a better fit?
> 
> Yeah correct, I can replace it with consume_skb, didn't know about it,
> thanks.
> 
> > But I'm not sure why you do the clone here, I don't see any requirement from
> > the icmp_send side, can you clarify? Is it because of the pull?
> 
> From the icmp_send side I think it's fine, however, this part might
> touch the original packet, especially ip_route_reply_fill_dst:
> 
> 
> if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
> 	kfree_skb(nskb);
> 	return -EBADMSG;
> }
> 
> if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
> 	kfree_skb(nskb);
> 	return -EHOSTUNREACH;
> }
> 
> memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
> 
> 
> All of this is mostly there because we allow this kfunc for tc and
> especially tc ingress. At this stage, the skb might not have a routing
> entry yet and icmp_send needs to know the dev from this or fail
> silently. This is the original reason why I added the the net patches
> (patch 1 and 2) and it was also spotted by Sashiko when I tried to
> remove them[^1].
> 
> [^1]: https://lore.kernel.org/bpf/20260515202358.20252C2BCB0@smtp.kernel.org/

Thanks for the details. Then yeah, let's just do the consume_skb part,
the rest looks good.
