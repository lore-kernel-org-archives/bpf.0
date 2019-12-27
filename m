Return-Path: <SRS0=E1yZ=2R=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7469C2D0C3
	for <bpf@archiver.kernel.org>; Fri, 27 Dec 2019 23:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7801120838
	for <bpf@archiver.kernel.org>; Fri, 27 Dec 2019 23:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfL0X2l (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Dec 2019 18:28:41 -0500
Received: from www62.your-server.de ([213.133.104.62]:60732 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL0X2l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Dec 2019 18:28:41 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1ikz1y-00015B-PD; Sat, 28 Dec 2019 00:28:30 +0100
Received: from [185.105.41.29] (helo=linux-9.fritz.box)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1ikz1y-000Skt-ER; Sat, 28 Dec 2019 00:28:30 +0100
Subject: Re: pull-request: bpf-next 2019-12-27
To:     David Miller <davem@davemloft.net>
Cc:     jakub.kicinski@netronome.com, bjorn.topel@gmail.com,
        ast@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20191227180817.30438-1-daniel@iogearbox.net>
 <20191227.142042.195965541160730299.davem@davemloft.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1e43c387-aca8-57c4-9aea-3be0c34fd0cb@iogearbox.net>
Date:   Sat, 28 Dec 2019 00:28:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191227.142042.195965541160730299.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25676/Fri Dec 27 11:04:35 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/27/19 11:20 PM, David Miller wrote:
> From: Daniel Borkmann <daniel@iogearbox.net>
> Date: Fri, 27 Dec 2019 19:08:17 +0100
> 
>> The following pull-request contains BPF updates for your *net-next* tree.
> 
> Pulled and conflicts resolved as per your description, thanks!
> 
> I'll push out after some quick build testing.

Perfect, thanks a lot!
