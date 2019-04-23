Return-Path: <SRS0=rV2l=SZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC5C282DD
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9DC218EA
	for <bpf@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJMY7WZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfDWXWs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:22:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37664 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbfDWXWr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Apr 2019 19:22:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id z16so18211229qtn.4;
        Tue, 23 Apr 2019 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7iVJ5kDGjzG9pXPsCndgUy8Ts+XJ9S8pVrlV1/B3Wk=;
        b=oJMY7WZ3Xs9oFz1Uf2yGhf8V9wwxmmrh+rlS2v8Scwn2G4praPy3UQ0kdbApHtz/TH
         5d+QxhRkOQGllt3p4VTtydO2REeyYEKF+COTdEyEXC1ZTU1sBCaQ4c56fuLWnU1YZnL+
         dy6/H8ZQFrygKobMsOHOCIT4nFOGntXmHbGX8+bN502C0ket/Am7HQOCCzWpqSbTGWlD
         X7OIIES2peMWiPuKatZ7/Z0ywoVHfngZVsSzy4LrntcJjI1oGlD7YoDxzdGXU5P0EIR1
         GT8ZkFYvWFzTm8lzxQSq3NBUQ4f38YeXGllDO7IBh75F3JkflSNaMq7peMyih67Qdh+n
         mOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7iVJ5kDGjzG9pXPsCndgUy8Ts+XJ9S8pVrlV1/B3Wk=;
        b=el8QQSROdIcNz7bMtVmXlmM09iGMARtb+plEqpf7tTdZcwDkDYRqifCYIEo3URVJd0
         lLzY3FsFVqHPg726N/sd7NdlDU0vrwABymDe5AKHVM7ItABPiGJgUKcykPFpdY3H5d93
         LDjU9yBT4DcRyO1JISTDFVczvEI8NXnYcDHGpUAjBv1QhWi4dt2GpjIRfvi0MhVFh/lr
         tixnfh4L05YSvVx/tbwOdkV3YKLRpxzuAVgTLZTSNqOI6QMu90i254j9t9KICbMDRpk7
         qUJjTCIaPq/SH0j2K4gMMFtDFzWxnu+q9JvFk0LtpgshZDJracv9FhYxq1f84jpINRF5
         GXPQ==
X-Gm-Message-State: APjAAAVvNpO+1u3Ey9yK4FJaTLkMqR6T9tNOWxjVLq5b2D3unbjGyE5p
        Tr4GKdq1WgXFhJDKDV7NpZE3pfCFwhnsIAuPp/U=
X-Google-Smtp-Source: APXvYqxzhWPVl7wsqy8wtE2hmhejxUMAlYeeNJ9ZA5ouq0MDWxLJ8UvDPd7yDytURrVXovhhUA6uLMjjtVe30LKskHs=
X-Received: by 2002:a0c:d1fa:: with SMTP id k55mr22741315qvh.229.1556061766494;
 Tue, 23 Apr 2019 16:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556059361.git.daniel@iogearbox.net>
In-Reply-To: <cover.1556059361.git.daniel@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Apr 2019 16:22:35 -0700
Message-ID: <CAEf4Bzao8QCiHd8qaNB2UcjKb-6bak762YqKn1aAkOrV2D3EYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] Two libbpf fixes
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 23, 2019 at 3:46 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> Two small fixes in relation to global data handling. Thanks!
>
> Daniel Borkmann (2):
>   bpf, libbpf: handle old kernels more graceful wrt global data sections
>   bpf, libbpf: fix segfault in bpf_object__init_maps' pr_debug statement
>
>  tools/lib/bpf/libbpf.c | 105 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 89 insertions(+), 16 deletions(-)

Thanks for the fixes!

Acked-by: Andrii Nakryiko <andriin@fb.com>


>
> --
> 2.9.5
>
