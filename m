Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4589DC433DF
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 20:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274B62065F
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 20:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgGWU1p (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWU1p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 16:27:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92527C0619DC;
        Thu, 23 Jul 2020 13:27:45 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D9FFE2BA;
        Thu, 23 Jul 2020 20:27:44 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:27:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] docs: bpf/bpf_devel_QA.rst: fix reference to
 nonexistent document
Message-ID: <20200723142743.0df6263d@lwn.net>
In-Reply-To: <20200718165107.625847-6-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
        <20200718165107.625847-6-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 18 Jul 2020 13:51:00 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> Fix the following sphinx warning:
> 
> bpf_devel_QA.rst:444: WARNING: Unknown target name:
> "documentation/bpf/btf.rst"
> 
> No target was defined for 'btf.rst' in the document. Fix it.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  Documentation/bpf/bpf_devel_QA.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
> index 0b3db91dc1002..a26aa1b9b2595 100644
> --- a/Documentation/bpf/bpf_devel_QA.rst
> +++ b/Documentation/bpf/bpf_devel_QA.rst
> @@ -643,5 +643,6 @@ when:
>  .. _selftests: ../../tools/testing/selftests/bpf/
>  .. _Documentation/dev-tools/kselftest.rst:
>     https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
> +.. _Documentation/bpf/btf.rst: btf.rst

Applied, thanks.

jon
