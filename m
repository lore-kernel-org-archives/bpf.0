Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334734C134
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136889; cv=none; b=sYvpTJk7WXJYFde7VIV26Oc2ehnx26JAsPvVMNdwVqM/vUP5i6kqEuvy0D6u4wM/4idCKXhrOG92yz+LT2Yg7kTFyn2sOjC3WcmKi5LhyEmeYemUi0oR1iwgCipZkyudx5VpD686Hz1IsWB7KujV7DvnJ+1oEgtbitysX8zFwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136889; c=relaxed/simple;
	bh=yyCeWl07icsosqH2G4xll+lRpCMYF3bNLc3PZhOUdtQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mf4cODxiLCah+uLUkWZbHHwv1BQ6fzqzf8SxAiFSvHfj/UB/Z23A7cLqP9m3sFRYRrl57FNVHGe8fmrz4RgjZId4xzhFgzox3gT2rvScZaY/Bmo5hA2wtLwftkSiSSbGIKpNzUA9WkWSnpm3d7GlX6O9QXqulXzyG6uTBB/b3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bD0VNA6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD0VNA6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1581F000FF;
	Fri, 11 Sep 2026 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136888;
	bh=97tsdKPd0UlEUFl7mj1E/EVtH4QjmOx4sEz3JyVH7Gc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bD0VNA6gqUXhx4DRJdPSLb4JFENuPWHy/aatsfWfFKJbPj3hqVWhA50SMD1kPU/X2
	 CwS7/RM39DybUwrB6wvd3qdjnGS1fDvtihS68dXuRxBjH6uy2mO3GZO3DflfvqQp38
	 2RM5rNA0+Y5hre0+ResJ+2DjN9GX/L9EdH2NHMd4AuGMAp5t+uoASekaw5cdakhqBM
	 ev5fbmqh0KbBoxB4k3PYkzMY6qqthOri9CsCUU2U4mDm5epixLbrB2PprXSUdieLPI
	 kLNdQT9xYCkbEAL3IE1SpbSaOQJrqi+RytSAjBNYHf4+NGMji2nv4BVQkSG86oxQwI
	 5weUqoo9w2A0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in
 __bpf_sk_storage_map_seq_show
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?Q2VuIFpoYW5nIChNaWNyb3NvZnQgU2VjdXJpdHkgRk9SR0UgTGFicyk=?= <cenzhang@linux.microsoft.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260911140308.81560-1-cenzhang@linux.microsoft.com>
References: <20260911140308.81560-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:28:07 +0000
Message-Id: <20260911142808.1B1581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Passing `sk_storage->owner` to the BPF program in `__bpf_sk_storag=
e_map_seq_show` introduces a Use-After-Free for non-RCU-safe sockets becaus=
e the socket memory can be synchronously freed concurrently.
--

commit 64d29cd038f4fabc766558da2cca84aac8eec45a
Author: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@linux.microsoft=
.com>

bpf: Fix NULL pointer dereference in __bpf_sk_storage_map_seq_show

Iterating a sk_storage map is a two-stage operation:
bpf_sk_storage_map_seq_find_next() returns a selem, then
__bpf_sk_storage_map_seq_show() uses it. The latter re-reads
selem->local_storage via rcu_dereference() without checking for NULL.

Link: https://lore.kernel.org/all/CAMB2axNFOC9G2RwOCnsWDth83REMWnmPE8gxMwbL=
YoGusw9miA@mail.gmail.com/
Link: https://lore.kernel.org/all/c3f2a61d-d5bc-454c-987d-717b5f8c8809@linu=
x.dev/

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fad..7d02245aa7049 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -806,6 +806,8 @@ static int __bpf_sk_storage_map_seq_show(struct seq_f=
ile *seq,
>  		ctx.map =3D info->map;
>  		if (selem) {
>  			sk_storage =3D rcu_dereference(selem->local_storage);
> +			if (!sk_storage)
> +				return SEQ_SKIP;
>  			ctx.sk =3D sk_storage->owner;

[Severity: High]
This is a pre-existing issue, but does assigning the socket pointer to ctx.=
sk
without taking a reference or ensuring RCU protection introduce a
use-after-free risk for non-RCU-safe sockets?

For sockets that are not RCU-safe, such as UNIX domain sockets, the socket
memory can be synchronously freed. If CPU 1 is delayed after reading
selem->local_storage in __bpf_sk_storage_map_seq_show(), CPU 2 can execute
the final sock_put() and call __sk_destruct().

Because SOCK_RCU_FREE is not set, __sk_destruct() immediately calls
bpf_sk_storage_free() followed by sk_prot_free(sk), which frees the socket
memory to the slab allocator.

When CPU 1 resumes, it will call bpf_iter_run_prog(prog, &ctx) with ctx.sk
pointing to freed memory.

>  			ctx.value =3D SDATA(selem)->data;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911140308.8156=
0-1-cenzhang@linux.microsoft.com?part=3D1
