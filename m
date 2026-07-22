Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6846EF7E
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705627; cv=none; b=s+oFxRGSRWnK49xVFpBC1/317ukJkEdMqgCLyZJG5ciGT6le08HdhAAg7pClbIAfHJChnn4g1VSqrI7Cd2GOmBCyYifXAKUItup6O4SrfVsRRGQVGwCFI7G5mWjHJOoF51Joxm8GyqkXvcWatJcq0SULCccDHhntwPwpBUe8eQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705627; c=relaxed/simple;
	bh=xYHZH6iwxUTCsSlK8c7nnJi026XWXnQ8x6vCSMVCP1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kcq77hGRWlyuU2r3eNQyw+SRdYd+xM+TeHCbxjcwZdNkhLLNNPjxoSUbjg6TF2aoXRiwl2e3fXeTzjpQbZRfxptgzQZJsP5QzD6QaBkrxjPXMzHoNd7eXzeAKCK3oBrp+tPKXjMyWIGXhXjUjvLo5WDzZWubD/+/bR1ZLmH2sPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alJK+a57; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alJK+a57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05751F00A3F;
	Wed, 22 Jul 2026 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784705623;
	bh=G8rlRyWRs/XIW9zN84BAIsMM5aIQBqm7I8Mnhve6x1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=alJK+a57Z8YQujdLPKet1hsjUvIJrii/gMmfxHXAu/qqpY8ukMt/V8VOti67NKFd8
	 P0APB70wFWayO/3Nl2b3t3qhZlURLBd4aQT3ba3zumXcpkwuFFWl9cyAexa2ZaSsfy
	 CdS2FQgKWKSSzxulMbjSl+IFJU1ulgV1VFalnTT5jUT05vU+plg9ZvRryxEDi3ohhk
	 Pw5Rnc8v7iEp5jT3FciT296mms4Ge1ICvKAz6/7Gl9F0Kpoh4mC/C0QXyCHtMP7sGg
	 gn0TmLRr6LIQuS/kXdQjePC4Tbp3BT/eoVsxE7WJvqEuJmuXVxzyjfunqhS5I5j4cb
	 Y/3Fj5+6QHFBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v6 2/4] bpf: Fix UAF due to missing link type check
 in mprog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722072326.1545677-3-pulehui@huaweicloud.com>
References: <20260722072326.1545677-1-pulehui@huaweicloud.com>
 <20260722072326.1545677-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:33:43 +0000
Message-Id: <20260722073343.A05751F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `rcu_read_lock()` in `bpf_link_show_fdinfo` and `bpf_link_=
get_info_by_fd` allows Use-After-Free of `link->prog`.
--

--- Patch [2]: [PATCH bpf v6 2/4] bpf: Fix UAF due to missing link type che=
ck in mprog ---
commit d6fd76d2df1307731a401336010d5bd9b2102da9
Author: Pu Lehui <pulehui@huawei.com>

bpf: Fix UAF due to missing link type check in mprog

This patch validates the link type in bpf_mprog_link before accessing
the underlying program type. This prevents a use-after-free when an
unsupported link is updated concurrently.

> diff --git a/kernel/bpf/mprog.c b/kernel/bpf/mprog.c
> index 1394168062e85..b4a1b35ff5693 100644
> --- a/kernel/bpf/mprog.c
> +++ b/kernel/bpf/mprog.c
> @@ -17,7 +17,7 @@ static int bpf_mprog_link(struct bpf_tuple *tuple,
>  		link =3D bpf_link_get_from_fd(id_or_fd);
>  	if (IS_ERR(link))
>  		return PTR_ERR(link);
> -	if (type && link->prog->type !=3D type) {
> +	if (type && link->type !=3D type) {

[Severity: High]
This is a pre-existing issue, but I noticed another potential UAF involving
link->prog being accessed without RCU protection.

When a BPF link is updated, link->prog is swapped and the old program is fr=
eed
after an RCU grace period. If a thread invokes sys_bpf with
BPF_OBJ_GET_INFO_BY_FD or reads fdinfo for a BPF link, it accesses link->pr=
og.

In kernel/bpf/syscall.c:bpf_link_show_fdinfo():

	const struct bpf_prog *prog =3D link->prog;
...
	if (prog) {
		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
		seq_printf(m,
			   "prog_tag:\t%s\n"
			   "prog_id:\t%u\n",
			   prog_tag,
			   prog->aux->id);

Can this dereference a freed prog pointer if a concurrent BPF_LINK_UPDATE
swaps and frees the program before the grace period expires, since
rcu_read_lock() is not held?

A similar pattern appears in kernel/bpf/syscall.c:bpf_link_get_info_by_fd():

	if (link->prog)
		info.prog_id =3D link->prog->aux->id;

Does this code also need RCU protection against concurrent updates?

>  		bpf_link_put(link);
>  		return -EINVAL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722072326.1545=
677-1-pulehui@huaweicloud.com?part=3D2
