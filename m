Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4A0C433EB
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 20:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D450B208E4
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 20:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgGWURR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWURR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 16:17:17 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1537BC0619DC;
        Thu, 23 Jul 2020 13:17:17 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 602592BA;
        Thu, 23 Jul 2020 20:17:16 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:17:15 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] docs: bpf/index.rst: Add ringbuf.rst
Message-ID: <20200723141715.360723ee@lwn.net>
In-Reply-To: <20200718165107.625847-10-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
        <20200718165107.625847-10-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 18 Jul 2020 13:51:04 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> 
> Fix the following warning
> 
> Documentation/bpf/ringbuf.rst: WARNING: document isn't
> included in any toctree
> 
> By adding it to the index.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  Documentation/bpf/index.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> index 38b4db8be7a2b..0f60b95e83c40 100644
> --- a/Documentation/bpf/index.rst
> +++ b/Documentation/bpf/index.rst
> @@ -58,6 +58,14 @@ Testing and debugging BPF
>     s390
>  
>  
> +Other
> +=====
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   ringbuf
> +
>  .. Links:

Applied, thanks.

jon
