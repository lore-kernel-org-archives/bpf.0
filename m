Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E002E2DDD
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788592905; cv=none; b=VP0/GQP5YVuh2wgfO7SAMYVdiuHIc1hGPv+D+Cr5QGyD8WTNjLQfCvZjhSpHjIYIXergzIrmwpLYeCQDZ04XpTthai6t1uizaF9p4JF7IR2NLrarCt6voirgT56gQiGz7Lk6IM/1TfUAtV08JSDZEFfl+iESGOMwa7ifhrj0ff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788592905; c=relaxed/simple;
	bh=U7iZhSHvNFK8n8qxWtruy34ZeXtZMkx+/FA/5NUblXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=swX2eMxfk2ZcMhKw8oPkelb7EleYe5I8YQBynAzGHDslzr7CpbhkSU1dBV3Jvjx2HLUGdtO+q7bR0fNJKgD4yq6lWQsp6BSxtcID1Vz1sZk3b2jdizQeuVH453EGw7SU5y/XKw+6nq1XVH6M3DknfvERiuBgZ7Hlf2daJ8gg5+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bcgmkl9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bcgmkl9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975EB1F00A3D;
	Sat,  5 Sep 2026 07:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788592903;
	bh=f5tARW7KOAArRbFwK6Qztsp7buS3lNVqPym/xMOkYy0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bcgmkl9sbAXzBDv+aMlFw0vbxXhWhD8noz9Wq0ptpOFf0X7cA6KfzCZCtsqj9tgqC
	 +TD2iW/8/+uyWYfPNYuRbOIkuzJ+RWDcgoy8fozdHNwFCCivlJCy5EeejRVnhbc2pP
	 9N7Pzr6LuM4zLaErOefZcw0NzZP7qOrVbU9nitLV6xtMyc1FC/6xDeJMBocG7JndDO
	 yVKHzx72ZCWsZeNnnsml+2DeYAOT+nZyxp3snFJmO2yXRkEruDeDm8g5RtZSWHf4zU
	 pYIsut09K5sYc62nKK47FANzk3R2XcH6t31vlsxQJrPJKYg9ls20fG/2F8o83YLnvN
	 Q8OdFk2dZBWlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 7/8] bpf: Assign lock identity to callback map
 values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260905070003.3193366-8-memxor@gmail.com>
References: <20260905070003.3193366-1-memxor@gmail.com>
 <20260905070003.3193366-8-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 07:21:43 +0000
Message-Id: <20260905072143.975EB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Lock identity aliasing across distinct inner map instances due to =
flawed static identity check.

Pre-existing issues:
- [High] A BPF program can cause an AA deadlock by acquiring `bpf_res_spin_=
lock` twice on the same single-element array map element, bypassing verifie=
r lock tracking.
--

commit 996188899c474047a5a9bb68f80d0d3c3e5a5b6a
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Assign lock identity to callback map values

This commit assigns a fresh verifier ID to lockable map values in
callback frame constructors to prevent lock aliasing. It specifically
preserves ID zero for single-element array maps to support stable
allocation aliases.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c3039f3fc323..b08501734ddfa 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -447,6 +447,11 @@ static bool reg_may_point_to_spin_lock(const struct =
bpf_reg_state *reg)
>  	return btf_record_has_field(reg_btf_record(reg), BPF_SPIN_LOCK | BPF_RE=
S_SPIN_LOCK);
>  }
> =20
> +static bool map_value_has_static_identity(const struct bpf_map *map)
> +{
> +	return map->map_type =3D=3D BPF_MAP_TYPE_ARRAY && map->max_entries =3D=
=3D 1;
> +}

[Severity: High]
Does this check fail to distinguish inner_map_meta from an actual
single-element array map?

When a BPF program retrieves two distinct inner maps from an outer map
(where the inner maps are single-element array maps), and calls
bpf_for_each_map_elem on both, the verifier tracks both using the same
inner_map_meta.

Because inner_map_meta has max_entries =3D=3D 1 and map_type =3D=3D
BPF_MAP_TYPE_ARRAY, will map_value_has_static_identity() return true and
incorrectly assign id =3D 0 to both callbacks' element pointers?

Could this allow a program to acquire a lock on an element from the first
inner map and unlock it on the element from the second inner map, corrupting
the spinlock state?

[Severity: High]
This is a pre-existing issue, but does preserving ID 0 for single-element
array maps leave an AA deadlock vulnerability in bpf_res_spin_lock tracking?

If a program acquires a bpf_res_spin_lock using a direct map value pointer
via LD_IMM64, check_ld_imm() assigns id =3D 0. If the program then acquires
the same lock again using a pointer obtained via bpf_map_lookup_elem(),
check_helper_call() unconditionally assigns a fresh ID to the lookup result.

Will find_lock_state() inside process_spin_lock() see the different IDs and
fail to recognize the lock is already held, causing a system hang on the
second acquisition?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905070003.3193=
366-1-memxor@gmail.com?part=3D7
