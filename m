Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795622213;
	b=a6VnmObGuMKO3hp8C2jYsAaQcV6Gus8s+lv1ZPkwuaTSsfkw9h4iHcRpRUB2/NWyP3Mb
	 JNdx6PpZjVszpCMVaej8BAWLSk9vTwl4ZuUqs4qASPbgil7JEqH45q/Ym2rwGKzrOzIbU
	 K7DMZqQXqzo/CZDFcpqBdJVhRGa3+q6u+ePX6+80UuVYz5n3wCUlEJJb5L/Jn/cPGdBI+
	 JgfgslOc37vXDIYtsM1ZO3z2vKTOX/rBrf2AwxHYRU05VNoGssTiaXzI4iY4dQpwctV9N
	 zWIjvy4SSPToHoaNy7ebKg/32yu7EHZ07RHiixpiFktAUYVC/7FgeXcutgSqgz3CEPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795622213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3BsMTfN8EK2sRtS9UbWW9tI0tLzMBpAynlivNPOxJtg=;
	b=YM7G3Du42mEwW3SUegnRp7vYThrfZbukNMqO3Dlwe5Hw+ADbxKAHBAm3r/EgW1P9F+Fb
	 VsooWZCaVYKASUgHF8N+ZgWfGljIKRDDgmJ60ZOUyXf9SgR+wFP0KK0NEXolT/mpupyeF
	 wANKF+vG13Q6H6P2OrjmAD2u5yHS/Fl5iNzEhqvRNO5QmeTo2a+n1X0KBOdRMR+CAQeaO
	 yAYEtUHMs135+y4qr4ZtRT66YPXx5KGsP9POPwfk8XgwY3dlxc0ietietO2aJV1ZRxLn/
	 Eu4PiJJrnnPFyj4bO0bBZoehIWF8S8XEgYv2IbAQgR27E6QNGKH8u+na6L9RGx7seUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQGYOQNp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4C606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SQGYOQNp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7201F000CA;
	Wed, 25 Nov 2026 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795622213;
	bh=3BsMTfN8EK2sRtS9UbWW9tI0tLzMBpAynlivNPOxJtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SQGYOQNpG2NTkPlhfZEgbOVHSODMAIbMrp8sLzeRGZVRuJMJ/FrM1PfpKLioqArWX
	 vOdY/RCrswkPm6Nt4PXPMluCjHl8IGn+mCBCP42dUUfqOXcw09TlqyPG6AuQ1f1evo
	 Qun1DUqEzq6c8nWCxSCUHSTH2vZng/gB4oGWdL1jGcLaHBdKi3vLie/+Csw2ML41Lr
	 0rGuV1KW6DNVnIvPWPKr4pZoaaRx9x3/jjH0nlXrd/uNI6zojjwQBEwPHcZFO2L7Gw
	 QYOl0/M1sFyJ1afKxDgOJZBdutlBq+VKRvJNiGRBUkDpkOXPdBBORaaXQhoBaApiM3
	 Ntpx+TyOxWqKg==
Message-ID: <sashiko-outbox-233687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 5/7] libbpf: Pass in token_fd when iterating
 kernel BTF objects
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261125-bpf-relax-get-next-id-v1-5-49175227c8cf@toke.dk>
References: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
 <20261125-bpf-relax-get-next-id-v1-5-49175227c8cf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 15:56:52 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] libbpf: EINVAL retry in load_module_btfs() skips EPERM and
  ENOENT checks
- [Medium] libbpf: unhandled EPERM in load_module_btfs() after token
  retry and fd fetch
--

commit 5f5f5856a82ba2af642d2a227760228210dc3824
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

libbpf: Pass in token_fd when iterating kernel BTF objects

This commit passes obj->token_fd to bpf_btf_get_next_id_opts() and
bpf_btf_get_fd_by_id_opts() in load_module_btfs(), retrying without a
token if the kernel returns EINVAL.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2ede3081a20eb..65c2af92db2f3 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6014,6 +6014,10 @@ static bool is_btf_mod_allowed(const struct bpf_ob=
ject *obj, const char *name)
> =20
>  static int load_module_btfs(struct bpf_object *obj)
>  {
> +	DECLARE_LIBBPF_OPTS(bpf_get_next_id_opts, next_opts,
> +			    .token_fd =3D obj->token_fd);
> +	DECLARE_LIBBPF_OPTS(bpf_get_fd_by_id_opts, fd_opts,
> +			    .token_fd =3D obj->token_fd);
>  	struct bpf_btf_info info;
>  	struct module_btf *mod_btf;
>  	struct btf *btf;
> @@ -6038,20 +6042,26 @@ static int load_module_btfs(struct bpf_object *ob=
j)
>  		return 0;
> =20
>  	while (true) {
> -		err =3D bpf_btf_get_next_id(id, &id);
> +		err =3D bpf_btf_get_next_id_opts(id, &id, &next_opts);
>  		if (err && errno =3D=3D ENOENT)
>  			return 0;
>  		if (err && errno =3D=3D EPERM) {
>  			pr_debug("skipping module BTFs loading, missing privileges\n");
>  			return 0;
>  		}
> +		if (err && errno =3D=3D EINVAL && next_opts.token_fd) {
> +			pr_debug("retrying module BTF load without token fd\n");
> +			next_opts.token_fd =3D 0;
> +			fd_opts.token_fd =3D 0;
> +			err =3D bpf_btf_get_next_id_opts(id, &id, &next_opts);
> +		}
>  		if (err) {
>  			err =3D -errno;
>  			pr_warn("failed to iterate BTF objects: %s\n", errstr(err));
>  			return err;
>  		}

[Severity: Medium]
Should the EINVAL retry in load_module_btfs() run before the ENOENT and
EPERM checks?

On an older kernel that rejects next_opts.token_fd with EINVAL, the
retried bpf_btf_get_next_id_opts() call without a token can return EPERM
(for example, inside an unprivileged user namespace) or ENOENT.  Because
those checks precede the retry block, load_module_btfs() falls through to
if (err) and fails with -EPERM or -ENOENT instead of skipping module BTF
loading and returning 0.

> =20
> -		fd =3D bpf_btf_get_fd_by_id(id);
> +		fd =3D bpf_btf_get_fd_by_id_opts(id, &fd_opts);
>  		if (fd < 0) {
>  			if (errno =3D=3D ENOENT)
>  				continue; /* expected race: BTF was unloaded */

[Severity: Medium]
What happens if bpf_btf_get_fd_by_id_opts() fails with EPERM after
bpf_btf_get_next_id_opts() succeeds?

In kernel/bpf/syscall.c, bpf_obj_get_next_id() only requires
bpf_token_allow_cmd(token, BPF_BTF_GET_NEXT_ID) and CAP_BPF, whereas
bpf_btf_get_fd_by_id() requires bpf_token_allow_cmd(token,
BPF_BTF_GET_FD_BY_ID) and CAP_SYS_ADMIN.  If the caller or token has
CAP_BPF without CAP_SYS_ADMIN (or allows BPF_BTF_GET_NEXT_ID without
BPF_BTF_GET_FD_BY_ID), bpf_btf_get_next_id_opts() succeeds and
bpf_btf_get_fd_by_id_opts() fails with EPERM, where the error path below
only ignores ENOENT and aborts load_module_btfs() with -EPERM instead of
skipping module BTF loading and returning 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-bpf-relax-=
get-next-id-v1-0-49175227c8cf@toke.dk?part=3D5
