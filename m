Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407764756D1
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657483; cv=none; b=aGflzxOpXuFD7x/+tg9tBfwNFXQA8U2m/hBnCKb5GVPG9ziBIKaRWk5k+PHTr47ekZxNHvOcstmhtCc8NaBA7fyAbDC5RPvuFh7EQpER441iAEvbeDEOWtJKUJa2Jevh3GFcvfhFRCNsnma5Jma3bycg4WuPtnNkZ88HXZ23CnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657483; c=relaxed/simple;
	bh=0KveDcv2Y/YNV9v+prwlF1PB9zOxLdjhpcB3Igf9aZA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YE5qZ5ryxTxoCad4KqZUOTX0aeICg/9skZHsyW7l0UIyaupt66Kljo1+3gMqm/EVFtimeYStQOddFPlzriL+cxG/R/PBr4+cqI5rP7uJxErZqjC5fwOvYNw3y/sYnEJBDuIqpHHG03yB3OSZqCk4qPUHpVbXWcDT4PRCdDDqzKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+s8FEyV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+s8FEyV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6199B1F000E9;
	Thu, 13 Aug 2026 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786657481;
	bh=FJT6g9mXh60zH+mVOieec1W8aQdAs9UkzXk9jDOb3Ts=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=R+s8FEyV+XVbaDa5yAzsCEAzv16KpoHnRtFYa4xcGvzEv/3uS4ZXO2Y7spLKO+tjV
	 LUwneH3BdvpmNVh0O6PqG3TyQOq1krtahs+sBwlqdHyOUI6BJtqHEn60XZiXpYbXCC
	 w/f/bMDZ+kitj7X9GctsUZx44xKJTB5mvCaVrNoP+4rUgRc6ISf3QkVXdxg6xH4vVg
	 /fp4pcaptVBwAuQrRFXy/2EFd0htY18qkyjG/P/1v0LKkoncmYc/z4Xwb/Fn4DP7MA
	 PsFqTUi1tS4hkKrKpqUmL+8P70Q1cPXePDTW1B2iUhBbnoYM+Qjo5l0kgmTMD4cbUM
	 TgifpurnGhmjQ==
Content-Type: multipart/mixed; boundary="===============6325040398020701520=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e69c09e324eddec182636a166bb50d7cdbb7828220155efdbc996fb0eeccdade@mail.kernel.org>
In-Reply-To: <20260813204032.644949-2-daniel@iogearbox.net>
References: <20260813204032.644949-2-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 2/4] bpf: Merge pointer types also when both are PTR_TO_MEM
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,eddyz87@gmail.com
Cc: memxor@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 21:44:41 +0000 (UTC)

--===============6325040398020701520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1f2ed6164305e..5daca4ef27278 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17096,6 +17096,17 @@ static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type typ
>  		 * save type to validate intersecting paths
>  		 */
>  		*prev_type = type;
> +	} else if (*prev_type != type && allow_trust_mismatch &&
> +		   is_ptr_to_mem_or_btf_id(type) &&
> +		   is_ptr_to_mem_or_btf_id(*prev_type)) {

Does this condition still leave a gap when the other side is one of
the remaining reg_type_mismatch_ok() base types?

Looking at reg_type_mismatch_ok() in verifier.c, it returns false only for
PTR_TO_CTX, PTR_TO_SOCKET, PTR_TO_SOCK_COMMON, PTR_TO_TCP_SOCK, PTR_TO_XDP_SOCK,
PTR_TO_BTF_ID and PTR_TO_ARENA. Everything else (PTR_TO_MAP_VALUE, PTR_TO_STACK,
PTR_TO_PACKET, PTR_TO_BUF, PTR_TO_TP_BUFFER, PTR_TO_MAP_KEY, PTR_TO_FLOW_KEYS)
is "mismatch ok".

For such a type paired with PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED at the
same BPF_LDX:

  is_ptr_to_mem_or_btf_id(*prev_type) would be false, so this new branch
  would be skipped

  reg_type_mismatch() would be false (both sides are mismatch_ok), so
  nothing is recorded either

  *prev_type keeps the type of whichever path was verified first

If that first path was PTR_TO_MAP_VALUE, bpf_convert_ctx_accesses() in
kernel/bpf/fixups.c falls into the default case - no BPF_PROBE_MEM rewrite
and no exception table entry - and the untrusted path then takes a plain
faulting load.

The commit message says this is being fixed, but doesn't this exact panic
stay reachable? The existing selftest ldx_is_ok_bad_addr() in
tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c already loads from
bpf_rdonly_cast(0, 0) and relies on the PROBE_MEM rewrite; the map-value
half is just a post-NULL-check bpf_map_lookup_elem() result.

Should the merge also fire when only one side is PTR_TO_MEM or PTR_TO_BTF_ID
and that side may_fault_on_deref(), or should such a mix be rejected
outright?

> +		/*
> +		 * Have to support a use case when one path through the
> +		 * program yields a TRUSTED pointer while another is
> +		 * UNTRUSTED. Merge them into a type which keeps the
> +		 * BPF_PROBE_MEM/BPF_PROBE_MEMSX rewrite when either
> +		 * side needs it.
> +		 */
> +		*prev_type = merge_ptr_types(type, *prev_type);
>  	} else if (reg_type_mismatch(type, *prev_type)) {

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31743446421
--===============6325040398020701520==--
