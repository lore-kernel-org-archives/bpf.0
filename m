Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87727F4E7
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157597; cv=pass; b=P6nKvybGjSY3FuDb9KZzxvy/zUxzsGeNayU7HEbnbJZ1FwUc3hCecgLu9+A3n2iTyImTQP8mHBAKeGagvQXwsVWm3dwxvIaC6TB4wvK2T4sH7tv+Hzax4abM2mS/pvK8wxLPvaM2gSnMkjTZMMmDs3sOFdcMfVDAXNc1n1aY530=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157597; c=relaxed/simple;
	bh=Ij8SC/G3dcyNsGNqzFPAw24A5ANOJGekvDBGgGPZ4Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elOrJxCdWH9uqZnZekwFclHhai+TqeKP0zbdjMivN/g4/AQwmuu2umH0DlHY6blm5Tmu3FhvocHAlXmDFZrOxpKLYCgG/oEucgvZj9lOsVLawSnNvY1A1rRTPPjOA2N0gPzRi0A6CQSoxJBT8uyBpxUY5B/wVlU4J1AFa1LSFKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lCZi6/Dx; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lCZi6/Dx"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5069ad750b7so13354831cf.2
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 17:59:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772157595; cv=none;
        d=google.com; s=arc-20240605;
        b=MuztEPKO5Oi9jK627QzKhIdxlBCYSmxPsl+BcY4x/eCUY+fONdWOYguiIHKoQoDXwf
         O/WWuZ5ufjD+lvJqfvMB1zz6TZ3FqpWxlAlXRI+yOh21j0x0jE+bUqfgms37ZkuAla38
         iKgfbAs9JTnIBbXfcyKRsI/vP9dla+yV5V6LTP7QAPlwvcoWbbQYJlOIDekee6tyyGq+
         o/azoS8tCm78SESrGLT2zXpIyJuvd4kZX1YbGi+VAXkXdnN2A7Wu05cBDkb5J5IRPKTg
         039CRRQY8Jru3Zzl/zyQ+wGHjlk/CGP8WIJH7O05o6PGENTvconxE0S43mafFdeQevwy
         A0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=evNy6jazY3xnKMkGc+5DNvdvNChV3K/OuW2kn1xZLCc=;
        fh=uKfaXrXNLx1u5cFaJYgBtgsazj/SjZ8GNkSBcRyE0GE=;
        b=jqUZnq127NTZtm6SQSfofnsFRT/lpYeEnuwcTixU4uz0djmoo1n2nyM43vsEzDzXrc
         ejw0tPJq+va3p6BwoTl1SAfGpb94rtqEc7t6ssG4X9897pncfDZ40hMhJDZlp4FUkMA5
         uhhbP6/AwEBFMxrrPrFx3cditFGRsBjZqsYOyVUiMnZGa88Ksy5dvajG/lbhtTffO/A8
         IPCHzrI1Z56H4W3r8+VVJpBBw/bhrLqWRRzIwKA+RTePNv3meL/JKs9ArQqdwcEM6PmM
         ieTXOp+iZMdfKUwExzUs80tvo9UqWDHrKQ16D7SigG4ZRFzNmvfMAlc6Bixqzj9QNiZ2
         EByw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772157595; x=1772762395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evNy6jazY3xnKMkGc+5DNvdvNChV3K/OuW2kn1xZLCc=;
        b=lCZi6/DxIUPXTN4oYxow/kyhlI35hHJhDwmMvVz+FKZHdsA2EpeRSHTZzM9EhJIwnR
         QREpsvu2Np2Cu136eywHqkZ9lxKxliad0dHO8Pt6xrJG28SpyysUOFBt3Q3XWnybEvNN
         i1X51fg1j83pQsw6hnmMBR1R6bLkjHSR/SVJw2cTvcLzW0+tYkyihJX9AQDGZl+TAiKF
         BjxdhFppe7flVc5EWYKo72QJDwJYrInkXUydrc19p9/Wa5Snd7qRShgIxoegxDW1Xv5b
         VQWdaIrI+lX5tF7uR1jePo36qjQUQZWRU1oYj+WZktePnTpo58rDDJ1Ph09S09uD1x0S
         xmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772157595; x=1772762395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evNy6jazY3xnKMkGc+5DNvdvNChV3K/OuW2kn1xZLCc=;
        b=kYcmAKpEiFGKSt3YwigsvS0v5Rs55nAVxSWAVWlzn8YxnhLjQmfNhsw/bQmR4yjZBs
         DmNAHuVtBv2oc0NNGe3lMXM23+e8ZIF5YPeYSihQ3kSe6r6z0vtOIqVd3gK2m0GHbPMh
         5MnzoFyDIH5ovlfMjJ1kcszzinGeEzQgzbeIJnCQQF5QY05gVOdeB28POwdgjKfhGowK
         JjaIoFgMeOJKVxSJJnVwBR/2W+Dyl4qonNhBPX9/uvoeHFkOJO5Oc+FBdvSYWZkItDE/
         wZABd7n7NhZZODeOOlDDIdNX5bSQSTuWBePqFJ7WuAXqp1uJvPk/KlmDZMsCdW6JJtH2
         gMmA==
X-Forwarded-Encrypted: i=1; AJvYcCUg4Vj0HG9N7D4889Kp/6ypGICC5rL/yEC4g7SwLmS0Zw+Mc6DPBWpHzB08PV0P0Cj6rAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKxO44BjE+4zSL5Z597cFO49hy3Ordt3a3TJmGIMFM9AFcA2Ox
	O7ob//CQVzE+nUYtN5dvCyh5yJJUvFTk+aco0HSs9iKIQfYCv5wrZnobXhErAmykaNRn3GrhTjQ
	eVcwVO8jw3QS1FKS0UVGxeuWuy3JzlKQ=
X-Gm-Gg: ATEYQzwX6PZ+SbaXTOqxJ+jBNg4QKg+p/0RzA/d+6IMlHvheRlzMF/5dW56KTlLk5Pk
	4flMggasa1sjj6lr71qLzt7TfcJ2iJVJsRtqi6/oBSIEwTzU3oXIy+CsQ03xVPBGH7x2wVV/dkv
	jxz1N/2oQi5nO9O4jnqdCLK3LNNen2CVcAusPZ+iBWMUed0qRA4E//yJ8PIpR4n9XfesnWD1pKU
	ci0e1yh+DywRlicx2pm8CpHlnGMSo2aT9TE5nec+PKYIfFrl43Q8OirNSzWxed9aHd+yV7ya3nV
	DDfZ1+o=
X-Received: by 2002:a05:622a:1190:b0:4ff:c17f:726 with SMTP id
 d75a77b69052e-507527146cemr16522181cf.15.1772157595056; Thu, 26 Feb 2026
 17:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226065952.4082859-1-hengqi.chen@gmail.com> <20260226065952.4082859-4-hengqi.chen@gmail.com>
In-Reply-To: <20260226065952.4082859-4-hengqi.chen@gmail.com>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 26 Feb 2026 17:59:44 -0800
X-Gm-Features: AaiRm53dVv20PZPdJFbffE_0aav73coUVY6FwOJJ0z1TIffKxtwmmOKxgDmhrL0
Message-ID: <CAK3+h2wDcR4tsLQMaCjo0qQxyyYCY-t5w7_5nXXVCAX9DsNbSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf/selftests: Enable fsession tests for LoongArch
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, chenhuacai@kernel.org, yangtiezhu@loongson.cn, 
	menglong8.dong@gmail.com, loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 11:00=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> Now that the LoongArch JIT supports BPF_TRACE_FSESSION, allow
> the fsession-related tests to run on LoongArch.
>
>     $ ./test_progs -a fsession_test,get_func_args_test,get_func_ip_test
>     #136/1   fsession_test/fsession_test:OK
>     #136/2   fsession_test/fsession_reattach:OK
>     #136/3   fsession_test/fsession_cookie:OK
>     #136     fsession_test:OK
>     #138     get_func_args_test:OK
>     #139     get_func_ip_test:OK
>     Summary: 3/3 PASSED, 0 SKIPPED, 0 FAILED
>

[root@fedora bpf]# ./test_progs -a
fsession_test,get_func_args_test,get_func_ip_test
#135/1   fsession_test/fsession_test:OK
#135/2   fsession_test/fsession_reattach:OK
#135/3   fsession_test/fsession_cookie:OK
#135     fsession_test:OK
#138     get_func_args_test:OK
#139     get_func_ip_test:OK
Summary: 3/3 PASSED, 0 SKIPPED, 0 FAILED

Tested-by: Vincent Li <vincent.mc.li@gmail.com>

> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/get_func_args_test.c | 3 ++-
>  tools/testing/selftests/bpf/progs/get_func_ip_test.c   | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/too=
ls/testing/selftests/bpf/progs/get_func_args_test.c
> index 075a1180ec26..afb185fdf60c 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
> @@ -167,7 +167,8 @@ int BPF_PROG(tp_test2)
>  }
>
>  __u64 test7_result =3D 0;
> -#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_=
target_riscv)
> +#if defined(bpf_target_x86) || defined(bpf_target_arm64) || \
> +    defined(bpf_target_riscv) || defined(bpf_target_loongarch)
>  SEC("fsession/bpf_fentry_test1")
>  int BPF_PROG(test7)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools=
/testing/selftests/bpf/progs/get_func_ip_test.c
> index 45eaa54d1ac7..3816a3616fbe 100644
> --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> @@ -106,7 +106,8 @@ int BPF_URETPROBE(test8, int ret)
>
>  __u64 test9_entry_result =3D 0;
>  __u64 test9_exit_result =3D 0;
> -#if defined(bpf_target_x86) || defined(bpf_target_arm64) || defined(bpf_=
target_riscv)
> +#if defined(bpf_target_x86) || defined(bpf_target_arm64) || \
> +    defined(bpf_target_riscv) || defined(bpf_target_loongarch)
>  SEC("fsession/bpf_fentry_test1")
>  int BPF_PROG(test9, int a)
>  {
> --
> 2.43.5
>
