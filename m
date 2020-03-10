Return-Path: <SRS0=x1rW=43=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66781C18E5A
	for <bpf@archiver.kernel.org>; Tue, 10 Mar 2020 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F530222C4
	for <bpf@archiver.kernel.org>; Tue, 10 Mar 2020 21:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qow1Yly0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCJVjg (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:39:36 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43352 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJVjg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 17:39:36 -0400
Received: by mail-ua1-f65.google.com with SMTP id o42so5257211uad.10
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdlXGBu011eILr6E7BKeOR6UiLq6Vdo/qhWhU5E0PbY=;
        b=qow1Yly0Eo6wNCVCAXCutaqv7CgN7WaQcfi68e6dnzv9swNvIzu6OER4ZCvTlqsND0
         v/wSUS0v8kJvwGnHBDvYrjU3aL1TVqj1p8lgA60b+qp0HENgTLb+f9Kd0py+Z1tnFnPu
         4oj7QZuEgxniGPxwYyBRmG/Asfmc41HbYw9i+H5IuuLAVAcNxQN0lZE/LiC3uw6+w6SC
         VytsXj/SMfOm5I3i8dxSxO3ukRTE9VzrnqduCBzKbYwFatcJezX15OG0D0I5/L6bBnoO
         uaRDM/xM6Y1p1fLIouawRKNZadIjdXjfmkxW2UYmlOg5Y7++zGD7F/xYSx+5wsKlVUUr
         GiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdlXGBu011eILr6E7BKeOR6UiLq6Vdo/qhWhU5E0PbY=;
        b=VhgBq50+mTk8fvnOim/rbPIRcdTh+ndSHv7toFM75RrdTStYIR2qVPFFVRakJyewIL
         7HRqznQWxuAgEVKISDNwaqrL4uRAoItf7foDTC8XDQ250nsRP/wRBrBpJYl7RnZXQgQy
         qqAFrmPWZDQiiuUeZUsHFTR4fmLwGrxB3SJ7WIjQVE6+QSnipj8sVnSLp9ixh1mqj1f/
         rqtJ2v5D36wJPA/WCol5WQ+fpLGiY9gVgNuRKoiMJOIuHEYbsaHwjHtUHG+DEK5UtAz2
         j08+mDncWkedlDohSHmQZJZuE65sxzhsYmhTAk35HnqK9pR1wB8cA7HCWT775Ny9Zjh1
         MJqg==
X-Gm-Message-State: ANhLgQ1NCp5xwJaQl7wC/TpLV/6lZLlLruFgwzlcwyU/bmDOXo8uaBLv
        B6K4J6VRSu6aTzxuH9GN6rlea2yrGSFwdk6TdA7Axw==
X-Google-Smtp-Source: ADFU+vvrCP8710FwovNQiq3TRDaasFyzXucpbPikePRLc6w5tbh734JpqREX6WUJxdQfuVbpX+V0ftICxermILFQWdA=
X-Received: by 2002:ab0:2851:: with SMTP id c17mr13587156uaq.63.1583876374973;
 Tue, 10 Mar 2020 14:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200310185003.57344-1-irogers@google.com> <20200310195915.GA1676879@tassilo.jf.intel.com>
In-Reply-To: <20200310195915.GA1676879@tassilo.jf.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 10 Mar 2020 14:39:23 -0700
Message-ID: <CABPqkBRQo=bEOiCFGFjwcM8TZaXMFyaL7o1hcFd6Bc3w+LhJQA@mail.gmail.com>
Subject: Re: [PATCH] perf tools: add support for lipfm4
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 10, 2020 at 12:59 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Tue, Mar 10, 2020 at 11:50:03AM -0700, Ian Rogers wrote:
> > This patch links perf with the libpfm4 library.
> > This library contains all the hardware event tables for all
> > processors supported by perf_events. This is a helper library
> > that help convert from a symbolic event name to the event
> > encoding required by the underlying kernel interface. This
> > library is open-source and available from: http://perfmon2.sf.net.
>
> For most CPUs the builtin perf JSON event support should make
> this redundant.
>
We decided to post this patch to propose an alternative to the JSON
file approach. It could be an option during the build.
The libpfm4 library has been around for 15 years now. Therefore, it
supports a lot of processors core and uncore and it  is very portable.
The key value add I see is that this is a library that can be, and has
been, used by tool developers directly in their apps. It can
work with more than Linux perf_events interface. It is not tied to the
interface. It has well defined and documented entry points.
We do use libpfm4 extensively at Google in both the perf tool and
applications. The PAPI toolkit also relies on this library.

I don't see this as competing with the JSON approach. It is just an
option I'd like to offer to users especially those familiar
with it in their apps.

> Perhaps you could list what CPUs it actually supports over
> the existing JSON tables.
>
> If it's only a few it would be likely better to add
> appropiate json files.
>
> If it's a massive number it might be useful, although
> JSON support would be better for those too.
>
> -Andi
