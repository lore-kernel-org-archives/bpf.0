Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794024197;
	b=B0ab2CZGQ8A5vnNzVIy/PBQXYpqg++FttO6PWIkEIpQ6xLaKDpCqD3mP4fdvyEb3OC0f
	 um7nImGeOvI5X+gCC584Mj1geN6YRZMzl0/ZZe8ixxpHV0UEOe+DdmH012X8/va561Djk
	 kPKJzb/PEG2HWgfty6XMazBievmpAtDR8RNmfuZPWB2XmpMw7wJhJ4+ocg0ugiNZ4Tnhk
	 NzZ2b/x/NFXMfpYeo29Qjoa9ptcdqYzU+2qoRXa+uMvXDAqdk/NNj0Hv8k2cQeWia/iy5
	 W7Zm6PJGiDFVAtE4D02f0s4RGE3ug60IGONF8x7APZz/80+gmKJmjJrAUU/rRFgcB0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794024197;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3J0lIxiYaVVBVMth8TSBMCQafEXS9qddAR94GuwLLN8=;
	b=HUo1/2cMMH0G2SV5M0fJaUYOHWEvyoCjxrU+93pGoFaX720H/6PvtwHVvHu6cDtZ8qtU
	 RpbJWO/RMwV8Q+ZVw4W82SeTziQ1FmgiuIQ/AknlA3kS7V8FNzUhF4iCa5MeXCZwCqBWd
	 LyeVs6tLNqo8z6l91g/PNq1gkpNc91rehaLJBWt9l5eDKn6wOn2TgbXqi9f0cqNGtzkrl
	 fJ8IleyyQAaPr6TJ7/XqTz8cxh3GfqEHjIHIt73LFp0V8Sofc5laUV/TheIqmySEwDEIK
	 6DMrYWfrYbNSPH27w1Wkz1KKjcwxE86HuA9jkJyEXVninRlBRc6Gbglb2u1YUDM3E4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCV4z94w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B38F606A32C
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCV4z94w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7121F008A1;
	Sat,  7 Nov 2026 04:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794024197;
	bh=3J0lIxiYaVVBVMth8TSBMCQafEXS9qddAR94GuwLLN8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PCV4z94wJvynVFy72JlzxBcXguXb6F7bs2hHROIqNRMVKlmEVMspu94ttmZs24QvB
	 Yccs1da76Z12vP98PGmUeXQS5E6AULZvCv2K6k9MMiHzI+vW5F951L9x6NlDVuaHvu
	 eXiKihSgGKY00bApvy40MYqookq4azvbTiOO/4JK7CYXriyRySn0t//LdqD/Grgtn1
	 b/eLUIrI5fvJ8L1N/K32x2pQZJC9TT+YpPHQn4lR+HOl3ftMq0gvg3vzWNy+Qir4Uy
	 9BiYKgbXygYWRr+s2vEWQZnkSZatKLCtKBaka6mh9j3nn+aLUsMeunBEz+7ujmftgD
	 eVZGAlQKDbp1w==
Message-ID: <sashiko-outbox-202551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 26/46] bpf: Update comments about paths,
 pruning and explored states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261107033758.1547725-27-alexei.starovoitov@gmail.com>
References: <20261107033758.1547725-1-alexei.starovoitov@gmail.com>
 <20261107033758.1547725-27-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 04:03:16 +0000
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
- [Low] bpf: non-standard multi-line comment style in updated verifier
  comments
--

commit a631e21cb29a0618e130f63e9c4f9c8e4eb63371
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Update comments about paths, pruning and explored states

This commit updates verifier comments in include/linux/bpf_verifier.h,
kernel/bpf/states.c, and kernel/bpf/verifier.c to describe the CFG fixpoint
and state joining design instead of path pruning.

[Severity: Low]
This isn't a bug, but several multi-line comments updated by this patch keep
text on the opening /* line (and on the closing */ line in
prepare_func_exit()), whereas BPF coding style places /* and */ on their own
lines for multi-line comments:

- kernel/bpf/states.c: func_states_equal() (line 659) and
  bpf_state_subsumes() (line 735)
- kernel/bpf/verifier.c: the bpf_check() overview comment (line 63),
  process_iter_next_call() (line 8921), prepare_func_exit() (line 12576),
  mark_ptr_or_null_reg() (line 19249), and process_bpf_exit_full()
  (line 20713)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107033758.1547=
725-1-alexei.starovoitov@gmail.com?part=3D26
