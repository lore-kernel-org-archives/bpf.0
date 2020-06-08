Return-Path: <SRS0=G29D=7V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138A5C433E0
	for <bpf@archiver.kernel.org>; Mon,  8 Jun 2020 14:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5092076C
	for <bpf@archiver.kernel.org>; Mon,  8 Jun 2020 14:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgFHORE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:17:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:38190 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgFHORE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 10:17:04 -0400
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jiIaE-0006yd-9r; Mon, 08 Jun 2020 16:17:02 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jiIaE-000Kgh-1K; Mon, 08 Jun 2020 16:17:02 +0200
Subject: Re: [PATCH bpf] selftests/bpf: fix ringbuf selftest sample counting
 undeterminism
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200608003615.3549991-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0e7cc718-9af1-a89a-d799-31cb1a83a6a9@iogearbox.net>
Date:   Mon, 8 Jun 2020 16:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200608003615.3549991-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25837/Mon Jun  8 14:50:11 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/8/20 2:36 AM, Andrii Nakryiko wrote:
> Fix test race, in which background poll can get either 5 or 6 samples,
> depending on timing of notification. Prevent this by open-coding sample
> triggering and forcing notification for the very last sample only.
> 
> Also switch to using atomic increments and exchanges for more obviously
> reliable counting and checking. Additionally, check expected processed sample
> counters for single-threaded use cases as well.
> 
> Fixes: 9a5f25ad30e5 ("selftests/bpf: Fix sample_cnt shared between two threads")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
