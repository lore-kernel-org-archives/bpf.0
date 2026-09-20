Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3386229B228
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789935114; cv=none; b=QGiE2Ki/utv19dE9ZOWetjwATcY9cLgGujXA4sYf011x+jDGn0JiHv4BSw+81tXMncEmAXJbFYgPJd5vXlRuCSGFjWVXoAQs4dfipW4DXbfwNtzpq9qcFSXchhIteMa42/F11+07oclSoFmrNKaLJtlyjr2U4Ll6AR4dLaL5gsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789935114; c=relaxed/simple;
	bh=5Jrb3Spufrx339CT6lq9CG0cjEoF7vNJC/KN6cPQ9xw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQt+aFCzykk/LMnMEUl7rfSDAOQPBlu+3evu+if31KL7IP7H1aIctcNwtQhKFiAkcZxahPip+8s5vtWsl+SuwOVbCeMf2ptbHteIlf9YmDUrkNlQ04pEtvq7EtJ8QXsJPXTC8toQ2FvwP0IaKNiNiaPKlnxKZMQmE9Zl4Cy5Oa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YapnhfXe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YapnhfXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CED21F000FF;
	Sun, 20 Sep 2026 20:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789935112;
	bh=k6H3HStpUBavrH86DF0jsCslob2KE47xaZn4+3Ut8mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YapnhfXeYQ1jDu2bLTUX//Ql666lsnbSD0ZMf60wGVC81SZDUJlPA4UpQEdhdFr6n
	 37SLNQuhP4uh411LqSYOcomhZLMGl6uyZ3FCPSWlGUDGyL/e2ZVttBkBuQuAGClZmn
	 PCO0RRJ1orutcOZ33zFIDxEBCO4phq7DwCzEM8+vTdvtYXKFu4ejcge54w+H7P7UcU
	 CH7k5drL55mCnBMYH70L8WLQhrX+cBuA3oGuxocB8KzGDuMCgthl6rgaFq95ZWJn5g
	 Q7nZhn4kEeqd/x7tFICpuv7fPi5dbzpYlWHnrKO3B8zJTmYnFYrJXUQTPeIgbYg0lc
	 qlhFTMLdzrKig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/7] bpf: tcp: Support
 bpf_sock_ops_cb_flags_set() for bpf_tcp_ops.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920195633.3033620-4-kuniyu@google.com>
References: <20260920195633.3033620-1-kuniyu@google.com>
 <20260920195633.3033620-4-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 20:11:52 +0000
Message-Id: <20260920201152.8CED21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: data race in bpf_tcp_ops_cb_flags_set() on unlocked sockets
--

commit 56d7f542a8c499237807954e17f2fae35e5e276b
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Support bpf_sock_ops_cb_flags_set() for bpf_tcp_ops.

This patch allows clearing or setting bpf_sock_ops_cb_flags via the
bpf_sock_ops_cb_flags_set() helper within various bpf_tcp_ops callbacks.

> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index c68d1fa323058..6d0452441b6c5 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
[ ... ]
> @@ -220,6 +220,24 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval_p=
roto =3D {
>  	.ret_type	=3D RET_INTEGER,
>  };
> =20
> +BPF_CALL_2(bpf_tcp_ops_cb_flags_set, struct sock *, sk, int, argval)
> +{
> +	int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> +
> +	tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
If an unlocked socket is passed to bpf_tcp_ops_cb_flags_set(), it looks like
concurrent updates to the flags from other CPUs could be clobbered, causing
BPF TCP callbacks to fail to invoke when expected.

Does this code modify the socket flags without acquiring the socket lock
or asserting that the socket is currently owned by the caller?

> +
> +	return argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS;
> +}
> +
> +static const struct bpf_func_proto bpf_tcp_ops_cb_flags_set_proto =3D {
> +	.func		=3D bpf_tcp_ops_cb_flags_set,
> +	.gpl_only	=3D false,
> +	.ret_type	=3D RET_INTEGER,
> +	.arg1_type	=3D ARG_PTR_TO_BTF_ID,
> +	.arg1_btf_id	=3D &btf_sock_ids[BTF_SOCK_TYPE_TCP],
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Since the verifier accepts any PTR_TO_BTF_ID of type TCP here, it seems
privileged BPF programs could pass refcounted but unlocked sockets, leading
to the data race mentioned above.

Could the use of ARG_PTR_TO_BTF_ID allow a BPF program to pass an unlocked
socket obtained via helpers like bpf_sk_lookup_tcp() and bpf_skc_to_tcp_soc=
k()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920195633.3033=
620-1-kuniyu@google.com?part=3D3
