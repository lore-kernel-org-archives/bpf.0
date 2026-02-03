Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216543D3017
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136456; cv=pass; b=fmFjIQ8fsDQChVJpBcDBYCd5HyNp+0JdJTEH5ORQHhEqmBVK5pEBXcZwcIRXUhszwb1aUUFpHFA1hl14w/n49c2de5kRcepAyanqk2s7ZbQqJXSursodZkXiEx0s6aIbHkWav2NjilzrUufzPk1RNQoczOm3pDTP702Mn2y54Mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136456; c=relaxed/simple;
	bh=bmwS02O7Xi0i3LCtAbnGeK3EdgJru2Z2vrI/HUuqlh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJMCUiwIMX2+rZjCU54EYh8KLQC68iIfySm4othksUnicpmthTwAxq4FjajL/msnV4sVdtvNACu5Nxa/dEuUcPIwBHlWWoShrbKmFhjpPXESx5HYDqkyt/E/oSYh0nw2zkppkxQAgdeDkD5F2uBS+DAZQkDeb71NEiTvF2MjOw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROKiYh3y; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROKiYh3y"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4359a302794so4012831f8f.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 08:34:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770136453; cv=none;
        d=google.com; s=arc-20240605;
        b=Fpz4rK86Xevi0fxWIl7AAYTV7JcXAQVLrq5ptlSXVLkNXA9NjKc+lMXv0UvBuBiTE8
         fGDvJ8X8Qr4MWPzmoxhVtKxwl+2b2p7b9j2fBRTglTvorSUFJTgQ5FySenGjRp+1lY8U
         0Im9rZAm/XuVymCDDkDDDgIUr7zuHnV74A6Se34bvV55uP/CqLpKeHukZ0gtdbBT+urr
         HQv4jCAQ4+zsuuzUeBAySs5Vt46jqvQHNPvuYXHF5rpBT9H6I8ykN2IIABCS49IWrUuk
         6EU7RIWfewF1KVx3EVMMGSFXPiQoFF8hlM3ZpNCADbaGBZIYXix9dkYxvDaUT5UXaPuo
         BzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nf1oryXgAVHjZvk/1Ujit1GezDamlVePl/4411gfaKk=;
        fh=Ke04bsHn2dfnVdrGyLgoc+QMWObZSNi8mjs0mKmdSgY=;
        b=V5FPI98pwQ5EcYAo76rxFTJbHu0RqSdxpBSRHcD2t6HpFUmS9p2ih/lauqaO3H+7oJ
         0Ch/AgITQAOEu4An8vM5qLFO4gCbf/SCCuFfJkGTPsneDtwjqd7WhmzTbpPH8oQv6rDE
         Sd08mzhYA6uYMWSR9dGs5c1cXNniQTOzT0W02ZGCxrxhS8Mra9HtiTLKDnCMZarrblv2
         s6YYvbSigbA95HoVPlkCgjPsPGdTvVdIeNBiZwSBZz0RtIfJn+3Z7pvX4nc6UDdYXP5t
         TA8mry//+fL1tnDCh2mAK451nuzTeCNb+aHOLLcQA5RjhG4/0YUNWrl7PaBs8waHny86
         Chyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770136453; x=1770741253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf1oryXgAVHjZvk/1Ujit1GezDamlVePl/4411gfaKk=;
        b=ROKiYh3y2/wez35sE3CtMZsUKlRfWEg3t15YY1aBUgmt+LbSguUMsRFV/kzdfi903D
         oGleb9H92ZHdDmm+ID3MluINwkVZReEfdDgulbme3JKKyCKjUBkIlP/096rhCI1jpP9O
         AZ5bbIxydTsglt+acNCaSW+xO8hzAq5HXfbi6WPJ3isORrxe4H9hs6tLYn3IQTwrzio5
         hgf25je7OE+NGjIzXKUsK12CrOtWNKp8mcs29EOIP0/8gfndW1nc3w1cPBVyiArh+feJ
         +zwdmAVTgt9VsVP8n1FDCLDbDJNwkiGrPZB3lJUtw3n4heOf8IHTk86PfdQfbkJm3k7d
         9rIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770136453; x=1770741253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nf1oryXgAVHjZvk/1Ujit1GezDamlVePl/4411gfaKk=;
        b=pQcMHYJvfDAGcOODM44IhCjQ3PeOnc3CAe6ZxgF2jPvcodaczqk4e/Iuc2NniEQA57
         UU/PCWAneGUALVltS4kmOAy9WayHnwmV7AlS/EJB0Yx/U8oIEBFAgClFTI77pMixZCcS
         w6QZeqA4yPkrVxR6w76eXyqvf9ys9sOvnQOfpuriKsy1O/dunGFqCDdfjiVTKPckeJ/z
         nFEZqL0OcVwtpkq1nYa16vfR0kTH848wba3CbK+kChfxC1gN2sFRh5zbaLTTdzUaclQl
         G9h3cGVmAT6IGvwyWsami0Uu41rMYdoMosGjF71HYC6QHDGAM56koj+0SW+GOrAi93nA
         nmlw==
X-Forwarded-Encrypted: i=1; AJvYcCWPuvfnL/ZB1bBljmr7HDs3HU52DPUsA5VPGjVLk9qoRK4UtHSelPh44zBlkvPGZuyXLpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPorXBJ+6IxOmd0EBd82e5L9ddSQjQvxNLOAa5PkLKg4op2Hrc
	DZXxWKqISifamS0nr27GMemT3Tiw46wJLqCaKFX0IKPKTUXWoQjSrWHjskF5Yp05kVFxyQhXg5e
	6Q3Sz7Zd2serdS6l5t1zsYLZ8o35VgUqURU2S
X-Gm-Gg: AZuq6aIh4VKsYomxnzfnW8/h+NkEPajnuwmk7GPX4iblVzjVZHVnXzBTXqgKN+7Io99
	Qs0IKjW4tzuZSdmVo05pvmw1lsEw1suVd2yUkjGuwLDU9WxWGpkJJkaiZfdA7M0ZhitrBJy8DVW
	+c9Xi0M7d+ZGFafkKbyMYNgUMNji//i8n6J6WVAKnVns7ItHVZW4DwFtlM79LcGW6pLczMUOcGh
	ob8xAWB0wBDd2h/s/Gwqe7WR6vauBzoUuwgmDuMR3hOP6cxzPaX3tzW+tldmR9OHYpX2ZUDEk4a
	p0s8Mpj730l/vri2COKPGvxF2wv/h6cQwfF7uRNGwR2/dNP8zQ7nEoVx6Q1Sk2TTWLKtXA==
X-Received: by 2002:a05:6000:1861:b0:430:fd60:940f with SMTP id
 ffacd0b85a97d-435f3a86042mr23293086f8f.14.1770136453481; Tue, 03 Feb 2026
 08:34:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203162746.2337002-1-arnd@kernel.org>
In-Reply-To: <20260203162746.2337002-1-arnd@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 08:34:02 -0800
X-Gm-Features: AZwV_QjtdNAcExIQQf3VFUMrTl7vDDynoLe0KaCwRMNFYo9feUcHlzrdWMcOD4A
Message-ID: <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing __printf attributes
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 8:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Some internal functions in bpf produce a warning when -Wsuggest-attribute=
=3Dformat
> is passed to the compiler, e.g. in 'make W=3D1':
>
> kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
> kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk' mi=
ght be a candidate for 'gnu_printf' format attribute [-Werror=3Dsuggest-att=
ribute=3Dformat]
>   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.=
bin_args);
>       |         ^~~
>
> The attribute here is useless since there are no callers from C code,
> but it helps to shut up the output anyway so we can eventually turn
> the warning option on by default.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This was discussed and it's incorrect.
Commit 7bf819aa992f ("vsnprintf: Mark binary printing functions with
__printf() attribute")
should be reverted instead.

pw-bot: cr
