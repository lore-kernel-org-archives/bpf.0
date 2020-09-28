Return-Path: <SRS0=5TR3=DF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA7CC2D0A8
	for <bpf@archiver.kernel.org>; Mon, 28 Sep 2020 21:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93FD2100A
	for <bpf@archiver.kernel.org>; Mon, 28 Sep 2020 21:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgI1VdF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Sep 2020 17:33:05 -0400
Received: from www62.your-server.de ([213.133.104.62]:35526 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgI1VdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 17:33:05 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kN0lb-0002Ff-Bi; Mon, 28 Sep 2020 23:33:03 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kN0la-000Rm8-ID; Mon, 28 Sep 2020 23:33:03 +0200
Subject: Re: [PATCH bpf-next] bpf: cpumap: remove rcpu pointer from
 cpu_map_build_skb signature
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, brouer@redhat.com,
        lorenzo.bianconi@redhat.com
References: <33cb9b7dc447de3ea6fd6ce713ac41bca8794423.1601292015.git.lorenzo@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f74f7b21-bba2-a26d-b66d-9cb5f26b5e04@iogearbox.net>
Date:   Mon, 28 Sep 2020 23:32:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <33cb9b7dc447de3ea6fd6ce713ac41bca8794423.1601292015.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25941/Mon Sep 28 15:55:11 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/28/20 1:24 PM, Lorenzo Bianconi wrote:
> Get rid of bpf_cpu_map_entry pointer in cpu_map_build_skb routine
> signature since it is no longer needed
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Applied, thanks!
