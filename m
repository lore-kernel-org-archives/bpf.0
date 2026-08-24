Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261835AC11
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584654; cv=none; b=s+4oxl1z8XOoVuiyZ6rISwb1OXC5yFN0TJBOapJ601cUKlX6BpcHOMRHMbRS5MoIsGkxCemudMOaEHalXJWiMnlCgZ75OIlvuW/BzcggGqz5PPvN8Fjj46N2c0CCPZ7Zl9V4vYXe7qlf15sX1rhnVODDys62JqUqyiFm/FuR9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584654; c=relaxed/simple;
	bh=pS+AC2c0LxEFUkcQIQYbbBUkmvuI4bxK2JfW5TYOaPc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OldMdwcrnvqbYurMBkt7/GVyaliYeFo3ndnGZN0rHL9rGz0iVZ45DZOR8C3nuRXREaWhkUV1rP8qJKMbrViHw/6uw80ATW0HVuFd4ZXLsjvoeth8AUwfu8NtKVRG8fieU4xq6N8SFOkbhJeHpSwAmuofpy5tfrBgXsrVm9FYY5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/+yzEAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/+yzEAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FAE1F000E9;
	Mon, 24 Aug 2026 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584653;
	bh=gQI0elQCH0WEr9AtRY/ToE179JZK5mI//G38fFhIUHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X/+yzEAWme4do1Z14CRUcMJb4/+B35P2+xELcI7F0PQIDtfD9fqaKJPYGV9RKs+gy
	 yOCfX9R7567mgAIk3T5niEhhm68eij+uMENJRN8Vdj8s7Y+Ugnxe9EgKxPuBaZ5u32
	 ys1hHxV40XuXY0x3wsHCih4I9UGVfDxvK/A5FQcRbOWqawUi2/kWdlS9Fs0GQroV8i
	 F8j3b9uSJUb7+Trbhh2vPoQjMaOXoyD64C9NgDyIVS4m4Q0r8UpeUU9+ZqQntAf2xM
	 SEY96LSP7+hTf+BnyFDps3shpzljhUVC7byGfX8uwZFhsX2NxkzbWpb2GZVzwekvGA
	 UmPh5/OhsmR8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] bpf: Fix use-after-free of program BTF in mem-alloc
 destructor
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824143621.2098856-3-chenyuan_fl@163.com>
References: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
 <20260824143621.2098856-1-chenyuan_fl@163.com>
 <20260824143621.2098856-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:17:32 +0000
Message-Id: <20260824151732.D0FAE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Race condition in `htab_dtor_ctx_free` leading to a use-after-free=
 of the program BTF.

Pre-existing issues:
- [Critical] The patch fails to fix the use-after-free for BPF_LIST_HEAD an=
d BPF_RB_ROOT fields, which also rely on the program BTF.
--

--- Patch [2]: [PATCH 2/4] bpf: Fix use-after-free of program BTF in mem-al=
loc destructor ---
commit 67cf446d3408eefa2548db164b549cbc9a9e17a2
Author: Yuan Chen <chenyuan@kylinos.cn>
Subject: bpf: Fix use-after-free of program BTF in mem-alloc destructor

This commit addresses a use-after-free issue of the program BTF in the
bpf_mem_alloc destructor. It holds a reference to the program BTF for the
lifetime of the duplicated record and drops it right before the record is
freed.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 0df8db27cd8cc..b8df2bc9a9a00 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> @@ -493,10 +493,54 @@ static void htab_pcpu_mem_dtor(void *obj, void *ctx)
>  		bpf_obj_free_fields(hrec->record, per_cpu_ptr(pptr, cpu));
>  }
> =20
> +/*
> + * bpf_ma_set_dtor() duplicates the map's btf_record. For kptr fields wh=
ose
> + * btf is the program BTF (MEM_ALLOC kptrs, e.g. objects allocated with
> + * bpf_obj_new()/bpf_percpu_obj_new()) btf_record_dup() only borrows the
> + * reference, like btf_parse_fields() did for the map's own record. The
> + * duplicated record is released later from the deferred bpf_mem_alloc
> + * destructor workqueue, by which time the program BTF may already have =
been
> + * freed (the map dropped its own reference in bpf_map_free()), so readi=
ng
> + * field->kptr.btf there would be a use-after-free.
> + *
> + * Hold a reference on non-kernel (program) BTF for the lifetime of the
> + * duplicated record and release it before the record is freed. After the
> + * last btf_put() the object is only destroyed after an RCU grace period=
, so
> + * btf_record_free() can still safely read the field descriptors.
> + */
> +static void htab_record_prog_btf_ref(struct btf_record *rec, bool get)
> +{
> +	int i;
> +
> +	if (IS_ERR_OR_NULL(rec))
> +		return;
> +
> +	for (i =3D 0; i < rec->cnt; i++) {
> +		const struct btf_field *field =3D &rec->fields[i];
> +
> +		switch (field->type) {
> +		case BPF_KPTR_UNREF:
> +		case BPF_KPTR_REF:
> +		case BPF_KPTR_PERCPU:
> +		case BPF_UPTR:

[Severity: Critical]
This is a pre-existing issue, but does this switch statement also need to
handle BPF_LIST_HEAD and BPF_RB_ROOT fields?

These field types also rely on the program BTF. When a map containing them
is destroyed, the deferred mem-alloc destructor is scheduled. Because we
don't retain a reference to the program BTF for these types, the program
BTF can be freed when the map drops its reference.

Later, when the deferred destructor calls bpf_obj_free_fields(),
bpf_list_head_free() could dereference the dangling
field->graph_root.value_rec pointer (which points into the freed program
BTF's struct_meta_tab):

kernel/bpf/helpers.c:bpf_list_head_free() {
    ...
    __bpf_obj_drop_impl((char *)pos - field->graph_root.node_offset,
                        field->graph_root.value_rec, false);
    ...
}

> +			if (field->kptr.btf && !btf_is_kernel(field->kptr.btf)) {
> +				if (get)
> +					btf_get(field->kptr.btf);
> +				else
> +					btf_put(field->kptr.btf);
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
>  static void htab_dtor_ctx_free(void *ctx)
>  {
>  	struct htab_btf_record *hrec =3D ctx;
> =20
> +	htab_record_prog_btf_ref(hrec->record, false);
> +	btf_record_free(hrec->record);

[Severity: High]
Can this sequence introduce a race condition leading to a use-after-free of
the program BTF?

This code executes in a preemptible workqueue context
(free_mem_alloc_deferred) without RCU read protection. When
htab_record_prog_btf_ref() is called with get=3Dfalse, it drops the program
BTF reference. If this is the last reference, the BTF object is scheduled
for RCU destruction.

If the thread is preempted immediately after this call and an RCU grace
period elapses, the BTF memory could be freed. Then the next line calls
btf_record_free(), which iterates over the fields and dereferences the
potentially freed kptr.btf inside btf_is_kernel():

kernel/bpf/syscall.c:btf_record_free() {
    ...
    if (btf_is_kernel(rec->fields[i].kptr.btf))
        btf_put(rec->fields[i].kptr.btf);
    ...
}

>  	kfree(ctx);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824143621.2098=
856-1-chenyuan_fl@163.com?part=3D2
