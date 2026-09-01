Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA146AA61;
	Tue,  1 Sep 2026 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282821; cv=none; b=ESWU9QdIFmfHC3ZSUUeMBKaN3yA33vGClyALUIExPP1MgSPptwGfRaMaFWj+sSBhZcm8qfRMODxMYycsvAXhbu9M0ZxCi/6VRdPLjxIxqTHZHXcWuMTFEL+p0uX3qfiMU6s9rJmSans/8rtmyYX9q5ECJpElXlundJb57U7lRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282821; c=relaxed/simple;
	bh=pvnAiDuX00uqpuGRu6YwsJ8+G7QYl4760AnR3jnoQQY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=flApHWNYM3TdnF6hmP6C2QrV5+aiDJZH5jOXVZqna4P2SdKO15zre5V0BpmfbvNxBD6evrCW/CBOSjM5LAZ6yz1ioXnT3G80i4xvTwTQ5MKeq48C/MWP6rkKkv3M/DQjHU62fSwQk4/qLF5KVIYtqQfe6X0H9wF0fdLpgaQj/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAwYZlP2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAwYZlP2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6621F000E9;
	Tue,  1 Sep 2026 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282819;
	bh=cw/dmTYWujRIT7Iwfph5Hd44BxCAPxtNXYqLBFgJw8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iAwYZlP2sCjNu679WU2RE6+kd6gTq/hRCQweViQ2hRHP3xa4zQZWhWI2i1taGz3Lw
	 gEsnx/UVW1TP45wWluxgqKNOA8MEcbRT0I72FkltCv87ok4zQbRL1LrQxSumNP+iUN
	 IzCR9SFB3s56/ASFqeD/SImDciTfmXovko6MAwaRdkAhJXt09Zh0gTkVry0/eib2py
	 e4FzoKcAUBXBQHSmThXSzB9hE7M3sKZUvBlFFVyTPmX0eJ7LzEW96BEVW1/d+RX7VV
	 oRDupBJGH76upVa/sjF9OGOEQIqzpzB9RPWgsFtt2Ci1JjnDAgYfck9YlOibPEdFJ6
	 CC+CBJmoAhuzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 09/18] bpftool: Handle multi-split BTF by
 supporting multiple base BTFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260901165757.801449-10-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-10-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:13:38 +0000
Message-Id: <20260901171339.5B6621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Memory leak of intermediate base BTF objects in the multi-split =
chain on the success path, and leak of the entire chain on the error path.
--

commit af485a13fcb0c9c0f013599abed8bb48b059b6e0
Author: Alan Maguire <alan.maguire@oracle.com>

bpftool: Handle multi-split BTF by supporting multiple base BTFs

This commit updates bpftool to support multi-split BTF by allowing multiple
base BTFs to be specified via multiple -B arguments.

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 5ababd8f7d0a0..9329f140b700f 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -515,7 +515,8 @@ int main(int argc, char **argv)
>  			verifier_logs =3D true;
>  			break;
>  		case 'B':
> -			base_btf =3D btf__parse(optarg, NULL);
> +			/* handle multi-split BTF */
> +			base_btf =3D btf__parse_split(optarg, base_btf);

[Severity: Medium]
Does this code leak the previous base_btf objects on error?

If a user supplies multiple -B arguments and parsing fails on a subsequent
-B, the base_btf pointer is overwritten with NULL, losing the reference to
the prior chain.

Does this setup also leak the intermediate bases on the success path?

The chain is built properly, but at exit btf__free(base_btf) only frees the
top-level BTF because objects loaded via btf__parse_split() do not take
ownership (owns_base =3D=3D false) of their parent base BTF.

>  			if (!base_btf) {
>  				p_err("failed to parse base BTF at '%s': %d\n",
>  				      optarg, -errno);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D9
