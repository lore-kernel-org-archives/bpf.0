Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA0BD534
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743884; cv=none; b=NX2Lf/bL/iDsK00Y1LPQOZEaZNDExB7cau7W3EC/hcN/l2xjR6vb9j7zzNk0JP50FoyGXBk8lC7tNpX8YrgK58vlcm42FyrKRDA910T6m+nOjvMWun+sSnSdkShQokjWhFmV5t28QpH6XGMfppCOqiedt5Y+NNqgQEWBEKXV/2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743884; c=relaxed/simple;
	bh=AuuhBwLZ0UDCQuIj72sUdbGMEd5gcb381MhHE5Ur1mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5IzpVth3v4ovD7ijdKz2rVgihSiSf9hvQ3gVFydVsaCsdtEXa6q0ovwh8IqReIZhmGauFlRvIGIfRxcvtXVQmDyXW1i4165BAM+IByxgAcY0yUADOjpY3v3/GtuYY+u28ORZxaDwP9gmBBZzS5R55oN2t9Trhpo84ziEeo2Z04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhAFAkZZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhAFAkZZ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e122c8598so13126f8f.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 08:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709743881; x=1710348681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oZYzWHIx6qDvlz03KR2uwW6nKu66yvZ/HggnMiSEPc=;
        b=AhAFAkZZgn4rT6VpsepxgN9cLjn7o7/3NiONM9b4A3kyMzKxg+bltMjjFj+XaDmqed
         wsniNMh/26aPGwg6ZOxlxuyL03mi4/5xSmyj3ReUIDQUccWEYUWrkf1Hk5MYmldwC7Y4
         FIez717YqZDDcMv2WZ3KiAuvyjH1ph53Cl3IpAKvfJqob6zNH5dwth/pUbgtVMW+jdtC
         tbnhsSUPFqiIwnFJ7aTT4NNc70d5/UgK2zImZyEaKVq85gOX2IZ0vj4cjBdlhyaqRpLr
         PU1NVl7vqID2J4IOjAyqhVcYtbHKxvAro4i4aM8WtA7YlsU+uiCwgwaF8Q9Dq+XcXuCp
         llTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709743881; x=1710348681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oZYzWHIx6qDvlz03KR2uwW6nKu66yvZ/HggnMiSEPc=;
        b=djNoK0GVI8cnu3fsAQKkKD1/HX6n0LxszxTp4AdLqh/NUN4pKyFw1qxMbnEm6u/OnN
         nfZ2sHED9oGwDHZ82CzIHN6tuQgFU8qcSdBaKQYpcnnSD3VDj/tu053J+WnJI+uxa/nk
         6JIdpYpxj+CAy3Wd9KkQrLJYN/VHriZXG9ijKwYPL2/Bd6HmiDi8pJkBjvOlEORo8g2D
         WdbLRO4pW8qYRiopSLcX3/iGMul7zqccO1XMYlaLOpYbsFpmjh1kvHTIf7ttgBC+nOcm
         gD3JlCdt8gKh5ZuGCSVrbb6B/0gA7mtZkrd17nWbDXCa12FNZgM30XC1DLnSL5th/1QD
         infA==
X-Gm-Message-State: AOJu0YzRzoMUJk0KXbkzG7HnDT7FwARnBEx1Ei6Xrck7O+TX1CyCqlED
	3FxLRhTMo9g/7X/u6e/qynGGkzch4HL/XzWke+/1g/ysAEDlo53g5THVoyHI3DJW9Ww00MjZLHW
	YkShwaehsvP2WI5PdFu2EZCLa7hw=
X-Google-Smtp-Source: AGHT+IFFOGrlzmfdBVVui7KjHMsLs8H794U4gl8tZwxN46LAgjI2iqHnrmjdKDBURInFtLCE35zNpZuXu8/KdTEkqKw=
X-Received: by 2002:a05:6000:1963:b0:33e:1560:71a8 with SMTP id
 da3-20020a056000196300b0033e156071a8mr10422841wrb.7.1709743880943; Wed, 06
 Mar 2024 08:51:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
 <20240306031929.42666-4-alexei.starovoitov@gmail.com> <e4fcd2c9f88e7ce31d356cb31e686bab22382bab.camel@gmail.com>
In-Reply-To: <e4fcd2c9f88e7ce31d356cb31e686bab22382bab.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 08:51:09 -0800
Message-ID: <CAADnVQ+pUa02_8u01KhTfsmgc0=sRVdX8TCp5gYkKBp5Sfhf7g@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: Add cond_break macro
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 5:26=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2024-03-05 at 19:19 -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Use may_goto instruction to implement cond_break macro.
> > Ideally the macro should be written as:
> >   asm volatile goto(".byte 0xe5;
> >                      .byte 0;
> >                      .short %l[l_break] ...
> >                      .long 0;
> > but LLVM doesn't recognize fixup of 2 byte PC relative yet.
> > Hence use
> >   asm volatile goto(".byte 0xe5;
> >                      .byte 0;
> >                      .long %l[l_break] ...
> >                      .short 0;
> > that produces correct asm on little endian.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> I tried rewriting with offset +1 and an additional goto:
>
>         ({ __label__ l_break, l_continue;               \
>          asm volatile goto("%[jcond]; goto %l[l_break];"\
>                            :: __imm_insn(jcond, BPF_RAW_INSN(BPF_JMP | BP=
F_JCOND, 0, 0, 1, 0)) \
>                            :: l_break);                 \
>         goto l_continue;                                \
>         l_break: break;                                 \
>         l_continue:;                                    \
>         })

It probably works, but the generated code is not pretty.
That's the reason why this macro has two labels l_break and l_continue.
It could have been written with a single label, like:

/* bad asm */
#define cond_break \
({ __label__ l_continue; \
asm volatile goto("may_goto %l[l_continue]" :::: l_continue); \
break; \
l_continue: ; \
})

but generated code isn't great.
It's similar to bpf_cmp_likely vs bpf_cmp_unlikely.
The C statement that llvm sees right after 'asm volatile goto'
is important for codegen.

The macro in this patch is effectively this
/* good asm */
#define cond_break \
({ __label__ l_break, l_continue; \
asm volatile goto("may_goto %l[l_break]" :::: l_break); \
goto l_continue; \
l_break: break; \
l_continue: ; \
})

To visualize see:
https://godbolt.org/z/98bcbrxaE

The next step is to do several fixes in llvm:
- allow pcrel fixup of 2 bytes
- introduce builtin_may_goto()
- recognize may_goto in inline asm and llvm-objdump disasm

With that the macro will be cleaned up and the big-endian issue
will be addressed.
