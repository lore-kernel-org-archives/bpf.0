Return-Path: <SRS0=QOwA=AE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465C0C433DF
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 18:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F147220774
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 18:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0RLb984"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgFWSAD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgFWSAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 14:00:03 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA39C061573
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 11:00:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b4so19625463qkn.11
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 11:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NTz+lh+xtUQgi1Y6Zn/t6QUyWx66KVZDJO+I/2WoyIY=;
        b=n0RLb984gZv+rIE2rqNPd1sNhZYymwfCNMqjwzdzPL0YVzylJUjBGI+Fm5pjDonkjo
         IjZXbSQkKT/0H0zSa+alpM59IgY9MuN431QYboB/7wc1jXd6UqzkQzQ8CFA5Yw25/1uk
         p5ZKyqoY0kd8KKVihLReF9oqhgxpMWLxEklIGlEGI+zWdA1+zWQDPhV8sM0eY848mUGO
         MWRZb+b0OVBxj17eHFlOkC7OiCXtOwGN/ctGY/iLm2gRJSNwn1wM1kRErvguG01YQHih
         f3CrLxQzN5stjNtrWtRFZHXVp/Ux0P/TOWC33DTkvbU7DprjdGFRr6LRlmyU1/DagqR/
         4Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NTz+lh+xtUQgi1Y6Zn/t6QUyWx66KVZDJO+I/2WoyIY=;
        b=jPKi3nKa4sN2i33s7fN1cJMFSxSSy5PE1PZxca/J5d2lm3KnwWVpk/8low6Tf3c577
         UqpHi5cwyV7TG9jKqRA38EgJ5beVC0J6YPXK2I4hhCU3Obfyve2zYLNTsHlYP4Osj11r
         1CKZMju8fOh7YpWKeY81hCTMDvJDlqp3dQYgVwWTfdi16B47JJ+iiCqYQaLweWPJjaNp
         LQuZgy4Y/sfzt6SMgNsGmTd82WCalWzAotGqm9b4dyh9MpbXwPgVwYpoolDadn85iQVE
         mGNltVB7ihfkYtmE9jwz1/+ktsCsKckc0JSMkdwzBX0wgB5Vxe/ZKjtRezDth+/uDZfg
         /Dkg==
X-Gm-Message-State: AOAM533bEf9vPYH3NBc3GeUrkvRRfUvutAXgpa/VjtyzzNZkEQMc7G+0
        EcmhSo2xotFdaQSoOUCLHKEuwreJ92cTO2gvQwU=
X-Google-Smtp-Source: ABdhPJyd1euduH15BKYtSLSYgLyer+Sm7bkSeW6o9c1rH8alBKAiKSQQNTkveUoCgcy+v45ZLDHnFL2/Rmv/jv2xGCs=
X-Received: by 2002:a37:a89:: with SMTP id 131mr21148364qkk.92.1592935202414;
 Tue, 23 Jun 2020 11:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200623103710.10370-1-tklauser@distanz.ch>
In-Reply-To: <20200623103710.10370-1-tklauser@distanz.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 Jun 2020 10:59:51 -0700
Message-ID: <CAEf4BzZ51uRdSkZNU=SwJd0rHJVCjxumpxz7pmMvDetvXckwvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools, bpftool: Correctly evaluate
 $(BUILD_BPF_SKELS) in Makefile
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin@isovalent.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 23, 2020 at 3:37 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> Currently, if the clang-bpf-co-re feature is not available, the build
> fails with e.g.
>
>   CC       prog.o
> prog.c:1462:10: fatal error: profiler.skel.h: No such file or directory
>  1462 | #include "profiler.skel.h"
>       |          ^~~~~~~~~~~~~~~~~
>
> This is due to the fact that the BPFTOOL_WITHOUT_SKELETONS macro is not
> defined, despite BUILD_BPF_SKELS not being set. Fix this by correctly
> evaluating $(BUILD_BPF_SKELS) when deciding on whether to add
> -DBPFTOOL_WITHOUT_SKELETONS to CFLAGS.
>
> Fixes: 05aca6da3b5a ("tools/bpftool: Generalize BPF skeleton support and generate vmlinux.h")
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  tools/bpf/bpftool/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 06f436e8191a..8c6563e56ffc 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -155,7 +155,7 @@ $(OUTPUT)pids.o: $(OUTPUT)pid_iter.skel.h
>  endif
>  endif
>
> -CFLAGS += $(if BUILD_BPF_SKELS,,-DBPFTOOL_WITHOUT_SKELETONS)
> +CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)

Oh, what a rookie mistake :) Thanks for fixing!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>
>  $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
>         $(QUIET_CC)$(CC) $(CFLAGS) -c -MMD -o $@ $<
> --
> 2.27.0
>
