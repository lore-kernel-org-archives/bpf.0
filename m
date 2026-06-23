Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61F375AB5
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254797; cv=pass; b=MmKlWfMPP7q3WXEWvWrOK4sRCtRSSSVRklp5Z6TOCXMFU+fQrko4LajH8IZROTvrqHh6gg0oOUjqxBBDlee6JbQL6OSdp7FpeECdFsAxFYyX6xlLtNZLspkHuKi7Crp/VSW3o3wKm111B3Xr+k6hJggjCnHiRMKF1pJsXz2mrJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254797; c=relaxed/simple;
	bh=EoNa88wmRRzgNbTcw8bzW3CIxyyn/g31iBHhffrV7JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p57CfcGfDzFgkHYNaYN9EaYwtDqRwYpPjTr38basZyQ538Emv1ww7wiVScJ9495JYLwkRXuHjlgR8Ja9WmbtLtz3v/34f3IJM2i01S90Xan6fOHOcVJfNIwJwnZMk1i+NT0LOlw5jcj3xDs4Pvfx8lcqvTjXmAPJnXcZPtzOx6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms6JfkGI; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms6JfkGI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37c8e7c8185so262964a91.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 15:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782254795; cv=none;
        d=google.com; s=arc-20240605;
        b=INQpsoXOLt2YHiQwmYaFCec+2NykFcMx57DUDX735/ggB7O4mlp53sIM+7oaj1KWwM
         o07vpjkPSeB30tHzYYh56Uo61VRor0sMm1yxpn1NyzSQSivQQrfvgbtdd6k7DuWLsXk8
         piMy0hRqNC3dLjiaxGqT92SiJcoRdWZ1PHUfbH2WI0tJjVzshlkHwXUvAQ7OxgETI9ay
         NnuqDlo+yMSllxPm/YuxBEVrHJPssuINPwZ+gEoLmrMR57yrRAXYrME8FYHf4FhXLvpB
         VMVdhiQEqcOo2QsZaeIfJtbJGd4uioEG7xFzwVUIBW6fJixBSTYQLqdaEQzAmjNh0gIj
         /2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4cQeF60kgONMVqNgnkSoiO81INVKj/yr1+GUEevj9iM=;
        fh=IqI/Cp1xYGcfpyBgkhc6h3oFTMbeXOsSrhhlFByRLHg=;
        b=J/lbPdvgVahGuBVhN2lIy8hYf8JDD3y33ma8yUFVIOZktLZfQcXmvXPrnufQyavO16
         4KM8Hn8RevLaHIKpt5zIsLRo0IvdXr30obhsXbK0kW8RKdpiH5EjuTWUU30QVbmzr4gK
         TQxAIXJRmXkDZMxfy1Bs8qhPdzNk+CyLlOrb8eEDRZL9tokofj14y4yUXrjEjJauCxgo
         g392QuXdbU2yf3Z5/lQ8kKDv4/d9jZuKfHcn/F1SbKXaNGskD5XaD+fcl7hkOWX8GDxW
         UQUByEb2evB9jAdINEeK3lMiagU36YfXjLkX+Qjz+Lx+dxO3NDnrCiDSCujPGNfyZZym
         wfmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782254795; x=1782859595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cQeF60kgONMVqNgnkSoiO81INVKj/yr1+GUEevj9iM=;
        b=Ms6JfkGINuzIe/mAzUHh9cn/cBcZj33HtV9vrtrrkvMsfzNBLdv/IqRoGs3z1hYK0m
         zhUMAScAwDEy5/y1J5CyXKTLiI54QqUc62/EuTbgKIl2VmqmJogpyS2bSH0bLvugw35L
         +KU3g5cPJCvNCgWFgsDU99syulZhGZIIOMNzzdBK4C3IDybvXLDmQGNhE403korEy9Hx
         uhBPBPx6Z0acExZRhWnskTKEYo1spzwf7PzhOcc4Q5g2Awy6gnTS7EplVtFDLtZjrmQU
         3GCzuBvSRBBl1kPYJtgxzW53/BGkopJFqkVKVbIBrJYSVlV8Zis9e22oT4NKCW58/ax6
         sqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782254795; x=1782859595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4cQeF60kgONMVqNgnkSoiO81INVKj/yr1+GUEevj9iM=;
        b=Dd0Za5v/GzdKlZGFmOvXzWVdkCixgpOFmWy+Twp9HV3XSPNe9wlOmGkq/qYaJpy0o3
         HBox2SAli2P+NaJ8pgKyh682DTRfYCkaQrSF4cCXPt5M/UR8FZNH6rYTDwXbvina8Tzu
         o97UVMTD/5ZWMPP88B5JKZgRH3ikc3PfQgfE+u5tcEv9xapuve0RWWwY4zxTHwTs7pnn
         iROhkM3NhzOAMUUsPNfnqgwksXK8t8Ia1gGahNOS+ezRcbCVfWi2S6UGvYWmKrqhNSQc
         ruYDgvmtfxb51sbMxwjKhJCWPsJhK7E2J//2RfaqiZTSuIwlmk42KXLhyXUzp/mmhSHl
         2X4A==
X-Gm-Message-State: AOJu0YztC57IkWoIjhcdhlNxt5UVfdnX85TNsBm8XckRidc7UgsVtsyG
	GpIXJDSUJelY+djmKL2Jg9O8ALjElNxwMC2lHmxoMepAEL9HuYaaoG5oa5wX1J1aY5nhzeHZ4C6
	SRiZ6l/mG95GNSx4+oiqjwsIuZIFHSE8=
X-Gm-Gg: AfdE7cmnhGL7kl73RMl+geZW04oLa+74tMOJNZudmq45SdIAIyFpJ2XuWA6FGccd2hG
	rC2/LDmMwkI3/pfpVhjRgmzAJXQMWG5Pe9gfmJiMh+jAiS7XmBYPXKPfxrh5PzRB2q55huek5Fc
	pVSUfpUOj4+KYoGRJ7skeCe3sKXFicvf2N/xqn6sGD1AMxIu0RBTOPJDTIjXUxXBXT22eqyQMQY
	NQJVo/hE8O8OsOgDYbeLMt+LSds/ZIC+WCGqkKKEkRYYLsTdX6yqyHbb3ANb/wz0RNsHGWVuZVm
	49LIfrUEVDV4SccKyeTDAQHqQdoZvgnh/QAp227r/AslbNmA3cfuyC8SZSL4KWc8eN2Hmg==
X-Received: by 2002:a17:903:2450:b0:2c1:ed61:36ab with SMTP id
 d9443c01a7336-2c7e1538eb1mr8422395ad.19.1782254795349; Tue, 23 Jun 2026
 15:46:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622143557.22955-1-leon.hwang@linux.dev> <20260622143557.22955-10-leon.hwang@linux.dev>
In-Reply-To: <20260622143557.22955-10-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Jun 2026 15:46:15 -0700
X-Gm-Features: AVVi8CeDV0iyWUJxT8tqR7wuW7mpOknFgq_TU9la-Qich4uiJgyQft90YUTPtII
Message-ID: <CAEf4Bzbmj-ekwYQ6oGW-BRnzLBDvWgLyn_QsU5g1yNt_8A0H3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 09/11] selftests/bpf: Add test to verify
 accessing rdonly percpu_array
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 7:38=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Since percpu_array supports direct-read, it should not break accessing

what does "it" refer to here?

> rdonly percpu_array.
>
> Add a test to verify that adding '.map_direct_value_addr' to percpu_array
> won't break the case.

what case?

I think you are testing (read-only) direct access to read-only per-CPU
array, is that right? Just write that out? Though, really, negative
test (we *cannot* access read-only per-cpu map for write operation)
would be more trustworthy for this...


>
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  .../bpf/prog_tests/global_data_init.c         | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/=
tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index ea7e4e3d91cf..f59d83919058 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> @@ -232,6 +232,48 @@ static void test_global_percpu_data_lskel(void)
>         free(online);
>  }
>
> +static void test_global_percpu_data_rdonly_direct_read(void)
> +{
> +       LIBBPF_OPTS(bpf_map_create_opts, map_opts,
> +                   .map_flags =3D BPF_F_RDONLY_PROG,
> +       );
> +       struct bpf_insn insns[] =3D {
> +               BPF_ST_MEM(BPF_W, BPF_REG_10, -8, 0),
> +               BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +               BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +               BPF_LD_MAP_FD(BPF_REG_1, 0),
> +               BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lo=
okup_elem),
> +               BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
> +               BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       int key =3D 0, map_fd, prog_fd =3D -1, err;
> +       __u64 value =3D 0;
> +
> +       map_fd =3D bpf_map_create(BPF_MAP_TYPE_PERCPU_ARRAY, "percpu_ro_m=
ap", sizeof(int),
> +                               sizeof(__u64), 1, &map_opts);
> +       if (!ASSERT_GE(map_fd, 0, "bpf_map_create"))
> +               return;
> +
> +       err =3D bpf_map_update_elem(map_fd, &key, &value, BPF_F_ALL_CPUS)=
;
> +       if (!ASSERT_OK(err, "bpf_map_update_elem"))
> +               goto out;
> +
> +       err =3D bpf_map_freeze(map_fd);
> +       if (!ASSERT_OK(err, "bpf_map_freeze"))
> +               goto out;
> +
> +       insns[3].imm =3D map_fd;
> +       prog_fd =3D bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, "percpu_ro=
_prog", "GPL", insns,
> +                               ARRAY_SIZE(insns), NULL);
> +       ASSERT_GE(prog_fd, 0, "bpf_prog_load");
> +
> +out:
> +       if (prog_fd >=3D 0)
> +               close(prog_fd);
> +       close(map_fd);
> +}
> +
>  void test_global_percpu_data(void)
>  {
>         if (!feat_supported(NULL, FEAT_PERCPU_DATA)) {
> @@ -243,4 +285,6 @@ void test_global_percpu_data(void)
>                 test_global_percpu_data_init();
>         if (test__start_subtest("lskel"))
>                 test_global_percpu_data_lskel();
> +       if (test__start_subtest("rdonly_direct_read"))
> +               test_global_percpu_data_rdonly_direct_read();
>  }
> --
> 2.54.0
>
