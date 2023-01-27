Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0C7C54EAA
	for <bpf@archiver.kernel.org>; Fri, 27 Jan 2023 07:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjA0H6k (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Jan 2023 02:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjA0H6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 02:58:39 -0500
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE7E757BD
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 23:58:37 -0800 (PST)
Message-ID: <befb819f-abc4-c7a1-1f82-9559542f9138@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674806315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCyMrk9aN65WEKM1E5bYRN1lFodwyHbxv5dcbOPmgug=;
        b=J2NFVLZHJjIRQqWiDnmsc+ZdaWRw6e0V7HMwt0c76ud0bxzrZIIfDh1ezD2ysO1kr5bzX4
        e4jNrGgxnZA2vJ0C9vKhiUS1N4NIZc2dhq4zctkRL8WRrpM6+qVk+xDSBf5TyRqu1FgRJ3
        buFAnvFFQzLg8RFfl9LAfkjfK1vQZQU=
Date:   Thu, 26 Jan 2023 23:58:24 -0800
MIME-Version: 1.0
Subject: Re: [PATCH v8 bpf-next 3/5] bpf: Add skb dynptrs
Content-Language: en-US
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        ast@kernel.org, netdev@vger.kernel.org, memxor@gmail.com,
        kernel-team@fb.com, bpf <bpf@vger.kernel.org>
References: <20230126233439.3739120-1-joannelkoong@gmail.com>
 <20230126233439.3739120-4-joannelkoong@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230126233439.3739120-4-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/26/23 3:34 PM, Joanne Koong wrote:
> +static enum bpf_dynptr_type dynptr_get_type(struct bpf_verifier_env *env,
> +					    struct bpf_reg_state *reg)
> +{
> +	struct bpf_func_state *state = func(env, reg);
> +	int spi = __get_spi(reg->off);
> +
> +	if (spi < 0) {
> +		verbose(env, "verifier internal error: invalid spi when querying dynptr type\n");
> +		return BPF_DYNPTR_TYPE_INVALID;
> +	}
> +
> +	return state->stack[spi].spilled_ptr.dynptr.type;
> +}

CI fails: 
https://github.com/kernel-patches/bpf/actions/runs/4020275998/jobs/6908210555

My local KASAN also reports the error.
