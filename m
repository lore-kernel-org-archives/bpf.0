Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FBD488766;
	Tue,  1 Sep 2026 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282978; cv=none; b=bTR4M8SGqU7Bqgs0WBASM0QOb838JmLawMvBUYSVi7jw3LkWrwG6MVUwo6HFh9GQe9jKMe/xRORmuUU5CJGBEDazJAFogawPI1ASOvUq7cfk4uSpbOCNkL48xbUn9ACYHe6I24yXymTlv1Wm+E4GZnQ4ESEIfj/g6NXD9XJu59U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282978; c=relaxed/simple;
	bh=Ko9p1FEqHmkkh/icu+YVEDf1Jxq2ljs5DXmNdSgFPiI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OBFG7+Qa5I+TWWvzqBjkfEd27W0MKe3GV9UeONr+DiztRoioid8pfiyy9MgY8zJ7Yv+ayT/FaWgvkphTWgTtxpb9vSiFHu0wSv+ecZFQ896AT7LJ49mYzFK9jT46K6PkMFO2lZYOOIsyFwL0GlDj/5HVH9jfYCiWdQes46E2CPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huTOKOit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huTOKOit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2CA1F000E9;
	Tue,  1 Sep 2026 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282977;
	bh=O+5Z+4hfqSGpvaCL++Zy3UdHiEjGohPUsan/S63OTHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=huTOKOitl/WDbStJzaVd54ztz/dZ9VRRLOX8Fo1anf1lFhnEsbClxybSUnLTvzFb9
	 wLzOA2hr/OWSv1OIpv5aWLKHYIbHkiK7xS1qZJVAuyM+zbmU+zF4K1QgTzhf7SBIZL
	 eaVcZ++3ls3KXOGKKM3qSYPRZbfYTsOhkz9RtKWIxkDPWEEs4ANFRzFpwpaHYHN8IT
	 Ax8BueEEzD7zj/qwP8nwhB3lgsbXuGNUzQxN14mfDtYHvAYGWV0FF2R+qof4s1DkL1
	 Y/IX5ASs00uuH6o2nGaXphwfpQFPPs3kCGavVv1Peef+dkKceVrR6+LSwUW612Awd5
	 Wi8aQXtx2GT+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 11/18] bpftool: Add ability to dump
 LOC_PARAM, LOC_PROTO and LOCSEC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260901165757.801449-12-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-12-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:16:16 +0000
Message-Id: <20260901171616.DC2CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `vlen` for BTF_KIND_LOC_PROTO is incorrectly cast to `__u16`=
, causing implicit truncation for large vlen values.
- [Medium] The `BTF_LOC_PARAM_SIGNED` flag is ignored when printing values =
for `BTF_KIND_LOC_PARAM`, causing negative signed values to be printed as u=
nsigned.
--

commit 979370a25e9a748392e761a4d7cd6d5cda14a0ed
Author: Alan Maguire <alan.maguire@oracle.com>

bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
   =20
This commit updates bpftool to support dumping the new BTF kinds
BTF_KIND_LOC_PARAM, BTF_KIND_LOC_PROTO, and BTF_KIND_LOCSEC. It adds raw and
JSON formatting support for these new types.

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index bca0a3982f09b..4d8991c99b484 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
[ ... ]
> @@ -415,6 +418,88 @@ static int dump_btf_type(const struct btf *btf, __u3=
2 id,
[ ... ]
> +	case BTF_KIND_LOC_PARAM: {
> +		const struct btf_loc_param *p =3D btf_loc_param(t);
> +		__u32 *v =3D (__u32 *)(p + 1);
> +		__u32 i, vlen =3D btf_vlen(t);
[ ... ]
> +		for (i =3D 0; i < vlen; i++, v++) {
> +			if (json_output) {
> +				jsonw_start_object(w);
> +				jsonw_uint_field(w, "value", *v);

[Severity: Medium]
Since the BTF_LOC_PARAM_SIGNED flag can be set in p->flags, will this
jsonw_uint_field() unconditionally format negative signed values as large
unsigned integers?

> +				jsonw_end_object(w);
> +			} else {
> +				printf("\n\t value=3D%u", *v);

[Severity: Medium]
Similarly for the plain-text output, does this ignore the BTF_LOC_PARAM_SIG=
NED
flag and print signed negative values as large unsigned integers?

> +			}
> +		}
> +		if (json_output)
> +			jsonw_end_array(w);
> +		break;
> +	}
> +	case BTF_KIND_LOC_PROTO: {
> +		__u32 *params =3D btf_loc_proto_params(t);
> +		__u16 vlen =3D btf_vlen(t);

[Severity: Medium]
The vlen field in BTF types uses 24 bits. Does explicitly casting it to __u=
16
here silently drop the upper 8 bits?

For a BTF_KIND_LOC_PROTO type with a vlen greater than 65535, this could
truncate the output and display an incorrect number of parameters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D11
