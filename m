Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793752864;
	b=xTCEcJGy1ED35R+th9BNYjgDi5bqewIbtYGv/2blJpecfr40fpHmiXpxBUcxz1E/zOlj
	 H9k+BPWgd4nZbvOYXYBBMSsGEcChb1tGOiTMsBsOnocGXHk2BgG6rBUW3UbKp0/xxiv+C
	 Wj5ztJ/oEvhUKiEJzxwhh1Aw3VmdO21RRkH48VQCQ6mTMT3dZhE+ni5FQrDWSWbC7pOYI
	 Y7jKJIXcVh+QSYDb54VYcIkfAuR7YhHZBnv2oG2qxLgDSB+Fi30A4e6RhN6Z97oaJ+g8G
	 w6uvl+nJxUI13nNNiCihcFqU89emgnA1t5iYByOu8OJcAkec6/QJRntqhBHgEpJczxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
	b=xQszPOfn3GxJYS3FhAC/uT1gk6T71DqQc/ZM8q39vHwwVDbA6q6ExfpRARr28EUC6C1Y
	 Ze94ojsjOhJ8zioalemWRhZA8oRpCw8Ueohk1HfMPPKV+VgeY9fi9518eWXaiPgyrjJ4Q
	 YC4VFzQZy8VprTUZyZf4b+lo5lIYnxWPS0HbUEgPZY0ZVjWriHO/YTKBQ7p+aSZRW5PNf
	 4iHTPF96aSVg/jyDevJO3LZ+f/BCE6xtH9CEAi6w29YcLuYdX2FcxvqhbmFNYVNcS/Sdq
	 Vnsco6sIvlIXz+lBUyNhtx2UBgtyoiKQg5hMpiethITm6htjIRMgqaFRTca+4TEQQ5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PTPniKxw;
	arc=fail smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFCA606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFFCA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PTPniKxw
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070781f63so95402b3a.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 16:41:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793752863; cv=none;
        d=google.com; s=arc-20260327;
        b=cd3W/etDX9YamKG77PNhHTMJoNMWEfJPjCHOygIcYxt0roZJSRWzZSPTFKl36C4uzs
         W6XAQlqBB8EJnKaQuBg6X0PzBMOgl5lKlK6dbfln2YSftMWfltdkWYDBlv/va4UnGEJc
         L9Jxfjydm93zZFyuGrw8WkMxrELGGGVwb1iFdAieI0veJtpfOp0PKhAqb3GMZAtrnw99
         6wzn+6GYIit+4jYm7T94tWHDO0gGBHQVrLcPA2bLgrW5YsL2bwprdlUAMXCCCNfJdBkU
         Iubl4U61yzeaTOYIz0YNhq6Yz6wiaR8r25FuImLHuUce+4i5kWqiE21enK50vZ3WZfU/
         TqHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        fh=oB7gkpKXL9HkpBWCNOK/Z/dR9UuHOD3O98RRMA/MXDw=;
        b=R9q6wnPxlK8gjRhfzPZmJ753sSImfN6LoC4ouFdCfB1kOaRuWG2LfpKwmhGIZhQYxs
         IPMsN/yyQs/pPh9f3iLLixiLeCzruL+bOnBYQrroScLM+SBwfpsPBWPMTvYxeFztTLmL
         Z26PUBrB3txqmCEUBy/mpQayzMOSblqqNLiO3unOVpJcPX5NhiblBR71KBkCeiffMD/X
         hYx2/3WNZZc7QD+9Mg9X9UqLW2y+YnEOtfyVUbqqITRygf6Gi2dJ8ddMfc1QDr/OXsjl
         KgsV7WO8nkkz2Rqk4vFgy8G+neXyi0DeLOrXoWwiX6lsk2pplrpAMQ2oJDOKG6sTABXE
         Omqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793752863; x=1794357663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=PTPniKxw8lSLWSxMbmhmXVodXffwfFqC3M3cDEPYPvY1SsBjNOjXXv95CLFg3rVQFu
         x1tdyRAr0bqYQ6HVqsjHpfPPU10/1FhE3kd/CHXKlKRa2s8Jf9/RWGaRvSd9s3tWp3+h
         Tji6Btj/3XlTUrwGPe+aphN7moDM3Ujmyews2MtwEsOdhWo9d1B27IQnIAXxeCj/AgoF
         TwCZd9YYNW98ENSoBC4GvFAhash4XN0WeHulLfX/snYculqtKEVgWcaAWPf68LjYBfvq
         i5NzGzwAog4kKLckyYK3n2IY4tOHLEWiT5cJSG6dbW9SW1FZ4MjXmEMstZ0yw7BaSVW5
         5qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752863; x=1794357663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fPNnZyQIDXSKNoVkiNoUdoJZWsQu0g4dBkxCnrIJvKA=;
        b=cQ+l3HAHVCyaYkjbh2hJsiWlaC89fX140fcMNmp1a0FEDDOb1p1sF+z+EtMY/WiDR9
         JJZkvHx2HbfGRCKCa99cdtcOEDGYCVP6KgzOcc+vokz1TsRQt6TndgXOcbtCW6Z109jw
         CFOVMOIdsyHXGTBuAiABAH+qfGoWznOrxHyjaUYWo7BVrb6BIWcK8932B2jyyBd+CjOU
         /IllBJz8/ckXQeHL3bA+aloj9fbUtK4tEKaZIY1GmhQbFeC3ygrulOgENylfEQZ7fDqD
         EQYEZ668e4zPu/elq0/zsXQD+yVyQr641UbKiQtsqSUuEL7UoPmDS8Tn/NNcTLuZcRCp
         3y4w==
X-Forwarded-Encrypted: i=1; AKwUvBwhAyshgIbeqf7Ykbx+1O7XEJ1jqdvCT9Ot+atHjPCw8mLWPrkmjtL5zjo3ESKsC/kuhGM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HJciSAdyUFeec2pSHXRiT2VOnUIcTDzI1TqkXtOVeE3rMImkA
	rTvW2/JFu2/NdKVHA0gO/04wbbgSTXM2QyNj8EHtm9kM8q+ycsonvaNH52eLGJ55eBw2C3GlP7I
	bER5BBYY6HgZ7+pQuTDJavGUP+YSgJMZXWH2ebG5o
X-Gm-Gg: AYBFou1RUzZDOvVVYcHhm9DmUjCFBojjxXGlFODluQMBe2k9Om7OAdG8Y5uXwgF9PGN
	qs9fH3RWI62+1RTajg3V4B9zKWQjenMrhJybq9H+4d3BYd1L0AvBpmQWAX0ybVZ03k/V4eQzy/O
	2IygG3z5MfwcFo3AK3v2Tza+cxNoZaLVF0dB97edsix9WU4wJJKkCHNGwf/A/ZkQme+du1n1ZsU
	X84ZRvm+y+izec227edXqhuC6vlopEeEk5zZpt44h8+8ijR/nIiOFgw9JA+3S5cMLwicDxAoOqe
	E0I1PczGfGv9yNFdx9Oe3bSvhAhPDILFG6AuEHhkAhzrDosYhVeTsu9HnTSBk4U2twrvXbBwHx9
	DkTDPjCa2uXNBTmJK7IwnACdQ0cCB4/NCUC6+G82kDK9HWjEJ91MLcTLR4kKFHqFlN3Qu
X-Received: by 2002:a05:6a00:2d96:b0:88d:4b30:1c11 with SMTP id
 d2e1a72fcca58-8a9ba703bc9mr11394030b3a.6.1793752863107; Tue, 03 Nov 2026
 16:41:03 -0800 (PST)
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
 <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com> <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
In-Reply-To: <CAABTaaBOrPknzdxc5S6L9hGu7hbFu2e1RZG=Sxjb_B1Cs4Sixw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Nov 2026 19:40:51 -0500
X-Gm-Features: AclHuK_mzIhdjHPxjnkTYRthyfMgrzjS55JZuNf6mZPYYsQQvO81kKGlvJUv8_0
Message-ID: <CAHC9VhQ4U-Z2KkGurfMihJgzGgwD3miWSW4wWAjWvUdDxLpH7Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
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

On Fri, Oct 23, 2026 at 8:45=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Tue, Oct 20, 2026 at 1:39=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redha=
t.com> wrote:
> > > On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@r=
edhat.com> wrote:
> >
> > ...
> >
> > > > * As pointed out by Sashiko, when you were converting all of the
> > > > arches, it looks like you missed alpha.  I took a quick look and it
> > > > appears that it should be a pretty straightforward conversion like
> > > > most of the others.
> > >
> > > I've actually dropped the alpha patch as per Magnus's request [1].
> > >
> > > [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phd=
BKy4BLWOvDTt92t5Eg@mail.gmail.com/
> >
> > The problem is that as things stand, this patchset breaks the build on
> > Alpha.  Perhaps this gets resolved during the current merge window,
> > but as you know we can't break the kernel build ...
> >
> > https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.c=
om
>
> Of course, you're absolutely right that we can't break the build. I
> was afraid that this dependency might cause trouble.
>
> I noticed Magnus posted a pull request a few days ago containing the
> "alpha: enable GENERIC_ENTRY" series [1]. It seems this will get
> resolved during the current merge window.

... and it has, or at least it appears to me to be resolved.  I
rebased the audit/dev-staging branch against v7.4-rc1 and Alpha does
indeed appear to be using the generic syscall entry/exit code in v7.4.
I think we should be all set here wrt Alpha, thanks.

> For future reference, what's the best way to handle dependencies on
> other subsystem changes like this?

Generally speaking communication and coordination :)  Talk with the
subsystem devs/maintainers to understand what they are doing, let them
know what you want to do, and find the best way to order things so
that it all lands in Linus' tree without making a mess.  In this
particular case, with the syscall arg audit patchset not being ready
(missing maintainer ACKs) and the Alpha changes going into v7.4 it
turns out to be quite easy, which is an important lesson: sometimes it
is better to defer a new feature for a release just to ease the
coordination burden, enable better testing, etc.

--=20
paul-moore.com
