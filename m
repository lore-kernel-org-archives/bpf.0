Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C184373BE6
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789166186; cv=none; b=tkujQ0+qwbbmcPsD35E0xghfsjQxeYSWrpE3c/QDX1YTvFGPkwXBjAmj+2If3LeGlX/JP2Xe4rXXGK6lnQqb8vQV/dpO3OLJmqugQVE8EGcyvD9cqGoJfrx41QrIkYfGHBYHzPVmVlpSYyKhI8CnionwGp8kqd8ebtZs4Qnv5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789166186; c=relaxed/simple;
	bh=Em8WyYE7Mwj2CXzT3dUQZ9ImjUemFfadIKZvDOF8LXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TdJya6EtcpwHuV+65cG3fU/cYbW32bktR5Gd4cIx0WSDMkowr3u+vozvnvro6wJgvTDQ3hRYOubdBUNKE270EY8Kt1kV0Z6xTFiAt1UMQbKl9ssmfVAMyFpLMgiZJHqc6yUqJ4bFDgSx8bAjJN13ctLNbPy5IKXgKe5mUh5qNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqxA6s+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqxA6s+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4321F000FF;
	Fri, 11 Sep 2026 22:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789166185;
	bh=+5OtKnRt5ja6rvcDuE/m+So1a5uhUCkOVZbCE3Qz7oI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kqxA6s+pPEyfZ0r1DZx4bR/A3ej9n0EIU85FE6jIO4yAR9jTSGP2AEA9ekYZtRHdb
	 k9PfYbXmkxo0L7/zSDeU2kUUjCnnuAo2Fx5eonU2jsBY1vQ6O+Rgjxb38iqFCf+FO4
	 1YiYt49L6IBW1q6HMtEWokBGm2Ore19NZhPgqq6MGVa8aj5HdQRcmsFqqyeuZHQ4jl
	 XbIskey4MljCZNckkzyDWKNWQWoianDONL/wuqFXcsrh8ZWo915QeK6ekIaCAONeJb
	 p0rHT7pJ+FZ/xEUNcHeqEnswQcbIVZydBwixCwZ/G060+j5psU0FeUHGFeg3Q1vqSD
	 CS/gneo0DOxYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 20/23] selftests/bpf: Test kfunc packet
 memory direct writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911220415.1396439-21-ameryhung@gmail.com>
References: <20260911220415.1396439-1-ameryhung@gmail.com>
 <20260911220415.1396439-21-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:36:24 +0000
Message-Id: <20260911223624.CB4321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Passing packet data to a kfunc expecting a struct causes unaligned=
 memory accesses, which panics the kernel on strict-alignment architectures.
- [Medium] The verifier unconditionally treats all `ARG_PTR_TO_MEM` kfunc a=
rguments as writable, causing unnecessary packet unsharing (cloning) for re=
ad-only kfuncs.
--

commit 4fcd6afbde5f30a90a43ed9c7692746d4f5d5555
Author: Amery Hung <ameryhung@gmail.com>

selftests/bpf: Test kfunc packet memory direct writes

A kfunc memory argument may be backed by packet data. Exercise this
with bpf_skb_ct_lookup(), which writes errors through its opts memory
argument. Verify that the verifier marks the program as directly
writing packet data, causing TC to emit its writable-skb prologue.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_acce=
ss.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c
> new file mode 100644
> index 0000000000000..88009566d92f9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c
[ ... ]
> +int kfunc_packet_write(struct __sk_buff *skb)
> +{
> +	void *data_end =3D (void *)(long)skb->data_end;
> +	void *data =3D (void *)(long)skb->data;
> +	struct bpf_sock_tuple tuple =3D {};
> +	struct nf_conn *nfct;
> +
> +	if (data + sizeof(struct bpf_ct_opts) > data_end)
> +		return 0;
> +
> +	/* An invalid tuple size makes bpf_skb_ct_lookup() write opts->error. */
> +	nfct =3D bpf_skb_ct_lookup(skb, &tuple, 1, data, sizeof(struct bpf_ct_o=
pts));

[Severity: High]
This is a pre-existing issue, but will this test cause a kernel panic on
strict-alignment architectures?

The verifier's get_kfunc_arg_type() assigns ARG_PTR_TO_MEM | MEM_FIXED_SIZE
for kfunc struct arguments but fails to set MEM_ALIGNED. This allows BPF
programs to pass unaligned pointers like skb->data to kfuncs expecting stru=
cts.

When this selftest intentionally passes data as the opts parameter, the kfu=
nc's
underlying C code in __bpf_nf_ct_lookup() dereferences the struct fields
directly (e.g., READ_ONCE(opts->netns_id)). On strict-alignment architectur=
es
like SPARC or older ARM, this unaligned 32-bit read causes a hardware excep=
tion
and panics the kernel. Executing this selftest acts as a concrete panic vec=
tor.

[Severity: Medium]
This is a pre-existing issue, but does the verifier unconditionally treat a=
ll
ARG_PTR_TO_MEM kfunc arguments as writable?

While this selftest verifies the writable-skb prologue, the verifier's
get_kfunc_arg_type() never sets MEM_RDONLY based on the BTF const modifier.
Additionally, check_func_arg() forcefully applies BPF_READ | BPF_WRITE via
the if (meta->btf) condition.

Consequently, any memory argument passed to a kfunc is treated as writable.
When packet data (PTR_TO_PACKET) is passed to a purely read-only kfunc, the
verifier sets env->seen_direct_write =3D true, unnecessarily triggering the
bpf_unclone_prologue(). This forces a packet reallocation and copy for every
packet at runtime, degrading performance.

> +	if (nfct)
> +		bpf_ct_release(nfct);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911220415.1396=
439-1-ameryhung@gmail.com?part=3D20
