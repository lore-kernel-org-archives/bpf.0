Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998598;
	b=cKDpHQUlr9N6YIYfKpAKyVEtoLXfsM2Grubjb9eeHfjTb5j5kStmzChpF9N/xMpyWlVF
	 piB1gj47b8gEbM8FzUSMW8/3crNVGcRbE1Yh1YjzuEw5WP5avwvuVX1ldKgyNyxelKjKp
	 tsgN64IygTojcfyX0hQVWyAhqlww0j2YNjDHaybahFg88qq4+M9IHJSebe5DF0BaETet6
	 NNhmxr/mBbdVP12F5dzV949IAeSRYiyw3VMOD/WXhjCNpIcAiq/9CjHCjXPfWkbnDWYQf
	 3BLBp5Ahz/uMzMxONT9Dc6CYI0d/tDyP2e3icVB+x2OUwmJgf9fwfkguLEYbfQGe88w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998598;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ErWiuFp9/TbFuEZjYat7Wfoqr4sd7GG4h/sKsc3g0ro=;
	b=cRxG0H4Y3UAn3UjWvJxtcRCmsyH+T/oZj30UoSbVd59Nd9sYlStN5MKljOwJpT9XB7ag
	 q0tn2HNT4z/6ANbzW+VnLhGH3vyWrGbLFjWW6HN7KWrWA2ff0sWRgHWyqDnXjg1mOOoh0
	 YYBmvZqUShZp7PdUrixVJhWuW4DfLrfiAurGmC3nzub+7O+IhGu0fyiDvFB0Rhi7RtLu0
	 GakYw+EVmAfDxuhpbWHcjNFv8QyYGDq3DztWQkOVOfdSdUzR64DEVFvTsa4/C1glbl672
	 /24aoD0QRzPFo2OPCAEIcElPASueJaI41E1tIbU11GudQUkdek/hd4pbSYHBaq8iQMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtubZ48x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDEF606A33E;
	Fri,  6 Nov 2026 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtubZ48x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6011F0089F;
	Fri,  6 Nov 2026 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998598;
	bh=ErWiuFp9/TbFuEZjYat7Wfoqr4sd7GG4h/sKsc3g0ro=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gtubZ48xUhO3CSZ57SrmhW8ks4lUTq+BCadaYE+Me4hx98qpsLBmhZnpV2BUaTqn4
	 xlVYAAhBtXpLIADNFeqSt4F65zxxQpfkUJ4u9sXcNdIRAPCXwyo5pddA2J4EnhR+EF
	 Excb0rESml94/JznsogoNUzd9/5zHCPfT+hTr74mw4KCWsmeqE9/eMOowtsqJ6pNXK
	 1eWlP1eKzzZx3Tc8jEBFTmpR07lxsBkdk3l41XcDGUXZOJOiJxC1jQa/jh21GoVATs
	 Px+oVwe9c5FYulj2lfURgOg4wRZ7YOXSDAYVD8hPx6zais1S1bCjiRBjW+uxu4lJ/j
	 Hv0GlEWsLllWw==
Content-Type: multipart/mixed; boundary="===============1853805646858724504=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d443a99c61ebd277a8b46dfeaa5061cb20a64abaffb750e390188e892aa79db8@mail.kernel.org>
In-Reply-To: <20261106-lskel-struct-ops-v1-4-a4486ffc79cb@google.com>
References: <20261106-lskel-struct-ops-v1-4-a4486ffc79cb@google.com>
Subject: Re: [PATCH RFC bpf-next 4/7] libbpf: Support BPF_PROG_TYPE_STRUCT_OPS in bpf_gen__prog_load()
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,gprocida@google.com,nkapron@google.com,tweek@google.com,mripard@kernel.org,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 20:56:37 +0000 (UTC)

--===============1853805646858724504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Support BPF_PROG_TYPE_STRUCT_OPS in bpf_gen__prog_load()

TL;DR: In light skeletons, a kernel-module BTF fd for struct_ops may leak
(stay open in the loader's fd table) if any struct_ops program load fails,
since no error-path close is emitted.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c

[ ... ]

> @@ -1151,6 +1151,20 @@ void bpf_gen__prog_load(struct bpf_gen *gen,
>  		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
>  				      offsetof(union bpf_attr, attach_btf_obj_fd)));
>  	}
> +	if (prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
> +		move_blob2blob(gen, attr_field(prog_load_attr, expected_attach_type), 4,
> +			       load_attr->expected_attach_type);
> +		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX_VALUE,
> +						 0, 0, 0, load_attr->attach_btf_id));
> +		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1, 0));
> +		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_0, BPF_PSEUDO_MAP_IDX_VALUE,
> +						 0, 0, 0, prog_load_attr));
> +		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
> +				      offsetof(union bpf_attr, attach_btf_id)));
> +		emit(gen, BPF_ALU64_IMM(BPF_RSH, BPF_REG_7, 32));
> +		emit(gen, BPF_STX_MEM(BPF_W, BPF_REG_0, BPF_REG_7,
> +				      offsetof(union bpf_attr, attach_btf_obj_fd)));
> +	}
>  	emit_relos(gen, insns_off);
>  	/* emit PROG_LOAD command */
>  	emit_sys_bpf(gen, BPF_PROG_LOAD, prog_load_attr, attr_size);

For a struct_ops type defined in a kernel module, can the module BTF fd
leak into the process running the light skeleton when a struct_ops
program fails to load?

The block above copies the upper 32 bits of the u64 at
load_attr->attach_btf_id into prog_load_attr.attach_btf_obj_fd.  That
value was produced at runtime by bpf_btf_find_by_name_kind() in
bpf_gen__init_kern_struct_ops().  For a module type it creates a new fd
with __btf_new_fd() and returns:

    ret | ((u64)btf_obj_fd << 32)

so this is an open fd owned by the loader.

The existing code closes module BTF fds whether the load succeeds or not:

    /* successful or not, close btf module FDs used in extern ksyms and attach_btf_obj_fd */
    cleanup_relos(gen, insns_off);
    if (gen->attach_kind) {
            emit_sys_close_blob(gen,
                                attr_field(prog_load_attr, attach_btf_obj_fd));
            gen->attach_kind = 0;
    }
    emit_check_err(gen);

bpf_gen__map_create() does the same for value_type_btf_obj_fd, but the
struct_ops path here does not.  The fd cannot be closed here because all
programs of the map share it.  The only close is in
bpf_gen__struct_ops_update_elem(), added later in the series, which is
emitted from bpf_object_prepare_struct_ops() after all programs are
loaded and so only runs on success.

If BPF_PROG_LOAD fails for any struct_ops program (for example a verifier
rejection), emit_check_err() jumps to gen->cleanup_label.  The cleanup
code emitted by bpf_gen__init() only closes the prog_fd[] stack slots and
the map fds in the blob fd_array:

    for (i = 0; i < nr_progs_sz; i += 4) { ... BPF_FUNC_sys_close ... }
    for (i = 0; i < nr_maps; i++)
            emit_sys_close_blob(gen, blob_fd_array_off(gen, i));

Nothing there knows about st_ops->type_id_off, so the module BTF fd of
every struct_ops map initialised so far stays open in the caller's fd
table.  The same applies to any later failure before
bpf_gen__struct_ops_update_elem() runs, such as another program's load or
an emit_check_err() in emit_relos().  vmlinux struct_ops types are not
affected, since the upper 32 bits are 0 and __emit_sys_close() skips
fd <= 0.

No later commit in the series adds an error-path close.  Should these fds
be added to the cleanup_label path, or closed in an error branch around
the prog-load emit_check_err()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42289585064
--===============1853805646858724504==--
