Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4D2D7DF1
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720296; cv=none; b=CLltAL0abJ/4NabdXTq+1CEphue0VJtr41g9ozMrxhzaBjsS4Y/28SW4FMA2F5DUolnoZAKi/O51vacarbEWXwqxnlIkiPqTyP14lzzbHPUDDqummrUTA7gG7LqYCkSJS4iEXZRJrDvcLt5pQmva15qzX1tFUUvApup7b6JgioQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720296; c=relaxed/simple;
	bh=+JD5tjbaN151kVW+Pygao5kQ39wLigisXfBieQEvSKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SHlLKmn7zHFXuhPLf6+mTA2PAdiXqF8jVVOFVeEgvUAlzvki0dfwDTGG7hVRb4/E30jEnyOrL5SsxR/9h31ctWgkfkC0xK/X0uAPqlt7Zzj4Xzbrdk+kJi25hBDrC7t3nvAKm0f7VAL6d3sL53sNwJQmRcE92EcE+9doL0T120g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcUy6oXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcUy6oXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F971F000E9;
	Wed, 22 Jul 2026 11:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784720294;
	bh=vKN8+R37G9Q0IJxBKH/0wLWBOFfs+WHCHGKHgWepUS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JcUy6oXp5TTzwlLvegRpxZDX3/EKIGanpHjSv0aTtCQ0yX1uDqL22sixtzUne4P+M
	 xNibO/3KqZ4t1Qs0Z1d4MWFo9v1itxLyhffj1PfD6tZ88IDk/5ypiXfDdnnlRnIHNS
	 HSxKjRpp4kE6pUqmuwMb38ghD7M8lSaRf+pIhFScjz8XYtlTXDSbXKY/EH4KgKuTAZ
	 MsS/rkqQ1A7UimeYBLHHsO8X2KgQTIZmtr1C9sAyCR+mGpl5kwWwOCbvuRN2T6lwFq
	 Mp4G7zGVdmfu1g3FJLpkS1VS88WW8LaCfopJWxi3XEfkYf9pgdHPC4dfaMbgYrq4ZA
	 tA7S9nwjYxnsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/4] riscv, bpf: Adjust bpf_func to account for
 CFI offset in bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722112754.1615201-4-pulehui@huaweicloud.com>
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-4-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 11:38:13 +0000
Message-Id: <20260722113814.40F971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Error path in `bpf_jit_free()` ignores the return value of `bpf_ji=
t_binary_pack_finalize()`, leading to a use-after-free and double-free of t=
he `ro_header`.
- [High] The BPF JIT module memory charge is permanently leaked when `bpf_j=
it_binary_pack_finalize()` fails.
--

--- Patch [3]: [PATCH bpf-next 3/4] riscv, bpf: Adjust bpf_func to account =
for CFI offset in bpf_jit_free ---
commit 2c7946882741f9c426f80073ff738910e58599f5
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free

Adjusts the BPF program entry point in bpf_jit_free() by subtracting the CFI
offset. This correctly restores the original JITed allocation address before
freeing it.

> diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
> index cbfcd287ea166..059db1adeaf8d 100644
> --- a/arch/riscv/net/bpf_jit_core.c
> +++ b/arch/riscv/net/bpf_jit_core.c
> @@ -237,6 +237,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>  			kvfree(jit_data->ctx.offset);
>  			kfree(jit_data);
>  		}
> +		prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offset();
>  		hdr =3D bpf_jit_binary_pack_hdr(prog);
>  		bpf_jit_binary_pack_free(hdr, NULL);

[Severity: High]
This is a pre-existing issue, but does bpf_jit_free() ignore the return val=
ue
of bpf_jit_binary_pack_finalize() and risk a use-after-free and double-free?

When bpf_jit_binary_pack_finalize() fails, it frees the ro_header internall=
y:

kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
    ...
	if (IS_ERR(ptr)) {
		bpf_prog_pack_free(ro_header, ro_header->size);
		return PTR_ERR(ptr);
	}
    ...
}

But here in bpf_jit_free(), the error is ignored, and bpf_jit_binary_pack_f=
ree()
is called with the same header:

arch/riscv/net/bpf_jit_core.c:bpf_jit_free() {
    ...
		hdr =3D bpf_jit_binary_pack_hdr(prog);
		bpf_jit_binary_pack_free(hdr, NULL);
    ...
}

kernel/bpf/core.c:bpf_jit_binary_pack_free() {
    ...
	u32 size =3D ro_header->size;

	bpf_prog_pack_free(ro_header, size);
    ...
}

If finalization fails, could this lead to a use-after-free read of
ro_header->size, followed by a double-free of the ro_header?

[Severity: High]
This is also a pre-existing issue, but does the error path of
bpf_jit_binary_pack_finalize() permanently leak the BPF JIT module memory
charge?

When bpf_jit_binary_pack_finalize() fails and frees ro_header, it does not
uncharge the memory:

kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
    ...
	if (IS_ERR(ptr)) {
		bpf_prog_pack_free(ro_header, ro_header->size);
		return PTR_ERR(ptr);
	}
    ...
}

In other places like bpf_int_jit_compile(), a finalization failure results =
in
the pointers being set to NULL and bypassing bpf_jit_binary_pack_free(), wh=
ich
would normally uncharge the memory:

arch/riscv/net/bpf_jit_core.c:bpf_int_jit_compile() {
    ...
		if (WARN_ON(bpf_jit_binary_pack_finalize(...))) {
			/* ro_header has been freed */
			jit_data->ro_header =3D NULL;
			jit_data->header =3D NULL;
			goto out_free_hdr;
		}
    ...
}

Could repeated failures exhaust the JIT memory limit, resulting in a local =
DoS
by preventing further BPF program loading?

>  		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722112754.1615=
201-1-pulehui@huaweicloud.com?part=3D3
