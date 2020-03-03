Return-Path: <SRS0=fWzt=4U=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B337DC3F2D1
	for <bpf@archiver.kernel.org>; Tue,  3 Mar 2020 20:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8892F20870
	for <bpf@archiver.kernel.org>; Tue,  3 Mar 2020 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583268628;
	bh=7AE8rMM+e9yVjOf3fq4igUYa/KeCJUzDDBRPZ/WBCec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TSao+M0coWu0gjODaG/lSUDndSNeQESV7WNPKRLMyrM7HYrdNCPHVqPQiyUB5IBnu
	 XELjpf/Z3ftEgSJjD9fhklyKCg1tD9ryB5FPecAuL12mawj5fD3yRLMFz2C6zdJbbb
	 6cP39ljP4ezBi+7YDtfNw0rxf0rT8UVFbcqTNhSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbgCCUuY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 3 Mar 2020 15:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731268AbgCCUuY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 15:50:24 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42AD120848;
        Tue,  3 Mar 2020 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583268623;
        bh=7AE8rMM+e9yVjOf3fq4igUYa/KeCJUzDDBRPZ/WBCec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MmneNJNcVy/IcUaO7VxGJMjoNs+Xvjb9W2g+0cY6wC+ui/mhXnyoWyAIhDm4WgQdJ
         xBYZ1RpvZJ79IRiOu8zFIwaiQ+1SmfVQW0Lb4RUQQXhPNWEWIHoDI6VtQwKp/iYmXm
         YsMgiI2s+i+HHJ4gpVQUu6VChr6SShnujSS3bxA8=
Date:   Tue, 3 Mar 2020 12:50:20 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Luigi Rizzo <lrizzo@google.com>,
        Network Development <netdev@vger.kernel.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        David Miller <davem@davemloft.net>, hawk@kernel.org,
        "Jubran, Samih" <sameehj@amazon.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, ast@kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v4] netdev attribute to control xdpgeneric skb
 linearization
Message-ID: <20200303125020.2baef01b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <3c27d9c0-eb17-b20f-2d10-01f3bdf8c0d6@iogearbox.net>
References: <20200228105435.75298-1-lrizzo@google.com>
        <20200228110043.2771fddb@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <CA+FuTSfd80pZroxtqZDsTeEz4FaronC=pdgjeaBBfYqqi5HiyQ@mail.gmail.com>
        <3c27d9c0-eb17-b20f-2d10-01f3bdf8c0d6@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 3 Mar 2020 20:46:55 +0100 Daniel Borkmann wrote:
> Thus, when the data/data_end test fails in generic XDP, the user can
> call e.g. bpf_xdp_pull_data(xdp, 64) to make sure we pull in as much as
> is needed w/o full linearization and once done the data/data_end can be
> repeated to proceed. Native XDP will leave xdp->rxq->skb as NULL, but
> later we could perhaps reuse the same bpf_xdp_pull_data() helper for
> native with skb-less backing. Thoughts?

I'm curious why we consider a xdpgeneric-only addition. Is attaching 
a cls_bpf program noticeably slower than xdpgeneric?
