Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995738F623;
	Mon,  6 Apr 2026 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496824; cv=none; b=dQK8N4c8JAl+1uwQX6pgIWGkw9pe0SZPbddcg/Y3Th48xiJArHK2e5hXyulV+VL5lxy/EgwD0ncf+pv0Tw7gdSzt53usSJbqyzua2CyzrTTLCnLJTMkkxwdxrS4fixqoov53Lj+HEMZXaeAGYU+qK2/bYOlWsJMJH7wHmRhuXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496824; c=relaxed/simple;
	bh=J12T7Qu9tuyMFjyy2uZxzUL0SgugG9GBIoE92Rl+vA0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EGC0G1Uw9In2xXVe2rfEiGtUBzFZs9jWHO1nvDQtFejpH73MZPK2+XDGHlVHatc7CVx/9+wG0PlrmJDk87ZSYTUb8hQc5Z0JaBhcpHEUOWpRWDC0hCfcieyD6XgC/7FjxNvcqpaC0pgTIieoxe7ypq9S3hJbcg0U3r0tYvNEhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G80Id64B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G80Id64B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B142EC4CEF7;
	Mon,  6 Apr 2026 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775496823;
	bh=J12T7Qu9tuyMFjyy2uZxzUL0SgugG9GBIoE92Rl+vA0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=G80Id64B0Fcd4SxEYv2Ua/NV5qzg5iEEUk9kXxOfJMF23ZYmZOhPd6BdF9JWyBHlN
	 eXnHJnk12BgZgSnXG2ULXJ/sjzF/7UB3Juqdx8xheovTN76Qi77lN6hEjaRelJ/NXP
	 SgRwNvIm4lfcyJS4VsMm34ktD3dg65bpSK6R8Ikx8NROIrxDefNji2xXmJhsews6yV
	 LYRmuTVfNYA3pvCuWqO/9PWBUeZDGgzr89wLkBSTq3xZwA4QSWZyMBwboQIheLxooR
	 MIZAUZ65iS0lGBCTteaS8zLRf3Mqx59DMAnO0shykWYI+u+MjBHIMu2UKd548mJCtN
	 57MeVtwySZCIA==
Content-Type: multipart/mixed; boundary="===============1590066759770731296=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e89e9143c05d759981d49c089860461293343c06c3f0e482335d111bcd3d4c04@mail.kernel.org>
In-Reply-To: <20260406165612.12115-1-adithalex29@gmail.com>
References: <20260406165612.12115-1-adithalex29@gmail.com>
Subject: Re: [PATCH] bpf: verifier: restrict insn_array_maps to jump tables
From: bot+bpf-ci@kernel.org
To: adithalex29@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,linux-kernel@vger.kernel.org,adithalex29@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  6 Apr 2026 17:33:43 +0000 (UTC)

--===============1590066759770731296==
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

Is the map_type check here doing anything? Looking at __add_used_map(),
it only adds maps to insn_array_maps[] when the type is already
BPF_MAP_TYPE_INSN_ARRAY:

  __add_used_map() {
      ...
      if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
          ...
          env->insn_array_maps[env->insn_array_map_cnt++] = map;
      }
  }

Since that is the only place maps are added to the insn_array_maps
array, the first half of this condition can never be true.

The comment also says "Only consider instruction array maps" but every
map in this array is already an instruction array map. The effective
filter is just max_entries <= 1.

Similarly, the commit message says "Restrict processing to
BPF_MAP_TYPE_INSN_ARRAY maps with multiple entries" -- the restriction
to BPF_MAP_TYPE_INSN_ARRAY is already guaranteed by __add_used_map()
and the check here is dead code.

The removed TODO comment said "TODO (when needed)", acknowledging that
distinguishing jump tables from other insn_array_map uses was not yet
necessary. Could this be simplified to just the max_entries <= 1 check
with a comment that reflects the actual invariant?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24041578069
--===============1590066759770731296==--
