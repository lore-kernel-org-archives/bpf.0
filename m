Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C6FC10F11
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 01:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82F5B217D4
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 01:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnhR7z0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfDKBTF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:19:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfDKBTE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 21:19:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so2515872pfi.12;
        Wed, 10 Apr 2019 18:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ymdTnTx50xuDSmJ8t0oWqdIBf4qCauCwn8QLLf+FypI=;
        b=DnhR7z0rXKXH7zmkPZ9QTVxZ0LSBJh0uoEuikjTpcy1z0zEDYarvkOuTC7sZshY+7i
         D3l4zpKq23Y5lrJsGRco75RNn2AF81fzAdYxUSRIoeRXcnfMnykxbPnwBLxl3X8VvFA1
         uSu5D1MjnZuzVdV7oVzGL5aUY4WSEF9iQM0DzdCUHmsUVp7Hjwg/xtRF2Yg86+XEqcSs
         fiYJa0mu700x4RacMtpTWYrdKn7z4SW3Xal8wKvJWVseG9jkD3fUYFJcUAFDVyxIR5nr
         BEWzQ2PrYvE6WVRb+XbrtBuoKsHiL48sSn4UmNe/DH7yuWen1ig4l1X4WCQIsumYwvQS
         0GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ymdTnTx50xuDSmJ8t0oWqdIBf4qCauCwn8QLLf+FypI=;
        b=mkUZulrDDuCYVE8jAFwdoaQ/bJGM4VDwiTVq+toB/VVvNH/B5VCQtsmb9z+MFQhvoA
         Q85xo3cRXNNYOHQ+keLOJjlz60WASXZt0GoVydvpK3BDovfyt7EBnH+O4OeXp9SxXSwn
         1DYnwJf3+2OkeGmTFn2/DdVwWcafE58pcSnzV0sW2wP57fFLna80X2wisbWpLoRLBe/1
         ALq+dSiF1hNEVgAfX2K0UYzcXsEZw16prH1bOekFJCauEM17x7AKjLu4be6fL0xTfnQr
         t+1mHnazYfGJSnorygUflCntr4YKMP4AQKNJLdwuaiCsd27EZP86RGL3F3e6ykS/uGGN
         Wm3w==
X-Gm-Message-State: APjAAAVDPzIVzi+S6aIL3kG1aTLiUPx7JBMgBgfG9a4+56OYR+zywdNA
        CWx/QnLfoAXN2mUjKaHRW4k=
X-Google-Smtp-Source: APXvYqybf03R59EWr8vHVweXolHhH/co5vzvZcHqcJOGGvWy3Jkz4tpP5hodnyYNQaWuNwGgkbH8WQ==
X-Received: by 2002:a62:19c3:: with SMTP id 186mr47725868pfz.172.1554945543944;
        Wed, 10 Apr 2019 18:19:03 -0700 (PDT)
Received: from [10.40.10.244] (fw.cumulusnetworks.com. [216.129.126.126])
        by smtp.googlemail.com with ESMTPSA id y19sm51066804pfn.164.2019.04.10.18.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 18:19:02 -0700 (PDT)
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
To:     Peter Oskolkov <posk@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Peter Oskolkov <posk@posk.io>
References: <20190403154338.29990-1-posk@google.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <82d2b94d-656c-2604-1538-468e2f891b99@gmail.com>
Date:   Wed, 10 Apr 2019 18:19:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190403154338.29990-1-posk@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/3/19 8:43 AM, Peter Oskolkov wrote:
> This patch adds tests validating that VRF and BPF-LWT
> encap work together well, as requested by David Ahern.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
>  .../selftests/bpf/test_lwt_ip_encap.sh        | 134 +++++++++++-------
>  1 file changed, 86 insertions(+), 48 deletions(-)
> 

Peter: What OS are you using to run this test script?
