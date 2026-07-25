Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385D377A9E
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994938; cv=none; b=RnLmCPNYURqv/3AcNEXCyjor378Yw2gEyGMCSuF45ioxtFQSYblJW+OLlRRc7HTNW9nF6+Q0RQCff+zWht/Q/s6qWzgrQjz3ahCqH5G4lNrD0QMaZOeFcnltkAvKCdchBEFG2MlJyXNXIQ52G6kaTBvxwBzC7uz7Lp4karDdQWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994938; c=relaxed/simple;
	bh=CHq+Hncur/vT5Myqc1NV7eSeLHxrqnHA6AO7eYyc7Io=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVcX5EnaiCiVGR8VexHGxkRkMBsB84BNHv9dcdgtclkcRVtr2i5tzubEx8XbwtVRyH98nMxAQjl6xuaU1BvE0DLCp6AgUl9sXksTmhchLf34d4vdrVXqg5tT1CK5Shs2sIwmEHFTSHRI48cRM/BqY5EN4iv2mm2cRWc7aI28ddc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AABxQBDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AABxQBDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0398E1F000E9;
	Sat, 25 Jul 2026 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784994935;
	bh=NNuUlbrlfXnDSVG4FKqjxvPT78m6AuM6J4vCrojkQKc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AABxQBDF3oeSkvYtbJ14a+95pUBMXQcXUByarBKhBX2Lqvd/kGzDbUJadyyZj4n8b
	 JyZ/WvnTB9qcBzk0w8j/wkWq8rfVwkQIQmHS8A9z98+YI1zuXq0k+A07ImqJB/KEta
	 nPbsyoUpSxA3RiVNr2wvq+BDeWQBZGVZo8xiirBb8SZhuumONyXL+aYUcHwcMJudBP
	 wUuG+WP3wYhrn7c54If60kgsJmS5C5/L0lMBnmWJBLj3UZEi7tesIxpATzp6VzVuzJ
	 sFKV+U4ECJSFKhk+Fk/UKwc10ClVcRhYzH7tYicZJTUiKm3j4mEIBp4NLcxkuSyd7g
	 78XoNH2+Mun2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 7/9] bpf, arm64: Fix private stack leak when
 JIT failed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260725154915.2488611-8-pulehui@huaweicloud.com>
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
 <20260725154915.2488611-8-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 15:55:34 +0000
Message-Id: <20260725155535.0398E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Memory leak of the BPF private stack in the PowerPC JIT compiler=
 upon JIT failure.
--

--- Patch [7]: [PATCH bpf-next v3 7/9] bpf, arm64: Fix private stack leak w=
hen JIT failed ---
commit 8de8b0f7fc232dba7540d3099301a4c55f3544c0
Author: Pu Lehui <pulehui@huawei.com>

bpf, arm64: Fix private stack leak when JIT failed

This patch fixes a memory leak in the ARM64 BPF JIT compiler. When JIT
compilation fails, the private stack percpu memory was being leaked because
the cleanup check evaluated to false after a pointer was left dangling. The
fix sets the pointer to NULL to ensure proper cleanup.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index f4e4d4578e38a..6e036acf80d8b 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2311,6 +2311,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_ver=
ifier_env *env, struct bpf_pr
>  		bpf_arch_text_copy(&ro_header->size, &header->size,
>  				   sizeof(header->size));
>  		bpf_jit_binary_pack_free(ro_header, header);
> +		ro_header =3D NULL;

[Severity: Medium]
This is a pre-existing issue, but while fixing this memory leak for arm64,
it appears that the PowerPC JIT compiler has the exact same problem.

In arch/powerpc/net/bpf_jit_comp.c:bpf_int_jit_compile():

		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
				       extra_pass)) {
			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
			bpf_jit_binary_pack_free(fhdr, hdr);
			goto out_err;
		}

When jumping to the error cleanup path, the JIT binary is freed but the ima=
ge
pointer remains non-NULL.

Then in the cleanup path:

out_addrs:
		if (!image && priv_stack_ptr) {
			fp->aux->priv_stack_ptr =3D NULL;
			free_percpu(priv_stack_ptr);
		}

Because the image pointer is still non-NULL, this check evaluates to false.
Can this also cause the private stack percpu memory to be leaked in the
PowerPC JIT? Should a similar fix be applied there?

>  	}
>  	goto out_off;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725154915.2488=
611-1-pulehui@huaweicloud.com?part=3D7
