Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DE275B18
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771555329; cv=pass; b=MiZ/FTEpsF21+c+TLFdbdz2+iVNVRbe7RlHHUp+Fjl2KRwgwlTPZSduhZI/eHXjlmpRTbixXfwiAHzaS2s50ezW2d9UATi0zYKS+IKZ4WpMVjXnP3CYJDmBKDZDVxeii8ZQGtzafJ3ZevqF1c49ouF+YyHu3uwgeCFhXXFGDrU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771555329; c=relaxed/simple;
	bh=eSIDcTndojuucPxxP0lRzGLmt5jXlY5cGrpufpEVE+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzKcm5XFAeBJ6w/0iXzjAZTJR1ekGDC+Qx+oEFG+R6vMmctopTsP2csTmKgUzWvkFD3X8DsbXLUpTMmK7VGVbmaMxU4Xm/uDwinJfvL6JV5C/5JEg0LiAllmVzBbcqNc4Po3RqM9tDz771c7Ixu+lrNb3PgGiw3kUoWKX8Qtf4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwkiIDLG; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwkiIDLG"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483487335c2so14906795e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 18:42:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771555326; cv=none;
        d=google.com; s=arc-20240605;
        b=YqBz+OxmYsQw3hKNyxzG8mlJe32LlFBmLFk3WgpAbYvynbb7UPaaQEPFODJfT6SYRa
         7md1XPfXTmJ2Sj7SxXh8KPsJOQ/IVQbIsSgANTFm+OhI9596M4wno11i9S5rpKlHYSG7
         4iyTgSuoksuJIq+D5r32l0XgaH7vFPP5uuMxZJK9ZWxmqsS3Do7N6mi8xeoV9uswCaw2
         eKhyt9z08Uu3SAM4S1y5RimtR8KvbIZ1Vd/ZNGMM4XxXr8TnyLvTBRwsmFds2rVWqC06
         8rortPUnYLZR+rxk5U19x72lu3RaXrs+WVoIoCnBYp438IPbmYv/QoAlab4Zng4NELkR
         Kdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SHrzT+fir9eST8UykRQwYBKwpHHr0uRgiPrfgHLzZ3I=;
        fh=FGhusMok0qAzlzvwPkHL+ZT9QPxNaGEeDf3EAmiLCFw=;
        b=UY7PAYZevGO/N+Dmi6mHgw33HmSfN1RtMYkNjgmn2d7aZbimJPUeJ8gf9+HpTTTEz5
         LpxYklfhE6msC7WygOEd/JhVEo2XSDH+lJHIwBvOkmKXNjOtUk1q9aPZVw1/r1JnULof
         ykVVKwn4ydXdM00FQaY14iqCfSm+phXqjIwGY/8TZHJwZH8fkTdf8XTDDFpiVUvbJSTI
         Ioqebe8UCr/LufoPlpxsfZfxjaN9xV2MaE0MkR4egJObSXXreXnPFd7Vtpr2HP7CzM2J
         w4Igi6GfA5bIlX99v8wPRkiggfzBL+TST8q++E/tDxHUSg7z5iJNH0fWo5ly01XTCZOu
         mAHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771555326; x=1772160126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHrzT+fir9eST8UykRQwYBKwpHHr0uRgiPrfgHLzZ3I=;
        b=VwkiIDLGJmBDKv8m6vpFKQpaIMXhjd3EHfEgLDIU0zCwxeBG3fc6GcMGwclrJF2+vl
         YNhHXrsOkmW7tamzuL60XCGHgHxvQLDxHxmLE8Qk9uOmEoAWld9lqOaj+yXA+y0+msh8
         eHuBWFm5meKSqTtYchZatYqfAgRqM0v/I/Nuyqg38LzWU5nbttlZnzu+QbDEl+12vbq/
         DFofZFVUnUdknB2qjYSrLithlnqFsb2D7FWZQYPZynocO+5TQtScXhY6u5yUst36hFE3
         /0ieP/z9tlLOG5BgPPQZLWxJ550E2HVC4pv+TxRy/Vn9wU/XqpukQkqTCfxO1P5r1QtW
         +OKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771555326; x=1772160126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SHrzT+fir9eST8UykRQwYBKwpHHr0uRgiPrfgHLzZ3I=;
        b=AYauWgvV3+u7FOFV/vKXYXuCr5uYeLczopeCwj8FwV2LKYrg+SWvpZ2uqSKIyu0QvD
         ECOMaSANhGyoqsh6UhyxqoZx7J4pZDm14Rs5Lu4CmaFuYKdBczc/KSify/gk5J86Bjji
         lTrtBVUNxMlcpmSmC/lBM+M4ZwplbHg+aEugY0E3hS6CFCTi4zceHL/xvewfu2sBcd13
         nwOlGGPLWfX/XOaAs/sgSBQZK5R8N0uqVV1mWZ04GyTY/l8WPoTCgDUS/DD1mGUxE37F
         y9n8jVwkjSYde9WjAvUDoEhOoQHF7yMBxYlsX9/YbD2AW69YIVDGQ7yb6cfpDTPr1Az3
         9FzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6KcwcYS3uSrRssq8s+bh9DkMJj0jEBpcWhHRvE/rbAI1hdhSDAG8hXFJVE9JnLd4Ni6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+7lqy9Zn6R/sFXZFJ41Kqj7B4Jn8DphiUgfoZpbqRy0/daOyo
	S07ytqVV+kaRTADCx9Ypvb/a6VXXzbc4WCSuAoSR/qhLHG4TFKbKiPIF3l4hiD93OfZAKPdBHF6
	2d92z+RTf2XaQLQMbasVopodxpciUocA=
X-Gm-Gg: AZuq6aJpVFddtuV4Jqu7CutBVuFO2btd/oghCPDesKxa8NmtC3LuBVs38b7MLOCLOTA
	ycwsiIBhYoI6lgdnH8qw9mokA+nKZoxod3vjLDeukwgktem1pumJg8Q44Z9za5+bj91jlF2OPHH
	6zzYtitmfPa2PYJ44qr/OdmPfwUXNtG/9lRik51ovDNBxX0SlHkD2zj5dWSz6Wv0E2JBWel6R3P
	rQo1NlCeHYTRfK/4+vYesSu/XyiCsrVuXodSapl5zfRFHhgNC+LH2A/KpMAD2R1TKHAG1yi1qg5
	v6hYLXbCfNqJe5RMnDPzT5K2TnmbErl0A5faJ9a3SdzZNXCBX0VT5/9Ap9Vv59stXkVhjN1VCjA
	76Xa/x9xwtdVt+etEyRVQAmS1Kw==
X-Received: by 2002:a05:600c:1f0e:b0:47d:92bb:2723 with SMTP id
 5b1f17b1804b1-4839e636f4cmr69681405e9.3.1771555326221; Thu, 19 Feb 2026
 18:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87fr7e15l0.fsf@gnu.org> <6ac7e425-cf75-4706-9906-4c23eb4f0f41@linux.dev>
 <b77afbde-b6d6-4728-9090-af31027846b2@linux.dev>
In-Reply-To: <b77afbde-b6d6-4728-9090-af31027846b2@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Feb 2026 18:41:55 -0800
X-Gm-Features: AaiRm52oqjoPs6aUgD_P2SwMtgfqFFvtz0QOB_T8lX1Js0g_JZq4X59icQ6oguU
Message-ID: <CAADnVQLKXawH8nuSkXGcafS9d66hYfLF_zjKCVdO5WoQ8TxrGw@mail.gmail.com>
Subject: Re: Function Return ABI (was Re: Argument passing and ABI: GCC vs clang)
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf <bpf@vger.kernel.org>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, bpf@gcc.gnu.org, Alexei Starovoitov <ast@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 3:11=E2=80=AFPM Vineet Gupta <vineet.gupta@linux.de=
v> wrote:
>
> On 2/8/26 9:11 PM, Vineet Gupta wrote:
> > On 2/6/26 03:20, Jose E. Marchesi wrote:
> >> Hello people!
> >>
> >> Yesterday evening Vineet pointed out in IRC some differences between t=
he
> >> way GCC handles argument passing compared to clang/LLVM.
> > For illustration, here's what a simple test looks like across clang, gc=
c and x86
> > and aarch64
> > https://godbolt.org/z/oerG3eT6f
> >
> > typedef struct {
> >      int a;
> >      short b;
> >      signed char c;
> > } my_t;
> >
> > void foo(signed char, short, int);
> >
> > char args_setup(my_t *s)
> > {
> >      foo(s->c, s->b, s->a);
> > }
> >
> > int args_consume (signed char a, short b, int c)
> > {
> >    int x =3D a;
> >    int y =3D b;
> >    int z =3D c;
> >
> >    return x + y + z;
> > }
> >
> > clang: -O2 -mcpu=3Dv4            |  gcc: -O2 -mcpu=3Dv4
> >                                 |
> > args_setup:                    | args_setup:
> >          r2 =3D *(s16 *)(r1 + 4)  |         r3 =3D *(u32 *) (r1+0)
> >          w3 =3D *(u32 *)(r1 + 0)  |         r2 =3D *(u16 *) (r1+4)
> >          r1 =3D *(s8 *)(r1 + 6)   |         r1 =3D *(u8 *) (r1+6)
> >          call foo               |         call foo
> >          exit                   |         exit
> >                                 |
> > args_consume:                  | args_consume:
> >          w0 =3D w2                |         r2 =3D (s16) r2
> >          w0 +=3D w1               |         r0 =3D r3
> >          w0 +=3D w3               |         r1 =3D (s8) r1
> >          exit                   |         w1 +=3D w2
> >                                 |         w0 +=3D w1
> >                                 |         exit
> >
> >
> > So clang is narrowing the args on caller site while gcc is doing this i=
n caller.
> > This is not consistent and needs to fixed in one of the compilers.
> > Doing this in callee seems like a better/safer approach as doesn't assu=
me caller
> > to always be doing the right thing, specially when mixing bpf user code=
 with
> > kernel etc.
> >
> > BTW where is the w<N> assembler notation and semantics (32-bit, zero ex=
tension
> > etc) documented. I don't anything relevant in [1]
> > Presumably it is just a compiler notation so [1] might not be the ideal=
 place.
> >
> > [1] https://docs.kernel.org/bpf/standardization/instruction-set.html
> So the function arguments issue is captured as PR/124171 and I have a
> tentative fix for that, but...
> There's second half of the problem which is promotion of narrow function
> return values.
>
> It seems the existing clang ABI is not symmetrical. The function
> arguments promotion is handled in callee, but function return is handled
> in caller [1] which is a bit atypical IMO and would need to be handled
> in gcc as well.

hmm. I thought we already concluded that for clang-x86 and clang-bpf
argument extension is handled in *caller*.
The same thing for returns. It's a caller responsibility.
gcc-bpf doing args in the callee only is broken and has to be fixed.

> Since we are on the topic of ABI change, I wanted to surface that as
> well before we go off and tackle that.
>
> Simple example
>
> _Bool bar_bool(void);
>
> int ret_caller(void) {
>        if (bar_bool() !=3D 1) return 0; else return 1;
> }
>
> char ret_callee(my_t *s)
> {
>      return s->c;    // c is a char in a struct
> }
>
> ret_caller:
>      call    bar_bool
>      r0 &=3D 0xff        <-- ret promotion in caller
>      exit
>
> ret_callee:
>      r0 =3D *(u8 *) (r1+6) <-- no ret promotion in callee
>      exit

Exactly as it should be because x86 will populate 8-bit sub
registers in the callee and bpf side has to do r0 &=3D 0xff
in the caller.
