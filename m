Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE9DC4332B
	for <bpf@archiver.kernel.org>; Wed,  3 Mar 2021 22:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B65F64EFD
	for <bpf@archiver.kernel.org>; Wed,  3 Mar 2021 22:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449541AbhCCWwI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:52:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:3026 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235921AbhCCQhG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Mar 2021 11:37:06 -0500
IronPort-SDR: 8d+yTfKVAXyAcR7jPBSU4BCbS1E17XnTE59WY3MTrt7cRRw/s6PnpIVsF1aklmvRAREl2qqveX
 gsoAHbUMjtcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="167126992"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="167126992"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:33:20 -0800
IronPort-SDR: zvVoBXWCVPH7UasWm9ojZhJbOWpCUVfjlA0aYlqeeaJ5IvJVBWvlQwhR4j/JTpHY84KeTtcppc
 ahmigwhPHzeQ==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="407308383"
Received: from jdibley-mobl1.ger.corp.intel.com (HELO btopel-mobl.ger.intel.com) ([10.252.61.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:33:17 -0800
Subject: Re: [PATCH bpf 3/3] libbpf: clear map_info before each
 bpf_obj_get_info_by_fd
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, john.fastabend@gmail.com
References: <20210303155158.15953-1-maciej.fijalkowski@intel.com>
 <20210303155158.15953-4-maciej.fijalkowski@intel.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>
Message-ID: <9838f0ef-7430-e2b2-4146-5ec6c9c807bd@intel.com>
Date:   Wed, 3 Mar 2021 17:33:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303155158.15953-4-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-03-03 16:51, Maciej Fijalkowski wrote:
> xsk_lookup_bpf_maps, based on prog_fd, looks whether current prog has a
> reference to XSKMAP. BPF prog can include insns that work on various BPF
> maps and this is covered by iterating through map_ids.
> 
> The bpf_map_info that is passed to bpf_obj_get_info_by_fd for filling
> needs to be cleared at each iteration, so that it doesn't contain any
> outdated fields and that is currently missing in the function of
> interest.
> 
> To fix that, zero-init map_info via memset before each
> bpf_obj_get_info_by_fd call.
> 
> Also, since the area of this code is touched, in general strcmp is
> considered harmful, so let's convert it to strncmp and provide the
> length of the array name from current map_info.
> 
> Last but not least, do s/continue/break/ once we have found the xsks_map
> to terminate the search.
> 
> Fixes: 5750902a6e9b ("libbpf: proper XSKMAP cleanup")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   tools/lib/bpf/xsk.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
> index ffbb588724d8..e56b2d76efc2 100644
> --- a/tools/lib/bpf/xsk.c
> +++ b/tools/lib/bpf/xsk.c
> @@ -610,15 +610,16 @@ static int xsk_lookup_bpf_maps(struct xsk_socket *xsk)
>   		if (fd < 0)
>   			continue;
>   
> +		memset(&map_info, 0, map_len);
>   		err = bpf_obj_get_info_by_fd(fd, &map_info, &map_len);
>   		if (err) {
>   			close(fd);
>   			continue;
>   		}
>   
> -		if (!strcmp(map_info.name, "xsks_map")) {
> +		if (!strncmp(map_info.name, "xsks_map", strlen(map_info.name))) {

This should be sizeof(map_info.name) and not strlen, otherwise it's kind
of useless! :-P


Björn

>   			ctx->xsks_map_fd = fd;
> -			continue;
> +			break;
>   		}
>   
>   		close(fd);
> 
