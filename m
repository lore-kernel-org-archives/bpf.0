Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC9A477E2B
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400782; cv=none; b=okqwW0ouaEEhNg9L6Dn14FcYs3fZX+d2st8D1QKHxWgDezmAxFLHGnDZQ6mKWDv8gpk2T6xu5RDDDrKIM1aew3r1GpZKWVWOlsjT6egtUuKuf8P0o4st4wtAGtOOr6hVMU2NgEDwK2mM4Sdhspp7uMdgfz7q3+jHFiHM6N2HyiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400782; c=relaxed/simple;
	bh=yS9oGUZDk1xU0RHbqO3rRoddTBWjLzDBNXZzDIfDh/8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=THlEjhBfZ7rnEQ8LED9oUuxlb9itZZ3R5CHHZo1eRiQaGQiNOSyspiQKgNcbf6nXfuE/0JgTYfpGeI/0XrP706rNRObpWZwz0RjYWdOFGIoGfLs0FL7DrKMTv29JYZ0MzooZg6qWwS2Tc7XbelTcVqHuOlbDrWEftF2/Ns4NFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CItsaX78; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CItsaX78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAE4C2BCAF;
	Tue, 28 Apr 2026 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777400782;
	bh=yS9oGUZDk1xU0RHbqO3rRoddTBWjLzDBNXZzDIfDh/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=CItsaX78Z5IoqcluBKFi1ETVF0jl0m0U6oPDMzhg4nJn16NRlZscJrl7tsN3/BXi7
	 zgwf84icHHuTlEeKP7x63fNhNN0OFup6k95sNpISoJ/1jznbTXnmPKIL/6hyP8iY2h
	 jMJlaIxW2+b87AZ8+urKJDp5IEY52Ay4/e2FwkaAWMto8el28WtA54kNCP46zWCPoJ
	 pDZjXQIA9XqEvHiHjnVKDBjsgUCF+wEvjMZponwRNC3AolqWTqyTCfqCgT2Flf2g6G
	 iYGFGOHskDjRj79ZUT3Tjl1dk5eY6dYmeFEyWSA0aTI3NUpx9btZNHE2vEPF7ci7um
	 Zf3XgCyA4nmJA==
From: sashiko-bot@kernel.org
Subject: Re: linux-next: build failure after merge of the bpf-next tree
Reply-To: sashiko@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260427132604.3754048-1-thierry.reding@kernel.org>
References: <20260427132604.3754048-1-thierry.reding@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 18:26:21 +0000
Message-Id: <20260428182621.EEAE4C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Incomplete adaptation to the btf_vlen() return type change.
--

commit 0212f8f14ef9fb92c19bf796baf0b7ea6478e094
Author: Thierry Reding <thierry.reding@kernel.org>

linux-next: build failure after merge of the bpf-next tree

After merging the bpf-next tree, today's linux-next build (x86_64_perf)
failed due to a sign-compare error. This patch fixes the build by changing
loop variables to match the unsigned return type of btf_vlen().

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index e58c49d047a2..d22e20a57b70 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -969,7 +969,7 @@ static bool syscall_arg__strtoul_btf_enum(char *bf, s=
ize_t size, struct syscall_
>  	struct btf *btf =3D arg->trace->btf;
>  	struct btf_enum *be =3D btf_enum(bt);
> =20
> -	for (int i =3D 0; i < btf_vlen(bt); ++i, ++be) {
> +	for (u32 i =3D 0; i < btf_vlen(bt); ++i, ++be) {
>  		const char *name =3D btf__name_by_offset(btf, be->name_off);
>  		int max_len =3D max(size, strlen(name));

Should btf_enum_scnprintf() in the same file also be updated for
consistency?

It appears the unsigned return value of btf_vlen() is implicitly cast to int
there, masking the sign-compare warning:

tools/perf/builtin-trace.c:btf_enum_scnprintf() {
    ...
	const int nr_entries =3D btf_vlen(type);

	for (int i =3D 0; i < nr_entries; ++i, ++be) {
    ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260427132604.3754=
048-1-thierry.reding@kernel.org?part=3D1
