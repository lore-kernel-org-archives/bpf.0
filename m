Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5950D3E6386;
	Mon, 31 Aug 2026 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176900; cv=none; b=UvlvSp6L8gsEODeG/N6qL6j63obRRaQgWnsnEHahhgO373vopMM/CamAZMMTq8WePAeF0cjn+NXQhzvKZTGQvaHtnCUN1y6MCWAGP0lJK1ZAP88u6jZxMSr2OPWj5l6OPlVPO2SZ7TVPl/WiO5GlVeFPIu9gGlFNMz4L4w9tU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176900; c=relaxed/simple;
	bh=+V6Y3Pde6gHn13ADn8LysRRNptw4kQRoDwJzDVXLhVk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=furK2IXJoN84LQiJdwb03viqyDIp1DwXVyhVrma+uAu4igxhyKM3MkBZkmCOok9KJBeFv9R6N3moYWnd5MhdEk4zysZVMCfGkNQtwdz7oxf7OGp2XAsZwklRD5jpACWb8Lcs6GEQr2fTIkrEvW02fjmRWSWzEXUToeYZTf2vS7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TljHMCJ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TljHMCJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41CF1F00A3D;
	Mon, 31 Aug 2026 11:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788176898;
	bh=FlOuQOjntk+7Xr3dFLIMLBklGLrkdVUsybJY/VDn/tc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TljHMCJ43nazG3yQ8pyGjgMAbgtYwTFL5YmOOqJxPSQUOVWNmf6ILHVBTUF/TACO9
	 rAfcGVbwKVO17/uhFapOCUaapDWpA2GTCaar/JRVPErxyzVgWnDi4JdMfQLAOX26Yi
	 F0DqDBElHAUtBZuUWfj6KX6DqSXLaWFKYu5dU0Enm9SsCKPfJq9wXfJO+5a3EthayL
	 duxtapP1wpY5hBBbokrSAO4YLnN9FvJPIZ/omwUQ2bUjc29cv+tAE4G+dh6Rj+dWMG
	 sTOBsnTic+qWMsmrZXrDI4/mMGx7GeLL6UvCxts3X7wtJ0qJ8mdS4X+TZh09pn6RBq
	 4AijaTnFhcfeA==
Content-Type: multipart/mixed; boundary="===============2702627393202367961=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <116308d606e3bff21d07c01feb8741702547d1c32b1eafaad6f3628a776828fc@mail.kernel.org>
In-Reply-To: <20260831110314.150870-3-jiayuan.chen@linux.dev>
References: <20260831110314.150870-3-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v3 2/5] bpf: Fix NULL-ptr-deref when showing a void BTF type
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org
Cc: jiayuan.chen@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,alan.maguire@oracle.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 11:48:17 +0000 (UTC)

--===============2702627393202367961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Fix NULL-ptr-deref when showing a void BTF type
>
> btf_modifier_show() resolves the modifier and then calls
> btf_type_ops(t)->show() unconditionally. For the void type (type_id 0,
> BTF_KIND_UNKN) kind_ops[] has no entry, so ->show is NULL.
>
> The map dump path cannot reach a void type (a map key/value must have a
> size and void has none), but bpf_snprintf_btf() takes a type_id straight
> from the BPF program, and a "const void" (a modifier that resolves to
> void, present in the vmlinux BTF) NULL-derefs there:

Is this statement about the map dump path accurate? Looking at
map_check_btf() in kernel/bpf/syscall.c, a map key isn't required to
have a size:

	/* Some maps allow key to be unspecified. */
	if (btf_key_id) {
		key_type = btf_type_id_size(btf, &btf_key_id, &key_size);
		if (!key_type || key_size != map->key_size)
			return -EINVAL;
	} else {
		key_type = btf_type_by_id(btf, 0);
		if (!map->ops->map_check_btf)
			return -EINVAL;
	}

When btf_key_id is 0, key_type is set to the void type, and
map->btf_key_type_id is stored as 0. array_map_check_btf() even has a
dedicated keyless exception ("One exception for keyless BTF:
.bss/.data/.rodata/.percpu map").

The preceding patch in this series, commit 55f5ad8f45a5 ("bpf: Reject
key-less BTF for hash maps"), documents a syzbot NULL-ptr-deref where a
void key reached the map dump path through htab_map_seq_show_elem() ->
btf_type_seq_show_flags() -> btf_type_show() -> kind_ops[BTF_KIND_UNKN]
== NULL. That patch closed the path by adding btf_type_is_void(key_type)
rejections in htab_map_check_btf() and rhtab_map_check_btf().

Would it be more accurate to say the map dump path is closed by the
preceding patch and by existing btf_key_type_id guards, rather than by
a size requirement?

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2911,7 +2911,15 @@ static void btf_modifier_show(const struct btf *btf,
>  	else
>  		t = btf_type_skip_modifiers(btf, type_id, NULL);
>
> -	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
> +	/*
> +	 * A modifier can resolve to the void type (e.g. "const void"), which
> +	 * has no show op (kind_ops[BTF_KIND_UNKN] is NULL). Print a placeholder
> +	 * instead of dereferencing NULL.
> +	 */
> +	if (!btf_type_ops(t))
> +		btf_df_show(btf, t, type_id, data, bits_offset, show);
> +	else
> +		btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
>  }
>
>  static void btf_var_show(const struct btf *btf, const struct btf_type *t,


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33385673160
--===============2702627393202367961==--
