Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE09D3CAA57
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792302786; cv=none; b=VEkl5OFUIYyYdVeXz0TL37IPpG0zKAIiF0rZqKuHEk0RfvJdtjMSH7EAyrLKchMq9kHf34nwvgFZREnHhtFMSEXkVENGh2zJCJxNunkAtuIZ/ZOFOPwYuHcJGyTLmv/MXgjajgo6y0cHWqyun6xLGrDbu81rdKza/ktZ7HquP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792302786; c=relaxed/simple;
	bh=CQdlXoJ9Tg9w5cMqC1YpGjjmIBALpRgabWcn3wakLIU=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=qg5j0/cZZDxBIxRKKUiMYjlHbOTW3dD/IVp4A2Ph7rxVhNx7pcRQFavxsS/c+Kxa+aStnVIjnYf89FUaNaYO1jmBjzWMCrH53O9DpmEsvuxtCRFjxxznBtFUI9ZMUCPMExJtrzqgltO5vZe81h9t0pE8A03TXboHL+hF3vMbG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtm4CR3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtm4CR3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23CED1F000C4;
	Sun, 18 Oct 2026 05:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792302784;
	bh=QjyCDUDYaMTdkNWuuWtXTrGuU8CHosSflQvTUfExzwo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Vtm4CR3AYrA3qi2t5tgGhheHaNL1TRd810u9PBBLwIqbzG2qMBoLn9Wg+nFGcVwTL
	 NxNS+fEcErCEWhIYMWgrXB+fgw63RvU0zsBFMcti77YyHdAS0BKvQLe/SiF7a1/Cxy
	 Q++2WxGFKB5V1VdM+QHztNpnyO938RAmNL+luFamr5Ly/P2Fh1dKGJOL0fUnt8b76M
	 E0X4ROCxXXFFlTYuyu2vySSYzOZFQvNtnARBFFog65zYZj0go5C9SC8u1Sgo3XpvDB
	 PvHct5Tw4IZeVyTFeaOo0CgqdeI8LjxGAg1dF7UP1Nui+LfymKfgfMaCy6yoppHtjX
	 0xjaADDfuGUxQ==
Message-ID: <sashiko-outbox-175960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test rejection of packet
 dynptr slices in mutating helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ren Wei" <weir@nebusec.ai>, bpf@vger.kernel.org
In-Reply-To: <b5207ca47760c74788f0da5643494f8594bdfce7.1792222148.git.rakukuip@gmail.com>
References: <cover.1792222148.git.rakukuip@gmail.com>
 <b5207ca47760c74788f0da5643494f8594bdfce7.1792222148.git.rakukuip@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 05:53:03 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: wrong section type in slice_pkt_to_lwt_push_encap=
()
--

commit 86f6940d47fbdfababc47269242b89301ecf8dfb
Author: Luxiao Xu <rakukuip@gmail.com>

selftests/bpf: Test rejection of packet dynptr slices in mutating helpers

This commit adds negative verifier selftests in dynptr_fail.c to verify
that passing skb-backed dynptr slices or packet-backed dynptrs to mutating
helpers and global subprograms is rejected.

> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/test=
ing/selftests/bpf/progs/dynptr_fail.c
> index c2247b38c8498..11699d87ad2b1 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> @@ -2279,3 +2279,93 @@ int dynptr_overwrite_ref_clone_slice_valid(void *c=
tx)
> =20
>  	return 0;
>  }
> +
> +/* Passing a packet dynptr slice to helper changing packet data should f=
ail */
> +SEC("?lwt_out")
> +__failure __msg("cannot pass packet pointer")
> +int slice_pkt_to_lwt_push_encap(struct __sk_buff *skb)
> +{
> +	struct bpf_dynptr ptr;
> +	void *hdr;
> +
> +	bpf_dynptr_from_skb(skb, 0, &ptr);
> +	hdr =3D bpf_dynptr_slice(&ptr, 0, NULL, 20);
> +	if (!hdr)
> +		return 1;
> +
> +	bpf_lwt_push_encap(skb, 0, hdr, 20);
> +	return 0;
> +}

[Severity: Medium]
Should slice_pkt_to_lwt_push_encap() use SEC("?lwt_in") or SEC("?lwt_xmit")
instead of SEC("?lwt_out")?

In net/core/filter.c, lwt_out_func_proto() does not allow
BPF_FUNC_lwt_push_encap, which is only exposed in lwt_in_func_proto() and
lwt_xmit_func_proto():

net/core/filter.c:lwt_in_func_proto() {
	switch (func_id) {
	case BPF_FUNC_lwt_push_encap:
		return &bpf_lwt_in_push_encap_proto;
	default:
		return lwt_out_func_proto(func_id, prog);
	}
}

Because of this, check_helper_call() -> bpf_get_helper_proto() rejects the
program with "program of this type cannot use helper bpf_lwt_push_encap#73"
before reaching check_func_args(), so the expected "cannot pass packet
pointer" message is never emitted and the test fails.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792222148.gi=
t.rakukuip@gmail.com?part=3D2
