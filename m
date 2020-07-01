Return-Path: <SRS0=pDiR=AM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3BDC433E0
	for <bpf@archiver.kernel.org>; Wed,  1 Jul 2020 22:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CF320780
	for <bpf@archiver.kernel.org>; Wed,  1 Jul 2020 22:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rY7+GLri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgGAWH0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGAWH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jul 2020 18:07:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B334BC08C5C1
        for <bpf@vger.kernel.org>; Wed,  1 Jul 2020 15:07:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q7so15841897ljm.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2020 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WUmFQUcd7U2wBK6gF6dQH2hVoOKP3K/dEQqxLMcEx4=;
        b=rY7+GLriQNJ+S302Sk3PuJ6wgQrf7Df6B8Hv8g6MyFTYM4zolEMuyW5KfhGMqPgOu+
         pDFHMeDVn8Zy5zQyY1s8u7tkwArxQ7mTj34QTBDbsLc2ux8+KDEWDRpkIZBPimzVE4xu
         2OKD4Ev3QH6qgFf+7ClWuQCQJrGTSnX2ux+He5W8ZqlSaxb5anrAlcyXV3strY3G6XlV
         LlO0BdThaU8TgJcW+f9WssPwjpUBaKiDgno9K6sgv71eK2a9D7M/X89t7G99bhGs4624
         7E/0evw3ptep26b3wwPD0h1NqEAc7+Uj5QesoA+Ntbg31e4xMlGTVEZlMydfmOKr+9Bw
         v3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WUmFQUcd7U2wBK6gF6dQH2hVoOKP3K/dEQqxLMcEx4=;
        b=p2ff2/MD8eXZ7VElUP/paop2PoZd1jCIXNegrzKH3mVhTqRQogDMTI7CBFlln5rRPK
         X3nI+YdxNFK0bKa8IJsu50QwXxM6Jkq4kS3qcd6f37dWUHoaa6S64aRbZ5d//X8wY2u2
         2EkWZtFcExSb58ud9ma1xgIpFqqvh+XBW228qODulWUNcuw4SihcbSCbUEgFFXGG1RPr
         sNYqLOjudtF+rHjEC8TWlgFclH0f1eQMAer5ry1X9ZweC/2cA6gUSMlv4++sz6cJBdSB
         buTISxoNwlxaZJjLlmWzyl2cAwpcX134Y5el8PSRbi43XQJ67RFJChrgfL/zGuAdCZED
         o3Qg==
X-Gm-Message-State: AOAM532oFJ0jVVF6r8vY5u5Zyq78bYrJF0pIQEizOpaSC9bjeHDn3zun
        gn133RqXP+G3lF1l0P/8l+wBo3UGR1jtHpdI3Bo=
X-Google-Smtp-Source: ABdhPJyxhlEvtwsBYma804bFxih+T+hjHK1LYrm417/imhwMu4j8edOq6FsM65SsiFcdOit7UXZ7i/IK4IT3C6qSEYE=
X-Received: by 2002:a2e:8ec8:: with SMTP id e8mr4792404ljl.51.1593641244194;
 Wed, 01 Jul 2020 15:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <202007020357.AiqTXmOv%lkp@intel.com>
In-Reply-To: <202007020357.AiqTXmOv%lkp@intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Jul 2020 15:07:13 -0700
Message-ID: <CAADnVQLpDep2Yw4XyH7bK+YQwUxgm4VvN-1equgM1OJ6wfHNag@mail.gmail.com>
Subject: Re: [bpf-next:master 9995/9999] kernel/bpf/stackmap.c:363:3: error:
 implicit declaration of function 'stack_trace_save_tsk'
To:     kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, kbuild-all@lists.01.org,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 1, 2020 at 12:25 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> head:   6b207d66aa9fad0deed13d5f824e1ea193b0a777
> commit: fa28dcb82a38f8e3993b0fae9106b1a80b59e4f0 [9995/9999] bpf: Introduce helper bpf_get_task_stack()
> config: alpha-allyesconfig (attached as .config)
> compiler: alpha-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout fa28dcb82a38f8e3993b0fae9106b1a80b59e4f0
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    kernel/bpf/stackmap.c: In function 'get_callchain_entry_for_task':
> >> kernel/bpf/stackmap.c:363:3: error: implicit declaration of function 'stack_trace_save_tsk' [-Werror=implicit-function-declaration]
>      363 |   stack_trace_save_tsk(task, (unsigned long *)(entry->ip + init_nr),
>          |   ^~~~~~~~~~~~~~~~~~~~

Song,
you're on it, right?
