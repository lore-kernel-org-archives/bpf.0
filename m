Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A533815C5
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876184; cv=none; b=jpH3uI7MvTu2hROhR74HJkt/uAZABwyq17LVHxYqkfwF6f8AaDnTICf3UtlPYVbOvgkxFORGtKLZYHpSOTV+UaVURX2CcGFs7uSxNqdO70hy0ZsM1T3ILmFAGTzFC6VBX0SZlck2rIfOIHWaquaCLY+9nzH7kWTzAjI4T2RdjkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876184; c=relaxed/simple;
	bh=sV+pHvX4a+mbnHKf1o4SBN69SuDc3eC0iTUpR/G1z2g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qSl8MGBgmzag7URMao9QTghKK8K/+djS6fzpjWmjCKHx8V+moBCOGYWUz4tUPqJthiJdzVIbntfRdXujHKXtm+fSyl6DfWkTtxMdOjadjLTZTFRsUlQkTk+StHXKw3bS6HssK3ylXOiiSSm2eT1BZRUB+B7PfsfNuqAS/qLlc7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nwhtnbji; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nwhtnbji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CE3C2BCAF;
	Wed, 22 Apr 2026 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876184;
	bh=sV+pHvX4a+mbnHKf1o4SBN69SuDc3eC0iTUpR/G1z2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NwhtnbjiLDo9Xu1zlVIbJcLoN+gU9akxUJzuBfhYyo5W1gGFZorMx+SJ+CCR6KUyT
	 /vm117YWUeYSwKxGV1lIWt/VeOPhOiDu/wMb3g432N2aVkUjuxgHQwqNKJtEbiYRPl
	 xniEPqZRflt2CiHoiVB/XpcINAVDkPl2bN+Fh6PdaWP27KyYEL1bbj96ajT+g56MDH
	 tn6Iciz3paR3E5OKqQ33IQRrYCishAPMgD2gDLK4iZzCjnKkIFMOaqOinIWVwMACgS
	 zVALS0y3dJ91+2mV9//TrWaNxXiTCqlx2/r/UXuZfOrRrCggdjejTFUja2o+NCcED+
	 YahOjbrdjqxaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 4/4] selftests/bpf: Verify bpf-tcp-cc
 rejects TCP_NODELAY
Reply-To: sashiko@lists.linux.dev
To: "KaFai Wan" <kafai.wan@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421155804.135786-5-kafai.wan@linux.dev>
References: <20260421155804.135786-5-kafai.wan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 16:43:03 +0000
Message-Id: <20260422164303.F1CE3C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Test logic allows vacuous passes if BPF callbacks are never exec=
uted.
- [Low] Type mismatch for `bpf_setsockopt` return value.
--

commit 8a4ced8128582d3995376457598fd25202c0468a
Author: KaFai Wan <kafai.wan@linux.dev>

selftests/bpf: Verify bpf-tcp-cc rejects TCP_NODELAY

This commit adds a bpf_tcp_ca selftest to verify that the TCP_NODELAY
restriction is properly enforced in bpf-tcp-cc. It updates bpf_cubic to
exercise the init() and cwnd_event_tx_start() callbacks, ensuring both
reject the option with -EOPNOTSUPP.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_cubic.c b/tools/testin=
g/selftests/bpf/progs/bpf_cubic.c
> index ce18a4db813fa..b941ab3ebad57 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_cubic.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_cubic.c

[ ... ]

> @@ -170,10 +171,17 @@ static void bictcp_hystart_reset(struct sock *sk)
>  	ca->sample_cnt =3D 0;
>  }
> =20
> +bool nodelay_init_reject =3D true;
> +bool nodelay_cwnd_event_tx_start_reject =3D true;

Can this test pass vacuously? Since these boolean variables are statically
initialized to true and the callbacks update them using a bitwise AND, the
userspace assertions will pass even if the callbacks are never executed.

Would it be safer to add explicit execution counters (like the existing
bpf_cubic_acked_called) to ensure the callbacks actually run during the
test workload?

> +
>  SEC("struct_ops")
>  void BPF_PROG(bpf_cubic_init, struct sock *sk)
>  {
>  	struct bpf_bictcp *ca =3D inet_csk_ca(sk);
> +	int true_val =3D 1, ret;
> +
> +	ret =3D bpf_setsockopt(sk, SOL_TCP, TCP_NODELAY, &true_val, sizeof(true=
_val));

This isn't a bug since we only expect a small negative constant here, but
bpf_setsockopt() returns a long. Could assigning the return value to an int
cause unintended truncation issues in the future?

> +	nodelay_init_reject &=3D ret =3D=3D -EOPNOTSUPP;
> =20
>  	bictcp_reset(ca);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421155804.1357=
86-1-kafai.wan@linux.dev?part=3D4
