Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0C0C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 05:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4608F2083E
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 05:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpd0dK1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbfDKFEh (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:04:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36425 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfDKFEh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 01:04:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck15so2782805plb.3;
        Wed, 10 Apr 2019 22:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bt0uWbuj1z5MOE1Q8awHzULq2AEW4NWNDM8uAh7cWs0=;
        b=Jpd0dK1g1dVzSgZg2NiM3wSJZIDHVn45aP6auli4YDbYwA3+CxRv//JTlLCkLQSG2N
         1x2hsQpJJe39UWsfOd0FC0zQJ0cC4gFh8DOVhCxJ/Ks6OMwGlp2ZbfnypO1lmG6C8EC0
         fhL0SE7Voz1Dhmfe8q4fRJ7WcG3dIOvN/Ie1kB+C0HZqQw+o8A0wcXg8oC0XzwORA6lT
         ATqcOhJdzZW+1DQfQZJ3N0uFBaTuIdZiNFzIaShDogVyH3zzxL8amRHrJNiM1VPPtspV
         d4eCJBWsdnXMkC0s/ap/WqvOrbAw3tzkBYESVetrVw8K5CXuzh/YMR9ywvq2TmiVo01x
         9PMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bt0uWbuj1z5MOE1Q8awHzULq2AEW4NWNDM8uAh7cWs0=;
        b=Cngadn2sYtS+kwlq06gUWwEDHDFKSxwaBuAHbzaWEg7hoSMUyZLKj301d8eR9pjjln
         DCYwY8g4OOymUw37jAG/WK2nuwbbPwgacbSYZQY3MAfMuG97qhQ9JE0WoZLlJ81Ebbdv
         2G/MzTxS9VbFT1VMAA7i0lq/SsyZxkArnDX0BfUZcl0LWp6nLhJfNv+lbeiqQo84j+Tb
         JLXHMpuhTmeYWrBrqGQouDG64sky7Ykja1OShxd8bxQev+4ty905cykAhidPwXgVz5rA
         SDEe2sWXgsJRXc/eLYBc1ZFEGaZ7YZ8As5MGPDSo0FfEJcamnX9Uv/ueEIG48B1mhoTj
         MnhQ==
X-Gm-Message-State: APjAAAWSqOBrDSUUbW87yITCcJV0BJXfZH1AQ+KUfDdqMdUcXod07CDW
        0wBNO+GVDO+pGqueum3VPVeOXEcz
X-Google-Smtp-Source: APXvYqx11iNziUTxxN7h5TTjPOjfN37iO5G65HEznd0z5MVaw5n69Lg7rlraeFL+gsdYo19IHbnwKA==
X-Received: by 2002:a17:902:7785:: with SMTP id o5mr48398957pll.33.1554959076626;
        Wed, 10 Apr 2019 22:04:36 -0700 (PDT)
Received: from [172.27.227.142] ([216.129.126.118])
        by smtp.googlemail.com with ESMTPSA id q74sm52477444pfc.111.2019.04.10.22.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:04:35 -0700 (PDT)
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Oskolkov <posk@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <20190403154338.29990-1-posk@google.com>
 <82d2b94d-656c-2604-1538-468e2f891b99@gmail.com>
 <CAFTs51XLObGg78HOO=jc8HqgKmuUkONcsCuH4jvMfOLiOKXU+Q@mail.gmail.com>
 <e89a3bb0-87c0-bb66-38a7-ac3bba1755e6@gmail.com>
 <CAFTs51XM3XUTCSGbhP=Xr+8__ezvMNVabMmGPbHk393rXazABw@mail.gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <cd8f31de-aaae-db13-4755-400f5d335b2f@gmail.com>
Date:   Wed, 10 Apr 2019 22:04:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFTs51XM3XUTCSGbhP=Xr+8__ezvMNVabMmGPbHk393rXazABw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/10/19 9:38 PM, Peter Oskolkov wrote:
>>
>> Notice the "No route to host" errors.
> 
> "No route to host" is OK: there are negative tests, as you requested a
> couple of months ago... :), and these tests correctly trigger "no
> route to host".
> 
> This output basically tell me that the test passes, both with and without VRF.

ok, expected errors like that should be trapped and hidden. I can barely
remember what I had for breakfast yesterday, let alone that errors like
this are ok months after the initial test submission.

Again, I reference what I did for fib_tests as an example of how I think
tests should be written: 1 line per test with OK/FAIL at the end of the
line, expected errors trapped so a clean runs shows only clean output,
verbose option and pause-on-fail option to help diagnose errors when a
test breaks.

...

>> ###
>>
>> so netcat is not the right package. 'apt-cache search netcat' shows
>> another package, so try it.
> 
> I guess Debian Stretch has a too old version of netcat that does not
> support the flags used in the test.

I don't have recent Fedora VMs setup to run these tests, but within
reason they should work across OS versions (reason to me being widely
used OS'es like Debian, Fedora and Ubuntu).
