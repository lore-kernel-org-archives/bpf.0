Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476DB1E5B9F
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172471; cv=pass; b=PqjJ97wVCOwTmLbEX298NmPHvyqcBCW6I8U/IOaf+4o3Gpl8t3+J7adlWLAkMf2eG0n5QFfU+scPd228YTDrjQisedpmZyzhfBwmM+i3E0ydmOJIIc88M564EoWThcSUHmewyV0GBPJVdlnW8cgUuV7bqFCkOYKzqGy4S/tHRlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172471; c=relaxed/simple;
	bh=yiO5TV0bwTKJtEwFyHk1KmMv4NJpSMLcyyEMsZ+nsFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0hEc2D0xotVzOvtVoGrQPkTnRoQMPriEoTOwmAooasClKUj1hP3yN7jKJ47dg2JIiMAJTbxjNtcVGv+xJh334xEuuidijMgo0Z0CjupwIVR5MYd0w7cPV0V9RhUIlP7+ab0Nsa4fnIzjlcCmwUHxoCYNxrIpu+8+HpfYU3nupo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZSf2oyg; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZSf2oyg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2db3305f94fso21645315ad.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 17:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789172469; cv=none;
        d=google.com; s=arc-20260327;
        b=dYvhU5OZoA1Q1aOzoIrWQUEgmFMAwyVHlKebG1qWyQZJxtG86GhlTNISzkcB6b/O86
         z2UA2PVcx7TCzb4rnrUtFSWWZogDF7Z6VD/fzX3rbCNUa1EzzBE/PH4Hd4E61g0xedVf
         ji6a7JpyOuj6kRXDyHmUZIf/+VEgxmG5tRkc+SgJhSf7bjXnEZSNTI20B3Z7hqBpB9iL
         B/ghhNehVPSuEjpP2tRosfvBBMNwHz5Oj3bXHdZUEl1gV3Z4sPZKa7Qww6vNeclrAfsf
         IdAbkZoII+2adeXMnhCLxb6viVdZ4LTWpu7zNrJ0aKAP2UuSKEVA676a8BnzoniXwN60
         x+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yiO5TV0bwTKJtEwFyHk1KmMv4NJpSMLcyyEMsZ+nsFU=;
        fh=tFHPXckZFUoakLXqdXRT9LYcVWRgtkfQrrr1rHEiQ2E=;
        b=qWzU1eHgbVF5x7j/IuelcNPvOnKXoK9FEeq0fzwbRjO0g0qvs5nTgLkwG1OYRJYXQt
         1mjoaReVJ4JExTHvyOJ7o+ovpUMqBo3qGist+2bprJR3/LCsWPhxQHtORBxGhSUSBTnW
         6hg/3/NmiVWKiNNe1B/+OwJeZWTolbuFQOkKgf1YVEqkt+a69Lg1hcodXt5PigJlmA4Q
         EEfUbqE8uqyOgOUQzp89JhKyZLlpTCBTTQyXpW8Sw8tyjmRRppwzpD/QgnlaXjuJb4NZ
         j+9Rm4z5qpzm1t9ITjsHOP3A507jbRODohLJ/NzankgKdYAcYkKsmkLvZBOCjMizXveL
         CxUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789172469; x=1789777269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yiO5TV0bwTKJtEwFyHk1KmMv4NJpSMLcyyEMsZ+nsFU=;
        b=cZSf2oyg4vqiJK0oNy50rXu7Jdi3uqS8aZvYiQIlLc/qxPEWvjTVfufbD9OTukguL7
         qQ5LApi3yKUwLbId667EXHstaKGLILbkBz8ky0A6xOPmjteCMsQngj913YUJ+IJcqGk8
         rjyCbvfFV7UzhT9v8KoSDGxOnISMEpz564WVVnU43I2rksvOqmprMplcx/hkq1dKqCU+
         iJbS32sAvVCZ1kTFmbNAf3XEHmZkVauTMpJ6RJYxDqvdWldEhOS4rM21Fcy/o9xpXwtZ
         qtIx4BuESVdYTnw6mJB48hYWd/OODiE7u2gaVMtr0BYqa37236BKmiYfcTwcrQqCGar6
         8GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789172469; x=1789777269;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yiO5TV0bwTKJtEwFyHk1KmMv4NJpSMLcyyEMsZ+nsFU=;
        b=GLRpfUVcKuplG7xcIH7eRVZbA/YfArimsnBkS10+6+36MvnkQO8o+gXdumUqBamNsZ
         xRoOn6iNGNKts/JrcDtMKtmDCWji1680Gcj5ztVf3vFYkwS3/tyziIpd8IbqrpE4hb9Z
         ZW/3Ee2wDdvDarRSiZvI3OoyCAzbo8TsCMWjB53WDXroExP3/kVBy1FP4ouE6bc4ibNl
         3+tliOswB2cLN1pq7B1IPMmdqISIDUp0O+VCC8H5GQL/zFTK2pSicBcEsxLAmGrtvafA
         GwyOe5+7Sb3yQj6YmKm/7Kl/4Nnon2IcRytZ6OefPAX0E2JevFe0T4eB5a+ruD2NkRRQ
         YWPw==
X-Forwarded-Encrypted: i=1; AKwUvBxLgpnTg8oYiWWhixv7ZNGnt/+noIKWJMDvkCzayxaaTZmjJWb3ssnEfwa/h2c+gIU9CI0=@vger.kernel.org
X-Gm-Message-State: AFuF++kB8JCDuQbD9V/g1ZWgUN2FeCyYDh5mnWOCIkbKPV4dtRaqnPn3
	t2oTuqWuHvMpzwjBhm8mewFNJIHwXK8Qocp5upjhCH2N4bpwBB3hRuI8f5w9oNR5I27FIf13v6y
	hc03NLx34AniCtcEZNTVimY7sPmH4qRc=
X-Gm-Gg: AYBFou0+wW6KTEEM7g5hCWBxFgvcJWVO9NPWpma/FXH8YoJwdwJtEctdUhf94aEJ2Zm
	hZHFTPK8DQeNAKUMo1gyt58WfgK9QDIKXGazUy/Ixd+RpExZfwvjdg5M4c98SHjJNJFTIXo5/BI
	bTiCT6fhw+iiUJdz/VgZCRr4qgQEPOobbQyPEBuvLaJB4Zer6fJOJf3UeFvgtFDBurHkONd4k3v
	ewiO7zLWOJWmmOVMKSLRAiDVXrvASZIMIyRQ+W2oDZ78U2kw028vgZONrggFUB2G9fS2bItrG7f
	+46Cx/3echv2c72a2KZ6duwiowUD1Ggnt1B3GDrwkRxtkm0z1/MxLniepjp4kA3TRUxOzVwxSJ+
	1DVYx2kwC5krgjm4dlVX7z1+cnzpf0CdBKgWL2rI=
X-Received: by 2002:a17:902:cec3:b0:2db:5f00:ff52 with SMTP id
 d9443c01a7336-2dd2a45c363mr109249375ad.22.1789172469306; Fri, 11 Sep 2026
 17:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com> <CAADnVQLxi-R1KDUXJJjpq69SpV8UcNJVqBi7uicO=V0WhAvyQA@mail.gmail.com>
 <DL2S878KSOI5.1SZMLIAWMCNUJ@gmail.com> <DL3FIBQNP6AU.1HO08FMI292UX@linux.dev>
 <CAADnVQLMm43qJxuiHUuuh51wAL4kH0+fRoaM7YfbZEXT7LHn0A@mail.gmail.com>
 <DL4R2YXF9J8G.203VBANYFFSET@linux.dev> <CAADnVQJ+OJKmgaDM9B58g30M_-pkZgGmbDuvEWmrg8U_ZkxbSg@mail.gmail.com>
 <DL57W17T3VEC.1EJMWXYOB7JFU@linux.dev> <CAADnVQJLNW=FqPrWq7MX28iA_Qsw_N1mT923WrVkoqES1ZArjA@mail.gmail.com>
In-Reply-To: <CAADnVQJLNW=FqPrWq7MX28iA_Qsw_N1mT923WrVkoqES1ZArjA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Sep 2026 17:20:57 -0700
X-Gm-Features: AcwNN1VKgqAgYGqyMG-DgnJAxbrComiDzG6Y23_NRHjcQt0zpiMmYJ15gSn1F6k
Message-ID: <CAADnVQJfvKmtD=jcOjaYaNAcfmujQm_oE7oNefTGiAAbTFj4Jg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
To: Florent Revest <florent.revest@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jose Fernandez <jose.fernandez@linux.dev>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:48=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Let's extend ip_after_call concept.
> Instead of using a single NOP after the call to skip fexit progs
> let's add NOPs in front of every invoke_bpf() including fentry and fmod_r=
et.
>
> Then on tramp destroy patch all nop-s to jmp epilogue.
>
> llm-s helped me realize that fentry has the same issue.
> fentry prog A can sleep
> while non-sleepable fentry prog B can detach and things will crash.

Florent,

are you planning to respin with the above fix or should I ask my clanker ?
