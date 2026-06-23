Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D9C8EB
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250855; cv=none; b=lQ/EjQD9AF6jwgU0UHXKB1PBy7UgvSHBzgGG92unTQJD5CpPE0SLLJvvBBKNob4w5OLn61f73xGQtytnIwV38j1b4p8z6tIVAmOpE1639HVh5WnqjqhhdeI0FFkUsugmnkYEx3o5L7Ahp1wLjF18vTLUFkoj90zfQOqTbxHVjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250855; c=relaxed/simple;
	bh=CtHPLoAY44IGNL6BPRwyEY/ogZ1/6VVOk6hXf4AuZUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXQl/av+YPq7Fvgtf2KR797XIMibPvkov9ObYKHRh0UYLpAzpfi2W6i5P0jhhA+LqkuziiEHPX8N+oLs441EE+jUEwifeOll3v73rEa64sCAvghBtXD2jckxeUqKwpNm5+LRABPHIWDBAKay+Opl/Td/Av7V8oZ0mvHRTXeotTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icef294k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icef294k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909821F000E9;
	Tue, 23 Jun 2026 21:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782250854;
	bh=6RrXZof9eTGrVu+A8fcZmKkDvpQKzaWa9+mc+htyPig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=icef294kkruWRXl2/+q0RyeF79bvK7rc8WOf5zK3biPrh8xl7rpOND23w2X7RK/Kz
	 p75ETSj/CvnI1ikFxVrYQkKZKjTUHwK0acjhW7Tsb67GcbdDjoBxUqs7iZJV6md0WK
	 2ZkbZrrrqDw/rakRx5ohjsYlLbnla7I24l/IoSybsBFNFMOvKET9VvWEoxUDAx04zc
	 ECsTeHYiNok2sguU8mAIopVoKasnM9cJvvQ9Mf1xvK1j9yCgJ9FGq0YcbvzNZ5XI2I
	 67TCsX3TH/6h5TCr5gsO8nTViwwoF8ZPpfjU79xBqyn76Cf0GsSEp6cf3D+HalKiZw
	 B9NtuwlqT5hpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 03/15] bpf: Add bpf_struct_ops accessor
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623175006.3136053-4-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
 <20260623175006.3136053-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:40:54 +0000
Message-Id: <20260623214054.909821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added bpf_struct_ops_kdata_map_id function is an exact du=
plicate of the pre-existing bpf_struct_ops_id function.
--

commit d1f80ae7e459b35d14e3b364a031f8d29bf9da8e
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Add bpf_struct_ops accessor helpers

This commit adds several helper functions in bpf_struct_ops.c to be used
for creating a struct_ops to cgroup attachment link. It also refactors
link update validation into a reusable function.

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index c422ce41873ee..1ca44584ed17c 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c

[ ... ]

> @@ -1236,7 +1236,33 @@ int bpf_struct_ops_for_each_prog(const void *kdata,
>  }
>  EXPORT_SYMBOL_GPL(bpf_struct_ops_for_each_prog);
> =20
> -static bool bpf_struct_ops_valid_to_reg(struct bpf_map *map)
> +void *bpf_struct_ops_map_kdata(struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map;
> +
> +	st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> +	return st_map->kvalue.data;
> +}
> +
> +u32 bpf_struct_ops_kdata_map_id(void *kdata)
> +{
> +	struct bpf_struct_ops_value *kvalue =3D
> +		container_of(kdata, struct bpf_struct_ops_value, data);
> +	struct bpf_struct_ops_map *st_map =3D
> +		container_of(kvalue, struct bpf_struct_ops_map, kvalue);
> +
> +	return st_map->map.id;
> +}

[Severity: Low]
This isn't a bug, but does bpf_struct_ops_kdata_map_id() duplicate the
pre-existing bpf_struct_ops_id() function?

Looking at bpf_struct_ops_id() which is already exported in the same file:

u32 bpf_struct_ops_id(const void *kdata)
{
	struct bpf_struct_ops_value *kvalue;
	struct bpf_struct_ops_map *st_map;

	kvalue =3D container_of(kdata, struct bpf_struct_ops_value, data);
	st_map =3D container_of(kvalue, struct bpf_struct_ops_map, kvalue);

	return st_map->map.id;
}

Both functions perform the exact same series of container_of macros to retr=
ieve
the id from the map field of a bpf_struct_ops_map. The only difference is t=
he
parameter type (void * vs const void *). Could the external caller directly
invoke the already exported bpf_struct_ops_id() instead of adding this new
helper?

> +
> +void *bpf_struct_ops_map_cfi_stubs(struct bpf_map *map)
> +{
> +	struct bpf_struct_ops_map *st_map;
> +
> +	st_map =3D container_of(map, struct bpf_struct_ops_map, map);
> +	return st_map->st_ops_desc->st_ops->cfi_stubs;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.3136=
053-1-ameryhung@gmail.com?part=3D3
