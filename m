Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E341D231
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625317; cv=none; b=I5sTL5LwudhzE8gDbcPgewBRRxAhOZsoX695woCb1r+nMwTYaRyIDSuOf1SOVH9iSLa2RhSHQojfn64aUc4tFl7S2sRKmNCGmHnupoqooo+RZwaaeyYiYj6x4uk+e0t97LWCGqEfvrLb0CToNHtrVWUA1akxUMfwG7Cq1E1oX04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625317; c=relaxed/simple;
	bh=HPu1IJFFjNyadSdRFh1ZbiSSg4WISo11VRz3pmZNy90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hZebeRd1ko3NxNLxou9C36eTbxJaGdvwgbDDHe0MmukRrj9/2IcnNGousWKlYUgP1583dcFUvwiwu0JwNC6rkGYarRJJP7582fcJ3vxDLRiaRqbhz4zkl6cAkhMTGpsD9u3ltAA6IsOODaddzdOLEkKc9EfopXcf67uq5AD/I1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUO4kdYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUO4kdYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEF61F000FF;
	Thu, 17 Sep 2026 06:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625315;
	bh=FJFfi4S8AbN6ykJZgGvFoFjLV20IRVxlk2THOjXJeCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iUO4kdYaBzH7jj8oz9M/wJtClbXQNd6ufEGMRR/8Zk7oSjx8OF8ytqRp2QPnXE9Fq
	 2yqTBS9Kf5fHTRpcRE8irIYLrzFsXTlvQqKbIfhYv5iWozctofdh5MJfKCHF0Ju5rP
	 g9Blk0SnUlfpmNPp0H7M7anyhwzh6yQx+cg8p6gdZlVDs6EHFbk1QhEAr5ayk/bo9B
	 B+9C2gRbBbhTCLTrOD+kE4HhxTBcwq1eg/i0CwhvErK5lil5bvpxSarueM63tgmS/K
	 reeYbd3doCCOM6GNuJx4oQTW2SKIgnSWCIc49wro/k6ve8y+fJl/BROirMKrqMXMD7
	 M9MTnWnK7cR0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 13/20] libbpf: Resolve the compiler's
 _Unwind_Resume to the kernel's kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917055752.3932718-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055752.3932718-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:08:35 +0000
Message-Id: <20260917060835.8EEF61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment violates BPF subsystem style guide
--

commit 082b791c15a0d9341a2e4f4d61c9b916d48b95fc
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc

This commit maps LLVM's _Unwind_Resume function calls in cleanup landing pa=
ds
to the kernel's corresponding bpf_unwind_resume kfunc. This ensures proper
symbol resolution without polluting the kernel's symbol table.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 613afae265199..ea1c09fa37939 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8346,6 +8346,15 @@ static void fixup_verifier_log(struct bpf_program =
*prog, char *buf, size_t buf_s
>  	}
>  }
> =20
> +/* LLVM terminates a cleanup landing pad with a call to _Unwind_Resume, =
the
> + * base unwind ABI's entry point for carrying an unwind on once a frame's
> + * cleanups have run. The kernel knows it as bpf_unwind_resume.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment format violate the
BPF subsystem style guide? The guide specifies that multi-line comments
must have the opening /* on its own line, rather than starting the text
on the same line as the opening characters.

> +static const char *kern_extern_name(const char *name)
> +{
> +	return strcmp(name, "_Unwind_Resume") ? name : "bpf_unwind_resume";
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917055645.3926=
444-1-yonghong.song@linux.dev?part=3D13
