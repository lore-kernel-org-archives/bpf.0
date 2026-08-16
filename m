Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A348D223DFF
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786848337; cv=none; b=gn8VfYv0sADlojCvhbX8kUbi5Z0dlxu22MsGU+i1nb1/4ZV0lkqKeixkXR8uyCvaDy895xA9J+fSvpg4DImmu1F53FodxO58nXpGt739zh1TrySOqNHRh6zXVK8J9dAgZl6+K1z2JxAalyNtDp5/e82DqBFHk6dhJD2j8kTnDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786848337; c=relaxed/simple;
	bh=33UyrlsNFsmSy9jam6vOSHmbPlwVac86/W6MaiJpizI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WCVClbI3iy1z7a7VZKUDm1JfecjScAprXMhuRyTVmdWwKBko75X0NZ1g0PPc0zwmv9AzrxVzwj4cuTYrlnSyefx0sGFbb6sxnhqqR8a/K+gwxez1Rr95SjxQvygdBJy4zniqC4qTbhKH1qVAUIUlUchTlsKmJdQAJUkp6A4W5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tn6dRReY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tn6dRReY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B2C1F000E9;
	Sun, 16 Aug 2026 02:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786848336;
	bh=qSkbUGX4w8t3JVSTmqLdB4/WoyYgW2kQX6wgugC0VAI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Tn6dRReYH6dYYpr17eMBGJACGwelgcIV1LivoRUKKJ6XP39JSuHZp/lQUS0I2nJlQ
	 76kYRylZyKIjYXsNri5NNwjskjU8qhQvPhElcIcfbnA4wzUVOUcbWHfpiGDpf4pApI
	 DLkxLStTY6H84vM1uYCQYvT9YUkErgap/8zkLMwo4Z0l9gvX3UiXDa2SqIhX8iqhai
	 9Km6jCK8oeQFgl40BnV+McYXNVFa0N/VgHL432cbbl8JA5XhBiZRWy87a6SyBXcBQq
	 YpRS1j8h2F+KacDEQnDSt0u6lVt3oLax9j+q7df7Fu84GsHE2lW2pdUO3UjO65DSGh
	 gOqPOBNadg8Ww==
Content-Type: multipart/mixed; boundary="===============0544100852628332932=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <592feb16031b652d6ae99546a346625838e8a52dbff431764c2c4ca02a9e8d0e@mail.kernel.org>
In-Reply-To: <20260816015746.2632990-15-memxor@gmail.com>
References: <20260816015746.2632990-15-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 14/14] selftests/bpf: Test pseudo-function policy diagnostics
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 16 Aug 2026 02:45:35 +0000 (UTC)

--===============0544100852628332932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Load a socket-filter program that passes a callback to bpf_loop() without
> making a BPF-to-BPF call. Verify that the privileged load succeeds and the
> unprivileged Policy report identifies the BPF function reference at its
> ldimm64 instruction.

This isn't a bug, but the changelog says the report is verified to identify
the reference "at its ldimm64 instruction", though the added test asserts no
location at all -- only the three wording substrings.

Looking at the verification flow, prog->aux->linfo is assigned by
check_btf_line() in kernel/bpf/check_btf.c, reached from
bpf_check_btf_info() at kernel/bpf/verifier.c:21164, which runs after
add_subprogs() at line 21157. So bpf_find_linfo() returns NULL and
bpf_diag_source() takes its fallback branch, emitting a bare "insn %u" with
no function/file/line and no Source context block.

Would it be worth either asserting the instruction location the changelog
mentions, or softening the wording -- given that linfo is not yet parsed
when add_subprogs() runs, the "At" section here can only print a bare
insn N?

> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> index 42de5cff7e52..3069e70fbcbd 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> @@ -96,6 +96,24 @@ __naked void pseudo_btf_id_log_masks_address(void)
>  	: __clobber_all);
>  }
>
> +static int pseudo_func_callback(__u32 index, void *ctx)
> +{
> +	return 0;
> +}
> +
> +SEC("socket")
> +__description("unpriv: pseudo function policy diagnostic")
> +__success __failure_unpriv
> +__msg_unpriv("loading/calling other bpf or kernel functions")
> +__not_msg_unpriv("BPF-to-BPF function call")
> +__msg_unpriv("policy check failed for BPF function reference")
> +__msg_unpriv("avoid BPF function references in unprivileged")
> +int unpriv_pseudo_func_policy(void *ctx)
> +{
> +	bpf_loop(1, pseudo_func_callback, NULL, 0);
> +	return 0;
> +}
> +
>  SEC("socket")
>  __description("unpriv: return pointer")
>  __success __failure_unpriv __msg_unpriv("R0 leaks addr")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31921026518
--===============0544100852628332932==--
