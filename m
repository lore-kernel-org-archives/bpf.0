Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58084C77B73
	for <bpf@archiver.kernel.org>; Fri, 28 Apr 2023 01:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344432AbjD1BQv (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Apr 2023 21:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjD1BQu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 21:16:50 -0400
Received: from out-23.mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9726BA
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 18:16:48 -0700 (PDT)
Message-ID: <1c06f0cd-68f7-17d9-2f78-481689c04ae4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682644607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4GvX/0oGjMptBTKVrOOgA8/mSjoENnBJqUySYMUM84=;
        b=Y2zXcVlSCjParkDuSBPaqh/aPsVaM/H9HrCk7y6qh1Ae5hNf1JUvL240SnL3kufFwPAKd3
        PeNiSI+nRgaAee9MUQTmNZ7uADptXX2jCuU97rRzoqBuSeb5syTl9v1FrlORiPCpDYaIMc
        mYk5IWtgJmSJaUYvobbFxkImyOsoupY=
Date:   Thu, 27 Apr 2023 18:16:45 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: btf_dump_type_data_check_overflow needs
 to consider BTF_MEMBER_BITFIELD_SIZE
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20230428010839.1328507-1-martin.lau@linux.dev>
In-Reply-To: <20230428010839.1328507-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/27/23 6:08 PM, Martin KaFai Lau wrote:
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 580985ee5545..8f659ec8798d 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -2250,9 +2250,19 @@ static int btf_dump_type_data_check_overflow(struct btf_dump *d,
>   					     const struct btf_type *t,
>   					     __u32 id,
>   					     const void *data,
> -					     __u8 bits_offset)
> +					     __u8 bits_offset,
> +					     __u8 bit_sz)
>   {
> -	__s64 size = btf__resolve_size(d->btf, id);
> +	__s64 size;
> +
> +	if (bit_sz) {
> +		/* bits_offset is at most 7. bit_sz is at most 128. */
> +		__u8 nr_bytes = (bits_offset + bit_sz + 7) / 8;
> +
> +		return data + nr_bytes > d->typed_dump->data_end ? -E2BIG : 0;

hmm...returning 0 here is not very correct. nr_bytes should be returned instead, 
although does not seem anyone is using the value. will post v2.

> +	}
> +
> +	size = btf__resolve_size(d->btf, id);

