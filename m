Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208642;
	b=pRyEvSkooI28Nv4PQvrN8cq/BGPtui6G7PwIId7vnWn9lH3g8CnqNUgPpJq8PRY/5fUz
	 PmJMtWw93i1+PUnv00tNHJuoW0Rl4f0ZqsriVSEa6S33k6Phu5F/xzVmolOVqZJtoBGan
	 pHXfvJFzIx2M+KaAZ0MwoI26SKKyUelC0qyze2WZ+lKiXScOchY5WLEzrmSGvlGRjTk71
	 7u2RvlSbU6qyjsl6QUeprnRU5iPbrwepC4x4w0OS462/kUYfjwykimWetERgqY4yMabRT
	 yne/gfRKN18JLf454nGX07dT2TTGefatKdFfysjlQbOvjQ130UOWyxFHPV82qejr5Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208642;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=KlNXVkq1wFX/0excrjk/rR7bzuArseKt7/XQpzoiZ7I=;
	b=usc03cp3DeePwDV06+CZtwa9SOkrpt5c4vcpbTwWLbqFikAZCXyop0uYYRlv+/vmTwVv
	 3No5jRrCui4vzxL4yuzlQZCn8HiZPRsvwV21X1a+wQUBGv5wdIe6LvJoO8jkRtYzW1IJe
	 BMG4T4qXUF7xYj4PpblNPhj/UdZf+ZWDaEGPfJg1vWUm8gmZPwsnZ4dkztL8i0FdATs1S
	 QKWt87P+HJ6aur9NslM8dV+NvcCDndH+QxGr5iVy5tHvL9Ybe+fIW8XBJqKpzfSun7vcs
	 7LQeIJPnmjhGumXTuXv6U8sCwTcTVxrKTMmKTGLlM4X/i/uFUd2KG2NEfA2LajPy4jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6LwTTGt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E6606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 07:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6LwTTGt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A30D1F008A7;
	Mon,  9 Nov 2026 07:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794208641;
	bh=KlNXVkq1wFX/0excrjk/rR7bzuArseKt7/XQpzoiZ7I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=T6LwTTGtH9QyZ7bQvFN5/A0CC8xbDXXpoTBfa5HT8Sy5OeRBQx4nyMnBTuLrIlL3d
	 12/d4rRDpxC5Y3C4FjGrHQ76x1dHcCSYfH96bqztLlWxgJk5Ju8O9OKbdlkYcoNRNE
	 17MAoWosghIo5GZc1hduJySXNhQiVMmt4z1DB3+1Nuj4HNt3wALUvyOruAZ5fcroIk
	 3+betkZG5SD0neJ1kt9qUW868UAFuKUUaL6I0kOY5pCljHb/nIHsZ8USrk2WA3SAck
	 REGJAI9Yx541Us8qsw7rbjlootpFRdA1iubQd3QIIjtXZV1kzQpd0KS1y5+8D9UCG4
	 7qkRQ1refUYYw==
Content-Type: multipart/mixed; boundary="===============6017797049047842132=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7ccfdd9c87fcff0cb613c9892abac47ccd5d981082add1942d7d568ea7b597fc@mail.kernel.org>
In-Reply-To: <20261109064715.2382452-9-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-9-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 08/26] bpf: Mark the attr argument of bpf_sys_bpf() as MEM_WRITE
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 07:17:21 +0000 (UTC)

--===============6017797049047842132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Mark the attr argument of bpf_sys_bpf() as MEM_WRITE

TL;DR: Commit message only: the Fixes tag may point at the wrong commit; the
read-only declaration appears to come from 216e3cd2f28d, not 79a7f8bdb159.

>     bpf: Mark the attr argument of bpf_sys_bpf() as MEM_WRITE
>
>     A fix of the declaration of a helper. This series needs it: scalar
>     evolution keeps the expression of a stack slot across a call unless
>     bpf_may_write_mask() of the call has the slot, and liveness.c computes that
>     mask from the argument types of the helper.
>       union bpf_attr attr = { .btf = .., .btf_size = .., .btf_log_level = 1 };
>       bpf_sys_bpf(BPF_BTF_LOAD, &attr, sizeof(attr));
>     BPF_BTF_LOAD and BPF_PROG_LOAD store log_true_size into the attr of the
>     caller. When BPF_PROG_LOAD rejects func_info, line_info or core_relo
>     records that are larger than it knows, it stores the record size that it
>     expects. For the helper the attr is a kernel pointer, so
>     copy_to_bpfptr_offset() writes to the memory of the program.
>     arg2_type in struct bpf_func_proto bpf_sys_bpf_proto is
>     ARG_PTR_TO_MEM | MEM_RDONLY. So the verifier keeps what it knows about an
>     attr on the stack across the call: a slot that held 0 is taken for 0 after
>     it. bpf_may_write_mask() of the call does not have the slots of the attr.
>     And an attr in a map that the program cannot write to is accepted.
>     Say MEM_WRITE.
>     Fixes: 79a7f8bdb159 ("bpf: Introduce bpf_sys_bpf() helper and program type.")
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

The commit message says the declaration became wrong because of the
original helper introduction:

  Fixes: 79a7f8bdb159 ("bpf: Introduce bpf_sys_bpf() helper and program type.")

Is that the right commit?  When 79a7f8bdb159 added bpf_sys_bpf_proto, arg2
was plain ARG_PTR_TO_MEM, which did not claim the memory was read-only and
allowed writes.

The incorrect read-only declaration appears to have come from 216e3cd2f28d,
which changed arg2_type to ARG_PTR_TO_MEM | MEM_RDONLY.  Should the tag be:

  Fixes: 216e3cd2f28d ("bpf: Add MEM_RDONLY for helper args that are pointers to rdonly mem.")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42577197491
--===============6017797049047842132==--
