Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A22BC433F5
	for <bpf@archiver.kernel.org>; Sat, 16 Apr 2022 19:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiDPTzS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 16 Apr 2022 15:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiDPTzR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 16 Apr 2022 15:55:17 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1077C183B1
        for <bpf@vger.kernel.org>; Sat, 16 Apr 2022 12:52:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q19so12057442pgm.6
        for <bpf@vger.kernel.org>; Sat, 16 Apr 2022 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bgAC77nR92R0Atdt/fs5cwWnopSQU2D1kSGGyPYLyDQ=;
        b=TVeQWAEYl9fYnjxCeAMwSSviv5YRc4g13KArx1gspSAInJbWYgmMd6M1eVuvihCIZL
         u+oLsN9LU3xWSLzM3Dekpfa8+shuPiRZC3FHglN1+AAes+5AhSRzPNZjvFxRDBRgjsaM
         /npxtIKoF8hoehyQlof2pmTrPY7IDkiK5UxeUUJ4MMkhNhHuQRBGYnZpZhSu5A4d88/j
         xGGJ4LiIbJk/77Moh7Rg+wcV1ZUxrHqFi1VxoDaF+UgtH7kFhFls3Leaw3Ur43FYpO2R
         rBKFa3PiFC0h9bSlpXAlPd5vqGPjK8z+I8BGJScRQ8CbeqvwwDCkQCYWlwaepFO8zJDW
         3cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgAC77nR92R0Atdt/fs5cwWnopSQU2D1kSGGyPYLyDQ=;
        b=OSHNSzs6Ac1ARRsd2b0/xjgq4H4NyBLxwMCeg7cLqUCYZ0RKbt+stszhyJMHo+uuNj
         o8cc3hNvkB5heOgCis6OEZYnFrdrZpFSr3/ZtKNG8Y2UUbly0xoQHBsmGDQrC4zu3HOk
         LZyrWUD9MZeKRh/Xe0zPqaqt3trDzgnkWGwhtKuzOJTZZ1yDzS5oPQMNgBVK7X7X2DK5
         Ul9JxviwtAHCW0Hox+XF5QcDOb+/z2HY4qUME372mmmY8YS4irDIdq1u1qZuOvAz+kCS
         2dS8zkWkapAALKmMCrxhCi9JtmhwedQmGKiaLLkbugC4NHXcvdRVUUB6sWZdMNyz7wSf
         Eu9A==
X-Gm-Message-State: AOAM532MDp3KpC70s/boXb6diWasHS2wwNCTj+3l+YGXFWIh72ZiZ7zU
        W7Lmp3BCKFBUBNDesRt3bwGIMXL3MANTD6aDmLcCbhrx
X-Google-Smtp-Source: ABdhPJzkJ/C2Ay0FjgjPq4evKE9flkKb2fOSIgn+aS3GYFJ+tHWdc3bzH8aVSaDmtwEE/V70mk3cihpfoHWou/t5cfo=
X-Received: by 2002:a05:6a00:24cf:b0:508:3278:8c21 with SMTP id
 d15-20020a056a0024cf00b0050832788c21mr4878423pfv.57.1650138763542; Sat, 16
 Apr 2022 12:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220414223704.341028-1-alobakin@pm.me> <CAADnVQ+rGR9vaDD1GM3mPgTkece711KZ+ME1MPWN8KYohydZyQ@mail.gmail.com>
 <20220416175452.202686-1-alobakin@pm.me>
In-Reply-To: <20220416175452.202686-1-alobakin@pm.me>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 16 Apr 2022 19:52:32 +0000
Message-ID: <CAADnVQJtEcTCaGSPuQVPaGP1sk+N0AMV861h73qN-k_CrWG9gA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/11] bpf: random unpopular userspace fixes (32
 bit et al.)
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 16, 2022 at 11:01 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Date: Sat, 16 Apr 2022 00:50:49 +0000
>
> > On Thu, Apr 14, 2022 at 3:44 PM Alexander Lobakin <alobakin@pm.me> wrote:
> >
> > Please do not send encrypted patches.
> > Use plain text.
>
> Oof, weird. I use ProtonMail Bridge and they claim it doesn't
> encrypt mails to non-Proton users. That's the first time I hear
> such, I was sending several fixes to LKML a couple weeks ago
> from this mail address with no issues (and got them accepted).

They come encrypted to gmail inbox. Shrug.

> >
> > Also for bpf fixes please use [PATCH bpf] subject.
>
> I decided to go with bpf-next since it changes the layout of
> &perf_event a bit when !CONFIG_PERF_EVENTS. But if you're okay
> with taking this through the bpf tree, it's even better.

I didn't see the patches. Only went with 'unpopular fixes' subject.
If they're not then bpf-next is certainly better.
