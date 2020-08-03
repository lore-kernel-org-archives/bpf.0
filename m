Return-Path: <SRS0=579k=BN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACFFC433DF
	for <bpf@archiver.kernel.org>; Mon,  3 Aug 2020 14:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8600F206DA
	for <bpf@archiver.kernel.org>; Mon,  3 Aug 2020 14:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgHCOIc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:08:32 -0400
Received: from www62.your-server.de ([213.133.104.62]:37962 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgHCOIb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 10:08:31 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k2b8Z-0005dr-Km; Mon, 03 Aug 2020 16:08:23 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k2b8Z-000Kb3-Fc; Mon, 03 Aug 2020 16:08:23 +0200
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, alexei.starovoitov@gmail.com,
        davem@davemloft.net
From:   Daniel Borkmann <daniel@iogearbox.net>
Subject: bpf-next is CLOSED
Message-ID: <be741b17-0785-19c5-242d-518abe29ae32@iogearbox.net>
Date:   Mon, 3 Aug 2020 16:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25892/Sun Aug  2 17:01:36 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The merge window is open right now, therefore please send bug fixes only at this
point. bpf-next will open back up in roughly 2 weeks after the merge window is
closed.

The last bpf-next PR will go out today to David after processing pending BPF items
from patchwork.

Thank you,
Daniel
