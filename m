Return-Path: <SRS0=2zQm=5L=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71643C43331
	for <bpf@archiver.kernel.org>; Thu, 26 Mar 2020 01:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40AF72073E
	for <bpf@archiver.kernel.org>; Thu, 26 Mar 2020 01:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoXmk5CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCZB2p (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:28:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40226 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZB2o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 21:28:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id c9so4022837qtw.7;
        Wed, 25 Mar 2020 18:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HP9H6Y9QQMu+yC14GoCYfTIho414qSgaXRYIZXGF6BQ=;
        b=VoXmk5CBF14E1LKLzFQR47ZOPqOKjtnANeVjT6351ITsYmQYArCU1LSYY3+pN0a8tM
         uwsqfmnxlGQaB1seebAkcKP7JURf4m2t5Nb18J7QFk91azY1BN7FcXikE44JBDIjxgaG
         uBpP0tb/TVEoUZxT+bDxDrnh9nQjPahm5RkLlfsJqVE8GYIULK0Fp9zU0tR8C/VsGm+D
         RTkuPMeH0j2WK0eviQb3bvJBEUKjngRzWpRFc5XpotkEVOJS8C6f1bUzp4fmyh2h+4h3
         +M1nHfI5fAEjzS1fbGjfkBY0IyZBntZad/pQwAxTddleKry+BRQErwWRQU6EwepX5+gv
         Xk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HP9H6Y9QQMu+yC14GoCYfTIho414qSgaXRYIZXGF6BQ=;
        b=ZsGlt/APJIyJYQ4pSXb6Mw4mukgBek5zInWmcxT4KQSl6r74b33rStFNzdup4h4hNM
         bHe+U0WlkwV35OesqA5STG4xyjwpM74mBBkYuYYmgVzIdQQ5LgdsgahZsH7WHZVjU2Ct
         d1K/2IaFyasdihb+VgDHWzbNSC9I1kG6NtLom2ZLOcc4zbG00J89aG6uPnpT5HQ+E9Np
         EIuFaJCIvbr7zfsJVWE81MSj8yuBDFX/lk5jv78ptPkPujtPTukPfOtQYrk0qMZ67oq/
         Cd775EEJUXeHLGM1ycwPR7TSqxegb+frdU38o9ZGAnM7ZsRmTleJk0sarLctv/7gk9tm
         HT4A==
X-Gm-Message-State: ANhLgQ17AIGT0a9Hd6nzuTeGxwVpDqcpb7tREEkydW2xx0XO5o+g1brD
        ugbCx1XddRzwofeOQLBUPOb0yJF8OiX+oa2mKhY=
X-Google-Smtp-Source: ADFU+vt2xg4F6xst0VzwDB0X1v2ReBRbqD3iYTyWZEePNHWPCdWvK+2mGsRhweo2LYlp1gq15Ojy1kz1pLnLdXyMjKk=
X-Received: by 2002:ac8:6918:: with SMTP id e24mr5841827qtr.141.1585186122289;
 Wed, 25 Mar 2020 18:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200325065746.640559-5-andriin@fb.com> <202003260625.uf6AM8WN%lkp@intel.com>
In-Reply-To: <202003260625.uf6AM8WN%lkp@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Mar 2020 18:28:31 -0700
Message-ID: <CAEf4Bzbpm9qC635ViM-kWJB6FMXErCpDgQzbao-xJ1RnaPQXVA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] bpf: implement bpf_prog replacement for
 an active bpf_cgroup_link
To:     kbuild test robot <lkp@intel.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 25, 2020 at 3:58 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Andrii,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on bpf-next/master]
> [cannot apply to bpf/master cgroup/for-next v5.6-rc7 next-20200325]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Andrii-Nakryiko/Add-support-for-cgroup-bpf_link/20200326-055942
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/cgroup-defs.h:22:0,
>                     from include/linux/cgroup.h:28,
>                     from include/linux/memcontrol.h:13,
>                     from include/linux/swap.h:9,
>                     from include/linux/suspend.h:5,
>                     from arch/x86/kernel/asm-offsets.c:13:
> >> include/linux/bpf-cgroup.h:380:45: warning: 'struct bpf_link' declared inside parameter list will not be visible outside of this definition or declaration
>     static inline int cgroup_bpf_replace(struct bpf_link *link,
>                                                 ^~~~~~~~
> --
>    In file included from include/linux/cgroup-defs.h:22:0,
>                     from include/linux/cgroup.h:28,
>                     from include/linux/memcontrol.h:13,
>                     from include/linux/swap.h:9,
>                     from include/linux/suspend.h:5,
>                     from arch/x86/kernel/asm-offsets.c:13:
> >> include/linux/bpf-cgroup.h:380:45: warning: 'struct bpf_link' declared inside parameter list will not be visible outside of this definition or declaration
>     static inline int cgroup_bpf_replace(struct bpf_link *link,
>                                                 ^~~~~~~~
>    20 real  6 user  8 sys  71.33% cpu   make prepare
>
> vim +380 include/linux/bpf-cgroup.h
>
>    379

It's a matter of forward declaring struct bpf_link here. Will fix in
v3, but I'll wait a bit for any feedback before updating.

>  > 380  static inline int cgroup_bpf_replace(struct bpf_link *link,
>    381                                       struct bpf_prog *old_prog,
>    382                                       struct bpf_prog *new_prog)
>    383  {
>    384          return -EINVAL;
>    385  }
>    386
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
