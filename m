Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DF7C64E90
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 00:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A678221E2
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 00:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgLBARP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 1 Dec 2020 19:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgLBARP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 19:17:15 -0500
Date:   Tue, 1 Dec 2020 16:16:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606868194;
        bh=gkmiWmVFzdO+ZVqjt/HjIfPByAtBi4a7TCJMSYve0RE=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=jn4ZicpTRqvvd/3B7BCUQU29hZZhEXLCbjVyCOIGz/QYEQow/jJMKiRkgFN8ui0MD
         3gvcm534UFKLuyIVKdQ4K37aYYRS4raZuF56qZZeTN7zAe/490IZESiEqZeaN67C5E
         pmhkOwdsXWVKqKWEan4ind0g0SvZjhiatZlrQXoQ=
From:   Jakub Kicinski <kuba@kernel.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, Dongdong Wang <wangdongdong@bytedance.com>,
        Thomas Graf <tgraf@suug.ch>, bpf@vger.kernel.org,
        Cong Wang <cong.wang@bytedance.com>
Subject: Re: [Patch net] lwt: disable BH too in run_lwt_bpf()
Message-ID: <20201201161633.2a3cc879@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201201194438.37402-1-xiyou.wangcong@gmail.com>
References: <20201201194438.37402-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue,  1 Dec 2020 11:44:38 -0800 Cong Wang wrote:
> From: Dongdong Wang <wangdongdong@bytedance.com>
> 
> The per-cpu bpf_redirect_info is shared among all skb_do_redirect()
> and BPF redirect helpers. Callers on RX path are all in BH context,
> disabling preemption is not sufficient to prevent BH interruption.
> 
> In production, we observed strange packet drops because of the race
> condition between LWT xmit and TC ingress, and we verified this issue
> is fixed after we disable BH.
> 
> Although this bug was technically introduced from the beginning, that
> is commit 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure"),
> at that time call_rcu() had to be call_rcu_bh() to match the RCU context.
> So this patch may not work well before RCU flavor consolidation has been
> completed around v5.0.
> 
> Update the comments above the code too, as call_rcu() is now BH friendly.
> 
> Cc: Thomas Graf <tgraf@suug.ch>
> Cc: bpf@vger.kernel.org
> Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Dongdong Wang <wangdongdong@bytedance.com>

Fixes?
