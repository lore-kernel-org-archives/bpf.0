Return-Path: <SRS0=qFa8=AG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F8FC433E1
	for <bpf@archiver.kernel.org>; Thu, 25 Jun 2020 15:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE5420775
	for <bpf@archiver.kernel.org>; Thu, 25 Jun 2020 15:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405701AbgFYPBo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:01:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:33038 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405502AbgFYPBn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jun 2020 11:01:43 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1joTNl-0004JI-4m; Thu, 25 Jun 2020 17:01:41 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1joTNk-000FIn-St; Thu, 25 Jun 2020 17:01:40 +0200
Subject: Re: [bpf PATCH] bpf: Do not allow btf_ctx_access with __int128 types
To:     John Fastabend <john.fastabend@gmail.com>, jolsa@kernel.org,
        andrii.nakryiko@gmail.com, ast@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
References: <159303723962.11287.13309537171132420717.stgit@john-Precision-5820-Tower>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d53db444-8473-a48c-179f-4baf13a97674@iogearbox.net>
Date:   Thu, 25 Jun 2020 17:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <159303723962.11287.13309537171132420717.stgit@john-Precision-5820-Tower>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25854/Thu Jun 25 15:16:08 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 6/25/20 12:20 AM, John Fastabend wrote:
> To ensure btf_ctx_access() is safe the verifier checks that the BTF
> arg type is an int, enum, or pointer. When the function does the
> BTF arg lookup it uses the calculation 'arg = off / 8'  using the
> fact that registers are 8B. This requires that the first arg is
> in the first reg, the second in the second, and so on. However,
> for __int128 the arg will consume two registers by default LLVM
> implementation. So this will cause the arg layout assumed by the
> 'arg = off / 8' calculation to be incorrect.
> 
> Because __int128 is uncommon this patch applies the easiest fix and
> will force int types to be sizeof(u64) or smaller so that they will
> fit in a single register.
> 
> v2: remove unneeded parens per Andrii's feedback
> 
> Fixes: 9e15db66136a1 ("bpf: Implement accurate raw_tp context access via BTF")
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Applied, thanks!
