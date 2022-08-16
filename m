Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F26C25B0E
	for <bpf@archiver.kernel.org>; Tue, 16 Aug 2022 22:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiHPWjd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Aug 2022 18:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbiHPWjc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 18:39:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5127963B;
        Tue, 16 Aug 2022 15:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A141B81ABE;
        Tue, 16 Aug 2022 22:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F7EC433D6;
        Tue, 16 Aug 2022 22:39:27 +0000 (UTC)
Date:   Tue, 16 Aug 2022 18:39:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guangbin Huang <huangguangbin2@huawei.com>
Cc:     <pmladek@suse.com>, <senozhatsky@chromium.org>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <lipeng321@huawei.com>, <shenjian15@huawei.com>
Subject: Re: [PATCH] lib/vnsprintf: add const modifier for param 'bitmap'
Message-ID: <20220816183935.2039e0ed@gandalf.local.home>
In-Reply-To: <20220816144557.30779-1-huangguangbin2@huawei.com>
References: <20220816144557.30779-1-huangguangbin2@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 16 Aug 2022 22:45:57 +0800
Guangbin Huang <huangguangbin2@huawei.com> wrote:

> From: Jian Shen <shenjian15@huawei.com>
> 
> There is no modification for param bitmap in function
> bitmap_string() and bitmap_list_string(), so add const
> modifier for it.

Yep, seems so.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
