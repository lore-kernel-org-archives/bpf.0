Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792825033;
	b=PhSrDDVQe5+oS5tFVKZ+j7s+pKgUB9XVIPhSrNP+f5RcyMAZVKYc7YKhIcwN5uFgrRI2
	 MIuSW+9rChd+YffhuXm2hedOLydYWwFWR28OaCLgA+tYz/z7cGThhXEwA/pkOIkVViVZW
	 Y5VbcC0BQk8CDOKOPsTz2WGpivnNCJBbSXP+sjqHXE8txX/qC5hFh0CacKG9QjXjmlr9g
	 5AfOKpsYyOeQdyc9Enbw3cZnjEf4JD/TH0/NkYT0bDCNlo6yfutdJ0UnVORE2m2pHvc5v
	 HGBbBQYE16Js5x0MMvKZkVYqFZN4OZe4ihfINXOeuYZ4tr+v5PjeWb2VGxwjP7bcpfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792825033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Afbmn384NjtXVMN6vbYrCXcl1LL7Rr708dWruA4+rrQ=;
	b=BL3NEBzeTkRTsZgya2MvUJlommRTudGxnLhwOQtWxoiGe8QwLk5C5QetpEezFj3f13gA
	 7ltQocdu1E57XQiLmk4aU9ZPc/XbP97fuBR0sZNThPDDDpwYyKGUwjTUvYrlNSX93WA/p
	 JrsQM5UJRfST1A7CYBTX4ElJPWAGcPfLZZ0EluHVZ/0jRvpzkQMROlt6A2AV9VYYK1gMF
	 0tsGRkxcHvOBELULNSFfiiQWHBEZI+Xh6K/P16AAcnZ/9wSO1OiJ/5by9WTM61tjFl051
	 BNmTTPd/961/husaOkeOQRfVAdVX6tXDUBZGdyzjPMKQzxbdxE5pIYxYFmHIBAk3gRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GQztE9LZ;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AE606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 06:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B93AE606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GQztE9LZ
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e7e742a2c7so10238705ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 23:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792825032; x=1793429832; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Afbmn384NjtXVMN6vbYrCXcl1LL7Rr708dWruA4+rrQ=;
        b=GQztE9LZDoU2DzSyVSmLMXH0ot90P79SC63HQJieUp35V+F4CVsptBC+pMFS9oL45t
         j04GOFehzKNTM8PSJOIKAI/P5Cv+o9Et2LfpgR33yh5Au1kOhAsp73Nq4/pfrBMXebIt
         dF3UYyIkIGORt2HcYntKeBT7V/2PVL0x84gXMH32mYu3OOE7QVFLeNyV1zrBrHaHiMUK
         J2DqYc19IxpOxBX0EdoB4CfMselFpaJyw5qVQzq9yWwLWvKcIl2aN8WWO/XKA0LP9axq
         +ZaURM2vQ1ugU2ei3nS2flxzTNsOWpKb3aNfRZOd15T6UGxViaYMri5I7RrRvIghdiq5
         2DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792825032; x=1793429832;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Afbmn384NjtXVMN6vbYrCXcl1LL7Rr708dWruA4+rrQ=;
        b=b7hdjFmDtrHQ3wQMs1L9vhzJ/CN8rRJcCZ0Z/a3q69QgIvIOf4og0f3egHB+yWStRu
         tRphobUXUIQ+nJMm3GuMyk/TUgcVYAGp8p6oH0s03W+EKlfRjSPquFqrfl/iRWlNxlPX
         JjLzYU6/JHqs7fL0F3TZjHkhvstZG75swbFmn53dD9QmE5KLkU/nUj740mc42XKtie82
         QqmcoPgAZHFPNsbLj6cogW4v+ULlKiCK7pkLqukhAsN+AVMpUZqxRe2Uw79KJ1XqX3Ip
         cWrO3PnWc34nWwJ1koVvpupo3jvsu7wcwuJUpkV/1Iy8JcLD2cxwevV37sBXDNQHQviz
         GRKQ==
X-Forwarded-Encrypted: i=1; AKwUvByejSSD9PtivXQp696F7mMXldtfMiSjJoaZObVFqANK50ibj+punlLrCUqkc6JYE6/Xn38=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPjVPnr0KVF4GlYhv4lL85SuTdhN955hdQ/uRWZLcCGT+pkmAA
	ny7KZnCataeQ9Cvs7YhTRWCdRcuooB3gNvphE1yA79nuNFjvIEcTLMsm
X-Gm-Gg: AYBFou1BSNJBXI3Zt4DTQEoEioyeXX5S5V2Low/pfC4PvHCtNeEvjs+OfIXcDdYf3J4
	4nvHUStIqidWr9tqxqYkBKvwuPHPyBVV6o7mO8MReXBLxf5ISTdfVLn/RK2ZUo/oPg5ASixw4f0
	x7Y8bkacwZW/vxhlLrYV+kc+UV2h7oaK78FJvS0RoNBDyhbXz4LjfspbXVGG5qyYP5L5ii4Oekn
	ku1Vh99aOBjI1oTVWVJQpbffCCajG1lj5/EAHSDVv2mu/YaK9pOVb7HzW3IQi+l2ijyUvuZp+dA
	OaqiXOYkiATlu4EWsvFGNyHtjO9HoT7fmsVjZjylnh3sAY5HNPuT9MLFEecatpH9em1UGebEpKX
	ZOigQzpRYfxrC4jryKS6neb4wKP9KSdrlCbvWpwL9774oBAWCsFvvc1ZeQSX/J61+mJRIhOxbCc
	h2pa6TlHb3ct1TZutPhcf6YW3t1Q3jnO8ILGYOsCfCyI6jjCkZdKgCs/rsahvRKMv1rjrne5LOv
	BHNie7q+wcDMu8JroonIYI4c3RATjcG8w4LEPkatVNXszyMxZPZxkWsn8ILcsKzLCKR35DyUhse
	fPFtALE=
X-Received: by 2002:a17:902:ef4d:b0:2e4:ade3:7290 with SMTP id d9443c01a7336-2ea9c8f9844mr7616685ad.30.1792825032094;
        Fri, 23 Oct 2026 23:57:12 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1e4de3sm3164905ad.66.2026.10.23.23.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 23:57:11 -0700 (PDT)
Message-ID: <4656dc2d7b8749adb9c9b26490a3ef37aea58715.camel@gmail.com>
Subject: Re: [PATCH bpf-next 02/11] bpf: do not intersect with current
 register range on clamp
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com, 
	yonghong.song@linux.dev, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Date: Fri, 23 Oct 2026 23:57:09 -0700
In-Reply-To: <8443794e24eae423d0f499a1d2f24576aa5bb70f6e5f6e015914cb0d1a72210a@mail.kernel.org>
References: <20261023-scev-simpler-clamp-v1-2-d43a07eda7af@gmail.com>
	 <8443794e24eae423d0f499a1d2f24576aa5bb70f6e5f6e015914cb0d1a72210a@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, 2026-10-24 at 00:41 +0000, bot+bpf-ci@kernel.org wrote:

...

> Since bisection can land on this commit, could that change be folded into
> this patch or ordered before it?

Commits should remain separate for documentation purposes.
Full test suite passes on both.

> A related question about the end of the series.=C2=A0 cf18840bc068 only h=
elps
> when the current frame has no active loop.=C2=A0 Consider states inside a=
n inner
> loop that is entered again on the second iteration of a terminating outer
> loop.=C2=A0 current_loop() finds the inner loop in both states, but its
> entry_state differs, because handle_loop_entry_exit() splits a new one on
> each entry.=C2=A0 So the EXACT check runs, and loop_stack_safe() does not
> compare entry_state.
>=20
> With the outer induction variable now the same on every outer iteration, =
a
> program like the one below looks like it would still hit "infinite loop
> detected" after cf18840bc068 (with the old code the outer induction
> variable was [1..9] on the second outer iteration and the EXACT compare
> failed):
>=20
> =C2=A0=C2=A0=C2=A0 w1 =3D 1;
> =C2=A0=C2=A0=C2=A0 *(u32 *)(r10 - 8) =3D r1;
> =C2=A0=C2=A0=C2=A0 r6 =3D 0;
> 1:=C2=A0 r7 =3D 0;
> 2:=C2=A0 *(u32 *)(r10 - 4) =3D 1;=C2=A0=C2=A0 /* fp-8 spill -> STACK_MISC=
 */
> =C2=A0=C2=A0=C2=A0 r7 +=3D 1;
> =C2=A0=C2=A0=C2=A0 if r7 < 3 goto 2b;
> =C2=A0=C2=A0=C2=A0 r6 +=3D 1;
> =C2=A0=C2=A0=C2=A0 if r6 < 10 goto 1b;
> =C2=A0=C2=A0=C2=A0 r0 =3D *(u32 *)(r10 - 8);
> =C2=A0=C2=A0=C2=A0 exit;
>=20
> Is that case covered somewhere I missed?

This example is valid. Need to relax the condition in the
current_loop() or bpf_is_state_visited().
