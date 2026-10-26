Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030753;
	b=E5s0IZ5CKoaw5YojYb5slFWeOGEZI50S6u2zJBU2EzU+gxIi3L2wAJJFvbV6vFbvVzR8
	 FTWYtV2TcFgym2aB4KDoGMEdUr6H5lIMvcfM8ay2FDWirWfD+f2CEWB3E6Ep9gHJZnYjr
	 g1YaTmaEGSbDCtNHceguLC9zB789kOXZAiE3NQgYoaGxVGvjN4ca7F+AGIbN6YZ+RWm/G
	 6SjuL4C8oUS50g3tyaX15DIj2k+CYjXLt/ZNIX1lOqCUV7CCxkNxdyf/n8+AfVkmdNt4K
	 v8r1RYyKVs5Qr9r2eh8CvnyYUYH53OctPDjnbGmsDxBIf23NfD+AofgORTRYBoinRsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030753;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0y9xtY2rLMDX9/mRTOpi/et5lOz0nmBeGks4StikzGc=;
	b=4REMk1SwNNukO9UZ9sXg8k1Y/s8CxrfitlvMm6NTmBeD0iliWjtaZeM9g7eQ05qNi78M
	 D3BbKmeoUc0Q1HnnZYKxXSB29LgAQN147lDZQaXglO+Ohae4AkN+WwgRnIpvC1y0iudEq
	 Iw/138+cASzSZ+9KL93JY+C8bvsHcDsGLBnQ44fU0PoqoL7hAQUtz96wRd4TOCF6TK5RU
	 rwFfRE1HnfEDU/e2m+CmLIiR4uF1XsIei/C1u56wQzXjAVY5YRkZgDBdE9Z9ES6lgg1Qa
	 xglf3vt+BJjIhiK5BcMQr3ZmybKd0s6cvIEsf1KTzwmwIPMnUNtXnoCXUkbAyeSBFpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uypo90Xo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABC606A31E;
	Mon, 26 Oct 2026 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uypo90Xo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523BC1F01825;
	Mon, 26 Oct 2026 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030753;
	bh=0y9xtY2rLMDX9/mRTOpi/et5lOz0nmBeGks4StikzGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uypo90XoVAxwvV0Hkyb+FXZBgp9ET9IuFGg985FifIEN1FbKQ2P7vmRBB4xD/Zwsg
	 7QHV55pEs1m6nd1m+4AUNW4TaSkpkVWwUYsEuszyRwz4btWuaPf3g7IROZF25qBY12
	 QmvJcrvCGpFkKJijJCZlvUkMl9XJmac6U0x0gTI+PoHREY3nfIP3Xa946CKRlOqKlA
	 jnsOnbvJKJAn29EFSbAV+auhNPg+DGLF+3qon1s7xzxf1WS0JhBs9b3FEaCRmmqt2C
	 sTgRkOurjJMCdCBSONMCg/AJzHfu+slgven8GNmw8aoFLBYACmZamvJMqgL21R8eyT
	 1z1FSYWm6C49g==
Message-ID: <sashiko-outbox-185491@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 5/6] libbpf: Add log_opts support for
 bpf_link_create
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261026154948.99408-6-leon.hwang@linux.dev>
References: <20261026154948.99408-1-leon.hwang@linux.dev>
 <20261026154948.99408-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 16:05:52 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] libbpf: type confusion between iter_info and log_opts in bpf_lin=
k_create()
--

commit b4af2771f4c0edb6656b6ddcd881019158c55a55
Author: Leon Hwang <leon.hwang@linux.dev>

libbpf: Add log_opts support for bpf_link_create

This commit adds log_opts support to bpf_link_create() by placing log_opts =
in
an anonymous union with iter_info in struct bpf_link_create_opts and passing
it to __sys_bpf_fd().

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index aea534764dfe2..38dcb31e8c0ed 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -794,6 +794,8 @@ int bpf_link_create(int prog_fd, int target_fd,
>  {
>  	const size_t attr_sz =3D offsetofend(union bpf_attr, link_create);
>  	__u32 target_btf_id, iter_info_len, relative_id;
> +	union bpf_iter_link_info *iter_info =3D NULL;
> +	struct bpf_log_opts *log_opts =3D NULL;
>  	int fd, err, relative_fd;
>  	union bpf_attr attr;
> =20
> @@ -803,6 +805,14 @@ int bpf_link_create(int prog_fd, int target_fd,
>  	iter_info_len =3D OPTS_GET(opts, iter_info_len, 0);
>  	target_btf_id =3D OPTS_GET(opts, target_btf_id, 0);
> =20
> +	if (iter_info_len && attach_type !=3D BPF_TRACE_ITER)
> +		return libbpf_err(-EINVAL);
> +
> +	if (iter_info_len)
> +		iter_info =3D OPTS_GET(opts, iter_info, (void *)0);
> +	else
> +		log_opts =3D OPTS_GET(opts, log_opts, (void *)0);

[Severity: Medium]
Can overlaying iter_info and log_opts in struct bpf_link_create_opts and
selecting between them using only iter_info_len cause type confusion when a
caller passes a non-NULL iter_info with iter_info_len =3D=3D 0?

For example, a caller of bpf_link_create() or bpf_program__attach_iter() in
tools/lib/bpf/libbpf.c:

tools/lib/bpf/libbpf.c:bpf_program__attach_iter() {
	...
	link_create_opts.iter_info =3D OPTS_GET(opts, link_info, (void *)0);
	link_create_opts.iter_info_len =3D OPTS_GET(opts, link_info_len, 0);
	...
	return bpf_link_create(prog_fd, target_fd, BPF_TRACE_ITER, &link_create_op=
ts);
}

might pass a non-NULL union bpf_iter_link_info pointer while leaving
iter_info_len (or link_info_len) set to 0.

Previously, bpf_link_create() forwarded both the non-NULL iter_info pointer
and iter_info_len =3D=3D 0 to the kernel, where bpf_iter_link_attach() reje=
cted
the mismatched arguments with -EINVAL:

kernel/bpf/bpf_iter.c:bpf_iter_link_attach() {
	...
	if (bpfptr_is_null(ulinfo) ^ !linfo_len)
		return -EINVAL;
	...
}

With this change, when iter_info_len =3D=3D 0, bpf_link_create() leaves ite=
r_info
as NULL (so attr.link_create.iter_info is 0 and the kernel check is bypasse=
d)
and instead assigns the union bpf_iter_link_info pointer to log_opts.

When bpf_link_create() then calls __sys_bpf_fd(), log_opts is dereferenced =
as
struct bpf_log_opts:

tools/lib/bpf/bpf.c:__sys_bpf_fd() {
	...
	if (!OPTS_VALID(log_opts, bpf_log_opts))
		return libbpf_err(-EINVAL);

	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
		memset(&attr_common, 0, attr_common_sz);
		attr_common.log_buf =3D ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
		attr_common.log_size =3D OPTS_GET(log_opts, size, 0);
		attr_common.log_level =3D OPTS_GET(log_opts, level, 0);
		fd =3D sys_bpf_ext_fd(cmd, attr, attr_sz, &attr_common, attr_common_sz);
		OPTS_SET(log_opts, true_size, attr_common.log_true_size);
	} else {
		fd =3D sys_bpf_fd(cmd, attr, attr_sz);
		OPTS_SET(log_opts, true_size, 0);
	}
	...
}

Since union bpf_iter_link_info is 16 bytes while struct bpf_log_opts extends
to offsetofend(struct bpf_log_opts, true_size) (28 bytes on 64-bit, 20 bytes
on 32-bit), interpreting the first sizeof(size_t) bytes of iter_info (such =
as
map.map_fd, task.tid, task.pid, or cgroup.cgroup_fd) as log_opts->sz can
cause out-of-bounds reads in OPTS_VALID() and OPTS_GET(), as well as a 4-by=
te
out-of-bounds write past union bpf_iter_link_info via OPTS_SET(log_opts,
true_size, ...).

In addition, aliasing iter_info and log_opts prevents BPF_TRACE_ITER links
from using log_opts whenever iter_info is specified. Would it be safer to
place log_opts in its own field at the end of struct bpf_link_create_opts
instead of sharing a union with iter_info?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026154948.9940=
8-1-leon.hwang@linux.dev?part=3D5
