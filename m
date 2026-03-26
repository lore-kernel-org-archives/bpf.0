Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92B2DBF75
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 01:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774489768; cv=none; b=MlyVmarOkXOGBvyQ804+tdSnY3dGD2RpszFkVqXUPIIXRsw0j95m5pKi99HAgYOp5rd5MklKc1VpWzTBXL1/aof1aTc5qvGv6QpuzletVPfA3eo1NXHQ2HDXb2xh7wQCPr4P8feve6POtKDL16Eoi7i+4g00AWfAnFL0KuHpA+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774489768; c=relaxed/simple;
	bh=GTaFnwGNfdgg0wmbzGs2jW7nDaj1/uyRzrmfCE5Ly6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Um74l0T2BfcgHI/YvXCBLIT1q2q3TQx5F30QKQM9mRaKT5VhpwKH/NOqjo6gQ4aNyNUTlvwwUy4cxS1S7ccFemOfbWycU9BwtDRjqeTMsJNPBBv7UzEuBkbzE9oHpFiJ2WQqGy3LSB99li1gsf0mgMMmvzw0F7POaQayRo8O/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JJvbe2y+; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JJvbe2y+"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-415b23dd6e5so189091fac.3
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 18:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774489764; x=1775094564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AzggYU7nJxlqFueGBHHNK6M7p48nU6BANSh6J3W16ms=;
        b=JJvbe2y+HHo0+KZPoyrLHwndHsiVBpCFXdO5fQgBURZe4uxZQ1QNc+MtOF/sI5qqYm
         N6llf6qO1tB0SwKCEjBhClADLVcTLi5JtcDYp9yhkkNpiVWRBZk/CQR0jeUpqRm6cEux
         UgV6arG4LnRa1Ruz5FgaEBxqjD0R/4KOCu9pPQqRo64mwBzckFK+bHwsOIJFwT1+sR6M
         LCvpCRCMTMOypTtnzHp75VjS9sgQeCrMwmN1f13kyQuMJWD4CketwMlvN8VVwrvae2Ew
         VbUBIU2CAK8SDNZKD5tuhLYEceqMhYz8+kR1XeXe0WX8x9BQgkaUxWzTyPg6l0z7/KuC
         XdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774489764; x=1775094564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzggYU7nJxlqFueGBHHNK6M7p48nU6BANSh6J3W16ms=;
        b=OEkrcpCC8vhtZkuPmeetZ1FJzYgJf5A0ZnEqP9dAb2lvM8exwv0pWIAVWvk+eaBFuP
         GbUOaXTrjr4V6futpi5BXYOSdKfxI3g9VRD14T/xce62k1EK1mZgh/wuN6JNiqj1X5CL
         2Kr3daVGFUbkvEtIXGqxVWVefgERIP59dz3ECVhfOCUaThh5Z8RkQrWqniP/SL1NtYsp
         XbYV18Tl7rRv/bcDCRWSZas42b04pl2pMuKgcgqQsl5xHfRd2nBl0O+uINO/t9LA54Se
         s2MEF4BIsI57fB9Zta9QEshmf00+NSnQ/DxxJqDjfWighOx+K5dNnJKMGLUYWkKZ7e8p
         p6Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWsjQnS8Ls3dEMnkvD3JDqkdqnQ+jEWoC6OMibrVbO+Ssysm0wA9QqczkeThYSmCguCFtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUHLiSdBflvAgcoBazBRC9GF19vFo8DwdISk2Huqo/9A0rNXG
	BjlRD5Pkb0rrRGjfDQ1CxZcatNTPw1zmNDvAyje1mvGB9AorqfqZJJ0hcmtVdyLMgZw=
X-Gm-Gg: ATEYQzzHxesOtoA7dAB6lA/iSBveaKv6/CC0qxaYvvH+tGsq/6T3TjXl2dp1jXPVOt8
	NJWzC36pfNsED2F5B2PmOJ3Bpc5IOCLnVQ4HtOfCv/eOPj3l5h6VA5odonuw2xqKxY9A7NY3sZ3
	j9nvL/Bok4DC74pYnZbE1ys/dereu4rz/YpHP3rCxSj8G6O5n5B/jZ5r3/+TiVTZBBCq0TOwMjF
	ek4jyqDVGQfbqf/WhFMNzd+BcS4EDtzN5GPPJ9Q1EYhVdcHyZDEVc7XijPEnbFM+MjwFEtV+0yK
	gMiL+WLvJ0rSCoaJD2uqeY6aD7y+3Q2HIMRmd/37tpGa8LaA37xZbtxVeYFRci7p3epLz2LtMlp
	VeI3PoTl2tNCI95Yk9xcqX2FyORsqMBLCdyUXDqIMwZCZaih2SKOOyVKdAkllD0MJ1PeRxK4/PQ
	S0yiFB7gVJl/p4pBe7xXWqSf2pBeZkeZlZEUtk9auDULCB5MUQyPDezsnDKf6mNQVP1ZWQ4SJYQ
	TYfqvckeg==
X-Received: by 2002:a05:6820:2294:b0:67d:fa15:ea48 with SMTP id 006d021491bc7-67dff59dc56mr2769205eaf.62.1774489764267;
        Wed, 25 Mar 2026 18:49:24 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e0ab1b9e3sm969199eaf.12.2026.03.25.18.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 18:49:23 -0700 (PDT)
Message-ID: <5e8766d3-a801-48e0-8d27-60e75523ebd1@kernel.dk>
Date: Wed, 25 Mar 2026 19:49:22 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/12] io_uring: bpf: extend io_uring with bpf
 struct_ops
To: Ming Lei <ming.lei@redhat.com>, io-uring@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org,
 Xiao Ni <xni@redhat.com>, Alexei Starovoitov <ast@kernel.org>
References: <20260324163753.1900977-1-ming.lei@redhat.com>
 <20260324163753.1900977-6-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260324163753.1900977-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 10:37 AM, Ming Lei wrote:
> @@ -493,7 +494,16 @@ struct io_ring_ctx {
>  	DECLARE_HASHTABLE(napi_ht, 4);
>  #endif
>  
> -	struct io_uring_bpf_ops		*bpf_ops;
> +	/*
> +	 * bpf_ops and bpf_ext_ops are mutually exclusive: bpf_ops is used
> +	 * for io_uring_bpf_ops struct_ops, while bpf_ext_ops provides
> +	 * per-opcode BPF extension operations (IORING_SETUP_BPF_EXT).
> +	 * The two cannot be active at the same time on the same ring.
> +	 */
> +	union {
> +		struct io_uring_bpf_ops		*bpf_ops;
> +		struct uring_bpf_ops_kern	*bpf_ext_ops;
> +	};

What am I missing here, why is this the case? What makes the use of both
at the same time impossible?

> diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
> index e4b244337aa9..e91c6964405c 100644
> --- a/io_uring/bpf-ops.c
> +++ b/io_uring/bpf-ops.c
> @@ -162,7 +162,6 @@ static int io_install_bpf(struct io_ring_ctx *ctx, struct io_uring_bpf_ops *ops)
>  		return -EOPNOTSUPP;
>  	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
>  		return -EOPNOTSUPP;
> -
>  	if (ctx->bpf_ops)
>  		return -EBUSY;
>  	if (WARN_ON_ONCE(!ops->loop_step))

Spurious whitespace change.

> diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
> index 91cf67b5d85b..1af33a89ed2f 100644
> --- a/io_uring/io_uring.h
> +++ b/io_uring/io_uring.h
> @@ -49,7 +49,8 @@ struct io_ctx_config {
>  			IORING_FEAT_RECVSEND_BUNDLE |\
>  			IORING_FEAT_MIN_TIMEOUT |\
>  			IORING_FEAT_RW_ATTR |\
> -			IORING_FEAT_NO_IOWAIT)
> +			IORING_FEAT_NO_IOWAIT |\
> +			IORING_FEAT_BPF)

Do we need this FEAT flag? If you think so, then it should at least be
dependent on whether the kernel supports this feature, eg if
CONFIG_IO_URING_BPF_EXT is set

-- 
Jens Axboe
