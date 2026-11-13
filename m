Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549152;
	b=wMJ0TqLUXt+GfmWvDEbLB8kdqXFxLQVWWnu2Mjvbdvtx/tASz6W8O11tG04Frr/hNHrX
	 Uzi6955Msnrpk57t40a+xpFQSJSapmtUMep8Rf1n+q10i/+4PXfmyMlMHb9sHyRgynxD3
	 0Pqwk58riiXBXyDwiJpybzZnUwGl8mw3o0lSIjG/Qo9JVQlkuuQKXzfq9n2zrAe4kNebh
	 8nUcqpd77SyLe/a4CbvYrgKwAcmY0/0Z1JhX6zkZ9z2URb4tHww9+daYKv3qUO7SUyxRa
	 5f8j6KeBDIGVmXws+TDKah5P88GALuMDolLxspyI361wPmFsR+t8k33LlT3OTiykpHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549152;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=9wqQssDPoJHmbzGXzglM/a8mbfK/BhmoyrLoXUItW5g=;
	b=EZY6Ag4E3206/SFFeZZEr3ihHqFI99fwR6SGxndLh7D2qAMeP88rbCkxwscI89IBsSrS
	 JqwVtE+YB+s5dAm5mEEk8RqMLh4DVyrrywpnoXXADS3HVGq6LJQHdfJdUlDujsFjFNJIz
	 +/06Ep2m6jXQ1sP1hONurDa4SBUUH4+gXfDJozYbl3TW17dkP35/wTrpQnU0K6PV1yqO6
	 j+pGKD+kzNX12z4D9a4KSyWCSm2mnik99VGveqN13GS7maulLBfDrtdwXZOJI/U76iJ/T
	 WBX3RuVccw+LjS8RWtSP4vXOaxfK++mhY/wYUsyF6UQhPZzDb8ggVMj1LBSnhAPWvyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hbv4Je0X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916DD606A337
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hbv4Je0X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B24D1F000C4;
	Fri, 13 Nov 2026 05:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549152;
	bh=9wqQssDPoJHmbzGXzglM/a8mbfK/BhmoyrLoXUItW5g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Hbv4Je0XEV7/vAti/p4myJzgbTHAqkgn6HaMIcmPTOfnLwBgYbfMv+qCRZT0D/IVh
	 uHB+0/XJpsFJj/CGxjj9MOEZRZcWd7s7nhwlslgafzEdwVjW4y6dzQHqFMf3afoM1m
	 zRiYhu8VTAItB/GuapZqy84i5dPyi6bbkfr3ktYmsAsFcgZ2Bg5zdQKo+m6SX4XHId
	 fJE/cMAneidD+Syyw785VKc4AJG3XsvxwSFUpxlInNVfnToTIXpioQOid8Z8tRKDBr
	 U0QLGqQTZIVEmOulclQmUE+L3BTeomlj9DbAkZClkaQfZ++zuruuZMzKhlSn4dimv5
	 uN7yJ3wN3Z/HA==
Content-Type: multipart/mixed; boundary="===============5653382077753049473=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <cdadf16f205392dbca1eabedeb3123c4b4ff7512d74b4c7f52f4b6b8f671a48e@mail.kernel.org>
In-Reply-To: <20261113050901.1399091-13-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-13-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Treat the type of an untrusted pointer as a hint
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 13 Nov 2026 05:52:31 +0000 (UTC)

--===============5653382077753049473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Treat the type of an untrusted pointer as a hint

TL;DR: Test issue only: flipped selftests now pass via untrusted pointers, so
comments and names still describe rejections that no longer happen, and
btf_struct_access() variable-offset checks lose coverage; consider updating or
using trusted pointers.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
> --- a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
> @@ -482,8 +482,7 @@ int flex_array_field(void *ctx)
>   * not match.
>   */
>  SEC("syscall")
> -__failure
> -__msg("invalid variable offset access into struct vring_used")
> +__success
>  int flex_array_unaligned_step(void *ctx)
>  {
>  	unsigned long i = bpf_get_prandom_u32();

[ ... ]

> @@ -511,8 +510,7 @@ int flex_array_unaligned_step(void *ctx)
>   * The flexible-tail exemption must not apply to that fixed array.
>   */
>  SEC("syscall")
> -__failure
> -__msg("invalid variable offset access into struct unix_address")
> +__success
>  int flex_array_inner_array_out_of_bounds(void *ctx)
>  {
>  	unsigned long i = bpf_get_prandom_u32();

This isn't a bug, but the comments above flex_array_unaligned_step() and
flex_array_inner_array_out_of_bounds() still describe a rejection (the
stride does not match, the flexible-tail exemption must not apply), while
both tests are now __success.

Both tests reach the kernel type through bpf_core_cast(), so they hold an
untrusted pointer, and a failed walk now gives a scalar instead of an
error.  The tests then only check that the walk does not crash, and no
longer exercise the variable-offset logic in btf_struct_access() that the
comments describe.

Two other flipped tests also keep names that describe a check that no
longer happens: correct_btf_id_check_size() in map_kptr_fail.c, and
"map_kptr: unref: correct in kernel type size" in verifier/map_kptr.c.

Should these comments be updated to say what the tests check now?  Or could
the two flexible-array cases use a trusted kernel pointer, so that the
stride check and the flexible-tail check in btf_struct_access() stay
covered?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43372129532
--===============5653382077753049473==--
