Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.215.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792514337;
	b=0VggeMd5uBlc8b2tkAT1V7qY3fiaLpf7qH/CoAgftCPoA62ALOybQCQm7HSrlHtrbe3F
	 PWs/2kLiXeYt8nbPazxpZgumtQ4VY9gZuzCXBk9zkuXDNH/P/RsqO4PESjbqRhSgUN9u0
	 Vdrf8npE0dY9WO/nBgPtf/zug9Ak+9R3GMFE51vNEpgZ0UkBe26DRw9eio72dODqwKyZK
	 /FsszbVL4ePqxH7kxrOK2RziC0BLfyjG2SAFiE/IdPluywKirlsOum2ngU/CXskUJ65dG
	 hkLXrsmnG0gRv2SiCQNlqYDj47nyIj6qKz4bdSBEE7m8pPksxb2NwAfDeUx0zYGjCvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
	b=BAJ704LRvQsT+VQyMFX2i1JVwREVI4SUOJptI3vznOT1APRqAVpdGiL9lO4i3STWYttr
	 9lhCq3TBpfEy5rrIVu2HHAf7pvLZwg4F4GNKA69sGXOJudFOaKrQB+LPOm5sDVwQjgcBU
	 xeOf3k3CB+N99tT5H0x3ZbzX23c2rf3WIA6SbOaZR4bLE7dgOfmpVBhm1f0l6z20aOFfG
	 KNq11KTt8ZyevW1K+sUkpmjXcznMJO9MWe9YssiV8s8Igv4WXLHRj2FGyr1IqY159vCWd
	 2quxV1510BAVVzLjIX03/vYvjrPKlBVOIfxCb6UH5bb86ikdQpSarhauqU5aSjpNG+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GwYGVURA;
	arc=fail smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274B60A2604
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F274B60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GwYGVURA
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so1265261a12.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 09:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792514336; cv=none;
        d=google.com; s=arc-20260327;
        b=CxWVwISevFLhQYOXb9pkE2Y+GmA4XtaZvACWqPHvAHjgWBTFPxJOvHPpuIuPiErNU8
         iQo4wbnNWJ1A77BkCd/gJgACT83ozft0coyzMUXKAlhmGhGpRYxEvaOfE69//lZ2Kl7Q
         8VEgzxK56GV0A9Fg9eyEhN5UcrV8rpKKOUBVHFjBrp4wWq8wOsa4O2U8KBj5+jcfPVFe
         cn8Ud7sDU5EI68njf138jDiTx5weUXzxRyVgvoul5d+1kd6ebe/KAwee7Y4PQGt5XaQe
         ykM53EOEN66w9WsE46it52+dt7ng4gfyDKEHB+C6rkWziFnGuwDaObp/NI95WoypPAQB
         oLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        fh=KBen45nMuZTPRsibGJjAGJcdglxPjrIOrLKDCJUaEzk=;
        b=R/XjBxyWyX7JF50yNu9R0YyGMSvbUSazTB9ZJwEMJr7AZ+hFVadiOZ3ejD2vbgH7M2
         UwvIT7PR8a2jghDRcf707WdXqNg7Y2M40CMV4Odzd1XjPCWAHSQVLvVTWn6gXm4qkz0z
         JL/X/WjsKyZm3u7AlzuktNVtChuCw/wbGX4bBqX5LK6Vdc314XRVUoXE3+l0SZ4lYWZ5
         i0mhT5Zt4/9OF/m2BKZgVfmPxBO/lxHBzNl7ADH5D4N1fEjPsWi3UHLflGuxtzW0i/FO
         TGroM/RHUBJmYRDYKVKh1mT0NKWD6mjCJKCRQx5jNrjTRxJ6Nd0mzvsonm9OP/WUAeqa
         Gj9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792514336; x=1793119136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=GwYGVURAL7E3Gqp1mE6IbppA5fK/M6QVj3T4+Mu1VqNJAQWSHTCgIBs7lXAHx7VP4b
         X7Ol6JtjEVwHUVW/UUWijctAKk0S3FIF6sAkL2D0z4+yun1CiPIG05jQakKiuYArY+di
         qKUZ2JssWHS9PY4Rrbam2j+K8HSVipMYAjJhVwlz0qlw5vC30c9m2oPlM5nOac4bwKsb
         0iIOeo41vgbotndmbkqO3IW2nEL8EcaGXBwYuALkuaiWKHExqpmpd78k/kVF659++rVb
         16kcHMvBo17gh+L06xflahlYQXJ+NMSTGDwKIeHcy9Z1IKqewLhKEpxT50Ywi1EBHbtT
         Ya6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514336; x=1793119136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=eQeF9MqqodYTerXpB3HS7CFVv/0ezfLxxTzQ94zTE4VVIqHKplngvT4viJA+m3YBAS
         fX+IwrbeUhF3c+oaqlc5NAqS29KbV3DXknxsIibmDb8nu8DVh4LaX9/Poj52cKfBeLGl
         pCM+vyrQj+exH2cQewN/IkAl7R+zELDHUN7k5q1H/psYesD+mI2vLW9Wqe+uwAwKF3tG
         xPY7bL6JnI6FOw+7eQBW9pSReOBzCcsd7r2NWJ8uouXziJenGaIs5dvsTyCMSIk3LZVp
         hs+taPmahdHiqQEZE/SXA8PAfrlDdBKUk7VufRYquPZBT/1ijjkCc/40t24NNyUjyShp
         O+LQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoV3RWCl81aBJbiNk/ENKq1g2hMApIlGV7ppQbuL0bTITGG44GZv8TUgyRim1FeNKvvmQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiysHQ1Vg3ue+020IVFaKAXLHg7htZGMIxtgfzvjDz1m5nuB2C
	nwU0RUqkH47HCiZcLL15ArlbhNst32hTiMEFVooBz2CYBOJM6ePeM+BJ5D43K8+RLfvGaiYmazr
	1dz12OfyKbwoRZvGLhiPSomrZ2zxSJ8oBl0peufpk
X-Gm-Gg: AYBFou2KhtkGcYQqAy9Y71v+GwkdqIqaCPXS0Ez+L8LeggMo5YJ5TQPm8CEGdTcYFaj
	sD4jHVWTtECLhZhowcecuE8wDlZ2eXYoY54/HjYFLwg1iawxRqLzLjV+oYyW1p6nRqFCA9JNUlC
	kcbmearxEiVoQqV2pVX2QiAq+3WMVhEDu9za7oDU9m+usa7WnaXB/yLSa9gq58PQJFMa4rfCx2j
	j0u8i7U4eXjNWlO4IqnpUrYZ6UvrLP+ImeGjyfeqGp+FChELURA29tNSIQkHAgJ41+dxRWg8AD4
	B5ECFeDXV05OkpYXQs3vwYiV/20tO1fGUOIKoakqyrFN1xC8I5/x6zGry9QVkvHmF8DIifIQNri
	quZpXEjWTy78=
X-Received: by 2002:a17:903:1111:b0:2e6:dcce:8227 with SMTP id
 d9443c01a7336-2e9a6c1a30dmr99034965ad.37.1792514336247; Tue, 20 Oct 2026
 09:38:56 -0700 (PDT)
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
In-Reply-To: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Oct 2026 12:38:41 -0400
X-Gm-Features: AclHuK9ZakV6IFm9eD67kaqUic0iU1MgVPLS7VN6RgjPgTRZmZP6_X_XOYOX9ZU
Message-ID: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
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

On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redha=
t.com> wrote:

...

> > * As pointed out by Sashiko, when you were converting all of the
> > arches, it looks like you missed alpha.  I took a quick look and it
> > appears that it should be a pretty straightforward conversion like
> > most of the others.
>
> I've actually dropped the alpha patch as per Magnus's request [1].
>
> [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4=
BLWOvDTt92t5Eg@mail.gmail.com/

The problem is that as things stand, this patchset breaks the build on
Alpha.  Perhaps this gets resolved during the current merge window,
but as you know we can't break the kernel build ...

https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

--=20
paul-moore.com
