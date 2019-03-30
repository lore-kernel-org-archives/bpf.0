Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8AAC43381
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7580920663
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="B+iKm9bt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfC3DSd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Mar 2019 23:18:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42606 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfC3DSd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Mar 2019 23:18:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so4698215qtc.9
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 20:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=4J+luJ8Wz1tFpwF6+f0t7UohI5CAVrSU5OI6axZomGs=;
        b=B+iKm9btNXrK1hmQsCSuJ63KAturtnq5Krgi5GvNekJeCFzof2/LuNxfgAIZYYNy/s
         m3zwU+J/6Es9HpG7Hi7JCVYA37a7YyKlT1DuIKcFV/Q+dJpFvayJm81620xJrW4yh1Xe
         ye3zil8DfHFY/y91ldbGIeDYEXVPUPU4x8wpwFaohDHPhBaXIfxcwCdPzLo+xkkrpWHB
         umuq1KdEzkY7nUs9Cz6vwzVlGdnNPclNA+7iFybI/w89VWx5iHrluUyUKMyTFCVBIDXw
         6/GF31IvaBK4bghbV9YoupVtFCsE16GMzkToc7DZibES5uv5sgRoQ2ExLRIV9mmT3jPU
         oHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=4J+luJ8Wz1tFpwF6+f0t7UohI5CAVrSU5OI6axZomGs=;
        b=LcuFj180llFDzLI0FM3aOCgtTxBqgBWtuChU1MIrxGQCyrr736uaCD7/hd4FXyJYFs
         ZXeZcy5yrg/3u4f9LCbtWguBWKBCnqjsxDzXG3lLuRsE5rQq5L9jGQk/97C6ibot3qMx
         uiy7eciusdaPVT3Yhp8wHKgt0lH9IEHgwcnPh6LT9VniZ4MXLfM/8esvNCFRBSVM83Oo
         Y0gT4GrWbHWPMhwcslrNV+NDDxUjgKPw79s8TJTuzu9UgWokxoedVjCFsBi8hjsYtZEI
         3SwCPa7uar3UH4udCdeaMsQ3R1gUB5vI6/C9Bp3f7enQreNl2/XT6JvaaoEYgXnJKcqJ
         CviQ==
X-Gm-Message-State: APjAAAV8+fg4PWGCCsRbkhE29Ntr1g8yi/0qm0lBpoM+AQs3uSHV7lFG
        zqMIa0hB1FEfNDiE7KKNVMJZMg==
X-Google-Smtp-Source: APXvYqxgfJp5/iii3eFmL4rTwfgyRjG19uEGgaSBWadBnX1i6UHpz1J+mOZmaxxj9RgN7sZFwd2jGw==
X-Received: by 2002:ac8:13c5:: with SMTP id i5mr31176807qtj.42.1553915912769;
        Fri, 29 Mar 2019 20:18:32 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id t69sm1999567qke.38.2019.03.29.20.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 20:18:32 -0700 (PDT)
Date:   Fri, 29 Mar 2019 20:18:28 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     <davem@davemloft.net>, <daniel@iogearbox.net>, <jannh@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/7] bpf: improve verifier scalability
Message-ID: <20190329201828.00c5c662@cakuba.netronome.com>
In-Reply-To: <20190330001612.2354959-1-ast@kernel.org>
References: <20190330001612.2354959-1-ast@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 29 Mar 2019 17:16:05 -0700, Alexei Starovoitov wrote:
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
> 
> Worst case it takes 1/10 of a second to process that many instructions
> and peak memory consumption is peak_states * sizeof(struct bpf_verifier_state)
> which is around ~5Mbyte.
> 
> Increase insn_per_program limit for root to insn_processed limit.
> 
> Add verification stats and stress tests for verifier scalability.
> 
> This patch set is the first step to be able to accept large programs.
> The verifier still suffers from its brute force algorithm and
> large programs can easily hit 1M insn_processed limit.
> A lot more work is necessary to be able to verify large programs.

Very nice!

Hopefully this doesn't discourage people from working on loops ;)
