Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F81377AB4
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964737; cv=none; b=UR26muFSxdY6cccivjzbvyaF1k1Pp8PeaIYs1g/rE/p9advaZmwIQy89YMVMbblqyIGd9oSsD/VhjH+Azx9c3tRmqnpfWl6+UtXWuWK4xiFN0wjR/wAKbwxtKL3MOSCBReXMNtMzQfMOHEM4THDvRG14rd0PmIiiGsDfOeKYqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964737; c=relaxed/simple;
	bh=bsL401M3LFyxMDSvkWS1vIiJZAEnF2cX12XpzWpU6es=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y2gYDIx3k6crtJUgq/p0LSrVbl/lHAZ6zahDpMiRNJqiOKCO2IhexziemWq4aajmD24Jtg2xf0QwPAAtIm5Q/kQunSKwV3VfrhxcCVUxCxNzmwDzgjVvzZPYuvWeIk94sayOuBE1NmMz1U/1ArNcsmGtr1+DXhRHuKt44QlIsxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFgv4VOf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFgv4VOf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFAF1F000E9;
	Wed,  5 Aug 2026 21:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964731;
	bh=bsL401M3LFyxMDSvkWS1vIiJZAEnF2cX12XpzWpU6es=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFgv4VOfypwOl8zJ51onfcy06GFZzkufFCm/lWLhGvZZV8dMifZm97/IG8H6SK2Wc
	 nj9KEzHyPRvqZe+4gfn/vZpnuvPLu1Jpx2jUEB7t2pAhx/OXB0SKp1bzkdqA57Jvqd
	 yM99g3oU/gr9SuSmVM4ioxWMcH/gx5dNx9LCgjvTBNAwjczMXMhpAoR45PdgyoJsB6
	 qDQNNn3xpfVjNLmdopJOCVx1eI/DdVrQLoKwp6rPr03hg205j8yyz7xLeI58I6XirH
	 RJKnrQ2eb6qBw6teVKEEgVmBjlxMcvUApmQ4z3kGddbj9UWey7Ag9EHEqJPNu37JTZ
	 1BZCu19UEKlCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 05/13] bpf: Support __arena and
 __arena__nullable on struct_ops arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260805210427.3218326-6-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
 <20260805210427.3218326-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:18:50 +0000
Message-Id: <20260805211850.CBFAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Extension (`freplace`) and tracing (`fentry`/`fexit`) programs=
 attached to `struct_ops` programs with `__arena` arguments bypass type saf=
ety, treating user-controlled 32-bit arena offsets as trusted kernel pointe=
rs (`PTR_TO_BTF_ID`).
--

--- Patch [5]: [PATCH bpf-next v4 05/13] bpf: Support __arena and __arena__=
nullable on struct_ops arguments ---
(Note: The formatting of this report is altered due to system recitation re=
strictions. I am providing a free-form summary of the findings rather than =
quoting the original code inline.)

commit fe44e46765df675218e6d1c19ad3b275b47f1966
Author: Tejun Heo <tj@kernel.org>
Subject: bpf: Support __arena and __arena__nullable on struct_ops arguments

This patch adds support for __arena and __arena__nullable suffixes on BPF
struct_ops arguments. It allows passing arena pointers directly to struct_o=
ps
callbacks by converting kernel addresses to arena offsets in the trampoline
context array.

[Severity: Critical]
Does this allow extension (freplace) and tracing (fentry/fexit) programs to
bypass type safety when attaching to struct_ops programs that use __arena
arguments?

In kernel/bpf/btf.c:btf_ctx_access(), the verifier iterates over
prog->aux->ctx_arg_info_size to enforce PTR_TO_ARENA. However, for extension
and tracing programs, ctx_arg_info_size is 0. This causes the verifier to s=
kip
the arena type check and fall through, incorrectly typing the argument as a
trusted kernel pointer (PTR_TO_BTF_ID) via the target program translation.

During attachment in kernel/bpf/trampoline.c:__bpf_trampoline_link_prog(),
the safeguard calls bpf_prog_has_arena_ctx_arg(node->link->prog) on the
attaching program instead of the target program. Because the attaching prog=
ram
lacks ctx_arg_info, this check returns false and allows the unsafe attachme=
nt
to proceed.

At runtime, the struct_ops trampoline converts the kernel pointer to a 32-b=
it
arena offset in the context array. Since the extension or tracing program w=
as
verified believing this argument is a PTR_TO_BTF_ID, could this allow it to
dereference a user-controlled 32-bit arena offset as a trusted kernel point=
er?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805210427.3218=
326-1-memxor@gmail.com?part=3D5
