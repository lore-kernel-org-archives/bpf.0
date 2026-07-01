Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579B349CC4
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931102; cv=pass; b=KiG40FSaNJD6rcFPko+nF5BALyD9rTCkhJZiyyhGSkSvcycReNe54YRE76WQKrXIcAWT0+ZOzO5rH8U0oHI+Y3gGWfKGPGzgGzQRQmGj4OIUkU0MSiSe5fKL+51Xz4+Tm0RuKwbhKFAOyYryk9QRi+nUYf/FKEPWQ2zHBMDlR9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931102; c=relaxed/simple;
	bh=Mnap1+UlUnWBZOkHLxLWqTkUukirAeI9f8hVRIb1NQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HctzeObpGnim7o+4Hrcgg0xTl5uPtPvm1XKs1GcMjBYQq8veSbSHpl+fefSuyzqG0zrUUSojJPq+haWzsfySOe27QlDKSC4tmP6Ppt+7E63pBIqw28IiosKUPZG4WpztLgiKX/ldF35sh7Eg3XSWLCy+GjQmtrTOwnklNUQTiyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FGI4z83k; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FGI4z83k"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c7c61b5292so10506985ad.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 11:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782931100; cv=none;
        d=google.com; s=arc-20260327;
        b=kZLtjCQE7MewvUaXam1rH1NuYu4VQfmuoHYRbWwM1gzx45zVjYgxTQSCqfOwaWcpJs
         Dsw8ihi6j7ilsSdJwKTM176H6Hyt2+UDJe2T4Ih/piuXWVk1Be/caHrS5fCNu8EtqWrf
         7ZgIqaQAI2aTbB4Bik00THV4j3NsYN7yYVf7NCVc1dHPg654Ow6OxfZVCxjGU8sdPY34
         5spbr/Wi1du+MybuDIT5ogm8nVzD7Wt3PKwGm0x86FYN8THMZD3SGzcJjFIdfQFsKv/p
         XJ0NUtl5OiEg1X6WmV3NayVjfELywG1cWwIMb8mnGzKWZi33S8zQbId5QB+gCHtH0nRM
         0UJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2MBQaboQ7ps8knbKKihnH5tB9CDYcCm7037HrSOtgY=;
        fh=kww1tOgR1zCuTqfgO2WlCzSUQFdH9eDSwrGCrDD5Nl8=;
        b=RyEHDqM523spUhNSDYpnWXT2A1TyqbodsGSIqiu4cZA2zP1JUatTq7h/SHn208hQZn
         ZUl9EOCaoBwxX1qGNc5YOy5QnHrDWRYel2njSBYtspiztnbaLQrPFYCMK9kvFVbvgD/c
         uqq0EhFsOWxa7FVM8567cGCq5mt+vBJKWdQbn1ApiIrDTfCLzFgy/O5YaWXjgiQ6KXoa
         xdSgZFLjW9U7syTsj2MQMYAk1Y2mtRTPnKfSiuU0WxqVl+wWNfJ4Abmm+nWGmrpO3oeY
         cpnPMyRzLU+Nj4L3LLoZ821YyE9uoOd5HNbh44k/MoePRe+rx9JT8hDkaXud8Kd07hEs
         nWXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782931100; x=1783535900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2MBQaboQ7ps8knbKKihnH5tB9CDYcCm7037HrSOtgY=;
        b=FGI4z83kN+qAC+C9+mZweeWYl+jCXfzakwgLVz2prRWPIaBY1lJMiknL7SP4ahntMy
         0+S6YraixQTDa87ytYhqx2+H2QObG18wPGxT2d3GL8PAR/g0+MzcaLssnP2SsjlZMcHD
         91nEdUg7Nu+ITl7egpXTelR8xCkgATx8Oa9MrGlzgTwd4tayYHmBC0OR9auhc0pC3/9h
         7tcDmmrfPRm1llaR4LwRc4hMB5/ofd2pPCPXydCaFFCw7R9nIr7o+k7su1AMyOy/+qF3
         SIrFfdJsd9AkTO/HhJorWHZYXjuTGo2KW6JU53a0W2VuI7mAHhLDZW82XW+5kUXj2bm8
         tExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931100; x=1783535900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I2MBQaboQ7ps8knbKKihnH5tB9CDYcCm7037HrSOtgY=;
        b=RrHrS/uoViYlz9xprd7e44IttqJ3AU7TKggZvFk3WUx2R6QZOGZp5qT/uqnBJu4v1y
         G0RUoHQIjqLPo2ldyGynXQ1tCKsC1bUdB9NQ6NWioprDQ2RRdkIN51PV/nTf+lILEXCP
         SjMqCf8MTUrrQmxecB/NuuEBDIHmFm/uYga9HyP5d4PzAu2zWO9UbS7Q3540KDxhUIjU
         0kf2L+PtV6qP0nxo1lKlY+yZGftZ73SGtnLyn9uRbMUKXPIJ0XTdRV6mIne042fj5gpO
         +rnPSblbXmGnvBJlpSj2Syyf/8dn4+8U3uX99kREtE7Y2J3vFmEgxsU5evSqbWx3eqzf
         Xwpw==
X-Forwarded-Encrypted: i=1; AHgh+RouC2iGfOF2v7CJjr/nBciEXQpsdrgJmI7pJE1JYMZwl6AoasL8ok8dUIPDuZAN/zOUuWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzMe//hkdRw3LcD0Uf0YXS7sysItb1Kgc2PzFtB9GD1KxOtMHP
	G2bj0ChNDhs3qbGD4SPfz5Qd2pg9nukj20Ndk3bfuCmt77WLeBqH2RCmI45B4JhhrFG9yB3NXio
	YMHAqvZri7FDotWXXSGp59yl8t8eqXFdiCOk0u09C
X-Gm-Gg: AfdE7ckoEy9gwIZIIfig9cEjmqwluQM8AvlqLM8VkIOBtCQYWFVDjsuIYvbx2U6HHsP
	dISaF2buBeF1ku22Sh9aWSnvOh3fJJE44kqbyTXNEgMIUR3Y4j2MfMkhhkXVlLuhuv3x7oYy9w0
	SV6AL+2qCJH0KjWBDPikWd7ON1Nc69HqkB9YhHTIXyRmCrg/lMygw3ypx38aUhewltemv6CWX5B
	T5/t8V4TMttFOEhkv34pHFJDf2EBIC24KA8jSlMy3sSwSgkFk/cMh9yKjovPYyZjlRwhaeI
X-Received: by 2002:a17:903:984:b0:2c9:97a9:2095 with SMTP id
 d9443c01a7336-2ca91229282mr17992775ad.41.1782931100271; Wed, 01 Jul 2026
 11:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox> <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net>
In-Reply-To: <20260701.jei4Paej3zen@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 14:38:08 -0400
X-Gm-Features: AVVi8Ce6qbJbJWCCH2p0_6_r7A1u2IFyNbmfvgc4fJ4aJEpixSgjGeJjZVE1e9k
Message-ID: <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org, 
	john.fastabend@gmail.com, Justin Suess <utilityemal77@gmail.com>, andrii@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 2:34=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilityemal77@gmai=
l.com> wrote:
> > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mi=
c@digikod.net> wrote:
> > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > > Create 2 kfuncs exposing control over Landlock functionality to=
 BPF
> > > > > > callers. Export an opaque struct bpf_landlock_ruleset preventin=
g callers
> > > > > > from accessing unstable internal Landlock fields.
> > > >
> > > > Generally speaking we don't want to provide APIs, either in-kernel =
or
> > > > at the userspace/kernel boundary, that are specific to a single LSM=
,
> > > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > > function as examples.
>
> This patch series is not about the LSM framework, only about Landlock
> and its specific model and use case.  Landlock using some of the LSM API
> is not relevant here.

Based on a quick look the patchset enables BPF programs to call
directly into Landlock.  For the same reason we discourage other parts
of the kernel to call directly into individual LSMs, we want to
discourage BPF programs from calling directly into individual LSMs.

--=20
paul-moore.com
