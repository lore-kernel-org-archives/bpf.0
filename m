Return-Path: <SRS0=8uh4=SB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9B6C43381
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C69218D8
	for <bpf@archiver.kernel.org>; Sat, 30 Mar 2019 03:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Sv9dNDgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfC3DMr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Mar 2019 23:12:47 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35890 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfC3DMr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Mar 2019 23:12:47 -0400
Received: by mail-qk1-f195.google.com with SMTP id k130so2597291qke.3
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2019 20:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=XtCD5o0YDi6zWAKv673Y4VjewihhLV9oSCf+ivJG+xc=;
        b=Sv9dNDgP1zV8t4hTSd7rPyhgQuk+llaXbUN+6Sc+p+t5ZPK6PD24jvpIQ+GnVFJN2U
         ZNZRR9KkeOr/2kfxU9qmARzB6jAX/Q4C3Xt48peLWEZtvjO7C1Ua/Z5o943vAap9IhY7
         dU2y9iSwRFzzokJwf6NKGzGxIM6CgGnFreCBvnxMzIlRnPw2v41cC7sBgnIhV2znusyc
         tfNsV2kZeBoD8oj7srexoM8w3j/VxqKvnUNbukVHpuUUxPl/jw7lhg+k57toxwYgnJl4
         56uTQdjaYYBsswttWYJXrCGJflrzczpGDUe/Vrc3WsipUelQVJEJ+U7A2XCmn2deTJs6
         tKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=XtCD5o0YDi6zWAKv673Y4VjewihhLV9oSCf+ivJG+xc=;
        b=DtM7rae2a3kiBc3VM3vM0UTegq9aRpDo9JI/OLn1lE1TZgIi9dDlideKp157/+UuW9
         Qq6DFmk0wrKc1mzhdHMFdhXC++nCTU3Ux4Y3P7sKN3zeSI5ojdzNqlTDtF0uAZdjxs0j
         XRX/qjFndaLqAOJxArKsSTxZ5ThoGF19dpI/Xemg7CYkvhX5lAeb5ZUDKnBpgX01Qn9j
         lvu62O0Yp/C2gWYyi+Stgi2/I++M2cV7d3xDCENRKxaa5SYvPfSORFVv8Olw2E2LBIb+
         SkIr/obBzsTDNBUULRWCfyAh75VJHL92hYKvCKVuTxEaNkPUj4U22jzVZZUUzvT478rx
         LHBA==
X-Gm-Message-State: APjAAAUxYM2DbF0JFXnqWbRaTHZtiofe/rt2h1SijaNPIgLkV25Sk947
        IXVcd9bf+WUkbLfFgrrTGyRXGA==
X-Google-Smtp-Source: APXvYqxcodn7dI3R+y7yas8H/qlRyv7cdcytqTnGEUQZVq4ql9DCnok/nl0ujEtvUbUoPihdmFLoNg==
X-Received: by 2002:a37:7ac7:: with SMTP id v190mr40628913qkc.275.1553915566244;
        Fri, 29 Mar 2019 20:12:46 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id r64sm2029084qkb.60.2019.03.29.20.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 20:12:45 -0700 (PDT)
Date:   Fri, 29 Mar 2019 20:12:39 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     <davem@davemloft.net>, <daniel@iogearbox.net>, <jannh@google.com>,
        <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/7] bpf: improve verification speed by droping
 states
Message-ID: <20190329201239.7736739e@cakuba.netronome.com>
In-Reply-To: <20190330001612.2354959-3-ast@kernel.org>
References: <20190330001612.2354959-1-ast@kernel.org>
        <20190330001612.2354959-3-ast@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 29 Mar 2019 17:16:07 -0700, Alexei Starovoitov wrote:
> Branch instructions, branch targets and calls in a bpf program are
> the places where the verifier remembers states that led to successful
> verification of the program.
> These states are used to prune brute force program analysis.
> For unprivileged programs there is a limit of 64 states per such
> 'branching' instructions (maximum length is tracked by max_states_per_insn
> counter introduced in the previous patch).
> Simply reducing this threshold to 32 or lower increases insn_processed
> metric to the point that small valid programs get rejected.
> For root programs there is no limit and cilium programs can have
> max_states_per_insn to be 100 or higher.
> Walking 100+ states multiplied by number of 'branching' insns during
> verification consumes significant amount of cpu time.
> Turned out simple LRU-like mechanism can be used to remove states
> that unlikely will be helpful in future search pruning.
> This patch introduces hit_cnt and miss_cnt counters:
> hit_cnt - this many times this state successfully pruned the search
> miss_cnt - this many times this state was not equivalent to other states
> (and that other states were added to state list)
> 
> The heuristic introduced in this patch is:
> if (sl->miss_cnt > sl->hit_cnt * 3 + 3)
>   /* drop this state from future considerations */
> 
> Higher numbers increase max_states_per_insn (allow more states to be
> considered for pruning) and slow verification speed, but do not meaningfully
> reduce insn_processed metric.
> Lower numbers drop too many states and insn_processed increases too much.
> Many different formulas were considered.
> This one is simple and works well enough in practice.
> (the analysis was done on selftests/progs/* and on cilium programs)
> 
> The end result is this heuristic improves verification speed by 10 times.
> Large synthetic programs that used to take a second more now take
> 1/10 of a second.
> In cases where max_states_per_insn used to be 100 or more, now it's ~10.
> 
> There is a slight increase in insn_processed for cilium progs:
>                        before   after
> bpf_lb-DLB_L3.o 	1831	1838
> bpf_lb-DLB_L4.o 	3029	3218
> bpf_lb-DUNKNOWN.o 	1064	1064
> bpf_lxc-DDROP_ALL.o	26309	26935
> bpf_lxc-DUNKNOWN.o	33517	34439
> bpf_netdev.o		9713	9721
> bpf_overlay.o		6184	6184
> bpf_lcx_jit.o		37335	39389
> And 2-3 times improvement in the verification speed.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>

> @@ -6182,8 +6185,35 @@ static int is_state_visited(struct bpf_verifier_env *env, int insn_idx)
>  				return err;
>  			return 1;
>  		}
> -		sl = sl->next;
>  		states_cnt++;
> +		sl->miss_cnt++;
> +		/* heuristic to determine whether this state is beneficial
> +		 * to keep checking from state equivalence point of view.
> +		 * Higher numbers increase max_states_per_insn and verification time,
> +		 * but do not meaningfully decrease insn_processed.
> +		 */
> +		if (sl->miss_cnt > sl->hit_cnt * 3 + 3) {
> +			/* the state is unlikely to be useful. Remove it to
> +			 * speed up verification
> +			 */
> +			*pprev = sl->next;
> +			if (sl->state.frame[0]->regs[0].live & REG_LIVE_DONE) {
> +				free_verifier_state(&sl->state, false);
> +				kfree(sl);
> +				env->peak_states--;

nit: is peak_states always equal to number of states when verifier
     exits?

> +			} else {
> +				/* cannot free this state, since parentage chain may
> +				 * walk it later. Add it for free_list instead to
> +				 * be freed at the end of verification
> +				 */
> +				sl->next = env->free_list;
> +				env->free_list = sl;
> +			}
> +			sl = *pprev;
> +			continue;
> +		}
> +		pprev = &sl->next;
> +		sl = *pprev;
>  	}
>  
>  	if (env->max_states_per_insn < states_cnt)
