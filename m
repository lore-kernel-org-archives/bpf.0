Return-Path: <SRS0=c9tz=YX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A09CA9ECB
	for <bpf@archiver.kernel.org>; Wed, 30 Oct 2019 22:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94E62083E
	for <bpf@archiver.kernel.org>; Wed, 30 Oct 2019 22:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+YVlo/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfJ3WDI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:03:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34954 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfJ3WDI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Oct 2019 18:03:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id l3so5569601qtp.2;
        Wed, 30 Oct 2019 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2m07ki5VoBt8Vb2fFCDnZahPA0NaP0f1n5/euJcW01s=;
        b=V+YVlo/vfWa4lNRq2t1ii7FuxAy4DhX+wtWZH5YSakpS6Y7P0r0BF0oNlfmhVHh8a8
         YxJ3hUG/aw9CWjQWWaEnZtIwLtimiB3jdNkdOKkG8yhB8Y8/oJ33W5kWKdIwqHJ4m43C
         Rnn8LJrad0Oh5jdhrQTtc0quqtUj4X6ronTfPaw2PPvA+jrJLKqzAlb5hqNTFFB9zECf
         XEd0A4uFwlLD6UYD7Nem2jE994dVrrZGmOvGLehp6jN5+qgVEp1GVrk9AVjqu7jRUdPF
         SAQqjno8YdmVFfPNA6EUsnzYhp2IuB5XpR5lawwihSNwXQLZ8nKqUVFxUprS3NmCGw+U
         tBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2m07ki5VoBt8Vb2fFCDnZahPA0NaP0f1n5/euJcW01s=;
        b=HJ3GH/VB1fqvw6RqsObKv1lcqfdLVaH1YqHqaH4IlFKe0lH/QwpQrHGfy1wWaCayNK
         foog+TdEamP9eaLjUxMOgMjz0Jir8IWpUl2fgyHqCSK/UdnTevsE0swIg4DBgnHLHJK9
         Dt/rEDuRlDuPuZMds6nybb8E2iTWkF5GZMgO8wDM/VuJExnKVhc6QwOZmbEa8hN5lQ+h
         zZBykK+XewpChdUcJ7fbh88FWHFco3FV0qvS0L2FVSVs4rITSWnsrmbev1cgaV2dZg0r
         zSAAtJsx/4Oe6hQz8l2RoUYk48cmsZiJXt+tGc6F/K7hIUKt4d1aBwmiODwOYT2Shavk
         0SJA==
X-Gm-Message-State: APjAAAVonIFA68cDJREqSD/STTgEHYnzwziGuTzckwAzpRkY+/IG28Q9
        yhxRbOdJISbz/wDoRnk/Z1duVXY4yPyxyN1ioBXe8w==
X-Google-Smtp-Source: APXvYqyiMvIfMHJa6jtTNF7WOQHsMxOkSldNyn8MUHNdWP3Fj7opTDOfnLFJq4JdlGDKxe64vgWOdgJCE3pWYgnGJM4=
X-Received: by 2002:ac8:4890:: with SMTP id i16mr2339246qtq.141.1572472987115;
 Wed, 30 Oct 2019 15:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20191030193532.262014-1-ast@kernel.org> <20191030193532.262014-2-ast@kernel.org>
In-Reply-To: <20191030193532.262014-2-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Oct 2019 15:02:54 -0700
Message-ID: <CAEf4BzaD6j=MFkHAK344BaqBihoE-Ym5ahxvL2x_mgRHn1S2Lw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: replace prog_raw_tp+btf_id with prog_tracing
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 30, 2019 at 12:36 PM Alexei Starovoitov <ast@kernel.org> wrote:
>
> The bpf program type raw_tp together with 'expected_attach_type'
> was the most appropriate api to indicate BTF-enabled raw_tp programs.
> But during development it became apparent that 'expected_attach_type'
> cannot be used and new 'attach_btf_id' field had to be introduced.
> Which means that the information is duplicated in two fields where
> one of them is ignored.
> Clean it up by introducing new program type where both
> 'expected_attach_type' and 'attach_btf_id' fields have
> specific meaning.
> In the future 'expected_attach_type' will be extended
> with other attach points that have similar semantics to raw_tp.
> This patch is replacing BTF-enabled BPF_PROG_TYPE_RAW_TRACEPOINT with
> prog_type = BPF_RPOG_TYPE_TRACING
> expected_attach_type = BPF_TRACE_RAW_TP
> attach_btf_id = btf_id of raw tracepoint inside the kernel
> Future patches will add
> expected_attach_type = BPF_TRACE_FENTRY or BPF_TRACE_FEXIT
> where programs have the same input context and the same helpers,
> but different attach points.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  include/linux/bpf.h       |  5 +++++
>  include/linux/bpf_types.h |  1 +
>  include/uapi/linux/bpf.h  |  2 ++
>  kernel/bpf/syscall.c      |  6 +++---
>  kernel/bpf/verifier.c     | 34 +++++++++++++++++++++---------
>  kernel/trace/bpf_trace.c  | 44 ++++++++++++++++++++++++++++++++-------
>  6 files changed, 71 insertions(+), 21 deletions(-)
>

[...]
