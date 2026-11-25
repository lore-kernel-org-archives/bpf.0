Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578931;
	b=b22Wr8S6vpfJpHjKqM3iiiF0LCaxvnwh2hOwSdae85UUu1M0kbBuViR0bS6BbWCy91gX
	 vEpVdRGnVlEl2lpnJ7wUM8SB/LwUdMvJXYAuOVBYlAv1fjTM5TCxV0P+E+SDL8+7dU6fV
	 PtQ0J4TTCCR4/d2vjXKz7EkAzV//378o76FYaFIfvQSTJnMXAVXawMCQTIHpoYQc/66lq
	 B4z/W3TT6OtKkG1yQP/w76HwOzoJ5yhybIfZVsWj/cMAmLqkqxdHHL2fqrt1SpgZaug3y
	 t+783jql2sRHGzYe9EqSQktPlCMEFYn5+EwYiBJMCclcziapxib2EZLW6fVd50zG0kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578931;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E8J6WM5dHn8vim5OCm7VfFDLxI7v7Vz4h27aGjhg+2Y=;
	b=rBKCZaV4kB6OV56e7QIrDJuJirh0MsmyZLm4UfKgDMACPIVp9txhanHtQW0tRX1dvitB
	 ieImBKRz7IrlXZ8/oca2NCTRGAulE2qdX6SHGJQ09s5g1rND5NpROdBq1L3nzBPbLf9Dk
	 OOxf2YpaWMiy3ioy+WA8n1C+0vZ4PYjUtEB6HQJgX/FbKnMNcdGuL5xlb2UbpixlmqB65
	 BSYAhUE38z2sjV5YemuFrr1HZFWTpd9l+FQQJEJfaBhq9F/va14M/hVgNxWQ9rsgWmtOl
	 HTLqgL5Z+HnB++CeH+9+7t6XFq2wlSOSnNmmguCPA18T1ZEUsuGbLtsjfoYjL1gXEug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1p5kVeh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838B606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1p5kVeh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D865C1F000C0;
	Wed, 25 Nov 2026 03:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795578931;
	bh=E8J6WM5dHn8vim5OCm7VfFDLxI7v7Vz4h27aGjhg+2Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=m1p5kVehe1YWzHmsT+QBPICg7fdSOx/E6yyicGwFsvAUH91OcUkXiCgr09i5YKk/B
	 VqaSrJmCYAvTY+n2hTzOlyjL0pfKUD1ZtD7ZFAWh50n3tShw5UFAD5EeL7x7Yljogd
	 i61JzjnzQcLKr4IQTTfQW2DdksPf1PP2y9MCYXhmAsRI7JubHeU0MxxTDfJ9a9P3gv
	 6EaOnBWsX7yLKm7KcytDxWGL3N4P1mUyxVkbp/x6rUpjStwX0YltBZHrktaMNdQ2gj
	 H1zEjy6iW9Bu5BjeRmtsRsArZ+0fvOw5nVLwzTxGVriDfI1c5yFvSMj8egL5TL50ln
	 pv8/m6QnLEKIg==
Message-ID: <sashiko-outbox-232533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 25/47] bpf: Give syscall programs without
 CAP_PERFMON the base helpers only
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261125032938.670542-26-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
 <20261125032938.670542-26-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 03:55:30 +0000
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
- [Critical] bpf: syscall_prog_func_proto() still allows loader helpers
  in async callbacks
--

commit 0b17252c17a9909e5f5169c092eff3dd514adbd9
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Give syscall programs without CAP_PERFMON the base helpers only

This commit restricts BPF_PROG_TYPE_SYSCALL programs loaded without
CAP_PERFMON to bpf_base_func_proto() helpers instead of allowing loader and
tracing helpers.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 03cb9f769398b..e82ae48c0bc07 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6747,10 +6747,12 @@ static const struct bpf_func_proto bpf_kallsyms_l=
ookup_name_proto =3D {
>  static const struct bpf_func_proto *
>  syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog =
*prog)
>  {
> +	if (!bpf_token_capable(prog->aux->token, CAP_PERFMON))
> +		return bpf_base_func_proto(func_id, prog);
> +
>  	switch (func_id) {
>  	case BPF_FUNC_sys_bpf:
> -		return !bpf_token_capable(prog->aux->token, CAP_PERFMON)
> -		       ? NULL : &bpf_sys_bpf_proto;
> +		return &bpf_sys_bpf_proto;
>  	case BPF_FUNC_btf_find_by_name_kind:
>  		return &bpf_btf_find_by_name_kind_proto;
>  	case BPF_FUNC_sys_close:

[Severity: Critical]
Does this still allow bpf_sys_bpf(), bpf_sys_close(),
bpf_btf_find_by_name_kind(), and bpf_kallsyms_lookup_name() to run inside
bpf_wq and bpf_task_work callbacks when the program has CAP_PERFMON (includ=
ing
via a delegated bpf_token in a non-initial user namespace)?

As noted in the commit message, these loader helpers operate on current.  B=
ecause
is_async_cb_sleepable() marks bpf_wq and bpf_task_work callbacks as sleepab=
le
and neither syscall_prog_func_proto() nor check_helper_call() rejects these
helpers in async callbacks, a program passing the CAP_PERFMON check can sti=
ll
invoke them from those callbacks:

- In a bpf_wq callback, current is a kworker running with init_cred in
  init_user_ns and init_files, so bpf_sys_bpf() executes __sys_bpf() with f=
ull
  init_user_ns capabilities and no token restrictions, and
  bpf_kallsyms_lookup_name() checks bpf_dump_raw_ok() against the kworker's
  credentials.
- In a bpf_task_work callback, current is the target task, allowing
  bpf_sys_close() to close arbitrary file descriptors of another process.  =
If
  the callback runs from exit_task_work() during do_exit() after exit_files=
()
  has set current->files to NULL, calling bpf_sys_close(), bpf_sys_bpf(), or
  bpf_btf_find_by_name_kind() (for a module BTF) causes a NULL pointer
  dereference in file_close_fd() or alloc_fd().

Should check_helper_call() reject these =E0=A4=9A=E0=A4=BE=E0=A4=B0 loader =
helpers when
env->subprog_info[env->cur_state->frame[0]->subprogno].is_async_cb is set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125032938.6705=
42-1-alexei.starovoitov@gmail.com?part=3D25
