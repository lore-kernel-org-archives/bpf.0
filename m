Return-Path: <SRS0=joy4=5R=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F41C43331
	for <bpf@archiver.kernel.org>; Wed,  1 Apr 2020 00:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E5020786
	for <bpf@archiver.kernel.org>; Wed,  1 Apr 2020 00:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIxiKBCs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbgDAADW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 31 Mar 2020 20:03:22 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:37002 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbgDAADV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 20:03:21 -0400
Received: by mail-qv1-f66.google.com with SMTP id n1so11936604qvz.4;
        Tue, 31 Mar 2020 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmTvz/L6YmOrh3p07+F8l4GXjEVQNak2kA1fSgQ4Mjo=;
        b=aIxiKBCsylb6yX3xKI+LsQsqD0w6HyUuOtycBCSZkXBMPqOnHc2TtCNpmmKNjSX4jz
         E6TkCysPrh15L662DEQtnYOMpbMzgrTHXK5wlH1ZxSK49B0DvmybzIoSoUVjJ54XGjVF
         Hrc0IC9VXLt5tbsUM8us6woO1kz1OpIhbRAbP2KvBxV6+vX0k2ozWBnhNbWvXR7/LKi5
         +Y657UvUeShXYWfIsXFmeCc+OvGOrcRJrxnUCjrCRGiwdY6qwkrtOoIq+8UEDgFkGeli
         xtrnkBU+0ImdgeOiXjy+I3Utt/iM9GAvVf/qRtf7hFA66IKrs8PioREy9drD+gIIklg8
         KU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmTvz/L6YmOrh3p07+F8l4GXjEVQNak2kA1fSgQ4Mjo=;
        b=mwGJJuk+SrSZupi3cNjWvRmI1zo7U8b1qRu2JiY7qSmY5mRIvHlM94NEDHrtQNxIHs
         e+9+b7Wsy2j135PfvaSDKJa6tzGt3Mwq+katmiJYjBh5Y2DMKB1hezRLK2FrgVQCsoYL
         yWvuGZtUfJxOov2++AB0Bfe0iBsKSklUiqXchMUmL8a7cuQmPrfnap8aFO3C2btnhxA4
         /Icwjq2IaFCjfdi0cuMJ+a2LmN1RlgEkza6JVt9+SO80q/SCqjTRGXQzx9aU+RQwfqUK
         Ea4XV/JFlNHnHLhsPrPHENnzHE/D01BolBpBxlcTlBcqhHeO4tuCMBcBFSgo+SAwLRav
         7TQQ==
X-Gm-Message-State: ANhLgQ2lQ627OkPXg9YXxxoxXZU9VNrXHUM1v2dV6f0u4u2HrDmT35rP
        J6ZrK3dKfzPQs1ZzOAE7CF2Bdg581XT9yVdGHqw=
X-Google-Smtp-Source: ADFU+vu6cimqTEAdtf39u8/T8WKKgNSMwihn5EK0r1F+dpBI+yAtS8ffjb/s/DQe8an3NADwSJckknxiktPrBP5Bf4E=
X-Received: by 2002:a0c:bc15:: with SMTP id j21mr18213275qvg.228.1585699398382;
 Tue, 31 Mar 2020 17:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200331215536.34162-1-slava@bacher09.org>
In-Reply-To: <20200331215536.34162-1-slava@bacher09.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 Mar 2020 17:03:07 -0700
Message-ID: <CAEf4BzZXtCPhhntbgrqL0z9aX4yrNUXfFZPk+qb_5-+Nx6PRzw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Kees Cook <keescook@chromium.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-hardening@lists.openwall.com,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 31, 2020 at 2:57 PM Slava Bacherikov <slava@bacher09.org> wrote:
>
> Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
> enabled will produce invalid btf file, since gen_btf function in
> link-vmlinux.sh script doesn't handle *.dwo files.
>
> Enabling DEBUG_INFO_REDUCED will also produce invalid btf file, and
> using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.
>
> Signed-off-by: Slava Bacherikov <slava@bacher09.org>
> Reported-by: Jann Horn <jannh@google.com>
> Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
> Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
> ---

LGTM, but let's wait on Kees about COMPILE_TEST dependency...

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f61d834e02fe..9ae288e2a6c0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -223,6 +223,7 @@ config DEBUG_INFO_DWARF4
>  config DEBUG_INFO_BTF
>         bool "Generate BTF typeinfo"
>         depends on DEBUG_INFO
> +       depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED && !GCC_PLUGIN_RANDSTRUCT
>         help
>           Generate deduplicated BTF type information from DWARF debug info.
>           Turning this on expects presence of pahole tool, which will convert
> --
> 2.24.1
>
