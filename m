Return-Path: <SRS0=PVg6=UA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE88C28CC3
	for <bpf@archiver.kernel.org>; Sat,  1 Jun 2019 00:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A73927069
	for <bpf@archiver.kernel.org>; Sat,  1 Jun 2019 00:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu38rh25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfFAAIo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 31 May 2019 20:08:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39292 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfFAAIa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 May 2019 20:08:30 -0400
Received: by mail-lf1-f65.google.com with SMTP id p24so2795894lfo.6;
        Fri, 31 May 2019 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xzuq1h6sq8EOWLTganLKpew1KQPiGePlBUZOTYDAg+w=;
        b=iu38rh25pDiYoczeUiJjOe5B7LcW2J7NesqzHRtlSJRgr/HzhyEQssXkvbxmlLovk+
         6/JzzfMra6RlHgiqna3C5aha0AbindOuEhFW6tSXCEb4EzK9RxZdgUrm6p73VolZ8UxU
         sYzAG+3wJPQn0TEraF2Gfkdp+G3TTz/n1HYha2Jq+iVcnijplzQbaACVj+9tNwxQZlvU
         WLSHmcoQDY0liwDCuY05lf4UT0rYDWOXXklHmzYB+i6uPaNvee+19lFjIT9TTk3dDVf1
         lEBqVqTjoBaXWQskFvzAaXwCQcMpvpl+3QPNodxWd5KFXmraZjSBc0rTrIq3WwKetXab
         Bm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xzuq1h6sq8EOWLTganLKpew1KQPiGePlBUZOTYDAg+w=;
        b=iz6Iglp61oYlH8QkWxftcYECUyXsym9q0D561BhSBW37hO/JrJpSkIETgy6FfD7D2V
         jkf7NSgpNbUNYf7OLZHFlnAgSh2CcMz2ikxlyx7nxheDye9+KgtKoBXeUHmM9xIan1Pk
         ZqcOHIrTqwDhVBCzazUoLhkTFG6lKN7VKA3aqxXGo2Pef88YblT5omPLcpfbV0cXO2cw
         6YCxiREJL0Js2GkI5dnMC1kf0z6W7HOz5fQ0k2THSupI65vhwPXweFFMXrotdr05q5M4
         VvOb/m/bUqZTq3EX3Hgo2o7DAgF+o7/Nnb4Lhl4+U/50FqLz7PLUlsnQKHCrNghVEUjo
         cUpw==
X-Gm-Message-State: APjAAAVofNaRL82AuuC4b1uijj8UdseIf2Iua0pF9Nkx49T7YnvN0MTI
        BxnGXr4zK/ogIIv56FMfpP5870MAUg1MgYD87ds=
X-Google-Smtp-Source: APXvYqxbkswevXFQW3SzXQ2/rMCy6QOLFwtz67AnR1ohWBat8Ola0weMsfBQkgGznR1f7VbK4++glFrQZGr9w+2vcAI=
X-Received: by 2002:ac2:46f9:: with SMTP id q25mr7736437lfo.181.1559347708447;
 Fri, 31 May 2019 17:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <1559247798-4670-1-git-send-email-jiong.wang@netronome.com> <CAPhsuW7ycQWP3C-DSDznSLw6G9KY1iNq5Ms8AbvdF8Vk1TjVGQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7ycQWP3C-DSDznSLw6G9KY1iNq5Ms8AbvdF8Vk1TjVGQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 31 May 2019 17:08:16 -0700
Message-ID: <CAADnVQJGc4uUPRVb2qqnmSvJuU+QZYtpz4MvRS2Okbp+NeicsQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: doc: update answer for 32-bit
 subregister question
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 30, 2019 at 1:42 PM Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Thu, May 30, 2019 at 1:23 PM Jiong Wang <jiong.wang@netronome.com> wrote:
> >
> > There has been quite a few progress around the two steps mentioned in the
> > answer to the following question:
> >
> >   Q: BPF 32-bit subregister requirements
> >
> > This patch updates the answer to reflect what has been done.
> >
> > v2:
> >  - Add missing full stop. (Song Liu)
> >  - Minor tweak on one sentence. (Song Liu)
> >
> > v1:
> >  - Integrated rephrase from Quentin and Jakub
> >
> > Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
> > Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>

Applied. Thanks
