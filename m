Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651A82898
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063843; cv=none; b=fcWV+88XbUijyoZAmc5APeY5mOB/hm/3iW4qyrdAngEdNW62swr+Eu2OSdX455zHA0jb7PfF98WYb70cL0MZag7cJsPairQx8AU4hnjNOzwzX2kqVLNFm8i+fGVGyETtxwaQqwn07QRAuMm8dbYdqPC/SMQV6IvlmvAyMC3lcvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063843; c=relaxed/simple;
	bh=8zNR+Yi+Mcvs6NrMFPw3NO9Lpyr5aMndpVvjpp6MS14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N09wCXGVISz4m6WI4eW//BVrNIgN0l9islb98MSdnF9FRty7JKQEX6u2SsQ1drEagXaEX4/uTCjnUSGwCysEhwqIMKFx+aNxG8vO7dH21unmD5EqnZ38OD4uGX8LI0d1/+d/eBxKVCT9UeI1YZLa8XHPHoQcI5VhcevVHOhUU90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1zgGgM/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1zgGgM/"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c404da0ebso7462781a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712063840; x=1712668640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SWHmg47IgG1Y41rNorn1RZaS/aNyAUpkqyL5lq3HIJk=;
        b=R1zgGgM/cJF9SDR6ut+4rzK55IHbb9TsCmCNxxn0HST9lfBi8GgWo0kPzxTu4Uiz9K
         G4U5WHb867Q2Q9ruG+TDyRmH0GpwjZMXbWYasnSVXH86W3GrkKW6aAN+ONQtwx44GEVO
         5w3b8mPLkj/JL8f522i9+f8wnIAxjGHTpAKkxGOwan5j88jEh7YwdQ6evwmUVVTnb9Yy
         nOHqVz3+OsVOjm2+7XFidJkdsRP7XzTcpJxNS8MIwlRGV7URgzL9ttK9Xj90m1ARjtJ2
         yMJApbHhlJL0FajoMm3q+Rbe0b+VIzlgLG4IBLEQIGIZIohSaIaRKvL6IdfHpj0/+o3Z
         YtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063840; x=1712668640;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWHmg47IgG1Y41rNorn1RZaS/aNyAUpkqyL5lq3HIJk=;
        b=f1j76lLB6fCMYr8wD294EcvzCzK0hzvLYgcf3IcERUcV65b55bUeRIkice8omvk6b+
         bZPAW4Nzp6205ur5BygOX6v5ZrBTe9QcfJraOEp8iYhbxS9hPxlVfggxissfMe4k9gTR
         bceTJ0cIAwQD4YdwJ0D/l5KUoFGfMZ71HmeuQNpVM5Kx0LJH43fRwTlZUQHJ09jjbGwm
         AQlx+wBP/0Kp6M2UPOowoO74AiKzfC9pYdH4Rk2PFVLUlGMg+pDdFO+qEvitrSeW5KKm
         yXSRjKwU9JuxOlC632Vew2t0PxLuDpdY+Myy0UU5xcqlKdevMHHGKTzXiqgxGQVrQiKu
         FwLw==
X-Forwarded-Encrypted: i=1; AJvYcCVDaTX3zRBDbhOA0ZrVli+RzB9KenBKp3SSTV1n0o4NLGtZmmKpjne1Lhs+/F3JSlKorblHX2T2fmf/4PkNRAgfmRmM
X-Gm-Message-State: AOJu0Yx/508GszB9wLc6RlzB4dQKUTkhn3/7XF9FUGZFlBdkZNaSus3I
	gtKvKhS3BxMaP4FDDsU2hqrIoRtOvS16DF4Vrb4vo6AVQrPj5GgK
X-Google-Smtp-Source: AGHT+IFo8XWZ6rpAYCn1/Ou8dyVfnu+ngtmkIMJVlGUUrv1g7Sc3wc3skSqaBVDKeYHLVdEf6urebA==
X-Received: by 2002:a17:906:d8e:b0:a4e:2419:d51c with SMTP id m14-20020a1709060d8e00b00a4e2419d51cmr8383585eji.51.1712063840282;
        Tue, 02 Apr 2024 06:17:20 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id bn8-20020a170907268800b00a4e6582edf8sm2854591ejc.102.2024.04.02.06.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:17:19 -0700 (PDT)
Message-ID: <2befbceb5be18eeee6f3376a1bf5b2d795beec53.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/5] selftests/bpf: Add some tests with new
 bpf_program__attach_sockmap() APIs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Jakub
 Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Tue, 02 Apr 2024 16:17:18 +0300
In-Reply-To: <20240326022219.657808-1-yonghong.song@linux.dev>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
	 <20240326022219.657808-1-yonghong.song@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 19:22 -0700, Yonghong Song wrote:
> Add a few more tests in sockmap_basic.c and sockmap_listen.c to
> test bpf_link based APIs for SK_MSG and SK_SKB programs.
> Link attach/detach/update are all tested.
>=20
> All tests are passed.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

As far as I understand patch #1 there are several error conditions
that are not covered by these tests:
- update link using program with wrong expected attach type;
- bpf_program__attach_sockmap() _after_ bpf_prog_attach();
- creation of a second link between same prog and map
  (if I understand 'link && link !=3D progs->msg_parser_link' checks in
   sock_map_link_lookup() correctly).

Are these important enough to have a dedicated test?

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 63fb2da7930a..b4b38f92b864 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -131,6 +131,40 @@ static void test_skmsg_helpers(enum bpf_map_type map=
_type)
>  	test_skmsg_load_helpers__destroy(skel);
>  }
> =20
> +static void test_skmsg_helpers_with_link(enum bpf_map_type map_type)
> +{
> +	struct test_skmsg_load_helpers *skel;
> +	struct bpf_link *link, *link2;
> +	struct bpf_program *prog;
> +	int err, map;
> +
> +	skel =3D test_skmsg_load_helpers__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "test_skmsg_load_helpers__open_and_load"))
> +		return;
> +
> +	prog =3D skel->progs.prog_msg_verdict;
> +	map =3D bpf_map__fd(skel->maps.sock_map);
> +
> +	link =3D bpf_program__attach_sockmap(prog, map);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_sockmap"))
> +		goto out;
> +
> +	err =3D bpf_prog_attach(bpf_program__fd(prog), map, BPF_SK_MSG_VERDICT,=
 0);
> +	if (!ASSERT_ERR(err, "bpf_prog_attach"))
> +		goto out;
> +
> +	link2 =3D bpf_program__attach_sockmap(skel->progs.prog_msg_verdict_clon=
e, map);
> +	if (!ASSERT_ERR_PTR(link2, "bpf_program__attach_sockmap"))
> +		goto out;

Nit: should bpf_link__detach(link2) be called before 'goto out' ?=20

> +
> +	err =3D bpf_link__update_program(link, skel->progs.prog_msg_verdict_clo=
ne);
> +	ASSERT_OK(err, "bpf_link__update_program");
> +
> +out:
> +	bpf_link__detach(link);
> +	test_skmsg_load_helpers__destroy(skel);
> +}
> +
>  static void test_sockmap_update(enum bpf_map_type map_type)
>  {
>  	int err, prog, src;
