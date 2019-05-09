Return-Path: <SRS0=dMgm=TJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C6EC04AB1
	for <bpf@archiver.kernel.org>; Thu,  9 May 2019 10:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B002084E
	for <bpf@archiver.kernel.org>; Thu,  9 May 2019 10:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvLNX6ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfEIKwU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 9 May 2019 06:52:20 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45679 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfEIKwT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 May 2019 06:52:19 -0400
Received: by mail-yw1-f65.google.com with SMTP id w18so1472730ywa.12
        for <bpf@vger.kernel.org>; Thu, 09 May 2019 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7JBnque1NuQV5E53NMd1BdyCPC6zb7SaKk+9RKtMUiY=;
        b=vvLNX6eiYqoP5M5ysr7X/Z5reI20uuW8H0FC5f1Fzp+BO95VdKvk/ZGxatewGaL8d1
         rWm20EQZ49RJnWtdJH08xwNjOKTXItRG8HkkY+G/p3wD/5a05YgTN57tTpdKNwKrWn52
         BzqhgTUpSjvXLXLu2zZqakZjvfBR+3apwuj/8C9wgCvE2t3VjaywR5QUd0qezfCvLdvi
         XDKaGe9OjDOue4OoZorFjXJeZf/PxA6uvRXYoHEmVv1E/dcLcOCZl/0lK/g+Q/nJZ333
         4xjWdHGWXhWnHsVXaMddREVD1gFN/Wakyce0WdGkN1W/qGHWpAUBcF36g1uRxuDOlylF
         gDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7JBnque1NuQV5E53NMd1BdyCPC6zb7SaKk+9RKtMUiY=;
        b=DUoYneU8Lr/J9pUQmoQ4p/7UBeT3RxkrCPuxB46myibHykDe6Gah8Vo/j5Q2uBHDCb
         pBj/wi9eRsnngGy1IUiaMK2VDhNkz0xM6n4qGMBCfCMDj4TRVbuum7IQ1Q25j/Rwus5K
         W2Cj9uI5Tgc7+819+gxZoI6/FNMq77cYaoRs+DE40R05a3ZdP9GoYwNgwLzMGOUrfjze
         hZLHpJiENBECIr1N5Ei3fpRuN1en8XAkiDNzQHfJlNrYbWBnqZm4/a6YrRH9BH1J2pqm
         JZRs6G37ESm4JWHWF67maCUOYgkInG9Ruvei061kHTSceqIB3w92D3tPGgOudsiRKqv1
         pfeg==
X-Gm-Message-State: APjAAAUiCMUX/i1B750/U0geuWj/Y1ScLXAOiCOtMVs4T9OTzJDTx6iq
        RLeagb8/pCSa6cFoQuYZ3RAaMatDuuO04lW19jBtMg==
X-Google-Smtp-Source: APXvYqzlnk/eTiaEZ/j1o2X3/sYKAu95wxM88iuGS/+MVOjD/Uheq/18AddxtpECIbK9mihkcpwUsSyVAfYzKO3RhdM=
X-Received: by 2002:a81:27cc:: with SMTP id n195mr1571719ywn.60.1557399138671;
 Thu, 09 May 2019 03:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iL_XLb5C-+DY5PRhneZDJv585xfbLtiEVc3-ejzNNXaVg@mail.gmail.com>
 <20190508230941.6rqccgijqzkxmz4t@ast-mbp> <CANn89iL_1n8Lb5yCEk3ZrBsUtPPWPZ=0BiELUo+jyBWfLfaAzg@mail.gmail.com>
 <20190509044720.fxlcldi74atev5id@ast-mbp>
In-Reply-To: <20190509044720.fxlcldi74atev5id@ast-mbp>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 9 May 2019 03:52:07 -0700
Message-ID: <CANn89i+v52ktezz5J_0of_EvTUozf86rP1Uh36HpbHf33uzDJg@mail.gmail.com>
Subject: Re: Question about seccomp / bpf
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 8, 2019 at 9:47 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 08, 2019 at 04:17:29PM -0700, Eric Dumazet wrote:
> > On Wed, May 8, 2019 at 4:09 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, May 08, 2019 at 02:21:52PM -0700, Eric Dumazet wrote:
> > > > Hi Alexei and Daniel
> > > >
> > > > I have a question about seccomp.
> > > >
> > > > It seems that after this patch, seccomp no longer needs a helper
> > > > (seccomp_bpf_load())
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bd4cf0ed331a275e9bf5a49e6d0fd55dffc551b8
> > > >
> > > > Are we detecting that a particular JIT code needs to call at least one
> > > > function from the kernel at all ?
> > >
> > > Currently we don't track such things and trying very hard to avoid
> > > any special cases for classic vs extended.
> > >
> > > > If the filter contains self-contained code (no call, just inline
> > > > code), then we could use any room in whole vmalloc space,
> > > > not only from the modules (which is something like 2GB total on x86_64)
> > >
> > > I believe there was an effort to make bpf progs and other executable things
> > > to be everywhere too, but I lost the track of it.
> > > It's not that hard to tweak x64 jit to emit 64-bit calls to helpers
> > > when delta between call insn and a helper is more than 32-bit that fits
> > > into call insn. iirc there was even such patch floating around.
> > >
> > > but what motivated you question? do you see 2GB space being full?!
> >
> >
> > A customer seems to hit the limit, with about 75,000 threads,
> > each one having a seccomp filter with 6 pages (plus one guard page
> > given by vmalloc)
>
> Since cbpf doesn't have "fd as a program" concept I suspect
> the same program was loaded 75k times. What a waste of kernel memory.
> And, no, we're not going to extend or fix cbpf for this.
> cbpf is frozen. seccomp needs to start using ebpf.
> It can have one program to secure all threads.
> If necessary single program can be customized via bpf maps
> for each thread.

Yes,  docker seems to have a very generic implementation and  should
probably be fixed
( https://github.com/moby/moby/blob/v17.03.2-ce/profiles/seccomp/seccomp.go )
