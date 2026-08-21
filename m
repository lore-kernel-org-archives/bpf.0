Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315123876D5
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787335122; cv=pass; b=nCU9p4VCBZq2iGKkXsYnCi2fWNVvBr58Tu0smnUygCWk40u3JB8DoyZm2puMCP5zWc2bnTqX2PaySOSWRe6avgcYxkv2a2BRwqVf0gQJCP8B8wPLrXqaHCwEOvvdm1aBzi5wzevjm9pEroGAhm7jyEqEoBophmMtMg0/G8Ww+1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787335122; c=relaxed/simple;
	bh=Q4YO3gW5+/ElgvrLASWt6W169GDgI6U2GbR0+q0Y9VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgVYOl/GWFTe6AO2fqv6hv7GGxrK16+aI25D/7jvSu39+eBdCRsVFBoMSXR3y2BsQILGE+J5DFNY3MNb65tMDndiBraLD/SW1wuNJ6y5ar9OUxNeU/Wg09lFN+DMLy9IuIBS4K7riNSD8Pxc4tsuRqx212ZUDA121J7DSgi3TiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5BL7ozj; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5BL7ozj"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1076973b3a.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 10:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787335120; cv=none;
        d=google.com; s=arc-20260327;
        b=UbC9OkxX27Hy3tDHWylPnfqq+9Yy4jDmRvnzaGlme2SK1mBsJWWwIMOLrYCj7brNvv
         atOt3fpynsjEqZyvcH5HD3ZZpncjQiNHX6L4SYpohxt7o76Rn9Pti/rr0fFXLrKM2DtX
         Jt2NqbUqf9PDtz4zizTBa4aXrYYxSWEh4PUU4c0UoJDHe+w04408W4IDrkyWT8baUUE3
         J6YFNLgR9fjF69fys1bcoB3TOAcXb4l+GjbgrJ/A4M9KJ/snKfI/h0QjDnj+cV0d7a7c
         KG8pFSAOB+TcVVbirLkd9+x+Tw1A3R/gsHHIL4bE3c7iOHDpFFpY9hr1ccTY+ZvziFgd
         nAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vY0AW2cZn1de8V5YbPks+VNx+ReYUlC/G8zlgT+JpJY=;
        fh=gnWV1EzPUsezA44czL0vbamwc7jfvYfN/ZGFKf07q8E=;
        b=kVOM/1Vmjoeu1GdfC63U0uOgzLHb2uzct1lXad5txXjU6j/rKiraidwpYFcDltIdyi
         hJhrwHBz139Hc44e6EuWmIZBxdr2V/hGg+3KqAISNtuKPbMK5M0wuNhTPR5wZp3Q2dy2
         oHGdTLwYASAceyXw2hpEFF1cxDppSR/veEwUDfQja3VOVvOCC+0yne7EHDYIugGJma5n
         iyVum2KnM886imNfDTu1IyrTOmvBxyBNLmW3kwN1i8H6sqNVtRSEmfTgdQPEhZNboqst
         ATT6frwvQmSdz0AHnh9O7a/emxF8yDGKTvkBPapxRv7wOqDAAMPaPKc7rSdiMx1nP9le
         EzlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787335120; x=1787939920; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vY0AW2cZn1de8V5YbPks+VNx+ReYUlC/G8zlgT+JpJY=;
        b=Q5BL7ozjPv9rQb3RAXRy94cbuVQdG9AAyZGyNNlly3JyOcD7JkegD2yQ4nn/M+REBq
         LwCwnlppCbfAhxQYQO1RBpzLopkERX6qEcYC621wS+c8+lJpVrCoprs3Sl07/n4CmIa3
         kmSfqooOG5uXbaAd+DaeSIBC1a6Mz9SM2QOaErWQa+ExIajgRnuWdpq3QJrUiooyTzCe
         q7gtZGJtW5U7SGhsosehIfwwPbkQBJ8sRsbPHFDliRr7+dd81nCjF2hcw31Jb/Zirk05
         aTVJ7woZWFjRksBkBrtg8nTyWewPAg5bMGD6y+vyJqTIrNepjgV5l596CqPJYnxeEHrf
         Wugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787335120; x=1787939920;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vY0AW2cZn1de8V5YbPks+VNx+ReYUlC/G8zlgT+JpJY=;
        b=ZJnmmLDPSWG+Uq0xPimPw+7Bal7UuFyKbZ/XVfJY7/dMgI7Wjm9O+LRYBOag1iyHs+
         d+NLUdN5U02Ky98zltNiQ6UykkaQIBLap3HikVn6L1mAVaJt/xPSrDOOgTsynMj4cpts
         w718tu63K44xApwHYMNZCLH1PB4UIoUSm1n6BJJo/mWL9S4u3MSMJV7bppEO5klC0vLt
         eEUB1avpdFSeV1gdEvxrP/gBGrIal+hnBs46fC9opP1QkjNXuc1x7m2on64HAyK84bno
         snX/HpGWgL7jJvWIHrfeFYHndFVmT7N3OC4dfT5I5W8+WysuqEeyXedHmR203dfOv7kd
         VqkQ==
X-Forwarded-Encrypted: i=1; AHgh+RriEAEIKgIPO1frSkDMxDN788v+106qLqtEO16BGBZp3SIL6QWvPx9mZF85m/y6FouInSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ncPHXtRsArobr6WtapmFFbbpIOqQUM1e14ciJE5AnWGMEtgbMA
	5bqtChPjBIGVsH5uzheIvEhxPq1t3faIzrFNf0PdxAdqRfi0PNYMNYKNx35cC8Gzu+AXviZKA/O
	ncMt90WQj1cPHlElKiSAslzcCNYnjhJw=
X-Gm-Gg: AR+sD123TWxbnMr/LQvwNWM+ErcTNRY2YCOyD/kIn4o60NH8IsXBSbi9JfJ/CKFCRKU
	BfpPEkQPC3C/2bE8HYe5RtKrXJZRbKesYfLeAUiN1kPj5ZdJDIFpO7rWr+l+sg1DQNwm8HC4gmb
	LjgupZUdDd7K1zW+Bhv6xDzt30qMeuwRV+CW7pklNXs93HyUXvZtI9DAFaCtGVuoYX03wANd4xm
	CkE0hqLIsS5Hguh3aUf0U8fzyzlWC8IhJ0xGyLnreu+yQ+x5wlzTZXEonqyDc0VU0o0CToLoJkn
	i3qRf+2RHk615pRZL8DQ9ndswEISyW5JtRtGU3TTHXoTibYhkLoZDG5CkRHFdwhuyKaQvLu7DQx
	gNNmlBCTYn6P6JGD2pOZCOqguQA==
X-Received: by 2002:a05:6a00:1a16:b0:84a:2b96:5986 with SMTP id
 d2e1a72fcca58-851df920e5fmr15445121b3a.8.1787335120562; Fri, 21 Aug 2026
 10:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818153202.90714-1-leon.hwang@linux.dev> <948e7ff41f942519880f9789faf6ca8ed9d0e2cf42eab5b9e1567ead5367b830@mail.kernel.org>
 <a1b1c6ee-ad7d-4972-a15b-f567e7787a6c@linux.dev>
In-Reply-To: <a1b1c6ee-ad7d-4972-a15b-f567e7787a6c@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 10:58:26 -0700
X-Gm-Features: AcwNN1Wfemt68pjxlxhVKlBjQGCM7z3Kdzzy_4k8tCZIXp4Ks6nXUMCLVcg67rU
Message-ID: <CAEf4Bza6X9SZmnyqdZDFKJG5nWchuaEuFyC-MbuzQCuZ+dwq+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Avoid flaky resize value test
 for percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:44=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> On 19/8/26 00:15, bot+bpf-ci@kernel.org wrote:
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c=
 b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> >> index 5671c31085cd..2b69290bcc3e 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> >
> > [ ... ]
> >
> >> @@ -236,6 +223,57 @@ static void test_global_percpu_data_lskel(void)
> >>      test_global_percpu_data_lskel__destroy(lskel);
> >>  }
> >>
> >> +#define PAGE_SIZE 4096
> >> +
> >> +static void test_global_percpu_data_map_resize(void)
> >> +{
> >> +    const __u32 desired_sz =3D sysconf(_SC_PAGE_SIZE) * 2;
> >> +    struct test_global_percpu_data *skel;
> >> +    const int arr_value =3D -1;
> >> +    struct bpf_map *map;
> >> +    int err, prog_fd;
> >> +    size_t data_sz;
> >> +
> >> +    if (sysconf(_SC_PAGE_SIZE) !=3D PAGE_SIZE) {
> >> +            test__skip();
> >> +            return;
> >> +    }
> >> +
> >> +    skel =3D test_global_percpu_data__open();
> >> +    if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
> >> +            return;
> >> +
> >> +    map =3D skel->maps.percpu_arr;
> >> +    skel->percpu_arr->arr[0] =3D arr_value;
> >> +    err =3D bpf_map__set_value_size(map, desired_sz);
> >
> > This isn't a bug, but since the guard above already pins the page size =
to
> > 4096, would `const __u32 desired_sz =3D PAGE_SIZE * 2;` read more direc=
tly
>
> Will change to 'PAGE_SIZE * 2' if the next revision is needed.
>
> > here - and is the unguarded `#define PAGE_SIZE 4096` preferable to the
> > `#ifndef PAGE_SIZE` form used in sockopt.c?
>
> No. PAGE_SIZE must be 4096 here.
>

can you please elaborate why do we care about specific PAGE_SIZE
value? it's a bit weird to guard test based on page size...

> >
> >> +    if (!ASSERT_OK(err, "bpf_map__set_value_size"))
> >> +            goto out;
> >> +    if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "bpf_map__va=
lue_size"))
> >> +            goto out;
> >> +    if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, "bpf_map__btf=
_value_type_id"))
> >> +            goto out;
> >> +
> >> +    skel->percpu_arr =3D bpf_map__initial_value(map, &data_sz);
> >> +    if (!ASSERT_EQ(data_sz, desired_sz, "data_sz"))
> >> +            goto out;
> >> +    if (!ASSERT_OK_PTR(skel->percpu_arr, "skel->percpu_arr"))
> >> +            goto out;
> >
> > This isn't a bug, but would it read more consistently with
> > test_global_percpu_data_init() to check ASSERT_OK_PTR(skel->percpu_arr)
> > before ASSERT_EQ(data_sz, desired_sz)? The block this replaces checked
> > pointer-then-size, and the surviving test_global_percpu_data_init() at =
the
> > same file still does pointer-then-size.
>
> Unnecessary to keep consistent for their order. This is a really minor
> readability concern.
>
> Thanks,
> Leon
>
