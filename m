Return-Path: <SRS0=/NIo=RH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E0FC43381
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 09:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02DD220836
	for <bpf@archiver.kernel.org>; Mon,  4 Mar 2019 09:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfCDJp3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Mar 2019 04:45:29 -0500
Received: from www62.your-server.de ([213.133.104.62]:46770 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDJp3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Mar 2019 04:45:29 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h0kA3-0007Xz-J0; Mon, 04 Mar 2019 10:45:27 +0100
Received: from [2a02:1205:34ea:9e0:5681:e3d2:fbd:7e53] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h0kA3-000TaB-Ch; Mon, 04 Mar 2019 10:45:27 +0100
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, davem@davemloft.net,
        alexei.starovoitov@gmail.com
From:   Daniel Borkmann <daniel@iogearbox.net>
Subject: bpf-next is CLOSED
Message-ID: <c8b0e988-da43-8ee8-9bbf-6f50c4dd1ad1@iogearbox.net>
Date:   Mon, 4 Mar 2019 10:45:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25377/Sun Mar  3 11:37:14 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From this point onwards please only submit bug fixes targeted to bpf tree given
the merge window. We will send out the last bpf-next PR to David today.

Thanks everyone,
Daniel
