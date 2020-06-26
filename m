Return-Path: <SRS0=o7vX=AH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF52C433E0
	for <bpf@archiver.kernel.org>; Fri, 26 Jun 2020 21:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE43208C7
	for <bpf@archiver.kernel.org>; Fri, 26 Jun 2020 21:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy+o+p39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgFZVtQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZVtP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jun 2020 17:49:15 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C06C03E979;
        Fri, 26 Jun 2020 14:49:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z2so8635952qts.5;
        Fri, 26 Jun 2020 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=doYsV1+x60dYGMlAnBhGiUwMPJnQ0kL/rbcqGWWy8TA=;
        b=Yy+o+p39/mLiiUdy3Ilg8FLDdDR2le9XHbSChUd6zi8C/CRwL+3mX1/2WO7g8i4QK4
         CKPI3tjHJ8wb/rTo5UZ2oUcOA5IVHX4eIMskmZm9naYD9mogDUuBu4cULa0BmShcFp/+
         Nw6cGcCSuq/a8Wa6KZV/1ffCaxZus4R+E3ihST/VqUmB4JESEuh7dsZ97J4s/iP9znWK
         jnXh7aTd3Du0fbaQeJqdCbRhlH9yER3RfnKnsvt8tzhJ6w+Sz95HexSeAUoMhSJaorPq
         xC+raRNgVpDB1u8hdrIDiD24+DeTB9myXSygGP2BfBV4XWLoVgtI0vsRqiGliqKU6kpY
         Twpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=doYsV1+x60dYGMlAnBhGiUwMPJnQ0kL/rbcqGWWy8TA=;
        b=p4NtcdTnCTPW7y+3vxb1HzbzQVnK8B891vkwDmLaPsBQWoBYBVES5WE+0HbeWCpq+1
         sP3TJBRJF5uZZs+jzHTsuJ9Owy+OqhQRSZhgMLLQBydImKNDMgzKnT/Aaou2Gxs8auyO
         5mkzUnFJghKUuT8JeXSbjGUK7XAuJz7uCcEJCS7NMX/SLjtRBt3v4Q4IqZ3qQv7iI05s
         sQsag+YRUqsQ8krp6QU60ezpQE3WxM3y1vgJ5I/bnPHhuaIr5NHTuJghhkHyZZpNkvqo
         XPaRsbL2fjRUr2GZNL7eomHvtkDElM6TDxrmBwEjAVhXb0yNccESsHILvJA9xp+st7Gd
         aoQg==
X-Gm-Message-State: AOAM533c5JM0YyeFd2ZqsJqDpF1IDJ99MwVMRHxcVB+3T1eF+X5lFibt
        oof6M+r70Q/9EGtdybjr01hjuK/v/ymyrw5scwA=
X-Google-Smtp-Source: ABdhPJyX97RxIc4dlMDJs6ydJN32Wjb3BlNXaqZy7xEbluESSWGQo+9lwhzQpASqFo7Q8qYvaCkdTchlm6CMUdBJa4U=
X-Received: by 2002:ac8:19c4:: with SMTP id s4mr693329qtk.117.1593208154265;
 Fri, 26 Jun 2020 14:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200625221304.2817194-1-jolsa@kernel.org> <20200625221304.2817194-9-jolsa@kernel.org>
In-Reply-To: <20200625221304.2817194-9-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Jun 2020 14:49:03 -0700
Message-ID: <CAEf4BzZC-reS4oQ-SWLBEYwu9KGV8RsaBDtAQiiUNh+EveHV6w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 08/14] bpf: Add BTF_SET_START/END macros
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 25, 2020 at 4:48 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to define sorted set of BTF ID values.
>
> Following defines sorted set of BTF ID values:
>
>   BTF_SET_START(btf_whitelist_d_path)
>   BTF_ID(func, vfs_truncate)
>   BTF_ID(func, vfs_fallocate)
>   BTF_ID(func, dentry_open)
>   BTF_ID(func, vfs_getattr)
>   BTF_ID(func, filp_close)
>   BTF_SET_END(btf_whitelist_d_path)
>
> It defines following 'struct btf_id_set' variable to access
> values and count:
>
>   struct btf_id_set btf_whitelist_d_path;
>
> Adding 'allowed' callback to struct bpf_func_proto, to allow
> verifier the check on allowed callers.
>
> Adding btf_id_set_contains, which will be used by allowed
> callbacks to verify the caller's BTF ID value is within
> allowed set.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

This looks nice!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  include/linux/bpf.h     |  4 ++++
>  include/linux/btf_ids.h | 39 +++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/btf.c        | 14 ++++++++++++++
>  kernel/bpf/verifier.c   |  5 +++++
>  4 files changed, 62 insertions(+)
>

[...]
