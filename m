Return-Path: <SRS0=LuT0=7I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3109C433DF
	for <bpf@archiver.kernel.org>; Tue, 26 May 2020 22:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA03207D8
	for <bpf@archiver.kernel.org>; Tue, 26 May 2020 22:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4vdZrS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbgEZWac (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 May 2020 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgEZWac (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 May 2020 18:30:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3FC061A0F
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:30:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id a23so17668263qto.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2020 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOczGX+c5Gop9OkQfJuWry4FqId72n2UWLyXQ5aTefM=;
        b=r4vdZrS1eD3OOhJMPaH3YWJDF/vdF3XHNXnQuMr3AUXDWTIdqBSDAypvb9MHFSzsrW
         kXHcJdixmNe2AAjMNj9hRe3TVsOqOG8eq+e/ub6GmrkgRXebTegR801rhu34grb7fP4A
         04mXlsx0yQGGwZHUEakgoDaSUbRO4ztwYoFDAlQ3sJbM9AJbXTJxUC4BBlGZdW6skR13
         f5MXQZV8GHt6xTWsWZnVsgjPLbtZngBodc5e3k6DV26TwB7WG3Y3+6ICk247M4QhKiX9
         +UGap1lIb0NAkYOzu8F3YJKy4ymLDx+opiuA1wipeKLq1NBpm0Hj4fLgZ9nhwiP8HpOc
         PRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOczGX+c5Gop9OkQfJuWry4FqId72n2UWLyXQ5aTefM=;
        b=YEnz1eUJxHnPcussu/efwKcY51BlmVw+avPh3W/tZPvFLTxLMf5yuC8t3PWEZcflOB
         d++ccVigFVkEPeeL778wfOJQyLdwyRywL4gvUqYNHqtriKnMs/L9pI9SVKtyNO2WfjAh
         RHizLCR+QSUAR0ptk2NopD+2j+oSz8/Rt1XOz/yNuWPDzVQ31IolveKoEg5ykTHtI6Fk
         /M90vBndu7O4Js8R5CLwixHMeuXYOM2aiyK0CPOLP8YCOUjURRf/uxBeSEtIqoEyJkKh
         OiojZEa4fzooLKMU/0yxRcLzm5b78oCrk9moHzkV9VMJnLX0i1fmuihb+KkSd+E27jPf
         2TAQ==
X-Gm-Message-State: AOAM530AERTUbJn080D//jlM2sVRmcnSKliygw1qNEjozlL2pULM6jmo
        SDcDK1BeMtyK4bex3GGvDrrREdFL6v4lFHQpyXdXV4YfQJs=
X-Google-Smtp-Source: ABdhPJyujHgyB+NSIx7VThVbkgLCTs12/nAqBlW5lJ1beA9B0kJ3f79nLZStnoYsXPU1DcXiQEi30yafmxYSRz+AvCM=
X-Received: by 2002:ac8:42ce:: with SMTP id g14mr1143657qtm.117.1590532230402;
 Tue, 26 May 2020 15:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com> <20200522041310.233185-5-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-5-yauheni.kaliuta@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 26 May 2020 15:30:19 -0700
Message-ID: <CAEf4BzZN=cMSFtinNOHMkDhposYPeHqgtJSwnpFSnQ2bX8BfyA@mail.gmail.com>
Subject: Re: [PATCH 4/8] selftests/bpf: fix object files installation
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Benc <jbenc@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 21, 2020 at 9:14 PM Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
>
> There are problems with bpf test programs object files:
>
> 1) some of them are build for flavored test runner and should be
> installed in the subdirectory;
> 2) it's possible that the same file mentioned several times (added
> for every different unflavored test runner);
> 3) some generated files are not treated properly.
>
> Fix 1) by adding subdirectory to the list. rsync -a in the install
> target will handle it.
>
> Fix 2) by filtering the list. Performance should not matter for such
> amount of files.
>
> Fix 3) by use proper (TEST_GEN_FILES) variable for the list.
>
> Fixes: 309b81f0fdc4 ("selftests/bpf: Install generated test progs")
> Fixes: e47a179997ce ("bpf, testing: Add missing object file to
> TEST_FILES")
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 19091dbc8ca4..1ba3d72c3261 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -42,8 +42,7 @@ ifneq ($(BPF_GCC),)
>  TEST_GEN_PROGS += test_progs-bpf_gcc
>  endif
>
> -TEST_GEN_FILES =
> -TEST_FILES = test_lwt_ip_encap.o \
> +TEST_GEN_FILES = test_lwt_ip_encap.o \
>         test_tc_edt.o
>
>  BTF_C_FILES = $(wildcard progs/btf_dump_test_case_*.c)
> @@ -273,7 +272,11 @@ TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS)
>  TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,      \
>                                  $$(filter-out $(SKEL_BLACKLIST),       \
>                                                $$(TRUNNER_BPF_SRCS)))
> -TEST_GEN_FILES += $$(TRUNNER_BPF_OBJS)
> +
> +TO_ADD := $(if $2,$$(TRUNNER_OUTPUT),$$(TRUNNER_BPF_OBJS))
> +$$(foreach i,$$(TO_ADD),\
> +       $$(eval \
> +               TEST_GEN_FILES += $$(if $$(filter $$i,$$(TEST_GEN_FILES)),,$$i)))

This makes me cringe. Can we not have three levels of nested evals,
please? I also didn't get exactly what's the problem you are trying to
solve, could you give some example, please?

>
>  # Evaluate rules now with extra TRUNNER_XXX variables above already defined
>  $$(eval $$(call DEFINE_TEST_RUNNER_RULES,$1,$2))
> --
> 2.26.2
>
