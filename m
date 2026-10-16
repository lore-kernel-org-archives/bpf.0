Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD3941DE0A
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189347; cv=none; b=OfyRxcJxk82FetDucbblnMRQRYyMuvhMYgOIyYt1iI089FrZTNmuaz76FSSTFScs4qpWLxa2FL+7k9vNxS5nv6CFT24CkmNgArHmb8+C4FWsyIgDsQ8WX5iQ7+8VJAHQd4BF71yhN5r7OiRSN4nfNpsFoDZIOvTmVo5/wj2XCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189347; c=relaxed/simple;
	bh=pSCLhnbOT0xuuDCb5+/TSejAr07j9WSQFCgbfOQybww=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CjR8zof+Ya/CB4UjdJ3zCssHLAXTTPIBw4toRDAoUsf1WG1zrBbR+Jgg6eQ4jiQIWs/YCamhQMXFtzOB2TedbuVqKp+uJIZssGNRjFX+Cc3XdRsrNGxiMSBAMyCVZjAQ9RXNy7InZfiAQB/NQsq7L7RIiAfdLQiNFwH273jWH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls15QnIo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls15QnIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16461F000C4;
	Fri, 16 Oct 2026 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189345;
	bh=0HsTnxRHTtdIsx8vGvbuejZAU6nG7JD96gMmh5Dm6Hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ls15QnIoo1DDgWCZAkycLfdV3/hxg4lN8PC+0dIYJmGygPEWH68bvWcm9CEWigMNB
	 NE9bCiAonGXO/jCyeshrZBn0AmYHSTBTeTJcgUKoU3rzu2voZzvrt9lhNSLbUeAd/F
	 6ZbVX6xCHnz/7L5ctjRF0bXnoilzAXToiZOkJXGecPm46gc6/XPR+8joPgRFeokaRI
	 oL0VsdbKxCZDfC8O/Ld3HG3HGlbThY5+N2eEp93dg6mU2P8kxRf5lVy4TeyH35L8lb
	 qkw4XsrvOb6fmPex2gC46Uufq/IAXGAlz55Iqyuh2r4Zzgwb6rIpp/NQDxmaeB2QfQ
	 OI7qhL49fBNQw==
Message-ID: <sashiko-outbox-175008@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/3] bpf, sockmap: Restrict iter-context
 sockmap updates to iter/sockmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co>
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
 <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:22:25 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: may_update_sockmap() allows attach_func_name spoofing via dst=
_prog
- [Low] bpf: multi-line comment style violation in may_update_sockmap()
--

commit ba865d5e27181c6f2b179215e5da8fe24b46fb84
Author: Michal Luczaj <mhal@rbox.co>

bpf, sockmap: Restrict iter-context sockmap updates to iter/sockmap

This commit restricts sockmap and sockhash updates from BPF_TRACE_ITER
programs so that only iter/sockmap programs are permitted to perform them,
checking both env->prog->type and env->prog->aux->attach_func_name in
may_update_sockmap().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ddfa0c6d2755f..c63abb13ec6dd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10331,6 +10331,7 @@ static bool may_update_sockmap(struct bpf_verifie=
r_env *env, int func_id)
>  {
>  	enum bpf_attach_type eatype =3D env->prog->expected_attach_type;
>  	enum bpf_prog_type type =3D resolve_prog_type(env->prog);
> +	const char *afname =3D env->prog->aux->attach_func_name;
> =20
>  	if (func_id !=3D BPF_FUNC_map_update_elem &&
>  	    func_id !=3D BPF_FUNC_map_delete_elem)
> @@ -10341,7 +10342,12 @@ static bool may_update_sockmap(struct bpf_verifi=
er_env *env, int func_id)
>  	 */
>  	switch (type) {
>  	case BPF_PROG_TYPE_TRACING:
> -		if (eatype =3D=3D BPF_TRACE_ITER)
> +		/* iter/sockmap only; type check rejects a freplace of any
> +		 * iterator's bpf_iter_sockmap() subprog.
> +		 */

[Severity: Low]
This isn't a bug, but in the BPF subsystem multi-line comments should have
the opening /* on its own line with the comment text starting on the next
line. Should this comment in may_update_sockmap() follow that style?

> +		if (eatype =3D=3D BPF_TRACE_ITER &&
> +		    env->prog->type =3D=3D BPF_PROG_TYPE_TRACING &&
> +		    !strcmp(afname + strlen(BPF_ITER_FUNC_PREFIX), "sockmap"))
>  			return true;

[Severity: High]
Can a non-sockmap BPF_TRACE_ITER program still bypass this check in
may_update_sockmap() by specifying attach_prog_fd (dst_prog) during
BPF_PROG_LOAD?

Checking env->prog->type =3D=3D BPF_PROG_TYPE_TRACING excludes BPF_PROG_TYP=
E_EXT,
but bpf_prog_load_check_attach() in kernel/bpf/syscall.c also allows
attach_prog_fd (setting prog->aux->dst_prog) when prog_type is
BPF_PROG_TYPE_TRACING.

In kernel/bpf/verifier.c, bpf_check_attach_target() rejects tgt_prog for
BPF_TRACE_RAW_TP, but does not reject tgt_prog !=3D NULL for BPF_TRACE_ITER:

kernel/bpf/verifier.c:bpf_check_attach_target() {
	...
	if (tgt_prog) {
		...
		btf =3D tgt_prog->aux->btf;
	} else {
		btf =3D bpf_get_btf_vmlinux();
		...
	}
	...
	case BPF_TRACE_ITER:
		if (!btf_type_is_func(t)) {
			bpf_log(log, "attach_btf_id %u is not a function\n",
				btf_id);
			return -EINVAL;
		}
		...
}

When check_attach_btf_id() calls bpf_check_attach_target(), tgt_info.tgt_na=
me
is resolved from tgt_prog->aux->btf (which is user-controlled BTF) and stor=
ed
in prog->aux->attach_func_name before calling bpf_iter_prog_supported(prog):

kernel/bpf/bpf_iter.c:bpf_iter_prog_supported() {
	const char *attach_fname =3D prog->aux->attach_func_name;
	u32 prog_btf_id =3D prog->aux->attach_btf_id;
	...
	list_for_each_entry(iter, &targets, list) {
		if (iter->btf_id && iter->btf_id =3D=3D prog_btf_id) {
			tinfo =3D iter;
			break;
		}
		if (!strcmp(attach_fname + prefix_len, iter->reg_info->target)) {
			cache_btf_id(iter, prog);
			tinfo =3D iter;
			break;
		}
	}
	...
}

If a user loads a target BPF program whose BTF defines a function named
bpf_iter_sockmap at the same BTF ID as another iterator in vmlinux BTF:

1. For an iterator appearing before sockmap in the targets list (such as
   bpf_sk_storage_map, which is registered via late_initcall in
   net/core/bpf_sk_storage.c after net/core/sock_map.c), once its
   iter->btf_id is cached, bpf_iter_prog_supported() matches
   iter->btf_id =3D=3D prog_btf_id first and sets up ctx_arg_info for
   bpf_sk_storage_map. Then may_update_sockmap() sees afname as
   bpf_iter_sockmap and allows sockmap updates, and bpf_iter_link_attach()
   attaches the program to bpf_sk_storage_map. Because
   __bpf_sk_storage_map_seq_show() only holds rcu_read_lock() on
   sk_storage->owner without locking the socket, updating a sockmap with an
   AF_UNIX stream socket from this iterator can trigger the
   unix_stream_bpf_update_proto() sk_pair race described in commit
   64c2f93fc325 ("bpf, sockmap: Take state lock for af_unix iter").

2. For an iterator appearing after sockmap in targets (such as iter/unix),
   bpf_iter_prog_supported() matches "sockmap" by name at the sockmap entry
   and calls cache_btf_id(iter, prog), overwriting sockmap's cached
   iter->btf_id with the other iterator's BTF ID and breaking subsequent
   legitimate iter/sockmap attachments in bpf_iter_link_attach(). In
   addition, bpf_iter_link_replace() only compares type,
   expected_attach_type, and attach_btf_id, allowing this program to replace
   an existing iter/unix link.

Should bpf_check_attach_target() reject tgt_prog !=3D NULL for BPF_TRACE_IT=
ER
(or should may_update_sockmap() check !env->prog->aux->dst_prog)?

>  		break;
>  	case BPF_PROG_TYPE_SOCK_OPS:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-sockmap-up=
date-limit-iter-v1-1-23fa946db59e@rbox.co?part=3D2
