Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAA44A2063
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053023; cv=none; b=qmhytyE8MK9PcTKB+W0Ipf9d7Y7GFtwWBBa+kczKuifAU4ZOP1JmbS+LQOu7Q6jqOmHg/OcqMGUmRoRSM4uGXna1i5S0w3JoVgfYJ89haDYvsICXCkWwmzx1o0qA6PuudPfSjNiA2zleC4sch2WZdvj/A3hMKXKO7539siardG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053023; c=relaxed/simple;
	bh=UyPDSSASOMNZVeYsgnd+t2hPI8s60c2DrN5k/6dlnmo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=GBFvloHqq6HaOPb+Fyb3hNp0tJ4YuktYOoitXV8i55vyAthZatT5fhMksOHzQtK/VjlU+U0wrSXRICDNvhZnTt8bBV/5IBSAZVmDV1kusgNQBigFHuhFQsTnvITDRB+pAeMg0sDeA88zDUtJhEdZE6QRsfZJ7s/T2UIxmxDQX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfMvv8PW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfMvv8PW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764CA1F00893;
	Thu, 10 Sep 2026 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053018;
	bh=WdErTEDZU92CYrnQblteQIRxoOexh7qEYjnO6ovxgbg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MfMvv8PWXnw4NaO6cu7RQygRsdqRCrv4EDvUI2LiWql2H7xWEnVwjYLABq4wfi+CE
	 BEP4AFcdBUEPjS896/c/1SOiJR/v2I1GnkYrvU2/tA84ZGPYot5U9ZHLRg7hHeWIDX
	 IEKijFdlYMoGkyqd+u9/+hsaVNB87MwOafENArZ6dMYjh3mXG2/8icW1OzJa4q7ILn
	 O1RFyDoQslJ5wot0eoORZ/htINbvoUwzTifPHLC730wKGJB38Tab/ZnM0TjuwvqIOw
	 9UiiVItCXAToi91h+x72ibXfNzm+0R4bz2v+N+XctL/2RJ4nVMIQdiW4QhgG/AqqmD
	 oSD7Rsb6tA4zA==
Content-Type: multipart/mixed; boundary="===============1767228951974674174=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c9888022d9375c377fca055eccc3086be4775ab4f3266760d29d1f9e3f01dc3@mail.kernel.org>
In-Reply-To: <20260910142107.40582-1-daniel@iogearbox.net>
References: <20260910142107.40582-1-daniel@iogearbox.net>
Subject: Re: [PATCH bpf 1/4] bpf: Add KF_PERFMON kfunc flag
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,ast@kernel.org
Cc: memxor@gmail.com,eddyz87@gmail.com,info@starlabs.sg,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 10 Sep 2026 15:10:17 +0000 (UTC)

--===============1767228951974674174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add KF_PERFMON kfunc flag
>
> Tracing related BPF helpers e.g. under bpf_base_func_proto() are gated
> behind CAP_PERFMON. However, the same is currently not true for kfuncs
> and they are accessible via plain CAP_BPF. Add a new KF_PERFMON flag
> which can be used such that check_kfunc_call() ensures env->allow_ptr_leaks
> is permitted. This follows similar pattern to existing KF_DESTRUCTIVE flag.
>
> The rejection returns -EPERM to match the other CAP_PERFMON gates in the
> verifier, that is, check_ptr_to_btf_access() and check_ptr_to_map_access(),
> which report the very same policy to user space.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

This looks like a security fix. Should this include:

  Fixes: e6ac2450d6de ("bpf: Support bpf program calling kernel function")

The bug was introduced when kfunc support was first added in that commit,
which created check_kfunc_call() without any capability checks for kfuncs
that can expose kernel memory or addresses, even though equivalent BPF
helpers in bpf_base_func_proto() were already gated behind CAP_PERFMON.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34490344966
--===============1767228951974674174==--
