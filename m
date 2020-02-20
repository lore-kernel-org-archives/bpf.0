Return-Path: <SRS0=tRXP=4I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B294C7619D
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 00:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB96124671
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 00:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBTAUN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:20:13 -0500
Received: from www62.your-server.de ([213.133.104.62]:55976 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgBTAUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 19:20:13 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1j4ZZZ-0007T3-CJ; Thu, 20 Feb 2020 01:20:09 +0100
Received: from [85.7.42.192] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1j4ZZZ-000PXz-4y; Thu, 20 Feb 2020 01:20:09 +0100
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build of sockmap_ktls.c
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
References: <20200219205514.3353788-1-ast@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <512d3233-f3a7-ba66-70ce-5762ed962f17@iogearbox.net>
Date:   Thu, 20 Feb 2020 01:20:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200219205514.3353788-1-ast@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.1/25728/Wed Feb 19 15:06:20 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/19/20 9:55 PM, Alexei Starovoitov wrote:
> The selftests fails to build with:
> tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c: In function ‘test_sockmap_ktls_disconnect_after_delete’:
> tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c:72:37: error: ‘TCP_ULP’ undeclared (first use in this function)
>     72 |  err = setsockopt(cli, IPPROTO_TCP, TCP_ULP, "tls", strlen("tls"));
>        |                                     ^~~~~~~
> 
> Similar to commit that fixes build of sockmap_basic.c on systems with old
> /usr/include fix the build of sockmap_ktls.c
> 
> Fixes: d1ba1204f2ee ("selftests/bpf: Test unhashing kTLS socket after removing from map")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Applied, thanks!
