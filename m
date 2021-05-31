Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B54DC4708F
	for <bpf@archiver.kernel.org>; Mon, 31 May 2021 09:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AD66101C
	for <bpf@archiver.kernel.org>; Mon, 31 May 2021 09:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhEaJgF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 31 May 2021 05:36:05 -0400
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:52105 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230423AbhEaJgE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 31 May 2021 05:36:04 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id 7A6B3FADAA
        for <bpf@vger.kernel.org>; Mon, 31 May 2021 10:34:24 +0100 (IST)
Received: (qmail 12408 invoked from network); 31 May 2021 09:34:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 May 2021 09:34:24 -0000
Date:   Mon, 31 May 2021 10:34:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     akpm@linux-foundation.org, bpf@vger.kernel.org, msuchanek@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hritikxx8@gmail.com, jolsa@kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH] kbuild: skip per-CPU BTF generation for pahole
 v1.18-v1.21
Message-ID: <20210531093422.GS30378@techsingularity.net>
References: <20210530002536.3193829-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210530002536.3193829-1-andrii@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, May 29, 2021 at 05:25:36PM -0700, Andrii Nakryiko wrote:
> Commit "mm/page_alloc: convert per-cpu list protection to local_lock"
> introduced a zero-sized per-CPU variable, which causes pahole to generate
> invalid BTF. Only pahole versions 1.18 through 1.21 are impacted, as before
> 1.18 pahole doesn't know anything about per-CPU variables, and 1.22 contains
> the proper fix for the issue.
> 
> Luckily, pahole 1.18 got --skip_encoding_btf_vars option disabling BTF
> generation for per-CPU variables in anticipation of some unanticipated
> problems. So use this escape hatch to disable per-CPU var BTF info on those
> problematic pahole versions. Users relying on availability of per-CPU var BTFs
> would need to upgrade to pahole 1.22+, but everyone won't notice any
> regressions.
> 
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Hao Luo <haoluo@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
