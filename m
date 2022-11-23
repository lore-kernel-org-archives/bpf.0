Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2611AC433FE
	for <bpf@archiver.kernel.org>; Wed, 23 Nov 2022 23:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKWXcL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiKWXcJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 18:32:09 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18898A6581
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 15:32:09 -0800 (PST)
Message-ID: <7bcdf377-59e9-a774-2882-d53e494b37cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669246327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5rrAwgHZ8XRFDVxHv+/cHHRy5aTlfeEpi6rVHqFq8Ug=;
        b=oHNHkiQL7JfogPC7kVF/VXcnp46egd6Vyok6oL/jiO8DF0gCnmkDSs+qIAJynou3XL5zzV
        +Y+LPPrUzA6bPtPZWg0Q8zMCPbRdgB5yFzBnBGBZMQVBsdyauVavr90sWYsXhoGvedR6eV
        LYsILVQIYgFCAK5MwYukxoEWbfb9quE=
Date:   Wed, 23 Nov 2022 15:32:05 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221123045350.2322811-1-yhs@fb.com>
 <20221123045406.2324479-1-yhs@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20221123045406.2324479-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/22/22 8:54 PM, Yonghong Song wrote:
> @@ -7539,6 +7590,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>   		return err;
>   	}
>   
> +	if (env->cur_state->active_rcu_lock) {
> +		if (fn->might_sleep) {
> +			verbose(env, "sleepable helper %s#%din rcu_read_lock region\n",

A nit.  Missing a space before "in".

> +				func_id_name(func_id), func_id);
> +			return -EINVAL;
> +		}

