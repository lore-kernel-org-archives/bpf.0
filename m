Return-Path: <SRS0=sVLx=7O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7F0C433DF
	for <bpf@archiver.kernel.org>; Mon,  1 Jun 2020 22:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E16206F1
	for <bpf@archiver.kernel.org>; Mon,  1 Jun 2020 22:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grDWpsg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgFAWiQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Jun 2020 18:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgFAWiQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 18:38:16 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD7C061A0E;
        Mon,  1 Jun 2020 15:38:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g28so10022026qkl.0;
        Mon, 01 Jun 2020 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvZW9vgdfgQJrU2H7xotPh1pXrCvDZu0ssR+AlBBsJU=;
        b=grDWpsg3yNeeH22d7CXHwWAz8aH6S8cEJoFpHLUZHOzPhJCDoQVKjMznTZZ3mvzRXv
         7Ra3XIk+I/yNSZOrKNqh0hD1eYThhHAzyQeBFfFlMM97PozNuBehuFi3eZVmxTYyNBKj
         ZnJd0yjDGQaS/3+TgFhVarflknACmfOwAXvTykz+HZRAQgXP+m/ajDyF08vZoR45SR1E
         RTthPYFcPzVV5/CL2rVPUzhiWT2P5xqEleEISXqffOgSrTRg/TELC1GnSSW7PETf2GQC
         IgPtnlgmXqEDn0ounSv03VJoWqjGzIY7GXM1pAIauKdFcVTO0nBSfd5OalPZseWNYh7M
         t4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvZW9vgdfgQJrU2H7xotPh1pXrCvDZu0ssR+AlBBsJU=;
        b=MFAvNB8DYqwq2bfUiARdtpcS7B+FmrWszFc5QB0Q98ifjqr3/7VNtFRsBTweuRa3r4
         C7j/ptE7jHc/WmrvOSf0PEumYuiIJ8QhSA9tIR2vpwr4IxG3MxyNmeNBzzuddOIIZ2Se
         Ft1Hkh0OcMNL8vhAyKo7ebCJTKqzviaCJ+KCoEpwSdiL4C5mWHDReStk066BqHb7oqt+
         QWm9dqSEHI7qzHLlyWSKQDNpykxQh+cS8c7fJ4LB3/C+8yo/sOnYs+jZFuMv17YqMOyC
         bAuVBByQghRA6DLoUeJqg4/X9mUlKE1OUnikkuUIO6XhOYPsivTthIU0wz7tyW7mdlip
         f/Eg==
X-Gm-Message-State: AOAM531ekxgIpRi2qfo9cM7J3NkcCz/+TCrNx23+Vt4GEXLfO5TVyN8F
        mYwmCqlCwnxuUvY1E9KwbZ1DFW5ftfqm7sG+tiA=
X-Google-Smtp-Source: ABdhPJzIjyyW+kIvHaEueaSOJQCRg1jcaKN0RnoHf79p2cGaAZQWkC+PYsEzAcnOgj2ULzUnE2aZ9DMkjOSAn2XhT2E=
X-Received: by 2002:a37:a89:: with SMTP id 131mr21680526qkk.92.1591051095189;
 Mon, 01 Jun 2020 15:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200531082846.2117903-1-jakub@cloudflare.com> <20200531082846.2117903-9-jakub@cloudflare.com>
In-Reply-To: <20200531082846.2117903-9-jakub@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 Jun 2020 15:38:04 -0700
Message-ID: <CAEf4Bzap93RJY4GvSbMA14Z3wCVw4gwYCLJ+4FS0zDNd8wu4Kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 08/12] bpftool: Support link show for
 netns-attached links
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, May 31, 2020 at 1:31 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> Make `bpf link show` aware of new link type, that is links attached to
> netns. When listing netns-attached links, display netns inode number as its
> identifier and link attach type.
>
> Sample session:
>
>   # readlink /proc/self/ns/net
>   net:[4026532251]
>   # bpftool prog show
>   357: flow_dissector  tag a04f5eef06a7f555  gpl
>           loaded_at 2020-05-30T16:53:51+0200  uid 0
>           xlated 16B  jited 37B  memlock 4096B
>   358: flow_dissector  tag a04f5eef06a7f555  gpl
>           loaded_at 2020-05-30T16:53:51+0200  uid 0
>           xlated 16B  jited 37B  memlock 4096B
>   # bpftool link show
>   108: netns  prog 357
>           netns_ino 4026532251  attach_type flow_dissector
>   # bpftool link -jp show
>   [{
>           "id": 108,
>           "type": "netns",
>           "prog_id": 357,
>           "netns_ino": 4026532251,
>           "attach_type": "flow_dissector"
>       }
>   ]
>
>   (... after netns is gone ...)
>
>   # bpftool link show
>   108: netns  prog 357
>           netns_ino 0  attach_type flow_dissector
>   # bpftool link -jp show
>   [{
>           "id": 108,
>           "type": "netns",
>           "prog_id": 357,
>           "netns_ino": 0,
>           "attach_type": "flow_dissector"
>       }
>   ]
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

LGTM. Not sure if bpftool allows to filter progs/maps by type, but
probably we should eventually add link type filtering ("show me only
netns links")...

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/bpf/bpftool/link.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

[...]
