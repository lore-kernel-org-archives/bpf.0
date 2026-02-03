Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BE136214A
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142324; cv=pass; b=Fzu3bOt6fSMfezBM9TPlbLbl9re1REtZBHdLkyIVssHoYYuros8s+qb2tV5d+VEmxnhW5DQTso5o4U7eEhHB7397jlg2GBofg3/NgPXFJBnaFuVBxgGo0Pb5s8hJLBuTulrtl7PoOg+gfoMtLwjJ086BNvugU2uvKwuXlPXXq0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142324; c=relaxed/simple;
	bh=NpuDJmf9DozXZ6B5ju12xAyZBBYveiccZy0i1uvwqA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fw5DbvTgGKhQYj4mgdP9iYPs3rIGy7/CnQn/ZnlartjVYZSnlWb0qNEznhk229ELUdPyHUS8E8beKwgBmnPN8R06ZMRTwEGD1W455q2fS9JQGTfjbebx+lPI9U77/oJdXD84E9KobcFzX+O/xw/N0o8uXswmw0VCkVllwayTmbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbParNXk; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbParNXk"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so4112577f8f.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 10:12:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770142321; cv=none;
        d=google.com; s=arc-20240605;
        b=XvbfEXvAxcYx9ZXkmMNSjHz1wQIPaGCZ2W54nHI0la2L673BJNIvtVFSjUdH3h/TB+
         LZYcKYIhqPeLtfKw+f2qQWKs8Ian+wzEgaR7CsVaVL4qrMBylpSn00q92c1H839A1Dmo
         ekuIJ0XmMWjyw2+LfHSRnvz3gbWfKQe2Vp/5BW09ZRBB3g7QkgyPXor6zxWZL3hNG7po
         6H+XkvqFtalp6iY8BIlnjxG2KwhGDsqeiZqifLJgXjZTdx6JTjASu+EuOGpcu77XM/JU
         QPeI7O1oGkM84ttDEoTLJm8ycOLA8BnqoKdBrTffZtmAhqt3lR6kKD65OMpobZV7wF0z
         THlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VX7w+kwRBRr6oO7XnjzeKtSVTEgDapRmL9gbLdKDZKg=;
        fh=j0pizyzZp9uS9gCFgmFYlMctwKy708T5Tli0bC2C890=;
        b=iJQzGN+5XZiMUrT3r7NtdQfBTQXFZ7U9JeOdtW18F+9AZqQKakrGDXZ4taVXPr2lQK
         MEJ0V9e9TZ/vD0d+cgzzCA8uiaqNXbZree1tpC5b0DNzum9h6a27nCSfYxNDM27aH+v6
         qXTjip0ZDdGv0DhrW9Ti7bCq6vmWEeoHf6TlUcKJb0D57NlHW8jySHhBoOFFvVyh0Y6t
         z4KWt2FqecFbyeLGBMrLB2B6fQxFV6Km4OVpXBZRYRdxFYxzrNkDIZe7FsgPVPr/BoXA
         D84ejao0JELVQGphhtevAHyTCH19nmnc5hhDk5vivxkzLyYesMmBKba9errm1g8Ntg6s
         bQNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770142321; x=1770747121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VX7w+kwRBRr6oO7XnjzeKtSVTEgDapRmL9gbLdKDZKg=;
        b=AbParNXkxhXotPSCDV40Z7s8dTDEOlxRgRgB4x8QLXnNkSxLqgeYdKFvJbrRx5kIxX
         3AKKlAXYD3mljFsW+Gb5UeM6wIf7Cr+MX/YLpwm/an/p/aemXwUku3udmxa10vcuQnAV
         n6dQdZSMuaXQoz6wB38110FGBkOeyDp0IgrNwESciWT2ncr8Lpcg+0x5f+DzMA/FN5cq
         2MGEcU0XMSY0NqSZHNZ8YNgKBo6K85I8n099ZITc5nLPSqdV53jYm9TmJZj7j39ck3k4
         MKjx7iSz/tkLSKR9wpnvu1yejbf0v8+QR87EibHaxqbivjeauLdKzQtIhXf1/5y9uvfV
         PgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142321; x=1770747121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VX7w+kwRBRr6oO7XnjzeKtSVTEgDapRmL9gbLdKDZKg=;
        b=HDERyq6hGdYO73Ucc50R1LFVMXxoYyfDFHjV2j6Kyyu//cHQMujLcB37o/BaiJB4t5
         HOEctYtg0DWOAxxBsxnBbBrNFYUEnwRZdWwGdOLQkLdetXOV4S/ouWAppc8fwha9s43f
         H7ABZYmkNe6RTJ93Dpmfg6kLXDgiJx6kni9GuNe10LPIkbCJDitjaruJWYVhq5vR8Qwb
         Ge8KmvDKJy4DsiAdAVtplBRIbU1udzBIJPFU/QgTmLbCIuYeg7CK3wiXJlDMvcyU4mnN
         I04h1j16DJnrqQySwfWm1MF2SsoBm9K6ESlimReIA1zQov8dqmTA3eHMdURfboBt5DNP
         KypQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxoPTvQ6CCARVeWnbgMW7V0Et/aWPgN1oyiBb2iftxfTqIbD/ROGC6K/O+lriNWync+ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2RWg570fBeCAWN7CjCJByqEa2gDKPkOYGr7G+pa9b6ZRGviN
	o+8zudOPmTIvDxgN5+mKTIspmUEkmhuvxendO0Tjw9iatKRo3KWi06NR/a0Pt4fswrERYF07a5p
	GnJy0RDhnKZQKs2PCDIhpiz+hUXtxptc=
X-Gm-Gg: AZuq6aJVmtqUC+A009Aa/EUC2oJqFN2dL4O8rOnakmn3DLMY8ZCC5I2Dl76ZGyre+2z
	XwaP4T0XMw7rKiRLSR91SAFF+A3qrAbPatx2vz9W1sy2umEjnaz2axkA9ckmrtAZLegjfnkdMW4
	RIJhHEj0jilKbYyOQXscUzM4dNSFdgMgI4OKfTva8XsO93cSmcfPgDK9AD9tTyVHPK5QZHqmp2U
	cBIyqhGniAAeM/J8rTDyP2qHvZRcR5SPeGMUnPjLGP2rAKpMSsQyyotVWwWpVUK9tjqBVp7IKva
	/MFsveMWcFKLX8ted6x4jTungBSVoAHrBdQHMMjSUuV3vOchf3szNnzpskuhqDjOI3jhRA==
X-Received: by 2002:a5d:64e6:0:b0:431:2cb:d335 with SMTP id
 ffacd0b85a97d-43618053b98mr288083f8f.34.1770142320658; Tue, 03 Feb 2026
 10:12:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203162746.2337002-1-arnd@kernel.org> <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
 <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com> <CAADnVQKn4xP9s_koBuP7D_eqUX0dSPwUr-dOj3mTZNTh_VxqKQ@mail.gmail.com>
 <ab709a00-3a7f-423f-9d8b-b2cd17fef76f@app.fastmail.com>
In-Reply-To: <ab709a00-3a7f-423f-9d8b-b2cd17fef76f@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 10:11:49 -0800
X-Gm-Features: AZwV_QgEx7To_odlcruGOiZCh_TUFGZ-bIKhZLPkiLhLR8oP1ufpcANIO_qNt0Q
Message-ID: <CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4VReqAJ=68PaaKYmg@mail.gmail.com>
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

On Tue, Feb 3, 2026 at 9:44=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 3, 2026, at 18:24, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 8:58=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >> On Tue, Feb 3, 2026, at 17:34, Alexei Starovoitov wrote:
> >> > On Tue, Feb 3, 2026 at 8:27=E2=80=AFAM Arnd Bergmann <arnd@kernel.or=
g> wrote:
> >> >>
> >> >> From: Arnd Bergmann <arnd@arndb.de>
> >> >>
> >> >> Some internal functions in bpf produce a warning when -Wsuggest-att=
ribute=3Dformat
> >> >> is passed to the compiler, e.g. in 'make W=3D1':
> >> >>
> >> >> kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
> >> >> kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_prin=
tk' might be a candidate for 'gnu_printf' format attribute [-Werror=3Dsugge=
st-attribute=3Dformat]
> >> >>   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt,=
 data.bin_args);
> >> >>       |         ^~~
> >> >>
> >> >> The attribute here is useless since there are no callers from C cod=
e,
> >> >> but it helps to shut up the output anyway so we can eventually turn
> >> >> the warning option on by default.
> >> >>
> >> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> >
> >> > This was discussed and it's incorrect.
> >>
> >> Do you have a reference to why it's incorrect?  It seems harmless
> >> and gives me a clean kernel build in combination with a handful
> >> of other fixes after enabling the option by default, but I assume
> >> I'm missing something,
> >
> > because it's not a printf format. There are no varags here.
> > gnu_printf attribute takes two arguments:
> > format (archetype, string-index, first-to-check)
> > Also
> > "GCC requires a function with the 'format' attribute to be variadic"
>
> My impression was that at least vbin_printf() falls into the
> same category as vprintf(), which is explictly mentioned in the
> gcc documentation:
>
>   For functions where the arguments are not available to be checked
>   (such as 'vprintf'), specify the third parameter as zero.

Not quite. That comment in gcc doc is somewhat misleading.
zero means that it should be va_list.

Examples of correct annotations:

static __attribute__((unused, format(printf, 2, 0)))
int vfprintf(FILE *stream, const char *fmt, va_list args)


static __attribute__((unused, format(printf, 2, 3)))
int fprintf(FILE *stream, const char *fmt, ...)

A comment in gcc sources:
      /* Functions taking a va_list normally pass a non-literal format
         string.  These functions typically are declared with
         first_arg_num =3D=3D 0, ...

Currently gcc doesn't go deep into va_list to validate them,
since they're likely not compile time constants,
but that's the meaning of zero.

> I also see the comment about bstr_printf() mention that it
> uses a vsnprintf() compatible format, which would indicate that
> marking the format argument isn't wrong, though I agree it is
> not actually useful if there are no callers that pass a string
> literal.

In general I don't think it's a good idea to add nop annotations
just to shut up over eager compiler warning.
