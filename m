Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E90BC5519F
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 12:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC28922254
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 12:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="reAmGndx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgKTM6h (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 07:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbgKTM6g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 07:58:36 -0500
Received: from linux-8ccs (p3ee2c6e9.dip0.t-ipconnect.de [62.226.198.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716612224C;
        Fri, 20 Nov 2020 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605877115;
        bh=pJax2K+i/Muhgm/YCZKN1EDGSzLusjUdKG89sWsR/H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reAmGndxw3FoA+oBZzcacsxfSRvTBRjtGaDZ7HV1lJVgTQIboc5Q7IUv2KZrcyPXj
         dRQS4LDw1dI/zQaCkRxv2zPevEjtqK3e/KwpuWpcqVR8xwP/DzmDUP0iax86aQstw4
         LSYSfUc/5H3ynbxn2pZwsi2+3GY/Whja0wZreH1g=
Date:   Fri, 20 Nov 2020 13:58:30 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, kernel-team@fb.com,
        Bruce Allan <bruce.w.allan@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: sanitize BTF data pointer after module
 is loaded
Message-ID: <20201120125829.GA7989@linux-8ccs>
References: <20201119182600.1496862-1-andrii@kernel.org>
 <20201119182600.1496862-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201119182600.1496862-2-andrii@kernel.org>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+++ Andrii Nakryiko [19/11/20 10:26 -0800]:
>Given .BTF section is not allocatable, it will get trimmed after module is
>loaded. BPF system handles that properly by creating an independent copy of
>data. But prevent any accidental misused by resetting the pointer to BTF data.
>
>Suggested-by: Jessica Yu <jeyu@kernel.org>
>Fixes: 36e68442d1af ("bpf: Load and verify kernel module BTFs")
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Thanks, Andrii!

Acked-by: Jessica Yu <jeyu@kernel.org>

>---
> kernel/module.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index f2996b02ab2e..18f259d61d14 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -3709,6 +3709,11 @@ static noinline int do_init_module(struct module *mod)
> 	mod->init_layout.ro_size = 0;
> 	mod->init_layout.ro_after_init_size = 0;
> 	mod->init_layout.text_size = 0;
>+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>+	/* .BTF is not SHF_ALLOC and will get removed, so sanitize pointer */
>+	mod->btf_data = NULL;
>+	mod->btf_data_size = 0;
>+#endif
> 	/*
> 	 * We want to free module_init, but be aware that kallsyms may be
> 	 * walking this with preempt disabled.  In all the failure paths, we
>-- 
>2.24.1
>
