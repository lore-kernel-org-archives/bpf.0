Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3693E8C50
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175809; cv=none; b=LJBl9Ts0ixlMvBanwMUiTBMiRjQSi14DZPtCNkEZz7RLj1uk+5+dPQCPrehaWDNezDAiFZWg6DIWbVHbLO7T8LxMIFFYPDLfSoy/QXqDbarBvA0DaS5jLXLeGH6dVxOcoDs7AGx/mYGs771gCfUipFz/7zIaAQ03ucVVZscQ9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175809; c=relaxed/simple;
	bh=myv2J1hmNetmeZvk0I6Hm50m017jG6Nu5o27ARXxvy4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=gAXwosRbAy8hdZAweJVFxcYfYo7oCIeU3kq/wPa5ZJ3FAY+MU+kY/mtgrgE9gQRdJKY5baHme1Pe5Ekn3XKuS+hAFwdGngZCE8kefGT/liYQej4Ujj4VFfkZfj0mahtJJZQTLJznIPfOAapFy1m1gFf+eQf46M3OjAsKFTE4how=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G67lTauS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G67lTauS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50CAC2BCB5;
	Tue, 14 Apr 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776175808;
	bh=myv2J1hmNetmeZvk0I6Hm50m017jG6Nu5o27ARXxvy4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=G67lTauSmPdoJBBgazxrxSvhyaOOdVd62StcHkI9zeTGqx8CJ0/dK6YxgiWjfgIaR
	 8EsDg0t7/p+Csomk0C0qbqFkU2hVzE8FoElyIUHHgNOn3LrBjW4+kHW1bQsTlYZAEU
	 2QIKiO90xtpOrL6m182kZlVNpt4khbcQWcGNPTrDukIduEvl8B8dLrpeTGj8Y5VwUq
	 Z/qAJEuiNFbM+YxknOdQYfYjKBr83NUkRMWpeRwzTuSFj3256Fge4AvrIKCwE4OGLG
	 /zxjQfqwT8KKB+BFJK0ve99nWVETIddlFaIHnWEsHng4uiitYlMGNhEYiclaLIExfH
	 0BRgUneDIgfuA==
Content-Type: multipart/mixed; boundary="===============9095934616257402327=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>
In-Reply-To: <20260414132421.63409-3-leon.hwang@linux.dev>
References: <20260414132421.63409-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,yonghong.song@linux.dev,song@kernel.org,eddyz87@gmail.com,qmo@kernel.org,dxu@dxuuu.xyz,leon.hwang@linux.dev,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Apr 2026 14:10:08 +0000 (UTC)

--===============9095934616257402327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1757c5720503..8ec24d63a2c4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6362,7 +6362,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  			if (tnum_is_const(reg->var_off) &&
>  			    bpf_map_is_rdonly(map) &&
>  			    map->ops->map_direct_value_addr &&
> -			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
> +			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
> +			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {

This correctly prevents constant folding of percpu array values in
check_mem_access().  However, should the same exclusion also be
added to const_reg_xfer() in kernel/bpf/const_fold.c?

That function has a parallel constant folding path via
bpf_map_direct_read() that only excludes BPF_MAP_TYPE_INSN_ARRAY:

kernel/bpf/const_fold.c:const_reg_xfer() {
    ...
    case BPF_LDX:
        ...
        if (!bpf_map_is_rdonly(map) ||
            !map->ops->map_direct_value_addr ||
            map->map_type == BPF_MAP_TYPE_INSN_ARRAY ||
            off < 0 || off + size > map->value_size ||
            bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
                *dst = unknown;
                break;
        }
    ...
}

Since percpu_array_map_ops now has map_direct_value_addr set,
bpf_map_direct_read() would dereference the raw percpu base pointer
directly, rather than the actual per-cpu address.  For a frozen
read-only percpu array, the constant-folded value could differ from
what the program reads at runtime after the BPF_MOV64_PERCPU_REG
fixup converts the address to the correct per-cpu copy.

In the v3 series, bpf_map_direct_read() itself had a guard
(map->map_type != BPF_MAP_TYPE_ARRAY), which protected all callers.
The v4 moved this to caller-side checks but appears to have missed
const_reg_xfer().


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24401974087
--===============9095934616257402327==--
