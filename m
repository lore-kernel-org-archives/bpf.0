Return-Path: <SRS0=Qn19=6T=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715C5C47247
	for <bpf@archiver.kernel.org>; Tue,  5 May 2020 03:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57196206CC
	for <bpf@archiver.kernel.org>; Tue,  5 May 2020 03:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEEDCb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 May 2020 23:02:31 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:35450 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgEEDCb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 4 May 2020 23:02:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9C5F31802E6D5;
        Tue,  5 May 2020 03:02:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spade83_6ce8685b68a3f
X-Filterd-Recvd-Size: 1826
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 May 2020 03:02:28 +0000 (UTC)
Message-ID: <5ae86fa9e7fbb92e08055dd60526bf9802217f5f.camel@perches.com>
Subject: Re: [RFC PATCH bpf-next 13/13] MAINTAINERS, xsk: update AF_XDP
 section after moves/adds
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, jonathan.lemon@gmail.com
Cc:     =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        maximmi@mellanox.com, maciej.fijalkowski@intel.com
Date:   Mon, 04 May 2020 20:02:27 -0700
In-Reply-To: <20200504113716.7930-14-bjorn.topel@gmail.com>
References: <20200504113716.7930-1-bjorn.topel@gmail.com>
         <20200504113716.7930-14-bjorn.topel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2020-05-04 at 13:37 +0200, Björn Töpel wrote:
> Update MAINTAINERS to correctly mirror the current AF_XDP socket file
> layout. Also, add the AF_XDP files of libbpf.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -18451,8 +18451,12 @@ R:	Jonathan Lemon <jonathan.lemon@gmail.com>
>  L:	netdev@vger.kernel.org
>  L:	bpf@vger.kernel.org
>  S:	Maintained
> -F:	kernel/bpf/xskmap.c
>  F:	net/xdp/
> +F:	include/net/xdp_sock*
> +F:	include/net/xsk_buffer_pool.h
> +F:	include/uapi/linux/if_xdp.h
> +F:	tools/lib/bpf/xsk*
> +F:	samples/bpf/xdpsock*

Alphabetic order in file patterns please

+F:	samples/bpf/xdpsock*
+F:	tools/lib/bpf/xsk*



