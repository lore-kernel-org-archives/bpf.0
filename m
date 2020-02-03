Return-Path: <SRS0=gOi6=3X=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B08EC35247
	for <bpf@archiver.kernel.org>; Mon,  3 Feb 2020 23:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E4B20732
	for <bpf@archiver.kernel.org>; Mon,  3 Feb 2020 23:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgBCXK3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 3 Feb 2020 18:10:29 -0500
Received: from www62.your-server.de ([213.133.104.62]:40660 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCXK3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Feb 2020 18:10:29 -0500
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iykrK-0002ZK-R6; Tue, 04 Feb 2020 00:10:26 +0100
Received: from [178.197.249.21] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1iykrK-000T5X-Gc; Tue, 04 Feb 2020 00:10:26 +0100
Subject: Re: [PATCH bpf] bpftool: Remove redundant "HAVE" prefix from the
 large INSN limit check
To:     Michal Rostecki <mrostecki@opensuse.org>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200202110200.31024-1-mrostecki@opensuse.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <66fc14f9-5147-7075-8b6c-99939fd68f79@iogearbox.net>
Date:   Tue, 4 Feb 2020 00:10:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200202110200.31024-1-mrostecki@opensuse.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25715/Mon Feb  3 12:37:20 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/2/20 12:02 PM, Michal Rostecki wrote:
> "HAVE" prefix is already applied by default to feature macros and before
> this change, the large INSN limit macro had the incorrect name with
> double "HAVE".
> 
> Fixes: 2faef64aa6b3 ("bpftool: Add misc section and probe for large INSN limit")
> Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>

Applied, thanks!
