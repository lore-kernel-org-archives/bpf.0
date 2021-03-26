Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B1CC433C1
	for <bpf@archiver.kernel.org>; Fri, 26 Mar 2021 12:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA4D76191F
	for <bpf@archiver.kernel.org>; Fri, 26 Mar 2021 12:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhCZMWb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 26 Mar 2021 08:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229935AbhCZMV6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 08:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616761318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8SoH41vqZ8M6OfcY0S1u2VmNBojDtuWzMPaYh4ry4/Q=;
        b=bDjRs3Lm0iAqb0zRj4YSUVf+Ek82sYlJfd5YJBr3kweqGp3Wqi2voVUNvynQGDc+hn01Py
        szfs6r+ZEi7RvcTlEh4Hz7vV20T3gHYT9Lux0McAP0P2nI7RVEhm+b9RkAOGZbibhqkvMO
        f2Zg+Vcun7XPjYfApeajdnoRJpDo1pE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-iLMF6EqXMBqx83q1u-bvcQ-1; Fri, 26 Mar 2021 08:21:56 -0400
X-MC-Unique: iLMF6EqXMBqx83q1u-bvcQ-1
Received: by mail-wr1-f69.google.com with SMTP id t14so4167252wrx.12
        for <bpf@vger.kernel.org>; Fri, 26 Mar 2021 05:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SoH41vqZ8M6OfcY0S1u2VmNBojDtuWzMPaYh4ry4/Q=;
        b=plxu/9XS7NZrNOqLhkiCJ3Z72UVfTLtImefZ3sIIHHWpAcNUNPKE0gRimIbZHxPYpq
         DWD7kgIJmuhM/e8Ly33+jOeeea38DfRS7VOPpVO9ePlY0G+6D9D59qUZ7TI2/J6O8tou
         yspzsM1kf2uVnbbijUjk94s8KE4ZjerN71kaIBf9MP7WJhDX+KOiafGoR2sHspYr0c+j
         etSw7jz+/OqwPzgwz4RmWmiLJ7oz5G3cyi7+b5dt9L63VG4PTIA9SCitAF8e97eX5Avm
         wK+T+WNSdAiJ5/56KydZ2yQ9RucS4z5Jd83seCQs/HpN9k2WZSThQ8rs6PDKqjO4it2t
         eeSg==
X-Gm-Message-State: AOAM530/wk/xM6Ie8w/M7c3cmgIYUCJrMXjgW7pAaUPMciC6YvYCtGDR
        ENloHAiCRJ2K9NM6EKXgKAMgV/nO7X1ZBJwzuuIuYnhosGEEoxejvUzvPDVbdI6SEW4HoHer3Tg
        8NCBDXw5lcvamjnsPppIft5g98gv5
X-Received: by 2002:a7b:c155:: with SMTP id z21mr1763778wmi.79.1616761314709;
        Fri, 26 Mar 2021 05:21:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOLfgiF9E8PFhkeH9ywUuLRdATyT+l28mfQ8B+7vbVPXn+3TRjmH5u3KsrGkPtfBSE0QBm6N1lUNTCciBwrQo=
X-Received: by 2002:a7b:c155:: with SMTP id z21mr1763769wmi.79.1616761314540;
 Fri, 26 Mar 2021 05:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Fri, 26 Mar 2021 14:21:38 +0200
Message-ID: <CANoWsw=ForMxYDGY=JpRherVshXKm9+Fjwcc_xvEVF=gpxcn0A@mail.gmail.com>
Subject: Re: [PATCH 0/3] bpf/selftests: page size fixes
To:     bpf <bpf@vger.kernel.org>
Cc:     andrii@kernel.org, Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Oops, one patch is missing.

Will recend

On Fri, Mar 26, 2021 at 1:47 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> A set of fixes for selftests to make them working on systems with PAGE_SIZE > 4K
>
> 2 questions left:
>
> - about `nit: if (!ASSERT_OK(err, "setsockopt_attach"))`. I left
>   CHECK() for now since otherwise it has too many negations. But
>   should I anyway use ASSERT?
>
> - https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/prog_tests/mmap.c#L41
>   and below -- it works now as is, but should be switched also to page_size?
>
> Yauheni Kaliuta (3):
>   selftests/bpf: test_progs/sockopt_sk: pass page size from userspace
>   bpf: selftests: test_progs/sockopt_sk: remove version
>   selftests/bpf: ringbuf, mmap: bump up page size to 64K
>
>  tools/testing/selftests/bpf/prog_tests/ringbuf.c      |  9 +++++++--
>  tools/testing/selftests/bpf/prog_tests/sockopt_sk.c   |  2 ++
>  tools/testing/selftests/bpf/progs/map_ptr_kern.c      |  9 +++++++--
>  tools/testing/selftests/bpf/progs/sockopt_sk.c        | 11 ++++-------
>  tools/testing/selftests/bpf/progs/test_mmap.c         | 10 ++++++++--
>  tools/testing/selftests/bpf/progs/test_ringbuf.c      |  8 +++++++-
>  .../testing/selftests/bpf/progs/test_ringbuf_multi.c  |  7 ++++++-
>  7 files changed, 41 insertions(+), 15 deletions(-)
>
> --
> 2.29.2
>


-- 
WBR, Yauheni

