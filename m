Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C28C2D0A3
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 18:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 322732078B
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 18:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604688963;
	bh=9Z//xbLRx7LhHssr++ORT9ZMJG5YapfMsn1CIp+w9p0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AShvpUC+WWxcA03FzVr+pudQMJi3mJB7FRgjLce9a2i0QUbnJpShbRT3BYlxq9Otn
	 ecJfU7n8QnnBe6W/3Xz6/J21KuPdOLXgr4y5QzjDO57T/PfpssNAp6aRbWmGrIkG9/
	 rlDkooFtkIC5A86KBZgYLD2CS/ckYQJnbeN3XL2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgKFS4C (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKFS4C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 13:56:02 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 486C6206E3;
        Fri,  6 Nov 2020 18:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604688961;
        bh=9Z//xbLRx7LhHssr++ORT9ZMJG5YapfMsn1CIp+w9p0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GlnX4wZ9Uofp6FrP4idiYapMnTBEou8mQ0t1s/CuoppCQdGLBv2f1mpkAWkIRjC0r
         9Ln+GRViccTul5ithO2ayQcJb7kkdxuDoGTBXwQDD9c/0r9gB8ApfNK7z3pzFC/Qir
         BUWinfsdgaVO8FAkDcPlak3V6GX2z8XFWNskznyQ=
Date:   Fri, 6 Nov 2020 10:56:00 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     netdev@vger.kernel.org, William Tu <u9012063@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCHv2 net 0/2] Remove unused test_ipip.sh test and add
 missed ip6ip6 test
Message-ID: <20201106105554.02a3142b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201106090117.3755588-1-liuhangbin@gmail.com>
References: <20201103042908.2825734-1-liuhangbin@gmail.com>
        <20201106090117.3755588-1-liuhangbin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri,  6 Nov 2020 17:01:15 +0800 Hangbin Liu wrote:
> In comment 173ca26e9b51 ("samples/bpf: add comprehensive ipip, ipip6,
> ip6ip6 test") we added some bpf tunnel tests. In commit 933a741e3b82
> ("selftests/bpf: bpf tunnel test.") when we moved it to the current
> folder, we missed some points:
> 
> 1. ip6ip6 test is not added
> 2. forgot to remove test_ipip.sh in sample folder
> 3. TCP test code is not removed in test_tunnel_kern.c
> 
> In this patch set I add back ip6ip6 test and remove unused code. I'm not sure
> if this should be net or net-next, so just set to net.

I'm assuming you meant to tag this with the bpf tree.
