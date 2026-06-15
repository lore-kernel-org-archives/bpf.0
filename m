Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9B3EFD15
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781528014; cv=none; b=Jn+Q4DGnHcG7niz64unmsjQvrYlSFLk0NG+H4P7Sq6xzELTlzb5c1BPOkdbmy2EbgK72qN/KShqhKBOA7ujdPEQJsooDgP+dhOjImUp+wy9hzDCegQJcwzCRInr+0wFB5pOyw31Zz/+X+FpfzhwPpbHUZT5GjNFFm4LJ1QSKtDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781528014; c=relaxed/simple;
	bh=A/4tMZh2v40NKp5aNyV+Uh+HYZksppLIFMK4STyxD+c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s7d7Ah+6QlwtcScxDf3pzYQ3Pp2pLIVEMu/JPAa2cfIhcm819iJb+dpA35hyA1uCP9G9a2s3mQdBf43uvXpkJpkgMQCx4E4qCUlOQSTzxstvQPdHlYuA6n87gj0KorJ8PNWv+E5SkUU4Zpm50lpvanna99ztYAh++fkZXDe0l0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHOgxngX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHOgxngX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DDE1F000E9;
	Mon, 15 Jun 2026 12:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781528013;
	bh=Wkd57XFfKNNZGt0LoRRrTXDl93dhx7svf0k9MbOYOwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LHOgxngXxzXIKhLyATmQJn/Te3enfSe8VEJGIuhUvT0C1wewr8eiFnPmy68XYtkHJ
	 +UwPv2DI3z0XRimaKF3rXtdpVx2yGRS1oA3xsohrncPgnZSLKE5TgutKdDs53XNlQw
	 T0n3eN4bdchjI8lHSmQw3+ArO9JO3oINKpuH229FwRAPhqEpFwkImHZ+HIS6N4iSl/
	 wJiwt29PleI+6tLubtYKvODkdsK6KmrWPDJJ1sA3j0UCWvLXagrkaDMt3yF1ZKxG8H
	 MarJzhNYVD4LOHCbqi9jSDUx5BAKocZhffDiGxCpF8bU9KeQHMEFm0d7Xvijv/apTe
	 NLVDflEqZdxZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix packet pointer invalidation for skb
 dynptr writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <72711041414b27e996c6a25f6fd72903acee589f.1781525896.git.chenyy23@mails.tsinghua.edu.cn>
References: <72711041414b27e996c6a25f6fd72903acee589f.1781525896.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 12:53:32 +0000
Message-Id: <20260615125333.42DDE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Static CFG analysis incorrectly assumes dynptr writers do not chan=
ge packet data, leading to Use-After-Free via global subprograms and frepla=
ce.
--

commit 1c2eddecfcf22d7859e70204534b70a21c8883bc
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Fix packet pointer invalidation for skb dynptr writes

This patch modifies the verifier to treat skb dynptr writer kfuncs as
packet-changing operations, ensuring that direct packet pointers are
invalidated after calls like bpf_dynptr_copy or bpf_dynptr_memset.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281c..5ea51bd284f84 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11229,7 +11260,33 @@ static bool is_kfunc_bpf_preempt_enable(struct b=
pf_kfunc_call_arg_meta *meta)
> =20
>  bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
>  {
> -	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_xdp_pull_data];
> +	return meta->func_id =3D=3D special_kfunc_list[KF_bpf_xdp_pull_data] ||
> +	       meta->pkt_dynptr_write;
> +}

[Severity: High]
Does this modification cause issues during the control flow graph analysis
phase?

Looking at kernel/bpf/cfg.c, check_cfg() calls bpf_is_kfunc_pkt_changing()
using a statically fetched meta where register states are not yet available:

kernel/bpf/cfg.c:check_cfg() {
    ...
    if (ret =3D=3D 0 && bpf_is_kfunc_pkt_changing(&meta))
        mark_subprog_changes_pkt_data(env, t);
    ...
}

Since pkt_dynptr_write is only evaluated later during check_kfunc_args()
based on register states, will it always be false during CFG analysis?

If so, it seems this might leave the changes_pkt_data flag incorrectly set
to false for subprograms mutating packets via dynptr writers.

Could this lead to use-after-free scenarios with global subprograms or
freplace? For example, if a global subprogram's dynptr argument is
defaulted to BPF_DYNPTR_TYPE_LOCAL in btf_prepare_func_args():

kernel/bpf/verifier.c:btf_prepare_func_args() {
    ...
    } else if (arg->arg_type =3D=3D ARG_PTR_TO_DYNPTR) {
        __mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen, =
0);
    ...
}

Will the dynptr write evade detection entirely, leaving the caller with
stale, uninvalidated packet pointers?

> +
> +static bool dynptr_type_pkt_data(enum bpf_dynptr_type type)
> +{
> +	return type =3D=3D BPF_DYNPTR_TYPE_SKB ||
> +	       type =3D=3D BPF_DYNPTR_TYPE_SKB_META;
> +}

[ ... ]

> @@ -12214,6 +12271,9 @@ static int check_kfunc_args(struct bpf_verifier_e=
nv *env, struct bpf_kfunc_call_
>  						  &meta->ref_obj, &meta->dynptr);
>  			if (ret < 0)
>  				return ret;
> +			if (is_kfunc_pkt_dynptr_writer(meta, i) &&
> +			    dynptr_type_pkt_data(meta->dynptr.type))
> +				meta->pkt_dynptr_write =3D true;
>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781525896.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D1
