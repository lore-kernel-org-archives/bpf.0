Return-Path: <SRS0=Im0D=ZW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71941C432C0
	for <bpf@archiver.kernel.org>; Sat, 30 Nov 2019 01:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29369215E5
	for <bpf@archiver.kernel.org>; Sat, 30 Nov 2019 01:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue3Vs3fZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfK3BiA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Nov 2019 20:38:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32773 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfK3BiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Nov 2019 20:38:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id y206so6838695pfb.0;
        Fri, 29 Nov 2019 17:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t45gUtK+uM9mXjiLOJb5swNVbq1vD3irWLp7sG1Ctu8=;
        b=Ue3Vs3fZvHJEWZYZulg2C54l8z5eEMBS/Uxt7hAM+L3CNGsm5us7TVdTsydqyEQfPv
         1SVJu/Q5UfM/AUsh2gJRB2mNUg3TRXOSUy0nB+ex/DXZxtp7JEF6Y5VSoPTD1IAlE1pq
         vTIROm7MCp/SqCYhPxPMndDxd4G4ck6qrPsoF4WlwrFbbMQg9W+qS3r98KfB5sY8DhJY
         XjfS5GU8rpG1qHmpisPxsh96wfQnKcQYLBDutbCct4dc4u9/ehs/p5IGJzVl0OUlVoto
         74S2PdRgTLF01i5uSEKu5n8qD6S4IpIQ1Xvtn+Cfj4URGWH2hiJqDCgg4dxCw2nwONKQ
         2WvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t45gUtK+uM9mXjiLOJb5swNVbq1vD3irWLp7sG1Ctu8=;
        b=r9Xtvlp2wPLq+xnbIXjrOTPKmiaaK0DCYvMOldTIv7Wx55NsI4ENfSOZpMwxjCQkKN
         tOAuP/eL74+cwnkVQls9Z+S7OYB5QNs8ZGVMwwKJ8coHkBvGyGxw/ycPynFnlpOPRRza
         tFj+33WAWw9Lm25wpGgU3T3CXBaAqlWJtTdgdIzBLH5N0kAfLTmX/EuwABs+7vmsWomv
         pho8nTjyOv01S4Mq/OEF83ZJkwGyNRdI3KUNla29cmcO95W/vbPzPO602D4gDBx3S6MN
         lW6GnvQ9ottBKjVOCQp7gE+cZtUmAplG6tEDdod2BTWpm4ioQw4c4FmMjmDOJUx8VE6H
         +28g==
X-Gm-Message-State: APjAAAX8wMSciH4sQ9B5RCyijPPwNaZJ1TdHmv+1xfGfkkmvcO3BABf8
        lV+ULNT48U4v0PiA5HxQoSY=
X-Google-Smtp-Source: APXvYqxRVDvofp4K48J2STEhlQkL2kouyRxmAijrBD2y+RICCWu6L6dDxIrKH0X/A3OSqfifOpTYpA==
X-Received: by 2002:a63:551a:: with SMTP id j26mr19600497pgb.370.1575077879570;
        Fri, 29 Nov 2019 17:37:59 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-58.hsd1.ca.comcast.net. [73.241.150.58])
        by smtp.gmail.com with ESMTPSA id c17sm25614319pfo.42.2019.11.29.17.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 17:37:58 -0800 (PST)
Subject: Re: [PATCH bpf] bpf: avoid setting bpf insns pages read-only when
 prog is jited
To:     Daniel Borkmann <daniel@iogearbox.net>,
        alexei.starovoitov@gmail.com
Cc:     peterz@infradead.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191129222911.3710-1-daniel@iogearbox.net>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <ec8264ad-8806-208a-1375-51e7cad1866e@gmail.com>
Date:   Fri, 29 Nov 2019 17:37:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191129222911.3710-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/29/19 2:29 PM, Daniel Borkmann wrote:
> For the case where the interpreter is compiled out or when the prog is jited
> it is completely unnecessary to set the BPF insn pages as read-only. In fact,
> on frequent churn of BPF programs, it could lead to performance degradation of
> the system over time since it would break the direct map down to 4k pages when
> calling set_memory_ro() for the insn buffer on x86-64 / arm64 and there is no
> reverse operation. Thus, avoid breaking up large pages for data maps, and only
> limit this to the module range used by the JIT where it is necessary to set
> the image read-only and executable.

Interesting... But why the non JIT case would need RO protection ?

Do you have any performance measures to share ?

Thanks.
