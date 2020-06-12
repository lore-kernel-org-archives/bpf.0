Return-Path: <SRS0=5juC=7Z=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B98C433DF
	for <bpf@archiver.kernel.org>; Fri, 12 Jun 2020 10:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E00A2204EC
	for <bpf@archiver.kernel.org>; Fri, 12 Jun 2020 10:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgFLKPG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Jun 2020 06:15:06 -0400
Received: from smtprelay0080.hostedemail.com ([216.40.44.80]:56746 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725927AbgFLKPF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Jun 2020 06:15:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 5E8FE18002A55;
        Fri, 12 Jun 2020 10:15:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tree29_1c128ad26ddb
X-Filterd-Recvd-Size: 2024
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 12 Jun 2020 10:14:59 +0000 (UTC)
Message-ID: <427be84b1154978342ef861f1f4634c914d03a94.camel@perches.com>
Subject: Re: [PATCH] xdp_rxq_info_user: Replace malloc/memset w/calloc
From:   Joe Perches <joe@perches.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Gaurav Singh <gaurav1086@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        "open list:XDP (eXpress Data Path)" <netdev@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Fri, 12 Jun 2020 03:14:58 -0700
In-Reply-To: <20200612084244.4ab4f6c6@carbon>
References: <20200611150221.15665-1-gaurav1086@gmail.com>
         <20200612003640.16248-1-gaurav1086@gmail.com>
         <20200612084244.4ab4f6c6@carbon>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-06-12 at 08:42 +0200, Jesper Dangaard Brouer wrote:
> On Thu, 11 Jun 2020 20:36:40 -0400
> Gaurav Singh <gaurav1086@gmail.com> wrote:
> 
> > Replace malloc/memset with calloc
> > 
> > Fixes: 0fca931a6f21 ("samples/bpf: program demonstrating access to xdp_rxq_info")
> > Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> 
> Above is the correct use of Fixes + Signed-off-by.
> 
> Now you need to update/improve the description, to also
> mention/describe that this also solves the bug you found.

This is not a fix, it's a conversion of one
correct code to a shorter one.


