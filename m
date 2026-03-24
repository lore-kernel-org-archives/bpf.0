Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D5384222
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362727; cv=none; b=iHbxwo73N7fVcoJHiFC5Je2gdqm6Y0TCIwr6QQ9rGZ6n4M/0VIjCbTU6rN8+K2Wxby6GV6s7tux/4/2CcBiT1an6ZLivtYUfK3bqsig2CFhDzaAfH6NnquEDzteIvrcfTOanIPE1Ox4qLUzOY38QgEcxf7iTOKjRLkL6473mrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362727; c=relaxed/simple;
	bh=5o8l0vLxm74e0MmSjAvuKJTpAJjS6ccDL2inty2cmMc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jW8WzzCO7pVok0c807bn1ZIpwgA1f8jq3zNJjpH2WZz3YWu6waa/OEsdvMxnj7g0Tifkv95hDFezJu9bjVI9obwJR6la2W4g5HxFS+vV+wjWEtE7U0Cps75tFngW7Dcu5UwZbRg+kmNXMpvXndHKslPH/BG5TEZX3qCSQzY59eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbYqNYjF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbYqNYjF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4870206f73bso23125845e9.3
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774362724; x=1774967524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5o8l0vLxm74e0MmSjAvuKJTpAJjS6ccDL2inty2cmMc=;
        b=cbYqNYjFZ9A0CWDz3LoyNhGrJh6r8oQbJJL7qRqw2Er1py/zE6MMMIhjamI4nSRLtD
         zBpVysG+PdOs3Q+V2kR2KSVXUXUVilyom3gQR+FURv5BAPWd4p7aWxb57c+Jk/tBHIzb
         7XrIPhxyzJdnyMea89JNk26LG4IhsL3op5tV65aCJdsiilpbtvj34q2ImOozgjaAbo0r
         TEGIrEEtti3gjXyDXe/XDnxs6QIcU9WnzMPUp8j+4M0K4aS5y9Fumdh3KwbtMYwkcFSv
         g8uWEZ0VaV7z3K9X63fhs5AbWODPGjGj5o/4LqVIcdbRWjG85jiuwO4HLAObDVx4nT76
         dicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774362724; x=1774967524;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5o8l0vLxm74e0MmSjAvuKJTpAJjS6ccDL2inty2cmMc=;
        b=MDAJ2F1j4L05qXZOWg9yRFZhQ1bZkDTy1jB3rortTx4SaBG6eSW5cBlgYW9B+1p6Qj
         /ualrDWEUx8QUdClWjVM+P9sLJ9QxdNLa0paqNBC5tAojnECME1+kdJ5n0+t55fKekig
         2NOCaf3OE4rlsKx6VSfIGjhfMhatP86NrenbtjiTTvpmRzFZZ3bvG5q7DW1VFaKgaA5p
         Ttu+AwMygNA9K826WWwItSO9nKCJ3EWkCadWQXFW9omN2DNLbyRjfPl2UP7j3bQitOHX
         hn+D+xXaPjlK5XSerYlrsIpBXfwVZMAnwJjYsPHflMjcKPcUICdvOcWUkKxskZoFGkGK
         F0KQ==
X-Gm-Message-State: AOJu0YwKqDiZP8QT28+NIsPRb1LzGJ1phabi9pyzn6Q87qU8uTbyWwqB
	LlXpQItHIF3TlaErHV7HtEKjg5TiBEXxFAD1TchB8NxTCoipsLIfCuwA
X-Gm-Gg: ATEYQzx79wwg0hD/ATiO7VyPs94aq+XNpVt62oSi2LxuxOz9Eks9wRCeaYkcYacL233
	AcNs5UwMU9gibg96N/5H8wvXcRTcCuAuuXHfTIEuM4EgOIxFG7QLqKgS12PRcrDwt1RpgmKYivE
	yMEfWooPH1c7tXyYnP9Ws9cWV/wkq5JuYJvg10x5Jl10ADbxC2a+sbGzqTrj9jqEp4KiuyS1NSO
	06Db+3rRA1LtQU6IkQOHgCPAVIt5Icbr03FX1diPErzmqH+TyHOWYYijEJgZ0nj0eWKoKbNs8A2
	RxBPi9Lq0Ohp2esAM00RVLKJ1vh1EjD4ne0yTHkrEjZ+jU4XsuNmgVeRlav8p7NA1eJR3zJHLoq
	0fckRNomg9sUirpLLLROtnNUD01jCJDnymvxxgkZuLD1AgEoXe3hLe044T6HgC9yh+ncGJHOsNC
	XiwPq33UA3IaWsXBw=
X-Received: by 2002:a05:600c:c10b:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-486fee2cf68mr169649975e9.30.1774362723668;
        Tue, 24 Mar 2026 07:32:03 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:8a8a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116f17f3sm51632665e9.1.2026.03.24.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:32:03 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: oskar@gerlicz.space
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com
Subject: Re: [PATCH bpf-next v5 2/5] bpf: Add sleepable support for classic
 tracepoint programs
In-Reply-To: <e0443380-97d3-4bcc-b599-0883bb6c6a03@gmail.com>
References: <629d0324276759a1bda71248e93a99e2@gerlicz.space>
 <7560779e22010c1907fe6045ef595d19@gerlicz.space>
 <e0443380-97d3-4bcc-b599-0883bb6c6a03@gmail.com>
Date: Tue, 24 Mar 2026 14:32:02 +0000
Message-ID: <877br1jo2l.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> writes:

> On 3/23/26 9:26 PM, oskar@gerlicz.space wrote:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(this_cpu_inc_return(=
bpf_prog_active) !=3D 1)) {
>>=20
>> Hi,
>>=20
>> A question regarding the recursion handling.
>>=20
>> Even with migrate_disable(), this still runs in a preemptible and
>> sleepable context. So if a task increments bpf_prog_active and then
>> sleeps, another task could run on the same CPU and also modify the
>> same per-CPU counter.
>>=20
>> Would this interleaving affect recursion tracking correctness, or is
>> this accounted for?
>>=20
>> Oskar Gerlicz Kowalczuk
>>=20
> We discussed this with Kumar in the sibling thread, the initial thinking=
=20
> behind this was that second task incrementing this counter won't see 1,=20
> so it's going to
>
> this_cpu_dec(bpf_prog_active);
> return 0;
>
> I'm reworking this for the next version.
The initial thinking behind this was that the second task incrementing this=
 counter won't see 1, so it's going to

this_cpu_dec(bpf_prog_active);
return 0;

I'm reworking this for the next version, as discussed in the sibling thread=
 with Kumar.
