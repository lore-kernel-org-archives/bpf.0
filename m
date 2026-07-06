Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9144210E
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332104; cv=none; b=mJavvS9pD9XU16s/mPPwd2gf3EgISw9+8EqXClmYW8T5ujyyUGMI3P6U1PCAcdDH2NyG998QbUc2+nmTfMK78sJ6BYQ9tr6b0GNpEak2LWkrIYtcyWTNpCiMESNQT496IDpftJI1lTiueyfHyms5MwJNQ0tRQwWA0ebRjNK2s0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332104; c=relaxed/simple;
	bh=JCy09TXSg0335DJM0Wh5+GuM26Cbdj9hVcUSfX38/MM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMYLJk3gP3KQf+0UvV8MmyTf9yEzp597rlRau9Lfvt/qq7rMHhuelcLDsYrQOnai9Ux3/eHHaIXcagbRfGPetHbrIt8Jlrxmnto6rviNf9Qn8AVg/04/UFDjr48hd+ywRdLpHmnzJYBI6OuMdNoJrLewf3JK8b2Zwl4KpTjLyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAjXJ3E2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAjXJ3E2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6233C1F000E9;
	Mon,  6 Jul 2026 10:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332102;
	bh=QSFOcHhSDgywfxh4IL/AiyiZWk5Gv9eRTfyWhKWFTSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IAjXJ3E26lFHl8bDhou0UmR4o+IybHaqla5T/upVgGVycSONwGZnlBL4a8Z/VNs71
	 HwE49O67XBSTEDn3rvc18oeduj7csWbq7bgUrDUn4P2yK7syGAwtzq93O8gC9/xiNW
	 JZZyhlT/q26pCBpMJZ4ac4w/ajlabjmwiUhiGMcs4+Jaz/8RZWwJRTUa/DhWqGbjWm
	 Upqx9jjBr71y1lbdZGcNfE+WkUQeFKv5fV3VXPaPszW/3rTP6rxJ6rrFy2YtVitkWh
	 WAIj0glmECc0zvrkAaDjOsTeGePCsVdVNFYBFsBBBxBOT1hnW+Pk2OZekxCHcBbBHT
	 +NNWJvlJVit/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/6] bpf: Add ksock kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mahe Tardy" <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706093525.13030-3-mahe.tardy@gmail.com>
References: <20260706093525.13030-1-mahe.tardy@gmail.com>
 <20260706093525.13030-3-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:01:41 +0000
Message-Id: <20260706100142.6233C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing rollback of pernet subsystem on initialization error pat=
hs in `bpf_ksock_kfunc_init`.
--

commit c26355c87f06c9eb5cc9cceccb20cfce50aa1e1e
Author: Mahe Tardy <mahe.tardy@gmail.com>

bpf: Add ksock kfuncs

This commit introduces BPF kfuncs to allow BPF LSM and SYSCALL programs to
create and use sockets for sending data. It adds several lifecycle and usage
kfuncs for kernel sockets, limits socket creation via a per-namespace sysct=
l,
and registers the necessary BTF kfuncs.

> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
> new file mode 100644
> index 0000000000000..8bde734bc917d
> --- /dev/null
> +++ b/net/core/bpf_ksock.c

[ ... ]

> +static int __init bpf_ksock_kfunc_init(void)
> +{
> +	int ret;
> +	const struct btf_id_dtor_kfunc bpf_ksock_dtors[] =3D {
> +		{
> +			.btf_id =3D bpf_ksock_dtor_ids[0],
> +			.kfunc_btf_id =3D bpf_ksock_dtor_ids[1],
> +		},
> +	};
> +
> +	ret =3D register_pernet_subsys(&bpf_ksock_net_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +					&ksock_init_kfunc_set);
> +	if (ret) {
> +		unregister_pernet_subsys(&bpf_ksock_net_ops);
> +		return ret;
> +	}
> +
> +	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +					&ksock_kfunc_set);
> +	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
> +					       &ksock_kfunc_set);
> +	return ret =3D ret ?: register_btf_id_dtor_kfuncs(bpf_ksock_dtors,
> +						 ARRAY_SIZE(bpf_ksock_dtors),
> +						 THIS_MODULE);

[Severity: Medium]
If the later register_btf_kfunc_id_set() or register_btf_id_dtor_kfuncs()
calls fail in bpf_ksock_kfunc_init(), does this leak the pernet operations
registration?

The earlier error path for BPF_PROG_TYPE_SYSCALL registration properly
calls unregister_pernet_subsys(&bpf_ksock_net_ops). If these subsequent
registrations fail, the function returns the error directly without cleaning
up the pernet subsystem.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706093525.1303=
0-1-mahe.tardy@gmail.com?part=3D2
