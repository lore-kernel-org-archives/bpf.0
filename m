Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C24332623
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 19:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328254; cv=none; b=XnV3Oygljxeg340xOXtSKjfRd9csnJrURKo1vvdNhf8a1gWZHrkzB1pcBhPfHprIKUU40cWveKPyptbxe8d25tcOYV0swZzTbPLxgjSLSif17WjmBzs99XZ01NE8x5KQoaVma2+H1ouN8bGSIB8rQNidxq8xZNGk6ZTHi8qmeQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328254; c=relaxed/simple;
	bh=325+8jrRqzV0Ehs6ZD6QD+hJ66gMQmKNW/0GhWuhPmk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=eYXi4PpkjxcSYVoxa2UbxiOINIRctlAfGg72lrBGKXQ7nZPDp7hgSMZ39gKGtdng39l1WJhBfZEi6CSDP3+qb5UXutmCjlqIY9iUnLZ9PWe6MwUIcKbDG/B6GTV9fmCJtQraJ82Gp3cf3vYMGKIMLw7wqPTp9r/s/F5XwwKVI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=MchLH8f6; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="MchLH8f6"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30bf132969bso1986830eec.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782328252; x=1782933052; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ07a+fI0gLyZ1MmFU0DlVOSt2eF2LjJV06swGrnpNI=;
        b=MchLH8f6w+/2ynLOIKUf88cE7gdcNciikZ1/ymv53YqSxZjN3QnxWFnKyrAKJ9aaT4
         FtibtS09q/0r4y1mIZPKe41RlCIakF7+GxdV7MKtxooQIWZZEqAf7tx9fRLksmDOBWzR
         OYHcsCugH9htOY48pBPth6g50fqzUS9x6qTUcvVlUClovxIQ1FFxaVMIn/odArtybp2F
         ys/RKwYT2MgqvRPlOafB9R2WRc8VH2xxJ/yAXJ+djdA+0YSA9JX2iOowBIwIe8Q6VmuA
         3F/IHaUHRgqRVPKk2tR533cjiqBGU4oLKZtDcwZLSskfgz7N59AXQn90ZsyuJBdhwi9L
         LzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782328252; x=1782933052;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQ07a+fI0gLyZ1MmFU0DlVOSt2eF2LjJV06swGrnpNI=;
        b=C1gVpOCMWJ2lPKNu79ncuPN1dKEx4+mbzMpROn8/ZjRbtj6zZN7Htsqloqovgqc6l4
         6CRXhPDWA/Od3WGmg7uZOqXZZsFImpL6CrSShZAnjD5DxIwcgAKkEyE7ZPiASCtbs9yq
         SYSQ2B2ONTDTNc8tHjaew75tfF/khtJdrgjA4huV9gKSDw+cHG7+3RnKOBTzABm5rZlN
         zw6uUMa0htmC4ACpwHzeFXAb2rcYvXhkqRP3d9g8nQVRKPz7hzic17gu6CaKGdO6sH1z
         oCLVEHWt8NXiTKUlfjaxoDcgz8BQpygz7OVn0xeMWD8mwoDRqF2WV5nuMslHjxKzfWzZ
         QLZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrqahPVaRAbNHQgjMf4k+GOSicvB3HvQjZg6rNmS4fEMiTokygGbgK2g3/mgv/u7piTbaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWgJCWl4tMYca5bsZa6I+C8dQIiTpAbjOKdUm5QX8SfowXsQz6
	RXk1wmloenFQp6uV6tl0GsXdYe1HQXA3qK34UCK3MRuh5ZqrCoZ1CXk1P3MHaBmPcFQ=
X-Gm-Gg: AfdE7cnm/Jfyd76HKUydI0AGymAnnl3x4TrYLblcV0ir3h7TlKhyMiFqUYuNaTMD9z9
	uSNlH0v82SaVipGVbkbezeeu5HTQwj5tPlXkyG6tejpEeozoYANyhA9vIAqlzJ2egTbJh9H0DTE
	fd0XMLJKtp8RwkUAnsfowQLhlS5ureXHjuAhQvgUp4anZGOlkF6DMOurqU/yIWPyNeEqL9s9+U3
	NGrAse4QbDy3FqhfAx1z9KDZwDmeeuDrjrbAz/Ajf51jv/Xc/gxiVVj9TlxveB6MceSQw6DlRkh
	0SS3Us7hORPT8haCfjrszW4xlpw6eqtX4wX7g2oz8k1Q350zr4bOydhELb/9/jbmhjFNlR+AijW
	4S2XDjMUAU0MapryNiQ6gFn/Zifg4bM3T7Te8Am4vbAUjlNrXih4pnlnjt/M8llXnosEjbQ==
X-Received: by 2002:a05:7300:cb13:b0:307:934e:da79 with SMTP id 5a478bee46e88-30c68e9019emr4624494eec.34.1782328252165;
        Wed, 24 Jun 2026 12:10:52 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::bf4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9f166dsm958792eec.22.2026.06.24.12.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2026 12:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 15:10:49 -0400
Message-Id: <DJHIMU9I8SWV.2EE7R1UL9SPZC@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <john.fastabend@gmail.com>, <jordan@jrife.io>, <martin.lau@linux.dev>,
 <yonghong.song@linux.dev>, <emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v9 1/5] bpf: add bpf_icmp_send kfunc
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
 <20260624185554.362555-2-mahe.tardy@gmail.com>
In-Reply-To: <20260624185554.362555-2-mahe.tardy@gmail.com>

On Wed Jun 24, 2026 at 2:55 PM EDT, Mahe Tardy wrote:
> This is needed in the context of Tetragon to provide improved feedback
> (in contrast to just dropping packets) to east-west traffic when blocked
> by policies using cgroup_skb programs.
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
> Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
> The interface accepts a type parameter to facilitate future extension to
> other ICMP control message types.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  net/core/filter.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2e96b4b847ce..f3aa494ed105 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -84,6 +84,9 @@
>  #include <linux/un.h>
>  #include <net/xdp_sock_drv.h>
>  #include <net/inet_dscp.h>
> +#include <linux/icmpv6.h>
> +#include <net/icmp.h>
> +#include <net/ip6_route.h>
>
>  #include "dev.h"
>
> @@ -12546,6 +12549,84 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md =
*x, u32 len)
>  	return 0;
>  }
>
> +/**
> + * bpf_icmp_send - Send an ICMP control message
> + * @skb_ctx: Packet that triggered the control message
> + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supporte=
d)
> + * @code: ICMP code (0-15 except ICMP_FRAG_NEEDED for IPv4, 0-6 for IPv6=
)
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
> + * Return: 0 on success (send attempt), negative error code on failure:
> + *         -EBUSY: Recursion detected
> + *         -EPROTONOSUPPORT: Non-IP protocol
> + *         -EOPNOTSUPP: Unsupported ICMP type
> + *         -EINVAL: Invalid code parameter
> + *         -ENETUNREACH: Unusable IPv4 route/dst attached to the skb
> + *         -ENOMEM: Memory allocation failed
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
> +	case htons(ETH_P_IP): {
> +		if (type !=3D ICMP_DEST_UNREACH)
> +			return -EOPNOTSUPP;
> +		if (code < 0 || code > NR_ICMP_UNREACH ||
> +		    code =3D=3D ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
> +			return -EINVAL;
> +
> +		/* icmp_send requires a rtable; test-run synthetic skbs lack one. */
> +		if (!skb_valid_dst(skb))
> +			return -ENETUNREACH;
> +
> +		nskb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!nskb)
> +			return -ENOMEM;
> +
> +		memset(IPCB(nskb), 0, sizeof(*IPCB(nskb)));
> +		icmp_send(nskb, type, code, 0);
> +		consume_skb(nskb);
> +		break;
> +	}
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
> +		memset(IP6CB(nskb), 0, sizeof(*IP6CB(nskb)));
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
> @@ -12588,6 +12669,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
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
> @@ -12618,6 +12703,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_s=
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
> @@ -12639,6 +12729,7 @@ static int __init bpf_kfunc_init(void)
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR=
,
>  					       &bpf_kfunc_set_sock_addr);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_=
kfunc_set_tcp_reqsk);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf=
_kfunc_set_icmp_send);
>  	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kf=
unc_set_sock_ops);
>  }
>  late_initcall(bpf_kfunc_init);
> --
> 2.34.1

