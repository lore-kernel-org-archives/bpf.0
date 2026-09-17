Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B74F4D1D
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663590; cv=pass; b=nbLtUurG2XZgqSzLxO0TKCrLJ4p5V9Z/tytRPKlJS++mKszVtnFefVg5dc3NdXcx4u6hcGXDfoMuhmE8zi1f1C8WqAliJYoGeNBNBIKgQqX6ccW6AWr7ZQ5YKoiCVISffim4uQTlPXiPd8tWpyLd9CEw41MFhRiuB/O/Ubluvbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663590; c=relaxed/simple;
	bh=eYYWM3K0Z9Uro9HwA9hQ8je2naly/JqA+zNhzp9DrpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+cL+CICA3AmXSvE3agky4ksgUlvjSSUL7qs3QaX9Ncrm1rpgMv6wyaqzlMxspWYl5XiW+rkrU0FB4FURGPQ0NI7Yy6Xohs+CPthYhUNsl1iIgHpa0PhNkNjDI8r/QCgwa6YfS5d1CUsjsUEe/XlCsc5BF/S0kSVtCIVFb0jpoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTTX6g4m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H200DWtJ; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTTX6g4m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H200DWtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
	b=ZTTX6g4mYj0vlRM1lqShOllZvQyzIx2owUz//QT3uX3LDPwvQ13gLfFul3EjOEEnhQRL8+
	IgQ/7XdL20/z2P4kFnyzkp7ERWfZuLKKKkUCSaqJIXTrE/hkbCg/FbDPz+nqS3uMZjRKFl
	rRIN2A0cBVjwRsvMvG/YvP3IE3QaPqs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-TYNd-fKsMzu1PBUOqEy1yg-1; Thu, 17 Sep 2026 12:46:26 -0400
X-MC-Unique: TYNd-fKsMzu1PBUOqEy1yg-1
X-Mimecast-MFC-AGG-ID: TYNd-fKsMzu1PBUOqEy1yg_1789663585
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c294ae16988so134589066b.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:46:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789663585; cv=none;
        d=google.com; s=arc-20260327;
        b=jpQwbMMZYeZsQgtCTNDo3Ld9yaloTpz1GuBi8uBVP4RcVZY/HjjzLKqeQ9r3ovMdBQ
         OzfiKdOd4FJHgIbByEImobTlhOaiSn+73oEYwDrNQctnX9WKePnmqi0na2tSknW69T5Y
         u+3R5HAKNWpfTfXzCm2SgSHCyo85dVX9OJ9nis/oLU6kGMJXU2QZ5Eq+03/i9IlR1E7r
         67aEaSg+gqE6MKJx1vat2I1VZymvOdB8RAx7EJe9on2et8xL/q24Xnd8MW+LOfwe/yA/
         AzO5O6E9xVTJ58OCsGQHuPBCVfA3AnLiOcrOJFDmUALMa9oKdPclQdoYhgkvTjYdIgtT
         l6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
        fh=gZLaWfMytRL/CsT76P1BNb7gj7/B9Omtbpw6AliAkQQ=;
        b=hF7kJMXUBrWMINT1JVwEUc+tsUkwBiRsQxUc8JiL+BAH5kpvwfEQtmiugPVysHG04+
         QhJpSFLkS6NrlnOP0ZiaXtiLV05pj+zlr3ml22lxwzp4AwnphivRFH1Knv69Y0CdkKw6
         9JVLcZvuWRF1lYAfGCcvb1QwDnvV+dyQ+HXrQ9wr3YYBkXFmY8pxRYmUNgsHtKPzMF5D
         6vuazxYg9muJt/ZyKfN0L+a7i0fdOv8dq/wg2xVExk6JOdeCK1BMJD1XwExdnb67+A1s
         dasVUI1yo7wKZvi1Kv5hD2gmoM1r8okV6snVloueMgPlTJTNfVwgqYIjLZZ0rfITc8VV
         rVKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789663585; x=1790268385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
        b=H200DWtJICF9QH6JHKN/nmm5tV86eiUouPYi7aafDRycxl6U169OnOUHb3rKCENsez
         +0RXYTDalsgbqK5ghOadRO1Q8ILIs3srTU1f8QjOTFAsX6a0xyq2jTukvLaLDFgK2T3X
         nqWiLKjVhJUi1FY9XS2W+MFSI/Yfh90CWlNqT5+QBG5KUeK+wYo2J2lpSvjs9TNMBe+y
         xQ+ptvfiXIvmOWzzcDpd4BoaAXwTWRZRRuQ6ZGdvEVm7fpOJRHQ6Y+CSZnj1bU6AMMRf
         3uQUC6XuxCuwpCc07yBmfv3xF+IN8gmARl5UVfqxlHr6om+vwq01CYDReMmqjLfntZU/
         SgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663585; x=1790268385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
        b=fOFtTvujhz27zb37KeDHu6s+z1YOsal1exQFFWct28zA/LGOHMRdgB+LqtXATiFxSn
         WIjtE91jEQ11yKFYiHVtwudlPJmEeJ5a1vE97rGpV6iduBcogUVuRkng5osaJXQBlxxc
         CczWAMsUL802ZipwSZpPKPkoVcGbhK4wUDkRYy7NR8YRg0/TwFierXmzm8BWIRiTPDBd
         TwMFy676qpQmQ5Q21pj492RmEJTCIV48sdqYAmx529fL33qPzBd35iN0nUPnHMM9MHix
         xK9EhMcz80EupIWK+a79g0qtV+3oKUW4b2WG6L1bjIHRpo35GTXMzK/9NYa87eYRXCMX
         y/tw==
X-Forwarded-Encrypted: i=1; AKwUvByQR7NwU7K3LGPYZd1q2yNYJ0RdT2uvGA66jUH4wuJXfTyKqXTf89pAPvE03lbsup2woB0=@vger.kernel.org
X-Gm-Message-State: AFuF++mFki7b/4oKT2hULy5bFaB/h8R1V3GAUcXZqPrSjjwL1B1a9Ilt
	U203GcJNlEgXgSn1tiqIKM/O1JnHxAw1d6OIHTvLq06dIJDazCCssRRRK4+dyHqPp2ER3VfoZlt
	ueMGUV+WrcojEiF7ysHG0vfG0cxacd9OT4whxUFb6lcHCWkSiPbTvt5K2l92OnHsUGFdHEQj4gi
	mRuxddlQG/Ya07otJ91z92kKodsvQw
X-Gm-Gg: AYBFou07x52CVnBBULsr0DL++ugN5LXnkOfNjsJEhpBOH96LrDKF5R0H/T5W59YlC8H
	9f/lgVyu0MXfi/uHUyJ2Oqc7JNkhkWofGdp9HwhW95FS7+xfIk1aWfUv6WIyh99u3ldLnTL9m7b
	f/HY8BbJEPjjJK4kdmOX9lEUQwDbo8M9CBIsez1bPrRjDXAPPYRjMdPxQsCzjNJn/KcypGY99bh
	hAK+cfJ1sYLr6muqIY44tooqsJOnJQCen1xUXNaTcBOenN0FNfRWSsklie8tl9C3jNXiEPJ4qCU
	0Z0=
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id a640c23a62f3a-c29e53184f0mr504528066b.42.1789663585515;
        Thu, 17 Sep 2026 09:46:25 -0700 (PDT)
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id
 a640c23a62f3a-c29e53184f0mr504523266b.42.1789663585091; Thu, 17 Sep 2026
 09:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
 <apkuNj1paR_GO3x9@willie-the-truck>
In-Reply-To: <apkuNj1paR_GO3x9@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:46:11 -0300
X-Gm-Features: AcwNN1UTQywdGW9xqj12KwNHAYLGfDNNso402GZvP3WcYYwXGdDJ7Oiz7qML_cg
Message-ID: <CAABTaaCoNztwDUA-HPp4LaikxL4dxk-1bvCCpoZEGD4rnds1oA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] arm64: pass pt_regs to audit_syscall_entry()
To: Will Deacon <will@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, guoren@kernel.org, 
	monstr@monstr.eu, tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:22=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 02, 2026 at 11:43:37AM -0300, Ricardo Robaina wrote:
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/arm64/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index f743cbec1c3a..65532b2a8cd4 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -2476,8 +2476,7 @@ int syscall_trace_enter(struct pt_regs *regs)
> >       if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> >               trace_sys_enter(regs, regs->syscallno);
> >
> > -     audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1]=
,
> > -                         regs->regs[2], regs->regs[3]);
> > +     audit_syscall_entry(regs->syscallno, regs);
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Thanks for doing this.
>
> Will
>

Thanks, Will!

-Ricardo

