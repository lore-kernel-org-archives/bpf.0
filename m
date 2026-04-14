Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD3313E07
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 22:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204737; cv=none; b=ltXIyuBMNT/9yldU0hJpYFp97Fau9km1Jebgpmi2tpxK7jZOR8EAnJeK8MsZA7WwtT1q8Gy+p4dCNstwqe2SebcKuGsLjAV52jBrF1qU6mqU+LABlZw252KqFnswPY5eZCIZwUaHUYBqawkkBBNrUAvGB5l4E4/QwXQW8AkXtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204737; c=relaxed/simple;
	bh=pt1RC1XXK31dR1BhL8VM9YjXr+mxqG8lGMO+oUmxu90=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rQ8C/6H8mxnUoSgaJZTAQSbH/xnwqHqv9qmuupf4h679uPTpGYx8CcWPHr+thWaNPjVgSSF1AQo1Ui0q6v8DaeKLBMbxuRJk3pe4vLQctCeQrc3VbrXqULpWgyOsncwoWiCYm+GKrVpY6eBDOdWWkVpwMn7DC7jFP9cNn8wUDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSeMF7h6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSeMF7h6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB23C19425;
	Tue, 14 Apr 2026 22:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776204737;
	bh=pt1RC1XXK31dR1BhL8VM9YjXr+mxqG8lGMO+oUmxu90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OSeMF7h6X83P1+3LJ4uADunQ9mFRTgU0TO7nn2LIV0HOgHPQUPimoaPszIq4nQKzu
	 sp2X8S1g89Ev8GWxEEfF7EI8jEeFUXB/RypEvxOhV0d7tHJmQPCpePNIBHqCIn2O8N
	 FBCcvnUbdBGvt/9WqF8IBQexfivbcuijYbEdh04OG8P5j/v2W3JAvpsN83fD+zYfY9
	 3zCHAgbtVPdizN0m4zmsBCVFAcgAOraT2glfl/j/yk4bua0AIT9T3CXpx2xtwLuI8s
	 hMlwBZLuAjytnSJmooLLv7zwH4LlXqq/3Lw0UVYGJwpPJCwWJSAjdtI4Td6UK26+xU
	 H/aTLp6iMGjXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/6] bpftool: Support 24-bit vlen
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414195019.684531-5-alan.maguire@oracle.com>
References: <20260414195019.684531-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 22:12:16 +0000
Message-Id: <20260414221216.DEB23C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Infinite loop in bpftool when dumping BTF enum types with 65536 =
or more members.
--

commit 0557506c731dab5c8d22900a9797fac53be5f625
Author: Alan Maguire <alan.maguire@oracle.com>

bpftool: Support 24-bit vlen

This commit updates bpftool to handle the new 24-bit BTF vlen by changing
variables and loop counters from 16-bit to 32-bit integers across various
BTF dumping functions.

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 2e899e9400341..6ef908adf3a4a 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
[ ... ]
> @@ -225,9 +224,8 @@ static int dump_btf_type(const struct btf *btf, __u32=
 id,
>  	}
>  	case BTF_KIND_ENUM: {
>  		const struct btf_enum *v =3D (const void *)(t + 1);
> -		__u16 vlen =3D BTF_INFO_VLEN(t->info);
> +		__u32 i, vlen =3D BTF_INFO_VLEN(t->info);
>  		const char *encoding;
> -		int i;

Are there missing updates to btf_dumper_enum() and btf_dumper_enum64() in
tools/bpf/bpftool/btf_dumper.c?

In btf_dumper_enum(), the loop counter i is still declared as a 16-bit
integer:

static int btf_dumper_enum(const struct btf_dumper *d,
			    const struct btf_type *t,
			    const void *data)
{
	const struct btf_enum *enums =3D btf_enum(t);
	__s64 value;
	__u16 i;
	...
	for (i =3D 0; i < btf_vlen(t); i++) {
		if (value =3D=3D enums[i].val) {
	...

If a BTF enum type has 65536 or more members, btf_vlen(t) will return a val=
ue
greater than or equal to 65536. The __u16 i counter will overflow to 0 upon
reaching 65536, meaning i < btf_vlen(t) will always remain true.

If the dumped variable's value does not match any of the first 65536 enum
members, will the function loop infinitely instead of falling back to
jsonw_int()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414195019.6845=
31-1-alan.maguire@oracle.com?part=3D4
