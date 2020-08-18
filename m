Return-Path: <SRS0=j30r=B4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DE3C433E1
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 08:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEAB72067C
	for <bpf@archiver.kernel.org>; Tue, 18 Aug 2020 08:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgHRIig (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:38:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:59534 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHRIie (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Aug 2020 04:38:34 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k7x8b-0004lS-DX; Tue, 18 Aug 2020 10:38:33 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k7x8b-000PcQ-80; Tue, 18 Aug 2020 10:38:33 +0200
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, alexei.starovoitov@gmail.com
From:   Daniel Borkmann <daniel@iogearbox.net>
Subject: bpf-next is OPEN
Message-ID: <63938a34-9df2-ec30-54a3-4acc51eab011@iogearbox.net>
Date:   Tue, 18 Aug 2020 10:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25904/Mon Aug 17 15:02:24 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

And we're back open. ;-)

Thanks,
Daniel
