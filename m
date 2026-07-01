Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93683A873A
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943498; cv=none; b=WhIG5iulWBgIx3jXODIKFGHio6/VrFEuImpgA0uSx37w7YLW+i4IWhLqBnMEV46Z1ocncEuMaYebeXpNtRXYxgwoOBh3rCRWa0V9fvp0HzKKKH/+LrCUuAFHpnt7BWsgM6ijjws4onPOUyAgQIcKn4bqXgyL25nRqRn5P9y7k0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943498; c=relaxed/simple;
	bh=kqApQUefcoxMOyFgYsfScJmRhcYAnJyGHDiCFGYPj5s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=orVd0Y/cOA3vyQ0ppzEfkGGTz+BDrXHEuKwzcuQx+sIS9SlpM5OFPYTmOfq78mmqNhu91rNolwoI64P6bOoGaCljp7ojZvHIhzszhVJJ46OdJ3NPEIDJcggWHUT3Vtv5pOdH3N1FiIZRWbGplD1wUVWn1Q6R3E6jFdiUZgECelU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=r/r7+50P; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="r/r7+50P"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e50979c71so107903485a.3
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782943495; x=1783548295; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz+w72WqMjFFoJkIcS+YO7klDKbo3zQaz3oeNDKSsls=;
        b=r/r7+50PQgX5+Dlmq+3Zj7SmqzTZzQxSCW5uGtqXgDG/DGShs8qwLrpK7h5LS1SJDv
         xzt1/mNbpP15354f3Y8OZkajBVps6sbiY8cLp68DghFpGZLMOhbeLGP7OpK+EvYS0iwO
         /v6mzqasi4EEIXNvfDDw4ofcErAoS0WKqGtOCx5kCKvd3p8wuEJFmMwG/aZsJqs2ZDDS
         HJjm3yzuhZDwxUx5TsuWvj3D3mThv5kzOR0XyhcFThlFCKMWLmpqmcES5DPREHWcZeKY
         yDE+/HI7hVdHfxI6sqnRoKcB/8AoLUDZ8AkkWmQMMdR82+56lofanvj/62x3znbiC0/S
         dJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782943495; x=1783548295;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cz+w72WqMjFFoJkIcS+YO7klDKbo3zQaz3oeNDKSsls=;
        b=klcXhes7y5+qVriWtoJgCM8y9t1giMSLwqK1NpRz6YiX3hYvgyD9MkmEast+8VI9y7
         CmC1sxbioVDbh3Zol6FFgQuf1qZOGtyouKpfRtR8syuXiYvx9JRKsAtW70vX573/nqqG
         8qf6h0LzT504r+BtvGVjTQkq+B73hgERFRwPVqUnuhbE4a6ZoN/nOdmSZvfiCtFICSBM
         LSMVThRVFFZspAQ96SKV+/vzk5hSF3pkVCj4UJ6sU4ZhFvJyCI7+afIzMfsrUgiuFvPZ
         m5wPpzs9hJSO173J9Ibcj5F/qN4b5NAvM6yqWD0kw9pXPuuaNMIG7v9x955TtSnfmkUJ
         kz8w==
X-Forwarded-Encrypted: i=1; AFNElJ+THYhQVuLQIztv4aajiT+nSRa5+OPCLVJvXaEpmEP5U2Gj5RLwSsGEgVMqpjIWevAaAdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuND348PBDn1QzByuAIaVFgzIooEQxDE7BXjAgAMTcUe3nMooS
	IDB03uYy2HgOt+SKm2gRX4J1yT8zg3F5vzW/hnjv4nTsvwA9txNftdNhvnsvMf7TjaY=
X-Gm-Gg: AfdE7cn51GqrKYOscfv9icUfp10UKJODI2XNGc2U9hpW2grSPEyTJtO/LnB+dNGC3u9
	Qbng6kn6BlKyZymqe+DUARwO1g8TPOchRFyS3jKmiJxsjVQDU7bklIvpohYxFtiwewThNhVtNjW
	z6x/4CcJwaC39c9nuwbpBXC5JDu4BwbtsJA+Cdt/tJP8nhKDQbMbKvHIb0TL7qxHLxoMwISowto
	9JIuOvG7mt/p6BCJnMms+jhQk9PdPfE4fU/eQ/Vw/WYh9cQ4cSpwTUXSIGPlfKNlpWRK2viyS39
	pQhZvypHtshSCHLoll6gHVo70P3tF3K7/Gb3rr3H1qAnSNVf0F2JGrLV3FRb2efbWrwjK6mACx3
	+QAnkiyWzp7Oz+j4qeWcz7UoJ6eK4DtWiJJmVk5uB/h05fh1sChksHrN6yMrZZ3Dg4jH9BIpZmx
	Z0yev6aGuut2U=
X-Received: by 2002:a05:622a:4d8d:b0:51a:8bc9:2915 with SMTP id d75a77b69052e-51c26a3b27fmr48081291cf.8.1782943494690;
        Wed, 01 Jul 2026 15:04:54 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c30b12a1bsm1973011cf.7.2026.07.01.15.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 15:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 18:04:52 -0400
Message-Id: <DJNKPX7M6V2M.3VHAH7G1VML8B@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: drop
 tc/xdp/flow_dissector/socket_filter sockmap mutation tests
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Sechang Lim" <rhkrqnwk98@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Jiayuan Chen" <jiayuan.chen@linux.dev>, "Varun R
 Mallya" <varunrmallya@gmail.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
 <20260630145410.3648099-3-rhkrqnwk98@gmail.com>
In-Reply-To: <20260630145410.3648099-3-rhkrqnwk98@gmail.com>

On Tue Jun 30, 2026 at 10:54 AM EDT, Sechang Lim wrote:
> tc, xdp, socket_filter and flow_dissector programs can no longer update
> or delete a sockmap. Adjust the tests:
>
>  - verifier_sockmap_mutate: the tc, xdp, socket_filter and
>    flow_dissector cases now expect __failure with "cannot update sockmap
>    in this context".
>  - sockmap_basic: drop "sockmap update" / "sockhash update", which load
>    a SEC("tc") program that copies a sock between maps.
>  - fexit_bpf2bpf: drop "func_sockmap_update", whose freplace program
>    updates a sockmap in the tc cls_redirect context.
>
> Remove the now-unused test_sockmap_update.c and freplace_cls_redirect.c.
>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 13 -----
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 -------------------
>  .../bpf/progs/freplace_cls_redirect.c         | 34 ------------
>  .../selftests/bpf/progs/test_sockmap_update.c | 48 -----------------
>  .../bpf/progs/verifier_sockmap_mutate.c       | 12 ++---
>  5 files changed, 6 insertions(+), 153 deletions(-)
>  delete mode 100644 tools/testing/selftests/bpf/progs/freplace_cls_redire=
ct.c
>  delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> index 92c20803ea76..d3a954158c33 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> @@ -336,17 +336,6 @@ static void test_fmod_ret_freplace(void)
>  }
> =20
> =20
> -static void test_func_sockmap_update(void)
> -{
> -	const char *prog_name[] =3D {
> -		"freplace/cls_redirect",
> -	};
> -	test_fexit_bpf2bpf_common("./freplace_cls_redirect.bpf.o",
> -				  "./test_cls_redirect.bpf.o",
> -				  ARRAY_SIZE(prog_name),
> -				  prog_name, false, NULL);
> -}
> -
>  static void test_func_replace_void(void)
>  {
>  	const char *prog_name[] =3D {
> @@ -599,8 +588,6 @@ void serial_test_fexit_bpf2bpf(void)
>  		test_func_replace();
>  	if (test__start_subtest("func_replace_verify"))
>  		test_func_replace_verify();
> -	if (test__start_subtest("func_sockmap_update"))
> -		test_func_sockmap_update();
>  	if (test__start_subtest("func_replace_return_code"))
>  		test_func_replace_return_code();
>  	if (test__start_subtest("func_map_prog_compatibility"))
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/too=
ls/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index cb3229711f93..33f788e2786d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -7,7 +7,6 @@
> =20
>  #include "test_progs.h"
>  #include "test_skmsg_load_helpers.skel.h"
> -#include "test_sockmap_update.skel.h"
>  #include "test_sockmap_invalid_update.skel.h"
>  #include "test_sockmap_skb_verdict_attach.skel.h"
>  #include "test_sockmap_progs_query.skel.h"
> @@ -235,53 +234,6 @@ static void test_skmsg_helpers_with_link(enum bpf_ma=
p_type map_type)
>  	test_skmsg_load_helpers__destroy(skel);
>  }
> =20
> -static void test_sockmap_update(enum bpf_map_type map_type)
> -{
> -	int err, prog, src;
> -	struct test_sockmap_update *skel;
> -	struct bpf_map *dst_map;
> -	const __u32 zero =3D 0;
> -	char dummy[14] =3D {0};
> -	LIBBPF_OPTS(bpf_test_run_opts, topts,
> -		.data_in =3D dummy,
> -		.data_size_in =3D sizeof(dummy),
> -		.repeat =3D 1,
> -	);
> -	__s64 sk;
> -
> -	sk =3D connected_socket_v4();
> -	if (!ASSERT_NEQ(sk, -1, "connected_socket_v4"))
> -		return;
> -
> -	skel =3D test_sockmap_update__open_and_load();
> -	if (!ASSERT_OK_PTR(skel, "open_and_load"))
> -		goto close_sk;
> -
> -	prog =3D bpf_program__fd(skel->progs.copy_sock_map);
> -	src =3D bpf_map__fd(skel->maps.src);
> -	if (map_type =3D=3D BPF_MAP_TYPE_SOCKMAP)
> -		dst_map =3D skel->maps.dst_sock_map;
> -	else
> -		dst_map =3D skel->maps.dst_sock_hash;
> -
> -	err =3D bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
> -	if (!ASSERT_OK(err, "update_elem(src)"))
> -		goto out;
> -
> -	err =3D bpf_prog_test_run_opts(prog, &topts);
> -	if (!ASSERT_OK(err, "test_run"))
> -		goto out;
> -	if (!ASSERT_NEQ(topts.retval, 0, "test_run retval"))
> -		goto out;
> -
> -	compare_cookies(skel->maps.src, dst_map);
> -
> -out:
> -	test_sockmap_update__destroy(skel);
> -close_sk:
> -	close(sk);
> -}
> -
>  static void test_sockmap_invalid_update(void)
>  {
>  	struct test_sockmap_invalid_update *skel;
> @@ -1385,10 +1337,6 @@ void test_sockmap_basic(void)
>  		test_skmsg_helpers(BPF_MAP_TYPE_SOCKMAP);
>  	if (test__start_subtest("sockhash sk_msg load helpers"))
>  		test_skmsg_helpers(BPF_MAP_TYPE_SOCKHASH);
> -	if (test__start_subtest("sockmap update"))
> -		test_sockmap_update(BPF_MAP_TYPE_SOCKMAP);
> -	if (test__start_subtest("sockhash update"))
> -		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
>  	if (test__start_subtest("sockmap update in unsafe context"))
>  		test_sockmap_invalid_update();
>  	if (test__start_subtest("sockmap copy"))
> diff --git a/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c b/=
tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
> deleted file mode 100644
> index 7e94412d47a5..000000000000
> --- a/tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
> +++ /dev/null
> @@ -1,34 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2020 Facebook
> -
> -#include <linux/stddef.h>
> -#include <linux/bpf.h>
> -#include <linux/pkt_cls.h>
> -#include <bpf/bpf_endian.h>
> -#include <bpf/bpf_helpers.h>
> -
> -struct {
> -	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> -	__type(key, int);
> -	__type(value, int);
> -	__uint(max_entries, 2);
> -} sock_map SEC(".maps");
> -
> -SEC("freplace/cls_redirect")
> -int freplace_cls_redirect_test(struct __sk_buff *skb)
> -{
> -	int ret =3D 0;
> -	const int zero =3D 0;
> -	struct bpf_sock *sk;
> -
> -	sk =3D bpf_map_lookup_elem(&sock_map, &zero);
> -	if (!sk)
> -		return TC_ACT_SHOT;
> -
> -	ret =3D bpf_map_update_elem(&sock_map, &zero, sk, 0);
> -	bpf_sk_release(sk);
> -
> -	return ret =3D=3D 0 ? TC_ACT_OK : TC_ACT_SHOT;
> -}
> -
> -char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/to=
ols/testing/selftests/bpf/progs/test_sockmap_update.c
> deleted file mode 100644
> index 6d64ea536e3d..000000000000
> --- a/tools/testing/selftests/bpf/progs/test_sockmap_update.c
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -// Copyright (c) 2020 Cloudflare
> -#include "vmlinux.h"
> -#include <bpf/bpf_helpers.h>
> -
> -struct {
> -	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> -	__uint(max_entries, 1);
> -	__type(key, __u32);
> -	__type(value, __u64);
> -} src SEC(".maps");
> -
> -struct {
> -	__uint(type, BPF_MAP_TYPE_SOCKMAP);
> -	__uint(max_entries, 1);
> -	__type(key, __u32);
> -	__type(value, __u64);
> -} dst_sock_map SEC(".maps");
> -
> -struct {
> -	__uint(type, BPF_MAP_TYPE_SOCKHASH);
> -	__uint(max_entries, 1);
> -	__type(key, __u32);
> -	__type(value, __u64);
> -} dst_sock_hash SEC(".maps");
> -
> -SEC("tc")
> -int copy_sock_map(void *ctx)
> -{
> -	struct bpf_sock *sk;
> -	bool failed =3D false;
> -	__u32 key =3D 0;
> -
> -	sk =3D bpf_map_lookup_elem(&src, &key);
> -	if (!sk)
> -		return SK_DROP;
> -
> -	if (bpf_map_update_elem(&dst_sock_map, &key, sk, 0))
> -		failed =3D true;
> -
> -	if (bpf_map_update_elem(&dst_sock_hash, &key, sk, 0))
> -		failed =3D true;
> -
> -	bpf_sk_release(sk);
> -	return failed ? SK_DROP : SK_PASS;
> -}
> -
> -char _license[] SEC("license") =3D "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c =
b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
> index fe4b123187b8..20332a731d4e 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_sockmap_mutate.c
> @@ -74,7 +74,7 @@ static __always_inline void test_sockmap_lookup_and_mut=
ate(void)
>  }
> =20
>  SEC("action")
> -__success
> +__failure __msg("cannot update sockmap in this context")
>  int test_sched_act(struct __sk_buff *skb)
>  {
>  	test_sockmap_mutate(skb->sk);
> @@ -82,7 +82,7 @@ int test_sched_act(struct __sk_buff *skb)
>  }
> =20
>  SEC("classifier")
> -__success
> +__failure __msg("cannot update sockmap in this context")
>  int test_sched_cls(struct __sk_buff *skb)
>  {
>  	test_sockmap_mutate(skb->sk);
> @@ -90,7 +90,7 @@ int test_sched_cls(struct __sk_buff *skb)
>  }
> =20
>  SEC("flow_dissector")
> -__success
> +__failure __msg("cannot update sockmap in this context")
>  int test_flow_dissector_delete(struct __sk_buff *skb __always_unused)
>  {
>  	test_sockmap_delete();
> @@ -98,7 +98,7 @@ int test_flow_dissector_delete(struct __sk_buff *skb __=
always_unused)
>  }
> =20
>  SEC("flow_dissector")
> -__failure __msg("program of this type cannot use helper bpf_sk_release")
> +__failure __msg("cannot update sockmap in this context")
>  int test_flow_dissector_update(struct __sk_buff *skb __always_unused)
>  {
>  	test_sockmap_lookup_and_update(); /* no access to skb->sk */
> @@ -146,7 +146,7 @@ int test_sk_reuseport(struct sk_reuseport_md *ctx)
>  }
> =20
>  SEC("socket")
> -__success
> +__failure __msg("cannot update sockmap in this context")
>  int test_socket_filter(struct __sk_buff *skb)
>  {
>  	test_sockmap_mutate(skb->sk);
> @@ -179,7 +179,7 @@ int test_sockops_update_dedicated(struct bpf_sock_ops=
 *ctx)
>  }
> =20
>  SEC("xdp")
> -__success
> +__failure __msg("cannot update sockmap in this context")
>  int test_xdp(struct xdp_md *ctx __always_unused)
>  {
>  	test_sockmap_lookup_and_mutate();

