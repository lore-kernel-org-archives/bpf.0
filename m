Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5703E7BAF
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409724; cv=none; b=F/Jq64YDVIpxnW21BZZJkef7TLHclC+JiZBSTsN/C2ex/4D/wPH8ELit4YdjsvG/tSEf797n/cy5qLUgdTkTvGi/bgm10LR+e+AzHhG2Raj+S5MwUsyMycal621Zowqupin3qvfH9wi07XiuLFW20/CksG0KxDwYNqvoU2bX768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409724; c=relaxed/simple;
	bh=Rs16UuzQH7NVpiNBmSmJsGSrRl182haQqix97b61qGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XPuT3jmRXzoml+QTerDB6kOUBqQtB3TT75JnZ3W/oa6qkvQu4OiwE4qHmOe6/yJFRhBHc1yFIsPRuwsK70V+QUldplIX3Ht5SLzVXs/wZYwALvD0ipvuJJsXNtMXqqOPmWOODo4yaCsq4hYUZxNmxdKox0I64uSYNa+mly/MN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVOfy1IU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVOfy1IU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D63C1F00893;
	Tue,  2 Jun 2026 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780409723;
	bh=JAJnJIHLQton3CHz57A5Qni9KI/U3jKHaUM4UqNrWRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jVOfy1IUpT0B08m21Fkg+WlJ4Jghxyla3xF+R7vXD1XJsEbwJAD9iSDmBfTBGg+Mv
	 3CjDCaJx7UhfeHyX5v2I+cO4EwxhAkA3ogODLb3qi9fLym/wTK5XLk9gn87C0ScgqA
	 ovgjH9yHEJyfcMmN1wE6nzdoqSG8PPOohTXJIxquv/F+q+2ErYz1cMKOV4FhuTfWfz
	 4wqmkVYZjUbxiXqoKRiFiqD2024w8wZJKE+8CZb4yS6DZhHzAhmAN/aT8e+cAaQp9o
	 A6BhU7oBtecf+m5RyDUD4y3U8ekDs7V7OD+BAW5BXS2pvdbTC60Sr+GfDdS20Qs1EW
	 gp3utBFdG5kVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: Keep verifier_map_ptr
 exercising ops pointer access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602133052.423725-4-daniel@iogearbox.net>
References: <20260602133052.423725-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 14:15:22 +0000
Message-Id: <20260602141523.2D63C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Test suite regression on 32-bit architectures due to hardcoded 6=
4-bit struct offsets.
--

commit 3edf5d52e70729a68d2f02df9f51787362f009a3
Author: Daniel Borkmann <daniel@iogearbox.net>

selftests/bpf: Keep verifier_map_ptr exercising ops pointer access

This commit recovers the old test for verifier_map_ptr with the right
offsets to exercise ops pointer access. It also adds the existing test
as an additional test case.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools=
/testing/selftests/bpf/progs/verifier_map_ptr.c
> index d8e822d1a8bab..1661936598703 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
[ ... ]
> @@ -72,17 +72,43 @@ __naked void bpf_map_ptr_write_rejected(void)
[ ... ]
>  __description("bpf_map_ptr: read non-existent field rejected")
>  __failure
> -__msg("access beyond the end of member excl (mend:36) in struct bpf_map =
with off 33 size 4")
> +__msg("cannot access ptr member ops with moff 40 in struct bpf_map with =
off 41 size 4")
>  __failure_unpriv
>  __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
>  __flag(BPF_F_ANY_ALIGNMENT)
>  __naked void read_non_existent_field_rejected(void)
> +{
> +	asm volatile ("					\
> +	r6 =3D 0;						\
> +	r1 =3D %[map_array_48b] ll;			\
> +	r6 =3D *(u32*)(r1 + 41);				\

[Severity: Medium]
Does this hardcoded offset in read_non_existent_field_rejected() cause test
failures on 32-bit architectures?

Since pointers are 4 bytes long on 32-bit, the excl field at offset 32
would be followed by ops at offset 36. Offset 41 would point inside
inner_map_meta instead, causing the verifier error message to mismatch
the expected __msg above.

[ ... ]
> @@ -105,7 +131,7 @@ __naked void ptr_read_ops_field_accepted(void)
>  	asm volatile ("					\
>  	r6 =3D 0;						\
>  	r1 =3D %[map_array_48b] ll;			\
> -	r6 =3D *(u64*)(r1 + 0);				\
> +	r6 =3D *(u64*)(r1 + 40);				\

[Severity: Medium]
Will reading 8 bytes at offset 40 in ptr_read_ops_field_accepted() fail on
32-bit architectures?

On 32-bit, offset 40 corresponds to inner_map_meta which is only 4 bytes.
The verifier requires an exact size match for pointer reads, so a size 8
read would trigger a rejection instead of the expected success.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602133052.4237=
25-1-daniel@iogearbox.net?part=3D3
