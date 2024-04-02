Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9E915D5B4
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089472; cv=none; b=MmGrTq84bRLQRKgKAUv+y6w5zd/byNm9Di+Mt00yck3i72a0VbgC7KpexcGBBPF4+7/hR9mHreGIIn8DF28N7YBIJIUNfANA4KVpr3zGyk2MP1gYv3oRWh8etzUEsghWOkkn7oeK5sgWd+VHbaoKQauVPvPHQJBQqqw3NGyI1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089472; c=relaxed/simple;
	bh=AXNu3peuW8gqSerZ8Nll7E4jzvZDhA3GfKW2pjYzRQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBaww0Q6/tSLzotN2Cl5bKNauayKMuIDD6J1q3KX2GgCvTxoIbaClPUbetafwJf6GukDwYso+SVOx5pYZTnig+TfstvSwGutbKSGD5nZdv4yzBkIrNAjJIH6LYFmZuNf9VAsY7ePR4DXUn6Ipaos8NQJXiLFaWI2op+Yb50Spg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/Oo3+Fx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/Oo3+Fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C0CC433F1;
	Tue,  2 Apr 2024 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712089471;
	bh=AXNu3peuW8gqSerZ8Nll7E4jzvZDhA3GfKW2pjYzRQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/Oo3+FxmRZHZBdzzw9Y3pgqWuJZiiVlGag3BQIdsyKPYMJcU0qSzC51FNDjQfS2h
	 fU9b4t6HpWrEBxh53+c1CJAgqCu5p32OYhpxncUB9jZrLzgzIf7YCxTgf6vaVIx47W
	 019djhoa5o2awLyBzsS+v6/aP25bH+dH/qcEbIJ3gUyYcHTrR52IS3a76sgZCnb7ou
	 W3yCzwl7r9Wf+DtkFSc9RU1yC8NmMnobIe18atQkn7l/QJfZiQ08JdIFzB2Mhez0ZJ
	 D6+VTyCI3UxHSfy5Jy5LdkBgFW/+sEm3rNErWRs2BouWIkJO+3BKSP2/6RSeYq1bqW
	 cQ98EnJaaFbzg==
Date: Tue, 2 Apr 2024 17:24:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: jolsa@kernel.org, quentin@isovalent.com, alan.maguire@oracle.com,
	eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v6 0/3] pahole: Inject kfunc decl tags into BTF
Message-ID: <ZgxpfDAKRAkHVNex@x1>
References: <cover.1711389163.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711389163.git.dxu@dxuuu.xyz>

On Mon, Mar 25, 2024 at 11:53:36AM -0600, Daniel Xu wrote:
> This patchset teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
>         121
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
>         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> 
> === Changelog ===

I'm a bit lagged on my backlog, will try and process these soon,

- Arnaldo
 
> Changes from v5:
> * Add gobuffer__sort() helper
> * Use strstarts() instead of strncmp()
> * Use uint64_t instead of size_t
> * Add clarifying comments for get_func_name()
> 
> Changes from v4:
> * Update man page with decl_tag_kfuncs feature
> * Fix release mode build warnings
> * Add elf_getshrstrndx() error checking
> * Disable tagging if decl_tag feature is off
> * Fix malformed func name handling
> 
> Changes from v3:
> * Guard kfunc tagging behind feature flag
> * Use struct btf_id_set8 definition
> * Remove unnecessary member from btf_encoder
> * Fix code styling
> 
> Changes from v2:
> * More reliably detect kfunc membership in set8 by tracking set addr ranges
> * Rename some variables/functions to be more clear about kfunc vs func
> 
> Changes from v1:
> * Fix resource leaks
> * Fix callee -> caller typo
> * Rename btf_decl_tag from kfunc -> bpf_kfunc
> * Only grab btf_id_set funcs tagged kfunc
> * Presort btf func list
> 
> Daniel Xu (3):
>   gobuffer: Add gobuffer__sort() helper
>   pahole: Add --btf_feature=decl_tag_kfuncs feature
>   pahole: Inject kfunc decl tags into BTF
> 
>  btf_encoder.c      | 374 +++++++++++++++++++++++++++++++++++++++++++++
>  dwarves.h          |   1 +
>  gobuffer.c         |   5 +
>  gobuffer.h         |   2 +
>  man-pages/pahole.1 |   1 +
>  pahole.c           |   1 +
>  6 files changed, 384 insertions(+)
> 
> -- 
> 2.44.0
