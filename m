Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397233C0A06
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589156; cv=none; b=VxbksokI4zT2DYm+Gb9jYXdoL0sBI3tkqCTrM/DKr/R/pg5Qu9IDwcSMYz/KwAlcEp1nWZc5dZgutHpojss0UVK0wMwScrinFD6PiewEp5Cw0Qu4Yv6xd2Tl6VfRZ3Wpa0aShkqGH+s+5u+SY2OH7TiXiwWQ7XT4Y0zbAkyqAGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589156; c=relaxed/simple;
	bh=pp/LcUh3darLoJ4b5XF2giA4MtI2nqsL2WreZvloQLU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fJg6hANZZCcVYQaQa7EQQo2eZLyv1LWSbBTaqVr3w02SaNPYObPwnxbagBgw/M/dHOT68RejM5S4upIrhcrJOe5pbUkevaiU51uI3FAKa9rcFDvfSS99x81ZbKxZmm9T2hmQzmVsevGoNE5KTY2cD1Al1iILJ8paDwrVKbdO7Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBK7nXmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBK7nXmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE671F000E9;
	Tue, 16 Jun 2026 05:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781589155;
	bh=bdvehv91ymlRVgAMm6P/Dmca56PEGIeNd1Qz7BX2WiE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZBK7nXmZn+x58GGFZLzNdi2X0LDCkiJQOr8kL728oreWWtPLR00kswtDNxsyIZAHH
	 8y6IapNF1ROmJwedTg3Ju7ZvRCX+/S1o2IviL8ugmjfbeE6smy0jUg/UUyEkIOZ/u1
	 FuwLt/47XtMxIYjqc3EwIyPCoh1SfAdypuK5fvfcT41dBttkZ503T0+8PUlt3KNJC7
	 El1a8gIGuJyPOnQCxcmjfO6uf3FbYoIRmrPuvEVtCr5Iz4PJg7GJgVLCpZo1qdrvwL
	 y2jgvCKV8J8GWwxZsRHRWDgNQEydpmdAWTPVFVfgLxWzHql52nwES/wVdPIZ91mU5l
	 z/NV15PZPdwxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover small conntrack opts
 error writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <c4c898dd23181b676ebf6b6b4d9c54f51bb69c75.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
References: <c4c898dd23181b676ebf6b6b4d9c54f51bb69c75.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:52:34 +0000
Message-Id: <20260616055234.DCE671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check for the enum parameter `manip` in the `bpf_ct=
_set_nat_info` kfunc allows a BPF program to pass an arbitrary value, trigg=
ering a `WARN_ON` and corrupting the conntrack state.
--

commit a2c96d6b406da0481952334b633ba64cd47d26da
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

selftests/bpf: Cover small conntrack opts error writes

This commit adds a conntrack kfunc regression check for opts__sz values
that do not cover opts->error. It verifies that the guard value remains
intact when the kfunc returns NULL due to an error.

> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/test=
ing/selftests/bpf/progs/test_bpf_nf.c
> index 076fbf03a1268..df43649ecb785 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
[ ... ]
> @@ -124,6 +128,28 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, stru=
ct bpf_sock_tuple *, u32,
>  	else
>  		test_einval_len_opts =3D opts_def.error;
> =20
> +	opts_def.error =3D CT_OPTS_ERROR_GUARD;
> +	ct =3D lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
> +		       sizeof(opts_def.netns_id));
> +	if (ct) {
> +		bpf_ct_release(ct);
> +		test_einval_len_opts_small_lookup =3D -EINVAL;
> +	} else {
> +		test_einval_len_opts_small_lookup =3D opts_def.error;
> +	}
> +
> +	opts_def.error =3D CT_OPTS_ERROR_GUARD;
> +	ct =3D alloc_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
> +		      sizeof(opts_def.netns_id));
> +	if (ct) {
> +		ct =3D bpf_ct_insert_entry(ct);
> +		if (ct)
> +			bpf_ct_release(ct);
> +		test_einval_len_opts_small_alloc =3D -EINVAL;
> +	} else {
> +		test_einval_len_opts_small_alloc =3D opts_def.error;
> +	}
> +

[Severity: High]
This is a pre-existing issue, but while reviewing these conntrack kfunc
tests I noticed that bpf_ct_set_nat_info() lacks a bounds check for the
manip enum parameter.

Since the BPF verifier does not check the range of enum values passed to
kfuncs unless they are annotated with __const, could a BPF program pass an
arbitrary scalar value for the manip parameter?

Looking at net/netfilter/nf_nat_bpf.c:bpf_ct_set_nat_info():

    __bpf_kfunc int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
                                        union nf_inet_addr *addr, int port,
                                        enum nf_nat_manip_type manip)
    {
        ...
        return nf_nat_setup_info(ct, &range, manip) =3D=3D NF_DROP ? -ENOME=
M : 0;
    }

If an invalid value is passed directly to nf_nat_setup_info(), would it
trigger the WARN_ON(maniptype !=3D NF_NAT_MANIP_SRC && maniptype !=3D
NF_NAT_MANIP_DST) and fall through the default branches?

It seems this could result in the connection status being inconsistently se=
t,
potentially corrupting the conntrack state or acting as a local denial of
service vector if panic_on_warn is enabled.

>  	opts_def.l4proto =3D IPPROTO_ICMP;
>  	ct =3D lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
>  		       sizeof(opts_def));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781586477.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D2
