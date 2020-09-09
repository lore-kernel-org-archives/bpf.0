Return-Path: <SRS0=JSZK=CS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26208C43461
	for <bpf@archiver.kernel.org>; Wed,  9 Sep 2020 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE5522078E
	for <bpf@archiver.kernel.org>; Wed,  9 Sep 2020 15:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cqhcZ15b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbgIIPnQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgIIPnK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 11:43:10 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0335AC061756
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 08:43:09 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id 4so672664ooh.11
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FNJsXd0dccSO7yeZeXpilx/YRFCAv+4g45stN+/0oJA=;
        b=cqhcZ15bA0g4G3fEQf3o/q3hYb6cLg01uG1HAeZIP2nHDGTpCIQu9itQvB8xMH6aX2
         LdnyeK0iNZ6IVRrVq+EnyCM1wGszSwqiXNm0uJJNp+Km8V6mwfVxvPn7VWChJeoB+2tA
         SY1Tml4yv0Gp6eBFUg7mjFVHMqvWBYTE10pDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FNJsXd0dccSO7yeZeXpilx/YRFCAv+4g45stN+/0oJA=;
        b=APDlPTVVIzqQWV6kuFfN9pN2elIJ1w/tL3CJssuxUMe1rrQ+Z8SzEmo4siv3TqS0eS
         au0Moy9fvOub/bFSPiC3yw/5xmBQtCz6dCBnjKpgtqppt1uhIDG+GPaDODPvuuJhIq1G
         BCQF+lPJmoVLgeZouKgWvjs8M87CtNovHsKCvBgd21yNvLOzgqh3g8PijuRZXNu4sfzX
         HCMxS3b1FkGCN18EIBeBaNrthatUfGQGRQL3A13Cof4dv0/sTzogfLDi8zfzD1Zo0L2E
         rvfr2qonH/uk9594UKk1Wmpi5QEmxlh+3f1KcBDJs+rpRQsMeR/mg1n+a3RNB9kjZvkp
         gVDg==
X-Gm-Message-State: AOAM532RAcGx7GyEFvO5stNSeSBXf/AeYY90Sd8qmrbvkIyd4zzZS2Sa
        5tROMZrLFuRGH1zBdvG7BeQT1l73Kqb4tLxt9F7aBg==
X-Google-Smtp-Source: ABdhPJwnEOkkM0gOD11rmCSy5ChQdq6Ir0/Ul7hb7A78v5q75JfuWD7uId0Mc9nmHbQv0CagXltQoGCRc5riChGkHN4=
X-Received: by 2002:a4a:3516:: with SMTP id l22mr1224609ooa.6.1599666188501;
 Wed, 09 Sep 2020 08:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200904095904.612390-1-lmb@cloudflare.com> <20200904095904.612390-2-lmb@cloudflare.com>
 <20200906224008.fph4frjkkegs6w3b@kafai-mbp.dhcp.thefacebook.com>
 <CACAyw9-ftMBnoqOt_0dhir+Y=2EW4iLsh=LYSH78hEF=STA1iw@mail.gmail.com>
 <20200908195212.ekr3jn6ejnowhlz3@kafai-mbp> <CACAyw9-HZ0AzVYOg_2=PF9Y=xNwxNWUBk4VonxQLgRE6TmoZdQ@mail.gmail.com>
In-Reply-To: <CACAyw9-HZ0AzVYOg_2=PF9Y=xNwxNWUBk4VonxQLgRE6TmoZdQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 9 Sep 2020 16:42:57 +0100
Message-ID: <CACAyw99BGEQORogx2+KvpG=qVcyVEn+UwBBAYV3KV6+BssYibQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Allow passing BTF pointers as PTR_TO_SOCKET
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Sep 2020 at 10:16, Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Tue, 8 Sep 2020 at 20:52, Martin KaFai Lau <kafai@fb.com> wrote:

[...]

> > Not all existing PTR_TO_SOCK_COMMON takes a reference also.
> > Does it mean all these existing cases are broken?
> > For example, bpf_sk_release(__sk_buff->sk) is allowed now?
>
> I'll look into this. It's very possible I got the refcounting logic
> wrong, again.

bpf_sk_release(__sk_buff->sk) is fine, and there is a test from Martin
in verifier/sock.c that exercises this. The case I was worried about
can't happen since release_reference_state returns EINVAL if it can't
find a reference for the given ref_obj_id. Since we never allocate a
reference with id 0 this ends up as the same thing, just less explicit
than checking for id == 0.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
