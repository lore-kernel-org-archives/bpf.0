Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9013AEF21
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697379; cv=none; b=Xx65yEiqml0nEfjJNQBeWe/C1XWrxBfPxWVk78SokHW5HQU/M7QKTj52JEYtFFbm8mELy/uJQCY5swOLocSrM8r4iNPvUQpFqHOvC723ef13uwnFGItM1CnNnQJZ2zli9iGg4W0VEnQz89Lk+Ps2mNwcm3/ux/3g8TEgOWvZRhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697379; c=relaxed/simple;
	bh=EGzWceiAVeeSBnRWldnrtoBTzG8f5fZR6iZziGoTu4A=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=WpcF6CC6ETF2O9cdv2DyNOtefGf41TCL/gw74M2AksfdNmibMb9SOuJTl2dJ6z9bMAPJ8GnoLJqsD5vD/BAOp6VoKBFG5JcKOiDeZbWAGerNs4V3se6tgG9wfCGYjiDwR5EWsny21FkJ7WQ0vXt/bkFoJCn6MxHHpuVtewm44f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ynx7Z4Lj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ynx7Z4Lj"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso93077236d6.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697376; x=1779302176; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lovk2GB7TQrI5ucvuQmmBzaE8ASoKYdV2IJHUjIv4o=;
        b=Ynx7Z4Ljie1JEomghn7GlULS7IhGgd2OagVENW1wPLCvZRScYzUpNdeVLtI24noRpc
         WNIj+KqksgMw40fBxE6gveV8VEplGokq04TM1GTe9/7whTW+hB7R/M1FEcy46QJ1nIUh
         7ac2mnOYCxaG1x6/okZLQ8zAoySoCBIkRnRw0efKl3ZevCt6uU1U0impaQkdQ9nXO/3c
         Oxm+hWns60n8b95RQrnkijukTwnCiTdfkrJSboyzP6VrCr8kmb6L1sFwrQSAD1GsN6PI
         xkZ4g11sk2AwYC8Nrbi+mp7aTaC2WnA7KeFNhXVKaU/I13NZj0gK5IIKTSPCTfvNlOKh
         rxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697376; x=1779302176;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lovk2GB7TQrI5ucvuQmmBzaE8ASoKYdV2IJHUjIv4o=;
        b=GclmQZB0qn0OAKpoyJ2XKdkFxK+hhgd2fCJUVWhrfwOOFXtulnWxPm6PNduCPIR3Hf
         pv3TPQ3W6FF2SXGE4hMme9CNzfCgdvvPG1cIHh2rigKHP7wpcJuHTwEp9BzAS2qN0b/2
         PbkBg2oQyeo/kmrkriLy1QgoEYnARXyy+8XJmKQENBp6BwU7MmgDhbLcsaHtEmoLRNPl
         w8FfgayZxoSRiWCC9xhppJlzvyJoX83a6G+Y4bUTN81PGi1iLdmFyIYSP0ldBu513/27
         edsmRTDM1giMhJkZSbpV5hIwOciDVZr4Kz8PQyziMVW91/s8yd5BendJgmFepDxz9Ape
         X3TA==
X-Forwarded-Encrypted: i=1; AFNElJ+cToMVIVZbVmLrM8TrrRjDbmjCe+3HcGJUfdGDrq1dftlEYpAjXVFhTC2rSqCAKeVglRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywdw+fI+ud3wSM/a7b6SIDsV7ad6ZTlm2aA/KyXDu7jhXcdNq+
	OVlPnPmC3mPIaiuZiuhE12jwJgCPFOs3vlwU1uwhgFZ+bICX5kXAcpCoK6vOMGQbmw==
X-Gm-Gg: Acq92OFnYzv8CxrAyc3TWITGz/aMA0+kCg8ZHcQZZg1Gc//CrpRZEv2N899MAjKnszy
	rqqrNYNl9VVKnKP/tq+zmJ/YJMavYS29UbBZReCIU/6NTbUJA7hf7tZnfWRsffYy36GSz/JyJSX
	+yRjanwfY3whKC0tdn0DWvmZ2pgMnStjAG8/ke5nVKiUruP7tqTaq+pxadfHrxAM7YMlbr9YG4D
	LIHGTw6KQVfmwvrJl+1I5RMXfDcSEPmLoOQFf40QqrCMSMUtXw+UnDNfn1t50gwnZrdnckMCPdZ
	R+v3ZR0TVh+ojJIemRltXVuoxzBXZA+nVzPK/6KSt/RSIG4DwMfJng51OptP5+FvjMPPKcNDOb6
	JTbx4oxS8uNMr3En6WOOMawEtH8c7PAxWC1AsJoeY7KS/cKqKEY9aezKe11Zis7OyKIVm7LEhik
	tab87YW+mHQq3rDei56VxdZRsvsZqljZhSSUkCJiuV0z4alWsSPEGOvs3wQ/gOYjoM8+Nn
X-Received: by 2002:a05:6214:469d:b0:89c:cacd:244a with SMTP id 6a1803df08f44-8c7b9e6573bmr74418346d6.5.1778697376105;
        Wed, 13 May 2026 11:36:16 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bb8241dsm2941076d6.34.2026.05.13.11.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:14 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:13 -0400
Message-ID: <426bd02f7870a8af23035d506a50de78@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 6/10] security: Hornet LSM
References: <20260507191416.2984054-7-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-7-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This adds the Hornet Linux Security Module which provides enhanced
> signature verification and data validation for eBPF programs. This
> allows users to continue to maintain an invariant that all code
> running inside of the kernel has actually been signed and verified, by
> the kernel.
> 
> This effort builds upon the currently excepted upstream solution. It
> further hardens it by providing deterministic, in-kernel checking of
> map hashes to solidify auditing along with preventing TOCTOU attacks
> against lskel map hashes.
> 
> Target map hashes are passed in via PKCS#7 signed attributes. Hornet
> determines the extent which the eBFP program is signed and defers to
> other LSMs for policy decisions.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Nacked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> ---
>  Documentation/admin-guide/LSM/Hornet.rst | 323 +++++++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst  |   1 +
>  MAINTAINERS                              |   9 +
>  include/linux/oid_registry.h             |   3 +
>  include/uapi/linux/lsm.h                 |   1 +
>  security/Kconfig                         |   3 +-
>  security/Makefile                        |   1 +
>  security/hornet/Kconfig                  |  13 +
>  security/hornet/Makefile                 |   7 +
>  security/hornet/hornet.asn1              |  12 +
>  security/hornet/hornet_lsm.c             | 352 +++++++++++++++++++++++
>  11 files changed, 724 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/LSM/Hornet.rst
>  create mode 100644 security/hornet/Kconfig
>  create mode 100644 security/hornet/Makefile
>  create mode 100644 security/hornet/hornet.asn1
>  create mode 100644 security/hornet/hornet_lsm.c

Merged into lsm/dev, thanks.

--
paul-moore.com
