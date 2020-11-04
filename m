Return-Path: <SRS0=nPxa=EK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD0AC2D0A3
	for <bpf@archiver.kernel.org>; Wed,  4 Nov 2020 13:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F722080D
	for <bpf@archiver.kernel.org>; Wed,  4 Nov 2020 13:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgKDNgS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:36:18 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:34864 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbgKDNgS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 08:36:18 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kaIxP-005DAy-09; Wed, 04 Nov 2020 14:36:11 +0100
Date:   Wed, 4 Nov 2020 14:36:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Song Liu <songliubraving@fb.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        xen-devel@lists.xenproject.org, KP Singh <kpsingh@chromium.org>,
        Yonghong Song <yhs@fb.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin KaFai Lau <kafai@fb.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 08/12] net: xen-netfront: Demote non-kernel-doc headers
 to standard comment blocks
Message-ID: <20201104133610.GB933237@lunn.ch>
References: <20201104090610.1446616-1-lee.jones@linaro.org>
 <20201104090610.1446616-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201104090610.1446616-9-lee.jones@linaro.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 04, 2020 at 09:06:06AM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/xen-netfront.c: In function ‘store_rxbuf’:
>  drivers/net/xen-netfront.c:2416:16: warning: variable ‘target’ set but not used [-Wunused-but-set-variable]
>  drivers/net/xen-netfront.c:1592: warning: Function parameter or member 'dev' not described in 'netfront_probe'
>  drivers/net/xen-netfront.c:1592: warning: Function parameter or member 'id' not described in 'netfront_probe'
>  drivers/net/xen-netfront.c:1669: warning: Function parameter or member 'dev' not described in 'netfront_resume'
>  drivers/net/xen-netfront.c:2313: warning: Function parameter or member 'dev' not described in 'netback_changed'
>  drivers/net/xen-netfront.c:2313: warning: Function parameter or member 'backend_state' not described in 'netback_changed'
> 

commit 8ed7ec1386b646130d80d017ecd4716f866ea570
Author: Andrew Lunn <andrew@lunn.ch>
Date:   Sat Oct 31 19:04:35 2020 +0100

    drivers: net: xen-netfront: Fixed W=1 set but unused warnings

Already in net-next.

	Andrew
