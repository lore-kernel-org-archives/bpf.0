Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0E5474F
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096542; cv=none; b=LmF/fOlbOO/0ARN9lFQdoMwzrr4QDYikoK0c28krk8Yli48sswa0QdLzeJXKMnaAqZuGezsWlSqqzyCcvUEAi/GMD4SHzjjyA4guvUYssS8CNhYmb/148Uwh7RaaYEoVYSqQm09slw1Ty2fmHWZaAVa6YAPc+mUIMquMsH1hUAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096542; c=relaxed/simple;
	bh=LTCo9KnUW05BLYVEKDZuymOePhAPshn3EX51Uq6L0Uk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JYf/gCcz5Wz09mDkkSfwbRttEwVUzsjP0rbCZw0r4UI1J5Kdkn4bCRjvSf+EO1rsVsUltprpfpViwwiLDbcLhvLxWstUcKu/CYuuAttXThmc9fuvt6IA8h3nmtg6Uc3pUbvvXykolbGmRivFOl+w7+77T87TndhzgJd+sueMsXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otIt2azp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otIt2azp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17021F000E9;
	Mon, 22 Jun 2026 02:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782096541;
	bh=uQu9iyWq9CV1IL+z63CLCG2PNBHiaTpKqxQtEBEP4i8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=otIt2azpfwUKKzNl8B5Qz0s5etE2FvmuYdoEeDGsBbN2kKkOYxh1lmVLPeutbI4z+
	 UUVYi6C5/KmsKo0gRfCriyREK8VtTElduGdWISoM74ghGROLV1jG7Z/ExTung9dOc+
	 GTa1arun8Rq5KMO1viaLoWLO1govXifnL46SeWsO7ie8lL1nhFrZyRFwcE9fQvLFvV
	 dNzZ9oZ9dy3HQxT0v/xAPEtTikDof5rJKSSCp3zUFCsViaxMSj52ijW8+za12ydTZk
	 QHsWfW9+JEWk3nZbz/J7cXv2NHhS0wv2ydv3WvzVWj0E1MxRhxbPpN80zGpvQ8Cydd
	 TU4DKXWBhiKuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] tools/bpf/bpftool: Reset vmlinux BTF after map dump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yichong Chen" <chenyichong@uniontech.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <E369B37D2D3B6B9D+20260622023345.1135373-2-chenyichong@uniontech.com>
References: <20260622023345.1135373-1-chenyichong@uniontech.com>
 <E369B37D2D3B6B9D+20260622023345.1135373-2-chenyichong@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 02:48:59 +0000
Message-Id: <20260622024900.D17021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Incomplete Fix: `print_key_value()` frees the global `btf_vmli=
nux` object but leaves the pointer dangling, leading to a Use-After-Free in=
 batch mode.
- [High] Severe memory leak in `cgroup` tree traversal and batch execution.
--

commit c154c8297093a9827de6d90793d321cdcca31123
Author: Yichong Chen <chenyichong@uniontech.com>

    tools/bpf/bpftool: Reset vmlinux BTF after map dump
   =20
    map dump frees the global btf_vmlinux object.
   =20
    In batch mode, a later map dump can reuse the stale pointer.
   =20
    Reset the global pointer after freeing it.

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 71a45d96617ed..dc22fe8750467 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -790,6 +790,12 @@ static int maps_have_btf(int *fds, int nb_fds)
> =20
>  static struct btf *btf_vmlinux;
> =20
> +static void free_btf_vmlinux(void)
> +{
> +	btf__free(btf_vmlinux);
> +	btf_vmlinux =3D NULL;
> +}
> +
>  static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **=
btf)
>  {
>  	int err =3D 0;

[ ... ]

> @@ -958,7 +964,7 @@ static int do_dump(int argc, char **argv)
>  		close(fds[i]);
>  exit_free:
>  	free(fds);
> -	btf__free(btf_vmlinux);
> +	free_btf_vmlinux();
>  	return err;
>  }

[Severity: Critical]
This is a pre-existing issue, but does this commit leave an incomplete fix?

Looking at print_key_value() in map.c, it fetches the BTF object using
get_map_kv_btf(), which aliases the local btf pointer to the global
btf_vmlinux cache:

static int get_map_kv_btf(...) {
    ...
    *btf =3D btf_vmlinux;
    ...
}

print_key_value() then unconditionally frees it:

static void print_key_value(...) {
    ...
    btf__free(btf);
}

Does this destroy the global BTF object but leave the static btf_vmlinux
pointer non-NULL? In batch mode, if a subsequent command executes, could
get_map_kv_btf() return this dangling pointer and trigger a use-after-free
when accessing map data?

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the use of
btf_vmlinux, does this code leak the BTF object in cgroup.c?

In do_show_tree_fn(), which is invoked by nftw() for every directory in the
cgroup tree:

static int do_show_tree_fn(...) {
    ...
    btf_vmlinux =3D libbpf_find_kernel_btf();
    for (i =3D 0; i < ARRAY_SIZE(cgroup_attach_types); i++)
        show_bpf_progs(cgroup_fd, cgroup_attach_types[i], ftw->level);
    ...
}

Could this unconditionally overwrite the static btf_vmlinux variable without
freeing the previous allocation? On systems with many cgroups, wouldn't
traversing the tree leak memory and potentially trigger the OOM killer?

Does do_show() in cgroup.c leak the BTF object across batch commands in the
same way, since it also fails to free the allocation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622023345.1135=
373-1-chenyichong@uniontech.com?part=3D1
