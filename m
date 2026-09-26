Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D11331EC0
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790437891; cv=none; b=Q4yc9a6xWk2M0SRsvR/WnguI6CQCwVHW1dgMJSqOrqQB2fj2zY8EW1r1BqdYA/xtZIqdXuzEEA1A4mXOz+89CM2f1LH4FVB4wBNY0DgHXY5k26FQKr3bQg9rmb4SOYCBr10HuYZ5e66da43MaT/CAOdIp9kUSXfIpvujK4cICu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790437891; c=relaxed/simple;
	bh=JreUhmC8q/f2ES1B0oXR1kXK7kyb8EDz0tA+iZUMvkg=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=lmqEN2O8x9zzwF5A8MigbomLucq2azxEvlQ2GPrr/gmw9S7m8L1k6U91Ze4XYbXirT2pz03Ai83hk0cegIiiSRhG63ZEnKWjiZAgZZ0NNunjXOvVre5SLpg2RkAr+Ht89ToyhgvBhkbpblhSWFIHRccIdceN6eLk8Z2sB1Agv2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sokd8/Fm; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sokd8/Fm"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so854969a91.1
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790437890; x=1791042690; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wCNiEYK1FuddaM7bPtuXQITHsT1CGEQa9+CWUJOkD4A=;
        b=Sokd8/Fm20u7Ic+NeflTDL2w8Y2SLL6bMkejv3nfFIMdXu3jqlwYI/dhxmFGA8DmjO
         jz00sKiKBDMOhSQ9xU9mPH4Ea734dRSUY9QDu1z5p49EdlGlZbKrI+3Ir0Yf3S3j6bC8
         2r4pffpwMwnWNf/IQ2hKu0AW1GztUsGFm1sLGkmqNtUYKX4bxt2cPk+EbSwtNGED67H1
         dg6G7LTuoppVJbEKxdIdkUnnQ27GzFdWqzfZ/onD6Vgu5B4d14d6Dw8k5yiievzhYafH
         Xu1tsTyFZlrDly3K1vZKnNKYG25ubA4aVKinmBggYD8aZB33I4Am6l4R4KWTBeP/4+sY
         nhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790437890; x=1791042690;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wCNiEYK1FuddaM7bPtuXQITHsT1CGEQa9+CWUJOkD4A=;
        b=uvTFdcNuEOpJC2+UXyjEfGzLXazYe9sT7zTSETrT6k3xgQoiuiS9R9QUBPlwIs6N80
         /Rw9zHpbxBl6JIylBxJ0dBPp3Pikb1GBpfVj7CVu06kwZ2n+8uKKSJKmoBlDIHw0yYS0
         1E79zjut2f8zetS59VhPtjxaQ0Ahp4dNJLeSj8UQ58Q2YtCvZZH9FGkR2n0FhsIedMnc
         Xz997TZ3hvWyM7687AzRzs/+UzjXr+wWXN8XBWXLrHmDzbZe0s7MW3D5X8w5dVqEY5vw
         gGsQ714ntyn/B/cn91VDga0gJTZIeuaFInM0RAqEw8H+bG6Pgk+G5CslxsruN8sJy30A
         yPgw==
X-Forwarded-Encrypted: i=1; AKwUvBzh/umHIwy94fdZx2FEfq+F+dwEZOBpfqHl4ODnWXwlQE+q50Pdp7xW1SDNp47XTP1Qogg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1M2kdqctv9eoXashvBntXaWwtqYU+ixMT78bV/WAwCrGJCuWL
	QF1ZPiWwQzVlcNlqvaYxBGKfYxHwWMmNDad0qIf0QbXeIHGs+cqAFlx8
X-Gm-Gg: AYBFou0YZ/MmLtsVZ2UvndiIuburODs4V7osg3k1TbUbg6ZSddb4KBMILzVyClrUDMd
	dMKy+yunhueiS4s5/mKr2g0foSymxDz+ZFBxhJYeiMtYeNKzNhA9U+dr5Qie1aen4lcU1DoMP5R
	7M8jOhsTpMuTZmftI1Lb4lsdba2eCK6qNmb4UJ2O0GBBy48iwvvd1/UkfWVEv+39fwZhK+7iqwU
	11kGhNyqhP6U6v8aLS2T+H9IAZZFgMpXybn3DLg4OalQ4xwl0aYF6eXT6xCcXPbBOGpyRD2akFr
	WnhWKUz6Pyd7qJGN0rUNijqwX1feM6CpNxg8MSriBtcL4Do3baWTKpNjdBLuyTEh4O1u4lix2dK
	PfcZrpbRffSSotVXFkJNoLNoK0orgEaf67xKmhOcVcWWkFQi2lm68AlW9JDwmCAp/yqpCfQ9hvn
	3Bv496Jddddg+0FeRCrzn4lOcGM3h5X2gy/Crs60T8N/pYoB1eUbQ34HHX4jdwCCcBO+5aHwbYf
	FNue6aksER3KMxnq47z+D9sd4yhZktcDOGtmZ0zXGnNTxsIdyJWCdobor8cnQPBOMpX2PBCk35J
	dik=
X-Received: by 2002:a17:90b:590e:b0:39d:fd82:de0c with SMTP id 98e67ed59e1d1-3a09856feaamr7297242a91.2.1790437889760;
        Sat, 26 Sep 2026 08:51:29 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5d0sm18274903a91.4.2026.09.26.08.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 08:51:27 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 15:51:25 +0000
Message-Id: <DLPD9DRXXOGK.1QIUC9VKTZU08@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 01/36] bpf: track may_write flags in liveness
In-Reply-To: <20260926-scev-minimal-rebase-v1-1-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com> <20260926-scev-minimal-rebase-v1-1-c8e5ab5ba79f@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 26, 2026 at 07:19 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> Compared to must_write, may_write includes any possibly modified slot,
> including partial writes, and does not kill liveness.

It doesn't include the writes done by helpers and kfuncs.
bpf_helper_stack_access_bytes() returns -size only for MEM_UNINIT args.
bpf_fib_lookup() has ARG_PTR_TO_MEM | MEM_WRITE for params, so
record_arg_access() gets +size and the call has 'use' and no 'may_def',
though the helper writes into params.
Same for raw uninit mem when !allow_uninit_stack and for every
kfunc mem arg that is not __uninit.

> -__msg(" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24{{$}}")
> +__msg(" 6: (85) call bpf_iter_num_new{{.*}}          ; def: fp0-24 may_def: fp0-24{{$}}")
>  __msg(" 9: (85) call bpf_iter_num_next{{.*}}         ; use: fp0-24{{$}}")

bpf_iter_num_next() is 'use' only too.

Returning a write as a read was the safe direction for liveness.
For may_write it's the opposite.
What does SCEV do with a slot that has no may_def inside the loop?
