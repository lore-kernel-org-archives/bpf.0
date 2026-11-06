Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964378;
	b=y9rprYYzGoCgEaCZ8Hj/9Z0dcHnCAGqYMJyBkF9/lKR33pT6ox+vwVDwjZvh5w8Tzahu
	 UsrCT1zdawc9Vx8Slxhpiz58o8USmc8YlhbAHJt6uCjOAp+wBRJkdp4+Z5LdeIDAGzrEm
	 61ew6ci240urBGzqfdyHwuc1l+n84mER5xM6ZbHQMAPB0rVDmCqUC/t/pPp+IjpnSsk5Y
	 47RhgCpKSVID2vDhsUCIhbhFSvN0tjb3LnDJKDcgUH7ERfXZtOW9tKhbdmoz1y2hGyiF9
	 +pueECp8nO797r75kHjwX3ysivgHnI6UUs059MbUY66SVj3X+gaJWg0pwNix+rqu1Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964378;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2EapSDrjyhov9rexdzuvow+SwKJZW58lRj0FHBnyXto=;
	b=Ta0NuGgcIwrfvL91xNKtFEwuwYBp/oqXvxepaKmbJZWqNlYH/FB29PROHQvloWASF702
	 a9WC2KaV93u3Q0STSVURd9zaK73c2OMk30n5KwvgQo2znwHHeBuvacLZODe0nsfXRN9Ca
	 DnR4oj+ZKoExBxoXDUdZYBnHsQhSMmRh6zwIP+MXC6jdBOujcvtHdxylKXn28f4/ByIxj
	 WhukX3UhT0a3W4pCJl6V58Mip6N4hfwnlTRr6arvGRy22RPpcf3fngN+PRuy9qBQ46NMA
	 etko1+ak4j2J2n4i4pe9t7UXSlE7DI8HiQ2RQ8pxDiIc2EkOVPUsfYZd88H0aA5IjMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aB7zpGTV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5DF606A326
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 11:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aB7zpGTV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E356A1F0089F;
	Fri,  6 Nov 2026 11:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793964378;
	bh=2EapSDrjyhov9rexdzuvow+SwKJZW58lRj0FHBnyXto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aB7zpGTVlODRoyme6+zxtoHx8eegqfr9XHYlLhsN87tx9dycWvYUSaPpeD88BV6dG
	 /UD/4PfJcbNobscnIHeX6OHtgRb7cd0ZMIbdwJpukz2sV3q1Of3rPhSmjQrENc6C0B
	 4K3nTKR33hz7GCpf2eZjmaYhndX93RxgWFNSSgzXXQE/09MM4ucJjhhz66hXMG4gyw
	 owIzVdTBg7C+bStSptoFxMZ3Xlc2PpUxU7y8TyeXteqYgvbDxDXguEg5e5sPMHrE3s
	 Jek+nlG3wwwUWRxqwEcCBdyl1MGwNG6Jy2oT+DqVwBbF/lHBKYne81MXPlGtYX3rnG
	 Ct+gUPdwxwrdg==
Message-ID: <sashiko-outbox-201311@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 6/8] selftests/bpf: Check bpf_wq value
 membership
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yun Lu" <luyun_611@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261106095747.471718-7-luyun_611@163.com>
References: <20261106095747.471718-1-luyun_611@163.com>
 <20261106095747.471718-7-luyun_611@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:26:17 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] selftests/bpf: multi-line comment style violation in
  bpf_wq_membership.c
- [Low] selftests/bpf: single-use macros DEFINE_WQ_MAP and
  WQ_DELETE_INIT
--

commit 67a78af8389db430f474e1214b9e087d1c068104
Author: Yun Lu <luyun@kylinos.cn>

selftests/bpf: Check bpf_wq value membership

This commit adds BPF selftests covering bpf_wq initialization on deleted or
replaced map values as well as live HASH and ARRAY map callbacks.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_wq_membership.c b/tool=
s/testing/selftests/bpf/progs/bpf_wq_membership.c
> new file mode 100644
> index 0000000000000..b78b4f1422b3d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_wq_membership.c

[ ... ]

> +/* Delete and initialize through the retained pointer in one RCU section.
> + * Never configure or start work through that pointer, even if init succ=
eeds.
> + */

[Severity: Low]
This isn't a bug, but BPF coding style places the opening /* of a
multi-line comment on its own line.

> +#define WQ_DELETE_INIT(map_sym, v)					\
> +	({								\
> +		long __e;						\
> +		bpf_rcu_read_lock();					\
> +		res_delete_err =3D bpf_map_delete_elem(&map_sym, &key);	\
> +		__e =3D res_delete_err;					\
> +		if (!__e)						\
> +			res_init_err =3D bpf_wq_init(&(v)->wq, &map_sym, 0); \
> +		bpf_rcu_read_unlock();					\
> +		__e;							\
> +	})
> +
> +#define DEFINE_WQ_MAP(map_sym, value_type)				\
> +static int map_sym##_cb(void *map, int *key, void *value)		\
> +{									\
> +	value_type *v =3D value;						\
> +									\
> +	__sync_fetch_and_add(&cb_count[v->cookie & (CB_SLOTS - 1)], 1);	\
> +	return 0;							\
> +}									\
> +									\
> +SEC("syscall")								\
> +int map_sym##_run(void *ctx)						\
> +{									\

[ ... ]

> +DEFINE_WQ_MAP(values, struct wq_value)

[Severity: Low]
This isn't a bug, but DEFINE_WQ_MAP() and WQ_DELETE_INIT() are only
expanded once, and WQ_DELETE_INIT() implicitly captures the caller's local
key variable while returning an unused value.  Could values_cb() and
values_run() be written directly as plain functions with WQ_DELETE_INIT()
inlined, and could these subtests be added to
tools/testing/selftests/bpf/prog_tests/wq.c instead of a separate test
file?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106095747.4717=
18-1-luyun_611@163.com?part=3D6
