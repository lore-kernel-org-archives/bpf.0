Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A35C04AA5
	for <bpf@archiver.kernel.org>; Thu, 25 Aug 2022 09:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiHYJH5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Aug 2022 05:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiHYJH4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 05:07:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34547E81C;
        Thu, 25 Aug 2022 02:07:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C020634FFC;
        Thu, 25 Aug 2022 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661418473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZHbxp4wW4UmzUmh4XCTZ+wLLXSuw5g/i7CYWPwKp9I=;
        b=TDCdXpFANzcf2BsutI0MOoaO3u+98fgAWYbg6sbPae9Jb/y8nhG582Z9lnFLdiB0YG1ETT
        jKG/wibbYJsEUTzAPcf+lZ8umzrbhly/NYQtVQfCP+e2m8kCG/EA9OSAEsEzbm3autZ593
        Iywm9+PScv6KVmMMcUppMsgTivIprBs=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7E9C92C141;
        Thu, 25 Aug 2022 09:07:53 +0000 (UTC)
Date:   Thu, 25 Aug 2022 11:07:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Guangbin Huang <huangguangbin2@huawei.com>
Cc:     rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        lipeng321@huawei.com, shenjian15@huawei.com
Subject: Re: [PATCH] lib/vnsprintf: add const modifier for param 'bitmap'
Message-ID: <Ywc76XQFYddD8KOf@alley>
References: <20220816144557.30779-1-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816144557.30779-1-huangguangbin2@huawei.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue 2022-08-16 22:45:57, Guangbin Huang wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> There is no modification for param bitmap in function
> bitmap_string() and bitmap_list_string(), so add const
> modifier for it.
> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>

The patch has been committed into printk/linux.git, branch
for-6.1/trivial.

Best Regards,
Petr
