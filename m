Return-Path: <SRS0=Oi1G=6O=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D12C83000
	for <bpf@archiver.kernel.org>; Thu, 30 Apr 2020 01:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F1D2082E
	for <bpf@archiver.kernel.org>; Thu, 30 Apr 2020 01:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD3BtK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:49:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3388 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbgD3BtK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Apr 2020 21:49:10 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8CDD71E68C8BD1707E1E;
        Thu, 30 Apr 2020 09:49:08 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.154) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 09:49:07 +0800
Subject: Re: [PATCH bpf-next] libbpf: fix false unused variable warning
To:     Andrii Nakryiko <andriin@fb.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <ast@fb.com>, <daniel@iogearbox.net>
References: <20200430012544.1347275-1-andriin@fb.com>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <b04c3fe3-3c96-d4d5-cdc1-283baedb6c29@huawei.com>
Date:   Thu, 30 Apr 2020 09:49:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200430012544.1347275-1-andriin@fb.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 2020/4/30 9:25, Andrii Nakryiko wrote:
> Some versions of GCC falsely detect that vi might not be initialized. That's
> not true, but let's silence it with NULL initialization.
> 

This title seems not appropriate, 'unused' --> 'initialized' ?

> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index d86ff8214b96..977add1b73e2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5003,8 +5003,8 @@ static int bpf_object__collect_map_relos(struct bpf_object *obj,
>  					 GElf_Shdr *shdr, Elf_Data *data)
>  {
>  	int i, j, nrels, new_sz, ptr_sz = sizeof(void *);
> +	const struct btf_var_secinfo *vi = NULL;
>  	const struct btf_type *sec, *var, *def;
> -	const struct btf_var_secinfo *vi;
>  	const struct btf_member *member;
>  	struct bpf_map *map, *targ_map;
>  	const char *name, *mname;
> 

