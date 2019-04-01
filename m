Return-Path: <SRS0=vda1=SD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D60DC43381
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 15:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5528B20880
	for <bpf@archiver.kernel.org>; Mon,  1 Apr 2019 15:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfDAPig (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:38:36 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:55230 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbfDAPif (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Apr 2019 11:38:35 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from webmail.solarflare.com (webmail.solarflare.com [12.187.104.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1-us4.ppe-hosted.com (Proofpoint Essentials ESMTP Server) with ESMTPS id 5EC9C2800A7;
        Mon,  1 Apr 2019 15:38:34 +0000 (UTC)
Received: from [10.17.20.203] (10.17.20.203) by ocex03.SolarFlarecom.com
 (10.20.40.36) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 1 Apr
 2019 08:38:30 -0700
Subject: Re: [PATCH bpf-next 3/7] bpf: improve verification speed by not
 remarking live_read
To:     Alexei Starovoitov <ast@kernel.org>, <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <jakub.kicinski@netronome.com>,
        <jannh@google.com>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <20190330001612.2354959-1-ast@kernel.org>
 <20190330001612.2354959-4-ast@kernel.org>
From:   Edward Cree <ecree@solarflare.com>
Message-ID: <4b3f4129-f787-d9e4-164c-f7d6484bdd55@solarflare.com>
Date:   Mon, 1 Apr 2019 16:38:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190330001612.2354959-4-ast@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.17.20.203]
X-TM-AS-Product-Ver: SMEX-12.5.0.1300-8.5.1010-24524.005
X-TM-AS-Result: No-7.485900-4.000000-10
X-TMASE-MatchedRID: csPTYAMX1+EOwH4pD14DsPHkpkyUphL9si3nm+6QLrz9Rt5WzFri/U39
        pXYjpT7kJZ4YH1MNGFJ+rXJ8lGaYaiIOuxx4sxXhLhKcTQVB5mmZf5btvM85ATl4J33GJ8zNsVa
        zO0N7rQ42zcW60/uLtByKB+Y+BqlAYlldA0POS1Lil2r2x2PwtSlayzmQ9QV0SZV6zWnCdrk1It
        q0yDsRho2F8Z4vmnH7kZOl7WKIImrvXOvQVlExsFZ0V5tYhzdWxEHRux+uk8ifEzJ5hPndGY6jT
        lohEeKiX7UowmHm8KG18c9JJNe2rVs8SQvP1LzSLkvEsK0USX+Z/QF7v6A8VYA4S3f8Qx98bLJx
        Voqb0iaS6gAO0+ae19Q17CngTb9OBKmZVgZCVnezGTWRXUlrxxtsJUxyzWNSVlxr1FJij9s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--7.485900-4.000000
X-TMASE-Version: SMEX-12.5.0.1300-8.5.1010-24524.005
X-MDID: 1554133115-i6sgI-Yq-JHD
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 30/03/2019 00:16, Alexei Starovoitov wrote:
> With large verifier speed improvement brought by the previous patch
> mark_reg_read() becomes the hottest function during verification.
> On a typical program it consumes 40% of cpu.
> mark_reg_read() walks parentage chain of registers to mark parents as LIVE_READ.
> Once the register is marked there is no need to remark it again in the future.
> Hence stop walking the chain once first LIVE_READ is seen.
> This optimization drops mark_reg_read() time from 40% of cpu to <1%
> and overall 2x improvement of verification speed.
> For some programs the longest_mark_read_walk counter improves from ~500 to ~5
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Edward Cree <ecree@solarflare.com>
> ---
>  kernel/bpf/verifier.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b18512ac205e..6dfd148b58f6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1151,6 +1151,15 @@ static int mark_reg_read(struct bpf_verifier_env *env,
>  				parent->var_off.value, parent->off);
>  			return -EFAULT;
>  		}
> +		if (parent->live & REG_LIVE_READ)
> +			/* The parentage chain never changes and
> +			 * this parent was already marked as LIVE_READ.
> +			 * There is no need to keep walking the chain again and
> +			 * keep re-marking all parents as LIVE_READ.
> +			 * This case happens when the same register is read
> +			 * multiple times without writes into it in-between.
> +			 */
> +			break;
>  		/* ... then we depend on parent's value */
>  		parent->live |= REG_LIVE_READ;
>  		state = parent;

