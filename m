Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D334A3F1B
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791315782; cv=none; b=R2AwCDPdy7Ced3cEw0ZWH40BnRFE/AsS3M+x/nHPPbvV8YdbU/TNxnwfLUUfXAB0k4b2ALdcZcXiRek6kXMWClavfTD9iGM1qtR8t6dVJVJWFRIjtyQNuJRpXEsXGAQYpuMapOOUju5DVbknjk2mmZVZOA89Qn+GEaqNsTeIfpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791315782; c=relaxed/simple;
	bh=L7OUtBJVEPtAbMOjZGQC84NT00N78bOjVvQALN65exs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MF3PtpVJFOamlqcoX8Ta+Ao0cIDcs4S02GPqIcchs24h+yXCwSdr2xOzyvzg+bp+E3qZUzRcKOszA3yhw8iAbx6E2N7OPDz0F0fwK2DExBxQxrAr1pOT6NQGweFy5edWRt8O6Di6RuReqMPO30nocebULBk8r+FgIZr35p96Svc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAnUwAbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAnUwAbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2951F0089B;
	Tue,  6 Oct 2026 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791315781;
	bh=jLLK58qik9pB6JslTs296jJM/AK/yESeDhcSlMTwy4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jAnUwAbveo5VuKy9nQUYivNYr4nzN6TNh//zgnzGonw0tDGg9gYwz5TyA0OuwQFme
	 IJ7la3t9l5Amp11v8LCRyvmncHUIUwvl1GLzplT6eFoNn0zju1FtnoaMIeeyUYnFr2
	 AoYNi7qFortWJ7ea/brdNJV4mEpx6ozJPBLXx9FOgrK9sOBncWN74WK/MSMvslkYiu
	 NaxwflS2D6ncLvIls7LIDjIQ2Y6AlRRVg7W7WD7W6KnJH/Rrns/WWO/mbE3crivByk
	 NWY48DJ72XvyPvw1lDrYpje5/m06wyXdOFMLwjy+AgBw/W8Kc4ZGt6p/lyYshZhDqY
	 tObxNx87QTSRg==
Message-ID: <sashiko-outbox-162406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 bpf-next 10/10] selftest: bpf: Add test for
 bpf_tcp_ops.{enqueue,dequeue}_rcvq().
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261006192601.1875100-11-kuniyu@google.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-11-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:43:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftest: bpf: tcp_autolowat missing rpc_desc_buff_len reset
--

commit 379ea90d2efb24d101b9be64b55e86c49d5beee6
Author: Kuniyuki Iwashima <kuniyu@google.com>

selftest: bpf: Add test for bpf_tcp_ops.{enqueue,dequeue}_rcvq().

This commit introduces a BPF selftest to verify the behavior of the
bpf_tcp_ops enqueue and dequeue callbacks dynamically adjusting sk_rcvlowat
for RPC frames. It sets up a client-server connection within a cgroup and
uses setsockopt with a custom BPF option to enable TCP AutoLOWAT.

> diff --git a/tools/testing/selftests/bpf/progs/tcp_autolowat.c b/tools/te=
sting/selftests/bpf/progs/tcp_autolowat.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tcp_autolowat.c

[ ... ]

> +static int tcp_init_autolowat_cb(struct bpf_tcp_sock *btp)
> +{
> +	struct tcp_autolowat_cb *cb;
> +	struct tcp_sock *tp;
> +
> +	cb =3D bpf_sk_storage_get(&tcp_autolowat_map, btp, 0,
> +				BPF_SK_STORAGE_GET_F_CREATE);
> +	if (!cb)
> +		return -1;
> +
> +	tp =3D bpf_core_cast(btp, struct tcp_sock);
> +
> +	cb->rpc_desc_seq =3D tp->copied_seq;
> +	cb->rpc_end_seq =3D tp->copied_seq;
> +#ifdef DEBUG
> +	cb->isn =3D tp->copied_seq;
> +#endif
> +

[Severity: Medium]
Should cb->rpc_desc_buff_len be reset to 0 here as well?

If an application re-initializes parsing by calling setsockopt again on
the same socket, tcp_init_autolowat_cb() resets the sequence numbers but=20
leaves the buffer length intact. If the storage entry already existed=20
from a previous operation that had read a partial RPC descriptor, the stale=
=20
parser state will persist and could corrupt the next parse operation.

> +	return bpf_tcp_ops_set_flags((struct tcp_sock *)btp,
> +				     BPF_TCP_OPS_FLAG_RCVQ, 0);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006192601.1875=
100-1-kuniyu@google.com?part=3D10
