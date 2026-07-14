Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B332AABA
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 06:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010214; cv=none; b=POch79bFIKS6eLGOihQKtnVDOAFzaDCA+dUOkKbEI1go43OZAbXWD1v5lpNCctFXrKRt8tQo7jRjKZDmIjBfRQx0mz+fxJpc3YkmbBSn3XisHPzd7Vtcozk54IVyJ8nvXFUoM7yMK8MjfWa8PheJKRGUTynfd/4/b5o1XtWoElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010214; c=relaxed/simple;
	bh=mrLR48Akm9GQ2K04C7ZMgBaqTqlOBP8oQOM8nbOCalE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=UZ/8IDp90SDSjgaIDgjWJyPW+gIIS9mxqE0TnbnsLDgZNGQDoysyeA0lnluscF1qVQqcQw38rDTN+1K1jypn9i5PCcphVJCuer2mW/6FufJmKc26ZlMkFNIscKSj/ABkG8dHSwxyR3d1pvDsP1jXLhyPRJnhaCCevApy98xPSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=M7z8CGqy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="M7z8CGqy"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84867f07d63so4371021b3a.2
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 23:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784010213; x=1784615013; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w4wsNoFBM5WdmRxP3Hm6ojL5xYGbiFYjA567+qOElRI=;
        b=M7z8CGqyc9WAJzkAQ4rQajfi/AheoIgOU2BGTgaxzRgra1R7xAUpus7T/c+KwnPEhk
         Mru+b4Sb8C33cspJ7E+UV1mzYj4VxY9/YLdRnhHw2mSw3YYf5qUV4gJd0KvdBGYoI0Lq
         YrriGplFLUCNUnnlhOdEl0scqklRNKM/Wffx5t/DkRy7B54nLlu30BS/fGQnQKD9uLA/
         P82EBFwm9RdK1+JH0dREcBRYPrElEoqRnirLgmo5wuOwOuHAeWxoh9c3RX9mPpS28S4d
         zPPyA7BCA+qwhqCilvEgqMwZYD13t9uC6g+lRlBHK5YlIFY+PFOYX3pIUNot0UY644uj
         Zx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784010213; x=1784615013;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w4wsNoFBM5WdmRxP3Hm6ojL5xYGbiFYjA567+qOElRI=;
        b=AoLX+cNNqhNtuMRWAwXJdv8t4PYVPsE6DPKxO/kjIDQ3e19qU+N57TQraLQMabLJy6
         NVho8BoCv8aE08rA2mC79SfAgresIcLsWPUFra8Y6DeRQ51tvQadxKSGOX7Ojd5sHdM1
         TjalxBIVfi9H+NU0lhtAHSr3tQGQADUhrXeulOn1rhwZ/LFT6YhULnmxuR2lDK1MkL+V
         GnCDJWnKduS/q3nlhaHzaWDzIEzGgOzC5uGgYlmIP8rT5pabgYXXZ4CgE299DYe4vHvv
         QcFcDdLwHcd3v3GkskDZwwTKR9GTaDTS9tUbxOAHbnrs/DjFN3YlcjIVUs5ZP8ZYcxlQ
         fTYA==
X-Forwarded-Encrypted: i=1; AHgh+RpPe+flF0JjKeRqGIJ7fD4YUxYdEYUsnpKlR/kniuN7c3lwWEQMV2mSaSXLiCa/vpQj110=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hQSZ7kb4qjNhDUpGCC0/SygSDNyQY9nk3Vss7CNo0WWXraxi
	R6itVErQtMtQuzr8YbkiYJfvscw2IMB+1tc/gJ9pLbG0luppFOvQV0HotM2VaenAagE=
X-Gm-Gg: AfdE7clkQbtguLWFBmxZWfaOBBRZLi/Xyr2TBhxAltGRStuIbD01k66egYLeZmPXZ0S
	9v29RbOMAomFOwnWGOOgqghYxEnc4ZJYbU33HZAf8feb3Rwfl20Odf0T+6r8vaQy90WAZVRCYPh
	4t7fW6n5bNNd/kgOEzmBJ6HldMCo/J8ArFUtoZw8CqCcyJvyDgaHOmrTvG2FAt+5bK6BlgBCbps
	X80IeIBX64Lf4hz0AWMzrgDx7ac63jYZpifhkwBLMLUDj1TRFzdpIligqIMNyvWCVz1nS/2WWwS
	pPngOsjCc/agMIl0h0MHxMgmO9RxCZdHr6BbHHuHKLRmydYA7ipzHAM9Wa7jHqz/hXXjeY0wSPc
	1X8KDeO7i2ESgxr9k3mHLzG0vp3hGYMZwHAt1iWdzR7VvZil8jxHOc0Cye+BcJonlANM0pEaNmx
	LiMmKaqLvvgIRif1bGno/YwVzt6UILTJoZNxwNYSOLzg==
X-Received: by 2002:a05:6a00:14c2:b0:847:b2e4:9f68 with SMTP id d2e1a72fcca58-848895dc8ffmr11323221b3a.9.1784010212598;
        Mon, 13 Jul 2026 23:23:32 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7de23asm902775b3a.49.2026.07.13.23.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 23:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 02:23:31 -0400
Message-Id: <DJY2U8WBO9RL.Y30LKYAJB2AM@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v3 10/15] bpf: Allow all struct_ops to use
 bpf_dynptr_from_skb()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-11-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-11-ameryhung@gmail.com>

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> bpf_dynptr_from_skb() was only made available to bpf_qdisc, so far the
> only struct_ops type that needs to read an skb. The upcoming bpf_tcp_ops
> header-option hooks (parse_hdr/write_hdr_opt) also want to access the TCP
> options of an skb through a dynptr.
>
> All struct_ops programs share BPF_PROG_TYPE_STRUCT_OPS, so register
> bpf_kfunc_set_skb (which holds bpf_dynptr_from_skb) for that program type
> once, instead of per struct_ops. This makes bpf_dynptr_from_skb()
> available to bpf_tcp_ops and any future struct_ops.
>
> With the kfunc now provided to all of struct_ops, the bpf_qdisc-specific
> registration becomes redundant and is dropped: bpf_qdisc_kfunc_filter()
> only constrains kfuncs listed in qdisc_kfunc_ids, so removing
> bpf_dynptr_from_skb from that set (and from qdisc_common_kfunc_set) lets
> it fall through the filter unchanged, and bpf_qdisc keeps access via the
> generic struct_ops registration.
>
> Widening the registration is safe: a struct_ops that does not receive an
> skb in its context has nothing to pass to the helper.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  net/core/filter.c     | 1 +
>  net/sched/bpf_qdisc.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4f5cbcac3e78..05f492c215e0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12635,6 +12635,7 @@ static int __init bpf_kfunc_init(void)
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &=
bpf_kfunc_set_skb);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_=
kfunc_set_skb);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kf=
unc_set_skb);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf=
_kfunc_set_skb);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_=
kfunc_set_skb_meta);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_=
kfunc_set_skb_meta);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_=
set_xdp);
> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index 098ca02aed89..5691c13781a8 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -280,7 +280,6 @@ BTF_KFUNCS_START(qdisc_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_skb_get_hash)
>  BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
>  BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
> -BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
>  BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
>  BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
>  BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
> @@ -290,7 +289,6 @@ BTF_KFUNCS_END(qdisc_kfunc_ids)
>  BTF_SET_START(qdisc_common_kfunc_set)
>  BTF_ID(func, bpf_skb_get_hash)
>  BTF_ID(func, bpf_kfree_skb)
> -BTF_ID(func, bpf_dynptr_from_skb)
>  BTF_SET_END(qdisc_common_kfunc_set)
> =20
>  BTF_SET_START(qdisc_enqueue_kfunc_set)

