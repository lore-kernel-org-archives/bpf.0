Return-Path: <SRS0=293s=AV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6615DC433E7
	for <bpf@archiver.kernel.org>; Fri, 10 Jul 2020 14:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB1F20674
	for <bpf@archiver.kernel.org>; Fri, 10 Jul 2020 14:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgGJO3J (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:29:09 -0400
Received: from www62.your-server.de ([213.133.104.62]:45460 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgGJO3J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jul 2020 10:29:09 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jtu1U-0003Q4-0U; Fri, 10 Jul 2020 16:29:08 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jtu1T-000O43-Qj; Fri, 10 Jul 2020 16:29:07 +0200
Subject: Re: [PATCH bpf-next] libbpf: fix memory leak and optimize BTF
 sanitization
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200710011023.1655008-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <102d6d82-5acb-da0b-824b-452d8315957d@iogearbox.net>
Date:   Fri, 10 Jul 2020 16:29:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200710011023.1655008-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25868/Thu Jul  9 15:58:00 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/10/20 3:10 AM, Andrii Nakryiko wrote:
> Coverity's static analysis helpfully reported a memory leak introduced by
> 0f0e55d8247c ("libbpf: Improve BTF sanitization handling"). While fixing it,
> I realized that btf__new() already creates a memory copy, so there is no need
> to do this. So this patch also fixes misleading btf__new() signature to make
> data into a `const void *` input parameter. And it avoids unnecessary memory
> allocation and copy in BTF sanitization code altogether.
> 
> Fixes: 0f0e55d8247c ("libbpf: Improve BTF sanitization handling")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

LGTM, applied, thanks!
