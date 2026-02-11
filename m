Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72842C21E6
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845852; cv=pass; b=kIjgTLtHE+/8Vx4XAddn2GHVo9foVT759oUton+MCB4iJnY5iXYaOhbapso9wyl5wphiVtptL2zBQCMTIiDIMYqFW/fA6XsJoujnXmbuXlrI7bxEb1V89uP7C8fuKd5lrvBIJ0a55kTG6tKu4b9dVMEbWLuiq6J/qI5IbNmIiaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845852; c=relaxed/simple;
	bh=h2qQ85Qhh5DSLIQxFM7CACzc94u9Keulho4DB1sISdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6NttnfoYcizusdpl2oAC/4r5pLaXuLQ97BvGOB72ub4dTbkgIOTIWk/Zt9W/b6RkZ0pgO1RQzcUcG+aSdZQ2PKXYNmHVbf38csjarxu7sZYWpb6YChX6+OqLhd0ZTd5eLrBxXBZZaaYCvJxFPdzevfDAhkn/3y5vVK2mDu4Beo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhCtkRfj; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhCtkRfj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43621bf67ceso3654601f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 13:37:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770845849; cv=none;
        d=google.com; s=arc-20240605;
        b=dmBo8OGTnEKqkHpn1r/68VEgrSbk/RfG5rXftjFGO691iNVlqFOiOwmELVzU0kqN+X
         pEQD4iyOU9ss4PAIHigiLrmACKfzmQHZ4HI3gyrKJ3UzPtstk+7mLCZM7xy5vFv/8GXF
         sRJRZxOpO52Ufc5zN2NsODS2vp0m6G5UEdNu4IKbwjy7tkOO+I2BMYHQwqUzZvGYTlrz
         qRf7g7q5OXaPIrtFwsi4kGu2MrGWPfTmtrnysxiv3tkaEzUuRaX0GqAcgDFB0pHVPfN0
         f5+4ScgYs61lyT7nuh500A4eeuKPgauE8wzm2hsGPKLBNzoKhTD1oTv1DWulZr44tTCM
         3VSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZcvUVKCVbxDZJjojOyr5v7ly+tltwCL9TrHLl6XbO8Y=;
        fh=RFQW4dbKCanmYydS1pUVYec9eiXuIiLjqUijElRBXv4=;
        b=PW6Gk4hsBhOqXxS/77IeqDFjeZeuhuHsm6kHSEQi6hCm0LD29BxMd545VI7CsOluSW
         pJkmLOd4oJXxyRdtDBkck0U6nkj+dL+atK+Wt+yiz7AFyXzkVo3poFu7nPyeceNiWV7V
         3tH5QUbhbHE2+mUKBmv8AEcTyft30L+Fdl4i9TwRgIqyeaX5gKMCsweuWP8pdlnNyEEA
         764mq+C59x7vIKAAvFMECxVr6G/+m5+LzvDOBG94lIGTL72sSq4tZE33cSFlo0LRFCQB
         g2yPv7tTh7rh+J5KYi6ndYiKorNw3mvQX82w8TmmU58HLr5z+iD+gcvTo7CN81+zD3UG
         Y8aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770845849; x=1771450649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcvUVKCVbxDZJjojOyr5v7ly+tltwCL9TrHLl6XbO8Y=;
        b=jhCtkRfjkwIRzS5HZ+0hRA1mTxhy18UGpqG4TSCMuWp7GdLVBxzjd0SVpSjOgWaa0k
         oIXAuR3KRY5OjNvt47qOXH5ufMWxYKX+hfvEzLDpJ4qEKrvYeqDc4vrjENx+WCYhGbCF
         rB3sEeQ8EtD3iWfY6exsnSUdDrBZmV77nbLrfDd6jO3Mk7nkPORj+gAYw2JwL+KxPQdH
         Nirtz2bTbS5djTAMADXHmxthU7niwRIEw8jKlSAbXYK8veDp38ADSWrEFfEIC9C/tUKc
         fucuXNoW1Vzm4bQk2t6YNeCGe3UwwjCcU518atE0PPQWKBzYUGC3DshMo5GwaFxxGGyW
         iOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770845849; x=1771450649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZcvUVKCVbxDZJjojOyr5v7ly+tltwCL9TrHLl6XbO8Y=;
        b=r6BfYaW/tU7ArwKZxNlTU5Ie7CwELxwOMjRi4KEYd+6VwZ7DJi8/1LB1DclvNHYWLG
         H/XZCJqSPIrZH8+WBEy3k++EsFDu6sTgtYzBgb9qATYCdqEki5fV1ds24zAvr675S5VG
         LaiZ3uUDzhhFxccroKX3d7WrVS2SPNgAZK7a8AtKPc+KkQN/U+oleKNlWWniJ5Au97nV
         wD1SQfpEE+1EhUGMEtokaA8dtQuIwcResQDNPQimBHSM/EHU0wmcDVC1kBhtl3vxcK4k
         lGLcouyg5b7ad/7l6UEEFVk40xvMvukvRaMDf3aIweFQkDdHfeWfuS9+GD73a0J9UCHb
         rtQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX77LUwdKAt4HGKgNLytvfeidm4HuF8O6ugHq1uB3C8TLgh72AE3jelIc3M6vXVpGxBE+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0IUJVAbKp4XP8mNGhD/mTam7kUkN5s0yN44GSp179UDeQ19Gt
	sGqV43tZsGUThXveWEznU/UCyFlL8lf1emMTEJD0eKE2NPH9m2eiS0jbLSN52djGeLHP6SOy0c4
	jMA5asctluB24wVfgj787Q5xunHI6JwRdE2qJ
X-Gm-Gg: AZuq6aLerFSuN+LhQWzhXjmix0ppeyIRWUYFDxJoUv8/tfSMdFQ96ALxhM4/OzJzJw0
	peTo2BVfwT0IgaAaGIvatMDltMdXbUuhQe+3zTaRVW2YfnrvWFTfemuB7r58/yksUwPVqKc9mWp
	yFh3B6x/miBgzP/zUEEAwhIZKeuHO27PbijiF6JngHydev9Y60cABeOsjzx0eM9eQDMDufW1DXy
	yAs+4RK6ebo4g3telwONGIfIy1Aq3n2jTC9qPBkgHnHn7EdDfM7m88c8zgHbq0cn2W6NHCKUPAD
	NWcQEgHrSnt4x76KIjEzWMp94syCY00qjY4k8mRg5gzVbyNnnTHxixut2OgfVdBkWcs5u2TyWxq
	lOGxScKGhz5/SBWN1ww3So0XYpQ==
X-Received: by 2002:a05:6000:2403:b0:435:b7b9:afe5 with SMTP id
 ffacd0b85a97d-4378aa020bdmr1165584f8f.1.1770845849115; Wed, 11 Feb 2026
 13:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211163927.665785-1-mykyta.yatsenko5@gmail.com>
 <20260211163927.665785-3-mykyta.yatsenko5@gmail.com> <CAEf4BzYZUnansvKncz=8MFYmjdodu2zd0ZPWskkq45otpqv0hw@mail.gmail.com>
In-Reply-To: <CAEf4BzYZUnansvKncz=8MFYmjdodu2zd0ZPWskkq45otpqv0hw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 13:37:18 -0800
X-Gm-Features: AZwV_QhU0Q4abFuUmuhaY6Ef7Dy8nfoYUbtCXmbBc5IAnKiqTOE73IjiR8_Fn6c
Message-ID: <CAADnVQ+6-82Pe9Q9zLAq2rbNFrVVp=zBRCKHErWVjXduVnt0wQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Use kmalloc_nolock for
 bpf_task_work_ctx allocation
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 1:28=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 11, 2026 at 8:40=E2=80=AFAM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
> >
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Replace bpf_mem_alloc/bpf_mem_free with kmalloc_nolock/kfree_nolock for
> > allocating and freeing bpf_task_work_ctx. Now that kmalloc can be used
> > from NMI context, it is the right generic mechanism for memory allocati=
on
> > in BPF kfuncs, even in restricted contexts like tracing programs.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
> >  kernel/bpf/helpers.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
>
> LGTM
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> BTW, file dynptr is also still using bpf_mem_free, consider changing
> that to kmallock_nolock as a follow up as well, please (and I guess in
> general we should do an audit pass on what are the other bpf_mem_alloc
> places that should be converted, but Alexei is a more authoritative on
> what are the remaining constraints that would prevent some
> functionality to be switched to kmallock_nolock).

After reading 2nd patch I realized what 1st one is for.
Let's first wait for sheaves and Harry's follow up to land:
https://lore.kernel.org/all/20260206093410.160622-1-harry.yoo@oracle.com/

then we don't need patches 1 and 2 and can just use
kmalloc_nolock() to allocate task_work_ctx
and kfree_rcu() to free it with defer to irq_work when irqs disabled.
kfree_rcu_nolock() will hopefully be introduced in 7.1
then we can clean it up even further.
