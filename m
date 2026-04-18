Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713E12628D;
	Sat, 18 Apr 2026 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776492659; cv=none; b=CyWbVX++/kdB0v53BbedDr8O4Suj4ImzrihP/PPsJrh7GQBQvO/9A1RHO3dvnHoMbrMvSP4Z8PSfegbfsozMmSl+0O+dZiDx4M+r/g7qL9kL/GIlTiN3+ZzZMn7zZjWb/GYClitkY0N07zQTXNGqU/NNprb5G0CYEJQ5p3dYH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776492659; c=relaxed/simple;
	bh=Yc31gG5luyQ3nCgXNH/t6x+b90saq6GSEJbPnba8bfI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hQKX3LgOJblK7zZUG/GRFFx+rTOzS5/v8A9hF3qBezPi9rrvWqvPiokmWcD4C2+4DTpCOn5rQ1cHo686zIL+qy33+x0izecUrxdGiUFUoxorsMzCiCMwJIopY1yMCcxLRfitDmASFaUZ1T+0tZXkLXuDCmbJq7XCjPHXz+V7/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mujd3wCm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mujd3wCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FB9C19424;
	Sat, 18 Apr 2026 06:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776492659;
	bh=Yc31gG5luyQ3nCgXNH/t6x+b90saq6GSEJbPnba8bfI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Mujd3wCm7BEZ0axUCSFuls3fcmeXkNrE8MdSTAlHucG+HKD3Y/BwofOSoeji6JuBz
	 5JKuEV9Sk/MfXWaqk5245VmVKjW4wkhpa2URIFD0fAo4Csl2BO2lU7HW9hl5br8kP6
	 L1XChATyMI0s8TdSV9IcYWDULEZonnkVgOFXmf/3Cs6fRAJVNmMyFZ1xPnYAkL8hdA
	 1V0LZOtQ9FCapaomC6SND6WGya3K0B34aAXtbQ3QGI4Q0N0EGu/eD04OZ/BpKFTBvu
	 mFOirVTFp4oEyryy0bAeEvqvw0aLPZyxWe9s5m38BtLtEIwk2Vd6h/U27Cy+Xc/BVy
	 rs/sP41A8m/UQ==
Content-Type: multipart/mixed; boundary="===============8804953040684429074=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <658609fdf8d0b9ee59a5a516fd7dd2460ef7cb52b9fca779094dfb761e43aa82@mail.kernel.org>
In-Reply-To: <20260417192502.194548-21-jolsa@kernel.org>
References: <20260417192502.194548-21-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 20/28] libbpf: Add support to create tracing multi link
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 18 Apr 2026 06:10:58 +0000 (UTC)

--===============8804953040684429074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 49368ee161b1..9bf7e8754c7b 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -12510,6 +12592,197 @@ bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t
>  	return true;
>  }
>
> +static int collect_func_ids_by_glob(const struct bpf_program *prog, const char *pattern, __u32 **ids)
> +{
> +	struct bpf_object *obj = prog->obj;
> +	const struct module_btf *mod;
> +	struct btf *btf = NULL;
> +	const char *sep;
> +	int err;
> +
> +	err = bpf_object__load_vmlinux_btf(obj, true);
> +	if (err)
> +		return err;
> +
> +	/* In case we have module specified, we will find its btf and use that. */
> +	sep = strchr(pattern, ':');
> +	if (sep) {
> +		mod = find_attach_module(obj, pattern);
> +		if (!mod) {
> +			err = -EINVAL;
> +			goto cleanup;
> +		}
> +		btf = mod->btf;
> +		pattern = sep + 1;
> +	} else {
> +		/* Program is loaded for kernel module. */
> +		if (prog->attach_btf_obj_fd)
> +			return -EINVAL;
> +		btf = obj->btf_vmlinux;
> +	}
> +
> +	err = collect_btf_func_ids_by_glob(btf, pattern, ids);
> +
> +cleanup:
> +	bpf_object_cleanup_btf(obj);
> +	return err;
> +}

Does this function leak the vmlinux BTF when prog->attach_btf_obj_fd is
set? The early return bypasses the cleanup label that calls
bpf_object_cleanup_btf(obj). Every other error path goes through
cleanup, which suggests the BTF loaded by bpf_object__load_vmlinux_btf()
needs to be cleaned up before returning.

The design pattern here is that bpf_object__load_vmlinux_btf(obj, true)
is called specifically at attach-time (after the object has already been
post-load-cleaned), so obj->btf_vmlinux is freshly loaded. Skipping the
cleanup leaves that freshly-loaded btf_vmlinux attached to the bpf_object
until bpf_object__close().

Should this be 'err = -EINVAL; goto cleanup;' to match the other error
paths?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047
--===============8804953040684429074==--
