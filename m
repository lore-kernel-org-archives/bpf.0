Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB01C56B866
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200843; cv=none; b=sQyA0QfteM2EkHsAhbqaDCPHiyH7uekEZRUMSN5yEWm0PznTcl1VGIg1EplTo90ss8IUICj6Qcp3f3KHvQ7Yi6wEIPJWvEbrRJrzQOw7d3k6ZfUq0bknDiYvQjKOXWRY2DP76A5geM7PKNXrRcVHloiRQOikyWQSgiUg6OIACKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200843; c=relaxed/simple;
	bh=QS6x7vBk6pbkwzMVcZvNDHmyv7AtHlEpYouQGhTP3a4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Og75XTs5X/u3zqJZIMpBYBPG6l2yDVnYMiUYkMXiVnCNhhGA6koA6lTNhVFHam9xSlUxuneaO8M2MBt3q0fJjLFVUz/Eewh3NpZ0zkr8cEe9teM/ooXWZsqScR5x8N2D8d49E/mvZxc37LhvgQGA8pMKBfcFX/6sUTkvxi9Si70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJ2OAPwF; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJ2OAPwF"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-32dbbe82e13so1277189eec.0
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200841; x=1790805641; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QS6x7vBk6pbkwzMVcZvNDHmyv7AtHlEpYouQGhTP3a4=;
        b=JJ2OAPwFQMLMc3Gi0bEcm9XOG0O3dDwLaBK/49twZibxEMkQlw0vPvwXBzkKXXKnp9
         0wvJi4pdOtlXp34ELAlrccw/BZTAwxmKUNC00RB1IdWqxProMPQwxeY4xefHj9AJZUmV
         glh2ZexwcaVF3fyWEJSjxxfxf6LSpEZeLBHGrcNSSkP9msa1MUG6vaXWJg9Kq3XTG3cf
         OL9rv3RjS4OofwgRZcvlZOm6rWwutq/z4b2ThsdxMeaFzND5KR8drx2xuTE5Ted5D2u3
         WYrQ9hc2kQJcfbM+ApU5iW5r7lT8GzTXD9NlJm/73kzFZvyuWmN8HcrMw2pR+0+yQ69g
         qN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200841; x=1790805641;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QS6x7vBk6pbkwzMVcZvNDHmyv7AtHlEpYouQGhTP3a4=;
        b=upMbTmK5zeAx4FdeW4nWz83mHB/Pg9jUywH61E4tNBW8sxaloF8/m153EQNFWJYHyS
         45vAh2mDim1/YyUK1OlRWcoRZbC9fUDmjMOxUD6/UdetbD6tfWlDxe5Dht5XkNWPxZ/e
         2g90ypxW5wg6l8u/fjbkJz8dCJ1fIFW8M4nPtd1hVdQCtscMrvfKLbMFhSbhKUh1n5x7
         Yas5MkPYAvdvhPXpGmfq++gfuQpYRs7i3FAiwysUplhBRmfm1gIVVbujwNiXnTE1E+Wr
         sF4cFvI2rSwlCdTksisY7JO/LGiFllv4aHjwNpmFm9T5caorWBoPxB6A/E5Q0/NxuGGI
         Vjxw==
X-Forwarded-Encrypted: i=1; AKwUvBy6wb57N+Qo34H3dup/fXaGp6oVUI84euZtFZvoMJKRrUkX6Tj9duf0VZzT3BU37Ks/2aU=@vger.kernel.org
X-Gm-Message-State: AFuF++kSEzMb/GCdUdpZ277r3EeZnX8jR/+cV5L5uzX7j03pG4J1HiKd
	oZuqVulc78NXgLL9XdiMnE4JvnsZsbz/KolOq0dK1HWJm390sR6nyk/6
X-Gm-Gg: AYBFou2C2tWRENxtOuPtNizJXltEP9KTKJx47xAoa4Wr8WQxCQoWViP1gwHrg4e96a9
	wcOVgB+QXMXDURA4Ky2yQq7tulNcHenUiyLH9rWRxhNorUk5bNyV/w0SPv9TxQsG7VjzPAf83Rf
	TuBe+CguoWfevGlfIEEg+WWWKBr8I17bRJp5zbUMTIoT/MKBDrAhlxmUL7toDq9pUAGYdewJUmo
	XPKTaeCLOu0uQPHBgBMtdw+NU5CJmoQjhJ+Ta0WoEbwYSPbW7r3tKvOnXyr1IWOaDkgfcQwz10h
	gHGc0RamKUPxRfKWkYlO8WoAKgHP38jd2PkBLojmOTuSA1fab3IoCEFUxZwV40aMjFJHCdErkAz
	9fCQBMKi4mYczNzZX/A/aDoXCrCdlb0AbgtRPs6dMhsuwwOXiKc6Q5JhKzUDXM67lVY1JKr9rqq
	LMlp+rPNVMnS7gOivsxyYd6Nw5s6W7b4MmsYtO5XB+WaXS4xJ5BY8GILGngTTDmgmqSk4dSMkwJ
	/sgapy3Kg/NsdcLcgEbmcK5Zu6Fv1PSBzp9aH+xMN3DrZ0C0V+kkJtdASnAu0sR+Z7U
X-Received: by 2002:a05:693c:66db:20b0:33c:3f3:cb9e with SMTP id 5a478bee46e88-34004892378mr326237eec.16.1790200840059;
        Wed, 23 Sep 2026 15:00:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:179a:a128:9d0d:40be? ([2620:10d:c090:500::5:48f8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96d47157sm7144763eec.24.2026.09.23.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:00:39 -0700 (PDT)
Message-ID: <d2ad6462af36f389b208ab17544ec760c27fb782.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, 	kernel-team@fb.com
Date: Wed, 23 Sep 2026 15:00:37 -0700
In-Reply-To: <DLN0OB4STWN9.1101L0OPX69QV@gmail.com>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
	 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
	 <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>
	 <DLM6BVU1G0V3.29T5BPPZTZ77Z@gmail.com>
	 <37e53199dfda608de30a31fc51d22ed2b25d6d2e.camel@gmail.com>
	 <DLM8NP9S8A4E.1YIS9HRMSR62@gmail.com>
	 <a9c4ebe0c1a08d7025179b1ec2297a4d975cd072.camel@gmail.com>
	 <b3a29c0b77ada6a7eff101a5d8b4e83021a3052e.camel@gmail.com>
	 <CAEf4BzaStrSG-hGERB8J=mt3agEq7d9L8+L9rsr4Z+=68gtA-w@mail.gmail.com>
	 <DLMY4E5MYGQI.29MKOKECHM134@gmail.com>
	 <DLN0OB4STWN9.1101L0OPX69QV@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-23 at 21:34 +0000, Alexei Starovoitov wrote:

...

> Sorry, all I hear is a knee jerk reaction to a lot of slop.
> yes. a lot of it is not needed, but invoke approach is no go.
> As I said couple time [ip_start, ip_end] is not a single call insn.
> libbpf patches do a bunch of unnecessary copy paste,
> but that's because we didn't do insn_array support cleanly.
> From libbpf pov bpf_cleanup section shouldn't be any different as
> "one more section with pointers to instructions".
>=20
> Sorry, we're not doing new 16-byte insn. We can chat about it
> during the meeting, but I feel it will be a waste of time.

If you simply don't like 16-byte instructions, then yes,
nothing to talk about.

> New insn doesn't reduce amount of slop.

It literally and demonstrably does, I listed the actions that are not
necessary with this encoding in the previous email. No matter which
llm you use more actions needed =3D=3D more code.

> Ed's example 1k vs 2k is a counter example.
> This is just one llm vs another. Both sucked and both slop.
> Just different amount of it.

Fwiw, it was not a one-shot. The verifier part is curated.
The jit part is whatever codex decided to do with the original series.
I stand by the complexity reduction claim.
