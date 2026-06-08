Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16518246BC0;
	Mon,  8 Jun 2026 15:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934208; cv=none; b=G9LD26ARYDi+AJ/aX4fJ0F4+18E9kBwn+t3Xqnk0GiusyDldLJjbCgb094L9GMc4ZjyGXkEv+6X8X4b+kzDDJevOlmvXFLEfTwarI7qreTdJqXyNdzGvRGwjOGhaejrz9yagnSI1ARiYOKYrS9aW9na/pzCSl9vJonjjCAu3PcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934208; c=relaxed/simple;
	bh=llWfrzerBUN7P3dWZ3mbH60SFdg2/wgYwjLD96wLuSA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Wvq1032cVj9oaSlYsxI4+gfgBTpH8eEN5z83FeSwsWikmCaQysrBPEeyLpVt4nqq9rNJnGZnRufAyTm2kE2NzKvGKXdUkb2qwtYq2TR/4WdPitRYMVXnj+Z/2XCNwNok2dsflKuFcKiPl1cqwEj5aHGCna4fZaffCL60MCMLM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUb8ql96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUb8ql96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189E01F00893;
	Mon,  8 Jun 2026 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780934206;
	bh=YUvXvRme0KQ6SDRxfWBQEQX9hoBdn5xz97TQef5u+78=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cUb8ql96PzgYE+524+Sv1ey8jQJsJbuLz5bQDmcMOFFZcVRS82HwJiSTG2wMjDhFs
	 i4aIwYKj8kaQz6hqTM08jVrllX5Dj5XLA9PyrMchpwebyjmD8Zzwz5bcgMZsnaPRQs
	 pcYWpOjXbfCf2Y9vi/N0K6MfGyEGzZedop0u1fW/DwMl+WDyssJNF1ftQ7zTK/9Yfk
	 Lpqsvt25xkU2STmjqXcz/UIVDfgujZwRKOTWwc/6ZVIsvjRk3DLgrpmx49GeVDjS8A
	 S7IEFIeW56ISGD/s6gn7z5FaYIiMm6Jk5LvTP/b1Ti7BGdpRNThkpQgxls+E4tNvFo
	 ksgjEPV78sMOg==
Content-Type: multipart/mixed; boundary="===============6158332718169548460=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d2a502a8663b9f28e4a55e948cbf70fdec01e3d71417816b534c002b467d718c@mail.kernel.org>
In-Reply-To: <20260608145113.65857-3-leon.hwang@linux.dev>
References: <20260608145113.65857-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v5 2/9] bpf: Introduce global percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 15:56:46 +0000 (UTC)

--===============6158332718169548460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> index b2a19acadb91..5787246bef30 100644
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -182,7 +182,6 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
>  		u64 val = 0;
>
>  		if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
> -		    map->map_type == BPF_MAP_TYPE_INSN_ARRAY ||
>  		    off < 0 || off + size > map->value_size ||
>  		    bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
>  			*dst = unknown;

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2690d063a240..eecd9ab82e91 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5556,6 +5556,8 @@ int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
>  	u64 addr;
>  	int err;
>
> +	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY || map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
> +		return -EINVAL;
>  	err = map->ops->map_direct_value_addr(map, &addr, off);

Here bpf_map_direct_read() now refuses both insn arrays and percpu arrays,
which makes sense since a percpu value address cannot be constant-folded
at verification time.

The const_fold.c hunk above was adjusted to cope with this: it dropped its
own BPF_MAP_TYPE_INSN_ARRAY pre-check and instead lets a bpf_map_direct_read()
failure fall through to "*dst = unknown".

Is the equivalent read path in check_mem_access() missing the same treatment?

kernel/bpf/verifier.c:check_mem_access() {
    ...
    /*
     * If map is read-only, track its contents as scalars,
     * unless it is an insn array (see the special case below)
     */
    if (tnum_is_const(reg->var_off) &&
        bpf_map_is_rdonly(map) &&
        map->ops->map_direct_value_addr &&
        map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
        int map_off = off + reg->var_off.value;
        u64 val = 0;

        err = bpf_map_direct_read(map, map_off, size, &val, is_ldsx);
        if (err)
            return err;
    ...
}

Since percpu_array_map_ops now sets map_direct_value_addr, a frozen percpu
array created with BPF_F_RDONLY_PROG satisfies this condition (it is rdonly,
has map_direct_value_addr, and is not an insn array).  It enters the branch,
calls bpf_map_direct_read(), gets the new -EINVAL, and returns it.

Does that mean a plain LDX from such a read-only percpu value is now rejected
at load time with a bare -EINVAL and no verbose() message, rather than being
tracked as an unknown scalar the way the const_fold.c path handles it (and the
way insn arrays are explicitly handled in the else-if below)?

Should this branch also exclude BPF_MAP_TYPE_PERCPU_ARRAY, so the load falls
through to mark_reg_unknown() instead of failing?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27147120330
--===============6158332718169548460==--
