Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025448;
	b=fVF9stm4YOjBF3ezHzfr6UjuxVSyXYSDTibSvcmHKoduXHdyjJ7EUszovJbHXHigUSkc
	 dByLLnU4c/80PIZOb0Q0XMAlmKV1AWHdzJc8LXJDLnGOjuMQdJ5jcgzJPmTQvOc3zCGjS
	 ZVlbbrrlsuEPUQz0RIz8noY+mWxjLYZ4u7BfkqZ3kxud+cyVddhFL69Y3Z7rXsV9dqnOn
	 2RYytCiNcnmMR+TUH+pHqlDi3ysLlCS0XQZiyf8dxc7CqoQeja/ErU26TDkPtjbndyMu+
	 FkLMqJ+FbDkX6wZYinkUeOFSf2R5ljuhRwFxqk4ueBIfBAKPEDsxWWlT/O++OclQQVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4Rlv3GKa/cPitqt7pnC2pTEZA/gohC4OLR05fQonNL4=;
	b=v3pvQ1ZQFCOjZqbSJXlosPEB90JjKtTI4x9FDlHQhv85Bu3yntr1aDwh9U6A7blm7MMq
	 CpyREEG3vtrpdLesE1YQrbvO6BOnYebWEZhnVrHtg9qbfqWtVYkYm462LtpLMYWD3ZUb8
	 qxJjVitNUQ135AsaepIYJ1qkwvDislZ6TGJs790epgeHckj/VdXr+QzpZZ4RSmwfKsCk+
	 lDklFmdc2pBCeqEZ04WpBgry0096N5uaNkMaSzxL/lOkcmx28BDucfqDaMJ15X0qDLOt1
	 EEFS3ymsrYuHCSxpk24Jlwln5PwlODHKWDl22O+6ptmvYd8Ua1vcSDrIpjBSwKcLcUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kQN0Z/B2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681A5606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQN0Z/B2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1571F0089F;
	Sat,  7 Nov 2026 04:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794025448;
	bh=4Rlv3GKa/cPitqt7pnC2pTEZA/gohC4OLR05fQonNL4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kQN0Z/B27RriQFaQWB4ic3AOx4SCL2Sap+B0ia6BoQUWBbQ1I9RFYc/pjm3AwD8NO
	 HBB5ya1C3AXUn2yeAoVaWez9Bdb+ORc6+tr/mVJUohCrQb5Kd3Egj4CuFBbIsW45/O
	 4+zuqw6lDj0PafOGhw7TttmZXbDGNQ4LbIaNXiyZGByIiTZS7GqVwDxILqQnu4JUH7
	 nbDozDAUQsteyxC3PSfW6/V0O/xR0PCUfZrlaBxwyELqEA1QzBK9zuzVyrVEFcqBya
	 Pqh2PtaLb55QU0f65pJOQjm2pkgovGmw7UWlqa+dtUerYG5P/vPx5DAGV0u/osOZPW
	 sk8q1p4DTUsmA==
Message-ID: <sashiko-outbox-202575@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 39/46] selftests/bpf: Adjust tests to new
 verdicts, messages and order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-40-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-40-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:24:07 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests/bpf: ineffective __not_msg() window in
  correlated_regs()
--

commit 7cea750c7f8c80faefbaba10e236762a682e25c2
Author: Alexei Starovoitov <ast@kernel.org>

selftests/bpf: Adjust tests to new verdicts, messages and order

This commit updates existing BPF selftests to match the new verifier
verdicts, log messages, and branch exploration order, and adds tests for
recursive subprogs.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_scev.c b/tools/te=
sting/selftests/bpf/progs/verifier_scev.c
> index abe2b19110790..d89ffe90c6bc3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_scev.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_scev.c
[ ... ]
> @@ -2396,18 +2374,15 @@ __msg_next("  r1=3D(+ r1 2) / (linear (+ r1 2) 2)=
")
>  __msg("loop header at 11, widening r0")
>  __msg("loop header at 11, widening r1")
>  __msg("11: R0=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=
=3D7,var_off=3D(0x0; 0x7)) R1=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax=
32=3Dumax32=3D14,var_off=3D(0x0; 0xe),step=3D0+2)")
> -/* loop exit */
>  __msg("16: (a5) if r0 < 0x8 goto pc-6")
> -__msg("exiting loop 11")
> -__msg("17: (95) exit")
>  /* second iteration */
>  __msg("loop header at 11, clamping r0")
>  __msg("loop header at 11, clamping r1")
>  /* iteration convergence */
> -__msg("from 16 to 11: safe")
>  __not_msg("{{^}}11:")
> -/* map lookup error path */
> -__msg("from 7 to 17: safe")
> +/* loop exit */
> +__msg("exiting loop 11")
> +__msg("17: (95) exit")
>  __naked void correlated_regs(void)

[Severity: Medium]
As reported by bot+bpf-ci@kernel.org on v2 [1], does moving
__msg("exiting loop 11") right after __not_msg("{{^}}11:") make the
convergence check in correlated_regs() a no-op?

match_negative_msgs() only searches between the preceding positive match
("loop header at 11, clamping r1") and the next one ("exiting loop 11").
Both messages are emitted inside the same do_check_block() call for
instruction 16: flow_drain() delivers the 16 -> 11 backedge (logging the
clamping lines and queueing any non-converged state as pending), and
do_check_block() immediately delivers the fall-through edge to instruction
17 (logging "exiting loop 11").

Only in the next do_check() iteration does bpf_flow_next() dequeue pending
states, so if loop 11 failed to converge, instruction 11 would be logged
after "exiting loop 11" and before "17: (95) exit", outside the window
checked by __not_msg("{{^}}11:").  Placing __not_msg("{{^}}11:") after
__msg("exiting loop 11") (or matching __msg("from 16 to 11: within"))
would cover the span where a non-converged second iteration is printed.

[1] https://lore.kernel.org/r/53c16606b21ca4743d6f2dcc8f31619c9e070d7ca0a72=
9fcb0ae723bb1c04ee5@mail.kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D39
