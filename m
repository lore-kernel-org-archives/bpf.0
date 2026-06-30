Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1633E7166
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810233; cv=none; b=CXKstkX9Tm6fIEGvkoPGklYwHIxgDGTf1JL/C9ybpF4TzT09Au8wcmZMuYDaTyKfWzj39LtwL0c+BRttxfQKz1N0XQt9SdELKRvdPE1tYn2kkKxmRZqmXJz6j9GAuDVziyTXDClU17tuoVH7NtV8IoP35RvXu+R9cnmHDe62py4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810233; c=relaxed/simple;
	bh=WYDwPbm7sPWdheOsHts4fMu7f3LE7RSVxKiW92nABAI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IbTtpThD10/wGMtBIQE6WCkK8Tdi98YNKYZNWZpJoVS0mXG15jz2cFIOxnY9NH/nhAV4gABPhxL/5hYkeRRrNWikr/nCJIRPpdv0ybUu/COny4b0jOCoJdEsBNB2EsJfCJsMhUymAjInVmUR/4fAGWgp5+1hf4YyczOaCaeaW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE2egT4T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE2egT4T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0940F1F00A3A;
	Tue, 30 Jun 2026 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782810220;
	bh=kETiyDrmOQ+j6nSAxxC/boLoToJjX92jub65d+iCn1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BE2egT4TwkBYcLnsWhjxfeGOhPo3Q3X521jruUKIbjsF1ZSQXZ+RuJ6o42e0jvcJZ
	 Rr3Ubw9sCpn1+UXGulOWIeD0oM4i8tIc6fbE9jj/yPjYf+WQgBDSZvje+9fg+aBlgo
	 QpiNviAKW/9S2B/UZUETHhjtj7hhRhnD3t/CG16hToNHvDhtBP00+AT/CG6SwRFvIB
	 SfdV27+Hyp/iHB3Ey1+SKu/n0oFahljevBXKZxwSfHgg9pkAZzi/XhaMexeQGl+2q/
	 XglJZWU9eyyOYG9UqcdV8GUoU0SOBoZCtjSlCUiZ8YgPuiOGaAl74rKsXiQ3Q4N+Uh
	 K8svtnUVbnNhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Reject MEM_ALLOC BTF accesses past
 object bounds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <4b8c8a81102ba4b595011434c881194f264ddc59.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
 <4b8c8a81102ba4b595011434c881194f264ddc59.1782807039.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:03:39 +0000
Message-Id: <20260630090340.0940F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for out-of-bounds flex-array access on locally allo=
cated objects. An attacker can bypass the new `!type_is_alloc(reg->type)` c=
heck by stripping the `MEM_ALLOC` flag from the pointer, re-enabling the fl=
ex-array relaxation and allowing out-of-bounds kernel memory reads.
--

commit 58fdae86cafcb299054bb852079f413faa582d91
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Reject MEM_ALLOC BTF accesses past object bounds

This patch aims to prevent out-of-bounds accesses past object bounds when
accessing objects with a trailing flexible array. It restricts the
flexible-array bounds relaxation when the register points to a locally
allocated object.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 64572f85edc83..dff5c0d916412 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
[ ... ]
> @@ -7404,7 +7407,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
> =20
>  	t =3D btf_type_by_id(btf, id);
>  	do {
> -		err =3D btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag, field_=
name);
> +		err =3D btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag,
> +				      field_name, !type_is_alloc(reg->type));

[Severity: High]
This is a pre-existing issue, but does this check completely prevent the
out-of-bounds flex-array access?

If a BPF program allocates a local object via bpf_obj_new(), the memory is
allocated strictly based on t->size with no extra room for a flexible array.

However, if the MEM_ALLOC flag is later stripped from the pointer, the check
!type_is_alloc(reg->type) will evaluate to true. This flag stripping can ha=
ppen
if the pointer is cast using bpf_rdonly_cast(), or if it is stored as an
unreferenced kptr in a map and loaded outside an RCU critical section.

Could this allow a program to bypass this new fix, re-enable the flex-array
bounds relaxation in btf_struct_walk(), and perform an out-of-bounds read of
adjacent SLUB allocator objects using PROBE_MEM semantics?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782807039.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D1
