Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0D39733E
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790060; cv=none; b=NbPkSL9Eg/eM71904QAHD7chk+a6XmD4RC6i1FudNnj/9xorZ+GfKv8YHQ7JJUGrxAjEjzghAUmYxqmqw3vugSQnefHhHV5S0vj/kGV6LHeK3q7+YjK7zdMIHTHWHdFTyFsx2SRUjjehMVMO/NM7ao2A5Dyw1/GGbs2qj2NrKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790060; c=relaxed/simple;
	bh=2+Aw8KFmXkmw+R4NR004OLgX4Y/M6BTSxaovwFQ9YGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gK6vxJOcwkgZJ8iSWfVSXwXj+PBGgUzuh2osKc6T/WmFNt0D5t682j8FLgzxCI4KOaTTq3bBk0An8VN6YD2huhESuhcmB3tM4Lf+F07VSePZGOrPmZqLwv1KKRK4MWe1BvmTuDv+qAGvbAVEk36lCjr/cm19Wfdr1eYWYGYxU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8+WOMs3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8+WOMs3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD69D1F000E9;
	Tue, 26 May 2026 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779790059;
	bh=bL1GdqEfGbGp9yi/ZGP1lq1NN5ID+g9ycIcEYNhd4NY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c8+WOMs31v53vm9azFsbNaPMATpYcGNyuUsx8WULs72Vz68Y6D9U9YuAQhyO7mS0M
	 TkOkaTh/5N8JLa68T2zFUpr9bzsgTPSdMRpdZd7/MKgfsOcdhDlsvLKR4mv9FrAEAJ
	 DJ4rcFgRSuIphpZHXwRwEfCrTf/F8yoALA3zko0635uJRs0RI6fgtKTZuGISp+eRaN
	 U+PFaX+6o6zDStoYOfiunLn+6BdC3IDimK7o7soPcMuhdksYVxxorWgwctt9AKD/yh
	 QVwjF2JTukWY1k0jtdwzZOlFDAaEztkUG8zqe9L9wZd5Sl96UnN+BgqtX98JCpWpJ0
	 Mz3XbSwywuKsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 2/6] bpf: compute loops hierarchy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526-better-1m-reporting-v1-2-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-2-51e4f2c59780@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 10:07:38 +0000
Message-Id: <20260526100738.DD69D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf_compute_loops() incorrectly uses kfree() to free memory alloca=
ted with kvcalloc().
--

commit ef2f37474f7b031f628d088384c6723a83200838
Author: Eduard Zingerman <eddyz87@gmail.com>

bpf: compute loops hierarchy

This commit adds an analysis phase to the BPF verifier to compute the
loops hierarchy using a non-recursive algorithm. It records the loop
header per instruction and tracks loop irreducibility to provide better
callchain profiling.

> diff --git a/kernel/bpf/loops.c b/kernel/bpf/loops.c
> new file mode 100644
> index 0000000000000..4bbcd923e960a
> --- /dev/null
> +++ b/kernel/bpf/loops.c

[ ... ]

> +int bpf_compute_loops(struct bpf_verifier_env *env)
> +{
> +	struct bpf_insn_aux_data *aux =3D env->insn_aux_data;
> +	int i, err =3D 0, len =3D env->prog->len;
> +	struct loops_dfs dfs =3D {};
> +
> +	dfs.dfs_pos =3D kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
> +	dfs.state =3D kvcalloc(len, sizeof(struct dfs_state), GFP_KERNEL_ACCOUN=
T);
> +	dfs.stack =3D kvcalloc(len, sizeof(int), GFP_KERNEL_ACCOUNT);
> +	if (!dfs.dfs_pos || !dfs.state || !dfs.stack) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}

[ ... ]

> +out:
> +	kfree(dfs.dfs_pos);
> +	kfree(dfs.stack);
> +	kfree(dfs.state);

[Severity: High]
Should these be freed using kvfree() instead of kfree()?

Since these arrays are allocated using kvcalloc() and BPF programs can cont=
ain
up to 1 million instructions, the allocations can grow to several megabytes.
In such cases, kvcalloc() will fall back to vmalloc().

Calling kfree() on a vmalloc address will blindly call virt_to_page() for a
virtual address, which can lead to a kernel panic or slab corruption.

> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526-better-1m-=
reporting-v1-0-51e4f2c59780@gmail.com?part=3D2
