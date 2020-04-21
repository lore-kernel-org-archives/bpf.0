Return-Path: <SRS0=GPe9=6F=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B15EC54FCC
	for <bpf@archiver.kernel.org>; Tue, 21 Apr 2020 18:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416772068F
	for <bpf@archiver.kernel.org>; Tue, 21 Apr 2020 18:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjRk1R9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgDUSyh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725870AbgDUSyh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Apr 2020 14:54:37 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE7C0610D5
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 11:54:35 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id u5so14442123ilb.5
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2020 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=N4tFyC4/8EGMbXolZNQ8jkjVWob5gaEliR9rHnKxF3Q=;
        b=fjRk1R9DZllfo7oUrdZY7SY0VSwueEG4ZlCrWv27C00sI9b+3NiKyCT0H/9EGMCpDD
         fjanlkk8/vOcrxTB+d+qGM+jwi+8fibLiyZcR4qRuh/FTkydSibQVcEcIcHFCetUABUs
         wbqL1pY3PIkOmZt7Qcri5pdSIGrxPnUDJ2egxezBPvP/fLObFdVTyNQp+hYuro0amYYo
         Cwce/dpRffTbxwoXpuOc4+UjSWR4+CRldfilZOmkuaZjN9OYkqCI47jFylaiSyRy8pkm
         F6Stqx8VZAJgRmtpmvMdkRTdyM9wDJEYPm2Klumi1/mn2X3U4MrZOH0D6y/ES3cczhlA
         q9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=N4tFyC4/8EGMbXolZNQ8jkjVWob5gaEliR9rHnKxF3Q=;
        b=bHnP/UnMOJZIcOiJ0bMPLvbHm2oWNnGQ6C47KnPYZpaZWFafeksPDcG7uFW8izYfKj
         BZUVJ8GVmfsO4SdA6SvBTstAHV/T6vzJSDaLyzo41crU15U4Np1acASQBa9EEOw10Kx3
         deVfLIYjorIvkorF/nZf/y1K8+vXB4wSKy9Un3gcFdwu1DBYLrN5s580tV3wCEiuqcP8
         zr1ofctr3aRf2FNXuVpFMrIQxjoZJGbL7uv6rsNIBGuxDc7Y3g8jJWensBzv0Lm9jy+W
         4+toXWCJoqWFWMmr6vclygs1ou95aO1O0alDOAEbs7k+kbidk6MYEvOx8jyWp1cfBrxk
         cm2w==
X-Gm-Message-State: AGi0PuZPel/NYGIXSIuHJTxEp9wCjgSf9zOxgquWRV43XLRG0C2IGBXD
        Rp5nBJJXk399+R2lFMt8r9GR/Ny+YI0=
X-Google-Smtp-Source: APiQypJLI8DPNlHplMYyw3Q+dTL3uCqltOYxzyiJbMhzxgtf454V90l/LeB3vJk5AYBPgW1wi93UBA==
X-Received: by 2002:a92:cf02:: with SMTP id c2mr15380643ilo.259.1587495275261;
        Tue, 21 Apr 2020 11:54:35 -0700 (PDT)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id g22sm259029ioc.41.2020.04.21.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 11:54:34 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:54:25 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Gilad Reti <gilad.reti@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Message-ID: <5e9f416193390_5d0f2af88f64e5bc58@john-XPS-13-9370.notmuch>
In-Reply-To: <CANaYP3EMYbeg67O5O1sjcHBF3MFhB+dyKYywr8i-VQwoFHWcaA@mail.gmail.com>
References: <CANaYP3GNm-siPt49Z5SSvgcF9YT4oN_enznMkaEFgbBBC9qrDQ@mail.gmail.com>
 <20200401232849.wms6vfuozvis5t2s@ast-mbp>
 <CANaYP3GgpWKpiW-ATQ6UYLwNWJ3EqBKf-6d8Ki4xWXHVBOGvQw@mail.gmail.com>
 <CAADnVQLfZv=1H_CuJwOyJK+=9iv=bdA7yCbMta0G2bqh6EmXRw@mail.gmail.com>
 <CANaYP3EMYbeg67O5O1sjcHBF3MFhB+dyKYywr8i-VQwoFHWcaA@mail.gmail.com>
Subject: Re: probe_write_common_error
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Gilad Reti wrote:
> On Thu, Apr 2, 2020 at 6:38 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > re-added mailing list back. pls don't remove it from cc.
> Sorry, this wasn't on purpose.
> >
> > On Thu, Apr 2, 2020 at 1:05 AM Gilad Reti <gilad.reti@gmail.com> wrote:
> > >
> > > On Thu, Apr 2, 2020 at 2:28 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Mar 31, 2020 at 07:16:28PM +0300, Gilad Reti wrote:
> > > > > When I try to probe_write_common into a writable location (e.g a
> > > > > memory address on a usermode stack) which is not yet mapped or mapped
> > > > > as read only to the memory, the function sometimes return a EFAULT
> > > > > (bad address) error. This is happening since the pagefault handler was
> > > > > disabled and thus this memory location won't be mapped when the
> > > > > function tries to write into it, an error will be returned and no data
> > > > > will be written.
> > > > > Is that behavior intended? Did you want those functions to have as
> > > > > less side-effects are possible?
> > > >
> > > > You mean bpf_probe_write_user() helper?
> > > Well yes, but it calls probe_write_common which disables the pagefault
> > > handler so I asked about it.
> > > > Yes it's a non-faulting helper that will fail if prog is trying to
> > > > write into a valid memory that could have been served with minor fault.
> > > > The main reason for this is that bpf progs are not allowed to sleep.
> > > > We're working on sleepable bpf progs that will be able to do copy_from/to_user
> > > > from the context where it is safe to sleep. Like syscall entry.
> > > Thanks!
> > > > Could you please share more about your use case, so we can make sure
> > > > that it will be covered by upcoming work?
> > > Sure. I was playing with modifying kprobed syscall parameters (for
> > > example, changing the path of an openat syscall etc).
> >
> > yes, but what is the use case?
> > Why do you want to modify path of openat syscall?
> I had no specific use case. I have seen that eBPF can modify usermode
> memory and wanted to experiment with that...

Late reply but figured its worth adding a concrete example.

We have a use case to read user memory from syscall (args when they are
pointers to memory for example) where we can cause a page fault. Sleepable
bpf progs with copy helpers would solve this for us.

Thanks,
John
