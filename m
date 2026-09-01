Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900463A9DA3;
	Tue,  1 Sep 2026 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256456; cv=none; b=sHEJnjd/V9/DKGr59Fvt4XrES+kimZ0dVZxS0GsnWBOWVbciBontEy8A2/zqmS1BKLcrBLv7oguKI9oDB044oPpv3KDjPnrTdkGMh0YPcWlq7U7hRWanXiXIehATDSSzOWDgjDO7nGaJm7aqMQYTERwjdbLUpRe7t/LikOVtXbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256456; c=relaxed/simple;
	bh=z9EicMUOaM3rG+OWnmtcrvc3BRTPXZG1G9KroAoYslY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NupvsLscueM3T9BcQp7wPHfavOa8ZnydfxrZ8LOLvgxEiBB+cuzhhmgWFwn1sNdfRJZYcabN21NzOLz6/Eq9HialmsIPZ13etT3KOWSCXg9fAOkNhOnVnDCt9/sYkNoa5EpM2chF6In9LWyM+qvl20cwliMJ82DeTnrKcr2CQsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUttv6/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUttv6/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988D91F000E9;
	Tue,  1 Sep 2026 09:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788256454;
	bh=LCH2ISJTlcWYHeY0eL7rdA0nk83xdfl2ZZrDBciLubw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NUttv6/AQLctgoMt0WD7hQebMJr4hHnDqCOPjFk5XHsVz6UZsRMuTZp8/55YAbhG8
	 8+ArYI00aLFhMx5IoWXB/n2dC4Yk8cDCYZzlyY6ZHQD09rx2daexHTidhEGyS1zHar
	 yC7kp+XcWkm0sl+wYlZ2YPS5Vdgimfk7kzZSUcp9lrWBlewBc8zYpRSt54O+E/1LUB
	 A9rAj5ZPDu/kXyzTKbvGgUmdalJDn8XJCyOk0QZtgiqdZiZgh3gkQiTao8QGoqHlk2
	 rN8W4MfxgpR8DYSs7pc9m7Kxwh2jbty2RwxxuPaSrfQ1UFGrZISb77h34+Z+GHrDNn
	 DWdWu2CNeoD3A==
Content-Type: multipart/mixed; boundary="===============2756755987579157109=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <486e478d8eeaec63726c1284ce5f60ddd3a1f7c24fa467317b77979ad38bd306@mail.kernel.org>
In-Reply-To: <20260901-libbpf-frags-flags-v3-2-4eb6f14968b0@redhat.com>
References: <20260901-libbpf-frags-flags-v3-2-4eb6f14968b0@redhat.com>
Subject: Re: [PATCH bpf-next v3 2/4] selftests/bpf: Set BPF program flags non-destructively
From: bot+bpf-ci@kernel.org
To: toke@redhat.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,larysa.zaremba@intel.com,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,lorenzo@kernel.org
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,toke@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 09:54:13 +0000 (UTC)

--===============2756755987579157109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index e8c1a619e330e..7dadb90e7b689 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -543,8 +543,10 @@ static void test_kprobe_sleepable(void)
>  		return;
>
>  	/* sleepable kprobe test case needs flags set before loading */
> -	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable,
> -		BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
> +	if (!ASSERT_OK(bpf_program__set_flags(
> +			       skel->progs.handle_kprobe_sleepable,
> +			       bpf_program__flags(skel->progs.handle_kprobe_sleepable) | BPF_F_SLEEPABLE),
> +		       "kprobe_sleepable_flags"))
>  		goto cleanup;

This isn't a bug, but would a local like
`struct bpf_program *prog = skel->progs.handle_kprobe_sleepable;` let
this keep the original one-line ASSERT_OK() shape? The read-modify-write
now names the skeleton field twice in one expression, pushing the line
to 106 columns. The other sites in this patch (bpf_verif_scale.c,
xdp_metadata.c, xdp_hw_metadata.c) already have a short prog local and
read as one clean line.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 2e0ddef77ba51..ed3fd0a88dab6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -362,7 +362,7 @@ static void test_attach_api_fails(void)
>  	sl_skel->bss->user_ptr = sl_skel;
>
>  	err = bpf_program__set_flags(sl_skel->progs.handle_kprobe_multi_sleepable,
> -				     BPF_F_SLEEPABLE);
> +				     bpf_program__flags(sl_skel->progs.handle_kprobe_multi_sleepable) | BPF_F_SLEEPABLE);
>  	if (!ASSERT_OK(err, "sleep_skel_set_flags"))
>  		goto cleanup;

This isn't a bug, but could the program pointer be pulled into a local
here so the flags update stays inside the 100-column limit? Repeating
the 44-character skeleton field name inside its own argument list pushes
this line to 121 columns.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33489985893
--===============2756755987579157109==--
