Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A26C10F13
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 04:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4DA20873
	for <bpf@archiver.kernel.org>; Thu, 11 Apr 2019 04:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="aansQTTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfDKEiU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 11 Apr 2019 00:38:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38710 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKEiU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Apr 2019 00:38:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id d13so3967482edr.5
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 21:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JvucfXXs8Y0SLvE5lUCShWqhpEgYk5odr0xCqL8zZ08=;
        b=aansQTTT5fBClVZCNQc2Z2MZWVZSeBiM9XjcplLtICL2c7/C7BNex+yyHAS8ouf7nR
         xT9n46bpfQ7KUKpikQMb6aGj1mJsXS7dxg+6EjeAGf2JiaUoULm1oP44nTxNzq5+y4W6
         A7xAe3ZbaFwQMZNbEoZM0EnYAr3F4Uc2JAsKpcix1F/xLtuUC/3osIUMvkMSma2ChZQv
         JpUzNBJstdH8/ko6/8f0Rfdliv4lRArGXggO3h1ncKi667wL5KPOKJKIyPKCqVxKiXkg
         collqJdPYke6zaLAjP6Mu/l1KDf8BGKSecTxdzkhDlvrrE6ayuTTGpRjGhyyN597Kg4G
         0wcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvucfXXs8Y0SLvE5lUCShWqhpEgYk5odr0xCqL8zZ08=;
        b=hMks5tUkdWMOFX49HLalUHtI6xszO2hSonFo7UUtFw8aq1/CXl0S3B21wD2nzSD1tc
         JGr6G5Je23uxcb14fBxBuAnXPooFi2HkcmkpWTemuI0HqTfJwQmBEONnS+FiV5K0Uc/1
         uDvDWnaH2CVSNja/Y17FlufFOjgVz/mQ6Fh6CW4PB/pihFK8ogtFQ2/kt0+yTDFJwePq
         VJgiVMe2yHUYv9Vs8O08j9/SMtMClV12a+mPuclIdrkkwr+7wBL/1Fu1TtbswZqrSow3
         BEfwQbIgIs/TlPdL4LAYjhkLjSgr9fVmCY2TAaYiEvVpgeR9VK3BtIaes09o3pr0EHT/
         k4Kw==
X-Gm-Message-State: APjAAAWmheD0AfTsypr2xn4Eh1uQhR+YtOMdloyXWLd2128GQSodqdTT
        COQGtGRgKPr4CJAOVRv3+zAr76A/3G4fDdZPGGRhbQ==
X-Google-Smtp-Source: APXvYqwU8sK+dXwzQQWbqDn/cbt/9PWtdlPhzwUMVTErptMdA50kjLYmgDt8PpxFoVCOAJQxWM05ee3UcnRjvGUSQCk=
X-Received: by 2002:a17:906:3941:: with SMTP id g1mr25596420eje.168.1554957498085;
 Wed, 10 Apr 2019 21:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190403154338.29990-1-posk@google.com> <82d2b94d-656c-2604-1538-468e2f891b99@gmail.com>
 <CAFTs51XLObGg78HOO=jc8HqgKmuUkONcsCuH4jvMfOLiOKXU+Q@mail.gmail.com> <e89a3bb0-87c0-bb66-38a7-ac3bba1755e6@gmail.com>
In-Reply-To: <e89a3bb0-87c0-bb66-38a7-ac3bba1755e6@gmail.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Wed, 10 Apr 2019 21:38:05 -0700
Message-ID: <CAFTs51XM3XUTCSGbhP=Xr+8__ezvMNVabMmGPbHk393rXazABw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
To:     David Ahern <dsahern@gmail.com>
Cc:     Peter Oskolkov <posk@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Your test output tells me that everything is OK - see below.

On Wed, Apr 10, 2019 at 9:17 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 4/10/19 6:26 PM, Peter Oskolkov wrote:
> > On Wed, Apr 10, 2019 at 6:19 PM David Ahern <dsahern@gmail.com> wrote:
> >>
> >> On 4/3/19 8:43 AM, Peter Oskolkov wrote:
> >>> This patch adds tests validating that VRF and BPF-LWT
> >>> encap work together well, as requested by David Ahern.
> >>>
> >>> Signed-off-by: Peter Oskolkov <posk@google.com>
> >>> ---
> >>>  .../selftests/bpf/test_lwt_ip_encap.sh        | 134 +++++++++++-------
> >>>  1 file changed, 86 insertions(+), 48 deletions(-)
> >>>
> >>
> >> Peter: What OS are you using to run this test script?
> >
> > Debian Testing with a net-next kernel. What kind of errors do you see?
> >
>
> This is on Debian Stretch.
>
> 1. nc is not installed
>
> ###
> $ ./test_lwt_ip_encap.sh
> starting egress IPv4 encap test
> nc is not available: skipping TSO tests
> nc is not available: skipping TSO tests
> ping: sendmsg: No route to host
> PASS
> starting egress IPv6 encap test
> nc is not available: skipping TSO tests
> nc is not available: skipping TSO tests
> ping: sendmsg: No route to host
> PASS
> starting ingress IPv4 encap test
> PASS
> starting ingress IPv6 encap test
> PASS
> starting egress IPv4 encap test vrf red
> ping: sendmsg: No route to host
> ping: sendmsg: No route to host
> PASS
> starting egress IPv6 encap test vrf red
> ping: sendmsg: No route to host
> ping: sendmsg: No route to host
> PASS
> starting ingress IPv4 encap test vrf red
> PASS
> starting ingress IPv6 encap test vrf red
> PASS
>
> ###
>
> Notice the "No route to host" errors.

"No route to host" is OK: there are negative tests, as you requested a
couple of months ago... :), and these tests correctly trigger "no
route to host".

This output basically tell me that the test passes, both with and without VRF.

>
>
> 2. install netcat
>
> $ apt-get install netcat
> ...
> ###
> $  ./test_lwt_ip_encap.sh
> starting egress IPv4 encap test
> nc: invalid option -- '4'
> nc -h for help
> bash: connect: Connection refused
> bash: /dev/tcp/172.16.4.100/9000: Connection refused
>     test_gso failed: IPv4
> nc: invalid option -- '6'
> nc -h for help
> bash: connect: Connection refused
> bash: /dev/tcp/fb04::1/9000: Connection refused
>     test_gso failed: IPv6
> ping: sendmsg: No route to host
> FAIL
> starting egress IPv6 encap test
> nc: invalid option -- '4'
> nc -h for help
> bash: connect: Connection refused
> bash: /dev/tcp/172.16.4.100/9000: Connection refused
>     test_gso failed: IPv4
> nc: invalid option -- '6'
> nc -h for help
> bash: connect: Connection refused
> bash: /dev/tcp/fb04::1/9000: Connection refused
>     test_gso failed: IPv6
> ping: sendmsg: No route to host
> FAIL
> starting ingress IPv4 encap test
> PASS
> starting ingress IPv6 encap test
> PASS
> starting egress IPv4 encap test vrf red
> ping: sendmsg: No route to host
> ping: sendmsg: No route to host
> PASS
> starting egress IPv6 encap test vrf red
> ping: sendmsg: No route to host
> ping: sendmsg: No route to host
> PASS
> starting ingress IPv4 encap test vrf red
> PASS
> starting ingress IPv6 encap test vrf red
> PASS
> passed tests: 6
> failed tests: 2
>
> ###
>
> so netcat is not the right package. 'apt-cache search netcat' shows
> another package, so try it.

I guess Debian Stretch has a too old version of netcat that does not
support the flags used in the test.

>
>
> 3. remove netcat and install netcat-openbsd
>
> ###
>
> $  ./test_lwt_ip_encap.sh
> starting egress IPv4 encap test
> nc: cannot use -s and -l
> bash: connect: Connection refused
> bash: /dev/tcp/172.16.4.100/9000: Connection refused
>     test_gso failed: IPv4
> nc: cannot use -s and -l
> bash: connect: Connection refused
> bash: /dev/tcp/fb04::1/9000: Connection refused
>     test_gso failed: IPv6
> ping: sendmsg: No route to host
> FAIL
> starting egress IPv6 encap test
> nc: cannot use -s and -l
> bash: connect: Connection refused
> bash: /dev/tcp/172.16.4.100/9000: Connection refused
>     test_gso failed: IPv4
> nc: cannot use -s and -l
> bash: connect: Connection refused
> bash: /dev/tcp/fb04::1/9000: Connection refused
>     test_gso failed: IPv6
> ping: sendmsg: No route to host
> FAIL
> starting ingress IPv4 encap test
> PASS
> starting ingress IPv6 encap test
> PASS
> starting egress IPv4 encap test vrf red
> ...
>
> ###
>
> still not the right nc command.
>
> This is when I started instrumenting the script.
>
> So really we need the existing (pre-VRF version) to work without errors
> and then add the VRF tests. And the ability to see what is failing is
> important.
>
> Compare the above output to pmtu.sh and fib_tests.sh for example -- and
> the options fib_tests.sh has to help a user when a test fails (verbose
> mode and pause on fail).
