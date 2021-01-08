Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD2EC433DB
	for <bpf@archiver.kernel.org>; Fri,  8 Jan 2021 00:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC23236FB
	for <bpf@archiver.kernel.org>; Fri,  8 Jan 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbhAHACv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Jan 2021 19:02:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbhAHACv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jan 2021 19:02:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9068D236F9;
        Fri,  8 Jan 2021 00:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610064130;
        bh=KJKLC3uYGOgY+19eJnV6s3kdmpf2QB56vwoB5+YZFBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U0LbJqCxiaoTm6BodQPsdlBxnxOLFK8rE+XLafOgnp6BGxzXT2uuyKTR6+1rE8Pde
         JQPwrmmk+DW0BMxN5RLm5EC6CbrDUSzkyI7fY8qpW330txt7zpiTCkJEJ7g4ScX+61
         Ku0p2XCqy8Eq7AZSTjkTewOb4rbMt5Qq6AUgpjuCMuj3/Dh0yzCRfcoc2nF06e4fGi
         6tvVATnEH4QwJq2zMrQBWKIllAUhBE8PuH8OoxcG2Ur8e0y/Ly7HRhnYqF/pr+7sfl
         /x2VCn28ivtcRC6I5inKAa/1Yq3FRjLizILV6ILl8s48NPzHk/2kuyPj2H4uC9QwQa
         DBdBhIXcul2wg==
Date:   Thu, 7 Jan 2021 16:02:09 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: pull-request: bpf 2021-01-07
Message-ID: <20210107160209.6b708829@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210107221555.64959-1-alexei.starovoitov@gmail.com>
References: <20210107221555.64959-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu,  7 Jan 2021 14:15:55 -0800 Alexei Starovoitov wrote:
> Hi David, hi Jakub,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> We've added 4 non-merge commits during the last 10 day(s) which contain
> a total of 4 files changed, 14 insertions(+), 7 deletions(-).
> 
> The main changes are:
> 
> 1) Fix task_iter bug caused by the merge conflict resolution, from Yonghong.
> 
> 2) Fix resolve_btfids for multiple type hierarchies, from Jiri.

Pulled, thanks!
