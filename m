Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422091;
	b=nIWU0i3GADZCBqAR3ZgqfLb6Vi3snQCBpyAKXCKRi2psfbnfocZFkCq/2EL7dVKAS6Ne
	 I8aStf5IgcIbyK4ttBmeyHxTY6BA5/K3eHATYiyaM4tkKrqL+IA6tcgFPqzHjST4ht8jK
	 yKeauVpvFj58uTmzgjAXkUtdZQDBdmU5Uf44e3M/bsEhhEScBO4YwVMmAqrxVZUlNNyZ8
	 12rT3cAXtPiH18lDUyhnp1bt6KNfQM9fAZkG2yAjWUn0D8lOKBvwrxybM1kjI6gp4+KsP
	 CirU7sDQEWuu6X2/rDS96DKXHC48/F6xHblPg/Fw55/+V5ngcjp0UQ2D8Ar2MI/T0iQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422091;
	h=Received:Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 Date;
	bh=IAOBmo/4ic3jXX9wroTjAB02hzEgaYEfduQTfRYwxNE=;
	b=FEEkzypfzUOmyqhAfIlnkaQ8bJN47XYEZWeZ2dyRYuqgo2/fqkuMqdq9v9KeYprYpqxs
	 4KnFn/U8TJ/zTXSpU/mBtwX0LmyCrSB2yrRrldDrIRRzvMmHz2nj0gq9bdUlvo+osI/8P
	 ijCeOY+VbaORe4gIO/8zRU8w3yhEn40aF4tDQm2hgkcRCaaWaLwTaYXiVFJ4UrQ2ehOhr
	 JPcotrGUZn+TGEfYXncF+RXIbpIsTpO4rjwxXfv0RHYmkhyIF0CZFJI1m2dqAYHroUgoJ
	 cjXRBYLRQXktG7NuERwy8HIEEL9+jlEk6N9RLm0DZzBA/Qo+6rOUjnjb5f6m9o+T0oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GmWXLXnC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=10.30.226.211
Received: from aws-us-west-2-korg-listserv-1.web.codeaurora.org (ip-10-30-226-211.us-west-2.compute.internal [10.30.226.211])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31411607AF15
	for <bpf.vger.kernel.org@localhost.mlmmj>; Mon, 19 Oct 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GmWXLXnC
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444433B975
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792422091; cv=none; b=H2Lmh+3acPa2hylBuOzdBCq+X9z0YD1Qu2osKMAnVP6Muj3n73lZaw8NASHAY3cLimrg1oba2SNrgiLWTGiKIVhEtvOFjHe5yCKVEd8+fB6ioXYG03MiK6JexWY5cD/PMihCCkeZPGfMkfhdge1JI7Gn7wZdusGHSUGnM7ftlYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792422091; c=relaxed/simple;
	bh=D2Qv0/JSugpBJZzFZB2Hewawe0Ks0xO/9Pp9HNMWtAw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TZYDfW8pTdGaxZrSCU6YGY5TRM6w1Xs93NSbyLMiynkBak6QN4U8nlDj8Ci7GT+KzjHLVk8p75QuKCWrKXLnzV46ciTtE+A2T17xd8MMmMZdlRbIJEWEhKHilItz+KfB/xBZT/2DLK3SM7FC7jU22nTM98lyb6QknYIUncGgPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmWXLXnC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30061F000C4;
	Mon, 19 Oct 2026 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792422090;
	bh=IAOBmo/4ic3jXX9wroTjAB02hzEgaYEfduQTfRYwxNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GmWXLXnCHUDPa9GReJdY7mS8UKFB1QLewHJP/uXQQrY8YO3alxsuuXYYNixtIERBv
	 3GT44PxNqJ7Hdw1O55CAXkl25MXhmf9QHrqp5+Eu09FtKvm7Wy6NtBrn6sO3Ly6qqk
	 BQfOD4SU5bUJKXu1MHSXvB7FGsYvRRpzYCVvMGN7tac2yRHHWIMczB2MyuRUdH3eXb
	 O3QrUvROmkhsxTg82kTTGD8GVS7N/gCFSV/cZmyxCxYg2gSpekkDHbtzmg+6MmgrET
	 L8l2+YnL9pcJ7hIPgWp/VO7TlPYN83MoXR2bPDF8Wm+hgpY4dJzOTyOCD6ZOlmnLDZ
	 exUmgARU2XOfA==
Message-ID: <sashiko-outbox-177591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] bpf: Reject callback subprogs invoke
 tailcall
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261019135441.1420968-237-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-237-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:01:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: unreset tail_call_reachable in check_max_stack_depth_subprog()
--

commit c2ffc0a7246f4fd9042fb29769bcdfa70c066eca
Author: Pu Lehui <pulehui@huawei.com>

bpf: Reject callback subprogs invoke tailcall

This commit rejects tailcalls inside synchronous callback subprograms by
widening the exception callback check in check_max_stack_depth_subprog()
to cover all callbacks via is_cb.

Link: https://patch.msgid.link/20260716120157.835937-3-pulehui@huaweicloud.=
com

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b89a5d717e422..5cc3e9a990ef7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6852,8 +6848,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>  	 */
>  	if (tail_call_reachable)
>  		for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller) {
> -			if (subprog[tmp].is_exception_cb) {
> -				verbose(env, "cannot tail call within exception cb\n");
> +			if (subprog[tmp].is_cb) {
> +				verbose(env, "cannot tail call within callback\n");
>  				return -EINVAL;
>  			}
>  			subprog[tmp].tail_call_reachable =3D true;

[Severity: High]
Can this falsely reject valid BPF programs when a program calls a
tail-calling subprogram and later uses an unrelated synchronous callback
that does not invoke any tailcalls?

In check_max_stack_depth() -> check_max_stack_depth_subprog(), the local
variable tail_call_reachable is initialized once at function entry and
is only ever set to true when descending into a callee:

kernel/bpf/verifier.c:check_max_stack_depth_subprog() {
	bool tail_call_reachable =3D false;
	...
		idx =3D sidx;
		if (!priv_stack_supported)
			subprog[idx].priv_stack_mode =3D NO_PRIV_STACK;

		if (subprog[idx].has_tail_call)
			tail_call_reachable =3D true;
}

Because tail_call_reachable is never reset to false when entering a
subsequent callee whose has_tail_call is false (or when popping back to
a caller), once any normal subprogram with has_tail_call =3D=3D true is
visited, tail_call_reachable remains true for the rest of the walk.

Synchronous callbacks (such as callbacks passed to bpf_loop or
bpf_for_each_map_elem) have is_cb =3D=3D true and is_async_cb =3D=3D false,=
 so
the traversal enters them via bpf_pseudo_func(insn + i). If a synchronous
callback without tailcalls is visited after an unrelated tail-calling
subprogram, tail_call_reachable is still true and hits this new
subprog[tmp].is_cb check, failing BPF_PROG_LOAD with -EINVAL.

Does this backport also need prerequisite upstream commit 3513ea9dab6c1
("bpf: Sync tail_call_reachable with callee state on entry"), which
updates the callee entry logic to:

	tail_call_reachable =3D subprog[idx].has_tail_call;

so that tail_call_reachable does not leak across unrelated subprograms?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-237-sashal@kernel.org?part=3D1
