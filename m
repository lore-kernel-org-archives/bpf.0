Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABCE36655B
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780349893; cv=none; b=RxPJomDLUyygV5qkB/1PbkCc4RJg496NrYx7lGl+CQd94UoNgmHkA86WqG++j2a5742NzECdKkqeUkXGXYDxPVcuiYkVGwpkCtxZH14Udemr0Eo5s+XYpYkYl2KpwinIEEQdOPtUZ+bNWCUTG9xDnpOl35+eQ9+WAqGWjkeGujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780349893; c=relaxed/simple;
	bh=J49thQU0tLDbC40LQbrf5dWPZTs/A+l7e9+LmY4skys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KqtaxBp3IjJlwVT8Ca1/CPioeZJrXmegrtDi6NxCO3uwlO7HfIzaQ4b/5rUL4RHtGUw9mK6BVXxFvcstufxhi/HCdFNsoBnzxDjI4kgHuSbp3HlNoL+XSRneE+G6CqHf5YHXmfno0knGuId3AEpYJDhaU2YjsuIyR/s32vI85Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awZbAefU; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awZbAefU"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304e83724bfso4819133eec.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 14:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780349891; x=1780954691; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d53G/+V5LF96ITn7EZOA+3GNRQdfCETQfKocNPYPMs8=;
        b=awZbAefU9YXQgdVaOJYE8Pioxj7TlyehUFF6pcAxNznRaEddr/k7DkrLUMqwRTQU+f
         +3JnH5v7XB9lzYjYAc0WN1hMdkwI50dQu1G7jDTFEL18d2iyurBbjjyXRcwNE4mIc5er
         YO52tiSZ3emyZcRKK+Bm4J88N0UBHBBMr/TAC3HZC0D1NMOcJ86SSLCHrGr9XKCImEDK
         M9f+aF9o1QQeJzQaC/XSMspQbSnH9hq3cca1wiUq5sPLeMaNkbQdwYxreIJMP5SjZ94Y
         q+wmxVm1g7BDhkeeQ0YycNcmDuhgfLEqQEKj+/b4vX0u5iZznFvyY9vJ/soQRcPxIj10
         1NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780349891; x=1780954691;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d53G/+V5LF96ITn7EZOA+3GNRQdfCETQfKocNPYPMs8=;
        b=dIj0NAsE8uuaVbARmgvCZDLl76AU5DEiGHvqvFn5Pxegp9z97zT0LshS9kbjkJKT4D
         jcpWWKU4WOqulYxXsPiLXBDmk4Iyfyn0s1hoyWGRfAVS7hUbfKUNd53bl88IRXRn411/
         KaxCz+BO3i+ACXVSbwERC5UAv2sHSXnAepFv3zf5TptHhF/xc8dQge26NvPtANa6zvJH
         /poj42U+qUyngtjBWdMglcLN3Bo9GIb5QmRoi0JovXDwXS8Y+GV7BddAIvOOAW7s+bSN
         sUU+IL00VmsiyBtUuPfQi5mH/A2AEeuwCgdGHPdTfUe64khBLaQROB2Ek1VFO4ldlC8V
         wiOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QIGLL2QMHjeHm2YuSCXcse7WgdcL+ueyK12NUhEBd799k2Y3Z5bXlX9EWszEQ5EZrrXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl3SLSj7lQOvXPLsHnmzgQGWac9UORzk7VFKQGPEBwIwOwnF+4
	QCPexQa+CRUY4KqUXUQUx13lLcOl1rOiCPEA413eWHyEb6113yhoRRMD
X-Gm-Gg: Acq92OF54chefBePRll3QYfvohgHKGJsQRQutZrqIL5xOYFTvC8WLfsdE9p2xek4sP6
	NO7mKq+FqO/Sh13wQKmFFWaHBygC6QUBXCMfCtUQEGbvC7yyfMwNe/GJyjAoxLFgSOnFEDTftZY
	EOkbzPI7iph+HhTg90F9L8cusytYYzpr8O/mzD1aK3SF8nMV5ZXTVLYhHYP0EBfnwrOuZ/VcMVL
	aU1qZ4sHURNI7YZo9mG8IMR/M9R/11CCNvMliYVcnED++wDsSBui5da3rNapUZGhWgEMjud4uzN
	RDRlyU0tEM4Tt6/YNHRdgnultZnoXQO3fLtExo7/8Bq+1/U9QDgISKvMV3Aff8NOaIv7qn1Zukr
	NOdPL0lKjYWu2bbsK20rAetaDBzHTPVcZRoo1BYyunyh2PTlkgy+UGZvSUV+x3x4YBX9FqUDlau
	r4vU3ba5agRTBnbhok4wfZx1CFQs4ERr9J+j5Hxu8AdRxckqo/1lLi6g5t0Y0HOm58NhM7jaFTg
	LR84xLmkv7n+xZs4fVxZLXFLB3/Hg==
X-Received: by 2002:a05:7301:168a:b0:2d9:a799:3c4f with SMTP id 5a478bee46e88-304fa652e17mr5611430eec.24.1780349891096;
        Mon, 01 Jun 2026 14:38:11 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c3a5:3c8c:3e68:6e4d? ([2620:10d:c090:500::1:c0f8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2eb24fsm9602685eec.7.2026.06.01.14.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 14:38:10 -0700 (PDT)
Message-ID: <35632e031e85b81cca133da8d420a3a467db3f54.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 5/6] bpf: report register diff summary
 for hot callchains
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Date: Mon, 01 Jun 2026 14:38:09 -0700
In-Reply-To: <DIY16FWK8YDS.1HLJ3UPVQ3LT7@etsalapatis.com>
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
	 <20260527-better-1m-reporting-v3-5-b3ede0588a75@gmail.com>
	 <DIY16FWK8YDS.1HLJ3UPVQ3LT7@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-01 at 17:29 -0400, Emil Tsalapatis wrote:

[...]

> > @@ -720,8 +721,11 @@ static bool stacksafe(struct bpf_verifier_env *env=
, struct bpf_func_state *old,
> >  				old_type =3D STACK_INVALID;
> >  			if (cur_type =3D=3D STACK_POISON)
> >  				cur_type =3D STACK_INVALID;
> > -			if (i >=3D cur->allocated_stack || old_type !=3D cur_type)
> > +			if (i >=3D cur->allocated_stack || old_type !=3D cur_type) {
>=20
> This new logging of divergent stack slots is identical throughout stack s=
afe. Can we factor
> it out into an error label at the very end?

Yes, makes sense.

> > +				diff->slot =3D spi;
> > +				diff->kind =3D DIFF_STACK;
> >  				return false;
> > +			}
> >  		}
> > =20
> >  		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D STACK_INVALID=
 ||

[...[
