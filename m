Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615C93FA5E0
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501472; cv=none; b=gx9VG0L17pqHmswCyRPIMcLggK5GeHA9FkQ8eKNg7OwUyoMYLObWILG0cMfYhadGS6bJdbZNaZcRvpqsjNeaqgAXHOL7sHUlM4iDm+bBRvHYCx6RcrDblktoiGbuPCA5oVUBt/mAnefaU1JPbkvJ7f2bzOHNxPJ+VjMNQZL0psw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501472; c=relaxed/simple;
	bh=QOJ/7S0kizwzzCebH4sTEJ+qmTJ11Y8lYm3wajuyLyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jk5HAifDlY3QgiIP2yAB+wJI1PcWukE7jysT+yiPB1eGt9SyI2ohl/xXgJr582Aznzn51oY7KTzH2theHe2WdMR+FnwIE0oquZY6dGK4uDlbURsdN+G+IH+L1khuIi7zbdBB9R2a0mkG9JFoxLHWQAvv6HZExQGXLc/uoWX+JL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsuOsdMy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsuOsdMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2685C19425;
	Wed, 29 Apr 2026 22:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777501471;
	bh=QOJ/7S0kizwzzCebH4sTEJ+qmTJ11Y8lYm3wajuyLyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hsuOsdMyRuu5G4PQCwefuo0HC9dcpLOm9frbhiIsPPrHjN7BdQeRpfA2YN/uw6DRv
	 XfIENs4xOXVzgQOW1M93S/gOeJ1S9lMizVHDl/G052l8qyaZmCr2Mm7bH3AQDHxJv9
	 vRri58AkUOz4PkZUYqNakVyxK87xKphXgEfu12j2/Eq8PXNwiWAupr5qHzOjyK6PtZ
	 bZrzp6wRl/r63lc38l+3TSbNIcTx8GlPCQlLcfSgelFHw3Ozk6QgO28SEXctTP0wNM
	 rutBXXXMmsgAQKf7orVn9wDbfBKwm7UcoJ1x9yYni9nyVeAaQmwdBOAS7zJvNzsGDX
	 9c4CPZEIQbb6A==
From: sashiko-bot@kernel.org
Subject: Re: [v6 04/10] lsm: framework for BPF integrity verification
Reply-To: sashiko@lists.linux.dev
To: "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429191431.2345448-5-bboscaccy@linux.microsoft.com>
References: <20260429191431.2345448-5-bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 22:24:30 +0000
Message-Id: <20260429222431.B2685C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added LSM hooks `bpf_prog_load_integrity` and `bpf_pro=
g_load_post_integrity` are missing from the `sleepable_lsm_hooks` BTF set.
--

commit 8148d31126f70fa43314056c3dc696e4fcd7470d
Author: Paul Moore <paul@paul-moore.com>

lsm: framework for BPF integrity verification

This commit adds a new LSM hook and two new callbacks to support BPF program
integrity verification. It allows administrators to select additional
integrity verification mechanisms through the LSM framework.

Link: https://lore.kernel.org/linux-security-module/CAHC9VhTQ_DR=3DANzoDBjc=
CtrimV7XcCZVUsANPt=3DTjcvM4d-vjg@mail.gmail.com/

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 8c42b4bde09c..4971d3c36d5b 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -434,6 +434,11 @@ LSM_HOOK(int, 0, bpf_prog, struct bpf_prog *prog)
>  LSM_HOOK(int, 0, bpf_map_create, struct bpf_map *map, union bpf_attr *at=
tr,
>  	 struct bpf_token *token, bool kernel)
>  LSM_HOOK(void, LSM_RET_VOID, bpf_map_free, struct bpf_map *map)
> +LSM_HOOK(int, 0, bpf_prog_load_post_integrity, struct bpf_prog *prog,
> +	 union bpf_attr *attr, struct bpf_token *token, bool kernel,
> +	 const struct lsm_id *lsmid, enum lsm_integrity_verdict verdict)
> +LSM_HOOK(int, 0, bpf_prog_load_integrity, struct bpf_prog *prog,
> +	 union bpf_attr *attr, struct bpf_token *token, bool kernel)

Should these two new hooks be added to the sleepable_lsm_hooks BTF set in
kernel/bpf/bpf_lsm.c?

Since they execute in the same context as the existing bpf_prog_load hook
(which is a known sleepable context), omitting them restricts any BPF LSM
program attaching to them to a non-sleepable context.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429191431.2345=
448-1-bboscaccy@linux.microsoft.com?part=3D4
