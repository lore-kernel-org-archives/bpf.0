Return-Path: <SRS0=yvf5=RY=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3713FC43381
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 04:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0763C218A5
	for <bpf@archiver.kernel.org>; Thu, 21 Mar 2019 04:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y28pQ4rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfCUEol (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:44:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55418 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfCUEol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 00:44:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so939037wmf.5;
        Wed, 20 Mar 2019 21:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vhOTqUW/HtJRDmilT5HRnlupXL6bQ+qRUxnMzXJYhUY=;
        b=Y28pQ4rbK2dCe29bPv5dEXPGafEHJhFwQI6JaeVMDC3pEuty/PD+pwo8E4dNM98ycT
         U1a+Ufu4f8q7s2xIFiyd0j9zMx6RGuXITKVp3lr5F9loZfKppEafkziL7lMqXDIBBIRF
         hdPb33mSM549Utr/8pJPjf0GAoQmhvVYfGK+KJ0h0JA/fJ64rPSKfPGonEcWQwCzZk6T
         spFYnO1fexqlM13v4BAo0Fra2VTHL5Nqv+xL3qc8msJHgMQi6wPpkFYa2YE1yjDnnhcO
         366qAmDSY+HSJ5xtG02Ui4k/2uQg66il0gIz2sXa+SJLLbdxhkswH7UvD3lZRpvSZ6EO
         FbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vhOTqUW/HtJRDmilT5HRnlupXL6bQ+qRUxnMzXJYhUY=;
        b=E4UDT7tTsqLO8SBbxBbQ6aYb4tc1czkzp/FZv5UzzpVp3FYvTpiXa8MqFEVjN7Hnha
         onEJS0uHVsuNfglio/6TBBKnVvbWMQOLF31vqwJJjWdp6kkOQHKTz1Zh1koxRX4TVAj3
         01eimYIJtwjcWeax02MVXUSu8i3/PnDqos5rhOULSYiVZgbsmIC7E/dmzhZhSNV3O0nK
         s09atwtPlPT40m64X0dFOcpQ3AyKSMehQ4Im+++6h79ZJXI81yYuSdCkVULyyhBwF4hj
         +SWU+1N4z4JIO6usgK6MXjhvD4CP2Qsa4bs3niy8qNW3M03Ilo/pFYFJATy6G9C3TA0/
         Ov4Q==
X-Gm-Message-State: APjAAAXs6aqZ+FjVlhqwfzBfjUmPY1Zo6ebmkjz9ODKSnRzG7rdMrgoz
        rAcgbJRBRc4aC/wyT5ursyA=
X-Google-Smtp-Source: APXvYqzvsTVAjJSSFKG6WsIlXepV32WzoazcvsQmu9LmaAU0BwEgQOn8IRB9UJbZ5BcCfPpqaLZIvQ==
X-Received: by 2002:a1c:6042:: with SMTP id u63mr1011954wmb.92.1553143479689;
        Wed, 20 Mar 2019 21:44:39 -0700 (PDT)
Received: from [172.31.96.190] ([195.39.71.253])
        by smtp.gmail.com with ESMTPSA id b134sm8865186wmd.26.2019.03.20.21.44.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 21:44:39 -0700 (PDT)
Subject: Re: [RFC bpf-next v2 1/9] net: introduce __init_skb{,_data,_shinfo}
 helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, simon.horman@netronome.com,
        willemb@google.com, peterpenkov96@gmail.com
References: <20190319221948.170441-1-sdf@google.com>
 <20190319221948.170441-2-sdf@google.com>
 <20190321033941.bygpejl2krltkdmm@ast-mbp.dhcp.thefacebook.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <6406eae2-4633-9b2a-1101-2de48d29f9dd@gmail.com>
Date:   Wed, 20 Mar 2019 21:44:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190321033941.bygpejl2krltkdmm@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 03/20/2019 08:39 PM, Alexei Starovoitov wrote:

> I think you need to convince Dave and Eric that
> above surgery is necessary to do the hack in patch 6 with
> +static DEFINE_PER_CPU(struct sk_buff, bpf_flow_skb);
> 

Yes, this is a huge code churn.

Honestly I believe we are going too far in this series.

> I think the better option it to introduce new prog type that works
> without skb. I think it can be pretty close to shape and form to xdp.
> 
