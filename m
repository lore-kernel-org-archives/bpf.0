Return-Path: <SRS0=zGgN=4G=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF201C34026
	for <bpf@archiver.kernel.org>; Tue, 18 Feb 2020 15:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D48F207FD
	for <bpf@archiver.kernel.org>; Tue, 18 Feb 2020 15:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgBRPJa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:09:30 -0500
Received: from www62.your-server.de ([213.133.104.62]:54206 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBRPJa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Feb 2020 10:09:30 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j44V6-0003XI-56; Tue, 18 Feb 2020 16:09:28 +0100
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux-3.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j44V5-000P2H-Sw; Tue, 18 Feb 2020 16:09:27 +0100
Subject: Re: [PATCH bpf-next] bpf: allow bpf_perf_event_read_value in all BPF
 programs
To:     Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kernel-team@fb.com, ast@kernel.org, Yonghong Song <yhs@fb.com>
References: <20200214234146.2910011-1-songliubraving@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9bd8fd7e-845e-abc0-b656-552294991117@iogearbox.net>
Date:   Tue, 18 Feb 2020 16:09:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200214234146.2910011-1-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.1/25727/Tue Feb 18 15:05:00 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/15/20 12:41 AM, Song Liu wrote:
> bpf_perf_event_read_value() is NMI safe. Enable it for all BPF programs.
> This can be used in fentry/fexit to profile BPF program and individual
> kernel function with hardware counters.
> 
> Cc: Yonghong Song <yhs@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

And ironically, we had that already for perf_event_read. Applied, thanks!
