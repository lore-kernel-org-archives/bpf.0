Return-Path: <SRS0=sVLx=7O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A44C433DF
	for <bpf@archiver.kernel.org>; Mon,  1 Jun 2020 20:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E77206E2
	for <bpf@archiver.kernel.org>; Mon,  1 Jun 2020 20:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uETH8SuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgFAUkt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgFAUkt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 16:40:49 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912AFC061A0E
        for <bpf@vger.kernel.org>; Mon,  1 Jun 2020 13:40:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z18so9817689lji.12
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2020 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZJ0O5vWXoNYTX7X4VCgSHaUewxLcTjN4Bjg0oWcroo=;
        b=uETH8SuM0C5t8alKK/sxSSoYjFiuOeRvoYVnbc6O+h4vdrN1APqqWcax4gbhlYMrZ2
         04g/BSCUHG8/cotYGi53AYez8sCvmAsEkZ9lIP3yj1LCBSENqStIhu4QaOf2tCnHfXv1
         MMELp+duI3+7cafWdL4NBo4SUb//Grt9dP/hyOaNg3y4Pkep02M9qDWx1zB22vHRsziU
         Da6ZXObi4wVsGEVvgbP9wnjq2Q+mX6vYJkTO7WWMSQ6vQeARDg5kubLFL9bUVrIlJyE/
         0OT9AFO6oco52c5r4lsWNFh/v6bU0tNIWBfdTTxdxM8TXswUdg8GVG1RPsescYoH/8qz
         rozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZJ0O5vWXoNYTX7X4VCgSHaUewxLcTjN4Bjg0oWcroo=;
        b=Dn54yqOgcp4B33pQpYIgDNPlMz6raa7n+cxCV8RgF7vzpUOZIM/JBwNm2PZ6U6j0/3
         pJHWQizA5gDdnzcjW+0PzgF6XG3S8p+NeRmVIUbMgenZ02dSeT4UGCXDROm4LyUAzC1y
         FiqMONFFNEVPizCEStUT/VyAtzjfria4tDVMjsMUo5xRwgdEpgCcHWuS/rhmS6jRcCaM
         ogYeGgoodopn5iMDsW8Nlgu0Yazc2J8ueBAxJBVnTJvDW7EXCjZvbaUINhJo3i/Vx0c/
         9m4PZ3pJgzdvmxcthsN1D/dF4mQKwqW5RjkqrSGYV8aa3yplJevubylf5vjvpfmD3j2r
         bHiQ==
X-Gm-Message-State: AOAM533UikOfwZ2wgiZYgzFxD7mFMtXiGHLBQsAEVESWNl0weID+0chW
        cWWDz6pHAOit8LhekiiLCh+4snEg6jFwQKoGj1Q=
X-Google-Smtp-Source: ABdhPJx6ILQQcrWbV6pEXaVPvdUCdvyRygjQsvOPnLwkCnhxzGWWM/aILgiY6zeMEVGwxZFfdTGewE8iDKDqsEo0XtE=
X-Received: by 2002:a2e:80ce:: with SMTP id r14mr5940922ljg.121.1591044047030;
 Mon, 01 Jun 2020 13:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200529004810.3352219-1-yhs@fb.com> <DD249D2B-7F03-43A2-99D2-002D1CA742C7@fb.com>
In-Reply-To: <DD249D2B-7F03-43A2-99D2-002D1CA742C7@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Jun 2020 13:40:35 -0700
Message-ID: <CAADnVQ+RBSC+rkYXOrswRsQVEpWOj_8OHn5Y+0XO6CxRPGXqdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use strncpy_from_unsafe_strict() in
 bpf_seq_printf() helper
To:     Song Liu <songliubraving@fb.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 29, 2020 at 1:45 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On May 28, 2020, at 5:48 PM, Yonghong Song <yhs@fb.com> wrote:
> >
> > In bpf_seq_printf() helper, when user specified a "%s" in the
> > format string, strncpy_from_unsafe() is used to read the actual string
> > to a buffer. The string could be a format string or a string in
> > the kernel data structure. It is really unlikely that the string
> > will reside in the user memory.
> >
> > This is different from Commit b2a5212fb634 ("bpf: Restrict bpf_trace_printk()'s %s
> > usage and add %pks, %pus specifier") which still used
> > strncpy_from_unsafe() for "%s" to preserve the old behavior.
> >
> > If in the future, bpf_seq_printf() indeed needs to read user
> > memory, we can implement "%pus" format string.
> >
> > Based on discussion in [1], if the intent is to read kernel memory,
> > strncpy_from_unsafe_strict() should be used. So this patch
> > changed to use strncpy_from_unsafe_strict().
> >
> > [1]: https://lore.kernel.org/bpf/20200521152301.2587579-1-hch@lst.de/T/
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Yonghong Song <yhs@fb.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>
>
> I guess we should add:
>
> Fixes: 492e639f0c22 ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")

Applied. Thanks
