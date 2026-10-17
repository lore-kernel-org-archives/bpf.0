Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854FC36D51B
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202750; cv=none; b=K4samT8YfvOd3ZT4U6JBqV5doFu4OyMh+13AdmZtkVAAlzTFmie5yGI1BETcsSCpJB6MQK/Of8I4SlARHK5xRl03MPPfXr6jqDhyiu12VmaeYNQ98UUn4t5DkiR4MFLY3UO4hl2kKcAZQ8EX/Bbj+WyiLvh27SzgDFNcXfwFU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202750; c=relaxed/simple;
	bh=4toXYb0eeK2tXIJYi0odjZCiG5UMArvUNKNmuPqeDC4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=ouHurG1b5QH19ufgVrRRUxodhabDPhkjqahhCt7wkKTsZW2+e1i8Y02TEbFpZxs7No7cB9whR79hl367UsZK17VnLCcwvWQEOC1WJy4TTzhKZB1miZxmgrsRug7TjPoKdAp8gzq96tHxYXI4BIDXbwt8AxqSfNgtT97atRgHLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAYzYvRT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAYzYvRT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BF31F000C4;
	Sat, 17 Oct 2026 02:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792202749;
	bh=vDtxz7fUXozxGW4XUpfJRqZT54NdygM/HAW9nV9W7bU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AAYzYvRTU4rc5d+FfhDQCvpxTr8Fza614hUXSe+qDjSEk2hGwzC4QWEnDVhTd1v6W
	 sn2Ey7rBfnTQdcgLWgfpiDLuoy8HPt6J12n85jG+pJ0cu7KToaFeQATbZvcBygxdk1
	 +OP7f6cLEGjQP4l8h8THehsstcX05SqgOT8OzSYYy8Vtp+CRV6ewHZ0NwZ2DZ4iOWr
	 Zhdulpb1UeISwiflETM8OZ54l9ZxvcLolPtCAgdoFPw6uHojYyFeihhIwem43Mxf/f
	 h4q1t5Omqy4dSBSHTSlQydSJ6nnFmPMDP380lQ0jAH/viYIdLWcxPmI2aISp9J6Vbg
	 MDAQA/almuVgw==
Message-ID: <sashiko-outbox-175187@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 26/38] bpf: Assume no bounds for a writable tp
 with tail calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261017012451.364800-18-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
 <20261017012451.364800-18-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:05:48 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: max_tp_access check bypassed via BPF_PROG_TYPE_EXT on writabl=
e raw tp
--

commit 467f1021d59430c1b54a88fe6072cc36e60eb149
Author: Josef Bacik <josef@toxicpanda.com>

bpf: Assume no bounds for a writable tp with tail calls

This commit sets max_tp_access to U32_MAX when a
BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE program performs a tail call,
preventing it from attaching to a writable raw tracepoint and tail-calling a
program that accesses beyond the tracepoint buffer bounds.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 002c3935a8eb0..fe59e3114d828 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -2153,6 +2153,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
>  			prog->aux->max_pkt_offset =3D MAX_PACKET_OFF;
>  			prog->aux->max_rdonly_access =3D U32_MAX;
>  			prog->aux->max_rdwr_access =3D U32_MAX;
> +			if (prog->type =3D=3D BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE)
> +				prog->aux->max_tp_access =3D U32_MAX;

[Severity: High]
Can the max_tp_access check still be bypassed using a BPF_PROG_TYPE_EXT
(freplace) program attached to a BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE
target program?

A target program (tgt_prog) of type BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE
with prototype int prog(struct bpf_raw_tracepoint_args *ctx) (or a global
subprogram taking struct bpf_raw_tracepoint_args *ctx) that does not access
ctx->args[0] or call bpf_tail_call() is loaded with
tgt_prog->aux->max_tp_access =3D=3D 0. Because
find_canonical_prog_ctx_type(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) resolves
to struct bpf_raw_tracepoint_args, btf_prepare_func_args() marks its BTF
signature as reliable.

When attaching tgt_prog, bpf_probe_register() in kernel/trace/bpf_trace.c
only validates max_tp_access on the root attached program:

kernel/trace/bpf_trace.c:bpf_probe_register() {
    ...
	if (prog->aux->max_tp_access > btp->writable_size)
		return -EINVAL;
    ...
}

This succeeds for any raw tracepoint (even when btp->writable_size is 0)
since tgt_prog->aux->max_tp_access is 0.

Meanwhile, a BPF_PROG_TYPE_EXT program (ext_prog) targeting tgt_prog or its
global subprogram passes bpf_check_attach_target(), inherits
raw_tracepoint_writable_verifier_ops in check_attach_btf_id(), and has its
struct bpf_raw_tracepoint_args *ctx argument typed as PTR_TO_CTX in
btf_prepare_func_args():

kernel/bpf/verifier.c:check_attach_btf_id() {
    ...
	if (tgt_prog && prog->type =3D=3D BPF_PROG_TYPE_EXT) {
		/* to make freplace equivalent to their targets, they need to
		 * inherit env->ops and expected_attach_type for the rest of the
		 * verification
		 */
		env->ops =3D bpf_verifier_ops[tgt_prog->type];
		prog->expected_attach_type =3D tgt_prog->expected_attach_type;
	}
    ...
}

In bpf_do_misc_fixups(), the check added here tests
prog->type =3D=3D BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE rather than
resolve_prog_type(prog), so it does not match when ext_prog
(prog->type =3D=3D BPF_PROG_TYPE_EXT) calls bpf_tail_call() (which is permi=
tted
when the replaced function has changes_pkt_data set, such as via
bpf_dynptr_write() or bpf_dynptr_memset() on a local dynptr, or when
CONFIG_NET=3Dn). However, __bpf_prog_map_compatible() in kernel/bpf/core.c
uses resolve_prog_type(fp):

kernel/bpf/core.c:__bpf_prog_map_compatible() {
    ...
	enum bpf_prog_type prog_type =3D resolve_prog_type(fp);
    ...
}

This allows ext_prog to tail-call into a BPF_MAP_TYPE_PROG_ARRAY of
BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE programs that read and write past
btp->writable_size.

Furthermore, even if ext_prog directly accesses ctx->args[0] (which
raw_tp_writable_prog_is_valid_access() types as PTR_TO_TP_BUFFER) or has
ext_prog->aux->max_tp_access set to U32_MAX, check_tp_buffer_access() only
updates ext_prog->aux->max_tp_access, which is never validated against
btp->writable_size or propagated to tgt_prog.

Should BPF_PROG_TYPE_EXT programs be disallowed from targeting
BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE programs (similar to how iterator
programs reject extensions in commit "bpf: Don't take an extension for an
iterator program")?

> =20
>  			/* mark bpf_tail_call as different opcode to avoid
>  			 * conditional branch in the interpreter for every normal

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017012058.3557=
87-1-alexei.starovoitov@gmail.com?part=3D26
