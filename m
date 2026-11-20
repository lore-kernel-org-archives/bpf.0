Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211473;
	b=eqdzLZ6HKoTk9I2YcLP1qLmidJ11kJucI5Zj+Y3wfaALY1quY74wUULG0hszDdVzPlt1
	 OsU4dTtqOZFERdPS821QySAD+AqeFlb+EQ4wkANPzmMMN9kwVs2Y2c3G4Ntj4hnvwM7+6
	 yjvlIRj7IRBTPA3A5nT5WHUK3oiInnBO3C8sRtPukVDQ0t8UT6pc1Hzfu6o7kEDI+dfEJ
	 oIOzDZJqQaE4eOrulamD2M9fb4tlcRAZN1dg7e4LzQ0TDbgy5oKCk+PTqqqhvyar+KUEq
	 /JMyylnk8n4bYEDg944MJdu7gqd1xECmLgpWuJJFFh/uaQPAtpIRj/KyoldYsluLYwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211473;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=jy5Ilp/gvBAgPmJdFM5GVvTEs6BssdctfFKdsphxSk4=;
	b=ZtftOKYde0Mbg1dTiWH3Ugg33W0OEasgOkoEj9Oen9+X3q8DSvOD09L/Ke9V6a3qYIu3
	 a9lypFA3qzCPoX2Sh3K/1btioKGj7wI/Yq5X89Ox94wot1szyY5a7tyFLTwxfyOp4g1J0
	 uL8lqbj/pA/WBQK6XS2Xnu6FJcbwgNxAz/cc/M+g15vYX/hCVgH2Al53AzP91w5iu7nu8
	 KkDiKVySmtH/Bd/lVKsPW5emtkvIHHebZmPP+6m48vk7oNPsaKc38kkij72CZQhQApZfA
	 sColdu/wj6m9AzKuaLRG0MPIg3qTU2yxqZlbYVxxjrbkw+qVjG+5T2EzlO5YdTMDhcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gl+i703Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D3606A6BB
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gl+i703Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E361F000CA;
	Fri, 20 Nov 2026 21:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211472;
	bh=jy5Ilp/gvBAgPmJdFM5GVvTEs6BssdctfFKdsphxSk4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gl+i703ZbtU5ZQ+264/+REIOEBSigbVPwe2uKOSIPDJvJHS8BGCwDsNBeQO/sOWPB
	 nMjAjQIomHuPcOvulhoTwYRI6do2cq0o68jQnuHNncbIDC9cunfiMKKchZl4HrjJ83
	 Tvf173Df8gvB2KU2SQ4uF2CMAPVyuTDilVdmSCE5I7jvhQBBj48SfRuzXI74qyyAKz
	 xRbTxuzGvMRmvRotngwacAPHH7Lp1fdrNcDUW2x4W5Ko6LnLax9lwa1LoOOeEOWyYs
	 2I86z2IpfxeP8S0GRVvwqOnJy8SfymqpnnCZmuZbO3ZEJy03qZkiGKFeBcy2YMwYkC
	 wqugyTamIQASg==
Content-Type: multipart/mixed; boundary="===============7009209547116001513=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a94a293d7edfc5f57d51c1e421fdd056b74f82f877a528ef27910e26954a2cca@mail.kernel.org>
In-Reply-To: <20261120204959.614908-49-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-49-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 48/49] selftests/bpf: Test equations
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:11 +0000 (UTC)

--===============7009209547116001513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test equations

TL;DR: Test issue: in verifier_equations.c, the __msg() on
past_64k_keeps_range_bad is written inline, so it likely always matches the
logged source line and may not check the intended packet-range error; use
BAD_PKT.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_equations.c b/tools/testing/selftests/bpf/progs/verifier_equations.c
> new file mode 100644
> index 000000000000..e88d6ff0ca8e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_equations.c

[ ... ]

> +AWAY_AND_BACK(near_pointer_keeps_range, __success, 1000, 7)
> +AWAY_AND_BACK(near_pointer_keeps_range_bad, BAD_PKT, 1000, 8)
> +AWAY_AND_BACK(past_64k_keeps_range, __success, 70000, 7)
> +AWAY_AND_BACK(past_64k_keeps_range_bad, __failure __msg("invalid access to packet"), 70000, 8)

Is the __msg() check for past_64k_keeps_range_bad able to fail?  The header
comment of this file says:

  The log has the first source line of a macro call.
  If __msg() is in that line, the log always matches it.

and BAD_PKT exists so that the expected text is not written on that line.

Here "invalid access to packet" is written inline on the AWAY_AND_BACK()
line.  The rejected load is retried with log_level 1, and verbose_linfo()
prints that source line into the log:

  ; AWAY_AND_BACK(past_64k_keeps_range_bad, __failure __msg("invalid access to packet"), 70000, 8)

so the strstr() in validate_msgs() always finds the pattern.  The subtest
then passes for any rejection of the program, for example a failure that
only shows up with the far 70000 offset, not just the packet range error
at off 8.

Would using BAD_PKT here, as near_pointer_keeps_range_bad does, make the
message check real?

  AWAY_AND_BACK(past_64k_keeps_range_bad, BAD_PKT, 70000, 8)

> +AWAY_AND_BACK(before_64k_keeps_range, __success, -70000, 7)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============7009209547116001513==--
