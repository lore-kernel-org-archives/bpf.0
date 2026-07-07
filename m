Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502047F2E1
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463479; cv=pass; b=UGJGWlnSEI52avxGYto0+oExetTtW28Q2SA8RrrwdVC5dadCArQqmFt4vaCn42xkKhwA4NtjNxohGH++pxklkpxftM76xhW/Ugp+uVVZXWWrwySpgtz71joJB/MzGDimaTVV2jFdl8CdP3FUa1Jyzu2ZUvL8WwAQJINgltECV2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463479; c=relaxed/simple;
	bh=mqbZzm1mKJ+DDD+5fcKDGLpRFtel3PnC5EbEwjE65/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jv5vxOL/yV6xddmwBRhQlkkJp4pmNBMGIaOoF4PFV7+NW0o2P8dssNEy8DuKbFTL0LtuM00NX/BLHlJxWb27DpVIWlL+by/2JUGkONv4KFuS2MSKRBlvILqmSAq+oRq0+VxAkwWknVbPciqX+d5nfJ9dO+jBDQT4xw/C83XlvEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wm7v5tkj; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wm7v5tkj"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66628618509so6040d50.2
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 15:31:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783463476; cv=none;
        d=google.com; s=arc-20260327;
        b=GFwKbWgYpN7mpud7Bma/2hqXjbG731WlDJMTNzeF1u6bjFRabgPwmMc8kboHxfT/0S
         4Ru1G6KTnOig96WUsnHsoR7dO6fNhOfHTv3z0y6WF+GojFEr48I4Kk4Q0FNi3cuMiWf/
         iCpoueSv1gvh6BOjZ8AFnekW0ZViD/Pjj5iaDLqKHYkttcP00gvKZOqIkAnX8Ku1/M5Q
         0J8l8W7gQfQi5vDIOvr5pO8gr5JbbKvyA670dRvLSs+JaeWUeGJXBJYJUAQH/FioyDIn
         GJvy3etzIM3MniGCpe3mam15qhUGWZDYPq7nCI6QvsOgm/3+Ez+QDe/cgj2X8XPlD5P/
         vlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJxuLS3sspXamyzGn0yp6stgWy+Vh4FKsBv5+CLJJZc=;
        fh=iw7+rQzlbDI58pgaP3Ojwlw8x3F/yp+Z3O6odXgNeYk=;
        b=LMG3PB0Kxt23uEjJxHY/VCBeumkmIwiDwX4FXCHFLWXL+treEqLK/w08Z9OCVH2mSR
         v+pZ7Upesa6W6do2YucpxToYJA//+sGS783Ef6aGJdvaUo6gWuyRIe27umZxr+5RY6Ry
         onXZZ84S1pyd9k9bpt6CMvps0oFLf+nKBk6RGpR1x+o9a9HsCz1YsbTIn5BDlxSt/5mO
         k9g9KJIX7O2UBVnA16wOXqJmDI+IkZUz5x7ny16sTa6v6LowKma27Zqi0Qobg1x/1/U3
         gaIQb7P5lY3AF5b+a6mPE6qfk2naN67XH+ByZWxWtE11mYb2LDQqqMyo1jbJqT/uc77o
         Zt5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783463476; x=1784068276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJxuLS3sspXamyzGn0yp6stgWy+Vh4FKsBv5+CLJJZc=;
        b=Wm7v5tkjZBhpCwwZtXdj/zu0NfHX2XxFdSzH7sdONPdeszaMTOiyXAMiYrjqMWDz07
         RUzFEpudVxeW4EzOdajrEInrZQajT2X37SPxVA39ABH5kztO81j6Q/zlgA28R9VIwOgD
         bD2TRw66m7ZryD3PUkQp/b8BuzNpjQK5BDgG3u63U6JU+eO7KSq/EUyul2W7ipwyDzHl
         DjgGAOHSbK6Tq+X6e8eIXoX+6QaCjYpzaMDLEbsqT+oHJeBKwVq3LhwRiWhNXDXOI3YG
         fK1gwRPubW3kr+DpNDru9UF5JltSUeBYiY4H5wp/zJyICNcYjR/K+sRg0ROOhO5rsNHY
         yleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783463476; x=1784068276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJxuLS3sspXamyzGn0yp6stgWy+Vh4FKsBv5+CLJJZc=;
        b=jpzLIT/aR+tX2EiO3N/mpkOEry3S/9HzG8fZqgcXrTUW2w4YYZ5f9msWM8fLUJaA9J
         DGATPeOhK6ZG98QRIFgTZKtZ/YKP9mOGWSWpJkCXIUHsYwcI2xQGhQ+oXaLlLFshcVEj
         sWJHNKdbmICc4mYqEdXBBGAit9IsLUCnxE1q3F/1Y6rXExPqsu8cbqrXMfpspZBo1U7B
         7VBeNG+1bNw4PSZySoyKbJf5OJDNzjT2rcLYmbJ7oIq3UxJp2iKYTU9F6t//KmQqP+M2
         sbj9jnB0S52piRAB3edAlOU9lBB4tcGBqelePdopdi/LWUvtkYyMiab3Z/aOwMk6lEqu
         l9gg==
X-Gm-Message-State: AOJu0YwuO+7gs4TDZ96jHjER2fcE9gGYtweNcNSwNekEJHllDqMVUxUX
	GBC8/FlcVPywqrqytYYDFrihd7rk5oMbm9yMTj9+8CDiWwL5P3wLrQtgU8IpAN6zeaOmYSBl44a
	9RowLcVg7MALu5h7otuG1+qVcfAlovYI=
X-Gm-Gg: AfdE7cm0TD56WQ3WAODD2FaVo2T1Ns98znXQothv+F3QvEJYNrCF5+fU6HgCRjXdeUU
	MoITITlJtO/cUffND9bO2vJzukmRqxyjyPAdQBQCK3s39x7p1mo6evzVH/ni4Vu+zRE9rWKWZJG
	QAJ/36RMr8xKDCYwnmYr8VwrnBSF7SNA+pwDq2KQqh7abZj6zi3zhyefwW5SqyEUEdlhq4EG6CK
	e2q8V0QvSe7VIfxoFtZQkyllAD5RMa0b6xdMEMtkfASEE+X4VuIjEYWJTckcyvJ50Wbpd1X8lzT
	dL3jWbpZN22aonPzlzMl
X-Received: by 2002:a05:690e:d09:b0:667:8b90:2e4b with SMTP id
 956f58d0204a3-6678b90384fmr3183088d50.87.1783463476329; Tue, 07 Jul 2026
 15:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707190214.1997705-1-memxor@gmail.com> <20260707190214.1997705-3-memxor@gmail.com>
In-Reply-To: <20260707190214.1997705-3-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 7 Jul 2026 15:31:02 -0700
X-Gm-Features: AVVi8CemGg6SAwdwuBVegAlQYDU3DUlqnvwun6oSn85udpc9vT7ExbMQ3zSyC2c
Message-ID: <CAMB2axMvA6n-x4SReDCzCPuu2n1i-oxsgeQtk6p5LF1Ce8Ez_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add untrusted BTF write regression
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 12:02=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Add a TCP congestion-control struct_ops load test for a write through a
> BTF pointer produced by bpf_rdonly_cast().
>
> The test expects the verifier to reject the program before the TCP CA
> btf_struct_access callback can whitelist the tcp_sock field write.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 12 +++++++++
>  .../bpf/progs/tcp_ca_untrusted_btf_write.c    | 26 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_untrusted_bt=
f_write.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> index fe30181e6336..eb05fc82f81b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c
> @@ -14,6 +14,7 @@
>  #include "tcp_ca_incompl_cong_ops.skel.h"
>  #include "tcp_ca_unsupp_cong_op.skel.h"
>  #include "tcp_ca_kfunc.skel.h"
> +#include "tcp_ca_untrusted_btf_write.skel.h"
>  #include "bpf_cc_cubic.skel.h"
>
>  static const unsigned int total_bytes =3D 10 * 1024 * 1024;
> @@ -579,6 +580,15 @@ static void test_tcp_ca_kfunc(void)
>         tcp_ca_kfunc__destroy(skel);
>  }
>
> +static void test_untrusted_btf_write(void)
> +{
> +       struct tcp_ca_untrusted_btf_write *skel;
> +
> +       skel =3D tcp_ca_untrusted_btf_write__open_and_load();
> +       ASSERT_ERR_PTR(skel, "tcp_ca_untrusted_btf_write__open_and_load")=
;
> +       tcp_ca_untrusted_btf_write__destroy(skel);
> +}
> +
>  static void test_cc_cubic(void)
>  {
>         struct cb_opts cb_opts =3D {
> @@ -637,6 +647,8 @@ void test_bpf_tcp_ca(void)
>                 test_link_replace();
>         if (test__start_subtest("tcp_ca_kfunc"))
>                 test_tcp_ca_kfunc();
> +       if (test__start_subtest("untrusted_btf_write"))
> +               test_untrusted_btf_write();
>         if (test__start_subtest("cc_cubic"))
>                 test_cc_cubic();
>         if (test__start_subtest("dctcp_autoattach_map"))
> diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write=
.c b/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c
> new file mode 100644
> index 000000000000..eda4697aac80
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_ca_untrusted_btf_write.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "bpf_tracing_net.h"
> +#include <bpf/bpf_core_read.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("struct_ops")
> +void BPF_PROG(untrusted_btf_write_init, struct sock *sk)
> +{
> +       struct tcp_sock *tp;
> +       int v =3D 1;
> +       void *p;
> +
> +       p =3D bpf_rdonly_cast(&v, 0);
> +       tp =3D bpf_rdonly_cast(p, bpf_core_type_id_kernel(struct tcp_sock=
));

Do we need two bpf_rdonly_cast()? I tested the following and it also works:

        tp =3D bpf_rdonly_cast(&v, bpf_core_type_id_kernel(struct tcp_sock)=
);

> +       tp->snd_cwnd =3D 1;
> +}
> +
> +SEC(".struct_ops")
> +struct tcp_congestion_ops untrusted_btf_write =3D {
> +       .init =3D (void *)untrusted_btf_write_init,
> +       .name =3D "bpf_ro_btf",
> +};
> --
> 2.53.0
>
>
