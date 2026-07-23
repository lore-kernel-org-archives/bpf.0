Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AB73A9622
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785337; cv=none; b=B6EF5v12aClz9rulb/lhhFcJbTIQOHng46Y9BMTQwF15oxlAJ2Fe/aggpsvTjS/NIAkcO/0tfY5/EZFoj++YqwkhTW4XSemGjyjteBStysAttGFwJ5+pb6JFg4FGRzlNTmV0Xj0ej+6RskOIAOCVYBLI7LawWsv2G11s3aUUSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785337; c=relaxed/simple;
	bh=MJRuYUbW7LS+q3iP3mEJK0QnGnfMLruj7LK686SKD3g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IQmdz8NPHY0Yg86LhbWttHrEyT+VXenm2uqQDrS1pkSbL7umGC/ZYnbYgdDUGGq9aaLFaJFg2Wuf9IuL9ffBTImRrm37vmnoO209sUXKSM2M3Khx94xGGFR/hGB6qhnN0/I3BWdfYbSn/Ov9Kr0x+LBBIhaOhex32/kjGucW3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001381F000E9;
	Thu, 23 Jul 2026 05:42:15 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 06/18] selftests/bpf: Add tests for helper
 and kfunc mem+size arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723050806.1158442-7-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
 <20260723050806.1158442-7-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 05:42:13 +0000
Message-Id: <20260723054216.001381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest `mapofmaps_value_as_kfunc_mem_buf` uses an out-of-b=
ounds buffer size (8 instead of 4), and both tests lack explicit `__msg(...=
)` assertions. This causes the test to pass (fail verification) for the wro=
ng reason, rendering it ineffective as a regression guard.
--

--- Patch [6]: [PATCH bpf-next v1 06/18] selftests/bpf: Add tests for helpe=
r and kfunc mem+size arguments ---
commit 967fe45d86aee49807b5742ffece3f858b20a4fd
Author: Amery Hung <ameryhung@gmail.com>

selftests/bpf: Add tests for helper and kfunc mem+size arguments

Make sure the return of map-of-maps lookup cannot be passed to nullable
memory buffer argument for helper and kfunc.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c b/=
tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
> new file mode 100644
> index 0000000000000..78a9ad22b10df
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
[ ... ]
> +/* An un-narrowed map-of-maps value must be rejected as a __nullable kfu=
nc mem buffer */
> +SEC("?tc")
> +__failure
> +int mapofmaps_value_as_kfunc_mem_buf(struct __sk_buff *skb)
> +{
> +	struct bpf_dynptr dptr;
> +	__u32 key =3D 0;
> +	void *inner;
> +	char *p;
> +
> +	inner =3D bpf_map_lookup_elem(&outer_map, &key);
> +	/* intentionally NOT NULL-checked: reg stays PTR_TO_MAP_VALUE_OR_NULL */
> +
> +	bpf_dynptr_from_skb(skb, 0, &dptr);
> +	/* pass the un-narrowed map-of-maps value as the scratch buffer */
> +	p =3D bpf_dynptr_slice(&dptr, 0, inner, 8);

[Severity: Medium]
Does using a size of 8 here exceed the outer map's value size of 4?

If the intended type check is missing, the verifier will still reject the
program due to a bounds check failure (size 8 > 4). Since the test uses
__failure without __msg(...), this unrelated bounds-check failure satisfies
the test expectation and causes it to pass for the wrong reason.

> +	if (p)
> +		return p[0];
> +	return 0;
> +}
> +
> +/* An un-narrowed map-of-maps value must be rejected as a PTR_MAYBE_NULL=
 helper mem buffer */
> +SEC("?tc")
> +__failure

[Severity: Medium]
Similar to the above, would it be better to include a __msg(...) assertion
here?

Without an explicit message check, this test could pass due to unrelated
verifier errors.

> +int mapofmaps_value_as_helper_mem_buf(struct __sk_buff *skb)
> +{
> +	__u32 key =3D 0;
> +	void *inner;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723050806.1158=
442-1-ameryhung@gmail.com?part=3D6
