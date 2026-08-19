Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46DC282F06
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160337; cv=none; b=QZAY6dtV59Fo8le+TTorKKAXzhxp2SOtRcYIXSDNQvdjnJZad91yvyedh1TnZ6UEQdY9T6lqk74QMTo1rGfK9+8T9J6PFFufjkNdFi0SgDo5sbZqZ7Hh+9ZA8+K62VTvvundsZxTMSRV8q6psENIToQtOwentNVv8oPfMMiUl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160337; c=relaxed/simple;
	bh=25RVr0PzaJB5SGq0J64QVvtXfLUWuggQny+pEzf2y5g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=A8/6VGyE3tCEg4u/KlI/zEXP2f0tYNbYCCp6LR7fLS0IR+ddsyS7xJnREIdXUM8WYLhrw0D+rMQq8nMOiFfk/fcoIJ114DvjVu+YZetzBpb0aqg3n6KR1JKwmqJ2E51j+g5wlHRN6FJnxpYQ605oRlpBenER+YGmndv20t8kuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=Wu8XlbrS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="Wu8XlbrS"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so1090029b3a.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787160335; x=1787765135; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T2WNbz/EDWuobLOQ3nNKJ3uRAjrkuktkhvK0BdgU1Z4=;
        b=Wu8XlbrSnbiExm76tU/8htulKssxcYQ6au8CrOHS7zXclP+W6ZdaKIBr08j/75XOA7
         dmRT/k80WzURqhRgdHEpaKQEHacO7hrVyIFTtdTWyLs0YzHGH6IC7lyDKh0n1DLtqbZy
         0iBBU2sADVCt2GDN6YDyyixk+Am6/pXBLuS8q2ijXLGmyYa3CzxjiEF6JkaKB+EPDrL6
         4lMMPyDZqkoCgXtrGx5lzy58I0h9Rx8Co9wq/TqJl06hKtrPxTZvd8WwLThx6l64HemL
         MaeiPxYJFJj5eDCp+xsnypBLig+CgDI9Q404HcDCHEjKmMpG8wl2xUxVad4aDRDenWp/
         IibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787160335; x=1787765135;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2WNbz/EDWuobLOQ3nNKJ3uRAjrkuktkhvK0BdgU1Z4=;
        b=g69zh2w/E6Ysok84PLbWdKPg6sIyeJ7ejXkEJv09YKnUhTuphy70Ec4mgsEYmQRXtG
         vxEQYcWY2WeXmsTux/K6oTo11nHtzadDF1+G44c0Ifo99Hn9AHK6nzTHGAka5/391U40
         GPLUaS/r/512B7FzCD7hajQ3PlV026emivfiUSvqz2Za5dN2tYHV9SyWOsgZ51cI8ZiF
         Ox77bpLx4eV8VSURiYgvYhE3w9nzDdkmKYMw0u8klJsm0n1vuChK4+k0WeBbuK5JDTCe
         C7ooHNknWPIPZtFXxsYbS5ybT2hlKDzwFIqHw9NfqHezsHfgT3j002yIGK8Aukbz3urG
         gZVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrDjhk/zpKvn5mK686m3IoUG0nOAxqbBRzr7aA/P36dY36ThfDp/qzsEj9hWBUVdql7680=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWr17EnNONMqL75+t8VtFuC211NjZNGRnY/EM3rPkfILGr7Bn
	qHe6OII0paKDxHdwicv2w4tdk4eku3S80YBbPt2M5/QEV1OsPQFQfNG4rp3/DPahPXQ=
X-Gm-Gg: AR+sD11cSlLUTCXd8osu+vu3TG/CHw45ANkgyWthq1Up0VbBIyr5PpECyJA53FMXDFs
	mg7V+WS4doX+Vt5RjXZKmnIEkZoVd5+eFtVhF2hK8tqMzVeqpBCqiqnpBSl/uBbexa+YjCRH6CB
	OvROW4hNubYuxrxpZJrjPS4tYd8+aUz6PWBIn1KQSlyO/9J6jQqbdaMUjS891g0i8ySXh2Lw/Um
	Wn+4V92GNDHfGPub5F/alYKcmXUsUJ2Gyxh20xwkWA7W8MSkOIffsY8ZUMo9oOjBQr+S9+y4bTr
	ev/T7t6p695Epc1djJ2RFJC+iM2rpMrdVaz6EyK9K6nIEUfmKfU8LpJFAgEyzFrB0VnDqV2MutV
	dIXl7iFN5U33L7XQxM+C8V3sG8QEzulLWkEvfp4vhYyMQJ4DuG9okxY/PZ6sdJULpKFbHg8px/I
	nDcIfxJQFJgxNHEClQNBOPjYmgygKi2ieIxhsGWlop8j1BPJWDE88ZQRtXC+MZSjnydEitDeG+T
	MH8KW4PllPDxNsxeWvIpG4l73g2
X-Received: by 2002:a05:6a00:438d:b0:848:8619:c149 with SMTP id d2e1a72fcca58-851d380131cmr10676044b3a.2.1787160334810;
        Wed, 19 Aug 2026 10:25:34 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc154f1e54asm870811a12.0.2026.08.19.10.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 10:25:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 13:25:33 -0400
Message-Id: <DKT3GQZABXQ6.39CXPMIP4DSKF@etsalapatis.com>
Cc: <linux-kernel@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Yuan Chen" <chenyuan@kylinos.cn>
Subject: Re: [PATCH bpf-next v3 2/3] bpf, arena: fix range_tree_set
 inconsistency on kmalloc_nolock failure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <chenyuan_fl@163.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260810134800.2875487-1-chenyuan_fl@163.com>
 <20260810134800.2875487-3-chenyuan_fl@163.com>
In-Reply-To: <20260810134800.2875487-3-chenyuan_fl@163.com>

On Mon Aug 10, 2026 at 9:47 AM EDT, chenyuan_fl wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> range_tree_set() pre-allocates the node needed for a brand-new range
> before calling range_tree_clear(), so an allocation failure returns
> -ENOMEM without having modified the tree (previously the overlapping
> nodes were already removed by range_tree_clear() before the allocation
> was attempted, permanently losing the cleared sub-ranges).
>
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/range_tree.c | 45 +++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 15b588377a76..54055b1fe541 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -199,6 +199,7 @@ int is_range_tree_set(struct range_tree *rt, u32 star=
t, u32 len)
>  int range_tree_set(struct range_tree *rt, u32 start, u32 len)
>  {
>  	u32 last =3D start + len - 1;
> +	struct range_node *new_rn =3D NULL;
>  	struct range_node *right;
>  	struct range_node *left;
>  	int err;
> @@ -208,20 +209,40 @@ int range_tree_set(struct range_tree *rt, u32 start=
, u32 len)
>  	if (left && left->rn_start <=3D start && left->rn_last >=3D last)
>  		return 0;
> =20
> +	/*
> +	 * A new node is needed only when the range has no adjacent free
> +	 * range on either side.  This is known before clearing: any range
> +	 * covering start - 1 or last + 1 survives the clear as an adjacent
> +	 * piece.  Allocate only in that case, before modifying the tree, so
> +	 * a failure leaves the range tree unmodified
> +	 */
> +	left =3D range_it_iter_first(rt, start - 1, start - 1);
> +	right =3D range_it_iter_first(rt, last + 1, last + 1);
> +	if (!left && !right) {
> +		new_rn =3D kmalloc_nolock(sizeof(struct range_node),
> +					__GFP_ACCOUNT, NUMA_NO_NODE);
> +		if (!new_rn)
> +			return -ENOMEM;
> +	}
> +
>  	/* Clear out everything in the range we want to set. */
>  	err =3D range_tree_clear(rt, start, len);
>  	if (err)
> -		return err;
> +		goto out_free_new;
> =20
>  	/* Do we have a left-adjacent range ? */
>  	left =3D range_it_iter_first(rt, start - 1, start - 1);
> -	if (left && left->rn_last + 1 !=3D start)
> -		return -EFAULT;
> +	if (left && left->rn_last + 1 !=3D start) {
> +		err =3D -EFAULT;
> +		goto out_free_new;
> +	}
> =20
>  	/* Do we have a right-adjacent range ? */
>  	right =3D range_it_iter_first(rt, last + 1, last + 1);
> -	if (right && right->rn_start !=3D last + 1)
> -		return -EFAULT;
> +	if (right && right->rn_start !=3D last + 1) {
> +		err =3D -EFAULT;
> +		goto out_free_new;
> +	}
> =20
>  	if (left && right) {
>  		/* Combine left and right adjacent ranges */
> @@ -241,14 +262,16 @@ int range_tree_set(struct range_tree *rt, u32 start=
, u32 len)
>  		right->rn_start =3D start;
>  		range_it_insert(right, rt);
>  	} else {
> -		left =3D kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT, NUMA=
_NO_NODE);
> -		if (!left)
> -			return -ENOMEM;
> -		left->rn_start =3D start;
> -		left->rn_last =3D last;
> -		range_it_insert(left, rt);
> +		/* No adjacent ranges; use the pre-allocated node */
> +		new_rn->rn_start =3D start;
> +		new_rn->rn_last =3D last;
> +		range_it_insert(new_rn, rt);
>  	}
>  	return 0;
> +
> +out_free_new:
> +	kfree_nolock(new_rn);
> +	return err;
>  }
> =20
>  void range_tree_destroy(struct range_tree *rt)

