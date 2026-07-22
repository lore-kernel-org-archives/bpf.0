Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFE4C77A5
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720035; cv=none; b=Zyo1k4E/P5eZK1HRtoHp79mh6q1NoULU7PiDfhkYxFvaWsbwMQja8AH1DQkNV/124R8N0CwUTJaRiawmH/iXuTYN+Flzons+WZFzYGJBYm7e4KF8uVn36eb6Rpjl9NEqEVQfPRjEk2TtxUqSaw9isSPbkH/g9Us2UBDNEqFLs4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720035; c=relaxed/simple;
	bh=avxKGpNO70VU4QP3yGk4Zgbpkw+X1vCqRTxN6jiT52k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QGj+MpltC9LlnCqtuaA0EZ/NA4DQ0MQgOC8D5r760SNKM4x4WWIlsp/4+q8K5C4kd6+aqZeU2UQErZReadyKVY3Z8m2RfGfri/wh4kpE9TZJwodBpq/XvluooJLZoeDg5+DgipIpZOlGm/+S3SDKvd3WKZM0t5wrCgd6LF0aREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wy1yWTBf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wy1yWTBf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503391F00A3A;
	Wed, 22 Jul 2026 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784720034;
	bh=m7P0tVgAgitZL0quwRnenunkd88djMfD64q9zr5ZL4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wy1yWTBfcJmiDlLFavcELfLoZcFKjHOGo9BFHBTjL38aHwPB6vv6psiJOVNxD+WE+
	 2CWmTSo8H+bXK2c35DMydeJFy0EL7hbZNnub52MvMm2PRZtrRm0qKUc6r3oy6SozSt
	 2vS/LD/QS+uYIkmHuZJcHKPstTa247yWNMappQBVaozz/eVoGwkIAM4U0I4t9OF2Ll
	 bnyaQ4UWLC8Kf5dKSuhhH48D0UfCZk2RMNeIf8zGEsFtSK605ndGkV5ErXac5RfFtk
	 7hoge7xw69bYFAiv9ZwCpxUeTC9hF54/+OP/YOZj0uQWRIhxttqMGoOWHhvm0jPUe/
	 K9G5WRKUBk5Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/4] bpf: Fix double-free RO header in
 bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722112754.1615201-5-pulehui@huaweicloud.com>
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-5-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 11:33:53 +0000
Message-Id: <20260722113354.503391F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] When `bpf_jit_binary_pack_finalize` fails, `bpf_jit_binary_pac=
k_free` reads an uninitialized/garbage `size` from `ro_header->size`, leadi=
ng to a kernel panic in `vfree()` and module memory uncharge counter corrup=
tion.
--

--- Patch [4]: [PATCH bpf-next 4/4] bpf: Fix double-free RO header in bpf_j=
it_free ---
commit 4586888c771a3a31208f8ce31608697cc4147140
Author: Pu Lehui <pulehui@huawei.com>

bpf: Fix double-free RO header in bpf_jit_free

This commit modifies bpf_jit_binary_pack_finalize() to drop the implicit fr=
ee
of ro_header on failure. Architectures are updated to explicitly call
bpf_jit_binary_pack_free() in their error paths instead.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index de7515ea1beae..d017bb0397b88 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3988,7 +3988,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
>  			 * Both cases are serious bugs and justify WARN_ON.
>  			 */
>  			if (WARN_ON(bpf_jit_binary_pack_finalize(header, rw_header))) {
> -				/* header has been freed */
> +				bpf_jit_binary_pack_free(header, NULL);
>  				header =3D NULL;
>  				goto out_image;
>  			}

[ ... ]

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 47fe047ad30b8..77195911a3b37 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1237,10 +1237,9 @@ int bpf_jit_binary_pack_finalize(struct bpf_binary=
_header *ro_header,
> =20
>  	kvfree(rw_header);
> =20
> -	if (IS_ERR(ptr)) {
> -		bpf_prog_pack_free(ro_header, ro_header->size);
> +	if (IS_ERR(ptr))
>  		return PTR_ERR(ptr);
> -	}
> +
>  	return 0;
>  }

[Severity: Critical]
This is a pre-existing issue, but does reading ro_header->size cause a panic
when bpf_arch_text_copy() fails?

If bpf_arch_text_copy() returns an error, the RO memory was not written, so
ro_header->size contains uninitialized garbage or illegal instructions. Bec=
ause
kvfree(rw_header) is called unconditionally just before this check, the only
header holding the correct allocation size is destroyed before the caller c=
an
properly free the resource.

When the architecture fallback explicitly calls bpf_jit_binary_pack_free()
(or previously when this function called bpf_prog_pack_free directly), it
reads the garbage size from ro_header->size:

kernel/bpf/core.c:bpf_jit_binary_pack_free() {
    u32 size =3D ro_header->size;=20
    bpf_prog_pack_free(ro_header, size);
    ...
    bpf_jit_uncharge_modmem(size);=20
}

Since this garbage size typically exceeds BPF_PROG_PACK_SIZE, the allocator
falls back to vfree(ro_header). As ro_header is a pointer to the interior of
a vmalloc'd pack, vfree() will trigger a kernel panic. Additionally,
bpf_jit_uncharge_modmem() drastically underflows the module memory tracking
counter.

Could the size be preserved or passed differently to avoid reading from the
uninitialized RO header during the error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722112754.1615=
201-1-pulehui@huaweicloud.com?part=3D4
