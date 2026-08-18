Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AAD3A7F41;
	Tue, 18 Aug 2026 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080405; cv=none; b=oud9QZa7r9qjSfQGhevl6M94J+ZsI4JEzOYIm1u0zcVOAcvcNcYyKGuLGiMD/irddJYrc66VsIecHEqDylpy73h4y687kiTyk+G+dNnjiz3ChawqaQhTItatS1kUQKP5SDBlHpobVJ3hX8/XaZ7RGEvVfj3hbKfjl/utOaFBL3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080405; c=relaxed/simple;
	bh=eP6hRVJWkqC9etP0qkJGMC1lvCwtMzBJ6mFYUAnXYUA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bJaAaSQuXmo9Fmzt/m5k6IgBSV7vUmhZ+QUBgAJohBZScz71KTTWwjS6v8Ii97hn0IxfJAfDTY5Ql47Nq5G6H2zfA+e+aKCsqqDNP5dp2rrNprVnxt8hF2Erc7Chd6U2HKbfuG7hDjx3Ioj2l0z+KRS7PbytYs5O8a9sy5srXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpqLfuFc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpqLfuFc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F70B1F000E9;
	Tue, 18 Aug 2026 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080403;
	bh=cDLgtVmpaOuZdcJclkutA/Cgdtb0yCY1mrHTQhLafYI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mpqLfuFctnvz4mu/Mhs/ebkXa2L+M0dgiHlmlRIbQazLSzC3bQQiO1HHcWD0YzAtl
	 ad3Cjwnj45jbcikMr0CuBt7SZZy1+zzCgEqGD9jREjVPXRk+cAGfWJtfvH5t6OJbkP
	 EQnIsa2uTocGqEjfDiDEUzxiHWCYhRXI9vATf5q8D2Vjof3rnNk6OnE+2DAFQ7xHuS
	 KiEjO6KVxGqpSUC5he8p2DkavCeNws7se8KRiUVQHTcJJnpHRAx1TrPKGf1emTGQxP
	 92/ZoinIuxbQ13AdORmu+zE6ODCPCbCbSVTv4G3vDJD+8MMICHRUeIJCU3P8hZf9VF
	 JKjJDN42/biBQ==
Content-Type: multipart/mixed; boundary="===============2041633098559337984=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4fc9c8150478b9b1f1b349068e6aac3817a8f9d80fe1e71cb31b72791bb3365d@mail.kernel.org>
In-Reply-To: <20260818174253.492196-1-s.mahnur.a@gmail.com>
References: <20260818174253.492196-1-s.mahnur.a@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in bpf_sock_from_file
From: bot+bpf-ci@kernel.org
To: s.mahnur.a@gmail.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net
Cc: netdev@vger.kernel.org,andrii@kernel.org,s.mahnur.a@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 19:13:23 +0000 (UTC)

--===============2041633098559337984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit b394c2b75945f69ef4a6312d0fa18f1cc000d0c2
> Author: MahnurA <s.mahnur.a@gmail.com>
> Date:   Tue Aug 18 19:42:53 2026 +0200
>
>     bpf: Fix NULL pointer dereference in bpf_sock_from_file
>
>     bpf_sock_from_file should not dereference a NULL file pointer.
>     KASAN detects a null-ptr-deref when eBPF tracing
>     fentry/fexit programs are attached to points such as
>     __mmap_region and file_map_prot_check kernel functions. This can
>     result in a NULL file pointer flowing from context to the helper.
>
>     A minimal check before dereferencing can fix this.
>
>     Fixes: b60da4955f53 ("bpf: Only provide bpf_sock_from_file with CONFIG_NET")
>     Signed-off-by: MahnurA <s.mahnur.a@gmail.com>

Does the Fixes: tag reference the right commit?

Looking at b60da4955f53 ("bpf: Only provide bpf_sock_from_file with
CONFIG_NET"), that commit was a pure relocation: it deleted the helper from
kernel/trace/bpf_trace.c and re-added the identical body in net/core/filter.c,
and moved the proto dispatch from bpf_tracing_func_proto() to
tracing_prog_func_proto().

The body it moved was already:

    BPF_CALL_1(bpf_sock_from_file, struct file *, file)
    {
            return (unsigned long) sock_from_file(file);
    }

The unchecked dereference was introduced when the helper was first added, in
4f19cab76136 ("bpf: Add a bpf_sock_from_file helper"), which created exactly
that body. sock_from_file() in net/socket.c dereferences its argument
unconditionally via 'if (likely(file->f_op == &socket_file_ops))', so the
null-ptr-deref has existed since 4f19cab76136, not since b60da4955f53.

Should the Fixes: tag be:

  Fixes: 4f19cab76136 ("bpf: Add a bpf_sock_from_file helper")

Practical backport impact is small because both commits landed in the v5.11
merge window, but the tag is what stable/AUTOSEL tooling uses to pick a range,
and it points at a commit that did not introduce the bug.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32172667075
--===============2041633098559337984==--
