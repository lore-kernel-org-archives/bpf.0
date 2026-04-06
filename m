Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3FF153BE9
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775475461; cv=none; b=a9FFe6MNwG+AL8sjgGcs/t/ITmC9ltt+qFPOh7tEHL5DRwXVbShonMB6CA/NowQEEKlpcn4jdwMB05kzu2hGvqBegEYxNljw84CSewXctlFE9dh8ZKoMK8jsPTsCTDktllMWg6VQyFjr5UWV6sJ/KgfQ5qTJe/ZaOxSxKlgVNMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775475461; c=relaxed/simple;
	bh=uSLVkvctII8drxf06bRCX4zkr6T2hSUvqFlhzOoW+Tc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lifB5laBcGkp9cVCdL0XZ/dIsrtk6icPhkWgQDW+MBXCnXKAaviMMkZz5OuWgNFxCbfl63KuPfBEI1Os7koiOHqU9udJB/Y7RAMsMyrCw7NFLSjqBZdbicZeWM6o2w4Bnq13G0ES6w2zdDj5ktztUtwJkuImAf9mg/cAChLYvLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3viRyiO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3viRyiO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336FBC4CEF7;
	Mon,  6 Apr 2026 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775475461;
	bh=uSLVkvctII8drxf06bRCX4zkr6T2hSUvqFlhzOoW+Tc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=X3viRyiOhzirJGmdvZlntUxoIEf2WseJrWGXCpTmV8Dh5eWwInN0Qtd/mUjT8nA5K
	 UroTR2E7sEv3DX00fsAguM22s/Ewvk9RtKWBFEjseN9LAW7/G1hZRuSXjxgtCnROJP
	 JyJjEns4kMaFAG9kaZdyZoWmOYJ5UhJgGco6T2eUll+ZDsjrNKWThKk/jbEbiLyT5t
	 Bv2ndR/RJ6HAzTVQhyabwciq1AtdrnGCSZo76b6t3i/gaWqyvRvw1h1h6xGErvH9Ue
	 By70Xc89NoaxpelQveH4QJK5oGKYVvB25e3RiXEi93sAs3rfbS4ReF1lKUbX/MfSmy
	 NhqJljEltYzBg==
Content-Type: multipart/mixed; boundary="===============4261776535237344842=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8591ab4d3e0c6f692e22df939616e575bbfa393720410125a995a815d665f4c3@mail.kernel.org>
In-Reply-To: <20260406110958.13434-1-adithalex29@gmail.com>
References: <20260406110958.13434-1-adithalex29@gmail.com>
Subject: Re: [PATCH] bpf: verifier: restrict insn_array_maps to jump tables
From: bot+bpf-ci@kernel.org
To: adithalex29@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: john.fastabend@gmail.com,martin.lau@linux.dev,bpf@vger.kernel.org,adithalex29@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Apr 2026 11:37:41 +0000 (UTC)

--===============4261776535237344842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 84699a428077..83566d2f446e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19098,12 +19098,16 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
>  	int i;
>
>  	for (i = 0; i < env->insn_array_map_cnt; i++) {
>  		map = env->insn_array_maps[i];
>
> +		/* Only consider instruction array maps with multiple entries.
> +		 * These correspond to jump tables. Skip others (e.g. static keys,
> +		 * indirect call maps).
> +		 */
> +		if (map->map_type != BPF_MAP_TYPE_INSN_ARRAY ||
> +		    map->max_entries <= 1)
> +			continue;

Is the map->map_type check needed here?  The insn_array_maps[] array is
populated exclusively in __add_used_map():

    if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
        ...
        env->insn_array_maps[env->insn_array_map_cnt++] = map;
    }

Only BPF_MAP_TYPE_INSN_ARRAY maps can appear in this array, so
map->map_type != BPF_MAP_TYPE_INSN_ARRAY is always false.  This makes
the check dead code, and the comment "Only consider instruction array
maps" suggests the array could contain other types, which it cannot.

The effective filter is just max_entries <= 1.  The condition could be
simplified to:

    if (map->max_entries <= 1)
        continue;

and the comment adjusted to reflect that.

Similarly, the commit message says "Restrict processing to
BPF_MAP_TYPE_INSN_ARRAY maps with multiple entries" but processing was
already restricted to BPF_MAP_TYPE_INSN_ARRAY maps by construction of
the array.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24029846149
--===============4261776535237344842==--
