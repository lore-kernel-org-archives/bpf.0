Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220C3B42DB
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453846; cv=none; b=RP1KTHCYEjyJRRQMsRMEd7zOgAZYTRPGYBcf1E/8gQVr4g2eF2YbgieSniRXa/AtioGvm7SQiOCtwrly0UK6/5f3jCakNSJaiP1TiD0U2i4abWLz+BYreHczaa2OO2O4FNXZ80K2kFGG7B+6Cuk/wkcpyegjKRWYynO6d6R0khA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453846; c=relaxed/simple;
	bh=Qs9cGq/noyZ9RjUV2/GFkA6VMK9rQ5wyF3mqCgfq5B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bZSXIxGk0maQWAupx5tadNxjSi4GCd+T7dgQydCP1mhIAxzW1oLwXovNZNsZMBFhKEMai7eRzw2/QBUHincDU2NKZPmn0YY3UL6ttCo0nwB3OJcb/4d1Y1s7JjIRnw+/ewoEvj7vjssE8IfBKIp49DDJSQDjt3BD1lMYRvoNpRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+f7JZh6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+f7JZh6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729391F000E9;
	Tue,  7 Jul 2026 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783453844;
	bh=OQPAR35p0L9sfC0hMSaBcLsYEgai5diAfh0tkQG0+IU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A+f7JZh6WYwXG//AfrejA0Fw1ft5vfacgAv2FVUkeypWHLeFKW0PmcPc+339ZfUE9
	 UYTnOmRwzvhxQdjIJnyuyDmQ0CMKow+RMqdELE7q5G0087V5orkzwaYPW4+j4Je2v/
	 QSfI93Mwgk5cx6cPdyjHJoit+pBg/Spabe46nFV1GDszfYvSy+8xrJecKTnZER0Mgg
	 mKh342RjICpksJIKdUNDfssgAnSRUecQCy4ADLkVWA6FW51G2XyiBxuaXLs26b2miu
	 +v2GUciv2Nn/1HNc2ZRZOR27ZeJDD0w8mgEoejwvjdZLJIa1tfahMPrCEkYtd62R0b
	 vla6rhbx2on3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 6/8] selftests/bpf: Adjust bpf_map layout in
 verifier_map_ptr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260707193104.350066-7-daniel@iogearbox.net>
References: <20260707193104.350066-1-daniel@iogearbox.net>
 <20260707193104.350066-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 19:50:44 +0000
Message-Id: <20260707195044.729391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unmodified selftests fail due to removed in-loader signature val=
idation logic.
--

--- Patch [6]: [PATCH bpf-next v5 6/8] selftests/bpf: Adjust bpf_map layout=
 in verifier_map_ptr ---
commit 044ddeab6141689800cc4332d820c23c210957a8
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Adjust bpf_map layout in verifier_map_ptr

This commit updates the expected verifier messages in the verifier_map_ptr
test to account for the removal of the write-only excl member from
struct bpf_map.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools=
/testing/selftests/bpf/progs/verifier_map_ptr.c
> index 1661936598703..e0a65835c861b 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
[ ... ]
> @@ -97,23 +98,23 @@ __naked void read_non_existent_field_rejected(void)
>  }
> =20
>  /*
> - * The u32 excl field spans offsets 32..35 (mend 36). Reading a u32 at o=
ffset
> - * 33 starts inside excl but extends past its end, which the verifier re=
jects
> + * The sha byte array spans offsets 0..31 (mend 32). Reading a u32 at of=
fset
> + * 30 starts inside sha but extends past its end, which the verifier rej=
ects
>   * as an out-of-bounds scalar access.
>   */

[Severity: Medium]
Does this patch series also need to update signed_loader.c to account for t=
he
removal of the excl member and emit_signature_match logic?

It appears that leaving tools/testing/selftests/bpf/prog_tests/signed_loade=
r.c
unmodified causes several tests to fail.

For example, check_sig_match_shape() explicitly looks for
emit_signature_match instructions which are no longer generated:

    for (i =3D 0; i + 1 < n; i++) {
        if (in[i].code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
            in[i].src_reg =3D=3D BPF_PSEUDO_MAP_IDX) {
            a =3D i;
            break;
        }
    }
    if (!ASSERT_GE(a, 0, "emit_signature_match present"))
        return;

Additionally, metadata_not_exclusive(), metadata_sha_mismatch(), and
metadata_hash_not_computed() test validation failures by passing a NULL
signature. Without a signature, the kernel verifier skips metadata validati=
on
entirely.

Since the runtime check was removed, the loader now successfully executes
and returns 0 instead of -EINVAL, causing these tests to fail:

    r =3D run_gen_loader(f.gopts.insns, f.gopts.insns_sz, f.blob,
                       f.data_sz, NULL, 0, NULL, 0, true, f.ctx,
                       f.ctx_sz, &ran);
    ASSERT_TRUE(ran, "loader ran");
    ASSERT_EQ(r, -EINVAL, "non-exclusive metadata map rejected");

Are there missing updates to signed_loader.c that should be included here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707193104.3500=
66-1-daniel@iogearbox.net?part=3D6
