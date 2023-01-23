Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3007AC25B50
	for <bpf@archiver.kernel.org>; Mon, 23 Jan 2023 20:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjAWUG3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 23 Jan 2023 15:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjAWUGV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 15:06:21 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E493668D
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 12:06:10 -0800 (PST)
Message-ID: <3a87b859-d7c9-2dfd-b659-cd3192a67003@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674504368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOQ59QPHmDUPZdHC3JGm0G/9zWHunFlEE0/hFcnMeas=;
        b=Z/6iOHHwQJVJtceqXgejlaRMo8lbwZ0hfBm7YfNFBQbRmusfHGY1Uze/0Nipuq/dzB7OHV
        pbflzpGajarxLsqoowhGseFG+YqlBi5VqKS8VkjM3ls3bG6qbNjq6AiWUmqxI1zBYOdjIu
        ceojguBFnq6AtiAIVdSEHdr70fRg1RI=
Date:   Mon, 23 Jan 2023 12:06:06 -0800
MIME-Version: 1.0
Subject: Re: Are BPF programs preemptible?
Content-Language: en-US
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@meta.com>
References: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
 <878rhty100.fsf@cloudflare.com>
 <CAMy7=ZVLUpeHM4A_aZ5XT-CYEM8_uj8y=GRcPT89Bf5=jtS+og@mail.gmail.com>
 <08dce08f-eb4b-d911-28e8-686ca3a85d4e@meta.com>
 <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMy7=ZWPc279vnKK6L1fssp5h7cb6cqS9_EuMNbfVBg_ixmTrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/23/23 9:32 AM, Yaniv Agman wrote:
>>> interrupted the first one. But even then, I will need to find a way to
>>> know if my program currently interrupts the run of another program -
>>> is there a way to do that?
May be a percpu atomic counter to see if the bpf prog has been re-entered on the 
same cpu.
