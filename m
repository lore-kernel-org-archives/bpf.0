Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053D5208A2
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663665; cv=pass; b=H7LeTq1oUlnTsSsHyC/D0sJ7wFX6NNGKdMm+yXDRlIvgNxN0xCWcc3QDjMrzzdfXUy+YOpu060aGWJ+0IagwRVwywz5IO3E8+dMCPC8Q+dRopCXU3MsOf7H04T7aE6hErO7/CUVkO3H/0LK0mGMtg/exL861h80SwCmvGm0/LcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663665; c=relaxed/simple;
	bh=OXoyJpegabl0ocESy43SWOAVnutZsDrl9ix8aJurgKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lliT5WgNpBM48+Odnzu9aqN0NH7m/5FGGaMQ+mbuAElYpbGAoq+vNUN4o4O7ZmQGxGFfHzL3hD942/SHkFcdvXtR8JpQQo0ejswtd2InLF7xuemRj0i4rgsuDx2/GQih6RBNTIKsNGDDvBRBRRFmghCNvxg5UE02KFgnJKPXa4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eATgGJvg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKGKnJD3; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eATgGJvg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKGKnJD3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
	b=eATgGJvglDB/e/XNDRrzgW5WKOMEpiB7LymnGtDf3t8cuHmDceHF6yh3kS+B4K+hNcO7ms
	+q7mwqmlMk4xTiF2LCi9CdNZxB2HVauHdvJoBImez5qV++TOb0SpSxrRysTv9oeZ9rPF7n
	RqubMsnYYyb9IE5olgw4ULYsdRg071o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-on7xFFcyPoejNFR9Ixdo7Q-1; Thu, 17 Sep 2026 12:47:39 -0400
X-MC-Unique: on7xFFcyPoejNFR9Ixdo7Q-1
X-Mimecast-MFC-AGG-ID: on7xFFcyPoejNFR9Ixdo7Q_1789663658
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c293a65b577so117392566b.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 09:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789663658; cv=none;
        d=google.com; s=arc-20260327;
        b=p2L9ytR8vPU4WkNOBt4YcOkcUDA30bFxmoeQwBpmrYmWzvTB2Za/nDhBNxUoXR845Z
         bZavM1PNR94zu4HO/zBAE2d6AN78qC/Rw4OQzNDsl4X3qjyw6Ddg9iLt+hAUDhfeWF/E
         VO8TZHJi+Korm5T+Nl2/qDDD9g2RBqrnl7lVhCR6aHcD+HWX2Ka4AlUyfP+GgIKjH+PT
         nO8iUKWtgOWHhJXfl23rZUwl0CcuZL8S80zZcbCzgRbN3T4rVEuSx9KJucWZrM3ZMO51
         xQR30eV0zH4BTkD0lFJFtt9JWxqdR/da10lz5NFdN7qy+f5zYb/c49aY8a76qJvcEMOh
         JuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
        fh=DsbJ+Yue8uWmoo4ZUqXVZhNrJQkacek/OAnA4IVx8rI=;
        b=gAvIgDmJfMLaMVv2SVYLChSFDrb/kT1oxBmJ4zWOb38MBB3rI8HEGV9lA+tEDM/Arg
         gfUVL90eKhdx9qh1qm3jmhgDfO5GzJ51dcKiDfA9Qgp1IKGpo38kz3xdt2SLzvcB+VHr
         iTSMglI8/h5OMnAl86imzNvAWnfCpGLXa4pzrR8ledmZ4OZibilWxE1Z7YjfJAB/nHI1
         wGpYgRLTAiH/wEhgRGOsZDge3sGKFPujUnbaxJoAzZyFzjDRUNbQHLPvcxC0fJS9pqp5
         mmaNZp3XxI2Mwf3KJCI9WXH3ciJ4BQ/JmmYJBB3ZWzE6DlTb+UWUKw6wX+KIgkN3Yk36
         wGsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789663658; x=1790268458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
        b=dKGKnJD38WiZGeDo9G7w61tJE8iA6+vSv3+VhV/+0BSAMznrhvPVqnGGKYQ4PLBA6I
         0x6n1uxTHhGhrERHIq4n2fwx7oBAGeJ0UH2xKBLCAHlcgYVJbSGdqkRY1bIrFojj6Vu2
         1xzNeV3ObTyMCYkO5MWwX8CYgFeVi4bWCgXmC4n+onP+bI4+jZOOu0utxMpLFY4bJHAr
         EnjiwLBgjs87fs6PxCZOmw1IRvyMdPyrIn9tJRRP/SWbFlBMtaD4DAF8BTLubz0gyLzg
         wVbhbv7VzQr/+jzG98EbBOOsFR5Vdnw7E8gs5KXES7CruX20+ZZXuAPdluYPVbk+dg7Y
         c55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663658; x=1790268458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
        b=h6y6ewrV6GKmdai6+xlJVkV2L2jXIRaUkF2J09Pe/RaooD36dhxFBam7ErjAAhuO98
         gWWl0X6ci8rGOXRYKllTPHr7EZjjMS1onbKo3Q/ARjl4EHUvCvHj9vA5Hz5lqyJgdWlt
         ETnj3d3VqMCud5CMcIrR920XB8Fh/9/CH5NNDg9ADT2dr0FF/RMYlY0oGloClj0MuF4c
         6xdK8h0q+mtM7W4gfouy1Qkl4rP1ydZlOeuSvPvoq9wSYTDo5ouIvvhN9BqqOxHPjkri
         wesITGjGsMwqLAdJowQPf2cPw+vXGuPo5AiAmETgF9c+lv9ex+uPa0yXFddNe15ujkgv
         bmuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbQv2QFov5GXE/TuM7lwdNR5y/8vIoB7h9BoL9pBKzklRCHZnuqsVgWeTbOJayp8JUp6c=@vger.kernel.org
X-Gm-Message-State: AFuF++k0uu+XZNTBW1BQjQ2xe0ElGxX/I7KTqlf7bMX6n2RqJgCp8Lfu
	oIiJUfF3Co6++1+LrM8kpF82pzjinHN/XONCu1FvAtVC4WfgUvcsHUCAMZdOsbU8dVM0F0EN6YL
	kBz1aObiLAyYuFMmjVX3EQHD79FKN/DbUEOCOhn/Vi2nbkw6mfVMmr9jfFT0WYIVo1vhzUENfv2
	iZI1m4cTbejA4uXL+4TKCvex/havQt
X-Gm-Gg: AYBFou1NbTTe+MR8Jgqy2FnZBeR8N2DNrYkmquIXUNhhPPMSA71gB+7Zs67LP1AmDRR
	KoN8678Qkouhs8XZrsvkvwwVuHtiyHoj18YUOcSm+xxWbzjgl/nln78/huPSxHt+k6w1UvlThNx
	0IbidSVZDWV7PAmW3+iiC6PqwKgrwvaq19If0olMXF9Jr1nrV4OPWBHCgHIsIY6Xv5PoAIsBxs+
	+Q4R7isyl0L0Bw4eBcM658Td02phSjz/LaQ1G/EGPKrmyGSiUKpyJtQu4qHCbVEWBbw6/JO5k5i
	4/w=
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id a640c23a62f3a-c29e5244c19mr627703866b.10.1789663657751;
        Thu, 17 Sep 2026 09:47:37 -0700 (PDT)
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id
 a640c23a62f3a-c29e5244c19mr627698766b.10.1789663657315; Thu, 17 Sep 2026
 09:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
 <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
In-Reply-To: <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:47:26 -0300
X-Gm-Features: AcwNN1UQ-9H3EW5aAPKYI2mYiHxV9kMvBFdM8jP3WAhZbefwH7qcxYHE69PGYDs
Message-ID: <CAABTaaAUBzp1uaLve2piMhEB1R5po5n5+Sy+U0mbbe70Ak-SUw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] alpha: pass pt_regs to audit_syscall_entry()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 2:21=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi Ricardo,
>
> On Wed, Sep 2, 2026 at 4:44=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
> >
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/alpha/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> > index fc8f6cedbb28..8a39c0473297 100644
> > --- a/arch/alpha/kernel/ptrace.c
> > +++ b/arch/alpha/kernel/ptrace.c
> > @@ -496,8 +496,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
> >         }
> >
> >  #ifdef CONFIG_AUDITSYSCALL
> > -       audit_syscall_entry(syscall_get_nr(current, regs),
> > -               regs->r16, regs->r17, regs->r18, regs->r19);
> > +       audit_syscall_entry(syscall_get_nr(current, regs), regs);
> >  #endif
> >         return syscall_get_nr(current, regs);
> >  }
> > --
> > 2.55.0
> >
> This doesn't apply on top of my "alpha: enable GENERIC_ENTRY" series
>
> https://lore.kernel.org/linux-alpha/20260902184058.198679-1-linmag7@gmail=
.com/T/#t
>
> That series moves alpha's syscall entry onto the generic entry
> framework and removes syscall_trace_enter() and its direct
> audit_syscall_entry() call entirely - verified with git am against
> GENERIC_ENTRY applied, it fails at exactly this hunk.
> You don't need a replacement alpha patch, though. Once GENERIC_ENTRY
> lands, alpha's syscall entry goes through
> syscall_enter_from_user_mode_randomize_stack(), which already calls
> syscall_enter_audit() as part of the shared entry helpers
> (include/linux/entry-common.h). I applied patch 1/13 alone on top of
> GENERIC_ENTRY and confirmed alpha's entry path already routes through
> the updated __audit_syscall_entry() - no alpha-specific code needed.
> So for alpha, you can drop this patch in the next revision rather
> than rebase it.
>
> Regards
> Magnus
>

Hi Magnus,

Thanks for reviewing this patch! Ok, I'll drop this patch from the series.

Thanks!
-Ricardo

