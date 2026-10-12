Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749E94ACC94;
	Mon, 12 Oct 2026 16:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822816; cv=none; b=SAmsmO3oY7YEptdGV3PchXPbTvJljd25Zb8yAitO/TiLD9YQYlo/xP/lvHmiwyCw6h+5S3pydKsRg6oeC6rFDGpaRCvN6YNzWmNogouNiuT/QIDin85n2eM6iiBvrTDJi27tU38uLkpKURLgYTxrJX54cApgvRn1zk2eqr62Diw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822816; c=relaxed/simple;
	bh=IaAi2U1ZWkIrhoJo9tGZawUhLxorGfQN25hhagAC6pE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=afwh3kmw0RfqBF6aBhtXEw2cgaM7pXtfujs2Fm2BmlkGUX5qvjNVguHTUlEmADUVALm7jJ0u/aJfj7oW9nCXvFZOECBrx+j50xQZjyiS+kwYk8TFpnsXcZGrym+R8W6n0srBf8lg/3GhHn/NUS1l6tGPTtpkMGI18ZJALFPdXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAyd4ghm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAyd4ghm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC3C1F0089C;
	Mon, 12 Oct 2026 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791822815;
	bh=kXE1zdrjiBM46Cqc2HIge5R7EvlWtWUr5gtY7GPtBwE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hAyd4ghm35IwJUMsijajsAyf2ebNTPfzgnSFHr6p4TbUI4FHa/ZUI1GBFDLdwW8gB
	 aKxH+S943CLcykjfZOYT0YYZdTNdft64zJf4mWIvleT3Vy1nIB3oSLTsBjwvKeemvk
	 QPw25hkRvAVVFX92TP0qY3iasVrUMAy0NomOeG4CBpBXipgqbpGvj1zftJ+MsrsJRF
	 Ze9z1EVYV87POOOpzhPfmAI7lqAWX6GWu4kHoDTpda1N5KEEcBLCX8kNyD/nHvXPbO
	 X3C/WburdAsWdlzv7FIsGbxuD2c+l9GVTVrPef/5YHncuLeFUbaV+mxKZgNs7FY81g
	 KTaFfTdUaZz8w==
Content-Type: multipart/mixed; boundary="===============4894449459767972379=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <034eb660ae492d5a40c305f0aa0ab3d11f3c6b1ad8adf2e3b8906d37837feec4@mail.kernel.org>
In-Reply-To: <20261012154024.29423-12-leon.hwang@linux.dev>
References: <20261012154024.29423-12-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 11/21] bpf: Add tracing_multi link support for bpf progs
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,yatsenko@meta.com,avinash.duduskar@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,jordan@jrife.io,rongtao@cestc.cn,eyal.birger@gmail.com,pulehui@huawei.com,tanjingguo@huawei.com,malin89@huawei.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 16:33:31 +0000 (UTC)

--===============4894449459767972379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add tracing_multi link support for bpf progs

TL;DR: The new tracing_multi fds field is not tail-checked, so older 7.2/7.3
kernels may silently treat program BTF ids as vmlinux ids, attaching to
unrelated kernel functions. Suggests a link_create flag to gate it.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6f70db7515dd..94302a3b680c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1927,6 +1927,8 @@ union bpf_attr {
>  				__aligned_u64	ids;
>  				__aligned_u64	cookies;
>  				__u32		cnt;
> +				__u32		:32;
> +				__aligned_u64	fds;
>  			} tracing_multi;
>  		};
>  	} link_create;

Can a kernel that already has tracing_multi but not fds reject a request
that sets fds?

The generic tail-zero check only covers bytes after
BPF_LINK_CREATE_LAST_FIELD:

    #define BPF_LINK_CREATE_LAST_FIELD link_create.uprobe_multi.path_fd

uprobe_multi.path_fd ends at byte 64 of union bpf_attr, while the new
tracing_multi.fds sits at bytes 40-47 (overlapping uprobe_multi.cookies).
So CHECK_ATTR(BPF_LINK_CREATE) in link_create() never looks at it.

The tracing_multi link shipped in 7.2 (c1d32dea5d46 "bpf: Add support for
tracing multi link"), and there bpf_tracing_multi_attach() reads only ids,
cookies and cnt:

    uids = u64_to_user_ptr(attr->link_create.tracing_multi.ids);
    cnt = attr->link_create.tracing_multi.cnt;
    ...
    if (attr->link_create.flags || attr->link_create.target_fd)
        return -EINVAL;
    ...
    err = bpf_trampoline_multi_attach(prog, ids, link);

bpf_trampoline_multi_attach() then resolves each id with
bpf_check_attach_btf_id_multi(prog->aux->attach_btf, prog, ids[i], ...),
which looks the id up in the vmlinux (or module) BTF that the fentry.multi
program was loaded against.  If the type is a FUNC with an ftrace location,
the program is attached there.

The libbpf change later in this series (85b62f93fd2d "libbpf: Add
tracing_multi link support for bpf progs") fills ids[] from
libbpf_find_prog_btf_id(funcs[i], fds[i], ...) and sets
lopts.tracing_multi.fds = fds, with no feature probe.  A new libbpf running
on a 7.2 or 7.3 kernel would therefore send target-program BTF ids, and the
older kernel would treat them as vmlinux BTF ids.  Depending on what those
ids name in vmlinux BTF, that gives either:

- a misleading -EINVAL or -ENOENT that cannot be told apart from bad input,
  or
- a successful link whose program runs on unrelated kernel functions
  instead of the requested BPF program functions.

No later commit in the series changes this.  ef1ca3de15ec only adds a flag
to the bpf_link_info output struct, and older kernels already reject a
non-zero attr->link_create.flags in bpf_tracing_multi_attach().

Could the program-target mode be keyed off a new link_create.flags bit (for
example a BPF_F_TRACING_MULTI_PROGS style flag), so that kernels without
fds support fail with -EINVAL instead of reinterpreting ids?

Related to that, the new padding is not checked for zero:

> +				__u32		:32;

so it cannot later become an input field either.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38273555988
--===============4894449459767972379==--
