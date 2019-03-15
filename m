Return-Path: <SRS0=GcXc=RS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250AAC43381
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC96D218D0
	for <bpf@archiver.kernel.org>; Fri, 15 Mar 2019 19:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="aCiSkt17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCOTlj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:41:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46529 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfCOTlj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 15:41:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id 33so10794264wrb.13
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2019 12:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z51KSwFmBZCbKDsQmFoz7GVvJw5qqbp9mVVgTqjqYlA=;
        b=aCiSkt17tzMhisF2YrhhJN6CpXsBKMGiF13KGjbcelVJE1ZTfDxoUvxWksOz/BU7TI
         v3XKdqpdntEP3tncq1K9d9QG/c4SUL4+3jk5OAf1osI7kYW2dgjkKNaX+MrhlTJ7qiBv
         haxeuO+QpDxrSjOvGQgumS5mNgj2QtA7TGmmsrt9Z/sEJqpuxcyPtW0Ma89xLlY3ynAI
         JA4CjoxOxyYUladXRxexIkYObNy61dWH3GGGmnxT7BVc9Le/+DM4AWV82g+9lngAGD/2
         s13bcwbcNGJfzAT+j1lpGRNUiPi9yCye+hHKdyqWzd6Ke6IynKhXFErHr0sDIQz6Eb4y
         jg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z51KSwFmBZCbKDsQmFoz7GVvJw5qqbp9mVVgTqjqYlA=;
        b=AAlGswNXhs6Jo047q1N+dFuvE0UXfZ9zLKup8WpHAc9+ehcidTtHrieLz/DzAXVeWK
         hwzSF4UXxYG/l1Z7SSxlEfG4wJJ75oGCu/Mh8ALqrBy4GtaCj3/SwlyuaNVRzMh59FeA
         xTBNHu5gn+U0c/wGw9ni69ZHzPe+bkq9A7Qq3rFF0E/TER/nl8J91Lq83+EIMlD+mP7+
         EUdQtDgmEpizKCT3m+qPjvdKdV/OF/YRLrPAmTaIB29tN9aIAdevHBgXJKRCOO7f0V9X
         u9HZZTso17ezJVzLmNAVQDbH8ZQrluGVO6SBaAbxsvKWMY5Oxu7wDLW8ssEJBL5aCQBl
         92og==
X-Gm-Message-State: APjAAAV7t5a3SDt3thvcwQz1CGkZfkaYH1upUOR8yORaqwDsiVykwFXu
        jyNy8sNtYmFsuK8WBHnRDzaxgg==
X-Google-Smtp-Source: APXvYqw6BOOzuB7BdL8/aoJWjO7mz22dQaOnSqpIbnkR+v7LyCdmSNTsdk8guPHkXK5QCUdBNIksxQ==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr3700383wrs.70.1552678897486;
        Fri, 15 Mar 2019 12:41:37 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.187.113])
        by smtp.gmail.com with ESMTPSA id c5sm2206474wrn.53.2019.03.15.12.41.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 12:41:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] bpftool: Allow referring to maps by its name
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stanislav Fomichev <sdf@google.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190315183211.GB24482@kernel.org>
 <20190315121632.246824dc@cakuba.netronome.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <9f6fefe5-0b9f-6257-4e84-19759dd72ab4@netronome.com>
Date:   Fri, 15 Mar 2019 19:41:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190315121632.246824dc@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-03-15 12:16 UTC-0700 ~ Jakub Kicinski <jakub.kicinski@netronome.com>
> On Fri, 15 Mar 2019 15:41:41 -0300, Arnaldo Carvalho de Melo wrote:
>> While developing 'perf trace' and looking at BPF maps it puts in place I
>> noticed that one needs to first use 'bpftool map' to lookup a map id to
>> then use 'bpftool map dump map id <map-id-looked-up>'.
>>
>> This is needed because everytime we restart 'perf trace' the map IDs
>> gets changed so we need to do the ID lookup again.
>>
>> To speed up this sequence, allow specifying just the map name, look up
>> its ID and then use the existing routines as if the user had provided
>> the map id.
> 
> I can see how it could be useful for quick debug.  Names are not
> guaranteed to be unique, though, do you not care about potential
> duplicates?
> 

Jakub beat me to it by a few seconds :). I discussed possible 
workarounds on that point with him though, so here are my two cents. I 
see two options: first one would be to return the ids of, and then dump 
info about all maps having that name. The second one would be to simply 
return an error if duplicate names are found.

We agreed that returning an error if there are duplicates is probably 
the best way to go, because dealing with several maps for anything else 
than "bpftool map show" would be problematic (clearly, we don't want to 
update all maps with a given name at once). Of course if you have other 
suggestions, feel free to propose :).

Best,
Quentin
