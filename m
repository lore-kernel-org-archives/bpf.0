Return-Path: <SRS0=W3SG=S2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09823C282CE
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE93520835
	for <bpf@archiver.kernel.org>; Wed, 24 Apr 2019 19:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="yeq/pi/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbfDXTCw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:02:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52918 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfDXTCw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 15:02:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id j13so6041189wmh.2
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2SrtIqVi6N/CDzfoGks7RKJ0ApZRQBPN1BqiEtG0HUg=;
        b=yeq/pi/YFi+uLs7q5oHGRX8J9qpid5BVnElCOfHDXQu8VsYKqbHw7AQv+wY1qc1Oxx
         ojG6u0ObVw2QcICNaFluP5kgFJr9WhCenUzReonnlgaPo6QbHVsKzpudD4ZlmcXnRMGa
         FJSh42/MZBk3S7mjIDDQGywEMuuBJ9BcQlzRHfPMQCNeSUtHCMP2Nvhahvnj4B5pVTTf
         2+gCevEDarwzhZWEI/8s2YOfQf3zz15iSsy9eSYhAEQCM1jhYTvo7iOW7HyMu2PwiHGn
         nFo2uOFofjuEk4y8qseEB2So3JTa2VJZ3//9uTsvlK7aQ60GB/Q+/10QpaZQ2W+H0qpa
         37Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2SrtIqVi6N/CDzfoGks7RKJ0ApZRQBPN1BqiEtG0HUg=;
        b=H+p4KZ4u8RFYNPw1XQQ3REOz3r9xE6+bbAEBB88IB8N7Vh/WKaskMt0rsSy5xok1PR
         6ksw2yRHrzk+Qpyt59/6h4OBBmyOm1JMQZRXT7NGzhJ5f29MEFtzQasdXuaYlIN3ct/M
         wAEC9d5Ztqw75TLdnyrkWCF/DvsOvRvnkiRK8yIXyVTCr21BXH2GStHdHniz4hVPnUKr
         Zllueif2XhGqSdRzJ5Io0eqRNNDafa72EQt//Qqu75JyNsyYGlnHelWkD/k7wtiU+Wns
         pfo+46VttRm66Flsb7FD5jwabts7cSTYBHWo0aMNdjHMl2zhds2t7EzwziOaeoG0lhcR
         IRYw==
X-Gm-Message-State: APjAAAUeZq5Luc0onw6XKKYOABX6RbmFatmtEdr3ilrlTfceOOG3jZFO
        KnefmhANIz+91SeQocqqR12pDw==
X-Google-Smtp-Source: APXvYqwuaFlrQncO/ecJaWVjyp4jA81KdRkItS9C1/xsInsVbND/ZafxpvOffKtXSgDtgZz7/EKJPQ==
X-Received: by 2002:a1c:7e0e:: with SMTP id z14mr397949wmc.95.1556132569977;
        Wed, 24 Apr 2019 12:02:49 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.213])
        by smtp.gmail.com with ESMTPSA id d14sm2880832wre.78.2019.04.24.12.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:02:49 -0700 (PDT)
Subject: Re: [PATCH bpf-next v3 2/2] bpftool: show flow_dissector attachment
 status
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        jakub.kicinski@netronome.com
References: <20190424185230.251550-1-sdf@google.com>
 <20190424185230.251550-2-sdf@google.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <144dc3c2-5230-8c0a-eb7b-46520f381e3b@netronome.com>
Date:   Wed, 24 Apr 2019 20:02:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424185230.251550-2-sdf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-04-24 11:52 UTC-0700 ~ Stanislav Fomichev <sdf@google.com>
> Right now there is no way to query whether BPF flow_dissector program
> is attached to a network namespace or not. In previous commit, I added
> support for querying that info, show it when doing `bpftool net`:
> 
> $ bpftool prog loadall ./bpf_flow.o \
> 	/sys/fs/bpf/flow type flow_dissector \
> 	pinmaps /sys/fs/bpf/flow
> $ bpftool prog
> 3: flow_dissector  name _dissect  tag 8c9e917b513dd5cc  gpl
>          loaded_at 2019-04-23T16:14:48-0700  uid 0
>          xlated 656B  jited 461B  memlock 4096B  map_ids 1,2
>          btf_id 1
> ...
> 
> $ bpftool net -j
> [{"xdp":[],"tc":[],"flow_dissector":[]}]
> 
> $ bpftool prog attach pinned \
> 	/sys/fs/bpf/flow/flow_dissector flow_dissector
> $ bpftool net -j
> [{"xdp":[],"tc":[],"flow_dissector":["id":3]}]
> 
> Doesn't show up in a different net namespace:
> $ ip netns add test
> $ ip netns exec test bpftool net -j
> [{"xdp":[],"tc":[],"flow_dissector":[]}]
> 
> Non-json output:
> $ bpftool net
> xdp:
> 
> tc:
> 
> flow_dissector:
> id 3
> 
> v2:
> * initialization order (Jakub Kicinski)
> * clear errno for batch mode (Quentin Monnet)
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---

Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>

Thanks!
