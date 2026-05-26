Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9140B6E4;
	Tue, 26 May 2026 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807282; cv=none; b=dieMxqdYxdQx4wyyFONqkFY46XIYowiNjaKd06L8NQ7zGm16TglwHqExQPyPAHklpDmRZj1B098lCJEm/Ev9geaziLWtBH81kjcWLorNgza7LqqDerci/Ya+15+tOka1FwVPQTyI/NZ99/JFcWUv+L79GlL7phY0w4MKndakugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807282; c=relaxed/simple;
	bh=jJqL/xqcSNuwFHu6WprJ4M3FfIDVaTLImxFIwMEtjh4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UUeX/+CBQqQ2XbVt4nLpBUtUWIG+fpduQzkA8TwMCJ4gpeDfP4t/D7xz8zVKqDRH+UY8pPDE6YpDHXnCYNWKi5ms0IDn0GF3Dele9G4LnzcibLAQsNEu9K68B67iJJzIM3mGBMMHwqJL1PQAmpjBfXnC2NgWcAPQIvPeb0NT4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBYspJXV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBYspJXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29F11F000E9;
	Tue, 26 May 2026 14:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807281;
	bh=1/1YumSs9eA3iJsXAD7Cs0D8odJd9rWKt1wmFjx8zEc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RBYspJXVUsoCU2XcqrDXN6FFd0qbVD/IRa056qICOM3bl3+Ao2yFfTQGGHVeSoXTS
	 W/DJ2d9Ze5vS786n1hAG7Mg2f0sNu1D04nlm4DthGuklX2jhr+QbDQ4BVZAOyTbmR2
	 hbNKziKMvGT84HPcbiaKeWQPCLSB1IX9yn2VeNI4NGsbdR5lzOdZOQaZEz+mvDSvB1
	 YQb1ma8O32sNLLWScgHMx1MXmxYmdNANdz8FgKhqE/Xcnqu2XyCmLh74ZDeHmf21h7
	 WixiOVCBR4m+PdpZY8AWgc+A2rD43RwmVyAjKos9lof25NTmnjV24vdPyEwWEtkc6+
	 7HvhhRGM7K3Pg==
Content-Type: multipart/mixed; boundary="===============7220549708744682312=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20696e4e019ea87f2179fbd1a1af423c9591708e0a31ceebe61d181ff6f8cf52@mail.kernel.org>
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-1-5b4fa2a5e1a4@google.com>
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-1-5b4fa2a5e1a4@google.com>
Subject: Re: [PATCH v3 1/3] libbpf: load vmlinux BTF in gen_loader mode for struct_ops
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,gprocida@google.com,maennich@google.com,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 14:54:40 +0000 (UTC)

--===============7220549708744682312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: load vmlinux BTF in gen_loader mode for struct_ops
>
> During light skeleton generation (`bpftool gen skeleton -L`), libbpf
> runs in gen_loader mode. Previously, `bpf_object__load_vmlinux_btf()`
> completely bypassed loading the kernel vmlinux BTF (`obj->btf_vmlinux`)
> if `gen_loader` was active.
>
> However, BPF `struct_ops` maps (such as `sched_ext_ops` maps) require
> resolving the kernel-side struct type IDs and member sizes at
> compile/skeleton generation time. Without loading `btf_vmlinux`, libbpf
> cannot query the kernel BTF types, causing light skeleton generation for
> `struct_ops` to fail or omit crucial type information.
>
> Fix this by modifying the check to load `btf_vmlinux` even in
> `gen_loader` mode if the BPF object actually requires kernel vmlinux BTF
> (e.g. contains `struct_ops` maps).
>
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>

This looks like a bug fix for commit 67234743736a which introduced the
gen_loader functionality. Should this include:

  Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ab2071fdd3e8..6163e53a2056 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3590,7 +3590,10 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
> 	int err;
>
> 	/* btf_vmlinux could be loaded earlier */
> -	if (obj->btf_vmlinux || obj->gen_loader)
> +	if (obj->btf_vmlinux)
> +		return 0;
> +
> +	if (obj->gen_loader && !obj_needs_vmlinux_btf(obj))
> 		return 0;
>
> 	if (!force && !obj_needs_vmlinux_btf(obj))

Does this change provide a complete solution for struct_ops support in
light skeleton mode? In the earlier review thread, Alexei Starovoitov
commented:

"That's a step, but please provide an end-to-end solution where
struct-ops and sched-ext programs are supported in lksel mode. This
step alone may be more confusing to users than helpful."

The author responded by expanding this to a 3-patch series in v2/v3.
However, only this first patch is present here. The other patches in
that series were:

- Patch 2/3: Zeroing btf_key_type_id
- Patch 3/3: Plumbing btf_vmlinux_value_type_id in gen_loader

Without those additional changes, will struct_ops maps actually work in
light skeleton generation, or does this incomplete series leave the
feature partially broken?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26454419965
--===============7220549708744682312==--
