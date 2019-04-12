Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF3C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 16:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DE320850
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 16:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="oOvUgfgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfDLQPD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:15:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37330 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfDLQPD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 12:15:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so12695385wrm.4
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 09:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1qnKcj/b9OFGPtYDXucN54O3UUd0wcRt86lwVm7G1M=;
        b=oOvUgfgglaZYITXGKoOI6oLUuLtPzzJezklItqNNR7eXuBUbrv/s0fC6KX+AmOnFDL
         GyGmfwS4shbdi8VsjC/hebFNBwUBVlKc/Li4M5N8+TObaBpTUpOiEQPvzmp3gnyo3wTz
         /0CrKjAHu6cEDLj3pvonBFk1k9az9MsqZkMURjBFHCDP6tTa5c0/bd6d8Sn7YGbOxC4g
         SYmsfVPlC7paE87eMKabUATc3lOOKJ1TyiP1Slzmxw6/qVWAuvnOx3sJ84BaSobWAQ2y
         JVBfUwX+gbBDMFVelhTqm1mJOJyen5xGjfzegol0W0Djory8AdjPypuLhtHNrv/9Zybh
         vQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1qnKcj/b9OFGPtYDXucN54O3UUd0wcRt86lwVm7G1M=;
        b=Q9whWz3tjgTawhoFFNVy4jBvE/+KBDnuRnZ2tq0Yf6K3czZ0xcRw+Zlwy3SnSWHFA3
         g5/Yao2DSTB9jzKjgF3G+4p2TR0J2EsRiHaJAtJo7REg7YLOKbYAN1BQDJ44jY7WRB96
         BnmOWAtUhCD1LABHMCNVhHNj+DWk/OrkPFtcStJbVf0oFsUTcfPaGpENMKbsVZnIJ8G7
         wBIclRdjKymqKmMgZfmtmDcYBTKSa1TpaNSJPCjUkQWB4X8inMgfgvVCU/cYxzgtA0za
         uvPOwt2adbOUj7/+XuVJuj6JwUJFrSnlYfwvvUmLT+a95jwOJzTdjU0BPtNFvCUp9JMT
         +VZQ==
X-Gm-Message-State: APjAAAUgYmXgDdHacga39iYWKRQgluLNQoi/aqbArPePKQj9egxHYqmv
        liWyx2pkWaG9wNFely2ymGF/+ZiNunEA9asl45PtPg==
X-Google-Smtp-Source: APXvYqzXBbw4qFsVAd5r1j0MesUJUAXlRpsOputi7CfNF+IsIbQStChKOiTbiwq9sslRjkbKiryzN2Nr0MpO8IM1wek=
X-Received: by 2002:a05:6000:5:: with SMTP id h5mr36481031wrx.271.1555085701703;
 Fri, 12 Apr 2019 09:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
 <1554925833-7333-6-git-send-email-jiong.wang@netronome.com>
 <20190410195218.303d4a6c@cakuba.netronome.com> <3A9F4205-577C-4E64-8400-0D476F08459E@netronome.com>
 <20190411094456.1fabc52d@cakuba.netronome.com> <078E22BB-54CD-4AA2-A240-1FD822189B44@netronome.com>
In-Reply-To: <078E22BB-54CD-4AA2-A240-1FD822189B44@netronome.com>
From:   Jiong Wang <jiong.wang@netronome.com>
Date:   Fri, 12 Apr 2019 17:14:47 +0100
Message-ID: <CAMsOgNDOqPuBY9b8fJL64ZPAz8tHYXGPwq3FeCZYQnb3n38H3w@mail.gmail.com>
Subject: Re: [oss-drivers] Re: [PATCH/RFC v2 bpf-next 05/19] bpf: split read
 liveness into REG_LIVE_READ64 and REG_LIVE_READ32
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 11, 2019 at 5:53 PM Jiong Wang <jiong.wang@netronome.com> wrote:
>
>
> > On 11 Apr 2019, at 17:44, Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> >
> > On Thu, 11 Apr 2019 07:13:03 +0100, Jiong Wang wrote:
> >>>> @@ -1150,17 +1150,17 @@ static int mark_reg_read(struct bpf_verifier_env *env,
> >>>>                            parent->var_off.value, parent->off);
> >>>>                    return -EFAULT;
> >>>>            }
> >>>> -          if (parent->live & REG_LIVE_READ)
> >>>> +          if ((parent->live & REG_LIVE_READ) == flags)
> >>>>                    /* The parentage chain never changes and
> >>>> -                   * this parent was already marked as LIVE_READ.
> >>>> +                   * this parent was already marked with all read bits.
> >>>
> >>> Do we have to propagate all read bits?  Read64 is strictly stronger
> >>> than read32, as long as read64 is set on the parent we should be good?
> >>
> >> We should be good, but I doubt there is value to differentiate on this in this
> >> kind of HOT function.
> >
> > The entire if clause is an optimization.  I'm saying you can maintain it
> > as more aggressive.
>
> What I mean is I suspect the read width could be quite consistent in real program,
> the percentage for doing extra check on read64 could actually be mishit for
> most of the time, if the propagation iterations is big the extra check done each
> time may overcome the propagation pruned.
>
> I will do some benchmarking on this to see the real gain.

Take bpf_lxc.o for example, it has ~3 million mark_reg_read
propagation iteration.

Adding extra (parent->live & REG_LIVE_READ64) check cuts off 18% ~ 25%
propagation iterations in exchange of 75% iterations are doing one more check
(parent->live & REG_LIVE_READ64).

Given the propagation contains several statement, I think we are better off
adding such check (also done some ktime_get_real_ts64 run timing measure, but
the results is not very consistent).

Will add it in v3.

Regards,
Jiong
