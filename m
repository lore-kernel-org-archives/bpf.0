Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335447262E;
	Sun, 24 May 2026 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624518; cv=none; b=QHyRjhh0E9AKLO/Msvgnw7SKkUWhEXLeLFyj6cDGjBUaVjSGthdT53fmQ49PwPLRapxpPW9XdKAl38OMCDRTlprij0zpiFVQse807OIotJofChgKbu08tQCiP9tIQJ7jWhn7EUk/RmsNBJBdEhLO9soP96usTI+1/y/3n3VbpKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624518; c=relaxed/simple;
	bh=sdG7tvIW9lndCrK6s/uSOPgd6OJni+FrUCwZ31XMcOE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=riMds4lHDqfxS/sa1Sc+h5guymmBSEnq1ABhBIXOB7/Iy0HLQfSNtUzq4dLakZk85dnFtPNIH/NVX31/TfU+EdRH4Gyqy+kaJi8D3wod6GSu28TbH2vn6rzV89buJ/jt5gFEBIrVoSNZjeWnRFux2bP1PQDbSULhjdNxxzlHjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ezh6iad7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ezh6iad7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927491F000E9;
	Sun, 24 May 2026 12:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624516;
	bh=KjxZLmIvNZn781qBk858sQDEpPVuyzd7nax09pb2kvo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ezh6iad7xdJVUOeJcsSety/wUG6NVoh7D8204VPKMpxudj2ocqRnKgMsdhFN8Xmjo
	 7sxQEn5Ws9HH0U6tDoWMPjOeWsU7LwUAnJ9x6SriPQYAQQhAANSBpODdO79ZFVQBsK
	 b+b/jX/tkxLsEwVG3/vhqqS7G+UWhSaN3J4V8yAV3MR82a60Zrn35qHfzOsL3YSvNa
	 FxLDWRFE7d+C+3jxDDpuO4DXk37FPb5oCkm/+6h3Jgam9Q0b8a5yC7yesjMJV4o1tf
	 EqrWjB6aLcChjsM0nf8L15va667ebOo+ru9VC40F573Q2ZSTBkpcNKBvjtyaJX7R1R
	 Rtqs8OtCZg04A==
Content-Type: multipart/mixed; boundary="===============5249304446152511709=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b4b4ca51ae8e281a37707cbcd2ba8349dabc6c630e96461929be0872fd8ed0e6@mail.kernel.org>
In-Reply-To: <20260524-libbpf-load-vmlinux-btf-in-gen_loader-mode-v1-1-6f57f191a7ad@google.com>
References: <20260524-libbpf-load-vmlinux-btf-in-gen_loader-mode-v1-1-6f57f191a7ad@google.com>
Subject: Re: [PATCH] libbpf: load vmlinux BTF in gen_loader mode for struct_ops
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,gprocida@google.com,maennich@google.com,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 24 May 2026 12:08:36 +0000 (UTC)

--===============5249304446152511709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit c1abfce71ecf8c95413f5afe0d153662877e0ad0
> Author: Siddharth Nayyar <sidnayyar@google.com>
>
>     libbpf: load vmlinux BTF in gen_loader mode for struct_ops
>
>     During light skeleton generation (`bpftool gen skeleton -L`), libbpf
>     runs in gen_loader mode. Previously, `bpf_object__load_vmlinux_btf()`
>     completely bypassed loading the kernel vmlinux BTF (`obj->btf_vmlinux`)
>     if `gen_loader` was active.
>
>     However, BPF `struct_ops` maps (such as `sched_ext_ops` maps) require
>     resolving the kernel-side struct type IDs and member sizes at
>     compile/skeleton generation time. Without loading `btf_vmlinux`, libbpf
>     cannot query the kernel BTF types, causing light skeleton generation for
>     `struct_ops` to fail or omit crucial type information.
>
>     Fix this by modifying the check to load `btf_vmlinux` even in
>     `gen_loader` mode if the BPF object actually requires kernel vmlinux BTF
>     (e.g. contains `struct_ops` maps).
>
>     Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>

This looks like a bug fix for gen_loader mode with struct_ops maps. Should
this include:

  Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ab2071fdd3e8..6163e53a2056 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3590,7 +3590,10 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
>  	int err;
>
>  	/* btf_vmlinux could be loaded earlier */
> -	if (obj->btf_vmlinux || obj->gen_loader)
> +	if (obj->btf_vmlinux)
> +		return 0;
> +
> +	if (obj->gen_loader && !obj_needs_vmlinux_btf(obj))
>  		return 0;
>
>  	if (!force && !obj_needs_vmlinux_btf(obj))

Alexei Starovoitov raised a design concern about this approach in v1. He
requested an end-to-end solution where struct-ops and sched-ext programs are
fully supported in light skeleton (lksel) mode, rather than just this
incremental fix. His specific comment was: "That's a step, but please provide
an end-to-end solution where struct-ops and sched-ext programs are supported
in lksel mode. This step alone may be more confusing to users than helpful."

This feedback has not been addressed - no v2 was posted and no author response
was provided.

Reference: https://lore.kernel.org/bpf/CAADnVQ+M6pJJJ_YY5QO_EYJyDfd=TNs=A1xFB9_RFLTqaM=w_g@mail.gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26360291945
--===============5249304446152511709==--
