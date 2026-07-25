Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EEF3C2B8F
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975278; cv=none; b=k9Up2q3rUb6jv0mjCbDtLZoaWohHMPceBSK0cBOYDrxj4tiRrEosnOLEhb4YLti499wZLks9EKtwdOIX50pWErXBwetaB9rGiqT6ac4BEx/nr/iKyIhtz2+GBFbQEKnaJ1acOyZGFs0Us3rXy5++70/7fISQs0vQepTBjQcehn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975278; c=relaxed/simple;
	bh=V9tq2ODzBv2FGYwwotX3UCH9hZwRKS0OsOhdC0TOUac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BVi8BWzw+Gek2/uxyOZ6OGvQ9QFUojR+uYqfNUV7iYJ9Jf43FQXN3h9+YWhS+lIcD38DTLWFGVIlf4tkF7Z6DLs47IHhkZRhUQecIOWJOcmv4wHxp/i7+/wW/Y+PnqiHBBCy7g94OZkpEmxuZOVrVfpklwCR2NaLrNd0al/Av0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWcIoHKz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWcIoHKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3BD1F000E9;
	Sat, 25 Jul 2026 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784975273;
	bh=SGOuzc/IdOnk+IZMA2WkXOgHSBEaoy6u/ezd3BmsY9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FWcIoHKziyULW169xPW5tRGBT1Hly7TqMtVmQCLabNwwrwh2naZJ6XfXB7mr80Shd
	 qWmnML7dYsIKcmZOhGGRveEMua7ebTui4Qtvjg0l7WcmPOdDV1l7DWH7l59xKJd5XG
	 OJPY4wdaNRmw/gJqKi2GdIk3oSQ3NWXp+1uWXjLV1EF2XDLHyZj85V6XX8Alm2Yedh
	 0YVnHhWiePcNz+JR3w/9F60qTZFHSxiu20N7PUEynHAFz8yeH3KgDpJUfA1vmfMcWV
	 92i8rjIor42Lk+OLR9LEjUZhf7K5ITuk8YcWsZtwDuTWfQfiYqMFaz82CPB7fP/YJF
	 SzjP/GZ/fxN3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 6/7] riscv, bpf: Adjust bpf_func to account
 for CFI offset in bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725102020.2287770-7-pulehui@huaweicloud.com>
References: <20260725102020.2287770-1-pulehui@huaweicloud.com>
 <20260725102020.2287770-7-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 10:27:52 +0000
Message-Id: <20260725102752.DC3BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_jit_free() ignores the return value of bpf_jit_binary_pack=
_finalize(), leading to a double free and use-after-free of the ro_header i=
f finalization fails.
--

--- Patch [6]: [PATCH bpf-next v2 6/7] riscv, bpf: Adjust bpf_func to accou=
nt for CFI offset in bpf_jit_free ---
commit 3086c59fad7254d5809adea2a09ea130ccb95d10
Author: Pu Lehui <pulehui@huawei.com>

riscv, bpf: Adjust bpf_func to account for CFI offset in bpf_jit_free

This commit subtracts cfi_get_offset() from prog->bpf_func to correctly
restore the original JITed allocation address before freeing it. This preve=
nts
potential invalid memory frees when CFI is enabled.

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

[Severity: Critical]
This is a pre-existing issue, but does ignoring the return value of
bpf_jit_binary_pack_finalize() called just above this block lead to a double
free?

If bpf_jit_binary_pack_finalize() fails during text patching, it frees the
ro_header internally and returns an error.

Since that error is ignored in bpf_jit_free(), the execution unconditionally
continues down to:

    hdr =3D bpf_jit_binary_pack_hdr(prog);
    bpf_jit_binary_pack_free(hdr, NULL);

Can this lead to a use-after-free when bpf_jit_binary_pack_free() tries to
read the header size, followed by a double free of the memory chunk?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725102020.2287=
770-1-pulehui@huaweicloud.com?part=3D6
