Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23C6C43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6E1218D0
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="vyvJF8Yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCOTQj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:16:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34582 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfCOTQi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 15:16:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id k2so11397920qtm.1
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Z2PbhkE09g7t6oRKjqIFtX2Y6vk27SOodVmTMG+Mnbw=;
        b=vyvJF8Yvyq56JE2ciWiwZk8IuNFMGLmAePOT4Tu5qierph3prv7keHc9y8ZdpQrI8W
         kpEZuHeENWDIn6uLdBhO2gOdNEPR6Bx7kLEfc/XGXlFlM/4lyWX1DmhVmbU8dGlqMvG9
         mfQf5VxmbzTEoMDSnOUluHkvgQVdrJ8hhEieFDeqgJu8HX2Qn99ARLve0yPiRIBW+Nmh
         vPnpW0vCcufsiDPy9KRzYOfd90C/CZ2+xUmxKdzF8+rJESUa5EgVGclLoLKT0dukzxnR
         HkkATTdoBj414369O3PGp49im50ukPfCyUB3tBxOCACwa9M+jp6kNh8FDkWCpfQ44TH8
         tqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Z2PbhkE09g7t6oRKjqIFtX2Y6vk27SOodVmTMG+Mnbw=;
        b=O8fZay4vEwq+7+kvf1wu7zxPSQEKlKycQM/Rsp3nkMKQL5J91eAjHvWpAznk4pACXu
         i6ti1Ga27uW8Slqpo2WYIz4ZDodq1qhCvE0g5UH25+JONPxcIe2UQjubByAZibDk5cuY
         /5W6wI1s6Jz8rLjMKpsn6ByyIzcMMpLQGK7cDxEgqnd9qf/pU+tRjBIclpOSPrdjKaCY
         GX9lsPubfRPXAqdZV9HJ8H04fijYlhuxzfrhMlvlDWW3abzSkk7bJwpCa3quq3XrcPbu
         HDK4yWzwp+glJxvLoIhEPRQUznPPI+szKXP1ko4vxSbrA6imUjP7HjllL/7iOQ1Psx0h
         pk2g==
X-Gm-Message-State: APjAAAXw2u39YyH5Lj91YjJfQgIMGpmx4py9GsW6TxLVDwgmW1JaAaji
        Vf0rBdR8xg+a0brQsxL9lloPxw==
X-Google-Smtp-Source: APXvYqy63It7NxbflTxRopkBNzs0KbBcrmOnJCWR2oN3xvhkBJuXllS8+e53bMvQOmLtdvrJWLP3Dw==
X-Received: by 2002:ac8:7545:: with SMTP id b5mr4171622qtr.239.1552677397679;
        Fri, 15 Mar 2019 12:16:37 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e9sm1006543qtm.76.2019.03.15.12.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 12:16:37 -0700 (PDT)
Date:   Fri, 15 Mar 2019 12:16:32 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] bpftool: Allow referring to maps by its name
Message-ID: <20190315121632.246824dc@cakuba.netronome.com>
In-Reply-To: <20190315183211.GB24482@kernel.org>
References: <20190315183211.GB24482@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 15 Mar 2019 15:41:41 -0300, Arnaldo Carvalho de Melo wrote:
> While developing 'perf trace' and looking at BPF maps it puts in place I
> noticed that one needs to first use 'bpftool map' to lookup a map id to
> then use 'bpftool map dump map id <map-id-looked-up>'.
> 
> This is needed because everytime we restart 'perf trace' the map IDs
> gets changed so we need to do the ID lookup again.
> 
> To speed up this sequence, allow specifying just the map name, look up
> its ID and then use the existing routines as if the user had provided
> the map id.

I can see how it could be useful for quick debug.  Names are not
guaranteed to be unique, though, do you not care about potential
duplicates?

> This:
> 
>   # bpftool map
>   13: lpm_trie  flags 0x1
>   	key 8B  value 8B  max_entries 1  memlock 4096B
>   14: lpm_trie  flags 0x1
>   	key 20B  value 8B  max_entries 1  memlock 4096B
>   15: lpm_trie  flags 0x1
>   	key 8B  value 8B  max_entries 1  memlock 4096B
>   16: lpm_trie  flags 0x1
>   	key 20B  value 8B  max_entries 1  memlock 4096B
>   17: lpm_trie  flags 0x1
>   	key 8B  value 8B  max_entries 1  memlock 4096B
>   18: lpm_trie  flags 0x1
>   	key 20B  value 8B  max_entries 1  memlock 4096B
>   21: lpm_trie  flags 0x1
>   	key 8B  value 8B  max_entries 1  memlock 4096B
>   22: lpm_trie  flags 0x1
>   	key 20B  value 8B  max_entries 1  memlock 4096B
>   28: perf_event_array  name __augmented_sys  flags 0x0
>   	key 4B  value 4B  max_entries 8  memlock 4096B
>   29: array  name syscalls  flags 0x0
>   	key 4B  value 1B  max_entries 512  memlock 8192B
>   30: hash  name pids_filtered  flags 0x0
>   	key 4B  value 1B  max_entries 64  memlock 8192B
>   #
>    # bpftool map dump id 30
>   [{
>           "key": 26554,
>           "value": true
>       },{
>           "key": 2592,
>           "value": true
>       }
>   ]
>   #
> 
> Now is equivalent to:
> 
>   # bpftool map dump pids_filtered

Please do keep the current model of name val, IOW dump map *name* pids..

>   [{
>           "key": 26554,
>           "value": true
>       },{
>           "key": 2592,
>           "value": true
>       }
>   ]
>   #
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Yonghong Song <yhs@fb.com>
> Link: https://lkml.kernel.org/n/tip-rrnxuhvety3j3rf0r9zlbfro@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Please also update the bash completions and all the help/mans/docs.
