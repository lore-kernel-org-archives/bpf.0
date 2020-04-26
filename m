Return-Path: <SRS0=vf2x=6K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EC9C54FCB
	for <bpf@archiver.kernel.org>; Sun, 26 Apr 2020 16:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74AB02071C
	for <bpf@archiver.kernel.org>; Sun, 26 Apr 2020 16:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnenXyc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDZQ6H (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgDZQ6G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Apr 2020 12:58:06 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CFFC061A0F;
        Sun, 26 Apr 2020 09:58:06 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so15008912ljg.8;
        Sun, 26 Apr 2020 09:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aV98zQdV8iudGcxnrL0ms1R5hGO42Yy4wHIwVeHIFzw=;
        b=lnenXyc4wVsIebDM9zhdUA7ipYBIUfGtT9xUEgWocdxv6z3QTNV+c/pIPNmroHVF/R
         HykcjDcWd858Wmo6KUlxNjFI1rvEbMPawksc8dGiZ+RKj29/92J3z/iGsQ+2Cnwcs1/x
         5W0QAGNeUX/jl8pSwGVozfArA8qA7XkgSPFDmx0eGY55IM4WTzHTLUJXZv0wjC0971vA
         UYxLJM3AKWUtI9MGmzpu3G8jj9Kve+dhLvwyAekIW8ZlXWlTXXPDq3OFa6Zk7jbNslPQ
         nBR9MqwuHdQOTz1/hM18oqTp9kPbVjG2CtH/n6ohsaxX7DeonGEbdiD1MLpSqLoUrWYd
         SQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aV98zQdV8iudGcxnrL0ms1R5hGO42Yy4wHIwVeHIFzw=;
        b=KmctH62P5WwT5qlqd8dWbj+HuCmxTkRjLWaWyz0ueN4bg5twiByx4jeE/3Dqbxm/2l
         mJItbAQVS0j9kEWcezYjHFPLb0igErbOu/hVgdfxmO8x8BSaN7EO1Gs41SbG//Qg82pj
         3b4di96z6y0QUCxyWYBQ2KbK8s/6NRezdrREE5+JDjfK0IoVYvtFk4jXPm9s4SLHkr8E
         dyoYXMNMrLlLos70mShir45Vr69MK/LPH+MnurEyr1S9E3H45HOI11hHVA6eGRJakBqT
         HwX1TpMLNN/nkMF/9eck5gb4/HQTwelotDXnaTZVWw473fOwUWYvHqWye0MCRjktSMLZ
         8xEw==
X-Gm-Message-State: AGi0PubUTXPzB57IH1w9gjwrUE4PAuG5+NTt1HmMaVXWSkFGZXHQpPrd
        EBAODmZNpfU3f3cwYgnQdRdXfH2AAeNcMOSknWI=
X-Google-Smtp-Source: APiQypIq1bZWROrVwXFOoU0Szj6S8Gg8+/GYTq9qx4zvNdsKhPeYnGOLgyQYv8iKfWp3jTzciPq9jrQ6jP84b2etcpw=
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr12002133ljo.212.1587920284678;
 Sun, 26 Apr 2020 09:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200423195850.1259827-1-andriin@fb.com>
In-Reply-To: <20200423195850.1259827-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 26 Apr 2020 09:57:53 -0700
Message-ID: <CAADnVQL4koqLqxxVgMSk42XYNTAzdauRa0PwEzHb0L+fXoE_rQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] bpf: make verifier log more relevant by default
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 23, 2020 at 1:04 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> To make BPF verifier verbose log more releavant and easier to use to debug
> verification failures, "pop" parts of log that were successfully verified.
> This has effect of leaving only verifier logs that correspond to code branches
> that lead to verification failure, which in practice should result in much
> shorter and more relevant verifier log dumps. This behavior is made the
> default behavior and can be overriden to do exhaustive logging by specifying
> BPF_LOG_LEVEL2 log level.
...
> On success, verbose log will only have a summary of number of processed
> instructions, etc, but no branch tracing log. Having just a last succesful
> branch tracing seemed weird and confusing. Having small and clean summary log
> in success case seems quite logical and nice, though.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

I think the behavior described in the last paragraph could be
surprising to some folks who expected to see the verifier log for
successfully loaded progs.
May be worth mentioning this in Documentation/networking/filter.txt ?
That doc needs some cleanup too.

Applied. Thanks
