Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A50286A4
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216745; cv=pass; b=u022k0bDoK101Qysdb84OjNP762b4Qgxx8Iv1J1XLgw3cqYmRLeO45X42Quj+V1nZZRCZKOalYT7KWhlZl5JrvF/183INmAKLfs86/um43EM47hrZQ0YylUnpZtOW/nBEMgn5hE2Nz7UgH9kc5d1ycHpIvfoVjxN6T0nl+hi6ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216745; c=relaxed/simple;
	bh=vAPrTpVvtjDoYqyCk5qlFEtzMqAPTstr/NkSMREnjU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiu0au5pF38ZBfP5WWAWyyxLSh02wXVB6NL8mc8GoD44MpmMKn9gh8UPVNWtQozVrh3MHpivN/xpRGoTe9+vDiWCuc6qTxvp42OKuBjODC7Z8ib7tUBFBPCcIS3N+L/Nf63fSQ1z32gKqB5zHVBCxHfMkkMWbNUFOHUU+aoz5wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmmCkk8i; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmmCkk8i"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b885e8c6727so201969566b.1
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 06:52:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770216743; cv=none;
        d=google.com; s=arc-20240605;
        b=IvBPITKN1kIyXgosApo6NQKR/qicUilMFSNtCMIT2Asb0XgxkMT9SSngF3WIjLnODj
         aYqmhk/ts3gYEOTu0/BhJ0Bh6JbmKVB6uCihPRl+TlGq8CYgOHT0JbaM13JIJCwgPPj0
         gFkieB30xcfbd+fcS/og5wZ53iOH6WAtfoUrciZ7xAH90tfQo82F7f+NmKktU1eKdKjh
         kN8RvOsmRf8cI5oZLw9pRYF/pVR6F2wOU+RN8Z0Bmdn866ykGGs8PJE5J1Og5oGPuZh9
         4sHC+IWEEiTpOXsR1oRgr4sGQCCQrlZufAJNalBGs1/758bHOd4Z6mUyeuKXF/FhPPpn
         RbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ae/2zsLX1SITkee1l+dAFeZHbUj9ZwEYK3HL0LzMcs=;
        fh=2SrMtZiocCPvAVFmnfWfkI+9klaiUGjzCcYfeu5qPWs=;
        b=Wj/7JcSDKaEltx156stFn1DjJYhqMBURCW9b/p72+RUkAVawIzRTzZvw6BGqd1j4rY
         qJIhccA9/1yV+dCcC2bU3R4bC/sKMMlNVzRpVwcp1WUcQG/Z83xAGrLr29HIC2iZ2pKx
         fb7zKGhRuZUhTkUNfUyKTpzrvDrmtBeKPJfWbRIJRBGiOCJgv+PnuLjmhnustdcq5rDw
         shBS/hPfHM4G5YgSwThI/cOxzPF5dD34V8i3NiIh7rS9T0hzcMBy21ZTIb2edcfXbW6d
         wgyONo5b2Lm51jT7DZWarPw3ybRYC4Ih6V9LmEAfxR3EAeJURmWVr3FqDvSX/cQLo1n/
         yTyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770216743; x=1770821543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ae/2zsLX1SITkee1l+dAFeZHbUj9ZwEYK3HL0LzMcs=;
        b=KmmCkk8ilN7MwW1HOtn3JeITxCIHDlsKvKcop8WAgvKvXkoISiw8AP1tLRIaaNeRjs
         7wfS2KxGF4XskI56h18aOdcohK9j5toE3kP3VPzDUDodap4CdfYWQDdxPaIIQJ0YvzIt
         QO9nS6fk/QDd3tWDVIY9R3Uz45GrT49RwHL9V92o81SPiifhjuCiFdhgYGXvbMkL2aCt
         qwTM6D4ONkquVtHlGryMOldmsiZcBZOfA8dWfwYWhfbhfbYRoGRxIPR2UK0UEb+EtNmZ
         UYJcyANj8/0ZoQFR5pJlrF+e5oLG/51ZoFfZYZD/ekiOHRH2aX+SORfVUhaNQ09wveLt
         iR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770216743; x=1770821543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ae/2zsLX1SITkee1l+dAFeZHbUj9ZwEYK3HL0LzMcs=;
        b=wwURIcJhpHyxkvm4gGWUB1IpJcWJ5EmLKQPX/3rNAOEGfXDscnw3GgOZK3v5zQdN63
         d7mIPw0Nh1zOQe3pBABHY6o67qVc4ts+jkEm9Oo5Re8uelESmpjSKj/ZuTWRLqFfwutN
         jNyZhgzTzD26DkiYE2OdOfOL428PZvE2omANwjj1mEfeRVFYsBhDQvbLpoAQ7QwVzLTB
         xkXhTsY1p9GOpLH593lyrOTrtn8tFA/Xn6kpw1nSwg8oxH1RSlskpzejpu7RnRIW+J0Z
         EUllPsAkjRo5TWiLbhP/UjvKhNYxD/wD4aREwDndz6vCi8eFOfT6h+UD55PUd8lXMOg+
         SMKw==
X-Forwarded-Encrypted: i=1; AJvYcCWnbirqqEf1LEtdi+bAN/jNBqGlMQoqQUFynCnaVSnbh3fEXa3+kIUV1QOMdVdG8+tOPKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwKvQHD3Lxt+p/ICU2EMHwHPfDhjrPxKfb05OkB4OB3qTeIJ6y
	Mg9rlsZV+Pf/ifQ4nlp0fpoRYA0XoC80kJHghivjldvO0/CVHXfjCX3tof9GEuVkgjnbUf7S6RB
	VzZGofnDo6F3byOFCFERCR+JUR5DHdyA=
X-Gm-Gg: AZuq6aLnwHFvUqFh04i4A70Qcmu/bm0PGzv4ayCr0uBaFJDTyXIj2tmVKc+X3sQKfC6
	vL0QcQj14XQOu+XUnmco5KO+OHkMmtXJDBIgUwc3x3FtocBFOJMbT53KimQ1VJ5eGbGA6zeaVMZ
	SLQ3SEPVGHRbdSxk+C4asjH/OcZPdeRlmP0pLZffyoxsqQaW/+1YBwxgUxbDsl5QNrtHJustpk9
	hm2tXUBUjon9ZmJAf04tHegazf8fId8C1mHEmPXCW6h5ZyDGZ8k69g8I2dIMLHhw3lfuPca
X-Received: by 2002:a17:907:72d2:b0:b80:40ea:1d65 with SMTP id
 a640c23a62f3a-b8e9fb81038mr249447766b.31.1770216742630; Wed, 04 Feb 2026
 06:52:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
 <20260203101707.52965eb0@gandalf.local.home> <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
In-Reply-To: <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 4 Feb 2026 22:52:11 +0800
X-Gm-Features: AZwV_QhyUAnBXEaRMJ8cNNq58o_SXW6uwD6sX0x2qOdpKoR92KuetEKRu2ZVyQ8
Message-ID: <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Tue, 3 Feb 2026 21:50:47 +0800
> > Donglin Peng <dolinux.peng@gmail.com> wrote:
> >
> > > Testing revealed that sorting within resolve_btfids introduces issues=
 with
> > > btf__dedup. Therefore, I plan to move the sorting logic directly into
> > > btf__add_enum_value and btf__add_enum64_value in libbpf, which are
> > > invoked by pahole. However, it means that we need a newer pahole
> > > version.
> >
> > Sorting isn't a requirement just something I wanted to bring up. If it'=
s
> > too complex and doesn't achieve much benefit then let's not do it.
> >
> > My worry is because "cat trace" takes quite a long time just reading th=
e
> > BTF arguments. I'm worried it will just get worse with enums as well.
> >
> > I have trace-cmd reading BTF now (just haven't officially released it) =
and
> > doing an extract and reading the trace.dat file is much faster than rea=
ding
> > the trace file with arguments. I'll need to implement the enum logic to=
o in
> > libtraceevent.
>
> If you mean to do pretty printing of the trace in user space then +1 from=
 me.
>
> I don't like sorting enums either in resolve_btfid, pahole or kernel.
> Sorted BTF by name was ok, since it doesn't change original semantics.
> While sorting enums by value gets us to the grey zone where
> the sequence of enum names in vmlinux.h becomes different than in dwarf.

Thanks, I agreed.

>
> Also id->name mapping in general is not precise.
> There is no requirement for enums to be unique.
> Just grabbing the first one:
> ATA_PIO0 =3D 1,
> ATA_PIO1 =3D 3,
> ATA_PIO2 =3D 7,
> ATA_UDMA0 =3D 1,
> ATA_UDMA1 =3D 3,
> ATA_UDMA2 =3D 7,
> ATA_ID_CYLS =3D 1,
> ATA_ID_HEADS =3D 3,
> SCR_ERROR =3D 1,
> SCR_CONTROL =3D 2,
> SCR_ACTIVE =3D 3,
>
> All these names are part of the same enum type.
> Which one to print? First one?

I think these cases are not very common and printing the first
one would be helpful enough, and we can add documentation
notes in ftrace to guide users.

>
> another example:
> enum {
>         BPF_LOCAL_STORAGE_GET_F_CREATE =3D 1,
>         BPF_SK_STORAGE_GET_F_CREATE =3D 1,
> };
>
> and another:
> enum {
>         BPF_SKB_TSTAMP_UNSPEC =3D 0,
>         BPF_SKB_TSTAMP_DELIVERY_MONO =3D 1,
>         BPF_SKB_CLOCK_REALTIME =3D 0,
>         BPF_SKB_CLOCK_MONOTONIC =3D 1,
>         BPF_SKB_CLOCK_TAI =3D 2,
> };
>
> I'd rather not print any and keep it integer only.
>
> pw-bot: cr
