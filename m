Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3957DC282DA
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0680020821
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfDPI0N (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:26:13 -0400
Received: from www62.your-server.de ([213.133.104.62]:58960 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDPI0N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 04:26:13 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJPr-00062x-Co; Tue, 16 Apr 2019 10:26:07 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJPr-000Jk2-4G; Tue, 16 Apr 2019 10:26:07 +0200
Subject: Re: [PATCH bpf-next] kbuild: handle old pahole more gracefully when
 generating BTF
To:     andrii.nakryiko@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com, davem@davemloft.net
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
References: <20190415215839.1895340-1-andrii.nakryiko@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1f622dd9-35c9-3274-abd6-f1d1bcbe2745@iogearbox.net>
Date:   Tue, 16 Apr 2019 10:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190415215839.1895340-1-andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25420/Mon Apr 15 09:57:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/15/2019 11:58 PM, andrii.nakryiko@gmail.com wrote:
> From: Andrii Nakryiko <andriin@fb.com>
> 
> When CONFIG_DEBUG_INFO_BTF is enabled but available version of pahole is too
> old to support BTF generation, build script is supposed to emit warning and
> proceed with the build. Due to using exit instead of return from BASH function,
> existing handling code prematurely exits exit code 0, not completing some of
> the build steps. This patch fixes issue by correctly returning just from
> gen_btf() function only.
> 
> Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
