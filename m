Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132837649D
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948783; cv=none; b=EO31CeiM9eygTF8yI+3y+1V5LHAacnsK0Z6yC9SanTHl21j2VHxeD1a3nG3Bdany0FjYXyKUPhnId7URmyD4/4rwrBkSo22gQvH5OWhoq8Aa+uSeQdkxb0IjY8bh7xpAsleXic5G88/+HMY4cLtvPhq9yH7e8S2HIxKVnQ7Xb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948783; c=relaxed/simple;
	bh=bcu36R+TqJbpQQsFTgeAEhNaF5/TuG83UijY3+2dlLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V0wiVG1HvbqnDit1PyOpHErvs7dDj4jCcOjEk/F3Gkee8tdV7kfpTAJfSj9hHrcbMkPoP5qFNsgfyOOquqowrYEgAZwFu3bHtKggHxDLboFZQ4tEZXuewp523ThGb1p5TiNI1TUBxjG5SYGqkex4HFslnHd7JEafqk3kgPZydUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCxUm/S8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCxUm/S8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675A71F000E9;
	Mon, 17 Aug 2026 06:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786948781;
	bh=mtWRLdHPc5AfZG45XKHEIBuA0e77nsxUJoPIRZVH4ZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YCxUm/S8vhFqbgQOQlmcqUMUDJbuJuRWjEQLwZUgyS9LdS5GbHinWR0FcOQtgRskK
	 apfi8kB/5BCEB3KVLhJgCJSY081saz+YY+lIU6U3JxfvqeH3FEMekqkXcUIz7cdez6
	 pm7zMvbi31osnU4ANGLARoT5K39LrLkVcy3L9xFTAJYPrMXYmFjAJttz4w3Yf24rrY
	 ecWY99jADjFNzNudRipSzl2FuBKRmLAoA6qdOdeFh5Pq1nnNfSFk/A/mAEWXWsEsMU
	 mQfOsFfD5pLPUGpE5e0e5IAWUI7yWwL5XzLApXyNl5i0t5iVNbX7nJ+IqSj7FeW1sZ
	 fN5/4i+0Pgchg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: Enforce cgroup storage map consistency for
 freplace attach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aohan Mei" <3472274613@qq.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_05AD70D6BED7A204CB00860D0C3A303FDC07@qq.com>
References: <20260814130650.634992-1-3472274613@qq.com>
 <tencent_05AD70D6BED7A204CB00860D0C3A303FDC07@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 06:39:40 +0000
Message-Id: <20260817063941.675A71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The function `bpf_freplace_check_tgt_prog` leaks `tgt_prog->aux->i=
s_extended =3D true` if the cgroup storage map consistency check fails.

Pre-existing issues:
- [High] Failure in `bpf_arch_text_poke` during freplace attachment corrupt=
s trampoline state and leaves a dangling pointer, permanently blocking futu=
re attachments.
--

--- Patch [1]: [PATCH bpf v2] bpf: Enforce cgroup storage map consistency f=
or freplace attach ---
commit d906b268f92284796bc16bccd01e3ee3f9f415d5
Author: Aohan Mei <henrymei@tencent.com>

bpf: Enforce cgroup storage map consistency for freplace attach

This commit adds a check in bpf_freplace_check_tgt_prog() to ensure that an
extension program references the exact same cgroup storage map as the target
program. If the maps differ, it returns -EINVAL to prevent verifier and
runtime inconsistencies.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 1a721fc4bef56..043bee6aaab2a 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c

[ ... ]

> @@ -821,6 +823,23 @@ static int bpf_freplace_check_tgt_prog(struct bpf_pr=
og *tgt_prog)
>  		return -EBUSY;
> =20
>  	aux->is_extended =3D true;
> +
> +	/*
> +	 * At runtime the extension program inherits the target program's
> +	 * cgroup storage context (via prog_item->cgroup_storage), so its
> +	 * own map never provides storage; the verifier, however, bounds
> +	 * its accesses (size, flags, layout) by that map. Require both
> +	 * programs to reference the same map, matching the cookie
> +	 * semantics of the prog-array path.
> +	 */
> +	for_each_cgroup_storage_type(i) {
> +		struct bpf_map *tgt_map =3D tgt_prog->aux->cgroup_storage[i];
> +		struct bpf_map *prog_map =3D prog->aux->cgroup_storage[i];
> +
> +		if (prog_map && prog_map !=3D tgt_map)
> +			return -EINVAL;

[Severity: High]
Does this code leak the aux->is_extended state?

If the cgroup storage map consistency check fails here and returns -EINVAL,
aux->is_extended remains permanently set to true. Will this cause future
attempts to add the target program to a prog_array map to fail with -EBUSY?

> +	}
> +
>  	return 0;
>  }

[ ... ]

> @@ -926,7 +945,7 @@ static int __bpf_trampoline_link_prog(struct bpf_tram=
p_node *node,
>  		/* Cannot attach extension if fentry/fexit are in use. */
>  		if (cnt)
>  			return -EBUSY;
> -		err =3D bpf_freplace_check_tgt_prog(tgt_prog);
> +		err =3D bpf_freplace_check_tgt_prog(tgt_prog, node->link->prog);
>  		if (err)
>  			return err;
>  		tr->extension_prog =3D node->link->prog;
> 		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_NOP,
> 					  BPF_MOD_JUMP, NULL,
> 					  node->link->prog->bpf_func);

[Severity: High]
This is a pre-existing issue, but if bpf_arch_text_poke() fails here, does
it leave tr->extension_prog pointing to a failed program?

If the text modification fails and returns an error, the failed link will
subsequently be cleaned up and freed, which might leave tr->extension_prog
as a dangling pointer. Furthermore, tgt_prog->aux->is_extended is left as
true. Would future attachments to this trampoline see the non-NULL dangling
pointer and fail with -EBUSY?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_05AD70D6BED=
7A204CB00860D0C3A303FDC07@qq.com?part=3D1
