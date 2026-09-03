Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161150EBFD
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 19:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464339; cv=none; b=crYVVeZwTc+lYXhs8WtAH34ypbgvdFHE2a9xmkL7SQfOO0P3cyMZetD+6VStRLRxxHXAdNr6kTTHv99vnWNldohe7iKY7J0m1sgxfP4vt5vSSSDu/19jO4M9PHiLVp37DvJ2sjiMoeIdltxop9V54+/aSZuvsu95OHJwXMif4qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464339; c=relaxed/simple;
	bh=nWwvnEw8kcoCPWaDwE40BzliZThktszTpE22/tRtGQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRrz5M6JQ+hwPu+3/sRCeKXbu31018SRlccjwmjiYm9R68ubCdRlSOAfUpntUMecyi4ikOudTPd5brapZy3V7dK0DZD6mbP+wsjElyl6Rtk/M15ba66JRen6eogMW8Zz4mRiQ4a1HEUVRPmFJlP4lZBTdohMaU9ns2Nig2UN5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab0dQQ5Y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab0dQQ5Y"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d7195706f1so2560505ad.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788464310; x=1789069110; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MCIjIscWtIkW8dPpZdLR261CJFgI9Gu7nzQkjrvICK8=;
        b=Ab0dQQ5YdnBngm8b2KgL/obsVKU805NrDQ/hG6S4QZUyCNqT7JkJsEWO5UUXJwxSCL
         esLeO2nlqPgbEQkA725niIube+MTIHBrQRKmdNp7Xktb7tkLHZNkFoSDgaVVgmCYE2th
         rEEDmQANdFIxRufb/ItindAUQ7CDH5b17JfIOo8BamqT+6Lec4xH3YRCShQz/H41Pi6h
         YWeQiugq14PP6ie0jRTZUJB1Zj3JqYqRo85Q+2HwNmEbd+m0pi0gHrgZtcL0jVBj5rNo
         xOTMJ58lYwLpiqlXGGxUEUjX5v8T12/WMEKBCg/5x6hs39WZftLYqYq42pJEF6PqZGPp
         fHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464310; x=1789069110;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCIjIscWtIkW8dPpZdLR261CJFgI9Gu7nzQkjrvICK8=;
        b=LPv5OKxMZ9GOG1RKkoWXQ2/pRHJAoeDvee18zfHod5mmhCdC/LYCpZFjItxZQ3ERUM
         zEwdaK2PllhumfOPsR+hHLKDiaq/7UkACDre9NFpAac4+CUafmK0Vx+yi5upNuOj9RhV
         OgM+9vj/UGizx11ulfoR7HMD9HM2WRVMIHQGk7A5kYWDk2dJXULfCAbtrKYjVCP7dhkN
         Z7sN4OcnJJ/rLX61Ib55uYUXTTywZvERcN5CI1oM3NPqo0V+MMsDt5wTurCbY+EEFZXP
         ZKqXMsirKfLaZRBuieRXdXi4Z4fjoSkTpmQgLpgdyQq61PlVj8GjnHwgS9HEYufOL6ti
         xm8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwhQZv74Q2lyosuY5ouiK99YSWax6dFy4Egf7cI7IDTww21Qek15Pd0yEBHSTFXYj2WBcs=@vger.kernel.org
X-Gm-Message-State: AFuF++lLP5QkVVqzlvPpTFShVAT1tlTjT9tDEeTYWhMqmbbwm/l5pLkW
	+Z2E1mp0UCE9tNf4Qg1rAz/w99+pbKpNzeHqvI0fDioQSahmC68Ust2I
X-Gm-Gg: AYBFou2h3EMmnIjdyxd+Es0m1yeB2sf0MsFIcFwgx3kJOr+9Qg5Fuu/9L4wk8z5Pa7n
	Wjzqf6McX7eANUBUbBudrVeT1Ux5FS2Jse/3yPDCeUU09Qcl4YNAHJKKlbGJI2kdDVllhyjrPyD
	oRMiao6etuMVRL1DTdX/bsJHbCmZBq/w6ffbLiZHh+EOnRi1XKDCZjs4AY776IalWkRmc8BQz4v
	CWgKuREn6X/+FaEM4dR62F3EqKTiiTtcTPc0hXDjBqVXQXxwFEPhUVgXaVYIneyqms/+B+jGYWm
	s8TBoid/u2oR6r5hg+l5hHz8mHU983FL/Frgz5RBa/pnKxrrQbfiZHpTVCNdLuyaSpV1UAzud0y
	L2HAMQBFQVuxCZ1u8ozPY5E1GWqmYFMno7MpH0IOf7DQT4d1EKUdrPtXGICDhTu0FQkU/e3jV2G
	dv0JOYM0yZT/h1Vt1vLx7CD0gCI0fXIUNW5545UGPPY4C6X5T8gsMT6PiowRf9v4uzjFJsS2Equ
	KyiScag0ilL6ZEiX/hIeIF+a0bxFLrfIo0i9o8KJYEcKQ==
X-Received: by 2002:a17:90b:3a50:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-39b26101576mr1334269a91.11.1788464310367;
        Thu, 03 Sep 2026 12:38:30 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fe3c:fb36:dc7c:5b5? ([2620:10d:c090:500::6:dba3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm1345842c88.14.2026.09.03.12.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:38:30 -0700 (PDT)
Message-ID: <2f40ba155a98bd357ff5c1182308ce10a425811a.camel@gmail.com>
Subject: Re: [PATCH bpf 2/3] bpf: update disasm.c to print BPF_PROBE_ATOMIC
 as atomics
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, npc@anthropic.com, 
	martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
Date: Thu, 03 Sep 2026 12:38:28 -0700
In-Reply-To: <2ddb3272d086e995630c56ed4c2cc2cdec75debd5fff9c10cb0bfe8c0fe664ef@mail.kernel.org>
References: <20260903171542.1438050-2-eddyz87@gmail.com>
	 <2ddb3272d086e995630c56ed4c2cc2cdec75debd5fff9c10cb0bfe8c0fe664ef@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-03 at 18:11 +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: update disasm.c to print BPF_PROBE_ATOMIC as atomics
> >=20
> > bpf_convert_ctx_accesses() rewrites an atomic on an arena pointer from
> > BPF_STX | BPF_ATOMIC to BPF_STX | BPF_PROBE_ATOMIC, this patch adjusts
> > print_bpf_insn() to print such instructions as regular atomics with a
> > 'probe_' prefix (instead of printing them as BUG_XX).
>=20
> The changelog says the instructions are printed "as regular atomics with
> a 'probe_' prefix", but looking at the implementation:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0const char *probe_pfx =3D BPF_MODE(insn->code) =
=3D=3D BPF_PROBE_ATOMIC ? "probe " : "";
> =C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0verbose(cbs->private_data, "(%02x) %sr0 =3D atomi=
c%s_cmpxchg((%s *)(r%d %+d), r0, r%d)",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0i=
nsn->code, probe_pfx, ...);
>=20
> the code emits a separate word "probe " (trailing space, no underscore)
> at the start of the rendered instruction, producing output like:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0probe r0 =3D atomic_cmpxchg((u32 *)(r1 +0), r0, r=
2)
>=20
> rather than:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0r0 =3D probe_atomic_cmpxchg(...)
>=20
> as the message suggests. For the fetch/cmpxchg/xchg/load_acquire/
> store_release forms, this also detaches the qualifier from the operation
> it qualifies (e.g. "probe r%d =3D atomic..._fetch_...", reading as if
> "probe" modified the destination register).
>=20
> Should the changelog describe the emitted "probe " prefix, or should the
> prefix be attached to the operation name (probe_atomic_cmpxchg,
> probe_load_acquire, etc.) to match the message?

Yes, I should have updated the log. The intent is to print:

  (hex) probe ...something-something...

will respin v2, waiting for sashiko.
