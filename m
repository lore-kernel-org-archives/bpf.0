Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CBEC433E0
	for <bpf@archiver.kernel.org>; Mon, 15 Mar 2021 16:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDAD64F2F
	for <bpf@archiver.kernel.org>; Mon, 15 Mar 2021 16:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhCOQZi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Mar 2021 12:25:38 -0400
Received: from www62.your-server.de ([213.133.104.62]:38776 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbhCOQZI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Mar 2021 12:25:08 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lLq1f-000CwE-8m; Mon, 15 Mar 2021 17:25:03 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lLq1f-000MKF-3T; Mon, 15 Mar 2021 17:25:03 +0100
Subject: Re: [PATCH] bpf: Add getter and setter for SO_REUSEPORT through
 bpf_{g,s}etsockopt
To:     Manu Bretelle <chantra@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
References: <20210310182305.1910312-1-chantra@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <13a467ce-7ca4-9a87-6a1d-b66948b9d01d@iogearbox.net>
Date:   Mon, 15 Mar 2021 17:25:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210310182305.1910312-1-chantra@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26109/Mon Mar 15 12:06:12 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/10/21 7:23 PM, Manu Bretelle wrote:
> Augment the current set of options that are accessible via
> bpf_{g,s}etsockopt to also support SO_REUSEPORT.
> 
> Signed-off-by: Manu Bretelle <chantra@fb.com>

Applied, thanks! I fixed up the 4 extra newlines:

> diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> index 115a3b0ad984..b65a5e2481e6 100644
> --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> @@ -57,6 +57,29 @@ static __inline int bind_to_device(struct bpf_sock_addr *ctx)
>   	return 0;
>   }
>   
> +static __inline int bind_reuseport(struct bpf_sock_addr *ctx)
> +{
> +

^^^ here

> +	int val = 1;
> +
> +	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
> +			   &val, sizeof(val)))
> +		return 1;
> +	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
> +			   &val, sizeof(val)) || !val)
> +		return 1;
> +	val = 0;
> +	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
> +			   &val, sizeof(val)))
> +		return 1;
> +	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
> +			   &val, sizeof(val)) || val)
> +		return 1;
> +
> +

^^^ here

> +	return 0;
> +}
> +
>   static __inline int misc_opts(struct bpf_sock_addr *ctx, int opt)
>   {
[...]
> diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
> index 4c0d348034b9..68e7ede67b6d 100644
> --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> @@ -63,6 +63,29 @@ static __inline int bind_to_device(struct bpf_sock_addr *ctx)
>   	return 0;
>   }
>   
> +static __inline int bind_reuseport(struct bpf_sock_addr *ctx)
> +{
> +

^^^ here

> +	int val = 1;
> +
> +	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
> +			   &val, sizeof(val)))
> +		return 1;
> +	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
> +			   &val, sizeof(val)) || !val)
> +		return 1;
> +	val = 0;
> +	if (bpf_setsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
> +			   &val, sizeof(val)))
> +		return 1;
> +	if (bpf_getsockopt(ctx, SOL_SOCKET, SO_REUSEPORT,
> +			   &val, sizeof(val)) || val)
> +		return 1;
> +
> +

^^^ here

> +	return 0;
> +}
> +
>   static __inline int misc_opts(struct bpf_sock_addr *ctx, int opt)
>   {
>   	int old, tmp, new = 0xeb9f;
