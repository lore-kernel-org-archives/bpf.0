Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B233067C
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772604330; cv=none; b=nQGKumSdYs5BpWtzU5/JZmArax0NhYIGO/RWZDb2SJEMpiy+o3mTjTfvoAsxKSWD5AWTAcs3JaXe8cgkZ4OEnJ/V04XpxBzCrVSLaXxSk0sB16sei7xIPhHfONeiPVaAnMvpEVieO7bzAjD98mAtsii6/8A6j0nCAWW8j7Zk+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772604330; c=relaxed/simple;
	bh=D6bKcFrH2eJAhaghmI19rLoQQ4vDcxghtYuRg29WGcg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NsalnyoPlE7rl/jnvfAIn2sOxHTxPeC2PdTvujrHj5vbFRN4wxJrByfPetNgMHKtom+0wa31YlCSc+DYNpyW6elawYvAKUC7Qr83LaqvKgMjpVxawQ16alZ6a5JVA4X0V3EAEpmiLZFFj55TOsNOrEBhgpA5Pr0fW7LlpBn6Xqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meaIR0+8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meaIR0+8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae50a33ff8so24151945ad.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 22:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772604328; x=1773209128; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I4jzwjHLv2KUZF1szEBLqYn8fq/YjRSK6XfOmgw2EUs=;
        b=meaIR0+8jGThPtQZT0oYJ1qCBpdLEDdrkOU28QEseDuA6uatRw/V2xSpHSZxSnvgv8
         zTqizQAMVnENl0+qy6fs3yAWk4G3EqgK0vc5yDVI4lBsvOC+jMOcSdaXyxRkPiHvLHls
         W57ryb9ljzyB03Xn1YNpSWLsROs0HtfSp59D8mWFqz4m+6KMxIG5wg7JSgGR4s0rvNig
         wzAsKdt32XW4LZzEzDQ/UZtrBEmlryZc7th5tJ/zpdNZElMqwGAdLqcA5gxfgUptPsaA
         7cOklsp6U9/yDfd25/ZxABFH9IW/nSA+LImpRQhEGII5J5pjncxlA6k7EyRck2bAl5H9
         HuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772604328; x=1773209128;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4jzwjHLv2KUZF1szEBLqYn8fq/YjRSK6XfOmgw2EUs=;
        b=YmhIJiN6jblX2OxhHUqG4H/XBk1fx12JinGmm1SMItJsRwIT+I4+7KxFzta+xKnjlt
         7UZ81asHnPwN8c22wAFomqtQ0sx4Fs94h+qPOxGuEfRZtyb/NHFonaHrf925GLqBcDTs
         9qtJ8KAp0MOpm5T1oFmwkz+BhmOdkb+hTmd9nMMrBVCh6herQOJpeH2k0EvR6+cZSnr+
         aijbTWPvbvaI+R5r4P3oX/49AI8vKWBQUJtTWGBs4eZIXeB5I+CDqr+RYdVFmVxnhaZ5
         LbE+Z2q7cwZDcSbkkp4UzG8H/+UtewOSScIoNiiOsUQilve/8ngO2QNYo8VM20C+FmfU
         vbqg==
X-Forwarded-Encrypted: i=1; AJvYcCUEXqUEjo+ffaTMgv1N7t9Ax6qHyDmLN09rWnhyICLFpvtozGOTPbEZfrTnnXvCs4Ebp90=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNnW8jIDj01Ri6S+Zr3VD+eNNiV1O1IafClQ/1iLej7yh0BG7e
	Sw+ym/CSMq8SNrT6Oy+ddWOCu53W1r1ETuvyTxX5zgG9yQdrXIiIMyyDqK3IMT+z
X-Gm-Gg: ATEYQzw48Yo4cvkhvSC3TEHwg/aAH8isymIurWFjtyTYHJSxY1bry3rG2Pt1gri4ZnM
	Sz03yEdAoqcw0aJcv2UziAiK7k9lLX1OVsbXaLJA5Yv2u8FdIhD8jsZLGfaVCioLVfNTBDfEhn0
	A7OaCG5x8HTgzfH1vSSdcHsaf0gQoarq0y3WqOjJQIotCXsatM53tdHT9y/creTe70XFb8l3TSh
	dm7ZZx1NHMSaQ+e8si5wjhTRgw33DP33jyf9p0MObowsrLE6cXZmdvmaf9bkliUHFjjaDzukefr
	AxtPFoHufunBY1RNWlAOU6AMaiOz/vG7aXvLVGsQ5WE4g1e01YR1PfwXPxU0wQTShvW4ZSqcR50
	Pt/JD/p8ubHC1sRKFqqrAufbJ/pezxsYd8cKSs9UcpxzXrwnbNd34564D2wLTjvzMcQ1Pmnle+B
	Ye8kzlXuLA2yFNIkrRy3YC4L8/9f15RSjISlM7kKYlcZd76wgniRGB
X-Received: by 2002:a17:902:d590:b0:2ae:456d:b836 with SMTP id d9443c01a7336-2ae6ab365damr11199975ad.47.1772604328378;
        Tue, 03 Mar 2026 22:05:28 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f3436sm265491385ad.88.2026.03.03.22.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 22:05:27 -0800 (PST)
Message-ID: <fda9674c063db24cde39c2d97779e307943d4ba5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/5] bpf: Move JIT for single-subprog
 programs to verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song	 <yonghong.song@linux.dev>,
 Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov
 <a.s.protopopov@gmail.com>
Date: Tue, 03 Mar 2026 22:05:23 -0800
In-Reply-To: <20260302102726.1126019-2-xukuohai@huaweicloud.com>
References: <20260302102726.1126019-1-xukuohai@huaweicloud.com>
	 <20260302102726.1126019-2-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-03-02 at 18:27 +0800, Xu Kuohai wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fc4ccd1de569..ab2bc0850770 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -26086,6 +26086,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>  		convert_pseudo_ld_imm64(env);
>  	}
> =20
> +	/* constants blinding in the JIT may increase prog->len */
> +	len =3D env->prog->len;
> +	if (env->subprog_cnt =3D=3D 1)
> +		env->prog =3D bpf_prog_select_jit(env->prog, &ret);
> +

I probably miss something important, but would it be possible to put a
call to __bpf_prog_select_runtime() here and remove it from syscall.c:bpf_p=
rog_load()?
Thus avoiding the need for `jit_attempted` parameter.

[...]
