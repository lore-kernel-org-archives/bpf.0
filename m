Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F51331196C
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134462; cv=pass; b=jufO6dHAt/h0kztr5wl94EXKKHTtFShJNZwBaYPVNocVnzdpYVwihkF6mi8p7MhNmFu8npOcRRBGctrnC6GUpYTUgPz3ldcee7AcYloRtXLVffh/ZE6OOVFZq6KvGJcdKE4VPYG4XxAY0fU6wtTM/dmznQIxJGTHzvNmhlXTlGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134462; c=relaxed/simple;
	bh=deO57hxzyS5UzkvPh4r4kvjZmU6hULG6xhnk9q4NzV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGq/dcqAbCxBmRBG21vHM1SWIdu6EKOF82aKVFA4N/YdUBAPgf7sDBFZWSsWSOt+9IMVO33q367K/u+Y6sOnY9C2kDjdTT+bkiV0xN9iqRmJ7a1EljYaYlL4/yMXtK9qoRf2YIgmEGwIt89wcWanINus6kqJ+ChvdgloOJrzWPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ8ZUjAh; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ8ZUjAh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806f80cac9so31796145e9.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 08:01:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770134459; cv=none;
        d=google.com; s=arc-20240605;
        b=jPLjZUwZXlSCR9rMigj043DUlNPi0u9KAa1FqFNEJN4wj3Wo4aPO6gpbF4ghuxtfQj
         LGwZN22oICr0+KJLmu10kjSpuE8t/rhbFsYVRWFTMsBKrDUnTvCLzD3DvThM/X0P0djS
         J3s3GTckVHADESNbI+JkqgrdNDBRsyWOLb6S6Om16T5a6u2URUGzSACNkXj83ykv/Pf6
         1xRYBMc5IYuG2vO0dz43YKTGGgdTBkdTXoRZNjaqmxLzMf8aQSpo8h1XD3a8pKWktxLQ
         KGN3TiPsDipyv4AaLS8vhcNfcOb2iJ9qKWa/dXXp1XvEFEZ40Ay+X1b5X72UDTXaf1g2
         CjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A0rdFZkSZwICcKcvSlfIIEDfERHEMj/nUefLkALNSBg=;
        fh=sxHj/QCMbJ+QcPj+jSygk6LTnmbJsNo58ZkoTWAZMNg=;
        b=cDZ9ciM+XJBW8EUO0/oujuhSn/P/P5dSqFhjUSFaQlNqRiU7FG8i2drY9OVcfxcQQN
         25qb+Z8o0HXossWyuDF3co4vo5pn5wuHPqVZUut6+u5PxqPSYZlvY4xERpAqLY9eAdLq
         dRpQ7MiX+LeDZJ9hB9DzeWWT/POCuxdWHI9n52FRaxEPOiISZNKIVzkpAoHGzLgL5my1
         PWZmD+Yk2eldhh9yFaTDHdQVVbpknXe55jqWfrAKnbJAtkUCh1ceg+rc4n06G+NXduAh
         5KtYRCOUANdicbhJXN5jz2A7gzMMAiYZGR3Pqw9Dvpal0yO4NAVr+XMpvRff2/delHl+
         Y8dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770134459; x=1770739259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0rdFZkSZwICcKcvSlfIIEDfERHEMj/nUefLkALNSBg=;
        b=nJ8ZUjAhc6eyDne25zx7/5W93JUZhndR2w7dRdvcwKJ20B2SZTtJsT3anhwAUAJY1Y
         GKHyuGWhVkkxs8vO6/apwmn7lgHC4dAPihLNgQ+vC8RxF4OKpqDoS47K0MgWtwSfw6G6
         7Lzn38y3HWegvH1M696KA1i5NKKW54nfXOE4JErIC+dwESBKMbkN+7QlAARvXe3UwjTv
         aZJh668ldT7M9WNPL/PHnk77HGZyj3WbRgYtZP6DUuLD1pNkjOeBwxUajylodKmpMdsD
         33K7msICw5VnXr9rbYEr2pbPyXXqb+kgH94YAsLC2dxLJLfSB+xOC9xlDz85E/uy0TIi
         NIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770134459; x=1770739259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A0rdFZkSZwICcKcvSlfIIEDfERHEMj/nUefLkALNSBg=;
        b=gjBcdWyPzi8eBkhiHWirBCgCahj7UCGyhacj/Q+iDc6EUYmypZ+ajJygCaDlZUsIaV
         A5uW9ZMrJ0KhocbAtVGKxf1MM6mZzqEJSoWFct/CuEqVTsfQfS1h4ROrJdKebtDnj1KX
         CAUH7rKkQsKiHEiO6rKk8TU8DgnlZZt/ovaO2VONJY4TOR5ENhD/ZlB+ycR12GYFHfFO
         Le+vytkoZb5PeMKHwfi9dztzFvA7komvhp3x6uE7jzzifuaSXslZFDd6Pwo4KFTdN782
         Z53HKxn9nikfL/udXfN3Ldqm14+rwT+YTX+AgeC+HsiWofmQgOWxyRpbPM9eVC8tIv96
         5AMA==
X-Forwarded-Encrypted: i=1; AJvYcCWOGvTjNgLTqW5cyPVya5/BjC559ATyowqDUvCTjFxD9zUbsE5Z5WPCgMnJTPk1Wn5VDC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsm4iqgxfqwSS/xdFqSTB3C2fKrRm0EZap0+ngngP3TRi74cDF
	FF521+FtLB0TH/YlThgYe7+iqmvCwCkOy8Ai1JLyFOv3jzTxDkdh0pURGb/IHi7E/cFA0DpbXdI
	pvj8CUKt/eLzF9otO90bqwIk81S6BaTw=
X-Gm-Gg: AZuq6aK0L3Df/QonSjw62ROfGO5SxYGXVtzM54xAP6Nm5/fl2bI7257ItLH2dGcWuIl
	tN6GxOa8Zde3S7fXvu7FJGgYe457Np3KG7IM2jP/wqw3mj37M+fDrtoES9u6PP44kFvA8chzyvr
	xS3s0dz9H1gmpF9sqKVvQtKPZyqmNYBtNXbcEpz8V8KTqoUEQS0xOFDBDPkuLZF/MXbo5Aks7m1
	8gbGoBhNvrHEBQqfZai/u3TWWQ/OT59EzYeY9cl1V+h3l34Lf+3PpNBpmvVtozOICPLpYYUSV8h
	bVftcHWG2c+J8o8peYbUnAtna5HcN+2EN2vRuoFhNfe5juv4LrDDP2Y0HLzrVa0Dr74jCQ==
X-Received: by 2002:a05:600c:34d5:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-4830e930f67mr1621525e9.9.1770134459065; Tue, 03 Feb 2026
 08:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com> <20260203101707.52965eb0@gandalf.local.home>
In-Reply-To: <20260203101707.52965eb0@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 08:00:45 -0800
X-Gm-Features: AZwV_Qgsf-FoXB1pc5mel06UTxL9uWyAFVjyhN8Kz0H72J6ymSV25GKNwS9ieHQ
Message-ID: <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 3 Feb 2026 21:50:47 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > Testing revealed that sorting within resolve_btfids introduces issues w=
ith
> > btf__dedup. Therefore, I plan to move the sorting logic directly into
> > btf__add_enum_value and btf__add_enum64_value in libbpf, which are
> > invoked by pahole. However, it means that we need a newer pahole
> > version.
>
> Sorting isn't a requirement just something I wanted to bring up. If it's
> too complex and doesn't achieve much benefit then let's not do it.
>
> My worry is because "cat trace" takes quite a long time just reading the
> BTF arguments. I'm worried it will just get worse with enums as well.
>
> I have trace-cmd reading BTF now (just haven't officially released it) an=
d
> doing an extract and reading the trace.dat file is much faster than readi=
ng
> the trace file with arguments. I'll need to implement the enum logic too =
in
> libtraceevent.

If you mean to do pretty printing of the trace in user space then +1 from m=
e.

I don't like sorting enums either in resolve_btfid, pahole or kernel.
Sorted BTF by name was ok, since it doesn't change original semantics.
While sorting enums by value gets us to the grey zone where
the sequence of enum names in vmlinux.h becomes different than in dwarf.

Also id->name mapping in general is not precise.
There is no requirement for enums to be unique.
Just grabbing the first one:
ATA_PIO0 =3D 1,
ATA_PIO1 =3D 3,
ATA_PIO2 =3D 7,
ATA_UDMA0 =3D 1,
ATA_UDMA1 =3D 3,
ATA_UDMA2 =3D 7,
ATA_ID_CYLS =3D 1,
ATA_ID_HEADS =3D 3,
SCR_ERROR =3D 1,
SCR_CONTROL =3D 2,
SCR_ACTIVE =3D 3,

All these names are part of the same enum type.
Which one to print? First one?

another example:
enum {
        BPF_LOCAL_STORAGE_GET_F_CREATE =3D 1,
        BPF_SK_STORAGE_GET_F_CREATE =3D 1,
};

and another:
enum {
        BPF_SKB_TSTAMP_UNSPEC =3D 0,
        BPF_SKB_TSTAMP_DELIVERY_MONO =3D 1,
        BPF_SKB_CLOCK_REALTIME =3D 0,
        BPF_SKB_CLOCK_MONOTONIC =3D 1,
        BPF_SKB_CLOCK_TAI =3D 2,
};

I'd rather not print any and keep it integer only.

pw-bot: cr
