Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75707C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 00:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB1620651
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 00:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9qk3OH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBWAF7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:05:59 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38303 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfBWAF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 19:05:58 -0500
Received: by mail-yb1-f195.google.com with SMTP id f196so1548922yba.5;
        Fri, 22 Feb 2019 16:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QTVvCOevTDl73jViyulXbYfsjfDfQkQmmv67Me/VDic=;
        b=W9qk3OH3RrBKV3EYVLlRqQZ93sYrf4+FyE6SU0ovn23gPPQPUZgQBgcMBfuRsP3oAm
         pXbfhzFm9XA2zG/jNEv742JFJWBLc5QvT88gaBBLFQv9k8rh7jSGspGscwgQ1AhwYgZp
         aGJycqzjP2ogEPpQshWxFceMiW8InS770H+YuDO+Iw7wovVSheRlm4GYuVbqljuz06N/
         6cqyEZ7pHJXUTBVb2eDtAetlN1urWLao3B0xMWfxFH32FmLLzYTgzYRCfTk0FZoSiaaP
         /pwJ5idtGmYAT1ZAssT0Sq/hUjE6MV2u6FNPNHvcx7r4MoAIsV/oTzdi8EpGoISmfJMX
         dwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QTVvCOevTDl73jViyulXbYfsjfDfQkQmmv67Me/VDic=;
        b=cep1KzfpYIE65LQX9kyuVy5jUfoOD+IIG3fHZRrUiXbR2u+Gp74aXMTFQmmWlSWbFB
         9lMtlJCUih5+k8dhpR8lwgtkzpurGQDW31CYHOAXTcM24bUclR0nelCQHcckgElh2Qj7
         JK9wmA3CULyFM4yI2iUd/rPSrAjmd2V8n9LF7C0QpRxecEkti8TRPEZMW88yrq4evqUa
         NMQaE2syqTTlKEpfgpHuVbxsgA8w2kq8sZc8o8MMQCvFKEF4AP0cG2BJapd/IBQdfgj6
         u395bstr03VnJxSFdyssqCvRPv/poywOd6a8JDAVgbEw4Rm7WehaPMeK8vgQK7ATliv5
         L1UA==
X-Gm-Message-State: AHQUAuYNmdvEKvmKXv8EHFGfGoOCJ8HE/YU3/ASVb7BXZ45JLg4Yfa6s
        dX87pCBSa4lZIremLS4S+vVe5lvr
X-Google-Smtp-Source: AHgI3IZn811PwJoRkp85VsordQPbew3mw5lQwlwZPF1IB7HS6F9d6Xh8O/XMf2jirzaB9l2+q/SA2g==
X-Received: by 2002:a25:2b07:: with SMTP id r7mr5643137ybr.300.1550880357954;
        Fri, 22 Feb 2019 16:05:57 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id 79sm977321ywo.64.2019.02.22.16.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:05:56 -0800 (PST)
Subject: Re: [PATCH bpf-next 1/4] bpf: enable program stats
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20190222233644.1487087-1-ast@kernel.org>
 <20190222233644.1487087-2-ast@kernel.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <adabf404-7d0e-d801-1952-14f6b3ff8ced@gmail.com>
Date:   Fri, 22 Feb 2019 16:05:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190222233644.1487087-2-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 02/22/2019 03:36 PM, Alexei Starovoitov wrote:

>  
> +static void bpf_prog_get_stats(const struct bpf_prog *prog,
> +			       struct bpf_prog_stats *stats)
> +{
> +	u64 nsecs = 0, cnt = 0;
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu) {
> +		nsecs += per_cpu(prog->aux->stats->nsecs, cpu);
> +		cnt += per_cpu(prog->aux->stats->cnt, cpu);

This does not work reliably for 32 bit kernels.

> +	}
> +	stats->nsecs = nsecs;
> +	stats->cnt = cnt;
> +}

