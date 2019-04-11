Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA5FC10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 04:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BC52084D
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 04:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai0cX5s7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfDKERI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 00:17:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45631 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKERI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 00:17:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id y3so2817155pgk.12;
        Wed, 10 Apr 2019 21:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CRJez2E53hy/rCMtpXx/VuZF+NjSCQ0+twMnB1I0BMQ=;
        b=ai0cX5s7hUCzsFVuhmY3zzFoVyWfVAHJV4vd/a7aYOSLeFCJHLOg7twBC4REtixm8S
         yFZSvQuZTt/Gju6y/afBRlXE0kQqjycMvVGog/07oiQNcflasFbDa6d3b7NwkBR204Kp
         BBm9sEDVzzEMAZ6NxoO4zqHkjP7lecrbb6+WQZSf8sTGbMCcxwODx8V1Qm+jS/en2Ntj
         zJgCuJP6a3fqO2PnZ155cDSR2+YV3t16maVYK/vyMvDPEEH7uaxfc0q2Qy80k0twDfIA
         19nsaPgoLDXwS8Nz9FNJ3Qnod+wfu5Q5lFVFG0xXbhoAObd4D/Cyeu3zapcalrxcYoGv
         yT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CRJez2E53hy/rCMtpXx/VuZF+NjSCQ0+twMnB1I0BMQ=;
        b=VIl3PqZNhp92wjRrHW4/1vPaMh2FcmYrr5595VsvBlhLD2vVcgKI9s+tjvK8m5FyUe
         hs8Jd32nAsTjmDyt7ZlqJTdIlEcsmBypqlpkFD4vj9g/98bnBu3Eny6RHRFmYHbgsQjx
         qrIwWyOuTOgwS0ZSk7PUDyFAVf1RSpeANiHI9C9jqLXIZLI3BWweKENP8ryxCNFyLJ9W
         jwG1LPTAt872ucx2ApwhFYD2lbkfinjKeTeRu4zxZ+LAYNjkz5Ph4A8UrNyZTyajrRFY
         +XVvelxYf8Pv0H6/v0hSFCtKjpP3b4EPq0ppQN+7cX7sDOgBBO94xTXecmkQhcu3BTS7
         jsqg==
X-Gm-Message-State: APjAAAVxKMJ2XeRFKCv6jX9rove4m0Z72PhV0+Qbwwqd0TW4ipvIoWnY
        52Rs32SOp/dj3iNytsthcDyjzLgS
X-Google-Smtp-Source: APXvYqxgsib70TAzOrBWPOb+gbIjrE3trv+sxa7hFZqVBTEUN30l4SrF9bMU2hocMI3ir2LrvXQUig==
X-Received: by 2002:a62:12c9:: with SMTP id 70mr48101914pfs.156.1554956227291;
        Wed, 10 Apr 2019 21:17:07 -0700 (PDT)
Received: from [172.27.227.142] ([216.129.126.118])
        by smtp.googlemail.com with ESMTPSA id e21sm50907389pfd.177.2019.04.10.21.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 21:17:06 -0700 (PDT)
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
From:   David Ahern <dsahern@gmail.com>
Message-ID: <e89a3bb0-87c0-bb66-38a7-ac3bba1755e6@gmail.com>
Date:   Wed, 10 Apr 2019 21:17:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFTs51XLObGg78HOO=jc8HqgKmuUkONcsCuH4jvMfOLiOKXU+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/10/19 6:26 PM, Peter Oskolkov wrote:
> On Wed, Apr 10, 2019 at 6:19 PM David Ahern <dsahern@gmail.com> wrote:
>>
>> On 4/3/19 8:43 AM, Peter Oskolkov wrote:
>>> This patch adds tests validating that VRF and BPF-LWT
>>> encap work together well, as requested by David Ahern.
>>>
>>> Signed-off-by: Peter Oskolkov <posk@google.com>
>>> ---
>>>  .../selftests/bpf/test_lwt_ip_encap.sh        | 134 +++++++++++-------
>>>  1 file changed, 86 insertions(+), 48 deletions(-)
>>>
>>
>> Peter: What OS are you using to run this test script?
> 
> Debian Testing with a net-next kernel. What kind of errors do you see?
> 

This is on Debian Stretch.

1. nc is not installed

###
$ ./test_lwt_ip_encap.sh
starting egress IPv4 encap test
nc is not available: skipping TSO tests
nc is not available: skipping TSO tests
ping: sendmsg: No route to host
PASS
starting egress IPv6 encap test
nc is not available: skipping TSO tests
nc is not available: skipping TSO tests
ping: sendmsg: No route to host
PASS
starting ingress IPv4 encap test
PASS
starting ingress IPv6 encap test
PASS
starting egress IPv4 encap test vrf red
ping: sendmsg: No route to host
ping: sendmsg: No route to host
PASS
starting egress IPv6 encap test vrf red
ping: sendmsg: No route to host
ping: sendmsg: No route to host
PASS
starting ingress IPv4 encap test vrf red
PASS
starting ingress IPv6 encap test vrf red
PASS

###

Notice the "No route to host" errors.


2. install netcat

$ apt-get install netcat
...
###
$  ./test_lwt_ip_encap.sh
starting egress IPv4 encap test
nc: invalid option -- '4'
nc -h for help
bash: connect: Connection refused
bash: /dev/tcp/172.16.4.100/9000: Connection refused
    test_gso failed: IPv4
nc: invalid option -- '6'
nc -h for help
bash: connect: Connection refused
bash: /dev/tcp/fb04::1/9000: Connection refused
    test_gso failed: IPv6
ping: sendmsg: No route to host
FAIL
starting egress IPv6 encap test
nc: invalid option -- '4'
nc -h for help
bash: connect: Connection refused
bash: /dev/tcp/172.16.4.100/9000: Connection refused
    test_gso failed: IPv4
nc: invalid option -- '6'
nc -h for help
bash: connect: Connection refused
bash: /dev/tcp/fb04::1/9000: Connection refused
    test_gso failed: IPv6
ping: sendmsg: No route to host
FAIL
starting ingress IPv4 encap test
PASS
starting ingress IPv6 encap test
PASS
starting egress IPv4 encap test vrf red
ping: sendmsg: No route to host
ping: sendmsg: No route to host
PASS
starting egress IPv6 encap test vrf red
ping: sendmsg: No route to host
ping: sendmsg: No route to host
PASS
starting ingress IPv4 encap test vrf red
PASS
starting ingress IPv6 encap test vrf red
PASS
passed tests: 6
failed tests: 2

###

so netcat is not the right package. 'apt-cache search netcat' shows
another package, so try it.


3. remove netcat and install netcat-openbsd

###

$  ./test_lwt_ip_encap.sh
starting egress IPv4 encap test
nc: cannot use -s and -l
bash: connect: Connection refused
bash: /dev/tcp/172.16.4.100/9000: Connection refused
    test_gso failed: IPv4
nc: cannot use -s and -l
bash: connect: Connection refused
bash: /dev/tcp/fb04::1/9000: Connection refused
    test_gso failed: IPv6
ping: sendmsg: No route to host
FAIL
starting egress IPv6 encap test
nc: cannot use -s and -l
bash: connect: Connection refused
bash: /dev/tcp/172.16.4.100/9000: Connection refused
    test_gso failed: IPv4
nc: cannot use -s and -l
bash: connect: Connection refused
bash: /dev/tcp/fb04::1/9000: Connection refused
    test_gso failed: IPv6
ping: sendmsg: No route to host
FAIL
starting ingress IPv4 encap test
PASS
starting ingress IPv6 encap test
PASS
starting egress IPv4 encap test vrf red
...

###

still not the right nc command.

This is when I started instrumenting the script.

So really we need the existing (pre-VRF version) to work without errors
and then add the VRF tests. And the ability to see what is failing is
important.

Compare the above output to pmtu.sh and fib_tests.sh for example -- and
the options fib_tests.sh has to help a user when a test fails (verbose
mode and pause on fail).
