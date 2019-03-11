Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02B2C43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 09:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C852A2075C
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 09:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCKJos (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:44:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:46502 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfCKJos (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 05:44:48 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3HUA-0000uJ-Sm; Mon, 11 Mar 2019 10:44:42 +0100
Received: from [178.197.249.29] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h3HUA-000Etu-M8; Mon, 11 Mar 2019 10:44:42 +0100
Subject: Re: [PATCH bpf] libbpf: handle BTF parsing and loading properly
To:     Andrii Nakryiko <andriin@fb.com>, andrii.nakryiko@gmail.com,
        kernel-team@fb.com, ast@fb.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, tehnerd@tehnerd.com
References: <20190308235820.3854596-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <04d73b67-feb2-13b9-5daf-47b335bd80be@iogearbox.net>
Date:   Mon, 11 Mar 2019 10:44:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190308235820.3854596-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25385/Mon Mar 11 08:43:35 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/09/2019 12:58 AM, Andrii Nakryiko wrote:
> This patch splits and cleans up error handling logic for loading BTF data.
> Previously, if BTF data was parsed successfully, but failed to load into
> kernel, we'd report nonsensical error code, instead of error returned from
> btf__load(). Now btf__new() and btf__load() are handled separately with proper
> cleanup and warning reporting.
> 
> Fixes: d29d87f7e612 ("btf: separate btf creation and loading")
> Reported-by: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
