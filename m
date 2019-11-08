Return-Path: <SRS0=EAyC=ZA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8048FC6196
	for <bpf@archiver.kernel.org>; Fri,  8 Nov 2019 21:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B571D20650
	for <bpf@archiver.kernel.org>; Fri,  8 Nov 2019 21:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbfKHVjZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:39:25 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387560AbfKHVjZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 16:39:25 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 80336153B268A;
        Fri,  8 Nov 2019 13:39:24 -0800 (PST)
Date:   Fri, 08 Nov 2019 13:39:24 -0800 (PST)
Message-Id: <20191108.133924.1397692397131607421.davem@davemloft.net>
To:     peterz@infradead.org
Cc:     alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        x86@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 02/18] bpf: Add bpf_arch_text_poke() helper
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191108213624.GM3079@worktop.programming.kicks-ass.net>
References: <59d3af80-a781-9765-4d01-4c8006cd574f@fb.com>
        <CAADnVQKmrVGVHM70OT0jc7reRp1LdWTM8dhE1Gde21oxw++jwg@mail.gmail.com>
        <20191108213624.GM3079@worktop.programming.kicks-ass.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Nov 2019 13:39:24 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Fri, 8 Nov 2019 22:36:24 +0100

> The cover leter is not preserved and should therefore
 ...

The cover letter is +ALWAYS+ preserved, we put them in the merge
commit.
