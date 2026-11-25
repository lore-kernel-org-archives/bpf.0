Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795579119;
	b=kV+6JSDq5HwHWU3MGAFfdXzsD0TIjvhxIR0AAqb6qQy4sXPsvd4qLkK/jGmqI+xC1Hs0
	 baGJtHx2AVvetF/Hy+6C+Z6/rSi3ZoaCp6mg/aQRFv/rLSLEDc5JSKMjKcQ63fc+DLm52
	 tzfJxvHCH+dcPYEeYI3gMUzZwGVbQtqAJZ6DLpOSEDP7E5Zu/Dr3CmFm1MLjMkKS8I0oH
	 Fw9GLnbKUBbolQRmXNHNlufknteTTC/HIOt6BfdXWRpKvf/iXAIGKKgTx2qntvg0tKyOi
	 tLkAPRyoDX5GswE6WhvyVha7u17BGwZtGvzrAJDhrtPLALSw+k9PQgzjg30xcQg7g8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795579119;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XmXRLQXvMdBgfCtRsm9MEi9YqjF67aBXCT2lVfjQBDM=;
	b=gnzgGYtagMl12odSVVd68gP13jAWErW5O99ZO0VaiVxWnpDbsm4xqXUvVzU2+6LrOu1P
	 4BOCegP+UCG1skgjsGjgt5QOidyh8ErlBqlPJmbMQWnGMNj1nOIc6fkEzNxVl1MLeH9gk
	 bBsxhQIHZxmiihrB/LfGQlLNEkV7HlMcaQe5sS9JqQN2Bq4DJTamDJq3mow2Mpzf8l3TM
	 MCUOnKr+PjJxvXvJ1fDabdURFy645pkrEKee653NmM4By3s068EH3QYF1lTGQJIPuUMtN
	 1YU2aZ133WEHlEM6J/j/2VU6lCN9nKkyQlxpt5lDtGgxQ6+l3FfiPTVIBQv+A25+LiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYtVEUC2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA35606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZYtVEUC2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E771F000C0;
	Wed, 25 Nov 2026 03:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795579119;
	bh=XmXRLQXvMdBgfCtRsm9MEi9YqjF67aBXCT2lVfjQBDM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZYtVEUC2djU53HhB223Mze9Kcl6g9taTtT2tzYwtFI4su1i11KAklUcacoecyo4bv
	 CrvWh8cXDBjtHqqwJOIkX2uzbwvDelS3PZc27EZHfXYpi266AY/5JxwEnBFjTkDoHJ
	 hR6ZNL7c2wWM4J4jwspPCXSpdlRhCU6PCBeb7ic+Zhfz9ybEJhPuaMxmixvfFfXdkq
	 6JmYU5yAe4NE06WGiL8YKak674r+omkY69KIjEdJZfjVYEuLPjwsSWQoVugFSKijdL
	 vKdsQJXHg2RyXBeG09wefFPbZ+y3b5yfHtLImDczPc09OEYieG4Zbpaq0fBd4NtA5f
	 FmEB/YxoRCdiA==
Message-ID: <sashiko-outbox-232540@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 07/47] bpf: Compare what a hook tells next to its
 prototype at tail calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261125032938.670542-8-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
 <20261125032938.670542-8-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 03:58:38 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] bpf: helper restrictions bypassed via bpf_prog_hook_key() on
  tail calls
--

commit 641147c8dfcc1727cd4d5af22656fb851b62f335
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Compare what a hook tells next to its prototype at tail calls

This commit compares hook-specific properties alongside function prototypes
when checking program compatibility for tail call maps.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 14b8ee05e5063..06a0413da4897 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2515,6 +2515,18 @@ static unsigned int __bpf_prog_ret0_warn(const voi=
d *ctx,
>  	return 0;
>  }
> =20
> +/* What the verifier took from the hook, next to its prototype */
> +static u64 bpf_prog_hook_key(const struct bpf_prog *fp)
> +{
> +	if (IS_ENABLED(CONFIG_BPF_SYSCALL) && fp->aux->attach_btf_trace)
> +		return btf_raw_tp_null_mask(fp);
> +	if (fp->type =3D=3D BPF_PROG_TYPE_TRACING && fp->expected_attach_type !=
=3D BPF_TRACE_ITER)
> +		return fp->aux->saved_dst_ctx_type;

[Severity: High]
Can a kernel-function tracing program bypass per-function helper restrictio=
ns
by tail-calling another tracing program that shares the same deduplicated
attach_func_proto?

For kernel-function tracers, dst_prog is NULL, so saved_dst_ctx_type is 0 f=
or
all of them.  The verifier, however, grants or denies helpers per target
function in bpf_d_path_allowed() (by attach_btf_id) and
bpf_sk_storage_tracing_allowed() (by attach_func_name):

kernel/trace/bpf_trace.c:bpf_d_path_allowed() {
	...
	if (btf_id_set_contains(&btf_allowlist_d_path,
				prog->aux->attach_btf_id))
		return true;

	if (btf_id_set_contains(&btf_allowlist_d_path_fentry,
				prog->aux->attach_btf_id))
		return prog->expected_attach_type =3D=3D BPF_TRACE_FENTRY;
	...
}

For example, filp_close() (in btf_allowlist_d_path) and filp_close_sync()
(in btf_allowlist_d_path_fentry) have identical signatures and parameter
names in fs/open.c, so they share the same BTF_KIND_FUNC_PROTO in vmlinux
BTF.  An fexit/filp_close_sync program can therefore tail-call an
fexit/filp_close program and run bpf_d_path(&filp->f_path, ...) after
fput_close_sync() has already freed filp and its dentry, causing a
use-after-free.  Likewise, fentry/bpf_sk_storage_free shares its prototype
with fentry/sk_free and can tail-call it to invoke bpf_sk_storage_get() or
bpf_sk_storage_delete() while sk->sk_bpf_storage is being freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125032938.6705=
42-1-alexei.starovoitov@gmail.com?part=3D7
