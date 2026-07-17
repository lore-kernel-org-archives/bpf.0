Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408C3AF64F
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329896; cv=none; b=nFQL/nhmLbMX147qQDePPUUOw8bN8//H0F74HAp30YnuzZyJthXpKXFPkjYfCThekBUhdXfo6gUSKpX4vew5OR2fSlgY87zZBk4I7crXQM20d16AlQHORuTNlSB/C5dlsJUNLyvzRIh62fACAmk4nuYNP0KADhpbLi91pp/YIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329896; c=relaxed/simple;
	bh=H9UBDqh2kye2P4CnU7T5hCf2ZYmDRXhCPHDbQmPuU8E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q3JlSi0GGMiuWKrM6/an906/6wQyRmeIODACGTi2VsuebzUumNID37q1SAQqyK8MiUiYJsPqP8Zjq2DpPWOtpkpljAQn9R59F0rvKClcodyE4tc/2c+5RminKYhnQOr1/a4v/HWbEAGYqqCST29pvLwt18eTTSz8pPr8En2/4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=rabvkiyb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="rabvkiyb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c7c61b5292so66277285ad.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 16:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784329894; x=1784934694; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WBevWLdm6MxRo3Qt2s9YR+iZOicNvJuxTFHEz0+pwEw=;
        b=rabvkiyb/qrWXb9pg2utm8nZR8lZ2Bw5oy1pDwBbtde7RiyxyHXwZRgk2gZnl6IQhg
         PnY+Cu0fx3HGk+SRulA2qS1K1hUpNeVjU4FzpRDBQzaZjgPb5j7Ahr7IkQ59jMOLM4Ef
         xZg4JkPSoqVriwArVfu3W/AvZLj7WXCb0YPVasM7neTkdM0pdFBp6C0TiD/8WpG40qCG
         j3RH0Irlw/xIl1j1d1TICdPRY9wn9eFFIyVkIMqeTkPvuBRu6JBmFe+SHWL1GUKIoD+2
         qYF7TzknM9Tsto9GC5FAulZ7J2NJg3dwT4c8ZD5T6zaUdPgzAxB+/auVYst90beAwQCG
         TFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784329894; x=1784934694;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBevWLdm6MxRo3Qt2s9YR+iZOicNvJuxTFHEz0+pwEw=;
        b=osj5FXJCEAOu8vueHoKIaDwmLm6tQxhW1GmhwHYpJZS/FRy01sa9URrWZEibEOoK6N
         BmJrOiM9GCE8zrwHkN20T4qNGe3PjHg6Xaf2pY05XLlsLZB0vDGkYRURry101xlY1L/D
         cn8uBFdRF17OUl5BPCShrNniOjaOaCAcSFpNJGO5tdGtz6yYTpX0AeW7wjXb7DJKaz8N
         vLu8JxwlCXRE8sj4vcTc8hFU6NzfvDnExKY4RZsIkJHjwzEqOBoPtdjzlm/1Spz5FL6y
         yJUChf96g368Xgp+qFg+ubEDy9mDQW7CrYi9EboXwjwYwKt8cYTrzP6Xqw2Rrrl/pDde
         qy+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqsUVbs/CjrYvEPr+knC8jtkKegLK7CZJfCiP3W1FZKsJ0rBxBa270ij+3bSzdQqUmKPQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywya/uM4JoNT0FvTNHb6OpdraP7w4mLAT0d0KDWfQywiSnqh2Lo
	le/2gOLqAwLy53YuXhPNCSNiVmsRSn3reJOdxuklB1zjpfYHNFccRy8LKC8mp1ZXO8g=
X-Gm-Gg: AfdE7clhjSEKNE+d9xHykYVCpBE/6QFMtXA8CfUoAdbiQQE0T61Bs+ajk+X7/osUOVY
	QsXTwR/K9xkiCoNtohx+RExmjXEC2ohTOc5CbWCN9rHNYcvRQQ6hafZ5gTRRMLZ8wyAdgVChnXQ
	W5d5Bp0++c0M5Y97ikebC2TRHT3FOetJo6QJk44hn0KZ4X/HQOuBcTigUcYdICzbLTTHSbsSnoJ
	/4byXnW9T5HtQTOu+7bEUQX0DvcIOsnIq9vdCdryw2Lf7LWhtY+B6vWEmkA7nEgbxKxUU/hfZSC
	17hUOFTqd5VMwBI4zK4BdwbqeUAzE33JYCPsdsIv6VQ3hIlX/ELnHbp3DKPvMtMAwqhWwGuCfHN
	7S3OT7utMKIkvNNN7jDBelI8+e+J8wN4apfaLZbjGJGNc4bYhsfI/A20aAXw=
X-Received: by 2002:a17:902:ec8e:b0:2c9:e961:d256 with SMTP id d9443c01a7336-2cf3494afcemr48411825ad.27.1784329894026;
        Fri, 17 Jul 2026 16:11:34 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::f5f9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34783112sm18615035ad.79.2026.07.17.16.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 16:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 19:11:29 -0400
Message-Id: <DK185N1NAAK0.31748Q1HZYORN@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Quentin Monnet"
 <qmo@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <kernel-patches-bot@fb.com>
Subject: Re: [PATCH bpf-next v10 9/9] selftests/bpf: Verify bpf_iter for
 global percpu data
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Leon Hwang" <leon.hwang@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260715153254.92010-1-leon.hwang@linux.dev>
 <20260715153254.92010-10-leon.hwang@linux.dev>
In-Reply-To: <20260715153254.92010-10-leon.hwang@linux.dev>

On Wed Jul 15, 2026 at 11:32 AM EDT, Leon Hwang wrote:
> Add a test to verify that it is OK to iter the percpu_array map used for
> global percpu data.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../bpf/prog_tests/global_data_init.c         | 52 +++++++++++++++++++
>  .../bpf/progs/test_global_percpu_data.c       | 25 +++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 598b7dde6581..e5a40ea36ee7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> @@ -283,6 +283,56 @@ static void test_global_percpu_data_verifier_log(voi=
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
> +	skel->percpu->struct_data.nums[6] =3D 0xc0de;
> +
> +	err =3D test_global_percpu_data__load(skel);
> +	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
> +		goto out;
> +
> +	linfo.map.map_fd =3D bpf_map__fd(skel->maps.percpu);
> +	opts.link_info =3D &linfo;
> +	opts.link_info_len =3D sizeof(linfo);
> +	link =3D bpf_program__attach_iter(skel->progs.dump_percpu_data, &opts);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
> +		goto out;
> +
> +	fd =3D bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GE(fd, 0, "bpf_iter_create"))
> +		goto out;
> +
> +	while ((len =3D read(fd, buf, sizeof(buf))) > 0)
> +		do { } while (0);
> +	ASSERT_EQ(len, 0, "read iter");
> +	ASSERT_TRUE(skel->bss->run_iter, "run_iter");
> +	ASSERT_EQ(skel->bss->percpu_data_sum, 0xc0de * num_cpus, "percpu_data_s=
um");
> +
> +	close(fd);
> +out:
> +	bpf_link__destroy(link);
> +	test_global_percpu_data__destroy(skel);
> +}
> +
>  void test_global_percpu_data(void)
>  {
>  	if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
> @@ -299,4 +349,6 @@ void test_global_percpu_data(void)
>  	if (test__start_subtest("rdonly_direct_write"))
>  		test_global_percpu_data_rdonly_direct_write();
>  	test_global_percpu_data_verifier_log();
> +	if (test__start_subtest("iter"))
> +		test_global_percpu_data_iter();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c =
b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> index b852a0b07508..8b1f625017d1 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> @@ -53,4 +53,29 @@ int verifier_snprintf(void *ctx)
>  	return 0;
>  }
> =20
> +volatile const __u32 num_cpus =3D 0;
> +volatile const int offsetof_num;
> +volatile const int elem_sz;
> +__u32 percpu_data_sum =3D 0;
> +bool run_iter =3D false;
> +
> +SEC("iter/bpf_map_elem")
> +__auxiliary
> +int dump_percpu_data(struct bpf_iter__bpf_map_elem *ctx)
> +{
> +	void *pptr =3D ctx->value;
> +	int i;
> +
> +	if (!pptr)
> +		return 0;
> +
> +	run_iter =3D true;
> +
> +	for (i =3D 0; i < num_cpus; i++) {
> +		percpu_data_sum +=3D *(int *) (pptr + offsetof_num);
> +		pptr +=3D elem_sz;
> +	}
> +	return 0;
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

