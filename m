Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793938797;
	b=xVnYvbbyO6xIT4I3ZX2HqkBOwPmQqtJ7FI8F/c/3/gK0iSWMaPo7iEIx2ee6WK+O9gxn
	 gv1Oef7PSSZhgLTnPKn8fuwLJgyWbz6YPgI1KXKdJw7DOmSJ4XAzsR+l1QHyvObk2xIzV
	 ihXgbz0amybCdRl309TObFV0+pm64/KwriXmFww1s5Zy1a5+XQ5WOziWOM9DJqQIA+R6C
	 ISqGsQJV/jMwD4l4LfiuQqs8AQhkSZAEs9WwrymRAgjYGhq6MA1rFXzGUhyf6oFkfrnxm
	 lPNvZPSgUKjXBf5bjt9ZxZM76QW81xkJA1CjrAWyauyXkswNQyJ5twXNvVgOlUEa5lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793938797;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UfcUVlz0AmO35Vuv5fDxZC/asBkjgOS5D5TEztXFQLU=;
	b=ZRgUwHzoeor95gOcaWo372XRT/tR3tRhcjTt6hSpvuMi9CXWILwX3rY55BByfDwWc64q
	 rZjBbJiDD2j7Kgj3UlIUHtMfxIiNYWkUqHGBJUS1CvmQx8jpHdHFGyWnKVcUH2Yyh1HQ7
	 4+vdeJ6UizR64LmU90RUdMukASkFFsIyBT/Iikq4FmulAU4kdqmGla1utumYryhnqxzWg
	 eHcHdP7p2QmtXSWw0/fhUHBFWVcmd1fW7WsZ1+x3IlMTvJ5cURDJcqg93S4Pwe2J4gzzC
	 56XS+o2afjFr7sr8aeQGFyoNN1LAA1hHpaGqRbuwKjDhqvGF+NB3Lkoodfa2klAd/ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibkYan87;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8A7606A329
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 04:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibkYan87
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02F91F008A4;
	Fri,  6 Nov 2026 04:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793938796;
	bh=UfcUVlz0AmO35Vuv5fDxZC/asBkjgOS5D5TEztXFQLU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ibkYan87ByOgLcmG15RGj6k8lx7OEvolQc3bVx8CskrXQCRuuwaiOl6GJ52XASBzz
	 1U3Ojr0GHO1qJgHW0PlXBBZwKB4OhgO43sxebcX27jzzeVjkztoTOGBKsBARTZczvR
	 wGLXJXSZcYLupg0BQp09QcV46cA8b4dyet5pjlTqbZbaWxLb6/WqeYJivfDeCSla5Y
	 B6T8ufCxNw3GVtPuFztbgNESMuLbCixCTrYrZKHw1bTavOCEYn6V3Lhl2rCH2WgzRt
	 TNs/wzzajKnXwriWCU1nTKMh21uBoF5zUHba89jbTgjUDoVqvv1qklJY9f3Cki/2FS
	 2lYB3v2FYVl2g==
Message-ID: <sashiko-outbox-200706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 26/45] bpf: Update comments about paths,
 pruning and explored states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261106035111.3315285-27-alexei.starovoitov@gmail.com>
References: <20261106035111.3315285-1-alexei.starovoitov@gmail.com>
 <20261106035111.3315285-27-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 04:19:56 +0000
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
- [Low] bpf: non-standard multi-line comment style in updated verifier comm=
ents
--

commit de7d08cee08981c083cd91cad28f7bba69ff01a5
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Update comments about paths, pruning and explored states

This commit updates verifier comments in include/linux/bpf_verifier.h,
kernel/bpf/states.c, and kernel/bpf/verifier.c to describe the control-flow
graph fixpoint pass and state joining instead of legacy path exploration and
pruning.

[Severity: Low]
This isn't a bug, but while this patch converts several multi-line comments=
 in
include/linux/bpf_verifier.h, kernel/bpf/states.c (in stacksafe()), and
kernel/bpf/verifier.c (in sanitize_ptr_alu()) to the BPF multi-line comment
style with the opening /* on its own line, several other multi-line comments
updated by this patch still keep text on the opening /* line:

- kernel/bpf/states.c, in the block comment above func_states_equal()
  (starting at line 659)
- kernel/bpf/states.c, inside bpf_state_subsumes() before the old->speculat=
ive
  check (starting at line 735)
- kernel/bpf/verifier.c, in the top-level bpf_check() overview comment
  (starting at line 63)
- kernel/bpf/verifier.c, in the block comment above process_iter_next_call()
  (starting at line 8909)
- kernel/bpf/verifier.c, inside prepare_func_exit() before free_func_state()
  (starting at line 12560, which also keeps the closing */ on the same line=
 as
  the comment text on line 12561)
- kernel/bpf/verifier.c, inside mark_ptr_or_null_reg() in the is_null branch
  (starting at line 19192)
- kernel/bpf/verifier.c, inside process_bpf_exit_full() before the
  exception_exit check (starting at line 20656)

Should these updated multi-line comments also place the opening /* and clos=
ing
*/ on their own lines to match the BPF coding style?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106035111.3315=
285-1-alexei.starovoitov@gmail.com?part=3D26
