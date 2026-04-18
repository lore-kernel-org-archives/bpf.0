Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2132DF719
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538028; cv=none; b=Tup6iD67JWxpdVAxt/xnL8unVYK+3tz8Mf0UvxXAlIfcXMQ6owUX6meHA8XTmFOMsS17zulKafUSl7XTFoG3sK5eez7EOCDpwFvk4vn9T1iXnYYWjV1k80qh+tHtu+XhvKggyPgonn/aGAIwxWcw4KNdTGDKVvJba5CZH11qh6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538028; c=relaxed/simple;
	bh=0aZdY8M47hBtBw6KnD67y7urP7/zE7YKpk+MDe9phKk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=koahz+vXFfpPqm+4AY5DSpTvsluByAFHfwpJUPxJ/B9rulALjqvX4pIm/Msb3AfU0haoi/DMeAIQs6qsMN9rbpZxJ1EnYUN2JYfPTXnghinkJecUJASBncOUPA/pl+Y8cAtaHp1DfyaGAJkIomraryjXMSvQ0T+jCBGpeUp+ktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnCYXVVc; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnCYXVVc"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35fc0d7c310so1222382a91.1
        for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776538027; x=1777142827; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJ7NztpfJjfBH2F+rZZRbIyLWyO3dkuQAVJ/yL9XsK4=;
        b=SnCYXVVcWO6aZAwXKPy2YTvrtYRHQrG9gcvQI+ZkXSNCT3uXSR0+u4SA14xq/8tHwf
         XLPR2gY5Qj6UKgBrcu6eaX/vdgfLEBwWFc1uGpHmcCfjbqrB+gUjD3qjydx9FlVgv6Ij
         Z1OXtbLQ2oJj4rPQLlYOmcUOV/mnPNw1OyvFjg94T8MZcN4YTgxvcbDMrXBFMREvyRWe
         OcSquXGKDu3LdVo+2zfcuZcdvw4Vz+4zuKTKB8TeMQ+tKTOOOKfreuUdSLdJrV1nC2Yq
         TxSJFchlJGeySmfyTV8zTn/h+l2o/J2Y/LV3mTFA4BEYzJlNEZN8rkgnVcfpv3JmGADJ
         5C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776538027; x=1777142827;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bJ7NztpfJjfBH2F+rZZRbIyLWyO3dkuQAVJ/yL9XsK4=;
        b=YTsAOso/dYEGkokYHho5b4ocrTTuwAybyI+En2FFnV2S1MUKrpUdVpER1FD2qO0vbc
         ZYnR3C8FMBLBOyigj0b32heJKqXE+jAu1pTXRXiz7syrmgf7WUpYlP/uylCfCQBJ10Ti
         sOe6vR1qB9jgN+QFsp57pD+MSrbtDRUX30OZr2b29TybqhJ6+Bs5i+NBN3cZff4Dnyka
         m5tVcT0xFE2MTNUKtR3K3LR8uNnsqsXtWDZcwwOnZBvFTwYxXBa4MQvT19yAy69o4MAG
         A68KYldMHukLGahoAJF/yzC5muz0VXpc+DyQbkiofF/wtCLvQLBOt1qsPpznezr9LJ0a
         1jEw==
X-Forwarded-Encrypted: i=1; AFNElJ9gC1/UytPVrS38WRK3eXalBRxl9tNsGvqCzMsUzADHu0IX4ovnJyMk2RphVoTO98if9ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6TrIXnyUTGJdKu51XtNxhf5w1kPLmM5igfCmCDiTBsRsP4ws
	Rwa9x0t6ZxXKwPLNluiBEpD4mdayY38mgQc1t94e5D0mdPMV6G1QZ8kK
X-Gm-Gg: AeBDiet/aSAoZBtLtYwHXUMTCOKYoo+TYe36hVTdV/KeI1SISbs1hUmLkbGW8v6bcSd
	epkq82DqHsfGXOCqn13lU/97bHFmGWDv3GXVAQSB33iCwI9lhm5hlNuEU0WdMx6nJ/guLnevneK
	jrxf8J18NWFKa7BjjeX6TK+IYUZIq7/eD5nqCihUrS9vMnvX+tWguP/W+vonvL4znm3b9ip7CY8
	hxPD2WxIZ++4fzkTEVCn66Ppzqdatqs7D7D+tLhI13UmuElHL+ieUq7mLQXKlXdrzsmg+Os3hT0
	6XYxKV0T5Hs/6u8bB6WSHhmI1EeKoOdEcFNurMhUweH2WSp4/8M1fJ2y1OWwJxP+PUC5PuAM7Rl
	ViqMaMiMn7+DzD8dNOFYjgs+jo1Pn91mMN0ffdCl5jTRDU9n+lSlHhg/v3Zae2YoERQYghNkGC7
	bpV+w/7I/G1AhL25QlnNLGHNzZtYBAXNePZJH8Elhb23HMGClteThM0YeUYNmFckXMANKJiiLVC
	bMknO509uGEEpVbhr29nXfmlbGQsXUhnpl6In/ZOryJ+6kdss0zeqEEgeRsMXGWQm0=
X-Received: by 2002:a17:90b:4c52:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-361403c3412mr8430863a91.5.1776538026995;
        Sat, 18 Apr 2026 11:47:06 -0700 (PDT)
Received: from localhost ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361418c3944sm7238524a91.8.2026.04.18.11.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 11:47:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Apr 2026 11:47:05 -0700
Message-Id: <DHWI663IJRCO.CRVLYYK1H7KE@gmail.com>
Subject: Re: [PATCH bpf-next v5 00/16] bpf: Support stack arguments for BPF
 functions and kfuncs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, "Puranjay Mohan" <puranjay12@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260417034658.2625353-1-yonghong.song@linux.dev>
 <m2v7do1avc.fsf@kernel.org>
In-Reply-To: <m2v7do1avc.fsf@kernel.org>

On Sat Apr 18, 2026 at 9:39 AM PDT, Puranjay Mohan wrote:
> +               /* call1: subprog_7args_inner_call(1,2,3,4,5,6,7)
> +                * internally calls subprog_7args(1,2,3,4,5,100,200)=3D31=
5
> +                * which clobbers stack arg registers with 100, 200.
> +                * Returns 315.
> +                */
> +               "r1 =3D 1;"
> +               "r2 =3D 2;"
> +               "r3 =3D 3;"
> +               "r4 =3D 4;"
> +               "r5 =3D 5;"
> +               "*(u64 *)(r11 - 8) =3D 6;"
> +               "*(u64 *)(r11 - 16) =3D 7;"
> +               "call subprog_7args_with_inner_call;"
> +               "r6 =3D r0;" /* 315 */
> +               /* call2: reuse r11 stores from call1 (no re-store).
> +                * subprog_7args(1,2,3,4,5,6,7) should return 28.
> +                * If clobbered: subprog_7args(1,2,3,4,5,100,200)=3D315.
> +                */
> +               "r1 =3D 1;"
> +               "r2 =3D 2;"
> +               "r3 =3D 3;"
> +               "r4 =3D 4;"
> +               "r5 =3D 5;"
> +               /*
> +                * the 6th and 7th arg should be 6, 7 as set above.
> +                * But the inner call in subprog_7args_inner_call clobber=
ed
> +                * them and reusing again without a re-store will be wron=
g.
> +                */
> +               "call subprog_7args;" /* should return 28, but will be 31=
5 due to clobber */

Puranjay is correct.
The verifier should error here.
callee can modify 6 and 7th args in place in the stack.
All args register or stack are caller saved.
I believe it matches other archs.

