Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBA844A730
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628430; cv=none; b=XtxvDzVCUxnGKPARVwssj/VHQp8z2taax1KSxI3tdr/paS34A7KcsLC2IuGuFOjfmLIr86+XWvqrgmHyM0T8gIrrzGyplEW4ArlUgV9tMQi6fhLt4RBGzWJOJEaMUMaHJpwdJvvunfYdWcvtLGUl8GKzmUG65bBH6NkycsjUtI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628430; c=relaxed/simple;
	bh=iwWpOiqYQTBXfgHoUvIsOnxJPYwFi7VPRrP9LmEPMOc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=o2NMLCMAlcIOhgXNIZSD6N+HgdJLimunP8rBPgx/5n65BJxLO0puK0jcYvOIsSK93jgltnrOKZCfwY5dI5Mf6rVktffQNKWJE2ZhRUHyVDzNa5NMVBfQmJy/z4+CkgZAjR56atlCimOVimqm2d+VgVp96eg9ZdFf8w8Pxg+3ybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4w0ummA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4w0ummA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B171F00893;
	Thu, 17 Sep 2026 07:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789628419;
	bh=+xElMieRBI5z1+cmMf9SmLoMWjo7SY6w4p+kQJgr9DY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y4w0ummAIZ0QoyYz+Cw8SJFUyORaQcUEM4emI2ue4NovxZVCcVUkctKSUPeXB8iY4
	 4NC3Bm8l2dEnDeNwj39aO2W90/Pj12E/cAsCFet0IgZHyBik+RVlW5memdYDZF/WUT
	 Z6V9yDFEEDU8jwY9gx5aadII+TS8lSVYhPk+wZXAIt80fWUAYMZsTIlt/Z07sILQQW
	 siGdm6b4RrG5+KP0oVBojbuAU6o7l/KzPnir4C6haoC3bZbJYWosM8+pyKydrezi9O
	 dPrvYEroxHogaI8qsG+Aj0j0qR6uP5aI7dgEyXSD9ekvSBmeExfeewr93JadUjg/AK
	 sKIkBnxvnkUlQ==
Content-Type: multipart/mixed; boundary="===============0751584282405106952=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <19251f166b31c6b7bc6212d2d9008f3f5b06ff7726b1d3c08c7f54467bb0dbc4@mail.kernel.org>
In-Reply-To: <20260917055752.3932718-1-yonghong.song@linux.dev>
References: <20260917055752.3932718-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 13/20] libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 07:00:18 +0000 (UTC)

--===============0751584282405106952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git tools/lib/bpf/libbpf.c tools/lib/bpf/libbpf.c
> index 613afae265199..ea1c09fa37939 100644
> --- tools/lib/bpf/libbpf.c
> +++ tools/lib/bpf/libbpf.c
> @@ -8346,6 +8346,15 @@ static void fixup_verifier_log(struct bpf_program *prog, char *buf, size_t buf_s
>  	}
>  }
>
> +/* LLVM terminates a cleanup landing pad with a call to _Unwind_Resume, the
> + * base unwind ABI's entry point for carrying an unwind on once a frame's
> + * cleanups have run. The kernel knows it as bpf_unwind_resume.
> + */
> +static const char *kern_extern_name(const char *name)
> +{
> +	return strcmp(name, "_Unwind_Resume") ? name : "bpf_unwind_resume";
> +}
> +
>  static int bpf_program_record_relos(struct bpf_program *prog)
>  {
>  	struct bpf_object *obj = prog->obj;

Is the kern_extern_name() mapping applied on the light skeleton load
path?

Looking at bpf_program_record_relos() below kern_extern_name(), the
RELO_EXTERN_CALL case records ext->name directly without calling
kern_extern_name():

static int bpf_program_record_relos(struct bpf_program *prog)
{
    ...
    case RELO_EXTERN_CALL:
        bpf_gen__record_extern(obj->gen_loader, ext->name,
                               ext->is_weak, false, false, BTF_KIND_FUNC,
                               relo->insn_idx);
        break;
    ...
}

This means the generated loader program would ask the kernel for
BTF_KIND_FUNC '_Unwind_Resume', which doesn't exist in vmlinux BTF. The
kernel only knows bpf_unwind_resume per BTF_ID_FLAGS(func,
bpf_unwind_resume) in kernel/bpf/helpers.c.

For comparison, the direct BPF_PROG_LOAD path does use the mapping:

bpf_object__resolve_ksym_func_btf_id() calls kern_extern_name() at
libbpf.c:8824, but that resolution is deliberately skipped when
obj->gen_loader is set:

bpf_object__resolve_ksyms_btf_id() {
    ...
    if (obj->gen_loader) {
        ext->is_set = true;
        ext->ksym.kernel_btf_obj_fd = 0;
        ext->ksym.kernel_btf_id = 0;
        continue;
    }
    ...
}

On the light skeleton path, bpf_btf_find_by_name_kind() would return
-ESRCH for '_Unwind_Resume', causing emit_check_err() to jump to cleanup
and fail the load. If the extern were weak, insn->imm/off would be
stored as 0, which the verifier would reject as an invalid kfunc call.

The test added later in the series
(selftests/bpf/progs/exceptions_cleanup_light.c) writes 'call
bpf_unwind_resume' directly in inline asm, so it uses the kernel name
and never exercises the mapping.

> @@ -8807,17 +8816,19 @@ static int bpf_object__resolve_ksym_func_btf_id(struct bpf_object *obj,
>  	struct module_btf *mod_btf = NULL;
>  	const struct btf_type *kern_func;
>  	struct btf *kern_btf = NULL;
> +	const char *kern_name;
>  	int ret;
>
>  	local_func_proto_id = ext->ksym.type_id;
>
> -	kfunc_id = find_ksym_btf_id(obj, ext->essent_name ?: ext->name, BTF_KIND_FUNC, &kern_btf,
> -				    &mod_btf);
> +	kern_name = kern_extern_name(ext->essent_name ?: ext->name);
> +
> +	kfunc_id = find_ksym_btf_id(obj, kern_name, BTF_KIND_FUNC, &kern_btf, &mod_btf);
>  	if (kfunc_id < 0) {
>  		if (kfunc_id == -ESRCH && ext->is_weak)
>  			return 0;
>  		pr_warn("extern (func ksym) '%s': not found in kernel or module BTFs\n",
> -			ext->name);
> +			strcmp(kern_name, "bpf_unwind_resume") ? ext->name : kern_name);
>  		return kfunc_id;
>  	}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35188619605
--===============0751584282405106952==--
