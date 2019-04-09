Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF800C10F0E
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 16:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F72220883
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 16:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Ip6ig7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDIQ5f (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:57:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46351 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIQ5f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 12:57:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so10047566pfj.13;
        Tue, 09 Apr 2019 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T5FuZxi6v+QW32ToObv1qgsnb20Q55Rzgr2gRwAN80k=;
        b=S7Ip6ig7xH3SOtgBq91WYfJYm7tbp98i7wCZAIOTvRkMe8KoeuGsGbnZWsh5ajyjfa
         ojDM35wJ3bdLbt4EqQQxp+0TH9rc1IcKcND6FF6ZxtalHedFEax4bQfWe57Jbk91j8xs
         KTXQbG/UD9cXFk3PAi2aPwam28TnMtLWrJ4vpYrlBzPm0dF6a3JNGqkXIneUGzqWMgvz
         hUahV+0gJWW7ObvE5ZEWVzElk+AlO/I8yhGMTllkLK2kVokcdnxoNIIIaKGgrFj/CyH2
         6I68DR2UJhQLd3tKQt927cxyD1X9iIERFXosed8SP5Ip1wvrrTuTS2F8qV+hAxFECjAo
         Murw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T5FuZxi6v+QW32ToObv1qgsnb20Q55Rzgr2gRwAN80k=;
        b=cd51SHPW4ePLiov+/QTbQWl0zw9f95YrGk7E1GwQhElT5fPBV7pxa/0e94w2Cms+oe
         HeS+g6czBSrVJzHGWGoNLm5xn+tYfzoThy7h0YnsWTfyfakowQWDDXxI2HT0VcwZoWyU
         dzbW+E6+vkRG14NxOWTNBPi+H9PiImhSlgDWjZ6h3rLt/AbzLtDVaEpAsjm/qpxXA+Km
         DuLc46gYrXnJonUFXKwIdVxjjfscjXdEY5EgiVMZzAkQIBc3hvCjiheSJGFpcH6EUDL2
         R+znKlLwtrHLMXzroXnzu6AyqrIYYeil+q/0toDERG1cTxnGx8lPNQD8eV/1sO8pZTQm
         jQ7g==
X-Gm-Message-State: APjAAAV2rurblgqckkgLtGgnLMLdY+z0ZQ+QIiLd1Dog9OFJtqChb0vp
        RJMwb9K4sC5Fmk+asqkztsQ=
X-Google-Smtp-Source: APXvYqyqtdYISfBYFUvW9+Zt80yyDMCbRb+nJ/GYFLp7lGlwDOS7ecxYMeeiunH5hoOHFPcZiPLs/A==
X-Received: by 2002:a63:2c3:: with SMTP id 186mr34860297pgc.161.1554829054170;
        Tue, 09 Apr 2019 09:57:34 -0700 (PDT)
Received: from [10.40.10.243] (fw.cumulusnetworks.com. [216.129.126.126])
        by smtp.googlemail.com with ESMTPSA id e7sm21011543pfc.132.2019.04.09.09.57.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:57:33 -0700 (PDT)
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Peter Oskolkov <posk@google.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Peter Oskolkov <posk@posk.io>
References: <20190403154338.29990-1-posk@google.com>
 <89f72dd4-a3d8-3788-482b-578e18b7078d@gmail.com>
 <07f9be8a-7856-8b68-f085-b72c0e880a05@iogearbox.net>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <fe4edfa2-4b0d-6c5d-6ced-c12c82cb4868@gmail.com>
Date:   Tue, 9 Apr 2019 09:57:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <07f9be8a-7856-8b68-f085-b72c0e880a05@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/9/19 2:48 AM, Daniel Borkmann wrote:
> On 04/05/2019 04:32 AM, David Ahern wrote:
>> On 4/3/19 9:43 AM, Peter Oskolkov wrote:
>>> This patch adds tests validating that VRF and BPF-LWT
>>> encap work together well, as requested by David Ahern.
>>>
>>> Signed-off-by: Peter Oskolkov <posk@google.com>
>>> ---
>>>  .../selftests/bpf/test_lwt_ip_encap.sh        | 134 +++++++++++-------
>>>  1 file changed, 86 insertions(+), 48 deletions(-)
>>>
>>
>> I hit a wall with running this script. One problem is the different
>> versions of nc for debian (stretch to be specific), and another problem
>> is commands failing it is hard to figure out why (e.g., connect failures
>> which seem like route lookup problems). I have been adding run_cmd and
>> PAUSE_ON_FAIL options similar to what is in fib_tests.sh and the change
>> I sent for pmtu.sh, but I have not finished.
>>
>> I am traveling tomorrow and not sure how much time I'll get this weekend
>> to come back to this. Might be early next week.
> 
> Hi David, any progress on the above?

not yet.
