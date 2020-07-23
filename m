Return-Path: <SRS0=Cb5B=BC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11415C433E4
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 20:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3502065F
	for <bpf@archiver.kernel.org>; Thu, 23 Jul 2020 20:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgGWU3m (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWU3m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jul 2020 16:29:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC3DC0619DC;
        Thu, 23 Jul 2020 13:29:42 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 250F62CD;
        Thu, 23 Jul 2020 20:29:41 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:29:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] docs: core-api/printk-formats.rst: use literal block
 syntax
Message-ID: <20200723142940.2867e864@lwn.net>
In-Reply-To: <20200718165107.625847-8-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
        <20200718165107.625847-8-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 18 Jul 2020 13:51:02 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> Fix the following warning:
> 
> WARNING: Definition list ends without a blank line;
> unexpected unindent.
> 
> By switching to the literal block syntax.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  Documentation/core-api/printk-formats.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 1beac4719e437..6d26c5c6ac485 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -494,9 +494,11 @@ Time and date
>  	%pt[RT]t		HH:MM:SS
>  	%pt[RT][dt][r]
>  
> -For printing date and time as represented by
> +For printing date and time as represented by::
> +
>  	R  struct rtc_time structure
>  	T  time64_t type
> +
>  in human readable format.

Applied, thanks.

jon
