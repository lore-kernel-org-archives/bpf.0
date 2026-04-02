Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BC4342539
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775173125; cv=pass; b=UJu5DiKqrgX9C/01z1Frl2bbL8X6fy/ZlS0Qjt86sU3VDNu7Zl8w1qQCr60fzl6HYLk3Kp/3/Vih23rLR7E09LPc3eTPoPH8ihpAfwmTghHtHGQDw8D5is9nuk/e42SHcbpn77wNbskwRczcAMZ1KH2ktlySx99nPuGmNpQEogE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775173125; c=relaxed/simple;
	bh=VrHUbT5fkwKMOLheEMzy2aaskunJO7MNYyh/9TDHHaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDMvpl+wUGblopmn3/f8OraloZVnnrAMFdrPz1+/3fPZSjk7asa/JP4JcDsPzKrIZqAIDRHRqb6LXv3HSfXUtwxZCbutpy9cWdDBUsbrH/X17ZAlZ/MoR9/Nkq5ZXPRms8aZfiDlEyIbRVPVO3DrRAJiMN9vbE/ZCQ5tg91vxEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3Vz4aFT; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3Vz4aFT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486ff201041so13915885e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 16:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775173123; cv=none;
        d=google.com; s=arc-20240605;
        b=LsCjTldajuvuJV9FS9te6r+TgdvNtYGfSMQFSLMjBd8XSJXFXLa9Sw65k9LxgKq5/6
         2+1buSTx/g+CDQM6kDOKNSY3FovppGL0t+Hwx8Adv4hQ38ghjqPFUVU7rKEWeBEYPbCj
         sOmSrCcwOMERtVWhmQRkKVehTI1e9Bq8pqZWSPzAuV1McYJ3n205TALTeP508oTsH41U
         SYGG8QQHqw1rha7Rlu5COqaU+JPiVjc07P5TcLyicGslSPkbACpZf2h/j0nNF3Y/RDQx
         cZEa0RJNjGmjH9u4TyUv/cxKRo9XtScKIL+h8XznzTwOAw9+Uf9aEaguvLObniIBGUpL
         KhKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EsKtQKBiyTkvHgvennBobwm5NzJ/BbIVyjjMnkcSHnU=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=Z87mbl00qqYFTuqm2/AXo8+PBX7o3vOIUSO3MZwi2Uy7OCP0HkmwkyvKRGQDs7yc8C
         AsRo4dwZqmpsv6ikSopS1SshEAsuC5dZRPGu5i/CqQkYxZCWW9QK+Hu6U4huG+UM2i8/
         RdLTYC6VnLXIq2O7ebfhRsb1P9iQYjCnXQONDIB2+g+bLNFo1+hlxXcYTRXGKPlvaj6B
         DRIHZfNapwe6GJQXB/PKzp0ve0YFX1dasbsIJ3quyyJcSgXdY+c5+G4ZA43liX2PAPoj
         Fr7g7NLTHLNITnyMB0SpOANNQ2S36+AptgolLJpuXFsdIoyojKkmlBLilAZriPWA+Hih
         48aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775173123; x=1775777923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsKtQKBiyTkvHgvennBobwm5NzJ/BbIVyjjMnkcSHnU=;
        b=P3Vz4aFTIUkonEMYpTy5UyqC8d10T9aFCT+XQCmbJVjtjIabqG0BYiFhAQmIlV8L51
         bhhqnHrMD7pI8vhlfdZqKUOXbLaSaTpMPyEnMndbv9bM/QECRKvHgJp2a5I16aFxgmtY
         cvA0MmWaImvJpgQSPNEUy5WOg/21j9Wq2ICn6ZiklqA31fA+ZjGVObrZ9C/DjYcjLdAE
         jck/z4AbcRZg3d3LtUgqmcsW6Di5v3MJKjUXHib5CcEpQuHn84hRvAP0bkO/ukRhKYe/
         UhOBubwmtCEAOh/E8/83v9ywnNrF7u5IDTN9/6A8xTb2DOnlGXTeAt07DpAzC6RqjSSZ
         KZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775173123; x=1775777923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EsKtQKBiyTkvHgvennBobwm5NzJ/BbIVyjjMnkcSHnU=;
        b=cVHv1COaZ1jyuihqDOJShrJCR1BC36NtQMz8uAu7sYf1BdhQoAiov/7319T6dTewav
         K4MGn3xDVWZ+39QA1X6Xx36KHRMrn4eZRUfJ8yMOqVu8O56MlW9l8i1PUyGfmwOihL7S
         +QPp5Wcxy8L0qU3NXnkipAvnzN1utZ0F8q1Y5y5141b9FKdX7RQLm4w8uTkg1KCvLw6A
         YUhrch0ZxdlSxkku93SjIvnvkQWOpBv9biEZ5mT5v3gm6bIG/N/GzBhrfcazxUYAHW+V
         MJp2zrJWSmyqxKyJV/D51XaZrVw+K2qQvQUjrxNISFScDu/5/Yloge40N3JnwkvSuP0j
         S86g==
X-Gm-Message-State: AOJu0Yz0Fy6XsFCa30AuLW6ci6J0jZxM0sj1BHMG0xSl+CaiuHKNGiSo
	YAUig84f7VrabR2OCfA6Lk9qVmLQNugBzUvcpRejMQ/1NiQH9BeqqTGNWJN7vSdnTSVaDGNBYA1
	jJWWj+lYDt6C8pkL2I+mmxnPlpl5X9+o=
X-Gm-Gg: AeBDieulBoJZdvgtnInBnRmuqWBuRRyG5W7gn4LIi82dY08Jr52aITDnpZQdFqHHSKn
	ewyawRNcICBX8U19YLBcwcOOG7wUbiWoHxK8VEza6Eq18ywBNTg9Fy0lTQcCJskxErqmk9gzIAE
	4/aeLZhnv5NUb3TXOrhMLqhrRJwGkm9x6pZPNY7DRT6oBvLvvKTZP4qNuMIzLFoIMlH6Y+FXF7b
	dYt5WLnpomft0QiSjS+GRrOwPbO43xzcxXtBui4tH87FheCMIqButiuj09ZaSjXOhm0d2SuJpZG
	tpdtZxhm+OXVU3ky532eB+o7VCM3zVOfo7IyUtVtNPKQoNMa9vAydtoa7x71NTOyIuly2bilojm
	6tOZnNi1TNK60+VCvROR3/k6TEw==
X-Received: by 2002:a05:6000:2489:b0:43c:f95c:3e6f with SMTP id
 ffacd0b85a97d-43d292d3435mr1429237f8f.26.1775173122680; Thu, 02 Apr 2026
 16:38:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402012727.3916819-1-yonghong.song@linux.dev> <20260402012742.3917613-1-yonghong.song@linux.dev>
In-Reply-To: <20260402012742.3917613-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 16:38:31 -0700
X-Gm-Features: AQROBzBwZdZSkxUK7vh9TgN4SR5hXikrtSBTEu3g8X8d7vt5cJvv0K-K72Z8r6M
Message-ID: <CAADnVQ+y1jZZTyNcXghD0UQ+JzD0pEu=icSP7=+QY4b=9dzv7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf functions
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 6:27=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Currently BPF functions (subprogs) are limited to 5 register arguments.
> With [1], the compiler can emit code that passes additional arguments
> via a dedicated stack area through bpf register
> BPF_REG_STACK_ARG_BASE (r12), introduced in the previous patch.
>
> The following is an example to show how stack arguments are saved
> and transferred between caller and callee:
>
>   int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
>     ...
>     bar(a1, a2, a3, a4, a5, a6, a7, a8);
>     ...
>   }
>
> The following is a illustration of stack allocation:
>
>    Caller (foo)                           Callee (bar)
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                           =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    r12-relative stack arg area:           r12-relative stack arg area:
>
>    r12-8:  [incoming arg 6]          +--> r12-8:  [incoming arg 6] (from =
caller's outgoing r12-24)
>    r12-16: [incoming arg 7]          |+-> r12-16: [incoming arg 7] (from =
caller's outgoing r12-32)
>                                      ||+> r12-24: [incoming arg 8] (from =
caller's outgoing r12-40)
>    ---- incoming/outgoing boundary   |||  ---- incoming/outgoing boundary
>    r12-24: [outgoing arg 6 to callee]+||   ...
>    r12-32: [outgoing arg 7 to callee]-+|
>    r12-40: [outgoing arg 8 to callee]--+

I haven't looked at the patch itself only at this diagram.
How does it suppose to map to x86 calling convention?
The shift is unusual.
x86 is using fp-N for outgoing and fp+N for incoming.
Why can't we use the same?
