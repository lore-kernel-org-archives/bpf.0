Return-Path: <SRS0=AnqM=ZU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC3C432C0
	for <bpf@archiver.kernel.org>; Thu, 28 Nov 2019 04:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B12215F1
	for <bpf@archiver.kernel.org>; Thu, 28 Nov 2019 04:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ay9Pv77i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfK1E4m (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Nov 2019 23:56:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1E4m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Nov 2019 23:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CT/8odWIbACPFsKf6XX/RegMTNWLBmmF9UXx2vlp7QM=; b=Ay9Pv77iPLbsgsTnRZJCenSSn
        QsVROvIaJBvi+tic+gsujlcF2kpi6eMbe0D6qwOneUzG2ncuul+maE80Ub4/Gt0csSWswoOc597TZ
        Wq2HDCoo2Um/BMc+q7u/xhkK3K6iHD8jdblyHT5++RSvEjGjRvphQv4nY6jDKjXjAYzkc19VwRzFY
        tJUzl9Mv68erhy7dR7wH96W+1WZH1tRRuZuff5rDU2VlofyXftffwbmUGxMASh0fZvTo1etQt61GZ
        ENpTRk9ShYuZIFv4M2cgVp5tpxJ29gyhRMpMhe5LuH/oQTJtM5vfkCR8RSTap3GogItS/DKauRhTL
        C6wxuLlng==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaBr7-0001AE-3D; Thu, 28 Nov 2019 04:56:41 +0000
Subject: Re: [PATCH bpf] bpf: Fix build in minimal configurations
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20191128043508.2346723-1-ast@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b803cae0-4514-4239-4004-4c3090ca67c4@infradead.org>
Date:   Wed, 27 Nov 2019 20:56:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191128043508.2346723-1-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/27/19 8:35 PM, Alexei Starovoitov wrote:
> Some kconfigs can have BPF enabled without a single valid program type.
> In such configurations the build will fail with:
> ./kernel/bpf/btf.c:3466:1: error: empty enum is invalid
> 
> Fix it by adding unused value to the enum.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  kernel/bpf/btf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index bd5e11881ba3..7d40da240891 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3463,6 +3463,7 @@ enum {
>  	__ctx_convert##_id,
>  #include <linux/bpf_types.h>
>  #undef BPF_PROG_TYPE
> +	__ctx_convert_unused, /* to avoid empty enum in extreme .config */
>  };
>  static u8 bpf_ctx_convert_map[] = {
>  #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
> 


-- 
~Randy

