Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70FA3E5A14
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720290; cv=none; b=lmbvKtJ9Oea7gl6OnntMovqw7TLioEVSWL6i0uzxTK7494R2Nq5KSATw2zmiurKBtR2I3VoLnhpUWk8CL9mgQTJXV0Dk1eQcCEVmgxON9E+LbLM/nl2GICQnWsIrp07K4uaD9A30P8ex1unF6K+8d+a1HaxxrQlG2/r57E/nIU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720290; c=relaxed/simple;
	bh=QQpelyvGGggJgEBATxWdleo8PQvr3CAL3DBzVyyTRJ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q3fuMt24aIdRNQvgLGP6f1ImrKFQmfIGaugSSI8JLjPD8JzBYkVfPQn4wNAhu2EdpZkbcnyHDVC8SPx+bapiJg9qENriGBSfpw7IxtkXZrz1Zi/OwTCU05Xs6nrkEbMxxlCNDdo7ovmAGPaM0JocObAyFkze5I02XIw/0AAqNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuXM8KTz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuXM8KTz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D6D1F000E9;
	Wed, 22 Jul 2026 11:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784720288;
	bh=7eWbbmXGR+H2SGH8J7hoMTFpWvnmSN2jU/JY0micMgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CuXM8KTzZqmRzioE8c3ZEGBVYf6J1Xl5Z50SEsOXXU/uUfRSl3tr8iZpbm8LY4y1g
	 04AcHaMrzAikjVRUOGYTUD8P5wUg3NDTk9EMzczKPt9FHBIoLzL75Mfck6EmZUl19f
	 NAMfo1ZwP/Sip8ZTwKkhV8pqmYj5Gn9Dir3vTNKsReQb6BVT33EteCYxgsqb88LuZ6
	 UCDWoQ2Z/sgfEI/Ff2eVuujGaDnUwBRcJsoFEmZdSgKWPgdYK15q2e5PGlyF30eVNG
	 631mKlbBqA4TvLUqab5xD1qgF7mRTzhcOEa+W4vixqVD/c/SOrnJ1aMW9DCzYRmMMw
	 Q9itYLfvEKv7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/4] bpf, arm64: Fix memory leak in
 bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722112754.1615201-2-pulehui@huaweicloud.com>
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 11:38:08 +0000
Message-Id: <20260722113808.94D6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of `jit_data->ctx.offset` in `bpf_jit_free()` for the =
LoongArch architecture.
--

--- Patch [1]: [PATCH bpf-next 1/4] bpf, arm64: Fix memory leak in bpf_jit_=
free ---
commit 34ee740bc2723be0c26671951b05fa73e1bfc918
Author: Pu Lehui <pulehui@huawei.com>

bpf, arm64: Fix memory leak in bpf_jit_free

This commit fixes a memory leak in the ARM64 BPF JIT compiler. When
bpf_jit_free() cleans up a subprogram after a later subprogram fails JIT
compilation, it now correctly frees the jit_data->ctx.offset array.

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 4cdc7dfb05ba9..f4e4d4578e38a 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -3237,6 +3237,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>  		 */
>  		if (jit_data) {
>  			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
> +			kvfree(jit_data->ctx.offset);

[Severity: High]
This isn't a bug introduced by this patch, but does the same memory leak
exist in the LoongArch BPF JIT compiler?

Looking at arch/loongarch/net/bpf_jit.c in bpf_jit_free():

		if (jit_data) {
			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
			kfree(jit_data);
		}

It appears jit_data->ctx.offset is not freed there before kfree(jit_data)
is called.

Could this lead to a similar resource leak if userspace loads a BPF program
with multiple subprograms that passes verification but fails JIT compilatio=
n?

>  			kfree(jit_data);
>  		}
>  		prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offset();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722112754.1615=
201-1-pulehui@huaweicloud.com?part=3D1
