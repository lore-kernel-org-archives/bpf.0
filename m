Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795673111;
	b=mgn02fDtyApJ92JkPP+uukE+BFXUjJmmeiYYxr0BKN1m9POE5iBxCK2znwSLvxzJp3xM
	 FBd9VU3n0fxse1WtsdZodNNWSxYqEICS93HgriVKs4JUSPHG12u6+mj90G7+OG2rjzZzs
	 BWsOQSosypfMbYNiiSH/wv90KqC8LiEnih2io5SeyhwmSxCZg4tknG2mU6pT5tEuv45a5
	 WQn1T0oTIJiNuyK5fJt3GyHiR2edgZMA6I4sAQln4FXAbgb6FZnGTEBmWADOOhP5lHnMc
	 inNiPeh0T1BQ5+4z9T0LpTYvGRF28hALCJYlQxH7umlt32XiSF9Xt7XAXAvLhQbeZcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795673111;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DtYZQ+YcQNcWzUjVwAqlFYOMmUZRbu6wHnKlevxXEcg=;
	b=he0cBwd40FTb0gZvEwuAmL0EbOICchBKxJ1KubKVJKqVhzItCrRYBcyzJL7Zv69D7Huy
	 RMyrRDZrQXZcrt0ee+UtDcshlbhXqUvo84hPgj7DCvYme8kRosUZ6JJKVgpW30EjkQkqb
	 QJaJrUJDSm3rHTCyLxgnPeFkb+xWrhfvD/ZPEkHcYqTqPg3eTdewwQuAwaDnmrZAQFOdB
	 0w/0cLm7etWVS6rkpnwYh4saiOmL8uSL3yDQqQu9epHGqOuyForoNJfC8fMrpzHToI4IV
	 ccwt3Pu0kSQ6oaQfLkLNO/KT6PsG1jWiTWi2sagXOLPYmjJJipjoift9Y5prCdPJuqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvadh1Qo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85112606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvadh1Qo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153C91F000C0;
	Thu, 26 Nov 2026 06:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795673111;
	bh=DtYZQ+YcQNcWzUjVwAqlFYOMmUZRbu6wHnKlevxXEcg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dvadh1Qo68cyNZT0k1JQIhvubfwoWZ4sHx+0teheCCgPLM30ZUN05JWReHauQzTZX
	 HtXwhTgX3jaDDdbHb0TqsF6hczCMusr/KbvqqWzMTUCZp4fvlSZt8KbSK7p8MyDJpa
	 X8/S13kfS+PxTrzJAIxFUsLbK//KghC9L+TqBiFgLqw0atPJIPUJk5R+/UPJtQwf8R
	 kzsmaV8j0Qj2f7J4v+suo/nO46h1f9SIep3GdLzOHJFSs4wSruLe1OhfEVgjtvrmwL
	 EjYZCXQa0gpLURMPEIuAXDI6hC83cYnwVCECZOtB0cHozxd9pl0uSXSF7lBBRmQ4Lq
	 f9KGgvLCr3FiQ==
Message-ID: <sashiko-outbox-234822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/5] selftests/bpf: Enable struct_ops
 private stack tests for LoongArch
Reply-To: sashiko-reviews@lists.linux.dev
To: "George Guo" <dongtai.guo@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261126055355.9967-4-dongtai.guo@linux.dev>
References: <20261126055355.9967-1-dongtai.guo@linux.dev>
 <20261126055355.9967-4-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:05:10 +0000
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
- [Medium] selftests/bpf: test_private_stack() fails on LoongArch
  lacking JIT support
--

commit a704d33c4d953257fca9dfdc057e22e872b058cc
Author: George Guo <guodongtai@kylinos.cn>

selftests/bpf: Enable struct_ops private stack tests for LoongArch

This commit enables the struct_ops private stack selftests on 64-bit
LoongArch.

> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_st=
ack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> index 103179ff8733b..730d5741591c5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> @@ -7,7 +7,8 @@
>  #include "struct_ops_private_stack_large.skel.h"
> =20
>  #if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__=
) || \
> -	(defined(__riscv) && __riscv_xlen =3D=3D 64)
> +	(defined(__riscv) && __riscv_xlen =3D=3D 64) || \
> +	(defined(__loongarch__) && __loongarch_grlen =3D=3D 64)
>  static void test_private_stack(void)
>  {
>  	struct struct_ops_private_stack *skel;

[Severity: Medium]
Will test_private_stack() and test_private_stack_recur() fail to load with
-EACCES on 64-bit LoongArch instead of skipping?

Both tests attach struct_ops programs to bpf_testmod_ops3.test_1, for
which st_ops3_check_member() sets prog->aux->priv_stack_requested =3D true.
arch/loongarch/net/bpf_jit.c does not implement private stack support or
override bpf_jit_supports_private_stack(), so it falls back to the weak
default returning false and check_struct_ops_btf_id() rejects the load:

kernel/bpf/verifier.c:check_struct_ops_btf_id() {
	...
	if (prog->aux->priv_stack_requested && !bpf_jit_supports_private_stack()) {
		verbose(env, "Private stack not supported by jit\n");
		return -EACCES;
	}
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126055355.9967=
-1-dongtai.guo@linux.dev?part=3D3
