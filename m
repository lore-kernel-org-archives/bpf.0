Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DDA79FE
	for <bpf@vger.kernel.org>; Sat, 30 Mar 2024 04:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772137; cv=none; b=oS6fFMoMkOCQCxwCFBeiswRK7iYPGI4DvNPcWTiHp8XO7KeV1KULO1V4FafX+p5pnb0PmPjrpE4b67koLkAKsChVWbYNtRtBjItt/QdbSLfYofH+aOrseZpQ4XqUh2ndku52/uk26NR3ppNcU1vdGh8T4Fx1XT53veZfMmNZLQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772137; c=relaxed/simple;
	bh=qgobxYsoW4+2TT3KspAAgbFZjvWwlDQJ1EahoxZ6SUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekMHrMAR2x/oVMtGV/zTMtk+3rkihZNIOhVGKhsgpBc0CYCZ47tVMlG98ByD9aXVMQt2MNsAZlb/Dxk0Q4+cj5fY/XqdMt6vKp6/8U325i9V1aOTEgRbjUFyLYP5QaxLdy+pk/lpNM1ls7/3nwpGP0D4XeAE6xZLuo4pCcoo8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lotuHB3Y; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lotuHB3Y"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6b729669bso2153347b3a.3
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 21:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711772130; x=1712376930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofE4DiMnvHuiRZX1XlrIQJQuThx3U4684j2Vrwr4bOc=;
        b=lotuHB3YqxI5vNiMNQShMPcZpMVUJ465SPLPfA2ZffKWYhtiIpcCAVyZSTq4l0PlVm
         cPPfJ5K6RIbzdDn0T2br/TIueszyxszgWUTJ380vTjs5mQUui38KoyOVDnG1aNFg3ojX
         qT7UlrcsXggaNQXe9AuPEuT0Sb7F0MLi7Nw6l+TH1U0d7yiQ+7KnPDVXHegP8jKCK6Em
         Uow1+d0qBdtY/BbdJh5NtxxGHAY5F7ea4QmX/AcK49wR4lbjbtMz9p1a1106CIP7G/p2
         F5jxnpW89ievSd3eMy5KK8/Cy/eyEh2UtRV9jEB1VoadAT58X+0FxQfYCzwBApOxWs6q
         CZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711772130; x=1712376930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofE4DiMnvHuiRZX1XlrIQJQuThx3U4684j2Vrwr4bOc=;
        b=dPmSma0dmcEX9OaqYrdZwsHo7RbVCMqMgXv2f0GsuLkChcwr64HiZ/CV7guiKUI8mT
         Ct63xAahBbhoR7mAJiS4MoMlnyl7jPBB+ATULxhFwF8GU4fcxBCnSKsSbvZfJjpixi4Z
         YVXc6vmELFI1uYLYEhG/7OM8zbqTXFRqW1IvltGiZW/yW0k8zjTZSC8VbkxFadqOG3LR
         V21fymRR2fZWcBcUmmgCcuZufSZ/rmR5RvuCe/Qx4Z3Wk11uQiVG+hoboKBA4dOmOHjt
         7kqfwbEgPMjBtcW6RHNalQ1es7h/INQfj7ghYVo18Pp/7Wj2wNOY113Hyrn0vBGj53zE
         MZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTw3mLvrzwBkOX51yllaP/Ijq7vXoJECBoiaMUruHn7QL6FypqOs9LC5SOUk7ki+PzAW72aLYnh9rAYzXp0/eol8mw
X-Gm-Message-State: AOJu0YxOvKRuMKOKTJrEtbTy2EaYti8zVerag8fyqL4E+Qr9Wa7jaxcq
	fVA3GwGPXq1Sg0IzeudJehI4FExuXGi3QhuDKePVOUsDrmK6AXjA+27dI2KTrBygMfpjjNvdG9V
	DQc0z47lB5xKhNFBrABpkrspv3GH/jGbdGM4mYQ==
X-Google-Smtp-Source: AGHT+IGgndwZ3xqfDhf4CyJqUlqHUpBRYWacoRvVkoWzKCTwU3GtudllRjOr+s4vd+S8mdhVeoofK0l9Hh+AwBW0mGw=
X-Received: by 2002:a05:6a20:17a2:b0:1a3:67fd:46b1 with SMTP id
 bl34-20020a056a2017a200b001a367fd46b1mr3653617pzb.36.1711772130610; Fri, 29
 Mar 2024 21:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
 <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
 <CAADnVQJ_ZCzMmT1aBsNXEBFfYNSVBdBXmLocjR0PPEWtYQrQFw@mail.gmail.com>
 <CALz3k9icPePb0c4FE67q=u1U0hrePorN9gDpQrKTR_sXbLMfDA@mail.gmail.com>
 <CAADnVQLwgw8bQ7OHBbqLhcPJ2QpxiGw3fkMFur+2cjZpM_78oA@mail.gmail.com>
 <CALz3k9g9k7fEwdTZVLhrmGoXp8CE47Q+83r-AZDXrzzuR+CjVA@mail.gmail.com>
 <CAADnVQLHpi3J6cBJ0QBgCQ2aY6fWGnVvNGdfi3W-jmoa9d1eVQ@mail.gmail.com>
 <CALz3k9g-U8ih=ycJPRbyU9x_9cp00fNkU3PGQ6jP0WJ+=uKmqQ@mail.gmail.com>
 <CALz3k9jG5Jrqw=BGjt05yMkEF-1u909GbBYrV-02W0dQtm6KQQ@mail.gmail.com>
 <20240328111330.194dcbe5@gandalf.local.home> <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
In-Reply-To: <CAEf4BzYgzOti+Hfdn3SUCjuofGedXRSGApVDD+K2TdG6oNE-pw@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Sat, 30 Mar 2024 12:16:52 +0800
Message-ID: <CALz3k9hm6U90K8+d7SprXiKvscRjFno83idqYneHEVwgs4pCiw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Quentin Monnet <quentin@isovalent.com>, bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 7:28=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 28, 2024 at 8:10=E2=80=AFAM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Thu, 28 Mar 2024 22:43:46 +0800
> > =E6=A2=A6=E9=BE=99=E8=91=A3 <dongmenglong.8@bytedance.com> wrote:
> >
> > > I have done a simple benchmark on creating 1000
> > > trampolines. It is slow, quite slow, which consume up to
> > > 60s. We can't do it this way.
> > >
> > > Now, I have a bad idea. How about we introduce
> > > a "dynamic trampoline"? The basic logic of it can be:
> > >
> > > """
> > > save regs
> > > bpfs =3D trampoline_lookup_ip(ip)
> > > fentry =3D bpfs->fentries
> > > while fentry:
> > >   fentry(ctx)
> > >   fentry =3D fentry->next
> > >
> > > call origin
> > > save return value
> > >
> > > fexit =3D bpfs->fexits
> > > while fexit:
> > >   fexit(ctx)
> > >   fexit =3D fexit->next
> > >
> > > xxxxxx
> > > """
> > >
> > > And we lookup the "bpfs" by the function ip in a hash map
> > > in trampoline_lookup_ip. The type of "bpfs" is:
> > >
> > > struct bpf_array {
> > >   struct bpf_prog *fentries;
> > >  struct bpf_prog *fexits;
> > >   struct bpf_prog *modify_returns;
> > > }
> > >
> > > When we need to attach the bpf progA to function A/B/C,
> > > we only need to create the bpf_arrayA, bpf_arrayB, bpf_arrayC
> > > and add the progA to them, and insert them to the hash map
> > > "direct_call_bpfs", and attach the "dynamic trampoline" to
> > > A/B/C. If bpf_arrayA exist, just add progA to the tail of
> > > bpf_arrayA->fentries. When we need to attach progB to
> > > B/C, just add progB to bpf_arrayB->fentries and
> > > bpf_arrayB->fentries.
> > >
> > > Compared to the trampoline, extra overhead is introduced
> > > by the hash lookuping.
> > >
> > > I have not begun to code yet, and I am not sure the overhead is
> > > acceptable. Considering that we also need to do hash lookup
> > > by the function in kprobe_multi, maybe the overhead is
> > > acceptable?
> >
> > Sounds like you are just recreating the function management that ftrace
> > has. It also can add thousands of trampolines very quickly, because it =
does
> > it in batches. It takes special synchronization steps to attach to fent=
ry.
> > ftrace (and I believe multi-kprobes) updates all the attachments for ea=
ch
> > step, so the synchronization needed is only done once.
> >
> > If you really want to have thousands of functions, why not just registe=
r it
> > with ftrace itself. It will give you the arguments via the ftrace_regs
> > structure. Can't you just register a program as the callback?
> >
> > It will probably make your accounting much easier, and just let ftrace
> > handle the fentry logic. That's what it was made to do.
> >
>
> I thought I'll just ask instead of digging through code, sorry for
> being lazy :) Is there any way to pass pt_regs/ftrace_regs captured
> before function execution to a return probe (fexit/kretprobe)? I.e.,
> how hard is it to pass input function arguments to a kretprobe? That's
> the biggest advantage of fexit over kretprobe, and if we can make
> these original pt_regs/ftrace_regs available to kretprobe, then
> multi-kretprobe will effectively be this multi-fexit.

Yes, we can use multi-kretprobe instead of multi-fexit
if we can obtain the function args in kretprobe.

I think it's hard. The reason that we can obtain the
function args is that we have a trampoline, and it
call the origin function for FEXIT. If we do the same
for multi-kretprobe, we need to modify ftrace_regs_caller
to:

ftrace_regs_caller
|
__ftrace_ops_list_func
|
call all multi-kprobe callbacks
|
call orgin
|
call all multi-kretprobe callbacks
|
call bpf trampoline(for TRACING)

However, this logic conflicts with bpf trampoline,
as it can also call the origin function. What's more,
the FENTRY should be called before the "call origin"
above.

I'm sure if I understand correctly, as I have not
figured out how multi-kretprobe works in fprobe.

Thanks!
Menglong Dong

>
> > -- Steve
