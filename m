Return-Path: <SRS0=j58T=UT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E67C43613
	for <bpf@archiver.kernel.org>; Thu, 20 Jun 2019 04:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026E5214AF
	for <bpf@archiver.kernel.org>; Thu, 20 Jun 2019 04:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfFTET2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 20 Jun 2019 00:19:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44320 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfFTET2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jun 2019 00:19:28 -0400
Received: from localhost (unknown [50.234.174.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8DC2715252E05;
        Wed, 19 Jun 2019 21:19:27 -0700 (PDT)
Date:   Thu, 20 Jun 2019 00:19:24 -0400 (EDT)
Message-Id: <20190620.001924.2113678155644292714.davem@davemloft.net>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: pull-request: bpf-next 2019-06-19
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190620035726.3942971-1-ast@kernel.org>
References: <20190620035726.3942971-1-ast@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Jun 2019 21:19:28 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>
Date: Wed, 19 Jun 2019 20:57:26 -0700

> The following pull-request contains BPF updates for your *net-next* tree.
> 
> The main changes are:
> 
> 1) new SO_REUSEPORT_DETACH_BPF setsocktopt, from Martin.
> 
> 2) BTF based map definition, from Andrii.
> 
> 3) support bpf_map_lookup_elem for xskmap, from Jonathan.
> 
> 4) bounded loops and scalar precision logic in the verifier, from Alexei.
> 
> Please consider pulling these changes from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

Pulled, thanks.
