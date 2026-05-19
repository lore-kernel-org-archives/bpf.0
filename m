Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E9F2D7DF8
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154430; cv=none; b=pjUt8mety74HeeMvPxcmgYx8jhD0grXoKyEjhTWDmLq3+1mnZLdM51hlCuFzD5Yt2nfr95RKT+BSkLxTi+rKSnr8R9W3u/jlI2fkpyfpag+vaOH+rdQpSRqj5J9DX5kfUmRnUJNp3PZDtzdqXvf9grlM9Zbl3THsiNrE2oGI5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154430; c=relaxed/simple;
	bh=yfu3HXA6WpN97f2/JLOaEHAfe4Lu3Fr+ei26pjJ6UjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxlVlLUNI40aIu4ijjfDzo3dpaCCMKaEBjVEXnyfWyXY8mDDZbPSL4kL2juk7uvyuWN2l+SJzN58lYugsBe26sof93VJ3lekKE2BxpfOWBVNnPuszE8CYAnyuzf+E3GZBoY4615QdY9NKvVFQqNliOwWn3MxF2Xh7rXeZqLsWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=Nl9JUDMZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="Nl9JUDMZ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b9a1896db5so5950275ad.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 18:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1779154428; x=1779759228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMUulh6qid06yp999kMZYRmV0VRKarV0DjzjDNUvDFI=;
        b=Nl9JUDMZSi2Y7h5AOqoLvz7XV7wbX66yP8vU6ojg+DRPPGuANXRxW1KkDVpB0McFzW
         NNVJRZZe90ACPhbIIGTQ8rahvxpR28Ml3Z4t5vXMlAGAnUqR8c78lfnrWZZ7E2H+AxE9
         12cy5sX1yiFVnrqt3iIbnl500nRYseapg4RGYhvm/N8iRe0heT0vCWO7itB+qAuSKkWM
         nhbHw5sdYaWnuvVLxiUaIcXYF/jS6kdq5QcYcVHp5oRFoBl8XfcfEF4sZLlplzlCayw4
         vbLto2R7/e2b88bdePQPLqLRKX9TJctORZt/HizMRugAFV5QpkTbbjG6ugMVBa8OjSXh
         UL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154428; x=1779759228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMUulh6qid06yp999kMZYRmV0VRKarV0DjzjDNUvDFI=;
        b=oPsBanUpIti51NV2V9gfyihBynj02NZHbSKGQqU1AnZA32H/Fxn9d0XXPuGVHNKP/c
         8I4510LVo3DuouAFSeHjn3s1IuN/guSrQ8/OHiWVN40KKsLimua6q65wviMaElXeJm7I
         4Pm5Ks27JgbXj9ABJkdoiRUHaunXY7Jan3gBD/6PVc2bzKCzhe8W5+UPZeK3XqIqkkHf
         YkA1izd4MrmjlIogcwwXdHgJbuoflJ1aaO6eO8S6s3fH0onXw+Nx848gr8ojXZea6tgo
         UWNoRZWcMZ7wQHWiW2Rd7zCB/VgjD7nqACLBQ64bVzcmmKSuzTAFHV6OrPpTwJi7YmBn
         7J6w==
X-Gm-Message-State: AOJu0Yz1zKxFOnuVRWiYNcoRwccPLYPUC8y3odE0ipave9IR83HiGYCr
	rcJ8DX4wEjBXZ5hZw19XhdNRXBu2RziJMd5qw/LyyDPrBwxqPbLlwLSLwhnCPfFPTGw=
X-Gm-Gg: Acq92OFW+2DstkcrbkLAJm+x2EJzQD2misrei9EihG1sC54oHv03gF5LWE62pbG5zHE
	NXNYcP8AmR5ywRsWtXRb0IXLhdDxyOqROEE5mtkrzjGS83rPhbQ5byecqloWnvsT48MmJ7q8yDo
	I39waFwhbZW3cqxqgQhCL6lRaEu7CNm4lS/5PIfe3NTJl0HLWfba93CAjS02aC+Hy4GqrDNBw/e
	5fltbIO29H6k2GHJIB3nGwLbw0A5DQ/TOjz3UZ3fqJUICCc+ADU0ddLAxhXMmdROVOdmW+usGNC
	CBuNBS35BS9789VXaLGChRAUKVqvtKb8eU+FTQ5SaBsXmyozayjFNocKRpfxStj8X4rK6M62BWs
	4UKivq19AuMDguutUrvtu3zocVvHIsR/4VS43qRcAHMl7NwNwuYchfY02Eb4SbElfZLimKqlweA
	vV3ccE9tDqjwu+mUVUPqES6obR
X-Received: by 2002:a17:903:2302:b0:2bd:e01c:d78 with SMTP id d9443c01a7336-2bde01c0e48mr37358615ad.7.1779154428357;
        Mon, 18 May 2026 18:33:48 -0700 (PDT)
Received: from m2 ([83.171.251.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f291sm170130185ad.15.2026.05.18.18.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:33:48 -0700 (PDT)
Date: Mon, 18 May 2026 18:33:45 -0700
From: Jordan Rife <jordan@jrife.io>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ast@kernel.org, andrii@kernel.org, yonghong.song@linux.dev, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH bpf-next v6 3/6] bpf: add bpf_icmp_send kfunc
Message-ID: <onco52d3vpxkcc6hh3s5vuqjxanasucteq7wnqfqgzg4d65alc@q7h22nu3ytjn>
References: <20260518122842.218522-1-mahe.tardy@gmail.com>
 <20260518122842.218522-4-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518122842.218522-4-mahe.tardy@gmail.com>

On Mon, May 18, 2026 at 12:28:39PM +0000, Mahe Tardy wrote:
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
>   the SKB control block after cloning to prevent icmp_send()/icmpv6_send()
>   from misinterpreting garbage data as IP options.
> 
> Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
> The interface accepts a type parameter to facilitate future extension to
> other ICMP control message types.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
>  net/core/filter.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714..843fa775596b 100644
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
> @@ -12464,6 +12466,110 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
>  	return 0;
>  }
> 
> +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> +
> +/**
> + * bpf_icmp_send - Send an ICMP control message
> + * @skb_ctx: Packet that triggered the control message
> + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> + * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
> + *
> + * Sends an ICMP control message in response to the packet. The original packet
> + * is cloned before sending the ICMP message, so the BPF program can still let
> + * the packet pass if desired.
> + *
> + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
> + * supported.
> + *
> + * Recursion protection: If called from a context that would trigger recursion
> + * (e.g., root cgroup processing its own ICMP packets), returns -EBUSY on
> + * re-entry.
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
> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> +	struct sk_buff *nskb;
> +	bool *in_progress;
> +
> +	in_progress = this_cpu_ptr(&bpf_icmp_send_in_progress);
> +	if (*in_progress)
> +		return -EBUSY;
> +
> +	switch (skb->protocol) {
> +#if IS_ENABLED(CONFIG_INET)
> +	case htons(ETH_P_IP):
> +		if (type != ICMP_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > NR_ICMP_UNREACH)
> +			return -EINVAL;
> +
> +		nskb = skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
> +			kfree_skb(nskb);
> +			return -EBADMSG;

nit: Instead of having several places where you call kfree_skb, maybe
consider just cleaning up in once place at the end like:

out:
	if (nskb)
		kfree_skb(nskb);
	return err;
	
then in places like this do something like:

	err = -EBADMSG;
	goto out;

> +		}
> +
> +		if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
> +			kfree_skb(nskb);
> +			return -EHOSTUNREACH;
> +		}
> +
> +		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
> +
> +		*in_progress = true;
> +		icmp_send(nskb, type, code, 0);
> +		*in_progress = false;
> +		kfree_skb(nskb);
> +		break;
> +#endif
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (type != ICMPV6_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
> +			return -EINVAL;
> +
> +		nskb = skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		if (!pskb_network_may_pull(nskb, sizeof(struct ipv6hdr))) {
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
> +		*in_progress = true;
> +		icmpv6_send(nskb, type, code, 0);
> +		*in_progress = false;
> +		kfree_skb(nskb);
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
> @@ -12506,6 +12612,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
>  BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
> 
> +BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
> +BTF_ID_FLAGS(func, bpf_icmp_send)
> +BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
> +
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
>  	.owner = THIS_MODULE,
>  	.set = &bpf_kfunc_check_set_skb,
> @@ -12536,6 +12646,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
>  	.set = &bpf_kfunc_check_set_sock_ops,
>  };
> 
> +static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send = {
> +	.owner = THIS_MODULE,
> +	.set = &bpf_kfunc_check_set_icmp_send,
> +};
> +
>  static int __init bpf_kfunc_init(void)
>  {
>  	int ret;
> @@ -12557,6 +12672,9 @@ static int __init bpf_kfunc_init(void)
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
>  					       &bpf_kfunc_set_sock_addr);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_icmp_send);

Thanks, this could come in handy for TC.

I'm not quite sure yet on using it in lieu of the sock_destroy kfunc for
the UDP connected socket use case we discussed at LSFMMBPF. For socket
LB mode in Cilium to make this work you'd need to add at least one new
map lookup in the fast path to check for backend liveness and this
partially defeats the performance benefits of socket LB which right
now avoids service + backend lookups in the fast path for connected UDP.
Ultimately, it might be better to stick with sock_destroy to kill
sockets out-of-band for that use case, but still it's good to have this
option.

> +	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_icmp_send);
>  	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
>  }
>  late_initcall(bpf_kfunc_init);
> --
> 2.34.1
> 

Jordan
