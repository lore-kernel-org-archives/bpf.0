Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C43D6695
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589440; cv=none; b=BkTfxUrZRC75vxNWh84kAMCQfcF5+Kb4LiBKmjM0sJLioA1v60IYaV/KOK6OqocmfnHDTXo4sAGmegWnUHat8U0PRG1CqwLhEU7s46zn8502f9xbmIJr1y0oalD2ufsxWc0nd5BmixbOQgW9U5zVSNHCJGsoLZrHqI84nyQPCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589440; c=relaxed/simple;
	bh=8qoM/h70MXOxJbQarSl2Ab59u1q3ADyZqAj25G8ltQE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s4iV0TiLgqtIDITs0DxNjHWCtQDNG9lsQrntxa41wUy0FOp7aoR/6smkdbK3PQAMgXBZxcL3Qzfkl8sLAX/lbjZlsvXghn2Za/lwjR02k++9SLV9cp+VezUPmGzts1LNt3Mx526u+k24IhWzV253TIhs6AWRisARunAfAT231B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2JPz2Fh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2JPz2Fh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20421F000E9;
	Tue, 16 Jun 2026 05:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781589439;
	bh=VNd1xs597nDP67X0/4Wfq63xRXILyMpB/dJ59nDteGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2JPz2FhOpZ+9rPqaQOuIQI85xx5eLngn8gl3uOXV1rNGL1XDraP+bjXEWKK1pJJ6
	 p9ewI+bevZqtlI8ThX5wa2W1G5GpZkGmaB87itx54Kl/q/rgf2rmwsFoEN/9mYuJpm
	 B1X3vB8Ad6Y0HEXaDRqs8JH6pUKbmhmhOk4kyTzyCteNU8vODnFchUXPY+M/DP61d4
	 QDd5DsJvAEGnhGI4ZRcgRtdTnOs8vY7sx+QldqUbh1MbWb7eqZQ6nD66FLIcf7XNXI
	 PXHVgoks1l+pCZOOFVg3rJAXN6SXyyTn6WLbTxCyo4I4wW/KJ1UUEfT7AmJI9E/zaO
	 6LZhRa+QntaIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Guard conntrack opts error writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <70aeec0ab762aebe65129cf6052e132c7329edc2.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
References: <70aeec0ab762aebe65129cf6052e132c7329edc2.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:57:18 +0000
Message-Id: <20260616055718.F20421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU Vulnerability / Use-After-Free due to multiple reads of BPF=
-provided `opts->netns_id`
--

commit 8efa13ac7f8992d846ab4af35e05c540c530390f
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Guard conntrack opts error writes

This commit updates the BPF conntrack lookup and allocation wrappers to
conditionally write to opts->error. It ensures the write only occurs if
the provided opts__sz is large enough to include the error field.

> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index 40c261cd0af38..3c182024ec509 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
[ ... ]
> @@ -298,7 +303,8 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_s=
ock_tuple *bpf_tuple,
>  	nfct =3D __bpf_nf_ct_alloc_entry(dev_net(ctx->rxq->dev), bpf_tuple, tup=
le__sz,
>  				       opts, opts__sz, 10);

[Severity: High]
This is a pre-existing issue, but does __bpf_nf_ct_alloc_entry() (and
similarly __bpf_nf_ct_lookup()) have a time-of-check to time-of-use
(TOCTOU) vulnerability regarding opts->netns_id?

The BPF verifier allows the opts argument to point to memory that can be
concurrently modified by a BPF program. Inside __bpf_nf_ct_alloc_entry(),
opts->netns_id is read multiple times:

net/netfilter/nf_conntrack_bpf.c:__bpf_nf_ct_alloc_entry() {
    ...
    if (opts->netns_id >=3D 0) {
        net =3D get_net_ns_by_id(net, opts->netns_id);
    ...
out:
    if (opts->netns_id >=3D 0)
        put_net(net);
}

Since function calls like get_net_ns_by_id() act as compiler barriers,
the value will be reloaded from memory. If a concurrent thread modifies
opts->netns_id from a negative value to a valid ID between the initial
check and the final put_net() check, could the function drop a reference
it never acquired, leading to a refcount underflow and use-after-free?

Similarly, changing it from a valid ID to a negative value could cause
a reference leak. Could we cache the value of opts->netns_id in a local
variable to ensure the same value is used for both checks?

>  	if (IS_ERR(nfct)) {
> -		opts->error =3D PTR_ERR(nfct);
> +		if (bpf_ct_opts_has_error(opts__sz))
> +			opts->error =3D PTR_ERR(nfct);
>  		return NULL;
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781586477.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D1
