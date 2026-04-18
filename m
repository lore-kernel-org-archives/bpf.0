Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED554192D97
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 04:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776485350; cv=none; b=bGGCdYRwr6GTLJmN2XI57EhdKKZAJ9y5kQHqUh8FbNWKCQYbViRvTqpcylrx0WZJl9/G77hU07iyGYUz5BQWumGRj0QK8wnv+qP74S9tic0Sz/8A3KDeNSbVRItPJy6VAg1gaB7i+4ieoX3KZWkwZGd10NBub8DaXulFqhPJ6V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776485350; c=relaxed/simple;
	bh=zwTr4cFeWKCIEL95wAOWOkOg9yGT8vX/UbXuS3HCn34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XZeUy9i9Ha310eUGnJ00yjjMZRlwyGczyOExS4pkT5N/V2Lq9u+XPG3tBYoDeaWL2avAHL5tHcyuweGEEUz36fzLC9fnZfv6REPS70P+V3Wrz+jWi8qfVyyh3E54EpAnQvl4cMCoCFJFxBiHmC4+IC2vTbsW/4enpsjJcagrccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgQbtGOZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgQbtGOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3B7C19424;
	Sat, 18 Apr 2026 04:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776485349;
	bh=zwTr4cFeWKCIEL95wAOWOkOg9yGT8vX/UbXuS3HCn34=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WgQbtGOZhEJ3daaRUfxtG9MdEZYCZIor5Fe2ypuwjEZO2bnmpGVhSz7g3WneBdrs/
	 K3wQWViQ2H4TiBf9mOgMDPu3KgnmcBetFsmoxEpzzY+Y27qMOUeZAttfPh0UfUm62O
	 0Py5Z/ifqmb4KxbblUvbvJDoj3zvUDT8HczMhvwgLB1GsHrWVLTLmTMWfTlvP8gSrT
	 Id889Rcw6m1qLHpf7gykpZJAU8LSRoTPoXYvjl7au8O6hCf0pBKolNBAQ5lg43BFRo
	 I+y574bJDWrSe6QhTxwTmI4BiPQhWtXGYiLJr/QIjarNYJDNUIdXKZq9pNxk8g7luj
	 HC0nd/lezCvFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv5 bpf-next 10/28] bpf: Add multi tracing attach types
Reply-To: sashiko@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417192502.194548-11-jolsa@kernel.org>
References: <20260417192502.194548-11-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Apr 2026 04:09:08 +0000
Message-Id: <20260418040909.5F3B7C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] FENTRY_MULTI and FEXIT_MULTI programs can bypass verifier bounds c=
hecks and read out-of-bounds kernel stack memory by directly accessing the =
`ctx` array.
- [High] bpf_multi_func lacks the __used attribute, causing it to be optimi=
zed out by Clang LTO, which completely breaks the feature at runtime.
--

Note: The format of this review has been altered due to system recitation
restrictions. Direct quoting of the patch diff has been omitted, and the
findings are provided as a free-form summary.

commit ca84efa8f86b1acb8cf0bd98e80446dbd7c92e12
Author: Jiri Olsa <jolsa@kernel.org>
Subject: bpf: Add multi tracing attach types

This commit introduces new multi-tracing attach types BPF_TRACE_FENTRY_MULTI
and BPF_TRACE_FEXIT_MULTI, along with base verifier support. It uses a dummy
function bpf_multi_func for initial verification before the specific link
attachment happens.

Can this approach lead to out-of-bounds kernel stack memory reads?=20

Since the initial verification is done against bpf_multi_func, which is=20
defined with 6 arguments, the verifier will statically permit direct contex=
t=20
accesses up to ctx[5] (and ctx[6] for the return value in FEXIT_MULTI).=20
However, when the program is attached to a real function at runtime, the=20
trampoline allocates the context array on the kernel stack based on the=20
target function's actual argument count.=20

If the target function has fewer than 6 arguments, would reading ctx[5] rea=
d=20
past the allocated context array and leak memory from the caller's stack=20
frame? Additionally, would reading ctx[6] for the return value return=20
unrelated stack memory instead of the actual return value, since the=20
trampoline places the return value dynamically? Does the verifier need to=20
explicitly reject direct memory accesses to the context array for these=20
program types and enforce the use of bounds-checked helpers like=20
bpf_get_func_arg()?

Is it possible for Clang LTO to optimize out the bpf_multi_func function=20
entirely?=20

The dummy function is defined without a __used or __attribute__((retain))=20
attribute, and the BTF_ID_LIST_GLOBAL_SINGLE macro only embeds the function=
=20
name in an inline assembly section without generating a C-level reference.=
=20
In kernel builds with Link Time Optimization enabled, could the compiler=20
eliminate this function as dead code?

If this occurs, pahole would not generate BTF data for it, leaving the BTF=
=20
ID as 0. Would this result in the verifier's bpf_check_attach_target()=20
unconditionally rejecting multi-tracing program loads by throwing a missing=
=20
btf_id error? Should a __used attribute be added to the function definition=
=20
to prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417192502.1945=
48-11-jolsa@kernel.org?part=3D1
