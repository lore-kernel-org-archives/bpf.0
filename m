Return-Path: <SRS0=579k=BN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713DAC433DF
	for <bpf@archiver.kernel.org>; Mon,  3 Aug 2020 14:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570BA206D4
	for <bpf@archiver.kernel.org>; Mon,  3 Aug 2020 14:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgHCOdY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:33:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:42952 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOdX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 10:33:23 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k2bWb-00089n-50; Mon, 03 Aug 2020 16:33:13 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k2bWa-0008QJ-56; Mon, 03 Aug 2020 16:33:12 +0200
Subject: Re: [PATCH] tools/bpf/bpftool: Fix wrong return value in do_dump()
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, ast@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        quentin@isovalent.com, kuba@kernel.org, toke@redhat.com,
        tklauser@distanz.ch, jolsa@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
References: <20200802111540.5384-1-tianjia.zhang@linux.alibaba.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <31eeb5d8-160a-64b8-9a39-a28add59ec74@iogearbox.net>
Date:   Mon, 3 Aug 2020 16:33:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200802111540.5384-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25892/Sun Aug  2 17:01:36 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/2/20 1:15 PM, Tianjia Zhang wrote:
> In case of btf_id does not exist, a negative error code -ENOENT
> should be returned.
> 
> Fixes: c93cc69004df3 ("bpftool: add ability to dump BTF types")
> Cc: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Applied, thanks!
