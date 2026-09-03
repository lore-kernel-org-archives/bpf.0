Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627149F11B
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450712; cv=none; b=OaL88M8NmV9n++OGHbwlueK9/2Z7xMjJNfDWA9ldllM3BzXEdkzyZkm859V7l0D6UwmTNFAJKMO6er4vcqT1+yEG+VyJB+elBP2d8yure5unt4mXDQzuSrARvnxak9SosDPFdO/vjZvqCeM6Fhim/S5HZtsMryGcO448K3SD5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450712; c=relaxed/simple;
	bh=Wrgs+6Axjde6Kj4UOdwW9uZ5GfYrAzKxZimS98RSnpc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kjD99VSnEKHKvmtgm1FSH8l3J8SkH8/Bv7hVrxurLAJMGe/6d02KA1OXv6XhsBbiU6QiRoCl+AC3+v6CLK+1LVuJXktk+CapG9WTCROv94neLukiBQOI1EO4D21Kgk/NvkSCxAqfzi9TrJrtAkSabhzVTQsxaUnNy1nQtUaTA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ov/EOt2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ov/EOt2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57251F000E9;
	Thu,  3 Sep 2026 15:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788450711;
	bh=6xA1SKet8KinlmRW91dfN5kvkyVQXXsZxHoi30o50Rc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ov/EOt2B/VmpbbWa5RBCICV64Ynu0Gk4ELRqCrHXjJ77MbwT1vY7EzgxxKRqI4k4+
	 AeQnOf8+/+4MWSRC6mQ/c2cDeh3qcgOwk96iIWvTH1xY9pBIeuP8jcoprcP1kq4FmZ
	 TAeL1XQq1lU8+kc3zo8LzmXT7t1CcZxgP+1gQpUHtMh1Fxpz+sYz3D8MfzGEeY0kSK
	 R9S8XUBmV7PY1qS55QK7hEL/TsLYSbHZ9J6QEyvhiL3anIVTq/NKMM6HxUqPuhyQZ2
	 xFbhzkjo7q5wQ3kU2qJby0Rqub2EYjpnxx8w3c/L77qq0jkEC+LR4JJIjzJvDZPXEa
	 gw9Xn8voSg3Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 09/10] bpf: Mark syscall helpers as sleepable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260903144433.1716731-10-memxor@gmail.com>
References: <20260903144433.1716731-1-memxor@gmail.com>
 <20260903144433.1716731-10-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 15:51:50 +0000
Message-Id: <20260903155150.D57251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_btf_find_by_name_kind_proto lacks .might_sleep =3D true, allow=
ing arbitrary FD injection via softirq.
--

commit 1d16e876066d61c09bcc6698ca694cdf8336d52c
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Mark syscall helpers as sleepable

This commit adds the .might_sleep =3D true constraint to the bpf_sys_bpf and
bpf_sys_close helper prototypes. This ensures the verifier rejects them from
non-sleepable contexts, such as bpf_timer callbacks registered within a
BPF_PROG_TYPE_SYSCALL program.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af0..c7bc9ba9b331f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6568,6 +6568,7 @@ EXPORT_SYMBOL_NS(kern_sys_bpf, "BPF_INTERNAL");
>  static const struct bpf_func_proto bpf_sys_bpf_proto =3D {
>  	.func		=3D bpf_sys_bpf,
>  	.gpl_only	=3D false,
> +	.might_sleep	=3D true,
>  	.ret_type	=3D RET_INTEGER,
>  	.arg1_type	=3D ARG_ANYTHING,
>  	.arg2_type	=3D ARG_PTR_TO_MEM | MEM_RDONLY,
>  	.arg3_type	=3D ARG_MEM_SIZE,
>  };
> @@ -6593,6 +6594,7 @@ BPF_CALL_1(bpf_sys_close, u32, fd)
>  static const struct bpf_func_proto bpf_sys_close_proto =3D {
>  	.func		=3D bpf_sys_close,
>  	.gpl_only	=3D false,
> +	.might_sleep	=3D true,
>  	.ret_type	=3D RET_INTEGER,
>  	.arg1_type	=3D ARG_ANYTHING,
>  };

[Severity: High]
This isn't a bug introduced by this patch, but does
bpf_btf_find_by_name_kind_proto also need to be marked as sleepable?

Looking at syscall_prog_func_proto() in kernel/bpf/syscall.c,
bpf_btf_find_by_name_kind is also exposed to syscall programs:

    case BPF_FUNC_btf_find_by_name_kind:
        return &bpf_btf_find_by_name_kind_proto;

Because bpf_btf_find_by_name_kind_proto in kernel/bpf/btf.c lacks the
.might_sleep =3D true constraint, the verifier will permit its use inside a
non-sleepable bpf_timer callback registered by a syscall program.

When the timer fires in softirq context, bpf_btf_find_by_name_kind() calls
__btf_new_fd(). This attempts to allocate a file descriptor with GFP_KERNEL
and injects the new file descriptor into the current->files struct of
whatever arbitrary process was interrupted by the timer.

Should bpf_btf_find_by_name_kind_proto be updated as well to prevent this
cross-process file descriptor injection and scheduling-while-atomic issue?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903144433.1716=
731-1-memxor@gmail.com?part=3D9
