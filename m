Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A65203710
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330807; cv=none; b=HFcU663oLAtF3Pug9csX7L2VNFPyIFd6uFqR3uhMEQMQpzuc9dbH/JgJqGBXFD4MwSaP9aHA4PhL81JJqHIDwP/MwsxzXBp6aOI3AlpgZSBCcHzw3FGFAYCIT9l7Ubpzjn1ZZQBAWzgwZnPGEjMbWcroe5p1eWxshJ0mkVAszpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330807; c=relaxed/simple;
	bh=qQsr+rwNzVt6OibBzMygkRa5tqLdQwfhrk5au0ve+BQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bj2czFfaJf318Psm3fDtX70hrgenpVYrM3Y34oNuc66k1sYCpD6tYdRw/mvNkaEx9iOyqXW0kh+rkyG34/W+EEPq4xvkSLoHxncz3iS0hiCMRLWtkrbk4jlTPickBjwh1El61UKHVgKJPr4DZrHs/c036ytPo39SxtWsoJMHil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtdc2aTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtdc2aTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266061F00893;
	Mon,  1 Jun 2026 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780330806;
	bh=THPlblx7nsP42lVNX39onfc9h/Ct96a0EyjUkIk66T0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dtdc2aTNpoM1kWBpfsb7feB/z1/Ek1ui4BVJcI50KVwG+gBTAgfSR0NDAUdDmvG9D
	 ZijXnfXeUCwYncIOdkeRBOMUqwHMdD3HAE8NEqaZA8fRIEHroDtYzX2HESctcTT+iD
	 I25P+4hatrm5K/LsfOPD1c6XqknHcPqJJCn+HmvGmdllzBsLPp2titwxJnKOKovn72
	 pTS3GE6LHtZYhMv3Iqc1iBhozdU+Pnu2ajC7QGYFg7spBnsrGgjTdPy3vEv6OMjOTt
	 BJTOYur19mL4/qVmHvJpKzjb5AF3WCowOuMLyUmDXpGZR6Nt61DvZX6S1wxNp97hvX
	 iFhDiICN6/3vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 6/7] selftests/bpf: Adjust verifier_map_ptr
 for the map's excl field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601150248.394863-7-daniel@iogearbox.net>
References: <20260601150248.394863-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 16:20:05 +0000
Message-Id: <20260601162006.266061F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Incomplete and degrading adjustment of verifier_map_ptr tests af=
ter struct bpf_map layout change.
--

commit 5b67581177de15e6a8e536ecacc43112b6c44726
Author: KP Singh <kpsingh@kernel.org>

selftests/bpf: Adjust verifier_map_ptr for the map's excl field

Adding the u32 excl field at offset 32 of struct bpf_map right after the
sha[SHA256_DIGEST_SIZE] hash shifts the ops pointer from offset 32 to 40.
This commit attempts to fix up the test case by updating the expected error
messages.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools=
/testing/selftests/bpf/progs/verifier_map_ptr.c
> index e2767d27d8aaf..d8e822d1a8bab 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> @@ -70,13 +70,15 @@ __naked void bpf_map_ptr_write_rejected(void)
>  	: __clobber_all);
>  }
> =20
> -/* The first element of struct bpf_map is a SHA256 hash of 32 bytes, acc=
essing
> - * into this array is valid. The opts field is now at offset 33.
> +/*
> + * struct bpf_map starts with the SHA256 hash sha[32] at offset 0 (a rea=
dable
> + * byte array), followed by the u32 excl field at offset 32. Reading a u=
32 at
> + * offset 33 runs past the end of excl and is rejected.
>   */
>  SEC("socket")
>  __description("bpf_map_ptr: read non-existent field rejected")
>  __failure
> -__msg("cannot access ptr member ops with moff 32 in struct bpf_map with =
off 33 size 4")
> +__msg("access beyond the end of member excl (mend:36) in struct bpf_map =
with off 33 size 4")
>  __failure_unpriv
>  __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
>  __flag(BPF_F_ANY_ALIGNMENT)

[Severity: Medium]
Does this adjustment reduce the test suite's coverage?

By only changing the expected error message here,
read_non_existent_field_rejected() now tests for a scalar out-of-bounds
access rather than testing the verifier's rejection of partial pointer
accesses.

Should the offset inside read_non_existent_field_rejected() be updated to 41
instead, to continue testing partial access to the ops pointer (which shift=
ed
to offset 40)?

tools/testing/selftests/bpf/progs/verifier_map_ptr.c:read_non_existent_fiel=
d_rejected() {
    ...
    r6 =3D *(u32*)(r1 + 33);
    ...
}

Additionally, ptr_read_ops_field_accepted() explicitly claims to read the
ops field, but still reads from the sha array at offset 0:

tools/testing/selftests/bpf/progs/verifier_map_ptr.c:ptr_read_ops_field_acc=
epted() {
    ...
    r6 =3D *(u64*)(r1 + 0);
    ...
}

Should this test also be updated to read from offset 40 to properly verify
valid access to the ops pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601150248.3948=
63-1-daniel@iogearbox.net?part=3D6
