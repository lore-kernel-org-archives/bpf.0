Return-Path: <SRS0=Mmu5=7R=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1021C433DF
	for <bpf@archiver.kernel.org>; Thu,  4 Jun 2020 23:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966722075B
	for <bpf@archiver.kernel.org>; Thu,  4 Jun 2020 23:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNlDKQlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgFDXi6 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Jun 2020 19:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFDXi5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 19:38:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CFFC08C5C0
        for <bpf@vger.kernel.org>; Thu,  4 Jun 2020 16:38:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so3833097pfe.4
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2020 16:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qYup94zySP3Uxa7E284Nu23pVrTSfDC94qvp+MhlSE8=;
        b=QNlDKQlwJzGNpaIA5XMGYnQTTE21/S1uyo2woyldXVIHARMi9y+JM7OnQf1zCDswHs
         fs6uKwuNsLwrNiIx5K32FICKgigqASrkQ7okD80ObWpG6z7os5TGL8bpqsVFEo/Z6CNx
         tB7/9TkqOlyz+xkHFLuXohB0RkunAym2yJd30P9wD9Vn9xZe2yKuwZHx89qm/E5937I1
         6ceplpFHeb+xisubcx3d/LRlLPWWOoQtuWSCqS8fHK59jsx5PYi4HFRpSdWnZFnE1pa/
         tc/Eda4zbF358+eJVvCnmxk9iBSNl/TwS0aqrObMov42G7HR+XdX0R9y66xjsBQssL4e
         19iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qYup94zySP3Uxa7E284Nu23pVrTSfDC94qvp+MhlSE8=;
        b=LOuZpqCB6R9GCkfGvc9WEnFsnLXolU/q86ofiCMhblI8P+cdS+kZlnZYtapRyj2Ik8
         1puqE9e6/m62XgY46FrwkY1Jn4LUccEZoOwtm/N0WbLD+MWHUC5YWAeD3xUFQDS2nu+U
         WPgFhE67kNCCjnupnxcFHkW+trQ5cSN3XKi0Odd37IliPUvpDnDk/uKe/oK4rPU+HXRb
         hKgCsW/7SRxzER6afJzar7ORHVflTDeXjKVnXgB89mgZ/kKpuwES8OUOGYmfGNmy2mLw
         teTQj7tLApJEc4b9+4eQKF6OLIztmo53IFk0FpewtlF8HTnHW3uJ4t6qJtO+q7++q8Fx
         sqlA==
X-Gm-Message-State: AOAM530Eu6EzzuJVr2evS49BX9MSPQOtjJzpjtzARQcGM7wbgXyMqGqf
        H/YvwIHfQO7fq2e51k3viGBERe7ZelGFpv0963AWfg==
X-Google-Smtp-Source: ABdhPJyjoKn2wPp3E+oSKiq/DLzPrKJg0Fnrv4RNZFCRKtQgm2qPWGeyhgvLV0B9oQRtvUCNduNx94uDPs3qYOmgYU8=
X-Received: by 2002:a63:f00d:: with SMTP id k13mr6940395pgh.263.1591313936725;
 Thu, 04 Jun 2020 16:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200527170840.1768178-6-jakub@cloudflare.com> <202005281031.S7IMfvFG%lkp@intel.com>
In-Reply-To: <202005281031.S7IMfvFG%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Jun 2020 16:38:44 -0700
Message-ID: <CAKwvOdmof_tGVAN+gkq8R3Hq_sRDHXE_cB+37Sd7gKvgzVzVHw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/8] bpf: Add link-based BPF program attachment
 to network namespace
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf <bpf@vger.kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Network Development <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 27, 2020 at 8:19 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Jakub,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on bpf-next/master]
> [also build test WARNING on net-next/master next-20200526]
> [cannot apply to bpf/master net/master linus/master v5.7-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Jakub-Sitnicki/Link-based-program-attachment-to-network-namespaces/20200528-011159
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: arm-randconfig-r035-20200527 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 3393cc4cebf9969db94dc424b7a2b6195589c33b)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> >> kernel/bpf/net_namespace.c:130:6: warning: variable 'inum' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]

This looks legit to me. Please fix.

> if (net)
> ^~~
> kernel/bpf/net_namespace.c:134:26: note: uninitialized use occurs here
> info->netns.netns_ino = inum;
> ^~~~
> kernel/bpf/net_namespace.c:130:2: note: remove the 'if' if its condition is always true
> if (net)
> ^~~~~~~~
> kernel/bpf/net_namespace.c:123:19: note: initialize the variable 'inum' to silence this warning
> unsigned int inum;
> ^
> = 0
> 1 warning generated.
>
> vim +130 kernel/bpf/net_namespace.c
>
>    118
>    119  static int bpf_netns_link_fill_info(const struct bpf_link *link,
>    120                                      struct bpf_link_info *info)
>    121  {
>    122          const struct bpf_netns_link *net_link;
>    123          unsigned int inum;
>    124          struct net *net;
>    125
>    126          net_link = container_of(link, struct bpf_netns_link, link);
>    127
>    128          rcu_read_lock();
>    129          net = rcu_dereference(net_link->net);
>  > 130          if (net)
>    131                  inum = net->ns.inum;
>    132          rcu_read_unlock();
>    133
>    134          info->netns.netns_ino = inum;
>    135          info->netns.attach_type = net_link->type;
>    136          return 0;
>    137  }
>    138
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202005281031.S7IMfvFG%25lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers
