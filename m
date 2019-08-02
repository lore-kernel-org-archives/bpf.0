Return-Path: <SRS0=X7YH=V6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABECC41514
	for <bpf@archiver.kernel.org>; Fri,  2 Aug 2019 18:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9D12087C
	for <bpf@archiver.kernel.org>; Fri,  2 Aug 2019 18:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405984AbfHBSfl (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Aug 2019 14:35:41 -0400
Received: from smtp.emailarray.com ([69.28.212.198]:16916 "EHLO
        smtp2.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405988AbfHBSfl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Aug 2019 14:35:41 -0400
Received: (qmail 68070 invoked by uid 89); 2 Aug 2019 18:29:01 -0000
Received: from unknown (HELO ?172.20.175.84?) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTk5LjIwMS42NC4z) (POLARISLOCAL)  
  by smtp2.emailarray.com with (AES256-GCM-SHA384 encrypted) SMTP; 2 Aug 2019 18:29:01 -0000
From:   "Jonathan Lemon" <jlemon@flugsvamp.com>
To:     "=?utf-8?b?QmrDtnJuIFTDtnBlbA==?=" <bjorn.topel@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        "=?utf-8?b?QmrDtnJuIFTDtnBlbA==?=" <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, bruce.richardson@intel.com,
        songliubraving@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] xsk: support BPF_EXIST and BPF_NOEXIST
 flags in XSKMAP
Date:   Fri, 02 Aug 2019 11:28:56 -0700
X-Mailer: MailMate (1.12.5r5635)
Message-ID: <26421FA3-6C40-4E6F-A320-105D35D858B6@flugsvamp.com>
In-Reply-To: <20190802081154.30962-3-bjorn.topel@gmail.com>
References: <20190802081154.30962-1-bjorn.topel@gmail.com>
 <20190802081154.30962-3-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2 Aug 2019, at 1:11, Björn Töpel wrote:

> From: Björn Töpel <bjorn.topel@intel.com>
>
> The XSKMAP did not honor the BPF_EXIST/BPF_NOEXIST flags when updating
> an entry. This patch addresses that.
>
> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>

Reviewed-by: Jonathan Lemon <jonathan.lemon@gmail.com>
