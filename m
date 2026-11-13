Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549156;
	b=zsXAnITZEe0ih6YcvPPJqhSUHqtH4gB+Mv14GXIbufqp64PzAn6VsRCKrWx+yFLfkdac
	 vx0Wp2Wdeq8+eEc4fdcpYyFf7aE0K60K6KpiU2QttJmHvXsgmaF3S5hJ7ndOBTF0mn7EB
	 54sC328JbPaauv7Pg8gM7ljq9hve36xhgvLM805+W3P2WL6h1tudb/3kdMa0nH8020y9q
	 Q9sux3JFxd3bmRDHhIIAiyLtdScX25IgV97qISUShuQFSpfHJce8p+Ce5z36WKxTnSgYD
	 3Jcx/71KTjShaesZEkfuQhqHDLiIqMFnuPwT1r1o6rL0jtpwcv012UQVaysJPTWGJxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549156;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=WrizM5Xmobjpl2Oj45jIwI9Yo3ZglQGnxF1pnRP5xmI=;
	b=WP8gaLmV6ov01jfSoFc87bWYK/jhmhVvqCwFD0PJbtnhf4UF/EzsNZ96ymrxw3h/DODX
	 NcGHFkqvLsEWMbBUK7S6rSe0BqmRHEPYa9Sl1y5+vQN4NaG7Z6xQdV2nBHHC/S0CS3vC0
	 AKFmHli+9WBF9BoAs4Gt7ANV+xuFZtBJvNBYngAeGjeoNKZyyVPO3RXgm+beM6PPgA9yc
	 PB1kp/MokPrS0s1tKHG3HhoBSEnUD2gzhjhRVNQRq8v/zCAMX3jpZkWVavanolswM5fdL
	 4fjQZs9Guf69twmB7sLD16to3LEpfyJC1JnaBP92HHH4RoAu5i02+TE9kFo+kn3rnoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSiXnSqe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091CF606A899
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iSiXnSqe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD791F000C5;
	Fri, 13 Nov 2026 05:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549155;
	bh=WrizM5Xmobjpl2Oj45jIwI9Yo3ZglQGnxF1pnRP5xmI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iSiXnSqepyybn7RFvZz0OfEN93gvosz3s85iP1KBCgamhua79YKAriKWMj0YjDnhI
	 PQext6jWRueigoE7ovWki9GgN23yb+kkVy/gF6I2qeSdI+5y/XAkGTGaYrxqiEzKsS
	 Qbz+lMmYr30PIjkAT2WfbDzoEYx7uzuTS2zy7/1otg4U1xcDK+wyAXDLr7pxAFQ1cm
	 J88Pdkquaq7aFJCyQwJ5CeKNQAxjkhAzVbjZavGVlrntDNCN6qtnzxbxh282GmXac7
	 WOIoeg4OTjtAMlYEHSkF3uon1aIg9s2abJlOp0ZAwopjvW/h9ScGKGyb0JRQ6UFkr3
	 q8b9ZyYdt9o+g==
Content-Type: multipart/mixed; boundary="===============5874848979077772428=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <3750dbb63ba14bc0a43aaf4c61cd27c20d2483dee161e98b9cb35793dc48d122@mail.kernel.org>
In-Reply-To: <20261113050901.1399091-10-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-10-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/13] bpf: Allow fmod_ret on tagged functions and check the return value
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 13 Nov 2026 05:52:34 +0000 (UTC)

--===============5874848979077772428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Allow fmod_ret on tagged functions and check the return value

TL;DR: Possible wrong rejection of valid fmod_ret programs: an exception
callback's return states may be joined into a range, so check_fmodret_retval()
could reject values like -26 that the main program accepts. Untested.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -20281,6 +20349,9 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
>  	if (prog_type == BPF_PROG_TYPE_CGROUP_SKB && (env->prog->expected_attach_type == BPF_CGROUP_INET_EGRESS))
>  		enforce_attach_type_range = tnum_range(2, 3);
>  
> +	if (env->fmodret_retvals)
> +		return check_fmodret_retval(env, regno, exit_ctx, reg_name);
> +
>  	if (!return_retval_range(env, &range))
>  		return 0;

Can this reject valid programs when the exit comes from an exception
callback?

process_bpf_exit_full() calls check_return_code(env, BPF_REG_0, "R0") for a
frame with in_exception_callback_fn, and that reaches
check_fmodret_retval(), which checks a set that is not contiguous.  The
commit message relies on this: "The verifier tests R0 at the exit, so
flow_join_makes_up() does not join ranges that leave a gap."

That seems to hold only for subprog 0 and for callbacks whose address is
taken.  flow_compute_need_const() sets FLOW_NEED_JUMP like this:

	if (jump) {
		/* the verifier compares what the prog and its callbacks return with a range */
		ret[0] = BIT(BPF_REG_0);
		for (i = 0; i < env->prog->len; i++) {
			if (!bpf_pseudo_func(&insns[i]))
				continue;
			...
				ret[s] = BIT(BPF_REG_0);
		}

The exception callback is a global subprog found through the
"exception_callback:" decl tag, so it is not referenced by a
BPF_PSEUDO_FUNC ld_imm64, and nothing in flow.c checks is_exception_cb.
R0 is then never in FLOW_NEED_JUMP inside the callback, flow_join_makes_up()
returns false, and bpf_states_join() merges the two states.

For example, with a target tagged "-27,-22":

	__noinline int cb(u64 cookie) { return cookie == 1 ? -EFBIG : -EINVAL; }

compiles to "r0 = -22; if r1 != 1 goto L; r0 = -27; L: exit".  At L the
states R0 = -27 and R0 = -22 are joined into [-27, -22], and
check_fmodret_retval() then rejects -26 with "At program exit the register
R0 should be 0 or one of -27,-22".  The same code in the main program loads.

Would setting ret[env->exception_callback_subprog] = BIT(BPF_REG_0) next to
ret[0] in flow_compute_need_const() address this?  The selftest added later
in the series only tests an exception callback that is rejected, so this
case does not appear to be covered.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43372129532
--===============5874848979077772428==--
