Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792582739;
	b=ZjFwoFWkzxrp9FIfPlTVJ/rEWwOUPlXEdxSAbV3ff4dSt9ofn9ZLzGxXK9xrqjOO5yFh
	 LoDdJn5xeDkGhnLsXhmLOLupswihV2kpcVjQb9SGfnvT50gvr82xOQRgKYDoonYjNSOSQ
	 gPcr3GS2KajxUL726GzTAl7f0RYsu3CHe5+uzQzKpHDw9jErdilFZhoBEPkG/J/Q/VK7d
	 iLC60q0dPUVd5JA2b2vjevPMy3uG/Bns9bP6D5G5whtMHOwr+U3L9m5HHu0Fk/LlTZ0JF
	 wjTgwtlMESQbX21uouorFzfbIrajVBG2/h/I6gPYwkvsAw1ju++i8RN8Y427E7nuu8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582739;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GtuTGfWk3H7E1gbYASmMIdUVMADE1R3RABXKZ9cs/xk=;
	b=TDCviE8Dmk66ZNJBYEodHd9fL3cTwK2EtTle3gHtk/XYJqpT10EI1xtQI4VIlLDDyJdO
	 ocVSeIFuDCCbmK10An6x3kzbQIQtUIGJyc0c3dLFs1/qEOJle3nH+5KtUEjJ2v+FwbYKD
	 5rKzldNuBHuRnM16k/E87zV8/XL1X1ikc94yeZZOs3WjHaqb4IVtRkLEVgk+7katAsxOG
	 uPdWEqlHHb3syu4NNUBfkUelSwgxgRC3187YozwRtf3IJHZ7AZNcbYfdSw6uhY/6kTpUZ
	 KbBeNI0+eBT4khSUKZN4cwPNAhviPCpS7t6fw6sEyr3XHVF9tscfhSpbVDea3DSNcwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kz5/tDiu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F4606A331
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kz5/tDiu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3D61F01579;
	Wed, 21 Oct 2026 11:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792582738;
	bh=GtuTGfWk3H7E1gbYASmMIdUVMADE1R3RABXKZ9cs/xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kz5/tDiuq8Zp96IVC2XIiPJGHoX+4gpgay7d0oEStfPLTU2WdUQTRgl1/EF1yoL0O
	 BU7irob0rKb3sMVDKzMRpIZs7GvhX3Ayu3OQf8z24V8lqQlnUkb6vSsV6V1iO1PTal
	 2WIyuUHLRX3g8T3i7fIc/icxzDroFXTTZxX6bGgQhbAJW7vma2lGUqci7DlhPF9Eh1
	 VhktQ7JzWWWXBUBH3XxR7xxFb+Cw9hj6bqf1xYb50wxzrMAsSK9/pZ5BPX3DjHaAck
	 Se2gn6259qUjypwwgez01jWaRFWrtB7zGEfTWYzVlsKdxq2/r0iUiW9A9w/I+Nd8Rf
	 Tu90+yQSyJ59A==
Message-ID: <sashiko-outbox-180173@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] selftests/bpf: add tests for the page_owner
 bpf_iter target
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261021112437.1799213-8-zhen.ni@easystack.cn>
References: <20261021112437.1799213-1-zhen.ni@easystack.cn>
 <20261021112437.1799213-8-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 11:38:56 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: ASSERT_OK_PTR() on strstr() and strchr() passes o=
n NULL
--

commit c911a68fd56ba0ae206e2cf17e238a8881f03bd2
Author: Zhen Ni <zhen.ni@easystack.cn>

selftests/bpf: add tests for the page_owner bpf_iter target

This commit adds a sleepable BPF program and a userspace test runner to
exercise the seq_file and open-coded page_owner BPF iterators and their
associated kfuncs. It also enables CONFIG_PAGE_OWNER in the BPF selftests
configuration.

> diff --git a/tools/testing/selftests/bpf/prog_tests/page_owner_iter.c b/t=
ools/testing/selftests/bpf/prog_tests/page_owner_iter.c
> new file mode 100644
> index 0000000000000..3684ca3089355
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/page_owner_iter.c
[ ... ]
> +/* Validate bpf_page_owner_get_memcg_info() results from the open-coded =
run. */
> +static void check_memcg_skel(struct bpf_iter_page_owner *skel)
> +{
[ ... ]
> +	if (skel->bss->memcg_first_name[0])
> +		ASSERT_OK_PTR(strstr(skel->bss->memcg_first_path,
> +				    skel->bss->memcg_first_name),
> +			      "memcg_name_in_path");
> +}
> +
> +void serial_test_page_owner_iter(void)
> +{
[ ... ]
> +	ASSERT_GT(skel->bss->stack_bytes, 0, "stack_snprint_ok");
> +	ASSERT_OK_PTR(strstr(skel->bss->stack_text, "+0x"), "stack_frames");
> +	ASSERT_OK_PTR(strchr(skel->bss->stack_text, '\n'), "stack_lines");

[Severity: Medium]
Will these ASSERT_OK_PTR() checks in serial_test_page_owner_iter() and
check_memcg_skel() in tools/testing/selftests/bpf/prog_tests/page_owner_ite=
r.c
actually catch a NULL return from strstr() or strchr()?

In tools/testing/selftests/bpf/test_progs.h, ASSERT_OK_PTR() checks the
pointer via libbpf_get_error():

    #define ASSERT_OK_PTR(ptr, name) ({                                 \
            static int duration =3D 0;                                    \
            const void *___res =3D (ptr);                                 \
            int ___err =3D libbpf_get_error(___res);                      \
            bool ___ok =3D ___err =3D=3D 0;                                =
   \
            CHECK(!___ok, (name), "unexpected error: %d\n", ___err);    \
            ___ok;                                                      \
    })

And in tools/lib/bpf/libbpf.c, libbpf_get_error() returns -errno when
given NULL:

    long libbpf_get_error(const void *ptr)
    {
            if (!IS_ERR_OR_NULL(ptr))
                    return 0;

            if (IS_ERR(ptr))
                    errno =3D -PTR_ERR(ptr);

            return -errno;
    }

Because strstr() and strchr() do not set errno when returning NULL on a
non-match, if errno is 0 after bpf_prog_test_run_opts() succeeds,
libbpf_get_error(NULL) returns 0 and ASSERT_OK_PTR() silently passes even
when "+0x", '\n', or memcg_first_name is missing.

Should these checks use ASSERT_NEQ(..., NULL, ...) instead?

> +
> +	check_memcg_skel(skel);
> +
> +destroy:
> +	bpf_iter_page_owner__destroy(skel);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021112437.1799=
213-1-zhen.ni@easystack.cn?part=3D7
