Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A33DB62B
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 15:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329518; cv=none; b=bJ5GPZbhuA1f8AgBNWORfbU8oJsX/2ZNM6CHVvyo0LETLP1yU5rKH/D+bEWr6YthXwBw//1Le7mDo9PzQSLS3jbsAFewVTzd6qHg4SyDoXUBercl6M86BvYDBWTjeq8VBe4h2Bd/TR5+Oh7Z/ovAnLpyvSg4TbqcgTtOrBFtWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329518; c=relaxed/simple;
	bh=qIcgFkKMx9QeSgr8ty91gm/JXMlrtZXaVkZ4yJ8YMgI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uuyd8sVY80gSlGotsE4qSLI0VyXftS3K5HkFFJ9MTDIJCiT1HoIcVynZeTd0jaLqQTXhvrHhqRaMnLLAh6dsbaGLyIzeLBvHSkdjpyj3FyDyCMzI7iqY3M6dm1kVzytwERFUyQlyQ9aHGkbtM1vhJBt9umK7ccuuKDfLruY5yiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jD+6qBht; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD+6qBht"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D8C1F00893;
	Mon,  1 Jun 2026 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780329515;
	bh=Joao1te7hTrLmAyeGbs0h9HXnqi8zOjupjLbQLoDXfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jD+6qBht9DvR8ZPSe7OjmkHGRbYYwuVRNvCzZJZRSXYxob8rZBp65u+mlBSWXi/Z8
	 CxcOHEOQ0bqO1tX5GPuJAkgSLHLww0ixq5JesfAFhw8pfT+wp1o7tj4Yy/cTCoKabf
	 ix0TEMHanciL5DU5DUftvr8k0fdFzup+Msw155jJLOwPRYUuIXAC7R3O+mbjxC2mMr
	 lvL5otAjke56ch3Z5ov/NJOlFhIB463WjQJIRHWknfFLI1E6L3uCcvHc8rc+gETYcq
	 gltm6qZrMOo9R2LXOLTGh93wqHhl3tebeocpqrOn7clxIAbzOjC2CHLggQ6QkBHYEX
	 KZ1MySvuuaKpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/7] libbpf: Skip initial_value override on
 signed loaders
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260601150248.394863-5-daniel@iogearbox.net>
References: <20260601150248.394863-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 15:58:34 +0000
Message-Id: <20260601155835.53D8C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in `add_data()`'s `roundup(size, 8)` can cause a =
massive out-of-bounds `memcpy()`, leading to a heap buffer overflow.
--

commit aaabe67208a39bc461c4602ad17bdd3b78f93227
Author: Daniel Borkmann <daniel@iogearbox.net>

    libbpf: Skip initial_value override on signed loaders

    bpf_gen__map_update_elem() emits code that, when the host-supplied
    loader ctx provides a non-NULL map_desc[idx].initial_value, overwrites
    the blob value with bytes read from the host (bpf_copy_from_user /
    bpf_probe_read_kernel) before the BPF_MAP_UPDATE_ELEM that populates
    the program's .data/.rodata/.bss maps. This override runs after
    emit_signature_match() has validated map->sha[], which lets an untrusted
    host substitute global-variable contents. This patch skips emitting the
    override for signed loaders.

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 66a02039da8ce..a5d9c7a5261b0 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -1187,27 +1187,36 @@ void bpf_gen__map_update_elem(struct bpf_gen *gen=
, int map_idx, void *pvalue,
>  	value =3D add_data(gen, pvalue, value_size);
>  	key =3D add_data(gen, &zero, sizeof(zero));

[Severity: High]
This isn't a bug introduced by this patch, but could this call to add_data()
lead to a heap buffer overflow if value_size is extremely large?

Looking at tools/lib/bpf/gen_loader.c:add_data():

static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
{
	__u32 size8 =3D roundup(size, 8);
...
	if (realloc_data_buf(gen, size8))
		return 0;
	prev =3D gen->data_cur;
	if (data) {
		memcpy(gen->data_cur, data, size);

If a large size is passed (for example, 0xFFFFFFFC), the roundup(size, 8)
macro would evaluate to size + 7, overflowing the 32-bit unsigned integer
and wrapping around to 0.

This would cause realloc_data_buf() to successfully resize based on the
wrapped size, followed by memcpy() attempting to copy nearly 4GB of data
out of bounds.

Can a maliciously crafted BPF ELF file trigger this integer overflow during
skeleton generation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601150248.3948=
63-1-daniel@iogearbox.net?part=3D4
