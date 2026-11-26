Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698849;
	b=GW/6J0yiHvRrLnP2QsRMAXAVLAPvbZg272JGhU5F3MO3Mm8pwJ7sMfm1cdzEajuIQW6b
	 gKys56yRK0/gEHr6kZmgWfQQnwn+7wgwS5FeWfmdobpEk9tkKKtq1lVqprjAkwdpqPCab
	 EtRiskehw9kuPp1qNR9q9FbEk6TYIlaB30dgqC42AzM0PYdNOth8Dq8gNiFGkvy+Rg/7F
	 ohX6utsFTO5TqelrugRma8jmNZoWivBH3Q0ZJTBSNMwAnXx93zHcKftMucX7KpF74i0Uj
	 I4u1CPNJfEOuROuH8jc6ZWTh2EZAb166ttMV3iRgcsn01j3RgY4lMBWXNNF07C0/zPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698849;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xgwVa0m0aXTKiVPkkq5QsNPPYdL+qFmTJdPiRPU/kpg=;
	b=EFQUV8ZnsPIZ7qcZq3/U3ZfVbznh0iYl6+t+NR3xGUW6y7GQU7i2/YhMqoiksMymH/Z7
	 SVPwbq+K8wx/56SAU0yRyJvXmzGxR+NOFY1MXYYpky++N3xx6zeohd6g1PYxKzUbbqmnM
	 5VB9FBZRk2fXFrRarU8593KhbH5bG8OGaH0fTOeKL0aX2MHP8DOKahwrDu2wCZUfpz9vO
	 VDHgm/pkb5e6gToW5L5qK4A5+Z90CSn2+yrm5NIX0qkJH1hwJt6N3zYMJpSZOps5gnLkO
	 hGmvV+2cwLPfcJ30qHQK6AnNRHEUl4bIV0kxGjE7CcgPBTl5gFWzvjNXjsiv/JxTS3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggKeX++U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C4606A31E;
	Thu, 26 Nov 2026 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggKeX++U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E491F000D0;
	Thu, 26 Nov 2026 13:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795698848;
	bh=xgwVa0m0aXTKiVPkkq5QsNPPYdL+qFmTJdPiRPU/kpg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ggKeX++U2bST8EA/sMksxRZ42dkNcvHInMzHTYPxswKsXSx10EsQ0WvxxeOzJe9FF
	 +KWerhXKKYxXiRiGLrLpW1LIOYmP/DaMB8ELT9yAoJkoizIiunnEpjBi9XbwqvFKO1
	 9OAC3ayFUIXTC2WwidD7nSTS2m22s02/AMZbKnXKgRfCkDRIPxej8e/kGoyeTizcpZ
	 J6nIoUJMjRS2kQhYRI1RxPjUF7YSYHRZISxBDpiKG18NbcFuO4gZc0GZA6ZTq4vSSX
	 Hdofrwea17rJQYYIK/JUL9wZGp86YlbjNROljYXBVEKqd6fk0gyb09dUaHiDk3GRr9
	 D2TQiDzcAVfHw==
Message-ID: <sashiko-outbox-235581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/18] tools/rv: Implement BPF monitor loading and
 tracing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261126130004.127155-11-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
 <20261126130004.127155-11-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:14:08 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] tools/rv: undefined reference to bpf_usage_print_reactors()
  when BUILD_BPF=3D0
--

commit 32e1d389b743671fba97d9526fde476a03a6fc44
Author: Gabriele Monaco <gmonaco@redhat.com>

tools/rv: Implement BPF monitor loading and tracing

This commit implements BPF monitor loading, execution, and optional trace
event attachment for the rv tool.

> diff --git a/tools/verification/rv/include/utils.h b/tools/verification/r=
v/include/utils.h
> index 61f77a72a1a23..d6b4e60df7ffa 100644
> --- a/tools/verification/rv/include/utils.h
> +++ b/tools/verification/rv/include/utils.h
> @@ -10,11 +10,13 @@ void mon_usage(int exit_val, char *monitor_name, cons=
t char *fmt, ...);
>  int parse_arguments(char *monitor_name, int argc, char **argv);
> =20
>  void ikm_usage_print_reactors(void);
> +void bpf_usage_print_reactors(void);
> =20
>  struct config {
>  	bool debug;
>  	bool is_container;
>  	bool trace;
> +	bool is_bpf;
>  	int has_id;
>  	int my_pid;
>  	char *initial_reactor;
> diff --git a/tools/verification/rv/src/utils.c b/tools/verification/rv/sr=
c/utils.c
> index e19dd65ec789e..1b1ad7a3ca32e 100644
> --- a/tools/verification/rv/src/utils.c
> +++ b/tools/verification/rv/src/utils.c
> @@ -81,7 +81,10 @@ void mon_usage(int exit_val, char *monitor_name, const=
 char *fmt, ...)
>  	for (i =3D 0; usage[i]; i++)
>  		fprintf(stderr, "%s\n", usage[i]);
> =20
> -	ikm_usage_print_reactors();
> +	if (config.is_bpf)
> +		bpf_usage_print_reactors();
> +	else
> +		ikm_usage_print_reactors();
>  	exit(exit_val);
>  }

[Severity: Medium]
Does building rv with BUILD_BPF=3D0 (or without libbpf installed) fail at
link time with an undefined reference to bpf_usage_print_reactors()?

utils.o is built unconditionally, while bpf_monitor.o is only linked when
BUILD_BPF is enabled.  Should bpf_usage_print_reactors() be declared in
include/bpf_monitor.h with a static inline stub under #ifndef HAVE_LIBBPF,
like bpf_list_monitors() and bpf_run_monitor()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126130004.1271=
55-1-gmonaco@redhat.com?part=3D10
