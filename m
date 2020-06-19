Return-Path: <SRS0=nKFI=AA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2FDC433E0
	for <bpf@archiver.kernel.org>; Fri, 19 Jun 2020 22:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E84E222E8
	for <bpf@archiver.kernel.org>; Fri, 19 Jun 2020 22:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgFSW2k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:28:40 -0400
Received: from www62.your-server.de ([213.133.104.62]:39376 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbgFSW2k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jun 2020 18:28:40 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jmPV0-0007TG-08; Sat, 20 Jun 2020 00:28:38 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jmPUz-000QAR-Mz; Sat, 20 Jun 2020 00:28:37 +0200
Subject: Re: [PATCH bpf-next] tools/bpftool: relicense bpftool's BPF profiler
 prog as dual-license GPL/BSD
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20200619222024.519774-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fbde3901-d287-1e68-2648-be2f2d68b8c3@iogearbox.net>
Date:   Sat, 20 Jun 2020 00:28:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200619222024.519774-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25848/Fri Jun 19 15:01:57 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/20/20 12:20 AM, Andrii Nakryiko wrote:
> Relicense it to be compatible with the rest of bpftool files.
> 
> Cc: Song Liu <songliubraving@fb.com>
> Suggested-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
