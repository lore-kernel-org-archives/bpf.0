Return-Path: <SRS0=Zphp=SL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40808C282E0
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 09:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1B621473
	for <bpf@archiver.kernel.org>; Tue,  9 Apr 2019 09:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfDIJsz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:48:55 -0400
Received: from www62.your-server.de ([213.133.104.62]:36258 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJsz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Apr 2019 05:48:55 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDnN7-0001oi-8l; Tue, 09 Apr 2019 11:48:53 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hDnN7-000EsO-1z; Tue, 09 Apr 2019 11:48:53 +0200
Subject: Re: [PATCH bpf-next] selftests: bpf: add VRF test cases to
 lwt_ip_encap test.
To:     David Ahern <dsahern@gmail.com>, Peter Oskolkov <posk@google.com>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Peter Oskolkov <posk@posk.io>
References: <20190403154338.29990-1-posk@google.com>
 <89f72dd4-a3d8-3788-482b-578e18b7078d@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <07f9be8a-7856-8b68-f085-b72c0e880a05@iogearbox.net>
Date:   Tue, 9 Apr 2019 11:48:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <89f72dd4-a3d8-3788-482b-578e18b7078d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25414/Tue Apr  9 09:53:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/05/2019 04:32 AM, David Ahern wrote:
> On 4/3/19 9:43 AM, Peter Oskolkov wrote:
>> This patch adds tests validating that VRF and BPF-LWT
>> encap work together well, as requested by David Ahern.
>>
>> Signed-off-by: Peter Oskolkov <posk@google.com>
>> ---
>>  .../selftests/bpf/test_lwt_ip_encap.sh        | 134 +++++++++++-------
>>  1 file changed, 86 insertions(+), 48 deletions(-)
>>
> 
> I hit a wall with running this script. One problem is the different
> versions of nc for debian (stretch to be specific), and another problem
> is commands failing it is hard to figure out why (e.g., connect failures
> which seem like route lookup problems). I have been adding run_cmd and
> PAUSE_ON_FAIL options similar to what is in fib_tests.sh and the change
> I sent for pmtu.sh, but I have not finished.
> 
> I am traveling tomorrow and not sure how much time I'll get this weekend
> to come back to this. Might be early next week.

Hi David, any progress on the above?

Thanks,
Daniel
