Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10839C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1951217F9
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 14:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJ+olCZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfBZOH4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:07:56 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36528 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfBZOH4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Feb 2019 09:07:56 -0500
Received: by mail-qk1-f196.google.com with SMTP id c2so6898668qkb.3;
        Tue, 26 Feb 2019 06:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r1ANj00QTqryDERB2P/cqGgPu1G/FS/jtfY5mLlto6s=;
        b=UJ+olCZTp1enYNmefm+EDAKuxHsh5qPg1IYUiyK4UdWYtV6EybB/5qrqLudKXUivmS
         um0wueV6YwrxEIrMDx7s6QS7y5o6xX0+E8eltTonw8htZRV22mcggGHFwMKopdxIvjzS
         7Lpl0MNsBHRaOifUbT+JgkXA7OrwWb5Dgp3IhZZzQULqcMUQDWrhVG1CnC/eDdHE6Q/U
         gdW7QeOhe117Z97bc8Q+FASS8fhWRvWLJsHLlC6DP6Ox5I2UbT8ZBujWSDcyIAWu/lQn
         zGL8etaUpLjCnfDYQ5RtQX4cz7yCRpqSo7iES4uKVWemcW8rSnzIqybAoijiIBNZAkvM
         RrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r1ANj00QTqryDERB2P/cqGgPu1G/FS/jtfY5mLlto6s=;
        b=TyanVIJpst5gHnrLKRljik3PGFV3xTtF2rK9x87NSASQDfm6Hcdl1AzWEvo7iMge7+
         7Q6O/5pJF1CnGrgj9rlvEkN6akhPFENglv5A/R4xc6MzJtG3xBzc7cfzTVImHocjBpoB
         aF/rpE1H13E32gdshnolauLOd8e6w5dCdwjxwQixVOd931Ojv2Y4G7ioRYYI0RkA9eob
         eHD2DHyEW9XF1HcKnIM4ZEDTznxsTo+7fiLXjRGWU+KqnW48fpUAVK90f5fkIRGddu71
         tLLpvkxd9NHiM9bLWqzzDTrMn/6wqXUNqHrN4YKYfmcKluuKeFZBySxPrIWweLY9zGPU
         Bo6Q==
X-Gm-Message-State: AHQUAuaYTVhJ8Gp0coPMxLpPZfcqXpxn+xF+iLVChCjKJB2JGZ6DUQnP
        EqVTgb5+ViyljRdn9D4Trny/oAa7
X-Google-Smtp-Source: AHgI3Iaz7U5Wj75RloXcCN3PEAfFDoQ4YxzAyRy3QL5POvjJ9hcX66U1f7bAUOCCutT9YzmB/yFKYA==
X-Received: by 2002:a37:9fd7:: with SMTP id i206mr15944965qke.278.1551190074541;
        Tue, 26 Feb 2019 06:07:54 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 20sm8355098qts.82.2019.02.26.06.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 06:07:52 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 97A5A405CD; Tue, 26 Feb 2019 11:07:37 -0300 (-03)
Date:   Tue, 26 Feb 2019 11:07:37 -0300
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     yhs@fb.com, ast@fb.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, andrii.nakryiko@gmail.com
Subject: Re: [PATCH v2 pahole 2/2] btf_encoder: don't special case packed
 enums
Message-ID: <20190226140737.GB26786@kernel.org>
References: <20190226011927.597075-1-andriin@fb.com>
 <20190226011927.597075-3-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226011927.597075-3-andriin@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 25, 2019 at 05:19:27PM -0800, Andrii Nakryiko escreveu:
> BTF data can represent packed enums correctly without any special
> handling from pahole side. Previously pahole's own `enum vscope` would
> be omitted causing problems.
> 
> Original commit tried to generate correct struct bitfield member type if
> the member is an enum. This was dated before kind_flag implementation.
> Later, kind_flag support was added and now pahole always generates BTF
> with kind_flag = 1 for structures with bitfield, where bitfield size is
> encoded in btf_member, so this workaround is not needed any more.
> Removing this "hack" makes handling it easier to handle packed enums
> correctly.

<SNIP excellent repro before/after text>
 
> Fixes: b18354f64cc2 ("btf: Generate correct struct bitfield member types")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> Acked-by: Yonghong Song <yhs@fb.com>

Thanks a lot, tested it with vmlinux, libc, your repro, all working
jist fine, applied!

Now out to get a vmlinux for a different arch to check that as well.

- Arnaldo
