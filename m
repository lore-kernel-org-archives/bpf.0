Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FE8413D74;
	Wed, 27 May 2026 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889191; cv=none; b=LPbAM5YymDE51rDwVvtGXzZEehf/2miLKI4il3h13KX9FOr/8j9ABCrk90m66HTYXVhP3sQ+LF7XxoObmSUPJquJSUDwIoWApQRJeP8ra2sGmURwAym5J0hvrK5Ukp+5VPI2//RIOItavIpBRkIRmia0KZ0KKmuhaRQmOd9ytS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889191; c=relaxed/simple;
	bh=re3Uyafgs2JXnAaAI9w3TxhDPwmAHaWyTxClyp5HBYU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=C5/+KUExFTh/lWJ2IpPn8173icxNt8kz09xYtY2C6hpVs3U/iaHh4A7b8u3cct1R/ltz/ULfAk4CRM6KkIMmfZwf+Tte9r96bDWPZnzTOmFSgvTdKodrv8m4j2kgED4I4kPky1r5EexmhmkeH/ofLyV+WS1hZkAJMjOhx/fu5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6Wmqp2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6Wmqp2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEC51F00A3F;
	Wed, 27 May 2026 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889186;
	bh=XpAQYImOvjpxwVIP8irMkz0rSSBxBn7LwJqPTYODlQ4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P6Wmqp2d2DLpL+JrBUavy/dnh6WZCI2fibUB17pytqxzeeCJOQk5EMB5arU+5ZZT0
	 bVHxZvgrY2kJgFZywTBEzn622MKOfeWOJLclf8//dgOLDlvlb1AuW+Gnb70FTQnIMs
	 5kPeWFxO0Ldk442OvnS7SiBia4bkBt+zU+8PFuU2UFUSONV2ef9griJ0l+12KuMDWt
	 ts3ZteFNTe3D01L6IMEihjHKtm7SjlVqVkyQRH+ySFsRcFDUxXtMyVtuz28Pm7EbAC
	 +apSxvX9ZmRalWcz3FjrK95qKo/pBJJGzIQKvDpLMygjWKB6BX05Xf7825EjCabnJ2
	 aP3el6g2qRxng==
Content-Type: multipart/mixed; boundary="===============2193829677159245353=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <556048bab0cc9bda9a7dfe2d041308d35eed943c9295aeabd69d34414e2a9f4c@mail.kernel.org>
In-Reply-To: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-1-27daa15487a9@google.com>
References: <20260527-libbpf-load-vmlinux-btf-in-gen_loader-mode-v4-1-27daa15487a9@google.com>
Subject: Re: [PATCH v4 1/3] libbpf: load vmlinux BTF in gen_loader mode for struct_ops
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,gprocida@google.com,maennich@google.com,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 27 May 2026 13:39:46 +0000 (UTC)

--===============2193829677159245353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 29cedaf6d7d80a7e880a2e639f40fbafcbaf2e65
> Author: Siddharth Nayyar <sidnayyar@google.com>
> Date:   Wed May 27 12:52:57 2026 +0000
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
>     `gen_loader` mode if the BPF object contains `struct_ops` maps.
>
>     Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>

Alexei Starovoitov requested in v3 review that a selftest be added to
prove struct_ops light skeletons work end-to-end:

  "The selftest is mandatory to prove that."
  https://lore.kernel.org/bpf/CAADnVQ+AA_fmRw7uRwdL2TMyMbpWeebOQKb=0wvpKiQR6Ee5xQ@mail.gmail.com/

This requirement has not been addressed in v4. Should a selftest be added
to demonstrate that struct_ops light skeletons work correctly with this
change?

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ab2071fdd3e8..420d37f215ea 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3544,15 +3544,20 @@ static bool prog_needs_vmlinux_btf(struct bpf_program *prog)
>  	return false;
>  }
>
> -static bool map_needs_vmlinux_btf(struct bpf_map *map)
> +static bool obj_maps_need_vmlinux_btf(const struct bpf_object *obj)
>  {
> -	return bpf_map__is_struct_ops(map);
> +	struct bpf_map *map;
> +
> +	bpf_object__for_each_map(map, obj) {
> +		if (bpf_map__is_struct_ops(map))
> +			return true;
> +	}
> +	return false;
>  }
>
>  static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
>  {
>  	struct bpf_program *prog;
> -	struct bpf_map *map;
>  	int i;
>
>  	/* CO-RE relocations need kernel BTF, only when btf_custom_path
> @@ -3577,12 +3582,7 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
>  			return true;
>  	}
>
> -	bpf_object__for_each_map(map, obj) {
> -		if (map_needs_vmlinux_btf(map))
> -			return true;
> -	}
> -
> -	return false;
> +	return obj_maps_need_vmlinux_btf(obj);
>  }
>
>  static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
> @@ -3590,7 +3590,11 @@ static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool force)
>  	int err;
>
>  	/* btf_vmlinux could be loaded earlier */
> -	if (obj->btf_vmlinux || obj->gen_loader)
> +	if (obj->btf_vmlinux)
> +		return 0;
> +
> +	/* only struct_ops maps need btf_vmlinux in gen_loader */
> +	if (obj->gen_loader && !obj_maps_need_vmlinux_btf(obj))
>  		return 0;
>
>  	if (!force && !obj_needs_vmlinux_btf(obj))

This looks like a bug fix for gen_loader mode with struct_ops maps.
Multiple CI reviews (v1 and v3) noted that this should include:

  Fixes: 67234743736a ("libbpf: Generate loader program out of BPF ELF file.")
  https://lore.kernel.org/bpf/b4b4ca51ae8e281a37707cbcd2ba8349dabc6c630e96461929be0872fd8ed0e6@mail.kernel.org/

Should this tag be added to indicate it fixes a limitation in the original
gen_loader implementation?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26512949106
--===============2193829677159245353==--
