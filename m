Return-Path: <SRS0=w44S=Q3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9699C43381
	for <bpf@archiver.kernel.org>; Wed, 20 Feb 2019 20:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4152146E
	for <bpf@archiver.kernel.org>; Wed, 20 Feb 2019 20:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU8+uJS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfBTU0q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:26:46 -0500
Received: from mail-it1-f177.google.com ([209.85.166.177]:52631 "EHLO
        mail-it1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfBTU0q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Feb 2019 15:26:46 -0500
Received: by mail-it1-f177.google.com with SMTP id r11so18564081itc.2
        for <bpf@vger.kernel.org>; Wed, 20 Feb 2019 12:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KZdJTUaYEgFE6htU9qnBTZ/DGkT429vsJXjB7NxXa0E=;
        b=nU8+uJS19JUSBIS1kGWXMvEFTW8tPnwReThXORXo7ri2JAfF6/sdOhE512ew23jD0L
         tD+WppAgyZlCn8oAoOBiquDi5+RVgPuxA36fC5ql7/X5IjexPbvFgoR6OF+21ZnUPUuq
         d4gKpykaDsV9xVh0S5u/d5CLjFWGZR7ENVncZ6wH/veh98mU5xxcq/F6Ne9Yek1d9F2M
         mhMsUWShowrQY0l6TnJZ+2yTI61TmsQFnZilUn+cCjFzHsCcybelH+l1g630gIoqjUFl
         aJSog4ITBN+GvhNETx+fPVxvojDQHCS1vkJwyAAV3QHFFtGcyx6Q33amCnh1prDN0TPo
         B4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KZdJTUaYEgFE6htU9qnBTZ/DGkT429vsJXjB7NxXa0E=;
        b=WLLUpAO9U/gRX6fAQYxySsWoWa9nGvbAhIW1M2jlhKVvVyowq1Akxc3+h+xUnNa7au
         rwLOo5ErrpeYngR/j4qyGIeL6TyjKsa3FYMv+e+W2eGQ4y30RJaSqd3NIYsuDuqSwJoC
         fYde/SjjDDVOnVBzRuy55wNooPQ/cJbZ59UcNGDniwaWYdhgFN5FF74PZARLZPCjW3op
         PzMXQ/i6EZ5Vq2MLyaFXfaO7sXPYTsyJ2YSW3UcClXYxXvzXUq6Z0Dzu1YxPUMBkFdl2
         T7xpyTLZRk9y7F3gkeybdrcKtixhuIt2gKIbDP0TUScuqNTkal27T8hhapG8YfiMfF02
         6npw==
X-Gm-Message-State: AHQUAuanyQG7XfQsQtSj8GicpmmCxnVe4QPARlRdalVKo8RwiEYxaR00
        VxE/OHfCRLlwB/I4tUF07x0WnK8x
X-Google-Smtp-Source: AHgI3IbUlhoRsKKjjBLzfUwnwG4PgstkCbAMbCmYDG022qNo7IMSYxpfbhBRZXylSrFZNbwM3k9Zfg==
X-Received: by 2002:a5d:9709:: with SMTP id h9mr19064450iol.184.1550694405169;
        Wed, 20 Feb 2019 12:26:45 -0800 (PST)
Received: from [192.168.86.250] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id u197sm3125582itb.9.2019.02.20.12.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 12:26:44 -0800 (PST)
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
From:   John Fastabend <john.fastabend@gmail.com>
Subject: LSFMM BPF Proposal: BPF Support for Bounded Loops Revisited
Message-ID: <6a3d5b6e-d638-7c7e-bf91-25777e08f901@gmail.com>
Date:   Wed, 20 Feb 2019 12:26:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, below is a proposal for the LSFMM BPF Track. Thanks.
---

BPF Support for Bounded Loops Revisited:

BPFs lack of support for bounded loops has proven to make it difficult
to implement logic that would be common in other environments. Macros
have been invented to unroll complex loops, creative uses of maps and
tail calls have appeared, but these solutions albeit "interesting" fail
to solve the core problem.

An initial prototype to handle bounded loops proceeded in the normal
compiler textbook method. This means building a CFG, constructing the
DOM tree, checking (ir)reducibility, finding invariants, and walking
all the paths through the loop (Floyd-Hoare) to verify termination.
This had some draw backs. First its a fair amount of complex code
that impacts all users of the verifier regardless if loops are being
used or not. But worse its almost unusable because LLVM generates
complex loop structures that are difficult to pattern match (find
invariants for) without even more code.

I have decided there is no clean/easy way to do this without bringing
the compiler onboard. We are building a prototype v2 that solves this
roughly as follows,

   1. Provide interface between compiler and verifier to "hint" at
      loop structures. We propose these can be pushed through BTF.

   2. Compiler "hint" gives loop start and end to verifier. Verifier can
      ensure that these "loops" are contiguous blocks of code that
      does not have JMPs into it from other blocks.

   3. Compiler has to build compliant loops. We plan to start simple
      only allowing the compiler to build increasing/decreasing loops
      that fit some pre-agreed template. For example, we "know" where
      the invariants will be and how they will be compared at the end
      (and only at the end) of the loop block. If this is violated we
      will simply abort and complain to the compiler. As part of the
      hints we can tell the verifier the type of loop to expect.

   4. Add as many loop types as needed teaching the verifier the
      loop types as we go.

The advantages are (a) if we never see a loop hint we never have
to run the loop verification code, small/negligible perf hit for
non-loop users, (b) easy to find loops no need for DOMs or reducibility
checks, (c) always know where to find invariants and (d) hints can
be added incrementally allowing compiler and verifier to create more
complex structures in the future. The downside is we will be restricting
the compilers ability to optimize loops. I anticipate this will be a
small price to pay and worth it but lets run some tests on prototypes.

We would like to discuss the above design, compare it with our initial
design and share the latest prototype and measurements at the LSFMM BPF
track.

Thanks,
John
