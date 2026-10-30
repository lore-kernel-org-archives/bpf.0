Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362385;
	b=ymPySHLl9aDOdG/kG3Hmylgl9blolqVD2W9nL8zdfr/z3YAgtIsw62AaIfuPjVQToZZK
	 HU0/vvWSiMDsmN4K1ZpiG0G6/g6YH1H0OoNu8HJUEsHxIgbZdv3rMBS8i3D+zxzT0OA9z
	 461KPIzbL74NcCE5Q7QcSUZcDcd4mEdMNd1eR8fG8XvYGjrFI+V283hv9c9h5O2XaivpK
	 iRLI++yRft2MXVg6Y2AzuLzpSsH6+VjDi44dx1mZGNhe0Bte05lx0+ceONsRsTW1XmSd8
	 80XZ4Dh1qsx7k6lNLqMEC7NrEqzd3lxRZh7DlwE+FAza5mLYx3JDvFcD/6nueey/QDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f2m0OoQ7+fZDkv7a5+IsOODIy9a+e/4AwgDVcbjlvpU=;
	b=JurmvvNmXeaj0byev3jxyLh+7GqC5uZBxptk/caZrRj9Xz1ruYx8ags3u25yzc7BBwFZ
	 zmA8JYuu57qcL2Gi3rgSNHdIAvgriCpquE88s/SD33pjgDJBAwDCR8gY0gGgajb43Qegw
	 QIywtRT4YrAYM/YyAIQBN9uws0fSon4WJz3GpC06nmU5Ac7nuxF55JzEEDi04wbwpLQ6u
	 cHbr6Lx74Z+BeL+Qw0ZWIoVCZDyROoUqYtguxWrgzRSKM3uxg+GlGdGf+YI67QbO7VsiO
	 KCgFcAfSypr4+EKYh4naebOb6S8yjcldL3ps0ae3SLHpIvICiVMerwMT85LZJ0buUyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXN5nFpQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C889E606A320
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXN5nFpQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FBB1F00A02;
	Fri, 30 Oct 2026 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793362384;
	bh=f2m0OoQ7+fZDkv7a5+IsOODIy9a+e/4AwgDVcbjlvpU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GXN5nFpQbkwXpcFXeFGchXswF+/YUrtUX17gQjrKgL8IudVxFwPPUWfNcCotX8+OH
	 Pk02dwNGnyG2KVLmHw+OmMOO1bMWBQdbJAU2Ovzma+6kQzbEaKgl989dvFfWusKOWo
	 m9Xv4YYVPZDmYqQiuEXsa7IzZ6GZFNoxZt3oLXSqpUXlYc45XzLbBchJQ9tZp0mMWD
	 ub6IGYK0zTinPWjwVrBESCEeWZxIPFWcVd2zrhG/JH4ts+irIdCsN6vh2oJ2GQZeBV
	 cbJUpypD1zhe41LQu1j6jh6CBaXR34NRDRAaLTmSpuTDLW2hfTRlCR5CNiCJ4ZzI9Q
	 zCIhzHov/HgJQ==
Message-ID: <sashiko-outbox-190999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Cover concurrent sockmap
 update and delete
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261030-bpf-next-v1-1-035eabf8eae7@cloudflare.com>
References: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
 <20261030-bpf-next-v1-1-035eabf8eae7@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 12:13:04 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] selftests/bpf: non-standard multi-line comments in sockmap_listen.c
- [Low] selftests/bpf: deprecated CHECK_FAIL wrappers used in test_update_d=
elete_with_prog()
--

commit c179b4e18de0bb4b1070c566c62402a2a9a2d3f1
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Cover concurrent sockmap update and delete

This commit adds a sockmap_listen subtest that concurrently inserts and
deletes a TCP socket in a sockmap with an attached verdict program to
exercise races between insert and delete paths under KCSAN.

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/to=
ols/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 235e1d56f044f..dca1f0de92e0e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -646,6 +646,82 @@ static void test_race_insert_listen(struct test_sock=
map_listen *skel __always_un
>  	xclose(s);
>  }
> =20
> +struct update_delete_ctx {
> +	unsigned int nr_iter;
> +	unsigned int done;
> +	int mapfd;
> +};
> +
> +static void *delete_elem_thread(void *arg)
> +{
> +	struct update_delete_ctx *ctx =3D arg;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ctx->nr_iter; i++) {
> +		/* Expecting EINVAL (sockmap) or ENOENT (sockhash) when the
> +		 * entry is already gone.
> +		 */
> +		if (bpf_map_delete_elem(ctx->mapfd, &(u32){0}) &&
> +		    errno !=3D EINVAL && errno !=3D ENOENT) {
> +			FAIL_ERRNO("map_delete");
> +			break;
> +		}
> +	}
> +
> +	WRITE_ONCE(ctx->done, 1);
> +	return NULL;
> +}
> +
> +/* One thread keeps inserting a socket into a sockmap with an attached
> + * verdict program while another thread deletes the same map entry.
> + */
> +static void test_update_delete_with_prog(struct test_sockmap_listen *ske=
l,
> +					 int family, int sotype, int mapfd)
> +{
> +	struct update_delete_ctx ctx =3D { 0 };
> +	int err, s, verdict;
> +	pthread_t t;
> +	u64 value;
> +
> +	verdict =3D bpf_program__fd(skel->progs.prog_skb_verdict);
> +	err =3D xbpf_prog_attach(verdict, mapfd, BPF_SK_SKB_VERDICT, 0);
> +	if (err)
> +		return;
> +
> +	s =3D xsocket(family, sotype, 0);
> +	if (s < 0)
> +		goto detach;
> +
> +	err =3D xlisten(s, 1);
> +	if (err)
> +		goto close;
> +
> +	ctx.mapfd =3D mapfd;
> +	ctx.nr_iter =3D 10000;
> +
> +	err =3D xpthread_create(&t, NULL, delete_elem_thread, &ctx);
> +	if (err)
> +		goto close;
> +
> +	value =3D s;
> +	while (!READ_ONCE(ctx.done)) {
> +		/* Expecting EBUSY while a deleted socket's psock still
> +		 * holds the verdict program.
> +		 */

[Severity: Low]
This isn't a bug, but should the three new multi-line comments in
delete_elem_thread() and test_update_delete_with_prog() in
tools/testing/selftests/bpf/prog_tests/sockmap_listen.c place the opening
/* on its own line with the comment text starting on the following line to
match BPF coding style conventions?

> +		err =3D bpf_map_update_elem(mapfd, &(u32){0}, &value, BPF_ANY);
> +		if (err && errno !=3D EBUSY) {
> +			FAIL_ERRNO("map_update");
> +			break;
> +		}

[Severity: Low]
In tools/testing/selftests/bpf/prog_tests/socket_helpers.h, FAIL_ERRNO()
and the x* helper wrappers (such as xbpf_prog_attach(), xsocket(),
xlisten(), xpthread_create(), xpthread_join(), xclose(), and
xbpf_prog_detach2()) report failures through _FAIL(), which expands to the
deprecated CHECK_FAIL() macro:

#define _FAIL(errnum, fmt...)                                              =
    \
	({                                                                     \
		error_at_line(0, (errnum), __func__, __LINE__, fmt);           \
		CHECK_FAIL(true);                                              \
	})

Could delete_elem_thread() and test_update_delete_with_prog() in
tools/testing/selftests/bpf/prog_tests/sockmap_listen.c use the ASSERT_*()
macros from test_progs.h (such as ASSERT_OK(), ASSERT_OK_FD(), and
ASSERT_TRUE() or ASSERT_EQ()) instead of FAIL_ERRNO() and the CHECK_FAIL()
wrappers when checking setup and map update/delete results?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-bpf-next-v=
1-0-035eabf8eae7@cloudflare.com?part=3D1
