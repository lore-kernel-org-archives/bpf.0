Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED177C4360F
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 00:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C351F2133D
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 00:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDDABr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:01:47 -0400
Received: from www62.your-server.de ([213.133.104.62]:33100 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDDABr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 20:01:47 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBpp7-0001ey-En; Thu, 04 Apr 2019 02:01:41 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBpp7-000GYQ-7h; Thu, 04 Apr 2019 02:01:41 +0200
Subject: Re: [PATCH v2 bpf-next 00/10] bpf: improve verifier scalability
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     jakub.kicinski@netronome.com, jannh@google.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
References: <20190402042749.3670015-1-ast@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e8f05c05-dcb8-ac33-ea9b-939ac924b221@iogearbox.net>
Date:   Thu, 4 Apr 2019 02:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190402042749.3670015-1-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25408/Wed Apr  3 09:53:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/02/2019 06:27 AM, Alexei Starovoitov wrote:
> v1->v2:
> - fixed typo in patch 1
> - added a patch to convert kcalloc to kvcalloc
> - added a patch to verbose 16-bit jump offset check
> - added a test with 1m insns
> 
> This patch set is the first step to be able to accept large programs.
> The verifier still suffers from its brute force algorithm and
> large programs can easily hit 1M insn_processed limit.
> A lot more work is necessary to be able to verify large programs.
> 
> v1:
> Realize two key ideas to speed up verification speed by ~20 times
> 1. every 'branching' instructions records all verifier states.
>    not all of them are useful for search pruning.
>    add a simple heuristic to keep states that were successful in search pruning
>    and remove those that were not
> 2. mark_reg_read walks parentage chain of registers to mark parents as LIVE_READ.
>    Once the register is marked there is no need to remark it again in the future.
>    Hence stop walking the chain once first LIVE_READ is seen.
> 
> 1st optimization gives 10x speed up on large programs
> and 2nd optimization reduces the cost of mark_reg_read from ~40% of cpu to <1%.
> Combined the deliver ~20x speedup on large programs.
> 
> Faster and bounded verification time allows to increase insn_processed
> limit to 1 million from 130k.
> Worst case it takes 1/10 of a second to process that many instructions
> and peak memory consumption is peak_states * sizeof(struct bpf_verifier_state)
> which is around ~5Mbyte.
> 
> Increase insn_per_program limit for root to insn_processed limit.
> 
> Add verification stats and stress tests for verifier scalability.

Applied, thanks! As discussed offline a bit with Alexei wrt to prior
thread on uapi, this will be documented in design FAQ.

> Alexei Starovoitov (10):
>   bpf: add verifier stats and log_level bit 2
>   bpf: improve verification speed by droping states
>   bpf: improve verification speed by not remarking live_read
>   bpf: convert temp arrays to kvcalloc
>   bpf: verbose jump offset overflow check
>   bpf: increase complexity limit and maximum program size
>   bpf: increase verifier log limit
>   libbpf: teach libbpf about log_level bit 2
>   selftests/bpf: add few verifier scale tests
>   selftests/bpf: synthetic tests to push verifier limits
> 
>  include/linux/bpf.h                           |   1 +
>  include/linux/bpf_verifier.h                  |  23 +++
>  kernel/bpf/core.c                             |  11 +-
>  kernel/bpf/syscall.c                          |   3 +-
>  kernel/bpf/verifier.c                         | 153 +++++++++++++-----
>  tools/lib/bpf/bpf.c                           |   2 +-
>  tools/lib/bpf/bpf.h                           |   2 +-
>  tools/lib/bpf/libbpf.c                        |  16 +-
>  tools/lib/bpf/libbpf.h                        |   1 +
>  .../bpf/prog_tests/bpf_verif_scale.c          |  49 ++++++
>  .../testing/selftests/bpf/progs/test_jhash.h  |  70 ++++++++
>  .../selftests/bpf/progs/test_verif_scale1.c   |  30 ++++
>  .../selftests/bpf/progs/test_verif_scale2.c   |  30 ++++
>  .../selftests/bpf/progs/test_verif_scale3.c   |  30 ++++
>  tools/testing/selftests/bpf/test_progs.c      |   6 +-
>  tools/testing/selftests/bpf/test_progs.h      |   1 +
>  tools/testing/selftests/bpf/test_verifier.c   |  35 ++--
>  tools/testing/selftests/bpf/verifier/ld_dw.c  |   9 ++
>  18 files changed, 415 insertions(+), 57 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_jhash.h
>  create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale1.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale2.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_verif_scale3.c
> 

