Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA19334373
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729473; cv=none; b=KgASELRE3US1R1yUYeJcN+SosgLR/Xl18I70XhkuVfLyDEJEihEN3lHHW/B7g+5XjJgrajEhTSfPstbuk+0Oo4h5IoEix4jRGXoMW/4WKFsZQ/xPxAbOL8qMmCnavn8SmTQ95kcJjmrA4VadqljuF+zTLWhQlSAd0DzvwdE8dHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729473; c=relaxed/simple;
	bh=hzyJ/yFamqomDikrPqRjWP9/PosUNpNacWc2Dsc95fw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=N8vs5cWMDaQKKcWIq6yeCEzdnakqLnGlN7pikOnWj5V+gyckt1hTFCvQYLlzsui5Nk1Hwgs9AsruqElfsFv8STQBrrqfizFEb4NB85L0eNilBD38OdVgubn808rfvR1ryY+OsJFMUA/14S5AkRVJx0Xg1aA4uZilDMi0et9Vjqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=EIsNGyBC; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="EIsNGyBC"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb7edbcde6so1007118385a.3
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772729471; x=1773334271; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0e3b8oko9uQIbCSYrE5g8rshIq1JxR8S8PuThBFjN4E=;
        b=EIsNGyBCa1ztZ4lx2RkgMsOoWHMfrkhm0l1mVX5ParQb6WAhbKj1sJmDD8bh4t10cB
         l3NRqIbfINABql02WEUiJEOMgh0PjxxV1MfziqY7pkOIX/zaCpiiE9FhjmGM2rGIMYEH
         TrfAL3O9xbX15DViQBCQJ55KMWkTwdc90p1p2LyCvzVEXVGVnTq52uwPOGpWVuqnIC9n
         KB6OzMFHB/h8wb/3PWTJR8wHCW2GLSSbK2FyqafBVQ8ZdQcaDpicgtDR5Skbf7j7T2J/
         cxCKYa549Mbe+FwUnsURbszcftRABZpBWeGMvMLXy1tnbMEfRKQ3gNLrFo8haUTER861
         3Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772729471; x=1773334271;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0e3b8oko9uQIbCSYrE5g8rshIq1JxR8S8PuThBFjN4E=;
        b=BrgUkCOaIFv56ubQ2lOPfjZ/whMaHbnoeY5DZDg1FG1eowtWJnD1t/1YE7T2FEPjz2
         aD0+/aReOqK6/fbMSAhxdjYXeNF+Ro1LaP98sxGCt1GrzcmbQ76O9ONrMaYGY3gHumfi
         d5uPc+9LQwkH1QFTDOFvIAoPenU7TwkDpmNXoRztAelP/yHkRYTp3a/BN3PGlrpBkpYn
         roHwejcdnDhM3maznMhIngb3K0NQkHW3Ng44CSazk9JB1tr4k/QgPwNPFvTw7FfIinam
         GleqxlCa1NKLB2rySSjcxs9bbn/cby9WAHf9Lh4cH7h/DB0dbfRZSTF3jl68ham1gWFQ
         TBPw==
X-Forwarded-Encrypted: i=1; AJvYcCWAxx/wkpM/OrSJxMGq6aRWmxQ5rAVlSqiPVYNdZI8bwLzqaqwslmp1BDNbJsBFR3MSU88=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlqpNj2ixkYjqhGjLtT8egR+e/R7IchWOqNFrKYfiBGDzp7As9
	w1XXbCzs8M2RU9L1FOBNS5HKQJV1UyV3dL4/QtSLW6oxO0C3RPh53u5fNZdFQ+EEqqlWEpQt/47
	3q/L7
X-Gm-Gg: ATEYQzxm6I8vsYVYbNQxl4wB6FsqO9Q6XoYTNjuEcM2Xcx4L2RGx3nYi8U47K31HOjE
	o1iRvp2JLtYwmU4pBe1cBnW/Zcf+YNKgfqhdQ9BwXJrJnBG2DiJVeiQWqCI122BXDZ5F/6c0rkx
	5LRcuY2Kd/xZeLTAgYFfXLZvH7q9JrRV7Qt/jzKXr3WsYH3GIEBVbIe/o16oRSAtcGSh8TZ95gR
	xIuVwkgXrw80M+e0EPSc4yFcGUNrMV8OoSJ/5ySk85C/OGy2mvMFk2glrJIY5faQmyepYKvdAs2
	GePFQi5UOJYxjvxnYTKOe6UYV69KcHcUgK4GefMyrlvnZLP+LNudieEgEiwcSUA6w0gjjRYMhxk
	XHyr+ppLuRMHslRd9QUspSLpD6RHsuzN7ZMNp+Jz2D8OvaHP+xKnMfuaJPLJk5BDKybJlws/frZ
	rn4xUJ04bljUUT5ndWNXA3bD8=
X-Received: by 2002:a05:620a:1985:b0:8ca:4392:c20d with SMTP id af79cd13be357-8cd6b047ea0mr66926285a.80.1772729470459;
        Thu, 05 Mar 2026 08:51:10 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf64ef00sm1937154285a.10.2026.03.05.08.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 08:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Mar 2026 11:51:08 -0500
Message-Id: <DGV05F4M6LE5.13QMFCL23DB3Y@etsalapatis.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>, <arighi@nvidia.com>,
 <shung-hsi.yu@suse.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: test refining u32/s32
 bounds when ranges cross min/max boundary
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
X-Mailer: aerc 0.20.1
References: <20260305110929.738140-1-eddyz87@gmail.com>
 <20260305110929.738140-2-eddyz87@gmail.com>
In-Reply-To: <20260305110929.738140-2-eddyz87@gmail.com>

On Thu Mar 5, 2026 at 6:09 AM EST, Eduard Zingerman wrote:
> Two test cases for signed/unsigned 32-bit bounds refinement
> when s32 range crosses the sign boundary:
> - s32 range [S32_MIN..1] overlapping with u32 range [3..U32_MAX],
>   s32 range tail before sign boundary overlaps with u32 range.
> - s32 range [-3..5] overlapping with u32 range [0..S32_MIN+3],
>   s32 range head after the sign boundary overlaps with u32 range.
>
> This covers both branches added in the __reg32_deduce_bounds().
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/progs/verifier_bounds.c     | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 4588e5b55b41..0c2a62b16ec4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -2000,4 +2000,41 @@ __naked void bounds_refinement_multiple_overlaps(v=
oid *ctx)
>  	: __clobber_all);
>  }
> =20
> +SEC("socket")
> +__success
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void signed_unsigned_intersection32_case1(void *ctx)
> +{
> +	asm volatile("									\
> +	call %[bpf_get_prandom_u32];							\
> +	w0 &=3D 0xffffffff;								\
> +	if w0 < 0x3 goto 1f;		/* on fall-through u32 range [3..U32_MAX]  */	\
> +	if w0 s> 0x1 goto 1f;		/* on fall-through s32 range [S32_MIN..1]  */	\
> +	if w0 s< 0x0 goto 1f;		/* range can be narrowed to  [S32_MIN..-1] */	\
> +	r10 =3D 0;			/* thus predicting the jump. */			\
> +1:	exit;										\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +SEC("socket")
> +__success
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void signed_unsigned_intersection32_case2(void *ctx)
> +{
> +	asm volatile("									\
> +	call %[bpf_get_prandom_u32];							\
> +	w0 &=3D 0xffffffff;								\
> +	if w0 > 0x80000003 goto 1f;	/* on fall-through u32 range [0..S32_MIN+3]=
 */	\
> +	if w0 s< -3 goto 1f;		/* on fall-through s32 range [-3..S32_MAX] */	\
> +	if w0 s> 5 goto 1f;		/* on fall-through s32 range [-3..5] */		\
> +	if w0 <=3D 5 goto 1f;		/* range can be narrowed to  [0..5] */		\
> +	r10 =3D 0;			/* thus predicting the jump */			\
> +1:	exit;										\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

