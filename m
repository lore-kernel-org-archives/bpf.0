Return-Path: <SRS0=rZCH=SH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA56C4360F
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 15:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1BD217D4
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 15:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfDEPDe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:03:34 -0400
Received: from www62.your-server.de ([213.133.104.62]:60614 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDEPDe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Apr 2019 11:03:34 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hCQNL-0005Yv-Pp; Fri, 05 Apr 2019 17:03:28 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hCQNL-000Px6-Kp; Fri, 05 Apr 2019 17:03:27 +0200
Subject: Re: [PATCH bpf-next] samples/bpf: fix build with new clang
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
References: <20190404213714.2800997-1-ast@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3cd94b55-acb7-b4d3-cedd-55b11fd7bd53@iogearbox.net>
Date:   Fri, 5 Apr 2019 17:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190404213714.2800997-1-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25410/Fri Apr  5 09:58:26 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/04/2019 11:37 PM, Alexei Starovoitov wrote:
> clang started to error on invalid asm clobber usage in x86 headers
> and many bpf program samples failed to build with the message:
> 
>   CLANG-bpf  /data/users/ast/bpf-next/samples/bpf/xdp_redirect_kern.o
> In file included from /data/users/ast/bpf-next/samples/bpf/xdp_redirect_kern.c:14:
> In file included from ../include/linux/in.h:23:
> In file included from ../include/uapi/linux/in.h:24:
> In file included from ../include/linux/socket.h:8:
> In file included from ../include/linux/uio.h:14:
> In file included from ../include/crypto/hash.h:16:
> In file included from ../include/linux/crypto.h:26:
> In file included from ../include/linux/uaccess.h:5:
> In file included from ../include/linux/sched.h:15:
> In file included from ../include/linux/sem.h:5:
> In file included from ../include/uapi/linux/sem.h:5:
> In file included from ../include/linux/ipc.h:9:
> In file included from ../include/linux/refcount.h:72:
> ../arch/x86/include/asm/refcount.h:72:36: error: asm-specifier for input or output variable conflicts with asm clobber list
>                                          r->refs.counter, e, "er", i, "cx");
>                                                                       ^
> ../arch/x86/include/asm/refcount.h:86:27: error: asm-specifier for input or output variable conflicts with asm clobber list
>                                          r->refs.counter, e, "cx");
>                                                              ^
> 2 errors generated.
> 
> Override volatile() to workaround the problem.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Applied, thanks!
