Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40B3C4360F
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965C520882
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZouWLEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDDPFX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:05:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36607 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfDDPFX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 11:05:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so1387246pgc.3;
        Thu, 04 Apr 2019 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i0GPMtIdS9HI8hPLb6G/yKs/AZfA+Fsy7NKeFFIZQ5I=;
        b=KZouWLEFwtnGGt6COaBERFJuH2YpHA/QGz/nPVEyoRaqBJr6lHRGD0NAH8delTmaOS
         WWhDuSsbto0ZSW/RtN3F9+nKhZasayKLWIXYHDoNKiMtyP3HSWimQr//8+Wl1dvpCPWe
         CPEg6PrILWKG7TDmJrtuHLKBVSEE3bj6/XDNTg1IRIuhipL6jm4BzcDPLCR1b+IxLiSD
         V+5CLJOtepG1Kmfq+cp+zBUscfxIn6Q/nvjX3WjP2rGX8eVGQ5wSNAolvTPWIbDvi1bQ
         eyR3Dk2wC6fGPkoyn8Nj1pbLpNezTIttHxbEyd9zYfvzfn5YEFqEdPJTrT/jjmxL1rKJ
         lTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i0GPMtIdS9HI8hPLb6G/yKs/AZfA+Fsy7NKeFFIZQ5I=;
        b=jxiU0WPqEjLBSyPU6sJnetayfJNxKC+9pDryUIIo5m2qqW6nsIUh3EhkTqi3/T/p4C
         4A7XpOadomkCHgK66Tr2lPgW2VGac38TO+puWzCjWAHhX4uMe05uvJEbdSmDruf4QF14
         Fpryca1Pcn4htHtqPbHAX6ngSH2cBKbF/AfFIO45U5bUO0u9XLrgvO2lWkSvkvhLJlxt
         oaq8dLSZcQJedwzHoVibTrFSqAhyrKImQL4Ge7nF1bDYiceiwL3n/cKT5H5shLnsRv0l
         4nPhZduJ9e8UpK5sLVurBvkf2uEPmpZ4KcxArCN2C0XhhImTb/y4tiZS0CjNZNx21j0h
         YNKw==
X-Gm-Message-State: APjAAAWyryO9CU953HjtofXsP8MHftjr+/IxjSDByfN/WhmJ9Gd+OMkZ
        25aSyXjKttkHH6hL6rjcM74=
X-Google-Smtp-Source: APXvYqwZfcmWrd1a12+a7y8oe7nJ8zmZS6AavMEnckNCNm6iPRtU6Fb4wm6a+KRUY/gDgiz3Nbiyhw==
X-Received: by 2002:a65:6295:: with SMTP id f21mr5882702pgv.129.1554390322511;
        Thu, 04 Apr 2019 08:05:22 -0700 (PDT)
Received: from ?IPv6:2601:282:800:fd80:c5a1:6d6:d92c:c7c1? ([2601:282:800:fd80:c5a1:6d6:d92c:c7c1])
        by smtp.googlemail.com with ESMTPSA id s5sm22369684pgv.8.2019.04.04.08.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 08:05:21 -0700 (PDT)
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
To:     Martin Lau <kafai@fb.com>, Peter Oskolkov <posk@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Peter Oskolkov <posk@posk.io>
References: <20190403154338.29990-1-posk@google.com>
 <20190404050941.w3fegqpm4kmyx3n5@kafai-mbp.dhcp.thefacebook.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <a6e18347-0b8e-067e-a1d2-972084d102de@gmail.com>
Date:   Thu, 4 Apr 2019 09:05:19 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190404050941.w3fegqpm4kmyx3n5@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/3/19 11:09 PM, Martin Lau wrote:
> On Wed, Apr 03, 2019 at 08:43:38AM -0700, Peter Oskolkov wrote:
>> This patch adds tests validating that VRF and BPF-LWT
>> encap work together well, as requested by David Ahern.
> LGTM.  David Ahern, please review also.
> 

looked at it last night and hit some problems running the script. Will
take another look today.
