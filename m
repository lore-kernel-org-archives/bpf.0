Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F994411A1C
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789422931; cv=none; b=ZytpvtBHKZMwGLKM2nSGH+CSBq45Mv8zy8zXnKbkFTzffai9xOtd7BGMJUbxWUTOdogEgTuuTXqyh5r5XJZE6AXRwnGwk+bXCflx+kXXaOsa2goU1RcTnBv6RBpMHQGXS/EoC8QvUy7e1mUhQVuz9qR2SNPv0eDzIyqHgKSrgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789422931; c=relaxed/simple;
	bh=ZW24AzKibRmsChTIZFpOqpEWa8pPmQADDutsZs1I8K8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=N3l/6Xe4P+QzvUkP1cp6+r8VfDIkvdZxol0qJBUgAkUu56S/qnusHLpW3+igviu3t/F1jgBkvHXGwG8IFDWJNMwZm90HcE/gMg8WLinwMgCu7trBrURw6QcigloYrzrG5rI9V/A8WYCh83rqE47mOiQ9OYulZfX2NLAa4I3z7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=N/h/zzjJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="N/h/zzjJ"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-869d181419bso3580428b3a.2
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 14:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789422929; x=1790027729; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T/TGZ0NqpBEB9GgHRd+TQ3uXQZZ6N+mNyW4FV6tZL6I=;
        b=N/h/zzjJjRH0m+Oyfcj/xy5x9EtK3sUMWeVZlp5JgAojOOX004qchGrl2hB9yCEskF
         tJwf1R/NCSK9yAI+K4nYw3dVIudOhV5g9aeBCPASqZMgy1vJLiDiW+YYsKYeHQjUiEXX
         WJkoogutrbWSr3WelghTNQVTyoAK3SKRNPxhi5Uio4LpT8Dxv4zgHCcndxHMTeO4QquC
         +8Q9wHh2fHVVe/OlrMsy/QZgMofWG4QakSORIU+KfqEm/XBgAJXKDjAILL3xnGwgyzWA
         HzcYWoFoQ7Gks2H3rtkZ11YwZFRn1Vik6Af976XabKK3BSRh+7MQRaMqMl8vCAInNMf+
         iDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789422929; x=1790027729;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/TGZ0NqpBEB9GgHRd+TQ3uXQZZ6N+mNyW4FV6tZL6I=;
        b=x827IrprZuIU3va2uDqTIeuGC9WdbPI4cfB4R2cNtR3dWvKNs7SNso4aznSQzXb9or
         JWDDIJV77xWEOXWLxO4OoIPkfhpQOTwrZmuWntTxKddgcmNtijZgmh84Dq1DMBsT7NPC
         ggnhdfqkzgCwJ0u2Nv9Sf6/8e+7E8Wv5pvglX+REn6VNr6N9vGOZQTHqKj/Cs8Qka7Gm
         4vDRMwV1yQs/uowsTnYfTws9/Vlr5vfPbpYemnu5seh/CS+3Z1Y3uODSM3SHfW2qfLSk
         58LYYUYk5eD9Difdx0Pw30Gi03u7E1Od4jKOTH98Cq3W2KmjDVcN042sSLm1ETS1fDfk
         ZP0A==
X-Gm-Message-State: AFuF++mISroX2Gyq2BnaavhiHSSWfXFusnU92+NCLMsVeAG5kAHp0RYY
	oWGfRMiILuhjmQ3vKpnhAx710gkNFLADxNeCa3gn6OTnzOqZ8zD45EhOPU0WAGQIPdo=
X-Gm-Gg: AYBFou2TQoO0+QSU9w2ShA/Nhyai6p2sfgz2U2jTd09bk5SConb8Zpd7uClqxWkEwbs
	Z+/0p1hGh3lP1tWdDTzkm1KC73sixPZf5gz6eLmRY3xD+pY47Sl9EGMVAsFtkB/UTv4H3nh4NYD
	Kf2Rs2hFUcF/7bEpuWvG5MnvxCUd9kgxzoN2A18/7jWUl4f6HeCkZZzmDm/RLFIEarObAi76FY3
	EsZmo3FKlzQ+SQYTxlL9weAS+wZ4b/Gu67EB9/giDY8YQAJz7okL6AZnGJfGF4ryV0P2rglChJA
	1DG5e9Glg5iAvZjv8cko+dV9gZtxCCPe1KOtFuJpDGseacbL6QhG+6mkoVjhEMSrv/6QpJy8F/g
	SWANm7KkQvq7cu6Y/5GIBo/0Vi88foVa+2uaGOTXgI8ZPpf1hdbt08VPQ5xjniD60pq9vTZUW/o
	8tUl+mvJm6DOsF4LT5y8ZzHNKG94qywG0x0uC31BGuVYrRzn0q+DiqsnFhF5YPCnsuPeGgAo9IJ
	jAXP6PhHWIri41VbtWl7cSMg9oD
X-Received: by 2002:a05:6a00:2403:b0:864:cbc5:b8c1 with SMTP id d2e1a72fcca58-86f83344128mr8757554b3a.2.1789422929402;
        Mon, 14 Sep 2026 14:55:29 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29dc09d4sm5106016b3a.47.2026.09.14.14.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 14:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 21:55:26 +0000
Message-Id: <DLFDHJU82VG2.PNNHZELXE80C@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Shihuang Liu" <shlomojune6@gmail.com>, <netdev@vger.kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <akpm@linux-foundation.org>,
 <leon.hwang@linux.dev>, <yatsenko@meta.com>, <kpsingh@kernel.org>,
 <dmitry.baryshkov@oss.qualcomm.com>, <jordan@jrife.io>,
 <nhudson@akamai.com>, <avinash.duduskar@gmail.com>, <rongtao@cestc.cn>,
 <joe@wand.net.nz>
Subject: Re: [PATCH bpf v2 1/2] bpf: reject incompatible socket assignments
X-Mailer: aerc 0.21.0
References: <20260911172313.64009-1-shlomojune6@gmail.com>
In-Reply-To: <20260911172313.64009-1-shlomojune6@gmail.com>

On Fri Sep 11, 2026 at 5:23 PM UTC, Shihuang Liu wrote:
> bpf_sk_assign() permits TC ingress programs to associate an IPv6 packet
> with an AF_INET socket. The receive path can then interpret IPv6 skb
> control data as IPv4 metadata. When IP_RETOPTS is enabled, this can cause
> __ip_options_echo() to copy beyond its stack buffer.
>
> Reject incompatible packet and socket families in bpf_sk_assign() and
> bpf_sk_assign_tcp_reqsk(). Continue to allow IPv4 packets to use
> dual-stack AF_INET6 sockets.
>
> Check request sockets against rsk_ops->family, since their sk_family is
> inherited from the listener and sk_ipv6only is not initialized.
>
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Assisted-by: LLM
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> ---
> Changes since v1:
> - Move family validation out of the IPv6 receive fast path and into
>   bpf_sk_assign() and bpf_sk_assign_tcp_reqsk().
> - Preserve IPv4 assignments to dual-stack AF_INET6 sockets.
> - Check request sockets using rsk_ops->family.
> - Split the fix into two patches and target the BPF fixes tree.
>
> v1:
> https://lore.kernel.org/netdev/20260823101809.26802-1-shlomojune6@gmail.c=
om/
>
>  include/uapi/linux/bpf.h       |  4 ++++
>  net/core/filter.c              | 31 +++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  4 ++++
>  3 files changed, 39 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 732b35cc08d1c..5d8f5e2c8db38 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -4568,6 +4568,10 @@ union bpf_attr {
>   *		**-EOPNOTSUPP** if the operation is not supported, for example
>   *		a call from outside of TC ingress.
>   *
> + *		**-EAFNOSUPPORT** if the socket family is not compatible with
> + *		the network layer of the packet, for example an **AF_INET**
> + *		socket and an IPv6 packet.
> + *
>   * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u6=
4 flags)
>   *	Description
>   *		Helper is overloaded depending on BPF program type. This
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 61940e7535523..e9cc76b775c0c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3491,6 +3491,32 @@ static int bpf_skb_proto_xlat(struct sk_buff *skb,=
 __be16 to_proto)
>  	return -ENOTSUPP;
>  }
> =20
> +static bool bpf_sk_assign_family_ok(const struct sk_buff *skb,
> +				    const struct sock *sk)

This should also be used in bpf_skb_adjust_room that can also change the
address family of the skb after it has been checked against that of the sk.

> +{
> +	unsigned short family;
> +
> +	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
> +		family =3D AF_INET;
> +		break;
> +	case htons(ETH_P_IPV6):
> +		family =3D AF_INET6;
> +		break;

What about VLAN?

pw-bot: cr

> +	default:
> +		return true;
> +	}
> +
> +	/* Requests inherit the listener family, but have family-specific ops. =
*/
> +	if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> +		return inet_reqsk(sk)->rsk_ops->family =3D=3D family;
> +
> +	return sk->sk_family =3D=3D family ||
> +	       (family =3D=3D AF_INET &&
> +		sk->sk_family =3D=3D AF_INET6 &&
> +		!ipv6_only_sock(sk));
> +}
> +
>  BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
>  	   u64, flags)
>  {
> @@ -7989,6 +8015,8 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, st=
ruct sock *, sk, u64, flags)
>  		return -ENETUNREACH;
>  	if (sk_unhashed(sk))
>  		return -EOPNOTSUPP;
> +	if (!bpf_sk_assign_family_ok(skb, sk))
> +		return -EAFNOSUPPORT;
>  	if (sk_is_refcounted(sk) &&
>  	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
>  		return -ENOENT;
> @@ -12526,6 +12554,9 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __=
sk_buff *s, struct sock *sk,
>  	if (net !=3D sock_net(sk))
>  		return -ENETUNREACH;
> =20
> +	if (!bpf_sk_assign_family_ok(skb, sk))
> +		return -EAFNOSUPPORT;
> +
>  	switch (skb->protocol) {
>  	case htons(ETH_P_IP):
>  		ops =3D &tcp_request_sock_ops;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 732b35cc08d1c..5d8f5e2c8db38 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -4568,6 +4568,10 @@ union bpf_attr {
>   *		**-EOPNOTSUPP** if the operation is not supported, for example
>   *		a call from outside of TC ingress.
>   *
> + *		**-EAFNOSUPPORT** if the socket family is not compatible with
> + *		the network layer of the packet, for example an **AF_INET**
> + *		socket and an IPv6 packet.
> + *
>   * long bpf_sk_assign(struct bpf_sk_lookup *ctx, struct bpf_sock *sk, u6=
4 flags)
>   *	Description
>   *		Helper is overloaded depending on BPF program type. This

