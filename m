Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29044E659
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544101; cv=none; b=iJ17acsvuGa2Z2eP1zO5zVSq2yCuwLZ3m1fhVejf+D3cXQik8mDaxQksoLLZL/Htg4WRGJfyZNvYlSdRungpyqVbBATw743cwkEzEHQ8FCrW+22PXxyxrQf75KtJe2Xnvqmhvu6kwfaUvLNfXk82caOhjGW+uZC0cywWzaH0w/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544101; c=relaxed/simple;
	bh=z/xdbBoX67RLjM8cebkAkzKS4tdXauax2CNSwj+j3sU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sPSVaz0NoXWYuyfE/3X5rJ0ysEUAtUer1BZ0aSc4ictL3SSUgDA6BMQwx6qjpuKRU+9272lN3EDhr6xNmcCd8i5cNHKoIjkWgOFnH1/boNhz6wCbm4/LoeWuIJPU/G9UU06MRCGXoFUaDg5Dn0vLwhP19joElU7A5K04fM4Jij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ97kIPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ97kIPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CED51F000FF;
	Wed, 16 Sep 2026 07:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789544094;
	bh=UYE1RaP5umdZQfku6GR8xh/8uboQNE0UB568eIoEpaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KJ97kIPVDpaBDRvWA3kybqFy8xYRiu2lkVgK+5ms5Liyx4PWSiAKTePkOYpqq4mkZ
	 WXjRzuADfCJOA8HB2YKqe5Rt4kqCghVDUFENM3IFKTzHg5kf4JIVpTbso2z1EGHDwA
	 jRcuhjJxvKAP06yImRkcY+YIs+j/7w9iH8yrjkgcgW/uDkncZk44kVzBrSt754xpd0
	 BJugUxEQbYqPoez+M9jFEdAZq3gbX4Rjiz1nUsaqHBcJ2dc8wZbEg6/+RATHwFUlop
	 2LKMqlV53pZMeIP7/NOKn2n2avmbN26yMr9NWyg4ydjFvDlmAACqOer1EpqM8/E9Ql
	 sMgBo6oAUxZQg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 2/5] selftests/bpf: add iocost cost model test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, tj@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260916072302.1068871-3-cui.tao@linux.dev>
References: <20260916072302.1068871-1-cui.tao@linux.dev>
 <20260916072302.1068871-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:34:54 +0000
Message-Id: <20260916073454.9CED51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] bpf: iocost_2x model misses cursor updates during merges
- [Low] bpf: invalid multi-line comment style in bind_model
--

commit 0857836334950bc87bf809661e8e366dfa84c06a
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add iocost cost model test

This commit adds an example cost model implementing the full builtin linear=
 HDD
formula at double cost. It registers it as a struct_ops and binds it to a d=
evice
to verify readback and write operations.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tool=
s/testing/selftests/bpf/prog_tests/iocost_model.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
[ ... ]
> +static int bind_model(const char *dev, const char *name)
> +{
> +	char buf[300], got[64];
> +	int err;
> +
> +	snprintf(buf, sizeof(buf), "%s model=3D%s\n", dev, name);
> +	err =3D write_cost_model(buf);
> +	if (err)
> +		return err > 0 ? -err : -EIO;
> +	err =3D readback_model(dev, got, sizeof(got));
> +	if (!err && !strcmp(got, name)) {
> +		/*
> +		 * restore the builtin linear model on every path so
> +		 * the device is not left bound to a model the caller
> +		 * may unregister right after; the write is checked too
> +		 */
> +		snprintf(buf, sizeof(buf), "%s model=3Dlinear\n", dev);
> +		err =3D write_cost_model(buf);
> +		return err > 0 ? -err : (err ? -EIO : 0);
> +	}
> +
> +	/* bind failed or does not read back: still restore, but report
> +	 * the original failure rather than the restore result
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment violate the BPF subsyste=
m's
strict comment style?

The opening `/*` must be on its own line, but here the text starts on the s=
ame
line.

> diff --git a/tools/testing/selftests/bpf/progs/iocost_model.c b/tools/tes=
ting/selftests/bpf/progs/iocost_model.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iocost_model.c
[ ... ]
> +SEC("struct_ops")
> +u64 BPF_PROG(iocost_2x_calc_cost, u64 opf, u64 nbytes, u64 sector,
> +	     struct blkcg *blkcg, u64 model_flags)
> +{
[ ... ]
> +		cur =3D *cursor;
> +		if (cur && priced) {
> +			seek_pages =3D sector > cur ? sector - cur
> +						   : cur - sector;
> +			seek_pages >>=3D IOC_SECT_TO_PAGE_SHIFT;
> +			if (seek_pages > LCOEF_RANDIO_PAGES)
> +				base =3D randio;
> +		}
> +		if (priced && nbytes &&
> +		    !(model_flags & IOCOST_COST_F_MERGE))
> +			*cursor =3D sector + RU(nbytes, 512);

[Severity: Medium]
Does skipping the cursor update when IOCOST_COST_F_MERGE is set permanently
lose track of the end of merged requests?

If a sequence of backmerged bio submissions triggers calc_cost with
IOCOST_COST_F_MERGE set, it seems this branch will skip advancing the curso=
r,
leaving it pinned at the end of the first bio in the merged sequence.

If a stream builds up more than 16MB of data through merges, would subseque=
nt
contiguous IOs calculate a seek distance > 16MB and falsely incur massive
random IO charges?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916072302.1068=
871-1-cui.tao@linux.dev?part=3D2
