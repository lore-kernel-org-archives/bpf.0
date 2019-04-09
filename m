Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C75C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 16:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B719B2084C
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 16:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDIQK5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:10:57 -0400
Received: from smtp7.emailarray.com ([65.39.216.66]:52496 "EHLO
        smtp7.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfDIQK5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 12:10:57 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Apr 2019 12:10:57 EDT
Received: (qmail 92408 invoked by uid 89); 9 Apr 2019 16:04:15 -0000
Received: from unknown (HELO ?172.20.52.29?) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTk5LjIwMS42NC4xMzM=) (POLARISLOCAL)  
  by smtp7.emailarray.com with (AES256-GCM-SHA384 encrypted) SMTP; 9 Apr 2019 16:04:15 -0000
From:   "Jonathan Lemon" <jlemon@flugsvamp.com>
To:     "Magnus Karlsson" <magnus.karlsson@intel.com>
Cc:     bjorn.topel@intel.com, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] libbpf: fix crash in XDP socket part with new
 larger BPF_LOG_BUF_SIZE
Date:   Tue, 09 Apr 2019 09:04:11 -0700
X-Mailer: MailMate (1.12.4r5594)
Message-ID: <E5CED6A9-274F-491E-AF88-B05E745B0BD5@flugsvamp.com>
In-Reply-To: <1554814174-28765-1-git-send-email-magnus.karlsson@intel.com>
References: <1554814174-28765-1-git-send-email-magnus.karlsson@intel.com>
MIME-Version: 1.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9 Apr 2019, at 5:49, Magnus Karlsson wrote:

> In commit da11b417583e ("libbpf: teach libbpf about log_level bit 2"),
> the BPF_LOG_BUF_SIZE was increased to 16M. The XDP socket part of
> libbpf allocated the log_buf on the stack, but for the new 16M buffer
> size this is not going to work. Change the code to allocate the
> log_buf using malloc instead. If the allocation fails, we go ahead and
> load the program without a log buffer.
>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>

Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
