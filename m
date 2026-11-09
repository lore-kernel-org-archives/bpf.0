Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251137;
	b=0M/doJ4P6WW3KcogvBYF3EgNwskufLjmGu304rRzjJzudYzhfNdHAS0WqmTODnaUPvWv
	 D0s+BoE/1Q68sEzHSr0tO41OidK3B2z3NCKQ/b+iTRoqspjrXNxgRtAxoM3XT4EplU3gF
	 DlgGR4GXZFNryXFaBSRbvZZvVD8VEHPTmTx106HQsFtJDzhY23YVHFaPiGPS+VWzVuse8
	 G9xFW7YVoNWav/r1Ne1zwVV6zJyy4n+HXnI+p9PAq/A+rBc47vWhN9k1CTs7MzZgJ26yg
	 IsDkvO+/5qduUkzvjpQXGJHFmX52n6XrsicCRPk22Br+4wwm0WOrN/KSyAtd/BSD3nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251137;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=XpTQ3mJLAJBdpvNaVjmhIcbyn19GZxzOWD1WUFYihgI=;
	b=HHe3+C2aktdxv4ihBOoaEkLw0cwms/runZeDDmb1U84W7fxvmZOJIrpYd4f32KbucSSW
	 igM4Es6tm3PDBchbqUldtEnWjVIfqGsU3HXXQCo8KskiDhqIKnkWgm916ymUOHZjKNkq/
	 nUooQGarURvzH7H0Om8knS8Q024VUKGzLq6N07ZRmooErMJPL5b6aQcFclpGlYoROqaWP
	 TpRaggfp1HYgXoHBFrgbcfXSLTONElKSwaVCfLPTvhcmVt3luK35oq2dZTxNG/nuhcPXB
	 kjc3oZ1/Meg32huwJCTiDOT7Ws6L0zytWw98EYoLloR9Ttmm4vMrSeay/Fbs/cGSbmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZ2uu5fU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB09606A333
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZ2uu5fU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D301F008A1;
	Mon,  9 Nov 2026 19:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794251136;
	bh=XpTQ3mJLAJBdpvNaVjmhIcbyn19GZxzOWD1WUFYihgI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JZ2uu5fUqMuDdtlQmjkQ34zXV2b6XjSHi3Weyo6zrEKJ/8XaR81B4Makwq6q2Ymrb
	 ekPNTN1Nr5f6OZmmWQSqSGJyRbNrG1r6LA8RVGM/iSS8B3D0uden+yBJWnrhF5hCdw
	 XfkSV7WV02DP5gNv5WN/uhtVrGtcD2MAZxXOkk0WdIm9llXFVtA84pummzVqBByigv
	 BW9WnyydWDy38/1jMAXazitc1XGqXJ6hJLNWj1hpafsdqfwN5NnTdg9YufDKdwLa4n
	 RJkIs3ovUWQoQIv5/9UcBgEU29BbBs5aA4WyW+nrqdL3mwqzCC9PRJ3QsrhIs31UWR
	 Uf2kIE8cGpINQ==
Content-Type: multipart/mixed; boundary="===============7876086795751749501=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <fb426bec579082fb1b7695046ed43d9f87ef6c326c17fc2c14e02a346178a728@mail.kernel.org>
In-Reply-To: <20261109182055.7581-10-emil@etsalapatis.com>
References: <20261109182055.7581-10-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 9/9] selftests/bpf: libarena: Cover buddy cache fast paths
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,daniel@iogearbox.net,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 19:05:36 +0000 (UTC)

--===============7876086795751749501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: libarena: Cover buddy cache fast paths

TL;DR: Nit only, in the test: test_buddy_cache_paths() frees bulk[0] and
bulk[1] outside the loop; the review asks whether the loop could start at zero
instead.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c

[ ... ]

> +	ret = buddy_free(&buddy, alloc_path_test.bulk[0]);
> +	if (ret)
> +		goto out;
> +
> +	ret = buddy_free(&buddy, alloc_path_test.bulk[1]);
> +	if (ret)
> +		goto out;
> +
> +	for (i = 2;
> +	     i <= BUDDY_CACHE_CAPACITY - BUDDY_CACHE_BATCH_SIZE && can_loop;
> +	     i++) {
> +		ret = buddy_free(&buddy, alloc_path_test.bulk[i]);
> +		if (ret)
> +			goto out;
> +	}

This isn't a bug, but is there a reason bulk[0] and bulk[1] are freed
outside the loop in test_buddy_cache_paths()?  Nothing checks the cache
state between these frees, so could the loop start at zero and cover all
nine frees?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42676408513
--===============7876086795751749501==--
