From torvalds@linuxfoundation.org Thu May 18 20:57:30 2023
Received: by 2002:a05:6520:3804:b0:25f:79bc:6e60 with SMTP id b4csp648748lkx;
        Thu, 18 May 2023 11:57:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pZjgw7pNK6kn+YpzRebOwbFEFy76vBal9ufZy0PCrriuFyLUKH6nnnaOcUYG0k6yq+OL7
X-Received: by 2002:a05:6870:9896:b0:192:d723:b261 with SMTP id eg22-20020a056870989600b00192d723b261mr1447132oab.17.1684436250839;
        Thu, 18 May 2023 11:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684436250; cv=none;
        d=google.com; s=arc-20160816;
        b=Gq4Xub04/owFRuE+Ypc5NBMDjjZ0lf/r72iXOWt9M0F0Kiub3FSjQx+eZc+L9mycZC
         Lr3uJcCjxGw51P3/Waq64POWOYLLsDaNHwPt8Ahqs19jYaakThPzqChP/FHQpTw7SAEG
         PpTOx7ldRoF1h/HYapcJIfvKVMa6i4+ZAlzMtWQf+xH/ASrMcMQbynUaLtjf/TT53iOK
         HFlL8gZm7NFriy/PsvBUclMUG+nuiYTw4OIe/tGs8IiN195vtrSzWglh40N72m3HneZ2
         CE6EKQaQmg8Y0m0DUWmHrDSg2cRkHfoRgTGaq1ojNB851421xGOhTXGNqyGKoBXts2ZT
         bhaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:dmarc-filter:delivered-to;
        bh=ufxGyUyvgmc9IbeLFwZqpA7R30Z+Lx7wHFt4+tZsdEM=;
        b=X5Aiq3rn0ImdRRB1/60IcnuzhDueKLwtId9eLfL1ai+O8KQigEtz+gd5HHV3PhR8Rt
         ZfCVN8lCdvwIaIf36N7F8lxalsz7ObqZh/r2onI8ApIT4ltpAXmdd+FWXweX6JWDxEh8
         lATLADGs9EGhom+73/MZJcwTZ+w3MdaIpKtK4ds/3pGansTmMfSSwrGtMbKzEYgtiWIx
         a4uECK3eLla702OLHugdrdpnRwMwGODqWLLignDRRJ//SnFlwRM0bqUxj/ba2XiVlTsb
         Wn3lhyU+yvMwbUyySemfRzQSiEjdITcSszqgh9agkhV0rlN+EmyJSJiWaIzlNQSl6QjJ
         2lfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=P8SAIWFM;
       spf=pass (google.com: domain of torvalds@linuxfoundation.org designates 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=torvalds@linuxfoundation.org
Return-Path: <torvalds@linuxfoundation.org>
Received: from dfw.source.kernel.org (dfw.source.kernel.org. [2604:1380:4641:c500::1])
        by mx.google.com with ESMTPS id a8-20020a9d5c88000000b006ac7cf7eae1si1389332oti.333.2023.05.18.11.57.30
        for <christian@brauner.io>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 11:57:30 -0700 (PDT)
Received-SPF: pass (google.com: domain of torvalds@linuxfoundation.org designates 2604:1380:4641:c500::1 as permitted sender) client-ip=2604:1380:4641:c500::1;
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=P8SAIWFM;
       spf=pass (google.com: domain of torvalds@linuxfoundation.org designates 2604:1380:4641:c500::1 as permitted sender) smtp.mailfrom=torvalds@linuxfoundation.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 81927651B6
	for <christian@brauner.io>; Thu, 18 May 2023 18:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix)
	id 02784C433EF; Thu, 18 May 2023 18:57:30 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0BAF1C43445
	for <brauner@kernel.org>; Thu, 18 May 2023 18:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.kernel.org 0BAF1C43445
Authentication-Results: smtp.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-965b5f3b9ffso2645966b.0
        for <brauner@kernel.org>; Thu, 18 May 2023 11:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684436246; x=1687028246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ufxGyUyvgmc9IbeLFwZqpA7R30Z+Lx7wHFt4+tZsdEM=;
        b=P8SAIWFMV9QOoW6GW+YU2ae1y4OHJGtm50lsikk5GeUjqgjhkgfljRGmfxNTX+4GBw
         XPrRixgB9sBBGXzfYrxposTgVsYh6AHa07JNJugUmoj49A1AnD4EEY0/pTd4vbH3UX13
         shBHgJlLleWkPXk3X8awTnXA0+ufLJUbuUg8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684436246; x=1687028246;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufxGyUyvgmc9IbeLFwZqpA7R30Z+Lx7wHFt4+tZsdEM=;
        b=Od+b253kj8H34kz71Tln7Li5eAJs0oiMGT1imkhaFXBnlGAxoi1Rmk7P0M4YygJI/B
         a+wlBV9Bm77+iQioW+aoqr2CJXLZFdGsOjvVfztBmF8UGOnJOrbdWYtF0h63YaL8/BgZ
         uh3VacKwhBBQRvAeE+yr4IGFZNDTQf4ysm7Cbu442pDZqtAHgoxlVa8Icf1bpx/jlNVu
         wgARBOAnYwtRnKJ0TRee7SNXiIyr9X2g3ixTV+s1f1qm3lCD0CmF/Qk4QTSttDTstaUm
         q62w+FDWrO6p4MABDZ8ZMEL19J8rb+WXnlN4zpJtnnhYlDWiIORd4L/8EFYxO1PXsMp/
         +aAQ==
X-Gm-Message-State: AC+VfDxjtNoOojA7UHbalH9bisfpml/lev9tco6SzrHWWlDtqqqJsQsh
	6u3zozE3bh5YhFUPqZ9jCqdvicX4RKxb286GGU2sPitm
X-Received: by 2002:a17:907:1b29:b0:94a:57d1:5539 with SMTP id mp41-20020a1709071b2900b0094a57d15539mr91273ejc.5.1684436245988;
        Thu, 18 May 2023 11:57:25 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906354c00b009534211cc97sm1301817eja.159.2023.05.18.11.57.24
        for <brauner@kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 11:57:24 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so3445a12.1
        for <brauner@kernel.org>; Thu, 18 May 2023 11:57:24 -0700 (PDT)
X-Received: by 2002:a05:6402:11d1:b0:50d:bd2e:6fe3 with SMTP id
 j17-20020a05640211d100b0050dbd2e6fe3mr6535100edw.14.1684436244109; Thu, 18
 May 2023 11:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230516001348.286414-1-andrii@kernel.org> <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner> <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner> <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner> <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <20230518-tierzucht-modewelt-eb6aaf60037e@brauner> <20230518182635.na7vgyysd7fk7eu4@MacBook-Pro-8.local>
In-Reply-To: <20230518182635.na7vgyysd7fk7eu4@MacBook-Pro-8.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 May 2023 11:57:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whg-ygwrxm3GZ_aNXO=srH9sZ3NmFqu0KkyWw+wgEsi6g@mail.gmail.com>
Message-ID: <CAHk-=whg-ygwrxm3GZ_aNXO=srH9sZ3NmFqu0KkyWw+wgEsi6g@mail.gmail.com>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Lennart Poettering <lennart@poettering.net>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: multipart/alternative; boundary="000000000000fa31b105fbfc5f7e"

--000000000000fa31b105fbfc5f7e
Content-Type: text/plain; charset="UTF-8"

[ Out walking for health - sorry for html crud ]

On Thu, May 18, 2023, 11:26 Alexei Starovoitov <alexei.starovoitov@gmail.com>
wrote:

>
> User space cares what they refer to.
> Unix made integer FD into broken abstraction.
>

Stop trying to blame anybody else.

The unix people came up with a good abstraction, and you've screwed up.
That is nobody's fault but your own, and you should just admit it rather
than trying to double down on being wrong.

Integer file descriptions are fine. Negative ones are invalid, and people
who wanted to use "root" and "cwd" have already done so using them for
decades. Look up openat().

You just picked completely the wrong invalid number.

That's on you. Nobody else.

regular files need one set of syscalls to work with such 'integer FDs'.
> sockets need another set of syscalls.
>

None of that has anything to do with file descriptors, which are a unified
format.

The reason sockets have extra system calls is that you're can just do extra
things with them. That's no different from ioctl's, and they could have
been done that way, but the extra system calls are cleaner.

While user space sees an integer without type and that a root cause of the
> bugs.
> And that's particularly bad for integers 0,1,2 where user space assumes
> that
> regular files are behind them.
>

Stop making yourself look any more stupid than necessary.

The 0/1/2 file descriptors are not at all special. They are a shell
pipeline default, nothing more. They are not the argument your think they
are, and you should stop trying to make them an argument.

It only makes you look bad.

Imagine C++ project where base class is called 'FD' while children
>

Ok, now you've just gone totally off the rails.

Stop this silliness.

You did something bad from ignorance. That's fine. But making excuses for
it turns ignorance to willful stupidity. Stop digging yourself deeper in
that hole.

The system call interface is not some C++ object interface. And we should
all be grateful that it isn't.

        Linus

--000000000000fa31b105fbfc5f7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>[ Out walking for health - sorry for html crud ]</di=
v><div dir=3D"auto"><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D=
"ltr" class=3D"gmail_attr">On Thu, May 18, 2023, 11:26 Alexei Starovoitov &=
lt;<a href=3D"mailto:alexei.starovoitov@gmail.com">alexei.starovoitov@gmail=
.com</a>&gt; wrote:</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
User space cares what they refer to.<br>
Unix made integer FD into broken abstraction.<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Stop trying to blame anybody e=
lse.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The unix people cam=
e up with a good abstraction, and you&#39;ve screwed up. That is nobody&#39=
;s fault but your own, and you should just admit it rather than trying to d=
ouble down on being wrong.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Integer file descriptions are fine. Negative ones are invalid, and peopl=
e who wanted to use &quot;root&quot; and &quot;cwd&quot; have already done =
so using them for decades. Look up openat().</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">You just picked completely the wrong invalid number.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">That&#39;s on you. Nobody=
 else.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
regular files need one set of syscalls to work with such &#39;integer FDs&#=
39;.<br>
sockets need another set of syscalls.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">None of that has anything to do with =
file descriptors, which are a unified format.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">The reason sockets have extra system calls is that yo=
u&#39;re can just do extra things with them. That&#39;s no different from i=
octl&#39;s, and they could have been done that way, but the extra system ca=
lls are cleaner.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
While user space sees an integer without type and that a root cause of the =
bugs.<br>
And that&#39;s particularly bad for integers 0,1,2 where user space assumes=
 that<br>
regular files are behind them.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"></blockquote></div></div><div dir=3D"auto">Stop making yourse=
lf look any more stupid than necessary.</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">The 0/1/2 file descriptors are not at all special. They are=
 a shell pipeline default, nothing more. They are not the argument your thi=
nk they are, and you should stop trying to make them an argument.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">It only makes you look bad.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
Imagine C++ project where base class is called &#39;FD&#39; while children<=
br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">O=
k, now you&#39;ve just gone totally off the rails.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Stop this silliness.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">You did something bad from ignorance. That&#39;s fi=
ne. But making excuses for it turns ignorance to willful stupidity. Stop di=
gging yourself deeper in that hole.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">The system call interface is not some C++ object interface. And=
 we should all be grateful that it isn&#39;t.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0 Linus</div></div>

--000000000000fa31b105fbfc5f7e--

