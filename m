Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940113B58C
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770003879; cv=pass; b=lY3dGGak69UnPFAzYxkCyYebbIVg4g5XnOKnZ1gvYIwaOgFrSUzfSSISOF6lBZgVLBc3n1+rqw+2BGrOjbw/LLfzPXf2WG7Yac/4lKBtMPB/M8A/K7EC6mWXgatGrJ6fVpLKqsFg9iUkKTPwlzBUqT8s1BarOy6wWes3Urcfhx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770003879; c=relaxed/simple;
	bh=W265N1/kl4pC3GTUPkETrU5S2zTTXhxD97HiDROTkvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XX5ebghu/tB8CrgUb2d9ecvR4TNDwOiAuHi9i2O4MT4UlT+mN+1kcHg7d1lkcIkJ7B7uEelTpo7Pn6EJG+2JP5oj4rWR/iXxfk2DRsoBNl7jbAzrfZLpJdcExHxy//GJVLtuR4HadltIo/nK2wZ3gQN59MP9nWUO6afD9uixdHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpwwNWVD; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpwwNWVD"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432d28870ddso2355892f8f.3
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 19:44:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770003876; cv=none;
        d=google.com; s=arc-20240605;
        b=JQllRCxehurEN2Lw7ZVCOc9UZXTJVCGXrPOzpHU4Z6NQwCLvv0305VIPFbGS2TjeBo
         MDu5qfkAcXVzWG37JV1M2LYU2m4FbTy4/KbqVOSmb+90HvhktF73qtuaeg0qPdHHukxT
         O1EKafnytLGvtN1lpNKjGihJZqB/tBzBMC4FLa0yHA6QX0phktrTG+cWHW5OPR1vG3ud
         meNim2FtxRSJBaxnlaFr2wy8OZ8pV1LSZkz3v8R3Cafs4/5JdtIVQSPGZCdNuL88tmU1
         omWQkVJHNsUS2zNPstosDXNvW6PudyRMJZ0umGiQWUugxxwujeDzLTyAgeZGjinOTsSm
         OOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W265N1/kl4pC3GTUPkETrU5S2zTTXhxD97HiDROTkvk=;
        fh=3jfIJeVFFYQPue4Y+xDFSVRIln6NnwH5Mwm6W8Wncb8=;
        b=i6MFwihkXPh89Js3uT/zTI6ct82k12WyebN/TqjLpHdbEK4Z8SXJgOXzrt95sVFyAh
         i1S3uCVLSPGmBHXOKghdg8IxhRV/EhtItsCkXXwFRVZZGomnr1IRtntVeCzH0Tz8aH66
         y41oahjFSqjipx2o+E+okAivD7bOJ+gSI5niQ7IVJV8AaWnnsYyMn/yWhB1CfjmH9b20
         BNiF0h5HsxHVP/pST8ir9G7ve2FSFkuZV8LFKYcxr3yCxyIPG8tK3IhVKA5/QAoplW2U
         P3BGFoKOT9mPHDjHtRT9c32oddZWgNcL2dsUSIpDqSddGIVDNqkrhin9CcTad+UlnNv5
         Gdfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770003876; x=1770608676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W265N1/kl4pC3GTUPkETrU5S2zTTXhxD97HiDROTkvk=;
        b=DpwwNWVDABUSW8E5nMQp5HPvzK8oet2rVgB5+DU32K82o0+UqPaJcj2+2ss5Rcrrnu
         yQD3NSr4MKAi5bLGiuL1AhcJ23ezV/D6ZNzEJv7y8j0pocvG/bIiICOQTvkYTUcPB5WD
         Ohc7QAGgvg7gChK6SH/2F4NhJenq01IWoJjIgGisIl4s9E+WDAbFg6VQBggA7p+ZM0iw
         fcxPRo9b/aZTISZU29lwQ3YAoRjy623tTHUSgfGkIkokood8ccM3JX43nrhqonm1Vr1c
         ED9bNBrhgmcr3FbHMA03CRrbYWN/EBvywpNFsCHA5QOUgJeNGvurWIwn8NaT7Gf+cFJz
         uEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770003876; x=1770608676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W265N1/kl4pC3GTUPkETrU5S2zTTXhxD97HiDROTkvk=;
        b=e0yf01EzW0ZXO7EmHK4RFgfvrIlWci8fpdjJ9+un/EMJKIlkWD0cSlbq3jW+5vYDsv
         RTKodFVVow4fcrG+Rszf7ndq+biTUsHqRpLKHPRtmNH/FzXErNGVUgDzyAygVcIcTf5O
         OQbVdovkaf+ZukWZgHwgMMqRp1Qe4fxJ1BiN/9//OSOgbXHEVhSsrSB38iP/0y5UOEJP
         LSVnrP0nlzg9z7JDUey2YIQbF/tJmakALxA5lcR56XQuaGhlxf0Qlfy3p0w21AE6BTif
         ayNs1uxT1aGFvx8E6Vo5GquhZ1o0iOpFNSNgjZYsLlg0LMGD81Qp1QTQR0J+WIYbJWSC
         APcg==
X-Gm-Message-State: AOJu0YyibzzCqI4cQjlo6UwR6foGHJfyjVzlar51KHFE+2/7LC27ISHH
	RMD00nxWpOz6B1NtiK4MdMd4SWwE6w9JBrOcZrBzo963fr5nR8HicfI1riYFpBF44tIMjgoehWS
	Jv+r43EmN89bWuJasK+AqngISHJiDY5EFxDzR
X-Gm-Gg: AZuq6aKRMiSVJjAjH0VLIzDtNIjb+6hiWbOeILnyWIzNTfSQ+0DzLLWVkb26NjR7DlC
	REZEmjhDfAqlh+F6lOr1P/oKMgOSLNkCpJGNHIzOfNhWozDPpEhHnZvloVEKfLiAgkY9fsu1Z/g
	FO3r0ptPN0IHDEZiGaSqFBEtZRqazyeaKGpDLLzktNnTfGi9vmdftGrqNWh3ilnzf000EZnTHXW
	DPSK4WSO+czL3fjE4GWIysx1yk3N3PgxhOtBCSQwcdunDxFf55YPyfGX9DpdbiJp8lDr4celJaR
	s5v3jV6no1ZWWiwhLiy/ozby/oUlHKh7YValUtdV2B4SBOUv20rRUEjlRiT2UA7C+Idxy0yDBj5
	u4ZBEHv7IyMddEw==
X-Received: by 2002:adf:e512:0:b0:436:141:82ee with SMTP id
 ffacd0b85a97d-4360141848dmr4817050f8f.22.1770003875834; Sun, 01 Feb 2026
 19:44:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6994ef9c.6e012.19c1c49afdf.Coremail.kaiyanm@hust.edu.cn>
In-Reply-To: <6994ef9c.6e012.19c1c49afdf.Coremail.kaiyanm@hust.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 1 Feb 2026 19:44:24 -0800
X-Gm-Features: AZwV_Qj6O9PhjFXu5G98fPtme7SmR_2A8CrzyzAxwvt68OXh-Wmbvd-cjAQbljg
Message-ID: <CAADnVQ+bYL6knUSTMqQQ8vnbEVdLryEhgUPwJtZwtkdVE5zFGg@mail.gmail.com>
Subject: Re: BPF: general protection fault in xsk_map_update_elem
To: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>
Cc: bpf <bpf@vger.kernel.org>, hust-os-kernel-patches@googlegroups.com, 
	Yinhao Hu <dddddd@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 1, 2026 at 6:59=E2=80=AFPM =E6=A2=85=E5=BC=80=E5=BD=A6 <kaiyanm=
@hust.edu.cn> wrote:
>
> Our fuzzer discovered a gpf vulnerability in the BPF subsystem. The crash=
 can be trigger on bpf-next(93ce3bee311d6f885bffb4a83843bddbe6b126be).

...

> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc0000000002: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 0 UID: 0 PID: 13844 Comm: syz.6.334 Not tainted 6.18.0-rc4-g93ce3bee=
311d #3 PREEMPT(full)

Same bogus report. Not worth anyone's time.
