Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C094C6FD1D
	for <bpf@archiver.kernel.org>; Fri, 17 Mar 2023 18:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCQSoi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 Mar 2023 14:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCQSoh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 14:44:37 -0400
Received: from out-52.mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F60C6C6A8
        for <bpf@vger.kernel.org>; Fri, 17 Mar 2023 11:44:35 -0700 (PDT)
Message-ID: <228648b6-c6f0-d194-2e72-c7aaf095a35d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679078674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xGZ0+34EXbGkT+gCmcTBGlemT7GP2Mt/CBbucp6vbQc=;
        b=hE5m1avh56a1Vk23aCr4p2iaAeEVialyHDR77sNT2TlDVEpDHs/RPBLy3T5XZhc/kr7daN
        5kVwI5iy/uY9CFyifjj/uAHg+pRrk2aZWeqAjCuYJeQ8FZZYPuJ6Z5Mu9lMR9QuuyanjdA
        +B1vcLhP0qdHgNRYyiRtkPMegUMqABo=
Date:   Fri, 17 Mar 2023 11:44:30 -0700
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 4/8] libbpf: Create a bpf_link in
 bpf_map__attach_struct_ops().
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230316023641.2092778-1-kuifeng@meta.com>
 <20230316023641.2092778-5-kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, sdf@google.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230316023641.2092778-5-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/15/23 7:36 PM, Kui-Feng Lee wrote:
> @@ -11590,31 +11631,32 @@ struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_map *map)
>   	if (!link)
>   		return libbpf_err_ptr(-EINVAL);
>   
> -	st_ops = map->st_ops;
> -	for (i = 0; i < btf_vlen(st_ops->type); i++) {
> -		struct bpf_program *prog = st_ops->progs[i];
> -		void *kern_data;
> -		int prog_fd;
> +	/* kern_vdata should be prepared during the loading phase. */
> +	err = bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0);
> +	if (err) {

It should not fail for BPF_F_LINK struct_ops when err is EBUSY.
The struct_ops map can attach, detach, and then attach again.

It needs a test for this case.

> +		free(link);
> +		return libbpf_err_ptr(err);
> +	}

