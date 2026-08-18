Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925953C8700
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028980; cv=none; b=mYC7MsskeD3zpLyXnchpQPdPxVJs1T8BwW0Wuiik6lVJqG4Dbjx4vv4KpAmnmEet9h5Ap4ZpjhEe4W2RsMpXop4/GOvEZQCKeI7hLlmvbO1QHmsbjnpFRD2zTv2xUEZRhVkCogFND+4vTnhKCxT3kolXxuzXV8uXi5qXrBkfW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028980; c=relaxed/simple;
	bh=EhH3QnaR1BcAObn/lD+ULyuU0o1N0ZF0VVwMg6/p2dc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZN30EER8n5JwQrfNqsvf13A2rIg8BU1pYRkaPM2unhyX0x2T01denrOE9GtLIhomLP89E21d6f9dBn/EFl/KcQCCmsjrsgf4cpBPNhYwiBL1LbfnTCxvPpwhLYYxPAhTanioFEICauRJa2bBERUoWgzBK/PhcA3U9Yf3P50Z/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbTbDvo8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbTbDvo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3174A1F000E9;
	Tue, 18 Aug 2026 04:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787028979;
	bh=HenJKxZCMV5e0GthMeh3y68970fQvqNNkisQqoh6Yrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PbTbDvo8ezjuDsQD+rprbfpynPZ6AfrMpIYc7QRhY8V7SIGNB2pkw0eiy6iRH2CXx
	 7P67kCYPbAWOEkGiO/OQZXin39w4WCKhwgFMxHqy26h/UciVG4SSlgQoBz4cf3LeLr
	 9d1ZGz39M1Mm2jt/oLTcgi2TdvAvp0RIv+3Ceee4uTSMIhZ1/bvwO8i2PCTnpA0n6r
	 ZUnQoMdc7JT8bwzPCCvMjAUB5/4zBTKlik5+hWW5ltqc1ogIMrGNxfDk8HZsEA8so2
	 9jO3sdJZAVtGJw+iriQYeESXR2SdjkuQu1whH4x2ArkIogDYPdwOql7zNLlBHwjDQS
	 FUtwmlrJNjyfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 5/8] powerpc64/bpf: fix percpu private stack leak on
 JIT failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Saket Kumar Bhaskar" <skb99@linux.ibm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <97a39fe69332e2db95f2e653445c5b8c9adc205b.1787027080.git.skb99@linux.ibm.com>
References: <cover.1787027080.git.skb99@linux.ibm.com>
 <97a39fe69332e2db95f2e653445c5b8c9adc205b.1787027080.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 04:56:18 +0000
Message-Id: <20260818045619.3174A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing error handling flaw in `bpf_jit_free()` leads to a do=
uble-free and use-after-free of the BPF binary pack if `bpf_jit_binary_pack=
_finalize()` fails.
- [High] The exact same per-CPU private stack leak fixed in this patch for =
PowerPC also exists in the ARM64 BPF JIT compiler.
--

--- Patch [5]: [PATCH v12 5/8] powerpc64/bpf: fix percpu private stack leak=
 on JIT failure ---
commit 7f3490460ab3b86fd0696381ed6fb1a49e89ac48
Author: Abhishek Dubey <adubey@linux.ibm.com>

powerpc64/bpf: fix percpu private stack leak on JIT failure

The existing conditional statement in bpf_int_jit_compile() frees the
percpu private stack at out_addrs only when the image buffer was never
allocated.

[ ... ]

Closes: https://lore.kernel.org/bpf/20260616135426.A06B71F000E9@smtp.kernel=
.org

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 38acef44c0979..b45fa80271068 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -404,7 +404,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verif=
ier_env *env, struct bpf_pr
>  				(void *)fimage + FUNCTION_DESCR_SIZE);
> =20
>  out_addrs:
> -		if (!image && priv_stack_ptr) {
> +		if (!fp->jited && priv_stack_ptr) {

[Severity: High]
This isn't a bug introduced by this patch, but does the arm64 BPF JIT have =
the
exact same leak this patch fixes?

Looking at bpf_int_jit_compile() in arch/arm64/net/bpf_jit_comp.c:

	out_off:
		if (!ro_header && priv_stack_ptr) {
			free_percpu(priv_stack_ptr);
			prog->aux->priv_stack_ptr =3D NULL;
		}

If JIT compilation fails late (e.g., validate_ctx fails), it jumps to the
out_free_hdr block which frees the header but doesn't set ro_header to NULL.
Execution then falls through to out_off. Since ro_header is non-NULL, it sk=
ips
freeing the stack. bpf_jit_free() also skips it because prog->jited is 0.

Should the arm64 code also be updated to use !prog->jited?


[Severity: High]
This is a pre-existing issue, but can ignoring the return value of
bpf_jit_binary_pack_finalize() in bpf_jit_free() cause a double-free?

In arch/powerpc/net/bpf_jit_comp.c:bpf_jit_free():

	if (jit_data) {
		bpf_jit_binary_pack_finalize(jit_data->fhdr, jit_data->hdr);
		// ...
	}
	hdr =3D bpf_jit_binary_pack_hdr(fp);
	bpf_jit_binary_pack_free(hdr, NULL);

If bpf_jit_binary_pack_finalize() fails, it frees ro_header and returns an
error:

kernel/bpf/core.c:bpf_jit_binary_pack_finalize() {
	...
	if (IS_ERR(ptr)) {
		bpf_prog_pack_free(ro_header, ro_header->size);
		return PTR_ERR(ptr);
	}
	...
}

Because bpf_jit_free() ignores this return value, it immediately re-fetches
the freed header and calls bpf_jit_binary_pack_free() again.

Does this lead to a use-after-free read of the garbage size and a double fr=
ee
of the pack?

>  			fp->aux->priv_stack_ptr =3D NULL;
>  			free_percpu(priv_stack_ptr);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787027080.gi=
t.skb99@linux.ibm.com?part=3D5
