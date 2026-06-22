Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5992E54AA
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140925; cv=none; b=MCx1iGFndwcD4oYx7RaOTfFkn6al9Uclim4PekdlOEzNJLf9RQHJd60wQjBqLtomSPnQZCXNkYims+rffeZk+tB1fLREwLhmmYzq+oowh7lgQqfLM+j+U+dlN+YbWcduhFcgeuMKxwi14vpkjspSmDlwys0leyflONyTBjbxel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140925; c=relaxed/simple;
	bh=0PqXJOXeKpliZcFQGc61Fv+QFv2ns4dNkmObq4NakMo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lpDPrFu0d2bjceduaID8mheW2uJdTVWnTLIK/j2/3nYYRPEhIZbp1jZDoPzruG9S3jRSNhOo8pKlYrBDukVKjKYqsD0MvYDbBd0DZbtpsjN4QWp5gCmAsQqdssKuvhStgp4xxG9pjI+BfQU6HfiFZhQG35Q2Vbh3c8/K5SieojE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIGdAJH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIGdAJH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C551F000E9;
	Mon, 22 Jun 2026 15:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782140924;
	bh=cMpNLZPTCvczajARCE0MYX5KR1FOR1qU0s8PmbPY5Ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FIGdAJH8tcjXI8NL5qrA+A6lpHmEobzF6/3DW8uswXwf1K0QSgrxtih7XiVK2yi1x
	 jR5/tBn6QYy6gNfmVu/VlwY5IKMnKgcaDnTvAKabqsDky+w8pfTGiXoTpxQzcTiKPK
	 cnzWURdP1NPysWacWNybkD1pU767GoicgAb2+ObtU+X289lugxITWwnLMCVls4VnqN
	 9Et8XdCnNE4K5FC5bNKKp/4LU86FgrQgO7fENUimIHoV/UTnHh0nQWuNluYTxJUKIX
	 AmA1rrWMK4RiqzduZkFj2ak3SqP+gOJxCF6ihQdQAaUx4D3YzpxGx8ILQgU0gtHrK2
	 iklQqpVJ0pBpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 11/11] selftests/bpf: Add test to verify
 bpf_iter for global percpu data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260622143557.22955-12-leon.hwang@linux.dev>
References: <20260622143557.22955-1-leon.hwang@linux.dev>
 <20260622143557.22955-12-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 15:08:43 +0000
Message-Id: <20260622150844.28C551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized kernel heap memory leak in per-CPU maps via bpf_iter=
 and BPF_MAP_LOOKUP_ELEM due to padding bytes not being zeroed.
--

commit a629f2d1587e23ca18c8365ab951d5623f170340
Author: Leon Hwang <leon.hwang@linux.dev>

selftests/bpf: Add test to verify bpf_iter for global percpu data

This patch adds a selftest to verify that a BPF iterator can safely iterate
over the percpu_array map used for global per-CPU data. It introduces
test_global_percpu_data_iter() in global_data_init.c and an iterator
program dump_percpu_data() in test_global_percpu_data.c.

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index e4c290492ff8a..32734e1dbfb00 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
[ ... ]
> @@ -279,6 +279,56 @@ static void test_global_percpu_data_verifier_log(voi=
d)
>  	RUN_TESTS(test_global_percpu_data);
>  }
> =20
> +static void test_global_percpu_data_iter(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	struct test_global_percpu_data *skel;
> +	union bpf_iter_link_info linfo =3D {};
> +	struct bpf_link *link =3D NULL;
> +	int fd, num_cpus, len, err;
> +	char buf[16];
> +
> +	num_cpus =3D libbpf_num_possible_cpus();
> +	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
> +		return;
> +
> +	skel =3D test_global_percpu_data__open();
> +	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
> +		return;
> +
> +	skel->rodata->num_cpus =3D num_cpus;
> +	skel->rodata->offsetof_num =3D offsetof(struct test_global_percpu_data_=
_percpu, struct_data);
> +	skel->rodata->offsetof_num +=3D sizeof(skel->percpu->struct_data) - siz=
eof(int);
> +	skel->rodata->elem_sz =3D roundup(sizeof(struct test_global_percpu_data=
__percpu), 8);

[Severity: High]
This is a pre-existing issue, but does iterating over per-CPU maps expose
uninitialized kernel heap memory?

When working with per-CPU maps, temporary buffers are allocated using kmall=
oc
without the __GFP_ZERO flag in functions like bpf_iter_init_array_map in
kernel/bpf/arraymap.c:

kernel/bpf/arraymap.c:bpf_iter_init_array_map() {
    ...
    value_buf =3D kmalloc(buf_size, GFP_USER | __GFP_NOWARN);
    ...
}

This is also done in kernel/bpf/hashtab.c:bpf_iter_init_hash_map().

If the map contains a BTF record, bpf_obj_memcpy in include/linux/bpf.h
explicitly stops at map->value_size instead of filling the entire rounded-up
size:

include/linux/bpf.h:bpf_obj_memcpy() {
    ...
    memcpy(dst + curr_off, src + curr_off, size - curr_off);
    ...
}

This fails to overwrite the padding bytes up to round_up(map->value_size, 8=
).
Because the BPF verifier allows the iterator program to read the entire
round_up(map->value_size, 8) * num_possible_cpus() bytes, the uninitialized
padding from kmalloc is exposed to the BPF program.

Similarly, in kernel/bpf/syscall.c:map_lookup_elem(), kvmalloc is used
without zeroing:

kernel/bpf/syscall.c:map_lookup_elem() {
    ...
    value =3D kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
    ...
}

This means sys_bpf BPF_MAP_LOOKUP_ELEM also copies this uninitialized paddi=
ng
back to user space via copy_to_user, causing a direct kernel heap info leak.

Could this be addressed by zeroing these allocations or ensuring the paddin=
g is
cleared when copying map values?

> +	skel->percpu->struct_data.nums[6] =3D 0xc0de;
> +
> +	err =3D test_global_percpu_data__load(skel);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622143557.2295=
5-1-leon.hwang@linux.dev?part=3D11
