Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405874;
	b=KxoAQFD9nZDNZBPhPIq2+mfzG44qOkhykJHWHQxo+VXamxfTVv+bxyeVEwBdLo2Lb0Rt
	 x2tTGuqvXQ09HTxWQWOlu5LCrOFKEDTD9sr7URE/gd+HQLwY3A4uiQC3Idji+Jid5e/Ib
	 e0OSD9UfxOH9s/22Bg0bElsZt0OBB/HTVEDci2I4xzCOEWLF7RXYYxxKXo/Ghqth/e5ZU
	 uk8wVqsS2noA4FSk27w40Mup4oPL3IJp1f30ugKATgzos/Rfwg1o7vzYRAV5+UK1rwzML
	 /J6R28DZCvtAsBBP62o7WgPpt9pPT1KZZyg6CDid3aGpVd/j7/IyWG6P7Abhpc4f/BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405874;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=DE0b+oFp4FFHOMJ207JgUmO9BEk1COwTNxSX6VVeQLs=;
	b=xDyllVVdwGnkmFVMKCK2385zBnB2eSfQq9SO29d3qBOw4WxC2igR/994sbar45hlMwRc
	 CiDC603c4BNVekA5bk30KfmSHkIyI2kIU08fCir7CQY0i8HAVWQc+PEt2qb9JzGNxTcdN
	 ThAPcP269zbYpij6o7wPKS42tgfge9K2rH61Ns3CDHpPgwSz8JQrw6SsdZK/XTce2lIlB
	 Ul4Z5b3Ux8soaeWhhmvRYv9k5+cbbpDDMSEfkZeKAGWkVwOwoG4WrCEupHzJa0axtHmu1
	 mDaL+4aFHsLTYtd/XNdkgc9h9VOwAiBT4azf3hThkCiYfPG0r3McOyjMkuUuGWHOVgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="drfHieY/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB2E606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=drfHieY/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2201F00A06;
	Wed, 11 Nov 2026 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405874;
	bh=DE0b+oFp4FFHOMJ207JgUmO9BEk1COwTNxSX6VVeQLs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=drfHieY/H5wyAqSDUAESDBvwpy0zfFUNLCdx3wYOoDPETVJx7VtYhxGt2jsYH+p5R
	 F+MIZqAJwMRQOp5t0EsJtk8LToHoH0wOMDlWlAc7qNdBM6mHcBV+NMNEBbzby6TmqI
	 H/HDC5EgA9WMUDSEUdZnPztW+MiBc2ar1be0MPk6u0tdKuNbB5SjLVsPMU0wNNNTB+
	 iq1DIbtElTYXGKg/qpn5syIe5k5eH2UPtZOp9m6lb7e6SGvDXUpPIVPtZX9WsBODVu
	 3LR3bg+zNH46U28YTHy9JuEwcZh+yRRgWyrHYRsYhn6kD7Bm+Sn/5/sjgx+2+KWGV2
	 e6mXYhQOqsxdQ==
Content-Type: multipart/mixed; boundary="===============7003638985179180478=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5f3e0115bae4a2a4d84b4c39c4da23ac0805b2085b84218c552153f127b91db2@mail.kernel.org>
In-Reply-To: <552b16f22843843822ccf014138e390ac72909ab.1794399387.git.memxor@gmail.com>
References: <552b16f22843843822ccf014138e390ac72909ab.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/29] bpf: Register cleanup destructors for more types
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 14:04:33 +0000 (UTC)

--===============7003638985179180478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Register cleanup destructors for more types

TL;DR: With CONFIG_NF_CONNTRACK=m, the nf_conn cleanup destructor is
registered in module BTF but btf_find_dtor() may never find it, so XDP/TC
programs holding nf_conn that can bpf_throw() would be rejected; no selftest
covers it.

> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c

[ ... ]

> @@ -537,12 +553,34 @@ static const struct btf_kfunc_id_set nf_conntrack_kfunc_set = {
>  int register_nf_conntrack_bpf(void)
>  {
> +	/* The only kfunc that takes an allocated entry off a program is bpf_ct_insert_entry() */
> +	const struct btf_id_dtor_kfunc nf_ct_dtors[] = {
> +		{
> +			.btf_id         = btf_nf_conn_ids[0],
> +			.kfunc_btf_id   = nf_ct_dtor_ids[0],
> +			.release_btf_id = nf_ct_dtor_ids[1],
> +			.flags          = BPF_DTOR_CLEANUP,
> +		},

[ ... ]

>  	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &nf_conntrack_kfunc_set);
>  	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &nf_conntrack_kfunc_set);
> +	ret = ret ?: register_btf_id_dtor_kfuncs(nf_ct_dtors, ARRAY_SIZE(nf_ct_dtors), THIS_MODULE);

With CONFIG_NF_CONNTRACK=m, can the nf_conn entry ever be found here?

struct nf_conn is always in vmlinux BTF when conntrack is enabled, since
net/core/flow_dissector.o is built in and skb_flow_dissect_ct()
dereferences a struct nf_conn under IS_ENABLED(CONFIG_NF_CONNTRACK), which
is also true for =m.  Module BTF is deduplicated against vmlinux, so
BTF_ID(struct, nf_conn) in nf_conntrack.ko (btf_nf_conn_ids[0]) resolves
to the vmlinux type id, below the module BTF's start_id.

register_btf_id_dtor_kfuncs(..., THIS_MODULE) stores that entry in the
module BTF's dtor_kfunc_tab.  But btf_find_dtor() does:

	while (btf_id < btf->start_id)
		btf = btf->base_btf;
	dtor = btf_dtor_tab_find(btf, btf_id);
	if (dtor || !btf_is_module(btf)) {
		*btfp = btf;
		return dtor;
	}

The reference returned by bpf_xdp_ct_lookup(), bpf_skb_ct_lookup() or
bpf_ct_insert_entry() has reg->btf set to the nf_conntrack module BTF and
reg->btf_id set to the vmlinux id.  The loop moves to vmlinux BTF, finds no
nf_conn entry there, and returns NULL because vmlinux is not a module.  The
module table is never searched, which breaks the assumption stated in the
function's own comment that a type below its first id is vmlinux's, with
its destructor registered there.

With conntrack built as a module, resource_registry() in
kernel/bpf/frame_desc.c (added later in the series) would then fail with
"frame_desc: no cleanup destructor registered for object nf_conn", so an
XDP or TC program holding a looked-up or inserted nf_conn where it can
reach bpf_throw() is still rejected.  Only CONFIG_NF_CONNTRACK=y, as the
selftests use, makes the entry reachable, and no selftest in the series
covers nf_conn.

The nf_conn___init entry is not affected, since that type exists only in
the module's BTF.  Should the nf_conn entry be registered against vmlinux
BTF, or btf_find_dtor() be taught to also search the module's table?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============7003638985179180478==--
