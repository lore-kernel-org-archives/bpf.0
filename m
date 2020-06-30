Return-Path: <SRS0=4Gtr=AL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DF3C433E0
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 18:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 639A32074D
	for <bpf@archiver.kernel.org>; Tue, 30 Jun 2020 18:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjGXWkph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgF3SXU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731903AbgF3SXT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 14:23:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92770C061755;
        Tue, 30 Jun 2020 11:23:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id q22so9837983qtl.2;
        Tue, 30 Jun 2020 11:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JknV3P4BTVwlCM56AtpVNp/VcjTCfHkbE8MWsb/faRY=;
        b=WjGXWkphztHMh2J2y/jaISF+dY442qtl8dP5GxodeiNWjUZLVkqL1Ky6GSZrC00Z+z
         mG95Q2Rd8jQ9BhHOvbU4i9+tt9bvl96lcw0woebCj0IRvmloopCBKEZgA40p037ss6Cb
         n4GjaHykqmvHVFnvypMVRbdg4kR0SU3HAvgNKMQoxuW3WxffXbgtXy1B4boitdERx9by
         MI8zhBjKUU4yS0hZYDEXq6/SCeQIQkyNz1CQx+FTpR9N53Qp1zG4fVicSJhr4f+ansgo
         E1wXsRhzZJhlvjcjm9AJGbMQLOVdGwBKVzPXEOIMEfc3kKhbAwfHexohWErHDuODUFI+
         9k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JknV3P4BTVwlCM56AtpVNp/VcjTCfHkbE8MWsb/faRY=;
        b=s8pXGk4CrrKY3kMW/py88jD0NP+bxe2uSoDPWbBRfO760KVXRmmmxwEIiM0gew6j8R
         h33hktM2SSUkmEkn3X+W6YMi6hQXDa+YBzbnB4xsNgxvpy2tpmR8jv9Kf5SX/yHPDvv2
         MIrGDbMNzCcRtZBHhjDhymS1sf9K/aT8YiP66PZkO9K7a+xPOPMG9c+K+IT0IssGh8xb
         egXJe010tzL8yLMAC0KiucB6s+vbD5sht0En2634XQM5ew8esCuGo/KRUjTWFkqJy4v6
         MUeil3UH5tzrya1PquISZcIZMhD+D/SDyMhTbVhlr3EhX8xpcXjMRsSbWYDZPymgFX2m
         UxYA==
X-Gm-Message-State: AOAM531V6yhJQJjiaEAkPkD2o1XQpCTGFaIPW0oiZLgtjcXp46B+mVF1
        Fy4fMXAyPcmxl7vvX6QHXrVfyuzEcj45oNGqOcQ=
X-Google-Smtp-Source: ABdhPJwdxPBEQICS9m6dUwQIDXQap4z+XC1q4MlWgMstgV9qHWWCcnWd40WgztGbifb8nAt0c6lq09Sf0CaPYpH6vNA=
X-Received: by 2002:ac8:1991:: with SMTP id u17mr21347226qtj.93.1593541398844;
 Tue, 30 Jun 2020 11:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200611222340.24081-1-alexei.starovoitov@gmail.com>
 <20200611222340.24081-3-alexei.starovoitov@gmail.com> <CAEf4BzYbvuZoQb7Sz4Q7McyEA4khHm5RaQPR3bL67owLoyv1RQ@mail.gmail.com>
 <CAADnVQ+ubYj8yA1_cO3aw-trShTHBRMJxSvZrLW75i8fM=mpvQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+ubYj8yA1_cO3aw-trShTHBRMJxSvZrLW75i8fM=mpvQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Jun 2020 11:23:07 -0700
Message-ID: <CAEf4BzbfXajuL-1VLBUJsC3P796s2hk9oYGveYG5QnS2=YoN-A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 bpf-next 2/4] bpf: Add bpf_copy_from_user() helper.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 29, 2020 at 5:28 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 18, 2020 at 3:33 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > > + *
> > > + * int bpf_copy_from_user(void *dst, u32 size, const void *user_ptr)
> >
> > Can we also add bpf_copy_str_from_user (or bpf_copy_from_user_str,
> > whichever makes more sense) as well?
>
> Those would have to wait. I think strings need better long term design.
> That would be separate patches.

I agree that it would be nice to have better support for strings, long
term, but that's beside the point.

I think bpf_copy_from_user_str() is a must have right now as a
sleepable counterpart to bpf_probe_read_user_str(), just like
bpf_copy_from_user() is a sleepable variant of bpf_probe_read_user().
Look at progs/strobemeta.h, it does bpf_probe_read_user_str() to get
user-space zero-terminated strings. It's well defined interface and
behavior. There is nothing extra needed beyond a sleepable variant of
bpf_probe_read_user_str() to allow Strobemeta reliably fetch data from
user-space from inside a sleepable BPF program.
