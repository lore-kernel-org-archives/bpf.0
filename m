Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4881AC10F0E
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 05:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EF22075B
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 05:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aoe+Zack"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfDOFmC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 01:42:02 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42765 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfDOFmC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 01:42:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id w23so12016632lfc.9;
        Sun, 14 Apr 2019 22:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJRzO5AO2VVdKpsZ5azaSsfwc0Wer5BB+qE2dKPd6pM=;
        b=Aoe+Zacktvqa1oN+ga0x+0anFIDQxbXm0BYWLS0H6vNBpYgtFR5lQLX9foT5ACDlpb
         xZYr+R+9B9Rlyr3L9d424DZONnJMiWJn8sVtRTNMS8q1VfyK86ksMYeCQ0MsGzpnc2Xm
         dgacnU5+QFx3Z8a9Z8roMMldWO6coo2OTc6qWq+Ie6ywtMY6K1IimMQrPdj6Ao16YgAA
         hxJRJw0r5U1UT5DMyBvqTnVMYkFRejhEvSeNWL702L7KcwoEEtu+qjZxWpr4JkqJuhhX
         Cn1dtVl0lJ8UjkeAkF8xxi2Zz14KdVAhi3PoQf6eyP3t/2GdfWb8QntU1vUoZ+I8HQ+b
         B3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJRzO5AO2VVdKpsZ5azaSsfwc0Wer5BB+qE2dKPd6pM=;
        b=DaO5YiZb90nFKTP+z8dtaA6YBsN7Nen6WyS52pNuSFnmLhJmeJLwMGe2Uas+LhUZIE
         zIphYSU2keC+GQwA9oxLSs4kjSAL5we8wVF4ZEQQbrRNqQqcdk5Q9AfhmusW2CcUbYL1
         uW+ga+gD7WHAwBqVZkpaa1u6fUYdW6UswKGDt4MALSIo49AowsXKrf7cvrHhepR6SfWR
         sgAfSJHyH3SH7NLWEOd1OGsDZf2BKCZgF9xyAHxxcRJk9g+h8xiepN6Dm044fYrbF5c0
         lbRfTLUs6EEUemQ2plkiNaeCN1ZwRtku1bHBUz+VnmrdXMs+ogTWVz8W+icNoPa/D1jJ
         8tTA==
X-Gm-Message-State: APjAAAVTbBcs/+r9lMQasuZ9xl2/OBIqQ1IAqRj9zUuiqDlZKdFTJRoR
        p/f8DYsqMVHbuY3rLbBNKMySLlCuJytyZjnohnl7gQ==
X-Google-Smtp-Source: APXvYqzmALhGZYhFGfKE+WQB6Alqlt/suhtyMG995xr8kuaFlhpnFSy4hF8eSKg6TRzMTwsQrQ6yCEvR9tGtCZKtTic=
X-Received: by 2002:a19:f50f:: with SMTP id j15mr36749900lfb.126.1555306920420;
 Sun, 14 Apr 2019 22:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
 <1555106392-20117-5-git-send-email-jiong.wang@netronome.com>
 <20190413001241.fiuiyd64l7vuntz5@ast-mbp.dhcp.thefacebook.com> <87ftqmfkyc.fsf@netronome.com>
In-Reply-To: <87ftqmfkyc.fsf@netronome.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 14 Apr 2019 22:41:49 -0700
Message-ID: <CAADnVQJ8osYBje-TAewjGTULJyS3-Epu48VmxWw7JcDXTrChGQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 04/19] bpf: refactor "check_reg_arg" to
 eliminate code redundancy
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 13, 2019 at 12:01 AM Jiong Wang <jiong.wang@netronome.com> wrote:
>
>
> Alexei Starovoitov writes:
>
> > On Fri, Apr 12, 2019 at 10:59:37PM +0100, Jiong Wang wrote:
> >> There are a few "regs[regno]" here are there across "check_reg_arg", this
> >> patch factor it out into a simple "reg" pointer. The intention is to
> >> simplify code indentation and make the later patches in this set look
> >> cleaner.
> >>
> >> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> >> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> >
> > The first 4 patches look great, so I've applied them to bpf-next.
>
> Thanks.
>
> > The rest needs more careful review that we'll do soon.
>
> No problem and agree they need very careful review. I understand once
> landed the optimization will be always on for a couple of targets like Arm,
> PowerPC and SPARC etc, so the correctness is critical.
>
> Patch 5 has two comments from Jakub not addressed, they are not about
> correctness so should not affect the review, I will fix them together with
> the other new comments.
>
> One good thing is high 32-bit randomization does catch a couple of corner
> case bugs so prove to be very powerful and efficient for exposing bugs. In
> v3, it is enabled on all possible tests under bpf selftests, and I haven't
> noticed regressions (my local machine configure may caused some tests
> skipped, but majority of the testsuite, especially all tests under
> test_progs/test_progs_32/test_verifier ran without failure), this is a good
> assurance of correctness.

Sounds great, but please respin the rest of patches with comments addressed.
Don't worry about spamming the mailing list.
