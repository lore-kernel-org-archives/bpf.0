Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C7ECA5A
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 00:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781916523; cv=none; b=Yo2PZQbN7cMjWA19b/mLzwNspAawAOxUJQHKAgxGzSZnUP8mnNrH/nIHyxj8GiRJuVNRnkxDHPsZ9icPF8pC5s9Rpj20jjVSFi6eVbxa1WnBvgBq+P/duWjfx8qSGBZwgEro9Im1Xy2PldtMqmKliiyuWpvv+qBMs6NzFKl7F/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781916523; c=relaxed/simple;
	bh=nUfycij5EaLTdZ8cEL9q3xhoP7pKUHkI/PEJ+8ICzJ0=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZQ2QWGf/mdXdrIrDNxKZaixLVitXYGo12xfSSGFoqxsd17fkmCuoBtLgccERhnXdYh1GjES7IyNhVj1jl8rYtm/p/pG6YxU4ltLHpbFxnOWUjTyaXGnKqL+nZL6E+mqchmAv8KQ38LlpElS4fzcz/GMgM5GcgoYqaM7Eut0hx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fai+m5t9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fai+m5t9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463861F000E9
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 00:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781916522;
	bh=FdYWK9JC/umDICJAnrcCPif7rHBCvW6VHHd/ajv2iRM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Fai+m5t9Px8swtF9jTS9thY0pWBifkO45EyHKpE8tAXsRlhfizIUUiShKFkDZVrtZ
	 TsgfdINNgCDLXQ4GtH/q/CGOh/SzzG5R85tLrCymXjqiFt0JPVC9gt+z1Ugs+F3GQp
	 nLTqHf7PU/D4mU2jJebfoRVKViAIDSp0+9zN3H7a32kSuIE5OodcNlFxm878BWznFW
	 xgzD0fJS1eMepYNmV8ZxeM2ezuBzBjaQrKF8VQ+VE2qt+DoWdQz0bgQM/Yior5nUMB
	 xv6KEzJhLsASW+VYUCBQ990PjrmZ96J9hz+P5CCeJpsFUhLuYHkkCPHyGJeAiScgYT
	 X3VKT5EWFV78g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: tcp: Fix use-after-free in
 bpf_iter_tcp_established_batch()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
References: <20260620-bpf-iter-tcp-refcnt-v1-1-883bf9e69495@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 00:48:41 +0000
Message-Id: <20260620004842.463861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double put / invalid pointer dereference when bpf_iter_tcp_realloc=
_batch fails.
--

commit a46eb4f81a6720ac273041ac646bef28306e6aea
Author: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()

reqsk_queue_hash_req() publishes a TCP_NEW_SYN_RECV request_sock onto
the ehash chain (via inet_ehash_insert(), which drops the bucket lock on
return) and only afterwards refcount_set()s rsk_refcnt to 3.

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fdc81150ff6cf..92342dcc6892a 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
[ ... ]
> @@ -3129,6 +3129,7 @@ static struct sock *bpf_iter_tcp_batch(struct seq_f=
ile *seq)
>  	struct sock *sk;
>  	int err;
> =20
> +again:
>  	sk =3D bpf_iter_tcp_resume(seq);
>  	if (!sk)
>  		return NULL; /* Done */

[Severity: High]
This isn't a bug introduced by this patch, but could this error path later
in bpf_iter_tcp_batch() trigger a double put and invalid pointer dereferenc=
e?

If bpf_iter_tcp_realloc_batch() fails:

	/* Batch size was too small. */
	bpf_iter_tcp_unlock_bucket(seq);
	bpf_iter_tcp_put_batch(iter);
	err =3D bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
					 GFP_USER);
	if (err)
		return ERR_PTR(err);

bpf_iter_tcp_put_batch() replaces the socket pointers with numeric cookies,
but it uses a local variable and leaves iter->cur_sk and iter->end_sk
unchanged.=20

When the iterator is aborted, the stop handler bpf_iter_tcp_seq_stop() is
called:

static void bpf_iter_tcp_seq_stop(struct seq_file *seq, void *v)
{
	...
	if (iter->cur_sk < iter->end_sk)
		bpf_iter_tcp_put_batch(iter);
}

Since the condition remains true, bpf_iter_tcp_put_batch() will be called a
second time on the same elements, but now passing the integer cookie to
sock_gen_put() as if it were a valid pointer. Can this cause a panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620-bpf-iter-t=
cp-refcnt-v1-1-883bf9e69495@linux.dev?part=3D1
