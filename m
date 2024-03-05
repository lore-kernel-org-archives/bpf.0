Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BAE12BEAE
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 22:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676345; cv=none; b=ixOGQXaWB/gd+9pXVrys4HZtniLwSAsNOBQO91mbIR995+T7OFI2oyTVmYx4choiLlpy87rEHo0OCVIO/Iem5OSlbbQwnO8dBZnUFBLNWyuD/yp3VVrILueCLbo1JQqymNd7H/w+Rs53ry+KQeAv+Bx/ikwPbSpHO9I3AEkVmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676345; c=relaxed/simple;
	bh=MIQxcjcigWftKeNdEDE7DIXuepVB60XiqUS8Ml2hZro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7x8HQe1pHzis2BmjL8hUp73dk6oeiKwDxJyT4TsKF1vhHXtfCYCItJM5jicnvgt1K0NPJsU/zN3P4WYEULusGMoOyQf413lUjn6egpOMEJd2pnxiOPchjLZooFB3946hmoz/gvAgbYkhxsYVr8Pyay3WfaSWgRqZzADF8e7p8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dmr7H4Lc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dmr7H4Lc"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29abd02d0d9so4057508a91.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 14:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709676343; x=1710281143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo6xHnCpd3jN2pIwuJReOkSxC5ikhCvnZ4HbkMD0ZOE=;
        b=Dmr7H4Lcp38YlQ4xso18HXhNuNOa+oke2c2Q1JWS7cUhb81AxIfHhi0CVHNsdiMZ/h
         T637zL4ZMzHdwdGvVvvCeNO7nGRt29bPrlVPoZltD0Y2ChSahAfPY/mF3h/2pjFYLC+V
         DbkSs6EL6O1AVrVrdegkL05dI669vbhlsBbqIYbp4m3mPyLnDiQuGfxOPjMgbqvhxhn9
         oPjArGTecjzOHGGbJzLNGhqqyAsq2jXA+JMtR+kWfrGH2cGVNzvRx/+fYjwU9oP7TzO/
         eaiuN7e1KQzJ/7hJJqVlgtwJVjFjhVJCBvaPmWO1jCZN6CZaoj/Z6R4emgpOhInjhtzI
         RpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709676343; x=1710281143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo6xHnCpd3jN2pIwuJReOkSxC5ikhCvnZ4HbkMD0ZOE=;
        b=RirGI3CUWdyBDZd1WUGgDYyFLeUBEqM381YiiFNEsEO2vMqHoEPJL3z1LiXADGyURz
         fqs8qoWSpnXViOlfW3H5u60AJ2WXTU063wKD4+exqP4d2k3BvvfjLsrXfq7QxIB+kBR2
         s3AOwapvLAuP41zmi0Epg7L+xb7wDY8CcdCX5jbyL0z6Wy7g4/uWzf+He7ExPjVDsyBw
         cI8Rs4UPfIwxO/G1jyeUWTXzpffN4ZaJzoRN2a/aEranfIS7iTIB8I/5eeklZcO3zaeC
         OvkqglKzN+g/ZtXbTEaene201R3N/xRgJqBZM/EBnX7RxmDvXsFZAVNGIoncClgN0+Xr
         gnBA==
X-Forwarded-Encrypted: i=1; AJvYcCVa589sAuNLHVH9wEui1g7kE0TbQA+57RNLlovAdVyUDthuJut6Jj+WxDerp8kVrda/qYwBCpiI3tWF26uf8AFt77F5
X-Gm-Message-State: AOJu0YzhnfL9a1To4OXW7WjluNLuIOPIH0j4UkW72nAX9YVcySPIlymU
	UOKfuHMguysF9LAkEIM4szV5S1lqXRlURJUiQ9e4XOXic+JoVh/PUOzD7OeYuaR1MSne6DbnvtB
	n3jAN8uBbLggrcuYOwYxBecI0+G4=
X-Google-Smtp-Source: AGHT+IGY29uIe26QrJTC+6hfqGl1N52Mmq2pd6uym8iPpiTuNigTCD7t9gqRFxnpFJ1jJqDeyWD2a1/CGQmOD1W+sbw=
X-Received: by 2002:a17:90a:af85:b0:299:f750:9670 with SMTP id
 w5-20020a17090aaf8500b00299f7509670mr10002570pjq.7.1709676343507; Tue, 05 Mar
 2024 14:05:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305064353.69734-1-laoar.shao@gmail.com> <20240305064353.69734-2-laoar.shao@gmail.com>
In-Reply-To: <20240305064353.69734-2-laoar.shao@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Mar 2024 14:05:31 -0800
Message-ID: <CAEf4BzYnMrpT2B2OdkijmR8AUhRXhNoKHM9=Q1GmRdp3FxnUEg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Add selftest for bits iter
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:44=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Add selftests for the newly added bits iter.
> - bits_iter_success
>   - percpu data extracted from the percpu struct should be expected
>   - RCU lock is not required
>   - It is fine without calling bpf_iter_cpumask_next()
>   - It can work as expected when invalid arguments are passed
>
> - bits_iter_failure
>   - bpf_iter_bits_destroy() is required after calling
>     bpf_iter_bits_new()
>   - bpf_iter_bits_destroy() can only destroy an initialized iter
>   - bpf_iter_bits_next() must use an initialized iter
>
> This test case can't work correctly on s390x for unknonw reason, thus it
> is added to DENYLIST.s390x.

That's an unusual way of handling "doesn't work for unknown reason" :)
This might be an endianness issue I pointed out in patch #1.

pw-bot: cr

>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.s390x    |   3 +-
>  .../selftests/bpf/prog_tests/bits_iter.c      | 137 ++++++++++++++++++
>  .../bpf/progs/test_bits_iter_failure.c        |  54 +++++++
>  .../bpf/progs/test_bits_iter_success.c        | 122 ++++++++++++++++
>  4 files changed, 315 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_fail=
ure.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_succ=
ess.c
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/s=
elftests/bpf/DENYLIST.s390x
> index 1a63996c0304..0cd6d2bf1ff4 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -1,5 +1,6 @@
>  # TEMPORARY
>  # Alphabetical order
> -exceptions                              # JIT does not support calling k=
func bpf_throw                                (exceptions)
> +bits_iter                                # cpumask iter can't work as ex=
pected                                         (?)
> +exceptions                               # JIT does not support calling =
kfunc bpf_throw                                (exceptions)
>  get_stack_raw_tp                         # user_stack corrupted user sta=
ck                                             (no backchain userspace)
>  stacktrace_build_id                      # compare_map_keys stackid_hmap=
 vs. stackmap err -2 errno 2                   (?)

[...]
