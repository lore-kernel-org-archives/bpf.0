Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025193;
	b=y1NqqVAeWCRlXqpKZ2Olbd36mGJmtwwRRMniFGF8ji6hn6owotJGiBljtef5h3gYq/xa
	 5PndMleA9JnK1XuYxpXFT9+rFGkmz4p5w70Bz1H6XJSLJ+5X+zg/fVSeUT7T7l8ZqNA8n
	 7+Bgk5nTpdceNHLEwUUw6Uccqu071miq75qa/2oCwVBwsfx1h3V8KbyqvOM1mH3oA84rH
	 F1ylccr6qOhSElfmmA3Os67/uT9oyTj02kxMLV0w0DbNHjBJdlyI4lcbEz3E2CQ9ICzCN
	 XP/lcPDD2Oq/Lakg1RYh0lajL8MUz9hnKOG+xZAFutdAhQ6XdK3s6UslBaqGfI5BCIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025193;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=2t/+DIaqfiM+lE8DcYXjJutVGHGOQmEq3czGbu3oJLs=;
	b=PFcTfc2ghFfY2XJnZDmMPz1r7aG+i09rkTWCICzxz5Z0SMXeAr8uQ7SNHX/R1/rSqXMo
	 DtmtaK6wrvVJCQCJBesaH0DUKx9snHTg2DnXyCiNLzTtpKxKu/cg66cHyc9grOvsrxbut
	 xxwD6jALzfrrag9ftCqwMBO8GMdhsXqzwE5rixPTJmwAeaxmngRSd+LZEfRcZFY0J67VH
	 7H+ZTMq5LyVUJVvB/F6wpbD3BW/V0DVcW5Q0a6DznRwF8FBGRnu9i/RxtQ2z/7vD5XUWp
	 Rr3DLbV5UKJMWM4XFF0o0aEw9IZ7f0i9UK8D5NNifECI6oAoMJzqziSGyVclkyc//zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVnDWhGN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFC606A326
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVnDWhGN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9DA1F0089F;
	Sat,  7 Nov 2026 04:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025192;
	bh=2t/+DIaqfiM+lE8DcYXjJutVGHGOQmEq3czGbu3oJLs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oVnDWhGNXD6PjwMS0RwUU1iFPySh6jsA29Q8yzMjRL5xYWgyRnFfXX2c5R5sLtdht
	 I3w+FGUO0FK3wra+fGWAHpHjYSaKCa2me8eR/LYYd/MHQUY3+QvMFcYMaw59rRfkpr
	 mfpR/0oMNRz+odXYwhmciBzflHYSU5oyTUt+9BKNp4IGIE/yqqcytOMV92O1bY0f5F
	 KGIK/rs4nOjD2sOizKEgNBUHrn99obi7AoWFOj8kf2tJ5bYUZ0LaYkMcw/2K9bKttl
	 GuU9t+/JZWzFXB5BrGqL/bTlBUOr002QSUj/eCThhjKS5uvjeLfbYGqPFjHNhpE3LH
	 sCt9jbYshxolQ==
Content-Type: multipart/mixed; boundary="===============8083120183854587895=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fb8d35a46bcb3abb0fb5bc6053fbc07e60229347b31be67441d34775742b0f7b@mail.kernel.org>
In-Reply-To: <20261107033758.1547725-7-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v4 06/46] bpf: Tell which arguments of a call a join must leave alone
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  7 Nov 2026 04:19:52 +0000 (UTC)

--===============8083120183854587895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Tell which arguments of a call a join must leave alone

TL;DR: bpf_call_checked_arg_regs() may miss the range-checked bpf_throw()
cookie in R1, so a later join could widen it and wrongly reject a valid
program at exit.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +/* The registers in which it takes a number that has to be in a range */
> +u16 bpf_call_checked_arg_regs(struct bpf_verifier_env *env, struct bpf_insn *insn)
> +{
> +	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_set_retval)
> +		return BIT(BPF_REG_1);
> +	return call_arg_regs(env, insn, arg_type_is_mem_size);
> +}

bpf_set_retval() is not the only call whose scalar argument is range
checked outside check_func_arg().  check_kfunc_call() does the same for
the cookie of bpf_throw():

    if (meta.func_id == special_kfunc_list[KF_bpf_throw]) {
        ...
        /* In the case of the default callback, the cookie value passed
         * to bpf_throw becomes the return value of the program.
         */
        if (!env->exception_callback_subprog) {
            err = check_return_code(env, BPF_REG_1, "R1");

check_return_code() rejects R1 when it is outside the return range of the
program, for example [0, 1] for BPF_PROG_TYPE_CGROUP_SKB.

For bpf_throw, call_arg_regs() sees one plain u64 argument, which
get_kfunc_arg_type() classifies as ARG_SCALAR, so it returns 0 and nothing
adds BIT(BPF_REG_1).

The consumer added later in the series, flow_tested_regs() in
kernel/bpf/flow.c (80384e102a64 "bpf: Find the registers and stack slots
that later checks depend on"), marks R0 at exits only, and nothing in
flow.c at the end of the series mentions bpf_throw.  So the same pattern
as the bpf_set_retval() case in the commit message (a flag tested before
bpf_throw(cookie), with the paths joined first) would widen the cookie and
reject a valid program with "At program exit the register R1 has ...
should have been in [0, 1]".

Should bpf_call_checked_arg_regs() return BIT(BPF_REG_1) for the bpf_throw
kfunc when env->exception_callback_subprog is not set, as it does for
bpf_set_retval()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42335829855
--===============8083120183854587895==--
