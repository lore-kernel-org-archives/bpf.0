Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793799787;
	b=XmQ8JWbQszvEmegEePWYkdrkRTd6GsY1bCkC6re7V53NCMboNUO7KeJP5mpk286saQUt
	 REkaesLtlKBqUxB8drB9f7OAISyfE/+4XzOls/s7nmOr+0Hvx3Lz9yDRPb9Q1I8VcPuqf
	 mHh5nOCAccYfs7qXMi4VjxrATT+0rwS9j929hqai6t5Qjb/7Ju1XvQEjpGvR2h5C5T3xY
	 thq7FXEhVml3VWZTGS79Pgzl75nw4z/+9iR4CXexaFV6hffAXyXnUKAfr6UgWzyvdjMrP
	 6kxe3M/elu+V6UaM2AifRf5JXaEgSpQpFEMtg/nBlmtXl8v7nO8GfS7vHqlO7DfUpkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793799787;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=JLATmvImDg/5VrDBag7NLO/Ra27QQfElNkmu7cHAdiY=;
	b=l0j8HKFuUYusSobROHIUV+SL1NsjPrwAS5KrHPpA9pHtvVdnIQMGdXqoKipNbCK69+qI
	 7kZcrJUMQhrstlMlq5Bcnosl3jURGr6/r/1wwVnsNdbjkXb5HD92xsKenXCK720Q6C6FP
	 VJEnb7e0RcqzW79frUAO78I0ss2HZKZ8ZMLuAz3gLrGKMeyTWUvsoG6ANKojpBKYl7+/V
	 UBUB3CbWbXfx9Vev7QltspzceeTsmLzuAzI2xvJQitnf6UnngBAympk5NNhajbkx5zUKg
	 DkdQiyJygWQKSWorlxUoQcBxmU1ZLhLFYAwXFmrpLQa/a/rHiUUf8pzI3nQfeDXH8qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=apDpBAmV;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Mouu1XSq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89816606A331
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 13:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89816606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=apDpBAmV;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Mouu1XSq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793799780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLATmvImDg/5VrDBag7NLO/Ra27QQfElNkmu7cHAdiY=;
	b=apDpBAmVyHsE8c3Flsxy9Ca82GUT6I+55gzpzWCTdUXVsJI9n3ccEwuf4/Obnn4yWBkAem
	HqBD5dLRmJdJxj8R2GQC20jDlFRwYnvfSKyGcVECq60ENLzqVljorLRXl3T1yOpIX/xvrC
	d+bSQqkg0EFxXymI/5arWzTYgt9yAJo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-b6IfKOsFP-qAz3HHdDuYqg-1; Wed, 04 Nov 2026 08:42:59 -0500
X-MC-Unique: b6IfKOsFP-qAz3HHdDuYqg-1
X-Mimecast-MFC-AGG-ID: b6IfKOsFP-qAz3HHdDuYqg_1793799778
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c40285df2a0so64574366b.2
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 05:42:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793799778; cv=none;
        d=google.com; s=arc-20260327;
        b=RmUHclAgNVS+k7bzLBHnCR+14haksmavDPZHB0crDxy6j5yZeTdXq58+sTn8HuAgMY
         01Og3SP+Kj3kHHPf5eCNqulJgO1jMivLMH0WPJuaYbhmU7qWhvzkYUzStvLlSVYN9DcA
         wJzLUcA0Pn3DMJjYVQyExI72gVz8+Hsg7sWndX77Rweka03IpIN5mmknJML7ir49trDC
         Gu6BescQlJP6sImdPd9IwDvJhf92tlIPXxEfgRxbzlAZlctZgdAUVHniWt6TiIyUBkuO
         ZgxrmhK7r5dnD7PJig4BgmkRvDpxNz7lAwRb62I+WUszFNOOkWWn4OTrdF+9NQmKhcVL
         eoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JLATmvImDg/5VrDBag7NLO/Ra27QQfElNkmu7cHAdiY=;
        fh=rQePKtpzYEUNxtCiGaM8J/iyVW+kZycMyVmABVNaWv4=;
        b=JBST3mSVGgEBFfsXczp2pzVGL3JEgniCSF1OHTdg2Psbq7Ve5HqJkHPSc9dESMYw9U
         oAfROHYHENjENRek7cnmQhxMTgAocYbNNqbGIFIURTXnS0to4h1ODU1u9rYFLdhGKUos
         Lfp57MrwjfYDUNu88x9TxN/gCkaLzHCr73k7PPMbjzvshSjbsT2vmAm/HbBQfmjfDBlg
         B8FqCPsP+bA9nObNhH+AERd5r6xg2uy5v10BJjxLhNdjPXaFmeFSFVkZ6DYhwFQ4wecr
         otz84ttV4kCnZBucTnYd3rTnW2IUlX6rQmbgL6JfLRQzhuQJ712GkyV1297L8d0q8G9Q
         W1KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793799778; x=1794404578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLATmvImDg/5VrDBag7NLO/Ra27QQfElNkmu7cHAdiY=;
        b=Mouu1XSquusTnpfBvStFzeTN87Vx2zKs0FoEY5SevuYiOSnWt13aiH+f4QP1nefFjN
         bwfvfwVDenTxSc8Ohnkem1H17b4LundNCijbYaIAUcQNAY3l9xb5ksqEC4f6Z0cL5fRA
         xNQeCDtNJvCH87SLQgARz7InVVv6L0tlELNSUxXik0wyk4894QFXRxG6ccRAtEW0LHKe
         THJnGdreJEIFTFpGet+lyfmvPE85xw5pgU74TXo42+1aVRehgiL3n4FUvqXowAs6156M
         o0mbE4QPzv8Fl1z8PH+X5bYTvPRcqdU8Fdi8z+HRncDyBsgEgiGZAnMawcFzMWiu0GGR
         D9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793799778; x=1794404578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLATmvImDg/5VrDBag7NLO/Ra27QQfElNkmu7cHAdiY=;
        b=1X8whaCOM4TAjhb32grloE1BZjxoyHE7c48vUHM58gda4SZfcifUe8DVAcUK7h66UR
         JyDI7NY+86UwlGq7ItTznE1kGoz9ioPvkPM6azuQ+iQCLJt6TcMl9dEWs5GfzhCY6WWF
         cQorFP7KEUHPCiu1lA8VePg7pkTNlfbX+bkFUmCrVdH1X1NGYYUu//Yaj2bmHk06SKOw
         09kxPX+cpJBnuTtWJobpWOs1qIOuHrFIqmm2LsRfnNJXAJGMqeOa4D1N9NAKxSZcpQlY
         OYcXdS3gakwb4PcfMJfCT6t0oacThPpesnFVGmifSb7fdI8pvfeWh1S7JD5eAMY3sSGu
         3KtQ==
X-Forwarded-Encrypted: i=1; AKwUvBxu+lSEkAFRH38qdzBG5TNKieUM3WEEgiIhuRPK3ykn5eZ1hJVo9Ax/X4jECNZtDVj6sxQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8GDBA9UcVlsvb95KDTMKFPJXLHkPrMPo8B2dBa7EsZh42k8PVV
	Rt2NXABGfVBTVs25X20cRsgaPUGzqhhRNU+w4u65eoZLwl/fkUDtNI+Yzpc9f+OoPaazgj7QXT3
	KcuZ1MwgB1/DTTuoEfwxpa+PCIvQQMm+NshaB9AXQcfI3iFLRAnYrtgtw/sdaghNBrYO391qM10
	uBgJ/V6pbCVIVPSBj96Ubxk81Y2Ij9
X-Gm-Gg: AYBFou2J1dK/7aE/eaalRi93EygS8hCk/kA67FNKhBaFkq88qOdcntx6Pf9LRw2ug7v
	+9JN6GOSYsVY+LiZEa1gC03bI3uwk9gaXqMhT3LJKbCflI1HnVshfTsofFxMp8/ud/2GrA7Tp8I
	f8JqQw3X0byoCuTKcNTy/ItLLnyY5Evf06mfWPcwxAepVUh3f0gd+p6leK4o/vjdQry36v0gDRM
	omDwrCrHFGPpXuEOCD+RGTkx5X+nsB/Uym1EGGrW2cDOA==
X-Received: by 2002:a17:907:1ca4:b0:c24:adf4:5c73 with SMTP id a640c23a62f3a-c4ca795d0cemr1327721066b.1.1793799778110;
        Wed, 04 Nov 2026 05:42:58 -0800 (PST)
X-Received: by 2002:a17:907:1ca4:b0:c24:adf4:5c73 with SMTP id
 a640c23a62f3a-c4ca795d0cemr1327717466b.1.1793799777447; Wed, 04 Nov 2026
 05:42:57 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
 <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
 <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com> <CAHC9VhQ4U-Z2KkGurfMihJgzGgwD3miWSW4wWAjWvUdDxLpH7Q@mail.gmail.com>
In-Reply-To: <CAHC9VhQ4U-Z2KkGurfMihJgzGgwD3miWSW4wWAjWvUdDxLpH7Q@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 4 Nov 2026 10:42:46 -0300
X-Gm-Features: AclHuK9fArBl2NqgMDWGc__kMOSMhBxMeP1FQYdilvQJHUxXbryD-TLWb0XsxW4
Message-ID: <CAABTaaAYn1oBwHSkoGm0a98c9YUZKf6ie=yUOtR4FQuSjrusjg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
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

On Tue, Nov 3, 2026 at 9:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Oct 23, 2026 at 8:45=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> > On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@red=
hat.com> wrote:
> > > > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina=
@redhat.com> wrote:
> > >
> > > ...
> > >
> > > > > * As pointed out by Sashiko, when you were converting all of the
> > > > > arches, it looks like you missed alpha.  I took a quick look and =
it
> > > > > appears that it should be a pretty straightforward conversion lik=
e
> > > > > most of the others.
> > > >
> > > > I've actually dropped the alpha patch as per Magnus's request [1].
> > > >
> > > > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_p=
hdBKy4BLWOvDTt92t5Eg@mail.gmail.com/
> > >
> > > The problem is that as things stand, this patchset breaks the build o=
n
> > > Alpha.  Perhaps this gets resolved during the current merge window,
> > > but as you know we can't break the kernel build ...
> > >
> > > https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel=
.com
> >
> > Of course, you're absolutely right that we can't break the build. I
> > was afraid that this dependency might cause trouble.
> >
> > I noticed Magnus posted a pull request a few days ago containing the
> > "alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
> > resolved during the current merge window.
>
> ... and it has, or at least it appears to me to be resolved.  I
> rebased the audit/dev-staging branch against v7.4-rc1 and Alpha does
> indeed appear to be using the generic syscall entry/exit code in v7.4.
> I think we should be all set here wrt Alpha, thanks.

I'm happy to hear it.

>
> > For future reference, what's the best way to handle dependencies on
> > other subsystem changes like this?
>
> Generally speaking communication and coordination :)  Talk with the
> subsystem devs/maintainers to understand what they are doing, let them
> know what you want to do, and find the best way to order things so
> that it all lands in Linus' tree without making a mess.  In this
> particular case, with the syscall arg audit patchset not being ready
> (missing maintainer ACKs) and the Alpha changes going into v7.4 it
> turns out to be quite easy, which is an important lesson: sometimes it
> is better to defer a new feature for a release just to ease the
> coordination burden, enable better testing, etc.
>
> --
> paul-moore.com
>

Thanks, Paul!

