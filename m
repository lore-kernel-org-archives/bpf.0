Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887DF49CF21
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551884; cv=none; b=qEEp29MMNELR69JTT59Vrvin+vjzoT2DvrB8lthhEAyHijz8bNzB7xIid18oyK4MrsSRLlE03Nike56tXMNU8l5MvCQGLAwozELQvYg+3HHgp2YeJdArArMaIlNubEJbRmR8YV91KpI9ekPFzYep9V4banTfM08pCbVL6IZvNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551884; c=relaxed/simple;
	bh=MfPiVrDKTxTbE6HKqJrw7XSQgdWoS3o9kfBRrnWi82A=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YZ3zAb2EsFiTbvKLF9B+ohM8N48bCo2RD2ZUrNHN4up5TD5ZYudVBZEw1ZJx4kSUuVuzPmc5tepj360OMMvOYw/wpUtliZ3k58Sa2UfWJB08aFoHuHU0f5+Ox4N4nvWSGa3LB212sPtkxwwcSIeaEMEZyeidDir64Ld1kNC6bGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTkaW269; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTkaW269"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB04C1F000FF;
	Fri,  9 Oct 2026 13:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791551882;
	bh=BTSOAcDfOcYemrnnm+xdiUKS4FYdEaoUzhqt1GSpJ3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZTkaW269L+KVMl3bphMxVBO5UoGFcx6Eyyuc7ksKto5LiLebwwnaVaGQrGbElP6bG
	 JI6H0Ze/G3rj4/QgjStvb4q1hCS9WSfjDYmmpctx2XXoalvoxQHQFqSXjJ2OZLRHBx
	 hyxB1xtkvAXt6jtPYT3pLYQsOHYzbIK5Nw0lgHwGXaXdAltmRlU9cqQrPqRxXvjWfN
	 wGBTUe2AT2G/fhioJR695jIfR5a2mIy3X+xORmi50mtjGNzIAp9eP+Wna7sucq1zEk
	 2QwQ3Poa5mZI1vorymTfcQn3/lvde+QG5XA8sA7E8u1YL/dKxgZYjkU/kHuE3zIgqh
	 lUjXg01eokOMQ==
Message-ID: <sashiko-outbox-165614@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] libbpf: Resolve typeless ksyms in the kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Samuel Wu" <wusamuel@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009130708.1370675-1-wusamuel@google.com>
References: <20261009130708.1370675-1-wusamuel@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 13:18:01 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] libbpf: weak LTO ksyms fail to resolve and silently default to z=
ero
- [Medium] libbpf: fast path bypasses ksym ambiguity check
--

commit fc5b255aa262ee9f680fe13bd2bcb9fc56ff8a8d
Author: Samuel Wu <wusamuel@google.com>

libbpf: Resolve typeless ksyms in the kernel

This commit optimizes the resolution of typeless kernel symbols by using a
BPF_PROG_TYPE_SYSCALL program to call bpf_kallsyms_lookup_name() in the
kernel. This reduces load time significantly by avoiding a linear scan of
/proc/kallsyms in the fast path, while falling back to the legacy parser
if the kernel resolution fails.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9590,6 +9590,58 @@ static int bpf_object__read_kallsyms_file(struct b=
pf_object *obj)
[ ... ]
> +static int bpf_object__resolve_ksyms_in_kernel(struct bpf_object *obj)
> +{
[ ... ]
> +	for (i =3D 0; i < obj->nr_extern; i++) {
> +		ext =3D &obj->externs[i];
> +		if (ext->type !=3D EXT_KSYM || ext->ksym.type_id)
> +			continue;
> +		if (snprintf(ctx.name, sizeof(ctx.name), "%s", ext->name) >=3D sizeof(=
ctx.name)) {
> +			err =3D -ENAMETOOLONG;
> +			break;
> +		}
> +		err =3D bpf_prog_test_run_opts(prog_fd, &topts) ?: (int)topts.retval;

[Severity: Medium]
Does this fast path bypass the ambiguity checks normally enforced by the le=
gacy
kallsyms parser?

In the legacy parser, kallsyms_cb() enforces a strict ambiguity check and
returns -EINVAL if a symbol name maps to multiple addresses. However,
bpf_kallsyms_lookup_name() simply returns the first matched address.

If the fast path succeeds, ambiguous symbols might be silently accepted. If=
 the
fast path fails for any reason (such as older kernels without support, or an
unrelated missing strong symbol triggering a fallback), it drops into the l=
egacy
parser which then unpredictably rejects those same ambiguous symbols. Could=
 this
lead to non-deterministic behavior depending on which path is taken?

> +		if (err =3D=3D -ENOENT && ext->is_weak) {
> +			err =3D 0;
> +			continue;
> +		}

[Severity: Medium]
When bpf_kallsyms_lookup_name() fails to find a weak LTO symbol (like those
ending in .llvm.<hash>) because it expects an exact string match, this block
clears the -ENOENT error and continues.=20

Because the error is cleared to 0, bpf_object__resolve_ksyms_in_kernel() wi=
ll
ultimately return success for this missing symbol.

Will this cause the caller to unintentionally skip the necessary fallback l=
ogic?

In bpf_object__resolve_externs(), the fallback to
bpf_object__read_kallsyms_file() is only triggered if
bpf_object__resolve_ksyms_in_kernel() returns a non-zero error. By clearing
the error here, the /proc/kallsyms fallback is bypassed, meaning weak LTO
symbols that are actually present in the kernel might silently default to z=
ero
instead of resolving properly.

> +		if (err)
> +			break;
> +		ext->is_set =3D true;
> +		ext->ksym.addr =3D ctx.addr;
> +		pr_debug("extern (ksym) '%s': resolved in kernel to 0x%llx\n",
> +			 ext->name, ext->ksym.addr);
> +	}
> +	close(prog_fd);
> +	return err;
> +}
[ ... ]
> @@ -9863,7 +9915,12 @@ static int bpf_object__resolve_externs(struct bpf_=
object *obj,
[ ... ]
>  	if (need_kallsyms) {
> -		err =3D bpf_object__read_kallsyms_file(obj);
> +		err =3D bpf_object__resolve_ksyms_in_kernel(obj);
> +		if (err) {
> +			pr_debug("failed to resolve ksyms in kernel: %s, falling back to /pro=
c/kallsyms\n",
> +				 errstr(err));
> +			err =3D bpf_object__read_kallsyms_file(obj);
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009130708.1370=
675-1-wusamuel@google.com?part=3D1
