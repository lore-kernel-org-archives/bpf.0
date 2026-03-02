Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A90175A8D
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772418275; cv=pass; b=Q/La3dPlDay8Sh72M2Q/JI4eARq9lE8pJMLj6DBR0VvX+1ve6ALEWGexi51URa3YU8OiVU69rreDHz9DbiZquqk0bYCbcYW26JbcZTI/HiP5jhMG0X6irUCaX4o4hiSMMnJEdyKH5HvVIsLaJtEIgGtq0c/RTK6Ad/75013gt1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772418275; c=relaxed/simple;
	bh=ls8YzzMu1lHwNDYBzxCJe6T3xmrSKYajel3OZEGjWFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oCYR1KXTs24MR4MdJ3+Yse6q0WNXCMEv2qiDQlsNjXr8JEKo6wcQqCVG3iFqz147pwiTMK+1nqrO+zT+L3Vo/WqRIMLpuT90nYRHwHGSr/l0FOM9gWIY3wKcRp/YszYaKBu4IYb4422/4aGgL4JFnsH0lQ1ilD2riN+xc9mOfgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy2CUt85; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy2CUt85"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7927261a3acso31534917b3.0
        for <bpf@vger.kernel.org>; Sun, 01 Mar 2026 18:24:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772418273; cv=none;
        d=google.com; s=arc-20240605;
        b=X+z31NG3VwQtGiO0h2hyvO4T+j2kQGlFFXTXHWCEjBnngx4jkg6ZccejHUDJfJdIpS
         FI96O3ya3F6aZf7GP4irA6wtOuF2KWQnviAWKh5l6TUPGKBy39XLtHC+y98ABS/k6auS
         f4UjMaTGWzMQuxciHgGNNf/UX38vPNz2niQmqwxJfYpgGY3iS9nCD6oWjkqLznf6KpLs
         gOPoo+JZVbybLl55kXpnwEl62UCil3t0tCWn2zdEN7mEcupnfugfUD33Ytny71LEanbs
         z1TdaHVfKbSy7vgQO5ftPwL+AneInIG/qsjCJZsSa+nB7+R1KWN8rTtcf0Oh6JccBfnl
         W4Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8/vdi2EDA5fJbaHQWlNFjBt8eNCftyyrrEKFU+E/z7M=;
        fh=/GyrciXAUw34LjW0qjwdkVBEH+5MZKpzZnxlO7eryJY=;
        b=Wi8YeDv3Y7yrq7U2tvGGAoHfIoB7GTqh7XiNYYFz/WKcG9Xif08lXamO3UMT8webOd
         MrJpA5P00jKjwFexQQkQ1DyBudDE9CppWFwVOeirj84/H1p+PyKq50SZZvSQZHg7lLRy
         0bBJtbMYMz4k3fcVX7GR/PbGzyZje0wfK4lCH13aht0CfjYtFi0tvHKVV9EOV1cdA4Pp
         lIoUF0Y9rEWvyhmR8iA77LPVOttPFWDteZNltwvEzUfXvMxF35PY43Y1r0D8rPBUwP4y
         K2+WzrQEX51aSe9RIKHifaDCVRhnqGhS0bjUq9c59ckmVqLOuPzkH8xCsfbDnuJlL/0E
         NJpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772418273; x=1773023073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/vdi2EDA5fJbaHQWlNFjBt8eNCftyyrrEKFU+E/z7M=;
        b=jy2CUt85GwGiwXSP+xbbU9XwZ7lgfKJg684N+ahaVS6pOZsNF0zQhZARbwUaDNELY3
         b4wGjwBqjBtsFMzKjOGTIWt4EFJtAW2ROUypAma2Ox+yJ/ZCFzJsg7cUrx18FLYDGPPW
         Mx6I9N/pD6XzMDk/9MuccpXutQTP1StlKwos54lJfQ8eVV36agEQbdRKDrzMPacljASf
         IASTXMSh62IvpnOBRwr4X/kga89Bvtg5oT4UBRU2AlLKutTbbmXlF7Y8RTcOEYW/ptGF
         dadhfbs2F36qkpKZwaZ7Y8eRL2KgsrGPe8t7DQIcKI1ZIK5Y8SwIY87cNm+VpdxrCFmM
         Gq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772418273; x=1773023073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/vdi2EDA5fJbaHQWlNFjBt8eNCftyyrrEKFU+E/z7M=;
        b=lTExLhD+xPdfCcHQ+uJ2p1fBOelRNQMmKNj+X9kNaO2LeDqy+qfwXd3mTUg7blILF0
         O5EHw9xZjpN3yGugCIbziRiiYduGMrMT5KKmTEsPfldhE0PCM/eNfUh8q569cjeHnqnA
         cBAixrp01JHYPpn39yjnIcVjVra/5/HBR++olypCw/UmKdcc3FvC1wnSau5i8H/0p3nr
         s4d80n8SLZUSoCvlWsiiRzAMYIHMk6UaiAvaWfkdL95VsgHcyNw6M2pJZdqkeAt95JDr
         vdquyazfkuegiTQCaKFpWh2ZCuxV9w0boGjF/XF4VllWJhOkip9KtUdqGc9gWkfmuEEI
         CAzA==
X-Forwarded-Encrypted: i=1; AJvYcCUzDW2mNFYm1TVgnHrEJEJkfGU/h8HKG+NTkJrslsNQ+QI4JPrP4780ZQmFDRKtRdA+bt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEt2offHYbWoFvU3v7sF6I3t8X27/4edBZeou5OUz+JHCb16jv
	NPQ/bTeujnJ40n18KOUGEwwLjmFzHRQxWzlrF9vBF/pILoFuB2gAt9HQJop9sVWDl+1KS6N/gHm
	Dyvaj96JzScpEod/0sawTvDh32TZtG6w=
X-Gm-Gg: ATEYQzwZ57Deb9/dFIwZANU5A1FKlOXZ+OV9H5+rEt+3278jMtQ6RzkuUsvwvuVwd3s
	AkHfBJOiguMl6E5bLPMjvjrv/W1l9QZ79xVc2NvGFsD0pn85826n/up46qneSaXcl/KOrPRiUof
	L/qf8SrnmOoY0HupRCu3LxctiqwMrJIijWSLczyMbBHvs7qtW0uvo1SeGyEYjsW7OhQyJILsi0Y
	yKltGePtXzeZaReBSxwd8qY8iOF9J0nctkXV/1CdEnHXbqzSONmsUc1G2eHvIWki+KKTmg6GdJ3
	kHTxr2kA
X-Received: by 2002:a05:690c:305:b0:796:6784:82cb with SMTP id
 00721157ae682-798854480a1mr104027267b3.2.1772418272925; Sun, 01 Mar 2026
 18:24:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227164037.84110-1-sun.jian.kdev@gmail.com>
 <20260227164037.84110-3-sun.jian.kdev@gmail.com> <DGRPNT4T4EJP.1USTJ2K0RETA3@etsalapatis.com>
In-Reply-To: <DGRPNT4T4EJP.1USTJ2K0RETA3@etsalapatis.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Mon, 2 Mar 2026 10:24:21 +0800
X-Gm-Features: AaiRm50bWAoScEl0963OCyaEyX-J4DWdqalf5QfF57SFt0awxx-tVDZNfgpAyFw
Message-ID: <CABFUUZGOxqO1ev=e8EdtsZxB=rnjHGgu=YoHXG-nq0XvoqX6mA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/bpf: bpf_cookie: make perf_event subtest
 trigger reliably
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 3:59=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.co=
m> wrote:
>
> On Fri Feb 27, 2026 at 11:40 AM EST, Sun Jian wrote:
> > The perf_event subtest relies on SW_CPU_CLOCK sampling to trigger the B=
PF
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>
> Nit below, but change makes sense.
>
Hi Emil,
Thanks a lot for the review and the Reviewed-by!
> > ---
> > -static void burn_cpu(void)
> > +static void burn_cpu(long loops)
> >  {
> > -     volatile int j =3D 0;
> > +     long j =3D 0;
>
> Nit: AFAICT most of these changes are unnecessary, you could just bump
> the cycle count to 100M and add the barrier. Moving everything to longs
> and factoring out the loop count is unnecessary.
>
Good point about keeping the diff small. In v2 I dropped the volatile
and added a barrier().

v2: https://lore.kernel.org/lkml/20260228074555.122950-3-sun.jian.kdev@gmai=
l.com/

I kept the loop-count parameter mainly to keep the "long burn to
trigger perf_event"
intent explicit at the call site, and to avoid  hard-coding a large
constant in the helper
if it gets reused later.

Thanks again,
Sun Jian
