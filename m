Return-Path: <SRS0=9p/N=UD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8797AC28CC6
	for <bpf@archiver.kernel.org>; Tue,  4 Jun 2019 15:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614EE20843
	for <bpf@archiver.kernel.org>; Tue,  4 Jun 2019 15:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7VtXexA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfFDPRG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 4 Jun 2019 11:17:06 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42480 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfFDPRG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jun 2019 11:17:06 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so16739043lfh.9;
        Tue, 04 Jun 2019 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oM5zNGPnurm7yPSxaho1MdyH9LKNKrlHCh4tchbxYqw=;
        b=W7VtXexADvrzOM+E8oMUc8sy4q9xuyrKHt/e8eSrCVXnyGFvII6lxB1k3PVIb0wUXg
         ZzATStGRM6nrg2kuIY0Bzz0uVoG+dtB2jemY8lTFc2IqUHDyRUNyEhT87V0T6tBld4bV
         r9V3zzEr8vWkJOoRgAP0K9t5+cj8NA3T57K8Uq4XvLxRINMH7RfIWLrrTzGo8rUxvWcl
         ZqqCmJIFWU5Iig5QuJP5GkEnr2b2MGFwqVNQZDrLu5oO1lEIaC2JsiR8KOlQaESo/HU6
         63Lm2e3qrb4L44r+qF2MJMRgd3mMGv0v8pA3ojOhe8bA6f+0GA24r2zPjPsKZlW4hhH1
         gFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oM5zNGPnurm7yPSxaho1MdyH9LKNKrlHCh4tchbxYqw=;
        b=GNX0tBrG0UV5oGnebZnm726dQmQ+B8FvlsOCwgYpgsNz2NP+ebplkVZwgimIlylnIS
         9M/6dbxxA+qeaDsu5FmYIRl4XdxVqdZgDIo/fKx48GEmK3dO6y/2CESsBL0QtmSFGEkw
         r61kC3BRAkMoWRz5PRqrgiSlWlX0QR41mwZuDtiK4LaP7bZnxj4gG9oDu36TeA9NcKbA
         sqHjN8WvDpCKDYEQO96IK0YAhcQMaBbtZJHjsYAH2zCoYVcCgLW7b8iNx3s4jNJ8qv8T
         NgkSULgD5Vij1CqmWsBZ1wYH5TT1aEB6pQAC2DuDla3zdiAq1R/GdrnCz7W6RjbFgjk+
         iK6Q==
X-Gm-Message-State: APjAAAVXaSS2Mlv+gpy3cD4OVf+WxqZJdmhQY8H0k2Ai6UtEMiDuvswd
        ouaNFoS2eSxBF8quiMPJd4VXmS4ISojP4mt3/3UAMQ==
X-Google-Smtp-Source: APXvYqx9ZbwUe1MPp7QDT3gljawQmWKB2HVLFzTEpB8y0FZxpPLN4iD9RWoXr0JkK3YGAt+h5Yz8H3875JeJnRWmLXo=
X-Received: by 2002:ac2:46f9:: with SMTP id q25mr18319324lfo.181.1559661423930;
 Tue, 04 Jun 2019 08:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <f42c7b44b3f694056c4216e9d9ba914b44e72ab9.1559648367.git.baruch@tkos.co.il>
In-Reply-To: <f42c7b44b3f694056c4216e9d9ba914b44e72ab9.1559648367.git.baruch@tkos.co.il>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 4 Jun 2019 08:16:52 -0700
Message-ID: <CAADnVQJ1vRvqNFsWjvwmzSc_-OY51HTsVa13XhgK1v9NbYY2_A@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix uapi bpf_prog_info fields alignment
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, "Dmitry V . Levin" <ldv@altlinux.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 4, 2019 at 4:40 AM Baruch Siach <baruch@tkos.co.il> wrote:
>
> Merge commit 1c8c5a9d38f60 ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next") undid the
> fix from commit 36f9814a494 ("bpf: fix uapi hole for 32 bit compat
> applications") by taking the gpl_compatible 1-bit field definition from
> commit b85fab0e67b162 ("bpf: Add gpl_compatible flag to struct
> bpf_prog_info") as is. That breaks architectures with 16-bit alignment
> like m68k. Widen gpl_compatible to 32-bit to restore alignment of the
> following fields.

The commit log is misleading and incorrect.
Since compiler makes it into 16-bit field, it's a compiler bug.
u32 in C should stay as u32 regardless of architecture.

> Thanks to Dmitry V. Levin his analysis of this bug history.
>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  include/uapi/linux/bpf.h       | 2 +-
>  tools/include/uapi/linux/bpf.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 63e0cf66f01a..fe73829b5b1c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3140,7 +3140,7 @@ struct bpf_prog_info {
>         __aligned_u64 map_ids;
>         char name[BPF_OBJ_NAME_LEN];
>         __u32 ifindex;
> -       __u32 gpl_compatible:1;
> +       __u32 gpl_compatible;
>         __u64 netns_dev;

No need.
