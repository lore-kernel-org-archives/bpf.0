Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F8BC4727E
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 01:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB296216C4
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 01:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ptvbu4P9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgI2Bl0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Sep 2020 21:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI2Bl0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 21:41:26 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613F2C061755;
        Mon, 28 Sep 2020 18:41:25 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u8so3605014lff.1;
        Mon, 28 Sep 2020 18:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Abk1BbjdM00OPRd2uWXilrq7XrEyhsA1YlL5eIiAOQk=;
        b=Ptvbu4P9DCSuekWRtfhjMZE06Me6IMHCoxGgTUCYPevR8cH5RNlW86knbQQDPhAtuI
         M13rD57niMA36oBQACsQezC4knFkkAzwu6Gq1/trQaVmygY16yctQGLKOJ6XNEx9m4Iw
         gIP0qKgLuam6QHnm5MyJQs55EbdANVKO3KlYfCs9mdXL4e6mshCAJV6nflznYI9ZgN0L
         XfuXCJ1mfg98O9lUbExY1tK5tBlTpZVdGI6qv4I9shpI39mZxVQWHRm575ntMtreflLN
         U6QTrkHIOOnWoJHDFQCZgxgO2K+kN+68UyXwYYTdc1GhMJAhNK0XA9lxS3sxgcPbTprS
         FrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Abk1BbjdM00OPRd2uWXilrq7XrEyhsA1YlL5eIiAOQk=;
        b=jSkB3rWPRYJguh4H/DivRE3KC81x3PEXbJdJQhx++G2Jkq4pHTIQrPPw1TUSZmJVjN
         MzB38DjY6Olsh1+ZWHyC+WodTI3eMXN6zLYoK21/BGiJ/OOBhQEXf1Hl5vtJ3C1sruNM
         oiqYxW+Ji0HmOLRn3WiZplGhrghYHOdJFhHL0sqy3vVumDctMG06TAIner0lpUfuEX+q
         5vvILDh+lGoQU+Nlk/IDOdIUEVZHhOhmmZTdHY5JOpWC/IBKGMxVWtxrFbyXWbKR+3Hy
         b/fa5/mW9DBgmLlv8CG+iZeaKqcuCBWhRkdYOx2lv6q6H2CJCr++bBSgBzjA749prIwW
         XsPw==
X-Gm-Message-State: AOAM5325Z9AJGcNVv2WMrznQwh7Rc3GLbefhFWgH/Rcqv+Na8YQBekPr
        5anrw0EWVLG+ITx6zEk5/kJM54HvWfXwR4xPv5I=
X-Google-Smtp-Source: ABdhPJxxF3quQ4a9pf5J7PQ5Ts2VVam9GUZMb+6YyxfzFXvPphQaXipRI0kMcEUXYzR9EzjEflvD/4WvC+ouOCDl0Cw=
X-Received: by 2002:a19:8606:: with SMTP id i6mr303196lfd.263.1601343681439;
 Mon, 28 Sep 2020 18:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <1601292670-1616-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1601292670-1616-1-git-send-email-alan.maguire@oracle.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 28 Sep 2020 18:41:10 -0700
Message-ID: <CAADnVQ+Va+gZQb2ShMB3yS3SpW-2uuqe9GL+Hz0A8NZkiNhsEA@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 0/8] bpf: add helpers to support BTF-based
 kernel data display
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Andrey Ignatov <rdna@fb.com>, scott.branden@broadcom.com,
        Quentin Monnet <quentin@isovalent.com>,
        carlos antonio neira bustos <cneirabustos@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 28, 2020 at 4:33 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Default output for an sk_buff looks like this (zeroed fields
> are omitted):
>
> (struct sk_buff){
>  .transport_header = (__u16)65535,
>  .mac_header = (__u16)65535,
>  .end = (sk_buff_data_t)192,
>  .head = (unsigned char *)0x000000007524fd8b,
>  .data = (unsigned char *)0x000000007524fd8b,
>  .truesize = (unsigned int)768,
>  .users = (refcount_t){
>   .refs = (atomic_t){
>    .counter = (int)1,
>   },
>  },
> }
>
> Flags can modify aspects of output format; see patch 3
> for more details.

Applied. Thanks a lot.
