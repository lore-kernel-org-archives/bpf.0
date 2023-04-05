Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC77C6FD1D
	for <bpf@archiver.kernel.org>; Wed,  5 Apr 2023 00:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbjDEALB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 4 Apr 2023 20:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjDEALA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 20:11:00 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5604224
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 17:10:58 -0700 (PDT)
Message-ID: <eb07aa5a-e44c-67b7-e9c9-bd65602680ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680653456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pI/qjDgoSqxgaYlHstx2idRdrUQGA4h8mGEgGSebTfw=;
        b=I1K9m/s/Oyz+3RDoZAXi/9rYjRSX4VvriFpuVN4zJj95t4RYGUqyD+uG1PMXGDLQN6gtCa
        xtCtaauyciyoBZT4kPeQmf4nOVfibAcelnFnlXPuVF9G+rPAqc9sk73pDv+cERNEdoMkta
        T7JjWbIPOpU9x9t2WdUzq/VEuEO/xZo=
Date:   Tue, 4 Apr 2023 17:10:49 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/8] bpf: Teach verifier that certain helpers
 accept NULL pointer.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        void@manifault.com, davemarchevsky@meta.com, tj@kernel.org,
        memxor@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com, davem@davemloft.net
References: <20230404045029.82870-1-alexei.starovoitov@gmail.com>
 <20230404045029.82870-5-alexei.starovoitov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230404045029.82870-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/3/23 9:50 PM, Alexei Starovoitov wrote:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1f2abf0f60e6..727c5269867d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4998,7 +4998,7 @@ const struct bpf_func_proto bpf_get_socket_ptr_cookie_proto = {
>   	.func		= bpf_get_socket_ptr_cookie,
>   	.gpl_only	= false,
>   	.ret_type	= RET_INTEGER,
> -	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> +	.arg1_type	= ARG_PTR_TO_BTF_ID_SOCK_COMMON | PTR_MAYBE_NULL,

I think the bpf_skc_to_* helpers (eg. bpf_skc_to_tcp_sock) also need similar 
change. They are available to tracing also. It can be a follow-up. The patch set 
lgtm.
