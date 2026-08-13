Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB1136215D
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660359; cv=none; b=IDgLDgLvQ4ZtFr+8j8TF/r1JePjR4llyfJIOXPOkXpX1iI7VSs2dXzU6Iz9DIX7RYNL0lyeBK4m+TUiYykD4mpdze05WEHPiVIN0+u2U+zHn//bLTbIOeqYoQKyMPxwEBMO9rPWWbt2LiknQrtcF7QoSLkkFMwx+PuRYWv9MAh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660359; c=relaxed/simple;
	bh=P9tXm7ziA2uuqMGnoC/M3nqJ2E0hGI7U4dFyEn7sfhI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pRI5FsJjgkL3zaw1blEn836jzhpkoEVlSl/hQNZa1YkHcAQ2lQJKKud5xQc3m254i4R3jKpgfs3uwjzdJgkhUwhfTLgXfqZPFHIEfu9i3Z109kIZEm7h1ozuFj1Sm6ZQeaXnWXVHq91yhjDuHoo3t1kzc1R1wp5ZA74am+GgDpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMcDX8oV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMcDX8oV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA321F000E9;
	Thu, 13 Aug 2026 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786660357;
	bh=ZZL85vNCz73hrdwFtE9+OKyg69zlsZ1sUhh3idU4RxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lMcDX8oVP6vVzriH45sob0ctHSRx0W8dj4d++Q0if9zB0c+iIJr1m4Ee81gVEikO3
	 7YGKagRon09I7iikKUzk2lOnS5Y4Rbleip9NDo4TdsWqSpddZ9cwSb727HlDB2NcfM
	 s/IawEAJlTPDm3o5gQsSAVS07Z1M7l8nFGFI30NH1Tviu1FyfczH/CVru07wnn3xy0
	 1AAd9kjAvzz8O/MNkj19yB6TR+1X4I6AD2yxUuzNW6IEn+z7JffG29TJ5mNaJGoCbo
	 hxowyjeQ4nuRPyIdQZJn6mNYTfvmkRBwLYba+FWSCNgIQPF0LvJn5MxVf7KolzBHuj
	 vz8WU4GKQQe1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 06/13] kexec_file: Chain the stages into a pipeline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pingfan Liu" <piliu@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260322014402.8815-7-piliu@redhat.com>
References: <20260322014402.8815-7-piliu@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:32:33 +0000
Message-Id: <20260813223237.BEA321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Aliasing ctx->kernel and ctx->next_parsing_buf in KEXEC_BPF_CMD_DE=
COMPRESS leads to a Use-After-Free.
- [Medium] Memory leak of newly allocated buffer 'pn' in KEXEC_BPF_CMD_COPY=
 when the pipeline array is full.

Pre-existing issues:
- [Critical] The BPF container decomposition stage completely bypasses KEXE=
C signature verification.
- [Critical] The bpf_buffer_parser kfunc lacks the required __sz suffix on =
its size argument, defeating the BPF verifier.
- [High] Memory leak of parsing buffers due to a double-negation logic erro=
r (!!context->parsing_buf[i]).
- [High] Severe memory leak of kexec_context dynamically allocated componen=
ts on error and success paths.
- [High] vfree() is improperly used on memory allocated by kernel_read_file=
_from_fd().
--

--- Patch [6]: [PATCHv7 06/13] kexec_file: Chain the stages into a pipeline=
 ---
commit 8070ede2f761980c4a2de11a2d72fb8a5309bc74
Author: Pingfan Liu <piliu@redhat.com>

kexec_file: Chain the stages into a pipeline

This commit enables kexec stages to be chained into a pipeline. It promotes
intermediate outputs from next_parsing_buf to parsing_buf for the subsequent
BPF parsing stages. It also allows multiple layers with distinct formats to=
 be
parsed sequentially.

> diff --git a/kernel/kexec_bpf_loader.c b/kernel/kexec_bpf_loader.c
> index af16f7b685d9a..7f7884411e2c7 100644
> --- a/kernel/kexec_bpf_loader.c
> +++ b/kernel/kexec_bpf_loader.c
[ ... ]
> @@ -301,6 +305,23 @@ static int kexec_buff_parser(struct bpf_parser_conte=
xt *parser)
>  				vfree(ctx->kernel);
>  				ctx->kernel =3D decompressed_buf;
>  				ctx->kernel_sz =3D decompressed_sz;
> +				if (fill_pipeline) {
> +					int i;
> +
> +					for (i =3D 0; i < MAX_PARSING_BUF_NUM; i++) {
> +						if (ctx->next_parsing_buf[i])
> +							continue;
> +						ctx->next_parsing_buf[i] =3D decompressed_buf;
> +						ctx->next_parsing_buf_sz[i] =3D decompressed_sz;
> +						break;
> +					}

[Severity: High]
Does this aliasing of decompressed_buf create a use-after-free risk?

If a nested BPF program parses a sub-kernel and issues another
KEXEC_BPF_SUBCMD_KERNEL command, kexec_buff_parser() will unconditionally c=
all
vfree(ctx->kernel):

kexec_buff_parser()
   case KEXEC_BPF_SUBCMD_KERNEL:
      vfree(ctx->kernel);

Since ctx->kernel and ctx->next_parsing_buf[i] point to the exact same buff=
er,
wouldn't this free the memory that the nested parser is actively reading fr=
om?

> +					/* No enough parsing slot */
> +					if (i =3D=3D MAX_PARSING_BUF_NUM) {
> +						ctx->kernel =3D NULL;
> +						vfree(decompressed_buf);
> +						return -ENOMEM;
> +					}
> +				}
>  				break;
[ ... ]
> @@ -313,6 +334,22 @@ static int kexec_buff_parser(struct bpf_parser_conte=
xt *parser)
>  		if (!p)
>  			return -ENOMEM;
>  		memcpy(p, buf, cmd->payload_len);
> +		if (fill_pipeline) {
> +			pn =3D __vmalloc(cmd->payload_len, GFP_KERNEL | __GFP_ACCOUNT);
> +			if (!pn) {
> +				vfree(p);
> +				return -ENOMEM;
> +			}
> +			memcpy(pn, buf, cmd->payload_len);
> +			for (int i =3D 0; i < MAX_PARSING_BUF_NUM; i++) {
> +				if (!ctx->next_parsing_buf[i]) {
> +					ctx->next_parsing_buf[i] =3D pn;
> +					ctx->next_parsing_buf_sz[i] =3D cmd->payload_len;
> +					break;
> +				}
> +			}
> +		}

[Severity: Medium]
If the pipeline array is fully exhausted and ctx->next_parsing_buf has no
empty slots, the loop will complete without storing pn. Is there a missing
check after the loop to free pn when it cannot be stored?

[ ... ]
> @@ -637,6 +674,14 @@ static int process_bpf_parsers_container(const char =
*elf_buf, size_t elf_sz,
>  		/* Free the old parsing context, and reload the new */
>  		for (int i =3D 0; i < MAX_PARSING_BUF_NUM; i++) {
>  			if (!!context->parsing_buf[i])
>  				break;
>  			vfree(context->parsing_buf[i]);

[Severity: High]
This is a pre-existing issue, but does this double negation logic incorrect=
ly
skip cleanup?

Because !!context->parsing_buf[i] evaluates to true for any non-NULL
pointer, the loop will immediately break instead of freeing valid buffers.

[Severity: High]
This is a pre-existing issue, but is it safe to use vfree() here?

Since these buffers are originally populated by kernel_read_file_from_fd()
which uses kvmalloc(), shouldn't kvfree() be used to avoid panics on
kmalloc'd memory?

>  			context->parsing_buf[i] =3D NULL;
>  			context->parsing_buf_sz[i] =3D 0;
>  		}
> +		for (int i =3D 0; i < MAX_PARSING_BUF_NUM; i++) {
> +			if (!context->next_parsing_buf[i])
> +				break;
> +			context->parsing_buf[i] =3D context->next_parsing_buf[i];


While reviewing this patch, I noticed a few pre-existing issues in other
related areas:

kernel/kexec_bpf_loader.c:decompose_kexec_image() {
...
		ret =3D process_bpf_parsers_container(parser_start, parser_sz, &ctx, 0);
		if (!ret) {
...
			vfree(ctx.cmdline);
		}
		return ret;
}

[Severity: High]
This is a pre-existing issue, but does this function leak memory on the err=
or
path?

If process_bpf_parsers_container() returns an error, the function exits
directly and returns ret without freeing ctx.kernel, ctx.initrd, ctx.cmdlin=
e,
or the array of buffers in ctx.parsing_buf allocated by
kernel_read_file_from_fd().

Also, on the success path (!ret), the ctx.parsing_buf array appears to be
permanently leaked as well.


kernel/kexec_file.c:kimage_file_prepare_segments() {
...
	if (IS_ENABLED(CONFIG_KEXEC_BPF)) {
		/* Fill up image's kernel_buf, initrd_buf, cmdline_buf */
		ret =3D decompose_kexec_image(image, initrd_fd);
		switch (ret) {
		case 0:
			envelop =3D true;
...
#ifdef CONFIG_KEXEC_SIG
	if (!envelop) {
		ret =3D kimage_validate_signature(image);
		if (ret)
			goto out;
	}
#endif
...
}

[Severity: Critical]
This is a pre-existing issue, but doesn't skipping signature validation when
envelop is true create a security regression?

If decompose_kexec_image() successfully extracts the kernel/initrd from a
container via unverified BPF programs, could an attacker load an unsigned,
untrusted kernel simply by wrapping it in an ELF container, completely
defeating kernel signature enforcement and Lockdown?


kernel/bpf/bpf_buffer_parser.c:bpf_buffer_parser() {
...
__bpf_kfunc int bpf_buffer_parser(char *buf, int buf_sz,
		struct bpf_parser_context *context)
{
...
}

[Severity: Critical]
This is a pre-existing issue, but does the size parameter need the __sz suf=
fix
to be properly verified?

Because the parameter is named buf_sz instead of buf__sz, the BPF verifier
treats it as a standard scalar and won't enforce bounds checking between the
pointer and the size. Could an unprivileged BPF program supply a small valid
pointer and an arbitrarily large buf_sz to cause an out-of-bounds read?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260322014402.8815=
-1-piliu@redhat.com?part=3D6
