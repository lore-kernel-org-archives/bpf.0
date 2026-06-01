Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD535C1BD
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342369; cv=none; b=gHpwZKQQ2+mfWFKDa+1EM4U31cn/oJ6v0pkKMNNflGo0ECi0XChV9xP4QI9nS0QgSwLU4YAE59bVNl0apTE+9mL2ClLfzVr5iJjHR5haOpY4ZdIeSezjrUl2hBvWwcmC3n3IX5FZ1R8oL12OUbFTlwXwHtod1AzJjswBsupEK/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342369; c=relaxed/simple;
	bh=uI9DbOztookQPi1QWPJTS5KmX6M4fBE1cxesgsindMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YLc6bDmBLoTztEBdwEH0JFD6xnjcwvZle8UQCQH0a2Mlg82F4Sjyu1G+4oXOql25eD7Ty5Y9cL7pFyzFY/E/OGUFeYz0CMxKb7M+V/utyfpIe4iqNWaNuG9geSpbbnCcB0B09P2MN9uKkKqkGUoOlFl2kCfaupJtsX9s+Jt9Ra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1dlb21V; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1dlb21V"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-137dd523634so2588551c88.1
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780342367; x=1780947167; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FmqPrAiaAyI+otBp62Udjj0SCzt/zY61VVnyRHk6LmQ=;
        b=L1dlb21VHLzaM96Gn9tmOCSJ5IGasLVKXuzutzOsZTQQe8706CTVgt4K5zaeKreIIZ
         WtKI7BXgXHUb3CiyacFG45FK8ckyFolEZzYqEwQYxwc8ODf4qu9LTUm48McNbV6ZmnPM
         5VarzM0cLyGM+NbL/0YttI/eZpnkuqB0GAUQ5qJOtFODOcHU+bNSAEKHJFkfK3CWHMT+
         H35AdnPruPZKbwuiXkoRvAVep44Pc/qh5/+JEC7AJjcWR4cxd+hPbIIR6eAkCdR5q3lr
         TiHKZEnwyhuG+D12+ht1XIep9gJHNtr3ctdUxXGrEQuu+k5k1cKKZULMDiX6JWyvgxaO
         ZvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342367; x=1780947167;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmqPrAiaAyI+otBp62Udjj0SCzt/zY61VVnyRHk6LmQ=;
        b=DbnAQicCI92vFf6CMV5qpNW9yyrdugAF1MGkf8jO3/G55uUUMfAzVKAo7pEO4yq3FN
         do9so31iVnci9Qvsg8DRHLbYVlEsJj6LmmkWxfpqH4ZHbNI4Hb9ynwRg/fDZQ6NkaOcv
         Dhd+mIvbhMYh+NqlCwIbRBfpXWLV6lKnj+uSXVk3BQJilNMhfvVD0d0Yj/QtdIRMhcWV
         SCvw3Gy38kcsLz3nO/t3wsewnR/V5+hAQeEeQ/mQ1fezFzd51QPDVmBkkOR+Wq1Ho8qJ
         i4DVkSvVtaFG83apddNbTDLpqNzcf6K4uIFihx4DAJ6ExPVh7pgiuGGSTqwdxUPyxXwC
         PyYA==
X-Forwarded-Encrypted: i=1; AFNElJ82JIYORv3MlO/uKqmxI5cZ6HE3ba5WEURYuM2J8B9Af1vZgGYEu9PE2ZzqGuKWqJQRA1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDV659meJHzyc0lpzTkLORQT5l/IKiEmNGYekAAq9TllpnXAA
	JAIoojJDWgQKqW2vxqyjIng6RO6XqhtSerF2W1ZQL23FCbyQfnh9Aa81
X-Gm-Gg: Acq92OEor8smkTlNAbf++kqZKUZnjlLscdV0v9cdZolFRIcyLQ5wavPXoqFvhaQoLTs
	QLczCuB7uMSPBup1ZIAm/jSBhdX6UhHIkkM5Mqp20ioZHfX264jN8gYrmKdP9t4uNDtCdsOdsD5
	GQwECiv8JnZiX7CeZWs+GrC9KgwOxiF3iw1bhkMXbSlHfLH9Ri8q9DqoQFgcAxuPxtkJQo//6+W
	qtdD5ZvdIo6WDt2W7gIO0LlJi95KCDWDNf+4O5x8+my62Y4vFkvrAGWxaX1xHkv4yhHwSg91Bka
	BiiTvXJtzy2s9bjuEqMxEjoCqFPL9FwUVcf2Z0QUdaqcg8GtF91/rvgznEoO67n3PGSyEqFRo4Z
	n7cNDaAUsj0bVvolGJz8RdCA1elTNnRYDpF2CqcmQBofhibfNpUTpACgFRO2dTPhTD7d9yndeNm
	hTf2IIOGDDrOiS17CTeGPzM+K+1RMVLRsovBW4560MFSlRxLVsUApPmWZm2iYi3B2ls0AzZRU3+
	K5venu1Ilgx/A==
X-Received: by 2002:a05:7022:e03:b0:137:6781:7dd4 with SMTP id a92af1059eb24-137d3bf3c9emr5514136c88.8.1780342366978;
        Mon, 01 Jun 2026 12:32:46 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:af92:b4b2:3f30:fe90? ([2620:10d:c090:500::96])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b37cd5basm7662619c88.8.2026.06.01.12.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 12:32:46 -0700 (PDT)
Message-ID: <535798105630b24033f33f532051b93dc853bc0d.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 chenyuan@kylinos.cn, 	daniel@iogearbox.net, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, 	martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, 	martin.lau@kernel.org,
 clm@meta.com, ihor.solodrai@linux.dev
Date: Mon, 01 Jun 2026 12:32:44 -0700
In-Reply-To: <a6d10d44ee132d70b2b2633790663289af944fd8d3889440dfc55fea04c5a2e5@mail.kernel.org>
References: <20260601064611.807637-2-chenyuan_fl@163.com>
	 <a6d10d44ee132d70b2b2633790663289af944fd8d3889440dfc55fea04c5a2e5@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-01 at 07:42 +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: Fix kfunc implicit arg inject type detection to prevent invalid po=
inter deref
> >=20
> > When a module kfunc declares an implicit struct bpf_prog_aux * argument=
,
> > the verifier must identify it so the kernel injects env->prog->aux into
> > the correct register at runtime.  The original check used
> > is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
> > module BTF type against vmlinux.
> >=20
> > Root Cause
> > ----------
> >=20
> > This issue was triggered by pahole 1.30 generating module BTF with
> > incorrect type information, which caused the kernel's distilled base
> > BTF deduplication for modules to fail.  As a result, the module retaine=
d
> > its own copy of struct bpf_prog_aux with a different BTF ID than
> > vmlinux's definition.  While pahole 1.31 fixed the BTF generation issue=
,
> > the kernel must be robust against such inconsistencies: a BTF mismatch
> > should result in a clean rejection, not a kernel crash or information
> > disclosure.
> >=20
> > When the distilled base dedup fails and btf_types_are_same() cannot
> > match the module's bpf_prog_aux type against vmlinux's,
> > is_kfunc_arg_prog_aux() returned false and the code fell through
> > silently without setting arg_prog.  The kfunc then received whatever
> > value was in the argument register and dereferenced it as a
> > bpf_prog_aux pointer, leading to:
> >=20
> > =C2=A0=C2=A0BUG: kernel invalid pointer dereference, address: 000000000=
00009e2
> > =C2=A0=C2=A0RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
> > =C2=A0=C2=A0RDI: 0x000000000000046d (stale register value)
> >=20
> > In the observed crash the stale value was the process PID, causing a
> > dereference within the unmapped NULL page.  However, an attacker able
> > to control the register value -- for example by writing a BPF program
> > that explicitly sets R2 before calling a KF_IMPLICIT_ARGS kfunc --
> > could redirect the dereference to arbitrary kernel memory, turning
> > this into an information disclosure.  The fix ensures the verifier
> > either validates and injects the correct bpf_prog_aux pointer, or
> > rejects the program outright -- no silent fallthrough that could
> > be exploited.
>=20
> This looks like a fix for a real bug, but it does not carry a Fixes:
> tag.  Should it point at the change that introduced the implicit
> prog_aux argument handling, is_kfunc_arg_prog_aux() and KF_ARG_PROG_AUX_I=
D?
>=20
> That code appears to come from "bpf: Support __magic prog_aux arguments
> for kfuncs" (Ihor Solodrai, lore message-id
> 20251029190113.3323406-5-ihor.solodrai@linux.dev).
>=20
> The merged SHA could not be resolved from this repository, so the tag
> would need to be filled in by hand, for example:
>=20
> =C2=A0=C2=A0Fixes: <sha> ("bpf: Support __magic prog_aux arguments for kf=
uncs")
>=20
>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/267401=
41551

The robot (and b4 utility as well) is confused by the following
formatting quirk:

> ...
> Fix
> ---
> ...

The triple dash marks the start of the diff section of the patch.
Hence, when I apply this series the commit message is truncated after
this point.
