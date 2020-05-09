Return-Path: <SRS0=3byo=6X=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6054C47247
	for <bpf@archiver.kernel.org>; Sat,  9 May 2020 02:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BEC218AC
	for <bpf@archiver.kernel.org>; Sat,  9 May 2020 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588990265;
	bh=7WATmBkFHhqVG5vcqGbREpgQfsEQnlS8vAP20J17ipM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=trldNcR0+vbgPELlLQy5+JQdEHh0KCBqyHlGbdirQOOgkRh5a3u4dJz60urRbT/yV
	 jqqKYiwqS8VyaZJhcXU6k/koEnuo9JKYVwSwfZFQLSDyam2f7GjVKA6DbGJu0xxiJg
	 iaTGDwEek9ohfmq290q4+XY3lq2cpod6EzRJxaXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgEICLB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 May 2020 22:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbgEICLB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 May 2020 22:11:01 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89597218AC;
        Sat,  9 May 2020 02:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588990260;
        bh=7WATmBkFHhqVG5vcqGbREpgQfsEQnlS8vAP20J17ipM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kjkKP+XSBvc3mr2oqj4XZUg2Yo9omuIKs/OVxXygH3nvEgoqKyPfRwqIBnq//m508
         NCRQYSSX9FESN/myPWSeDf76ABB33Ms0P1mYgYpoqgwRvtLDn9rSbN2E8YJmolBRle
         VqBFqU8WzeIid3weJEad+VOfErOOiqCcSxANGkHE=
Date:   Fri, 8 May 2020 19:10:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vincent Minet <v.minet@criteo.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] umh: fix memory leak on execve failure
Message-ID: <20200508191058.24158f7a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200507221422.19338-1-v.minet@criteo.com>
References: <20200507221422.19338-1-v.minet@criteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri,  8 May 2020 00:14:22 +0200 Vincent Minet wrote:
> If a UMH process created by fork_usermode_blob() fails to execute,
> a pair of struct file allocated by umh_pipe_setup() will leak.
> 
> Under normal conditions, the caller (like bpfilter) needs to manage the
> lifetime of the UMH and its two pipes. But when fork_usermode_blob()
> fails, the caller doesn't really have a way to know what needs to be
> done. It seems better to do the cleanup ourselves in this case.
> 
> Fixes: 449325b52b7a ("umh: introduce fork_usermode_blob() helper")
> Signed-off-by: Vincent Minet <v.minet@criteo.com>

Applied to net, thank you!
