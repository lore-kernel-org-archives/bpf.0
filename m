Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC5A3A5449
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436717; cv=pass; b=Ycc0z2581scgwaIrO4p0lzM2ZHDFS3m+SCr330L1j5vNABdT/mDyDh2owXkCO8zqTK6rEe6O+Dd2oGCZY5NPgI9kzUmgrjETIWHRaWfB9/QjSBHYJ9D0hFaPVWyXaMOQEX2ah/BN6qvv6+dCUsAs5ixE1rPTiGNuug2bGaLVxIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436717; c=relaxed/simple;
	bh=KOQdHlqbjdmDreblqF6LDye84bMbw/y63M7JSnQjQwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdVuif+qqL1GCRlXYTginD+g/+I2iMS5oOObZ1qaninLF1VGdtteTLSNlzuwlJWpPfXyYJrUeLDj/9x5cJ4InCTKONe7TQEmliiboPbidfAKSpMKKmq/xUt93DXEWuTfwfYq6D0cXW+tDVAeQqEbxKuU4lq3UqUhTTpLfth0lpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GVaOxf6I; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GVaOxf6I"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf114b0cf9so33436755ad.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 14:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780436716; cv=none;
        d=google.com; s=arc-20240605;
        b=WIo6YsceUzj+xS0X50iCB1k9ITS5xvaHefoVvUz+xjPVWJktXA0DYhvScgDL5t3s0K
         niRSGD/s40GiS5g42b1DlUFWhv/ks4UKX4IHgdUQXeNw2ZaknjfklMbwyF+a/h/V7wuL
         McHTJSWKL99XryMP1Ds4XSTtAbfOFSdF/j/5IKf/jREwde0UKN6FDESulc0hm72cJbhU
         vwVy1bEz3wm2kyCbVp63EjoYOT2Cq0oifM/g3h5PsaVEaVMOPwOBkkJjlZ4NmAmWt/ot
         asHSbXw1GwhKPXGUujSbohUVSwWhjpWP9xs5GspuyUAk/GyForeg/ZWGnGZyjgfgpol7
         N/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KOQdHlqbjdmDreblqF6LDye84bMbw/y63M7JSnQjQwY=;
        fh=+v+Ti7F6DyWXM/vLaSn1xwgVeVLt2QEUDlAb69o2klU=;
        b=j1/2vUj5GSsqXmqwbpoKv3f65xWgKdNe9ZW7DQfHBXZcjC+jPVSEzpJOM5qywryjrk
         YjbvDQsPs/ctP9MTgdzDAuwj94nGt81j1m2+a5LsnXGjr8yjmLtG/F2bJ0m3PXMZnIHr
         8wbeKiHWBgSNKls1ZK+5J5gH9ZeCXE55A63Sjv0iuM10C/te0LqGiZV92eQ9lB1Lvtr8
         Z8LySGo2RL0SCF1nEoD25zbqozeSREjikK9yKfb1t9gKnRcSkq/BfNgEgkQpXQ6kS/MO
         zVjWeWzDElUWwetwKk49g/MhvPI42+RrJAKGeWcbWk/08f4qCKRCh0FiU/p1SI0DF1HA
         VMiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780436716; x=1781041516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOQdHlqbjdmDreblqF6LDye84bMbw/y63M7JSnQjQwY=;
        b=GVaOxf6IskshIWFXpyp00GpLCHlAzB56Wpwkv38VLkYLIxUN1669g/OKkBmG6Vt5je
         XOj71bi9TwMdNZw8tKxI1zvySYg+1HEj1Pobk9BlpGQu2dgBTRnzNMiYUk//SIb1n6rN
         viH9YJmI+utKN/8HMdNs6uZaqBrlDCrrMwQXwjDmGIZAZ4op+lGXdUH6amVXBRCT0A/D
         ufidmD3M+YZT147mJvpNI11PYvaCW4vLUZ4VJBGtIfkczCaytcgaimZs2Ph0EuaEStng
         EarIi/p6I3/hU8rgykTOwtkD2BSGLjDlRYn2apKdjgAaX9g+ML+kUD50pmPZDx/8gGZl
         7bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780436716; x=1781041516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KOQdHlqbjdmDreblqF6LDye84bMbw/y63M7JSnQjQwY=;
        b=JdpmWkRqgNL/g8getiooD1ZkWs8HUPD+w9Nd2IXoPrjfhaeJcncfk7bJIZbw6RdBaU
         12r31gOPRmIV2j/cp+vh61MY5ZvNuT/alw/EYY4qGfj0FcUwsyEoP4dFLyOnGelMho++
         JfYHugqW5OnuDrKyABvoRguNXnFdT/ktrEgCTEPSX8I7JhX78rmFG+qBmlSlxhZcbE1s
         Ois1gPgHkTKFQSZMKrMsxKe9qrrrNVqxtIslFJNNKF4iEHUbOVmzFNmKAaBAEljAoivF
         AeJ3VnJppRVIgSbbKJtznqJK4hLqk3YyXRPbg75MJ4JgqozAP22dE2PxJBF4P4/vIkTc
         5l/A==
X-Forwarded-Encrypted: i=1; AFNElJ/p+npPL7T3Nn6nQV0a5OYSQcwTS+S8o+T72JDB5hFIA0sEd05e079iIP2NvmEUwmkBQ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YywVIIu3FJNzlY79fAtV0FVeIoMloes7Gd4L2owXFc7yYX62Nht
	sBP8XEtcxBbuI5yLuiMIcpSq7Z7Rxx6KABXI3kMekKZ3az5u8Vj5MpnKHrb0BTq/0qeGMlfABcY
	/qMEI/NxzTROz4CI8yXZSQmNJ5bbk/08VdBw1xyYYDW3ifVORQlcNfg==
X-Gm-Gg: Acq92OE/hshF2+RB73VV0CiZF2GxJwW6qzz609K9mYhneChGLIMJVBvkHz664ynr6uL
	WRQdkRz5QkJbvPw/TNKyDQDyhGtW3lEced5+RdKJXL8rRr/ADCjBBBNAjET+HR1lZOltux1DyAy
	41Tga668NE/c2M31eVg2UKR5YtILpBd/WvmpnIHnaoNvkCehcQjNJUJmAKm1Nq4WCN87ddKisMg
	1hlfTSvOXQeJ21mkG+FxKMk1bDHKENbr3Jwl8NW05KoPLkCd2iyeyCIXv+H1vav3ORJWK03MaiO
	1fkqerLG/C2X6reu0w==
X-Received: by 2002:a17:903:3903:b0:2c0:fa4e:91ed with SMTP id
 d9443c01a7336-2c163a59a86mr5095515ad.18.1780436715739; Tue, 02 Jun 2026
 14:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk> <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
 <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com> <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk>
In-Reply-To: <9d34218f-abbf-4a23-8b35-b305873ffae3@sirena.org.uk>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Jun 2026 17:45:04 -0400
X-Gm-Features: AVHnY4K_GfYnJi1Ham2KVsQorfmtW0kY909SMhxY_6Zb2qHORdTKGwtbORTWZjc
Message-ID: <CAHC9VhQnBi55hjwTATA_tgKNZ=StFYTKu2Av5R8N4yDJwsFswQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the security tree
To: Mark Brown <broonie@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 3:16=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
> On Tue, Jun 02, 2026 at 02:40:12PM -0400, Paul Moore wrote:
> > On Tue, Jun 2, 2026 at 12:31=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
>
> > > Thanks Mark, we're taking a look at it now and should have a
> > > fix/answer later today.
>
> > Proposed update to Hornet, assuming this looks okay to Blaise I'll
> > merge it into the LSM tree (and either pull in Daniel's patch or base
> > off bpf-next so everything builds correctly).
>
> > https://lore.kernel.org/linux-security-module/20260602183658.161744-2-p=
aul@paul-moore.com/
>
> Can you ping me when that goes in (or things are otherwise resolved)
> please so I know to drop the revert from -next?

You shouldn't see a conflict with lsm/next now, but if you do let me know.

--=20
paul-moore.com
