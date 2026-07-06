Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C637F738
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359260; cv=none; b=LdLbW5LsA9/ehNLib4eVEJ9MhTn7gL5Qo+UF+aWVkfD0s3Fn/qS+04wpHYdHG3gwfoQadpYpFZzaitOeA0GM9cDIb2tdCeyBeGtioqVTGrHnYJaV8JyLt7/s1LShzeqgLGgh7dB7CSi+cCRX2TtfFjgD3aRBpmK5cS9/jFzAbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359260; c=relaxed/simple;
	bh=y4rMSqY82UpbAhx5vvgl241U/7PL/WCfgxLs3hcZGF8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YUdt9z1tZoJR+IIWfnHczG63yeeSp6qkippv+HxYb/byblhmjWQu6PTuPSzwq3sZvgRw60VlLPLiEiy7hm1XbRAdKgOdKfIvoUAILtd21CNavWigSiOtAgEg0vfQ5AJKw6BWCsYrRkBqRJmVIWJdPqefl26xyQvD8DCz8zpp/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iG0o12xG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iG0o12xG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F11D1F000E9;
	Mon,  6 Jul 2026 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783359259;
	bh=5XoSZYkuOB7GdmQEbwFBAhY8WaKLa+j0usHJF9vdwVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iG0o12xGgxxaCXcMUs1JumO+obhu6qDIgGb3okapQGiVeBZrwXhuz6QCNw0k4A4Nt
	 SVc/UptJ4AF1fQdNTrCUXUiQ8Sb7ROJLj9eqNIaWuPYriSX3YIaDy55t114odwkl33
	 1541sIBrjuLghurm+IVOuhcXMVt4/alXyaSgE+gBBWvN+1ebW2kBIdgLuAPjZAA5yI
	 p0EO4sHD+2I3/qk7Vi48n4WkkWihIVq3gPa7SFXpd04EXpt7KgDPQxGyCYjsJGUipn
	 cDgCCYnxkZTSGmf7R1mQvnvPphVojovq+j5QXNg2JPxODawIUHoosn+15oR2I6JPuO
	 Viffxee161hwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 03/15] bpf: Add bpf_struct_ops accessor
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706171918.317102-4-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:34:18 +0000
Message-Id: <20260706173419.6F11D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The function `bpf_struct_ops_kdata_map_id` is declared in `include/=
linux/bpf.h` but its implementation is missing.
--

commit 95521f3bc40fc850e1847bcb5fd4b12e698ebe45
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Add bpf_struct_ops accessor helpers

This commit adds helper functions in bpf_struct_ops.c for the upcoming
patch to create a struct_ops to cgroup attachment link. It also exposes
existing validation logic as new helper functions.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 91b8479121fa3..1a1e8d0885c8e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2252,6 +2252,12 @@ u32 bpf_struct_ops_id(const void *kdata);
>  int bpf_struct_ops_for_each_prog(const void *kdata,
>  				 int (*cb)(struct bpf_prog *prog, void *data),
>  				 void *data);
> +void *bpf_struct_ops_map_kdata(struct bpf_map *map);
> +u32 bpf_struct_ops_kdata_map_id(void *kdata);

[Severity: Low]
Is the implementation for bpf_struct_ops_kdata_map_id() missing?=20

The prototype is added here and a dummy version is provided for the=20
non-CONFIG_NET case further down in this file, but there doesn't appear to =
be=20
an actual definition in kernel/bpf/bpf_struct_ops.c. This would cause a lin=
ker=20
error if the function were called.

> +void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map);
> +bool bpf_struct_ops_valid_to_reg(struct bpf_map *map);
> +int bpf_struct_ops_link_update_check(struct bpf_map *new_map, struct bpf=
_map *old_map,
> +				     struct bpf_map *expected_old_map);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706171918.3171=
02-1-ameryhung@gmail.com?part=3D3
