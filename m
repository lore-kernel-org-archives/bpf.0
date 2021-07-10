Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970B0C07E95
	for <bpf@archiver.kernel.org>; Sat, 10 Jul 2021 18:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7EB611C1
	for <bpf@archiver.kernel.org>; Sat, 10 Jul 2021 18:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhGJSId (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 10 Jul 2021 14:08:33 -0400
Received: from mx1.riseup.net ([198.252.153.129]:50774 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229652AbhGJSId (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Jul 2021 14:08:33 -0400
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4GMdHb3vwnzDrhZ;
        Sat, 10 Jul 2021 11:05:47 -0700 (PDT)
X-Riseup-User-ID: 027C2E7FA9882A576F4230443E21B48C75A0196E4E75127C55D378DB13D2B2AC
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4GMdHZ5B8hz5vYk;
        Sat, 10 Jul 2021 11:05:46 -0700 (PDT)
To:     aarcange@redhat.com
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project, Inc
In-Reply-To: <20201104215702.GG24993@redhat.com>
Subject: Re: RFC: default to spec_store_bypass_disable=prctl
 spectre_v2_user=prctl
Message-ID: <55e3ba77-a305-8abb-1506-5a8aabe24bf3@torproject.org>
Date:   Sat, 10 Jul 2021 13:05:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Is anything happening with this proposal? Is there anything I could do 
to help it along?

My personal motivation is that I'm involved in developing and using the 
[Shadow] simulator, which we use to run hours and days long simulations. 
We're currently looking into running some simulations in gitlab CI 
Docker runner to take advantage of shared hardware, but Docker currently 
doesn't expose a way to opt out of these mitigations without turning off 
seccomp altogether [Docker FR].

I've measured these mitigations to cause simulations to take 50% longer 
[Overhead], so I'm pretty motivated to find a way to disable them :).

[Shadow]: https://shadow.github.io/
[Docker FR]: https://github.com/moby/moby/issues/42619
[Overhead]: 
https://github.com/shadow/shadow/issues/1489#issuecomment-871445482

P.S. Attempting to respond to a thread without actually being subscribed 
to the list; sorry if this ends up not threading correctly. The CC 
header was truncated so also some original recipients have been dropped. 
Original thread: https://lkml.org/lkml/2020/11/4/1135
