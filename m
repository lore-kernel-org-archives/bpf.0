Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795067691;
	b=0tLpj/lGfjscj3nZXfOQDYgNdYg5jcQBZ6rUiZdnc7sWcFYsNEaNTLNzLatm1i6T97Uf
	 R5Zg8i8oW2ZyFaVDa7HzKoSSYUHqRzcwAlPl2tpO5g6P4pkzPqsW2JZBGKSyTcqObsCc0
	 u43L6ZnOaOZGNj6rK43PWlWgBOcvhSuMiAtP2xL8sUxpn1JdExWez3iAPd+2Kdao3e5lm
	 lHRAEEnV0BCvhU/ZJwsYaiw58CT9W6iPxO3U769ybFhnVID1keTQ+ZXTXRtAcCcDefoHA
	 6FowwiLpYNk5l28/3Tgg2ofWbsNKx6a0adSLoN/JcW3jnkMZm5EGrI5LIgjICN4Nbfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067691;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=UwyCHZ5Si8ZvWhJjHvroOZ9yrZ7pvY5Qd7BfWI8Qgts=;
	b=CgiUwTmuW/EFIA5w3LAHW9vteIrI8OWI3EMNKDTSpMyARFdTKShhJpkZh3nVhCLcOyqr
	 nxmBZf++KYZn2YG6Y1hze1+411JTdF9EPtYvgYDeuuBLrrbDByFka3E6VdjhP26+TscZq
	 KVfvPvt8gOU8XPzMp3utHyXPizhoyQstGIclye8713KKFEEqVKVCL/TUoqL6uIvQ/wp7Y
	 KY1Ie/ysMvfVkui5t3+FTL7FLZge4WfbWzWzYDfmcMnb1I3jlt+oPFGhDN165LM5JPSHT
	 HsJWQqn+2aiXXXBfR00CVLEEae0+dH5IIGsmFp+fpdAmlTSmzcjYA8hKQ6ve09E+OCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrMGOfsD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E12606A332
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CrMGOfsD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379EF1F000C4;
	Thu, 19 Nov 2026 05:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795067690;
	bh=UwyCHZ5Si8ZvWhJjHvroOZ9yrZ7pvY5Qd7BfWI8Qgts=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CrMGOfsD3PnbiXU2yHbMXnf8d05mr2lK3LgjvS6O8FYVbpYpU4KxEXdAopyEK6qXh
	 Ff/7GoMUnLBI/4wYaFPfxARJ9i457qgKq7RZmCol28m+oLnEqJC2RuPegnulm8LSyI
	 yl2KXO5I19mUAC13FgO3Xab2Hahl70MVf0MIqbhFM17aAdhccESEsxkQvQMxnlYMMI
	 6aISRSKI37MZR+Ts5ydR/K3ATzHV76H0h3PkjUBppTDUvUnY9wB/U+t4YDsOINL6CX
	 adL07Bzbw1O+KajswA8yzvR/0Pk+ZzaBHyMmllFmw/rlK+E4AoXMaFjW+7jtMM752O
	 zdgdUrXtqLXwg==
Content-Type: multipart/mixed; boundary="===============0023687075468440993=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d711aef177c86b8b225bdf52e9b0a47894d8ec2f2b5432010c78f3a275501d43@mail.kernel.org>
In-Reply-To: <20261119051448.1902442-1-yonghong.song@linux.dev>
References: <20261119051448.1902442-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: Zero-extend unsigned 32-bit enum values in CO-RE relocations
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 19 Nov 2026 05:54:50 +0000 (UTC)

--===============0023687075468440993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Zero-extend unsigned 32-bit enum values in CO-RE relocations

TL;DR: Commit message only: the Fixes tag may be wrong, since the
sign-extending enum read predates 23b2a3a8f63a and was introduced by
eacaaed784e2; the tag may need to change.

> libbpf: Zero-extend unsigned 32-bit enum values in CO-RE relocations
>
> [ ... ]
>
> Fixes: 23b2a3a8f63a ("libbpf: Add enum64 relocation support")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

The sign-extending read of btf_enum->val in bpf_core_calc_enumval_relo()
predates 23b2a3a8f63a, which only wrapped the existing read in an
if (btf_is_enum(t)) branch.  The old code already had the same __s32 to
u64 sign extension:

    e = btf_enum(t) + idx;
    *val = e->val;

The sign-extending read was introduced by eacaaed784e2 ("libbpf: Implement
enum value-based CO-RE relocations").  Should the tag be:

  Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocations")

The unsigned-enum (kflag) distinction was added later, so the unsigned
symptom could arguably be dated to that, but the faulty read itself comes
from eacaaed784e2.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44465301903
--===============0023687075468440993==--
