Return-Path: <SRS0=FlKb=3Q=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE54C2D0DB
	for <bpf@archiver.kernel.org>; Mon, 27 Jan 2020 18:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3194324680
	for <bpf@archiver.kernel.org>; Mon, 27 Jan 2020 18:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF5K5DZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA0Sqr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:46:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34387 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0Sqr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 13:46:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so7015376lfc.1;
        Mon, 27 Jan 2020 10:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6j8ZrHqnAL/W88gLwdWKIRQ3rx0fpmE67YlL/tBUZc=;
        b=lF5K5DZKcEB8ULYyKv4nCNl2jy1/WL5idqfUViOv5GytKmCl59Tn5W0JOKslCkyuWm
         s0P8fpf5gFaaT3SA2+DCPBk9SmhnQrqq7GSp80/lR7tcjcBhPp2nW2uqz/YABAoyD6nc
         /Pl5mvcAsKVOZdwmnzeS9yNMB+EEFMlywhm1aKW8H2yZPhGVA8PNnI0U41+G6RYPwTl3
         o13NGiYYOUzdCO7RJAWJc30uDIwM9m8ZgF0U/hyafV9zo+8wjLAjqR1cKJdLvPx8fSoI
         YAzIOi1rHpc9GfiO8/XFOqsghaRb3xChQCgnwVMl2Kxjjm2sDF7jBAZHF7XF9Wd66G9X
         aVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6j8ZrHqnAL/W88gLwdWKIRQ3rx0fpmE67YlL/tBUZc=;
        b=J2bUcBuxm8Ee3E/EXhilBec1Q+RTXfYsKYIuQaGnqqGCZVOlysO+mfEvU2z04i/mmd
         cu9NU+2Ev+JAFvirTMoZ90PB9agNCc0R6E4jHZvJSMGNFL0RhSj9/a3mnB2DfL+LFhuo
         AC/QbzfzqjuqeAHPkNAH0NazrAOhhUM4VhM6bLGP9bwvrF5G0be272qkV5+EBosNMZGQ
         d3uERxd9NW+oSz8XfNAh61J3wFHO2Wdcc8hXrJKxPYvk457TMjmjhgBZiDXEFjMB1Ba+
         OlolmmtSh5F6mF35m5kh0iaHWekXeapYMp5tU4p/KbDpNXb9FLJ0ooPPZP1A9RmRCWnO
         j2KA==
X-Gm-Message-State: APjAAAX7OM1nRE1Od2GZscEp27UdmyVKTLARg0T/1QJOXsXz4aKlGEzV
        KDGGyhUx1g63IklFM943R81m8oxy3abhaTrW0g0=
X-Google-Smtp-Source: APXvYqxIrSIoPOAfM2CqC4CpGwBvS9FF2EPJPH+76gg65eXVlPam6BFaicgKM0R+skYXkazNS9BZwOIb+0jBks2b0Qw=
X-Received: by 2002:ac2:515b:: with SMTP id q27mr145lfd.119.1580150805112;
 Mon, 27 Jan 2020 10:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20200127175145.1154438-1-kafai@fb.com> <CAEf4BzYONH0jpi+VV8Q72q2Uico2_MnydX0ptpcOJQLW8H+gng@mail.gmail.com>
In-Reply-To: <CAEf4BzYONH0jpi+VV8Q72q2Uico2_MnydX0ptpcOJQLW8H+gng@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 27 Jan 2020 10:46:33 -0800
Message-ID: <CAADnVQKx46Ors4=ywPs-+Oq1-8yRid81_mWqHyGYAD2kvZ0eLQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Reuse log from btf_prase_vmlinux() in btf_struct_ops_init()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 27, 2020 at 10:34 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Jan 27, 2020 at 9:52 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > Instead of using a locally defined "struct bpf_verifier_log log = {}",
> > btf_struct_ops_init() should reuse the "log" from its calling
> > function "btf_parse_vmlinux()".  It should also resolve the
> > frame-size too large compiler warning in some ARCH.
> >
> > Fixes: 27ae7997a661 ("bpf: Introduce BPF_PROG_TYPE_STRUCT_OPS")
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > ---
>
> LGTM, but there is typo in subject (btf_prase_vmlinux).
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Tested. All works.

Dave,
if you haven't sent PR yet may be you can apply this patch
directly to silence the warning?
Not a big deal if not. I don't see this warn with default config.

Acked-by: Alexei Starovoitov <ast@kernel.org>
