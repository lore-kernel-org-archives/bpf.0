Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E5913A86C
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549032; cv=none; b=Fq/ncgAltOuVJ2bprpv+TgwsXbMkIjPF1bDxXD8Nq/bOpB2M1XDvjgtj3xzfuDh8iv7jgBBJmmRS4A/efByHG/5q2gelUR29aGXJSA+K5JdufkEZFhMUIdycvvxyk9KlfLoilEVqpd/mJW0k+QAKub0sDBA4JjpRMCYsGgIWbwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549032; c=relaxed/simple;
	bh=MX4A9WUCjlz3c/NA8JNTYbwYXnCDRxhUzC6zMWhisiw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Pdoy16YbcNlm2u2d9hSp69Mw129BeqwAIfvqPpgCqmQoPmdi//yAtB28PispVhVq1Ur06w8uTSnHCTmB3mGi0O9u9dinn+VnAxVgpu70QTlv4Myc4TQtzy2MWeD6+RPAENxc5PpjF4GFXt8fAOZxlBdaIovG9jmCyBpHWQt0se4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eou8DqAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eou8DqAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8A71F000E9;
	Wed,  8 Jul 2026 22:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783549030;
	bh=sHVcllaLzJrBLQ+/feMYoJ6kwKFdhtYSflTb9cynD2I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eou8DqAbm6PE5g1tSmULXY1PXyXfUWc5OheoRS6Ula3Sajb5Ax8VoQRhima8uQMiH
	 CC9v4USTm4HYzuR8SmZa+uJUAPLZHM66fbDectuF/iHjmTMv6xCkwPRApveQJFrMkR
	 tzZqaXKmae6GikUNfC2Z43biogqkVucEKcBBWkXo6+wCow57nYXRhsqd0aud60fT3b
	 KNIOLz3RlIez1MQ+u8zENXd3/Dld8QpMzzVMpLqYHjUZw0/PtgDYdj+fdUd1IsjMqJ
	 AdtQLSqIyDA3WL/vRl/Mhwzbn0HA28+JjYH1K/xEFtwtNNNCBT2JGGRezR+0F1zvxJ
	 hi3mVf4o4nugw==
Content-Type: multipart/mixed; boundary="===============7021045581571313455=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d8b7187ee3e890b315359fab83153ae03edb407e101ce3f97900d5154e41cdb@mail.kernel.org>
In-Reply-To: <20260708211537.371874-2-daniel@iogearbox.net>
References: <20260708211537.371874-2-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 1/4] bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: ast@kernel.org,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 22:17:10 +0000 (UTC)

--===============7021045581571313455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
>
>     bpf_get_btf_vmlinux() lazily parses the vmlinux BTF under the
>     bpf_verifier_lock, but publishes the result through a plain store
>     and re-checks it through a plain lockless load. Nothing orders
>     the stores initializing the struct btf inside btf_parse_vmlinux()
>     against the store publishing the pointer: On a weakly ordered
>     arch, a concurrent first-time caller taking the lockless fast
>     path could in principle observe the pointer before the parsed
>     contents are visible. The mutex_unlock() does not help such a
>     reader given it only synchronizes with a later acquisition of the
>     same lock. Thus, publish the pointer with smp_store_release()
>     and read it on the fast path with smp_load_acquire().
>
>     Acquire semantics are needed rather than a dependency-ordered
>     READ_ONCE(): btf_parse_vmlinux() also populates globals outside
>     the returned object (e.g. bpf_ctx_convert.t). An address
>     dependency would only order accesses performed through the
>     pointer and not cover other globals.
>
>     Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

This looks like a fix for a real memory-ordering bug on weakly ordered
architectures.  Should it carry a Fixes: tag?

The plain store publishing the pointer together with the plain lockless
load appears to go back to the introduction of the in-kernel BTF parsing,
so a candidate would be:

  Fixes: 8580ac9404f6 ("bpf: Process in-kernel BTF")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28977272970
--===============7021045581571313455==--
