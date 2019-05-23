Return-Path: <SRS0=Im41=TX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E59C282DD
	for <bpf@archiver.kernel.org>; Thu, 23 May 2019 20:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0B62081C
	for <bpf@archiver.kernel.org>; Thu, 23 May 2019 20:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvEScRqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfEWU5a (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 May 2019 16:57:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44023 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfEWU5a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 16:57:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id g17so2414323qtq.10;
        Thu, 23 May 2019 13:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/A3o95sGGdl+Wp91GEMs1+11L3d+M6mnqGMfYpccU8=;
        b=CvEScRquhaybu8exnTU0oYvHv5x90Tgon8Vtf8bAGPIgjkhbPiFlfvJZPlwHmhLXmg
         hS+4x5cbh+1mfKJq2MChkGD8KV7EciLEqYaP7G1gQlqpqqA7Y3kvCFJYbcjzMxabzEur
         KoxI69PX/Pru66hkQZOAF07fzLv+X6AiRPcb33FSFiYNQgNcmPAC18OE1P6Jlb2/MoTY
         sHYCjD1L/o190tVoJNY6vG/OZnqXEoolWQaJpzKY+Es9RKiL3XIcOIwn5Ybck5AhrcV+
         x0tJzG/Ge2LYhV3NIfg3Hl5DnrcjwG93NZtVbQWTob5qZ7L/C3pz780uvGVJnQdAWtS3
         CdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/A3o95sGGdl+Wp91GEMs1+11L3d+M6mnqGMfYpccU8=;
        b=m2V5aXtjWCtpvs02UhCUiP0GmrZ+fEuJp4fOyQlh81JDmAFZEJOkNo8Ayb2qrNt/mN
         +bfQnAzSIPR7NnsjSv0XiWdt+WqYs8fHserwAMAzyXPbTZkBos3tx5DavQeA4K8tYwhY
         3/TMW2S0MrWy9iNL1CtkvIwdo1b+1R5DmAHQsyMoAIMFVJEjpE6A10OS9EMjI/aGZkrx
         giotR5TC4gEx4PG56tR5IlrH+lFsjQNn2nSyfelADLDEyWg/ZvJRRcoNAlT5oP78Mjas
         J77zNGVciU/yEcjzDCDb8MvMJbhegV6SdYtHKmthmODZHoTZS4DrpboZr+QL1zFzAhVh
         GJgQ==
X-Gm-Message-State: APjAAAX4aQCrRMRyL9fGdhY4oS5DldAIUCPr8BozaiZITPVv8XuGZ7jL
        ZQr7qubBq98SKFKszTUw+gE0jLR6XdB68+qh5uA=
X-Google-Smtp-Source: APXvYqz4YBdNM1P1vyj5RXDmouo546y7tb3K87McDDaVmlul8/TIX1wu8nuso++2tVGZuY6kL6Ran/4pVUVuFj3xvvk=
X-Received: by 2002:a0c:986e:: with SMTP id e43mr67804725qvd.78.1558645049262;
 Thu, 23 May 2019 13:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190523105426.3938-1-quentin.monnet@netronome.com>
 <20190523105426.3938-2-quentin.monnet@netronome.com> <CAEf4BzZt75Wm29MQKx1g_u8cH2QYRF3HGYgnOpa3yF9NOMXysw@mail.gmail.com>
 <20190523134421.38a0da0c@cakuba.netronome.com>
In-Reply-To: <20190523134421.38a0da0c@cakuba.netronome.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 May 2019 13:57:18 -0700
Message-ID: <CAEf4BzbyE8w1wLN33OfUgu8qGqRbxE5LbXFniucyqW4mH7mQFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] tools: bpftool: add -d option to get
 debug output from libbpf
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, oss-drivers@netronome.com,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 23, 2019 at 1:44 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Thu, 23 May 2019 09:20:52 -0700, Andrii Nakryiko wrote:
> > On Thu, May 23, 2019 at 3:54 AM Quentin Monnet wrote:
> > >
> > > libbpf has three levels of priority for output messages: warn, info,
> > > debug. By default, debug output is not printed to the console.
> > >
> > > Add a new "--debug" (short name: "-d") option to bpftool to print libbpf
> > > logs for all three levels.
> > >
> > > Internally, we simply use the function provided by libbpf to replace the
> > > default printing function by one that prints logs regardless of their
> > > level.
> > >
> > > v2:
> > > - Remove the possibility to select the log-levels to use (v1 offered a
> > >   combination of "warn", "info" and "debug").
> > > - Rename option and offer a short name: -d|--debug.
> >
> > Such and option in CLI tools is usually called -v|--verbose, I'm
> > wondering if it might be a better name choice?
> >
> > Btw, some tools also use -v, -vv and -vvv to define different levels
> > of verbosity, which is something we can consider in the future, as
> > it's backwards compatible.
>
> That was my weak suggestion.  Sometimes -v is used for version, e.g.
> GCC.  -d is sometimes used for debug, e.g. man, iproute2 uses it as
> short for "detailed".  If the consensus is that -v is better I don't
> really mind.

It's minor, so I'm not insisting at all, just wasn't sure it was
brought up. bpftool is sufficiently different in its conventions from
other modern CLIs anyways.

As for -v for version. It seems like the trend is to use -V|--version
for version, and -v|--verbose for verbosity. I've also seen some tools
option for `cli version` (subcommand) for version. Anyway, no strong
preferences from me either.
