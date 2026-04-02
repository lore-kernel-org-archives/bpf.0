Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E015954726
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 03:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099920; cv=none; b=YzT7bTyM96G5v3HkKAqBwXUqXfLWY9O1pIZxiLZ+/cKu2BaNSsXNd28Ej7t4L4RjECFDAD1Ziugn/+gP2PQhwFVKs6Js4Z1U2Ihgn0onOkaTPeJTGPFtkPAPlNmjVPzyLjoz7VvI57p/YTR/f5C4MpaudHfErxWrsIXn7uQf5Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099920; c=relaxed/simple;
	bh=0l/ozMsYZOxveqB7FdP5M+7yrXX5u4BESe6SYOd3PIg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=phW882zOTPF8y9KzsRVc3Xe6HZyAeN/UbJyWE25fTCHJ5wq2b0dpkpz5w6se0QK2+Q44dUbe9lD8Akyiwgk0VNpjo916cS+hlxm/Q5NazLrCDIZYAeZ4hoEeTW3N9MQJX8DJp8EDpPZlR0LOanKVvV9SVD5/HDZf0w6wWc8I79s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV9MFGQH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV9MFGQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B69CC4CEF7;
	Thu,  2 Apr 2026 03:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775099919;
	bh=0l/ozMsYZOxveqB7FdP5M+7yrXX5u4BESe6SYOd3PIg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jV9MFGQHIdpzq1f/7pVej70Etv3rYNTMh0IpHOOQov45xUuYFEHJU+PzAm6FViGmU
	 nSN8TBOycSksJvKx4JfHobcNl237ht3DEiil5zmrmX79knCPwVN6k7Ds4Sbkh3bdk+
	 XgFp3+wR097hlzKXMKc2b/EoJq+VLA5dZSQttTbOOniuxf4Ebiy4X8ygC9vh9go0yi
	 IOJ38Ko/L1efsrf6I3r9au3uxxuqnnHnNvBrgbUjr0XkkHk1vXZyJoIw8AXL77ZDSp
	 Lb+sKuCAdoPmOwbKSIqP6WOAvPBgO0sMM2Bdfn7agNyXfhqF4x13WTyZkoLZzTnGFY
	 cdK0brFXNI11Q==
Content-Type: multipart/mixed; boundary="===============7994529667577249783=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02581856b17c3d0ea793c988f905388c2855a7fcbc488df8228621462ffdd2ab@mail.kernel.org>
In-Reply-To: <20260402012742.3917613-1-yonghong.song@linux.dev>
References: <20260402012742.3917613-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf functions
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,jose.marchesi@oracle.com,kernel-team@fb.com,martin.lau@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Apr 2026 03:18:39 +0000 (UTC)

--===============7994529667577249783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 090aa26d1c98..a260610cd1c1 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -319,6 +324,10 @@ struct bpf_func_state {
>  	 * `stack`. allocated_stack is always a multiple of BPF_REG_SIZE.
>  	 */
>  	int allocated_stack;
> +
> +	u16 stack_arg_depth; /* Size of incoming + max outgoing stack args in bytes. */
> +	u16 incoming_stack_arg_depth; /* Size of incoming stack args in bytes. */
> +	struct bpf_stack_arg_state *stack_arg_slots;
>  };

The new stack_arg_slots state is part of bpf_func_state and is
properly copied in copy_stack_state() and freed in free_func_state(),
but stacksafe() does not compare it during state pruning.

stacksafe() only iterates the regular stack:

kernel/bpf/verifier.c:stacksafe() {
    for (i = 0; i < old->allocated_stack; i++) {
        ...
        old->stack[spi].slot_type[...]
        ...
    }
    return true;
}

It never examines old->stack_arg_slots or cur->stack_arg_slots. This
means func_states_equal() -> stacksafe() treats two states as
equivalent even when they differ in their stack arg slot contents.

Could this allow the verifier to incorrectly prune a path where
outgoing stack arg slots are uninitialized? For example, if a BPF
program has two paths to a call instruction -- one that writes the
outgoing stack args and one that does not -- the verifier could
explore the initialized path first, save the state at a checkpoint,
then prune the uninitialized path as equivalent. The initialization
check in set_callee_state():

kernel/bpf/verifier.c:set_callee_state() {
    for (i = 0; i < callee_incoming_slots; i++) {
        int caller_spi = i + caller_incoming_slots;

        if (!is_stack_arg_slot_initialized(caller, caller_spi)) {
            verbose(env, "stack arg#%d not properly initialized\n",
                i + 1 + MAX_BPF_FUNC_REG_ARGS);
            return -EINVAL;
        }
        callee->stack_arg_slots[i] = caller->stack_arg_slots[caller_spi];
    }
}

would never run on the pruned path, potentially allowing the callee
to receive uninitialized data.

It seems like stacksafe() needs a companion loop for stack_arg_slots,
similar to how it walks the regular stack, to maintain verifier
soundness for this new state.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23879588767
--===============7994529667577249783==--
