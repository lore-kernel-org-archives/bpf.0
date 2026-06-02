Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F14C394464
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425625; cv=pass; b=sXoxVOrdOyRoYndPQHYbeNxiIWS7riYH1TEdBorh2+kOxQsMTtYncKi5MnxRgqfXwC8ug58+3IImlUe02NI7lyTWxD4t3ZveB4gNKQkQ8W2ClU7pIgot1fbaxZ6Yk28/WABPT9aVd0fudSJ/24XcKtzQDJfyhYdZtdVD1qLfZZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425625; c=relaxed/simple;
	bh=WA7l95NuW7yFcNCRtIvefhqHj1bJWeBjBhmpwS0AQds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWC/HKfTRHdIT1Jytb0Q9+e+2gu7FCfzrRjXciddj/LZEg8NQGU69F6p/vkB9raRh/RDlIIU4Kb6lwXniODUeADdX913cIAfkL5LSOXqpcAy8gyTRCqKxPQqELnVJY3Dsv4mrstcZQBPl2GeSv7XQTLlyF/XP5aFAycgAjMbRuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EI35RztN; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EI35RztN"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c858b392697so1664771a12.3
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 11:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780425624; cv=none;
        d=google.com; s=arc-20240605;
        b=d2iB7POlkci03hhMkE7Nx7c+6r0Ot3R2sZoD6ZbvqzTuwrpcazVXy9lNawTHSB76Kt
         Tco1IrwU4hUe+CZcYz4y/y/ND79JIP6ItKtgCZNkV6Igk3YDG2syik8HJqY8aa0ColL9
         8I2tZvDUumVTliGcOcQ8N1sswrUhEqwXcgZwSZn0IcCZarJqCUM+VNLBcRj7rOWvgR6r
         eXE77PspL3Rn6uquDuRHenrD1UvpER5SRzfH6CVryqZFVsOZ1Y5X8ywro9icZLdWgbcB
         UobOvmlHIJv7RNh3WiT0ZJrQdD/2Dde0ymlNHq2XGKAwCuUpPWTIPHpk3pe9Ck52IwhT
         cwSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rfh9WdBs5XOXY44y294ac6EXxBbUnL31MDufdlNqOTg=;
        fh=Am84xEZfYbim/SeycMuHn0cWhehaBZOoczjWi6BIgOo=;
        b=iookoCcKH+u1DcEOMdrSet9Hawf5rxlrxBd0P5kPfdPD2FaG+Y6+kasMjZMkE3r85l
         F4wC/eQ7Vz9ra7FGNCQibXL3XHCv346UY32iv/zmo/l32mIwvanoNzP6mbW89LMWF/T8
         fArfUW2a63qDH+XoqmYvDzrm+k32iWqCChQZ6OrBOqooMVsKhdGANK3NTgtJqXxb/l1n
         xzmW8ggXm4E1VkolZ6c/3+VHeMoXeJwoGNHlDMTTJrSdaV2GJppTM+szXP4Py9jc4QHt
         KDZ2i0aVTx+BMDian0lZMuC+rCXpMD4CjB7cPYjmEJfW2lYZI7EPbyGTyCF3PuhZWZjV
         sYXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780425624; x=1781030424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfh9WdBs5XOXY44y294ac6EXxBbUnL31MDufdlNqOTg=;
        b=EI35RztN4TEm5SbgtgQnyT6eGUU5sgcuBmOFp5ybOirSL/arndAPH43Xm/sc/fu1iv
         G3n1o3yDLVVc8pKP5F5fslIroK0BRZ81N85Dp1X04B7EGWD3JmBzYtDkJiuXSGS9zIUm
         cY6DJEulR61ALbbn38Gcla+FKtRASkDV5UWFwYwOTlgzQgcFMMG+6ud+VkU/ZdwMg1+9
         U47H1LMyHS9dh/326FbIGxwEwbCGRU2XJ1SRvwssIkenqXLMUNJ2qBinitWw1j27L/Kx
         kuaRYp3WmFNptm3BeDwNh/+ylNh6tBM5hsg8glFQdfXe/VmuYa3XIG0pfzAROUCNslHh
         CQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780425624; x=1781030424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rfh9WdBs5XOXY44y294ac6EXxBbUnL31MDufdlNqOTg=;
        b=DDgcE+L79IxmaWxHMzfS+JBUyEd/EK2Yi+IEek++BHiuQfAxUcWOmlZncgL/S/s5+c
         C9nUzczCmZAjLHFdKW2jwHLJFoQZCdL1mhPtdf8Oev91tWmcdnHJ5a7Ozfz8KjCmc1iZ
         smHmLYHeSm6DYVERgFBjkTPnI2EMNBLoSFF7IIiqUii5kAPg2Xzjm0nOFA8JOOam2Y2u
         7U9UQtTq8pNa1lGeLNmAXTHfl4VAsxbnmPbNJVs4MsC0PqGVjlFR8XQVi25HGtM3f7Zn
         oyY0oXVv8sEfuswanAmW7WDl4HafTm39JGZrQsGZWM8lSJPBQTLeLng5crbS2M8Ptq2M
         CKog==
X-Forwarded-Encrypted: i=1; AFNElJ+/GT9UwRW5K34Jkc9pZA8uU3J2q05Cs3+gSlm6ZmpcvdXlDXwn/pDG/ucaYkNDDE+at1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaxiLexgnU5PMyWASghwuSEQS5za9ZNJX1FI3/oHhNG6h1cHQm
	f0rCs9d4M+I8VS6ZkFHusVy55p0HY1Mt5qwpzGZuNLmoRNgstfHOF0Ru8/FeXIodO8w2gxbTy0T
	OqZR9NDFb6hlw161ZL/9zy9xGzbNCINlPrXAK/Ddm
X-Gm-Gg: Acq92OGdbzvw3OsSHPH1RKVEzb62dxqoQWLrmB+fTKRTjwlYu9py2dMf99ionHSm0V3
	QAkvR+Yclq/Eo+YGEJIrdlEYleNjoODYvee1NpOzGo0tseqk8gl959obRbrVWf0OwdB7M20uZwJ
	0nK9GTjFvbVIXVSRFftgRyrJi8NeJ8WEIzZdMo9NnQT6BAsYdpt/eFkz9Zfy4JbJ8IdKdd+rQHr
	1k8i+4DT+dG++zD8/MAhcR2loJxPgWkwyFw0mol6Ob0lHKpsdrtITwmC4YiJSW6qB7lPgLkIAOO
	S1xK8E37e7x2BxZHiw==
X-Received: by 2002:a05:6300:228c:b0:3b4:6a23:6ba with SMTP id
 adf61e73a8af0-3b4978a0a35mr69451637.26.1780425623852; Tue, 02 Jun 2026
 11:40:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ah8BzqSmZO40xYhS@sirena.org.uk> <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRR4mmkOdWwUCLswmA+_KEjB8RCBBTJ2W4JGiLUWKzxyQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Jun 2026 14:40:12 -0400
X-Gm-Features: AVHnY4LseEdZ3PSnzNXG3ZVT30xvrKptf0DJmetNk04_9qty-3SQmPQjrXm0JY4
Message-ID: <CAHC9VhRPbkVYAMec0KG55er6GOPdKqMXKdpC8rrHgiAodSv-sw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the security tree
To: Mark Brown <broonie@kernel.org>
Cc: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 12:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Jun 2, 2026 at 12:16=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > Hi all,
> >
> > After merging the security tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > /tmp/next/build/security/hornet/hornet_lsm.c:212:36: error: too many ar=
guments to function call, expected 1, have 3
> >   212 |                         if (map->ops->map_get_hash(map, SHA256_=
DIGEST_SIZE, hash))
> >       |                             ~~~~~~~~~~~~~~~~~~~~~~      ^~~~~~~=
~~~~~~~~~~~~~~~~~
> > /tmp/next/build/include/crypto/sha2.h:14:33: note: expanded from macro =
'SHA256_DIGEST_SIZE'
> >    14 | #define SHA256_DIGEST_SIZE      32
> >       |                                 ^
> >
> >
> > Caused by commit
> >
> >   c62310df81899 (lsm: introduce the Hornet LSM)
> >
> > interacting with
> >
> >   c48c3a7e7d5be (bpf: Drop redundant hash_buf from map_get_hash operati=
on)
> >
> > from the bpf-next tree.  I have reverted the latter commit, the new LSM
> > means that the assumption in the changelog that there is only one calle=
r
> > isn't true and it seems like the most straightforward approach.
>
> Thanks Mark, we're taking a look at it now and should have a
> fix/answer later today.

Proposed update to Hornet, assuming this looks okay to Blaise I'll
merge it into the LSM tree (and either pull in Daniel's patch or base
off bpf-next so everything builds correctly).

https://lore.kernel.org/linux-security-module/20260602183658.161744-2-paul@=
paul-moore.com/

--=20
paul-moore.com
