Return-Path: <SRS0=vDm1=DQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF25EC433E7
	for <bpf@archiver.kernel.org>; Fri,  9 Oct 2020 18:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78867222C3
	for <bpf@archiver.kernel.org>; Fri,  9 Oct 2020 18:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602267894;
	bh=3gzFofUqvvuEvMRqSqivHVmFqIoTnziY9ubwe/C3228=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=13Hx6GwtU+7pzvusR6tFXdaWcf8pQ89YzBUYxgg+d4ER1DEVMfoxOSPKPbSaGkRnd
	 AVVc5uhNjqb1YLnxTW+z3qrxb6Hz8xwkXHIaP3KARzYGSfshmiX58ntCBG6lQeU0SI
	 YVx+VExAbskuWipTpeD0MFzTHy5x1anD177Kd2W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390393AbgJISYy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390392AbgJISYy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 14:24:54 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DF3D22284;
        Fri,  9 Oct 2020 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602267893;
        bh=3gzFofUqvvuEvMRqSqivHVmFqIoTnziY9ubwe/C3228=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bVC8c59n0iudoHofaZB/OcH4nM7ZKfF0JpaDCNZfARx1qHcqRW564v2G3fcWlG3hI
         gy8JsIEJ5LqdLB35CRhgYk2GlBdEswQShLKjo/EL+9M8DJf2ptQVfjl/3uVZFUj6uA
         dqBGxvJg1RBDzG9jww9YEiFDnxa6f9uJqry/3BHE=
Date:   Fri, 9 Oct 2020 11:24:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@kernel.org, john.fastabend@gmail.com, yhs@fb.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: improve bpf_redirect_neigh helper
 description
Message-ID: <20201009112451.3ce7a6b7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <8fcc44a98c7600492c5f1fc1e79fccdcf3bfe4d2.1602252399.git.daniel@iogearbox.net>
References: <cover.1602252399.git.daniel@iogearbox.net>
        <8fcc44a98c7600492c5f1fc1e79fccdcf3bfe4d2.1602252399.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri,  9 Oct 2020 16:10:10 +0200 Daniel Borkmann wrote:
> + * 		get the	address of the next hop and then relies on the neighbor

FWIW if you have to respin there is a tab in the middle of this line

> + * 		get the	address of the next hop and then relies on the neighbor

Also copied here.
