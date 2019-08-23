Return-Path: <SRS0=I0lg=WT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6E3C3A5A2
	for <bpf@archiver.kernel.org>; Fri, 23 Aug 2019 23:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0B820850
	for <bpf@archiver.kernel.org>; Fri, 23 Aug 2019 23:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfHWXff (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:35:35 -0400
Received: from www62.your-server.de ([213.133.104.62]:52606 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfHWXff (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Aug 2019 19:35:35 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i1J5b-0001oM-Bv; Sat, 24 Aug 2019 01:35:27 +0200
Received: from [178.197.249.40] (helo=pc-63.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i1J5b-000PRZ-59; Sat, 24 Aug 2019 01:35:27 +0200
Subject: Re: [PATCH bpf] bpf: fix precision tracking in presence of bpf2bpf
 calls
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
References: <20190821210710.1276117-1-ast@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0a921eb3-a3f7-8b23-cf61-87a4761cfc00@iogearbox.net>
Date:   Sat, 24 Aug 2019 01:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190821210710.1276117-1-ast@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25550/Fri Aug 23 10:25:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/21/19 11:07 PM, Alexei Starovoitov wrote:
> While adding extra tests for precision tracking and extra infra
> to adjust verifier heuristics the existing test
> "calls: cross frame pruning - liveness propagation" started to fail.
> The root cause is the same as described in verifer.c comment:
> 
>   * Also if parent's curframe > frame where backtracking started,
>   * the verifier need to mark registers in both frames, otherwise callees
>   * may incorrectly prune callers. This is similar to
>   * commit 7640ead93924 ("bpf: verifier: make sure callees don't prune with caller differences")
>   * For now backtracking falls back into conservative marking.
> 
> Turned out though that returning -ENOTSUPP from backtrack_insn() and
> doing mark_all_scalars_precise() in the current parentage chain is not enough.
> Depending on how is_state_visited() heuristic is creating parentage chain
> it's possible that callee will incorrectly prune caller.
> Fix the issue by setting precise=true earlier and more aggressively.
> Before this fix the precision tracking _within_ functions that don't do
> bpf2bpf calls would still work. Whereas now precision tracking is completely
> disabled when bpf2bpf calls are present anywhere in the program.
> 
> No difference in cilium tests (they don't have bpf2bpf calls).
> No difference in test_progs though some of them have bpf2bpf calls,
> but precision tracking wasn't effective there.
> 
> Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Applied, thanks!
