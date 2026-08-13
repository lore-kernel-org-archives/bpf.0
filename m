Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE533D47CF
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786659602; cv=none; b=khcEvi2MPxGDrVgloG7jMNZq+6RD01ZOydWhdvWFKckytf1tQlYrcdWHfvJHQzt955Gdnz+x8gD/nu+KPFXHJdnUBFyfA+VFxuo7h8yWZ1wMiI/xDwuys01KB4Pnq39taFEkynFOfyl42dPgnihgPspl5zzNXoaKklDLgEWlx3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786659602; c=relaxed/simple;
	bh=cNDopMJLGLwJlhH2OiQlVacfqz8M/ZxOw8bY4zhUm80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XViEjp6DjlBvpAr4eLOPHWGG+ZgjYwMrULlYhsCyapVru0lZO2Ag/wmj2/dlDvJdlD1+kFgvQOb61wuZNqbxfH/QyRtvt2HikWs2HXpaZmxvio5TSQJjnVNoRlJl24Qr8yQWVtWjopxz5tKXl26RazFiGKKAoMLC5zvgif+aMVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnXMl1ZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnXMl1ZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3311F000E9;
	Thu, 13 Aug 2026 22:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786659601;
	bh=8pYbP2+fj6BLr9kn8vyQW3CbBcbvbr3awYyWmDRgcYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mnXMl1ZIJ8EjKijIJM7Xkkvi8rEXbLIrDSPrxiYJdJGopFyr1YRptj31ezFIJEPXg
	 qKjyRdldbR2YcV/A4dJZgEMl7dgwAJ/1mnSpEJLwnReIay84k556JizWe8YAjuTqcc
	 9wBFiVq0W+A189tWK92b6YnWnS2SnEN139SGYbox4MXXKRl9+QSTjVY51jgPHhRdTR
	 pX2KTLyIUNz7aEHuVDaSSECiY+fCm3ooVfkOwZNcRAT/cKfq9dg7rT+F8xpxUrBNbn
	 P4OBFAXxLF3wH/DE9eTXoqylN5Un6U5poLAs7lY49zXV7rFYv4Z/XxN41HixT4E+pG
	 1grTQJWFD+uiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 01/13] bpf: Introduce kfuncs to parser buffer content
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pingfan Liu" <piliu@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260322014402.8815-2-piliu@redhat.com>
References: <20260322014402.8815-2-piliu@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:20:00 +0000
Message-Id: <20260813222000.CB3311F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] `bpf_buffer_parser` enables a tracing program to alter the beh=
avior of privileged operations without the `KF_DESTRUCTIVE` flag, bypassing=
 Secure Boot and lockdown restrictions.
- [High] The `bpf_buffer_parser` kfunc lacks the mandatory `__sz` suffix fo=
r its size argument, preventing the BPF verifier from enforcing bounds chec=
king and allowing arbitrary out-of-bounds kernel memory reads.
- [High] Context ID allocation uses raw memory addresses, allowing a BPF pr=
ogram to exploit an ABA vulnerability to hijack unrelated parser contexts.
- [High] The kfuncs `bpf_get_parser_context` and `bpf_put_parser_context` u=
se a bare `spin_lock()` to protect the context hashmap, leading to deadlock=
s when called from BPF tracing programs executing in IRQ or NMI contexts.
- [High] BPF programs can asynchronously extend a parser context's lifetime=
 beyond the kernel caller's underlying resources, causing `context->func` t=
o trigger a Use-After-Free.
- [High] The release function for the parser context invokes `vfree()` and =
`kfree()`, which are unsafe and will crash when called from an atomic or NM=
I context.
- [Medium] Releasing the `context->buf` pseudo-lock uses a plain store, all=
owing memory reordering to cause data races.
--

--- Patch [1]: [PATCHv7 01/13] bpf: Introduce kfuncs to parser buffer conte=
nt ---
commit aad6827f1d21b01308897cd07d851cc0ef53ac1c
Author: Pingfan Liu <piliu@redhat.com>

bpf: Introduce kfuncs to parser buffer content

This patch introduces BPF buffer parser kfuncs to allow BPF programs to
construct and pass structured buffers directly to kernel callbacks. It adds
mechanisms for acquiring, releasing, and using a parser context within BPF
tracing programs.

> diff --git a/kernel/bpf/bpf_buffer_parser.c b/kernel/bpf/bpf_buffer_parse=
r.c
> new file mode 100644
> index 0000000000000..5d5c068330791
> --- /dev/null
> +++ b/kernel/bpf/bpf_buffer_parser.c
> @@ -0,0 +1,186 @@
[ ... ]
> +static void release_bpf_parser_context(struct kref *kref)
> +{
> +	struct bpf_parser_context *ctx =3D container_of(kref, struct bpf_parser=
_context, ref);
> +
> +	if (ctx->buf) {
> +		vfree(ctx->buf->buf);
> +		kfree(ctx->buf);
> +	}

[Severity: High]
Can this trigger a crash if the last kref is put from an NMI or hardirq
context?

Since BPF tracing programs can run in these contexts, dropping the last
reference via bpf_put_parser_context() would synchronously call vfree() and
kfree(), which sleep and are not NMI-safe.

> +	spin_lock(&bpf_parser_context_lock);
> +	hash_del(&ctx->hash_node);
> +	spin_unlock(&bpf_parser_context_lock);
> +	kfree(ctx);
> +}
> +
> +struct bpf_parser_context *alloc_bpf_parser_context(bpf_parser_handler_t=
 func,
> +		void *data)
> +{
> +	struct bpf_parser_context *ctx;
> +	unsigned int key;
> +
> +	ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return NULL;
> +	ctx->func =3D func;
> +	ctx->data =3D data;
> +	kref_init(&ctx->ref);
> +	key =3D bpf_parser_context_hash_key(ctx);

[Severity: High]
Does using the raw pointer address as the hash key introduce an ABA
vulnerability?

If a context is freed and the SLUB allocator reuses the exact same memory
address for a new context, could a BPF program holding the old ID
unexpectedly hijack the new operation?

> +	spin_lock(&bpf_parser_context_lock);

[Severity: High]
Does this risk a deadlock if an interrupt fires while this lock is held in
process context?

If a BPF tracing program in the interrupt handler calls
bpf_get_parser_context(), it will attempt to acquire this same
bpf_parser_context_lock, which is a bare spin_lock() and does not disable
interrupts.

> +	hash_add(bpf_parser_context_map, &ctx->hash_node, key);
> +	spin_unlock(&bpf_parser_context_lock);
> +
> +	return ctx;
> +}
[ ... ]
> +static struct bpf_parser_context *find_bpf_parser_context(unsigned long =
id)
> +{
> +	struct bpf_parser_context *ctx;
> +	unsigned int key;
> +	int cnt;
> +
> +	key =3D bpf_parser_context_hash_key((struct bpf_parser_context *)id);
> +	spin_lock(&bpf_parser_context_lock);
> +	hash_for_each_possible(bpf_parser_context_map, ctx, hash_node, key) {
> +		if (ctx =3D=3D (struct bpf_parser_context *)id) {

[Severity: High]
Is it safe to directly cast the user-provided integer id back to a struct
bpf_parser_context pointer for comparison?

This seems to complete the ABA vector mentioned above, allowing direct acce=
ss
if the memory address happens to be reallocated for a new context.

> +			cnt =3D kref_get_unless_zero(&ctx->ref);
> +			if (!cnt)
> +				ctx =3D NULL;
> +			spin_unlock(&bpf_parser_context_lock);
> +			return ctx;
> +		}
> +	}
> +	spin_unlock(&bpf_parser_context_lock);
> +
> +	return NULL;
> +}
[ ... ]
> +__bpf_kfunc int bpf_buffer_parser(char *buf, int buf_sz,
> +		struct bpf_parser_context *context)
> +{

[Severity: High]
Does buf_sz need the __sz suffix in its name for the BPF verifier to enforce
bounds checking?

Without the suffix, the verifier might treat the size parameter as an
independent scalar. This could allow out-of-bounds kernel memory reads when
the arbitrary size is later passed to copy_from_kernel_nofault().

> +	struct bpf_parser_buf *parser_buf;
> +	void *old_val;
> +	int ret;
> +	char *b;
[ ... ]
> +	parser_buf->buf =3D b;
> +	parser_buf->size =3D buf_sz;
> +	context->buf =3D parser_buf;
> +	/* @func should be a sync call */
> +	ret =3D context->func(context);

[Severity: High]
Can context->func() trigger a use-after-free here?

If a BPF program acquires the context reference and sleeps, the original
kernel caller might complete and free the underlying context->data. When
bpf_buffer_parser() is eventually called, it would execute context->func on
freed external data.

> +	context->buf =3D NULL;

[Severity: Medium]
Should this be an smp_store_release()?

Using a plain store to release the context->buf lock might allow memory
reordering, causing concurrent programs on weakly-ordered CPUs to observe
incomplete memory writes.

> +	vfree(b);
> +	kfree(parser_buf);
> +
> +	return ret;
> +}
> +__bpf_kfunc_end_defs();
> +
> +BTF_KFUNCS_START(buffer_parser_ids)
> +BTF_ID_FLAGS(func, bpf_get_parser_context, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_put_parser_context, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_buffer_parser, KF_SLEEPABLE)

[Severity: Critical]
Does bpf_buffer_parser require the KF_DESTRUCTIVE flag?

Since this kfunc enables a tracing program to alter the behavior of
privileged operations like kexec, omitting the flag might allow unprivileged
tracing programs to bypass kernel lockdown and Secure Boot by covertly
injecting malicious payloads.

> +BTF_KFUNCS_END(buffer_parser_ids)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260322014402.8815=
-1-piliu@redhat.com?part=3D1
