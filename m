Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830383D301B
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139495; cv=pass; b=NprhP9BBHkGN5qogDbxs274x0iGYNuPqAVNqbEjV+pRqtZl3lBJPcLemsiTnzOci/nflk05Yh05x3XxOxve0L6K0knUkV2B9aHj5q6ft6jtsVcQt6D7UhcrzXo0fXjktyvjPQFErhxzEQYgKvv+BZWoaUhyGbMPqIAT5v2zF4f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139495; c=relaxed/simple;
	bh=gnMtZmchYRzH7dNslEFA4stp+XJm4brsj9Vj7PicmZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwYrhbmTlvcF+TEWOKIWmWoJGjPBZ/TbkqiQnO/ZnTU74TDWfx1HfpPqeflUKBa4B+v3yyM7SCyWCLr633aNwuRwHS+fSTDSaJuMjal4US1Mvyle9CBwIJWujV8fx0Tt48oPV02+u34In5baoPfUWjy8drkAp4rZdgHIpds6fcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHZ03lJF; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHZ03lJF"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so64629345e9.2
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 09:24:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770139492; cv=none;
        d=google.com; s=arc-20240605;
        b=fOwH9BfkJl5M6cT2MkJPrz93xWiHVJmDRam9feaPgnqTq+avlZGAMac937pM8+4FrC
         vuFyCljMm0WWL4DxxMu1CSZFDrPHKNP95KaQYG9bs9YGz1+2qHlXgRxsFVibYyq8gxay
         HjYGaOCOFTno0fvJIxhuoIM4AWS00MzM6nKmz63vduhPTKPu17Dsw5wX/wdyAtUt65jI
         wWv3WpFyC1Oc4lEaeUTCMVEFH1tDIcP7I5f48yWCyxN6HHqYV8fNWWIdUEEuGfPU9K85
         zyFP0uMgbKBrUY2nFR1wG3JIHVVHHEAc13o+mGPMPf+U8ctH9frgibWdK7EZp8NMSjFH
         ZxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3L8PeZHd5zp2j1+IrITdToEQMOA3ng6s8kKooIY7hLs=;
        fh=H1mZNbz4lDlTFNW42fNo929LduhtQO+4vxm0QFT8x+I=;
        b=OykPLrT+c7zAvYWQLhWHkatJbO61fVw218wyQCB+RjbY89qMbHDT/LmhIrW/tCVPJj
         BC0imPvq1bQYPe2j/a7LPYdpPHyHsN/abjpAUBOG37dqzVkVkRVjUHU8VOZjsessWegk
         U9acJGTo/sx1PDfxZnl9f9KBuc4GuTswtRURf1LZPq18T69LRBqQG1bMxaK95f4U+8ST
         gCg3Nsy/1GdOoElSLobo8jyq3fPgAoOaU/EOOqOFZCGArAw/ojioAfQoxgpYwJiHaLY9
         CgJb4bI9rr5XdtCEsesvXzhXRGwFS/pg2cTQ5UyZ9dq6DNGLpOZvfB5+AtdTp+XcPoJb
         /Y3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770139492; x=1770744292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3L8PeZHd5zp2j1+IrITdToEQMOA3ng6s8kKooIY7hLs=;
        b=QHZ03lJFlmtMqhr7Hwglf4I6eqH2x5GdtUUWjn4lT+Lidt7Db4o9TjrGGKpVXb7G6M
         g9s5RQ09Q4ksNdyTjcjbF9uhPMAlCUxHSiBQJ9pN43UfhR0SBynMzMedXLG4BAO8r9U3
         glbXYlMt74cgfiWefbdVzTwBl4zvUHmFifOOm6EmElfj3/t63shfKg3eFsfypJy6n3CK
         KVplAi2CzR9FYEWSk8k747MRjYAFn0KTvp036oAW1Zjn2Wnd2HucK1/JFnbcfHANBpDv
         9AN/0nfvXX/Mey5eLia5YOYhoL1r9KAglLaT5eKPvFXHVtc681DB33cZFUScVSpwcMAZ
         U7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770139492; x=1770744292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3L8PeZHd5zp2j1+IrITdToEQMOA3ng6s8kKooIY7hLs=;
        b=wnY8Xy8mABYMBLaVfA+PCyJLU+kbZU19f6oZX9CLibBxB8dQEulzBzzSJJ1d/o8CmE
         qbo6q1MJQ/yR/SB2jhfGmUapkugsFRPIywbKyX3couAC6ZAvcQwhJ3nfKtFjSNEsczev
         TJvDhzXTFRUZ2DmNn9YITIQXvuRpD2tvzNUpQYWW5Z5o9LBxsSxkFOQuMYN+GIFnQKwq
         WVyuZJCISJoSiYVd6RIsqtVdi46Kq+XusX5uBaVNFfOqu9CkPV0PIQNr6MuNZ7x1GSo2
         tjYnE74m+minE76Cd0xiQkE2ugftArU5xPSp4Z1LYlb2XfvsU3JHWdMBrgdcdt2Oy5UH
         XzJg==
X-Forwarded-Encrypted: i=1; AJvYcCWKPVMNhqdGMbvkOkG4iUbzLYLiE1CqwbmlChMZE9u3j7P407cQTK/7H7ZbJ8mmiSLFZ8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF37KvQV5M0Bt2pwiLHAkaiP4T6zE9aqqJpvGQEfB1p4M4aAbf
	0luqtkHo8rQcarsNtmqIrR9G7wwarj7Z4biWo/fh7FjciU4jLk4FEaK9aaG9otbJ1dwNkz8uujY
	H0GSnNQdnurrmSk4/HhI248EafxaQFjI=
X-Gm-Gg: AZuq6aJJEGkggGnmvAvS+XYSqgvoTIzSU50cXG657Xr+jxskA/AtBBb4luk1B9R8VLI
	pSxxZA1mHrKHCLLkmxJrlxiTp0ztwI0r1tCCoYs+iLONgSMEaKmVD7IHv5KUTqeDmd5zj5ZHeUH
	KaPrJ6VOqXcKnd4zbtyLrHS8hr7fxnLZx2Ik3WOdyB0DywYm6Ux5ChO06QtrtuHaL1ILimW26gM
	1/2wDSrO8LP169Y4iQrtnta3zGTApTth64GhXarJUvFSJibUbQJ/FknElc7smrJ3WM3ITHQhaNJ
	mhXEp/oG7X00GxktpCWUA1QIFoLzp21Aw2cH8B6AFe6r0r77ZPfqXuUSgY9/Ns1qjupIiQ==
X-Received: by 2002:a05:600c:3488:b0:480:f27c:6335 with SMTP id
 5b1f17b1804b1-4830e970950mr5148595e9.25.1770139491825; Tue, 03 Feb 2026
 09:24:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203162746.2337002-1-arnd@kernel.org> <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
 <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com>
In-Reply-To: <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 09:24:40 -0800
X-Gm-Features: AZwV_Qjq5yJ89ITMl28f2X126VP0vq1wVQ3IBzfvB52Lw1A-jsn_Ewvvp-lFM9A
Message-ID: <CAADnVQKn4xP9s_koBuP7D_eqUX0dSPwUr-dOj3mTZNTh_VxqKQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing __printf attributes
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 8:58=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 3, 2026, at 17:34, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 8:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> =
wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Some internal functions in bpf produce a warning when -Wsuggest-attrib=
ute=3Dformat
> >> is passed to the compiler, e.g. in 'make W=3D1':
> >>
> >> kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
> >> kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk'=
 might be a candidate for 'gnu_printf' format attribute [-Werror=3Dsuggest-=
attribute=3Dformat]
> >>   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, da=
ta.bin_args);
> >>       |         ^~~
> >>
> >> The attribute here is useless since there are no callers from C code,
> >> but it helps to shut up the output anyway so we can eventually turn
> >> the warning option on by default.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > This was discussed and it's incorrect.
>
> Do you have a reference to why it's incorrect?  It seems harmless
> and gives me a clean kernel build in combination with a handful
> of other fixes after enabling the option by default, but I assume
> I'm missing something,

because it's not a printf format. There are no varags here.
gnu_printf attribute takes two arguments:
format (archetype, string-index, first-to-check)
Also
"GCC requires a function with the 'format' attribute to be variadic"

> > Commit 7bf819aa992f ("vsnprintf: Mark binary printing functions with
> > __printf() attribute") should be reverted instead.
>
> Reverting that one would appear to introduce warnings elsewhere,
> so that would not be a complete fix either.

Somebody needs to root cause it and fix it properly.
Adding more incorrect annotation is not a solution.
