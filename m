Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2863538AC79
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780353208; cv=none; b=PELbbFka9VO3iALOYKErbBS8urV8nQZKtNCTA/U3qEiegmvmGy1dTk/uts9u6wmhly30YAMhC48JnfyqNBMfbbLj0U0jkefllKX6T2PSV25HXPIRsZqJaNttTkKsgMdVO6TcPPRPXeJYdxFXI/RBt/EFM0MGA20lFblJcqIiIZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780353208; c=relaxed/simple;
	bh=QIR8zxWT4wq9U4ZSJ8OZXs6xHzrNtV+21bY/5ypufKA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GwMgIGNuuyhss4Of0IO7qVwG1a30Pv1iVmYu5R4EIoDM/rPqUFUmyCDlNvqc5RBz4WdJY9WpCOlfte/xWgasx/vf3w8U1q8soVUlrebWenq30EHhelO4tWFcw3QG+p5KbGDWWWofvysmBimF5HHbdwrSEwmzsnt1ojSaIBB+VgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUd9kPDZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUd9kPDZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C912E1F00893;
	Mon,  1 Jun 2026 22:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780353206;
	bh=3vGLuxxb7zMMdYXPtpeo97zedivav2XtvUVzrhBDH3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HUd9kPDZtS8w1I4JOTuI8bsMCnfNgA5p/5mUrdImpY/Ff6zJhIXvtRnYeZb207EIO
	 V7FyyFZpNlQ4r0rn5yn4w/SOJDlX6yk9iWZmc0PliNPGb9WEEmtJUWlRoMubn+jmW+
	 69EfEgnaXMpAc9fqu+dVWngoyGOVCOoipCEIoDkgjY6069k7ej+sLPO3K0JC7iwAqf
	 8EBf/6Cj5dqhN+9fp/tmO+H31ustYM6BMUgeFmmLSpl2LSLxnSQhBq4EaDbLr8YvDL
	 ekTHCzMo1HvI9GRgVHgq+39boFcwPvMBQ5hWvZ/U9+lDdrN0Fvk7OsSFrkYK069MDx
	 ITkUOwnnZGnVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 06/14] resolve_btfids: Discover kfuncs from
 BTF ID sets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601221805.821394-7-ihor.solodrai@linux.dev>
References: <20260601221805.821394-7-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 22:33:25 +0000
Message-Id: <20260601223325.C912E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Ambiguous string-based lookup in resolve_btfids incorrectly resolv=
es kfunc BTF IDs on name collisions, causing silent failures in BTF mutatio=
n and tag emission.
--

commit 8f8fb9808a6cbcfa547c7cbbeadbb0e70e3b6b81
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

resolve_btfids: Discover kfuncs from BTF ID sets

This commit updates resolve_btfids to discover kfuncs by parsing BTF_ID_SET8
symbols instead of relying on bpf_kfunc decl tags. It extracts the kfunc na=
me
from the symbol address, then looks up the BTF ID by name and records the
associated flags.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 43512af131482..d35a7b2460e83 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
[ ... ]
> @@ -1003,92 +1020,63 @@ static int collect_decl_tags(struct btf2btf_conte=
xt *ctx)
[ ... ]
> +static int collect_kfuncs(struct object *obj, struct btf2btf_context *ct=
x)
> +{
[ ... ]
> +		for (u32 i =3D 0; i < set_id->cnt; i++) {
> +			Elf64_Addr addr =3D set_addr + sizeof(u64) * (i + 1);
> +			const char *name =3D find_name_by_addr(obj, addr);
> +			struct kfunc kfunc;
> +			s32 func_id;
> =20
> -			if (!name || strcmp(name, kfunc_id->name) !=3D 0)
> +			if (!name) {
> +				pr_err("WARN: resolve_btfids: no kfunc symbol for set %s entry %u\n",
> +				       set_id->name, i);
> +				warnings++;
>  				continue;
> +			}
> =20
> -			pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
> -				 kfunc_id->name, set_id->name);
[ ... ]
> +			func_id =3D btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);

[Severity: High]
Does this string-based lookup risk returning the wrong BTF ID when processi=
ng
kernel modules?

When resolve_btfids processes a kernel module, btf__find_by_name_kind() sea=
rches
the base_btf (vmlinux BTF) before the module's BTF. If a module kfunc shares
a name with a static function in vmlinux, or if there are multiple static
functions with the same name within the module, it seems this might return =
an
incorrect BTF ID.

If the wrong BTF ID is returned, resolve_btfids could silently mutate the w=
rong
type in memory later, for example in process_kfunc_with_implicit_args() or
process_kfunc_with_arena_flags(). Since base_btf modifications are not save=
d to
the module's .BTF section, the actual module kfunc would remain unmodified.=
 Will
this cause the BPF verifier to reject programs using the module kfunc due to
missing implicit args removal or tags?

> +			if (func_id < 0) {
> +				pr_err("WARN: resolve_btfids: no BTF FUNC for kfunc %s in set %s\n",
> +				       name, set_id->name);
> +				warnings++;
> +				continue;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601221805.8213=
94-1-ihor.solodrai@linux.dev?part=3D6
