Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA59FC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 00:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBB62184E
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 00:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ope7fDn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfBZAlq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 19:41:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40096 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfBZAlq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 19:41:46 -0500
Received: by mail-ot1-f67.google.com with SMTP id v20so9633284otk.7;
        Mon, 25 Feb 2019 16:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3PZA4n0Ad3UP2ljiXyOzLT9sJquFANm2Z75RBw/eV1A=;
        b=Ope7fDn8hQbaHWT6IMr6xtIfGfSflYhdTI6ujlVKsJpwqqZubETXzzifdBI65pZv8b
         U2h+yVby/VZaGg05vYT46wXBoxQJu0/LgIpXlr/4Z9roUJu8iqyBboeTmvJVV22q56s3
         9h/Sahl8qxWEOjNiepSOcdiP3ZE3ILPQAPXcQdE3/08OrtTMqGHULR3bJgs7V5ew4HDK
         OyBhcIa4jCrHpsnK31M+YXe0qmVKtAJNSLtsHTQSYsiQbX9d4pp8jMFSaTILw69K89ig
         bQZxSGgKpopVQsg5kIZ8v31dSzvzGaOUbiF1+UYxul2sohB4vzzwIYbL+0oO/kY47i+f
         dFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3PZA4n0Ad3UP2ljiXyOzLT9sJquFANm2Z75RBw/eV1A=;
        b=ZEMou6pybPk1rz6+ZydMhcUvpX1WxRG1ERo/ZqwNX9eTn64eC7hqJp/BcCh8j/qB1k
         rcv/M0ZtX80m2MvO1tP9LYOf7wYWO/Y4pHJgPMkyL+jKEEi/r9qkrJONVkWEL2scgZ1V
         mxZgkZvEtxJEvu082OZbv9bTwekFV52fs1717uwCjPFPSGFkwhMVNozFAijCfSKToJEn
         SKNaLrNkjauNqmjEhi+8FqVdFn3hV31I9Kk9jPqwKPt51EXRRK6tV1c83ry/COqkVFoz
         8gnmBEDqjbVrs95XJSJEjuVIqS0OsRQchn2CbqSM67zCjx38CmgK/HBxlOvloeJPTnY5
         g+mg==
X-Gm-Message-State: AHQUAuZ7Q/NN5sTT0faUUAVuoExqPcvMyJIOLaCPcyWyzk1qAM5hyiQN
        p1avq6CSL7Mi0a4KBWkFVJA8rgzTInG5JMK8XgA=
X-Google-Smtp-Source: AHgI3IaePJlUCW7LK665JkqBXyYgrUUIYf2+ONZk/mh3wA4isEH57fkOt34KBCwsFn2qpS6VMTn4K8FYpUIIKyzehsI=
X-Received: by 2002:a05:6830:1193:: with SMTP id u19mr13240139otq.221.1551141705298;
 Mon, 25 Feb 2019 16:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20190225222842.2031962-1-ast@kernel.org>
In-Reply-To: <20190225222842.2031962-1-ast@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Feb 2019 16:41:34 -0800
Message-ID: <CAEf4Bza4Lf-R0mEDrrFi3JEg2WUq_mtnoG0NNnNJB0Mi+0Bb3A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/4] bpf: per program stats
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     davem@davemloft.net, Daniel Borkmann <daniel@iogearbox.net>,
        edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 25, 2019 at 2:29 PM Alexei Starovoitov <ast@kernel.org> wrote:
>
> Introduce per program stats to monitor the usage BPF
>
> v2->v3:
> - rename to run_time_ns/run_cnt everywhere
>
> v1->v2:
> - fixed u64 stats on 32-bit archs. Thanks Eric
> - use more verbose run_time_ns in json output as suggested by Andrii
> - refactored prog_alloc and clarified behavior of stats in subprogs
>
> Alexei Starovoitov (4):
>   bpf: enable program stats
>   bpf: expose program stats via bpf_prog_info
>   tools/bpf: sync bpf.h into tools
>   tools/bpftool: recognize bpf_prog_info run_time_ns and run_cnt

Lgtm, thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>
>  include/linux/bpf.h                           |  9 +++++
>  include/linux/filter.h                        | 20 +++++++++-
>  include/uapi/linux/bpf.h                      |  2 +
>  kernel/bpf/core.c                             | 31 ++++++++++++++-
>  kernel/bpf/syscall.c                          | 39 ++++++++++++++++++-
>  kernel/bpf/verifier.c                         |  7 +++-
>  kernel/sysctl.c                               | 34 ++++++++++++++++
>  .../bpftool/Documentation/bpftool-prog.rst    |  4 +-
>  tools/bpf/bpftool/prog.c                      |  7 ++++
>  tools/include/uapi/linux/bpf.h                |  2 +
>  10 files changed, 148 insertions(+), 7 deletions(-)
>
> --
> 2.20.0
>
