Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521185;
	b=x+qnoiDfl7n/gKNGJlD/bmHPkYaSM1iWB2RlNnA/IgOUUoJP8jDRBM8KsA6iDh22EGbj
	 Gxe2wOELouRn3UeGwI/94ZmWIC/VciH09qyDgSpEmV86c/JzI8HE5cegczNvYU7kdq953
	 KygWZ+rCFmo8t69Qlpzg5ZxA44H3K8ebnH33uloG2Iw0MWodhqrUK24RVekymGkzctdem
	 W3FVjpUp1Olbb3V80ufkUE7H+WzeJSRcpyLeUvpC/2rM1kupLbPFtcMRORsWBb+KZmU3t
	 RXFoSESf9lgjR7Mi8bu9VGEzRz02iFkgYTiauU/Iv2836KBpMzJ+IfzRL0q8+cqK8qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521185;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=tcOgHR83oJ/E387XM9X7XUHtvcTJO511qwW+hFx3nDg=;
	b=1x58Zi/6CcBMYIFfUh+eWglrB93s8q5ZN9Q/iQflTFlFGp+MPWR/xbISBEtA0NlLXRg5
	 x+uyXPjmYCz/3XO9eMTUr0dybt/HttSe7JZ76uuwHONc2ZFMLN/ErDTPhBTTQDNauiUbb
	 1a03JZOTRlHRve97t3BdMLD5MC6vEysUzRgFbo5nKC1S8KQVYzcR+OZbX8u7AVvQGJ2wx
	 T9O2VyLKFbgheLu6wJNmKgsQhQKu9MWn7/bSy+uJ2wwB1wQn9SwhrOtuuxHAET9t9csM9
	 xtwfpjJNMdLWeAxBrBJRlaMP1KfNsbQlLpZCSiEpmW9Eq1L/bgWeDy0Nj4fxvM2oYIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EiYlKpxT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F49606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EiYlKpxT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8C21F000C9;
	Tue, 20 Oct 2026 18:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521184;
	bh=tcOgHR83oJ/E387XM9X7XUHtvcTJO511qwW+hFx3nDg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=EiYlKpxTms7fqr4qk7hrx1I3zIxXVjtufaczMj9LPAqR/eA4x7kaGVMQpIWz6YIyQ
	 21YOKv8//LccxsvdTC5Ip3yUzlyL8vz80IWjFl/9PRXA768DT9qNU5ZEsmgEWGzmd+
	 fOe1X4vA6LQmNFB51OKu6o/LSx8vXgsxslC+QQAa0+lYDLNgLI1g4D+YG5hO1ZRaC2
	 x/2iOag7MjDFfzO+vYkNmnvsLcrUgMOMUWIMo7gz1Aq1LaO+xQy46o9flAcZ1hw7nH
	 UyFvDDgsWdXDD7g4je+j/iV1zNpiJU4m0ITUmLkJuNZSr37IXHhY6+iVzKNBYBhMz1
	 r/rBUf0N4HTcQ==
Content-Type: multipart/mixed; boundary="===============0240370079051438660=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a9d7c1aded97ee3ced24068eeaa79c447ccc242ba7f33c5ff85aa4bbc55650be@mail.kernel.org>
In-Reply-To: <20261020180147.1769873-6-memxor@gmail.com>
References: <20261020180147.1769873-6-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/6] bpf, arm64: Add a native bpf_throw() entry that captures R6 to R9
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 18:33:04 +0000 (UTC)

--===============0240370079051438660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, arm64: Add a native bpf_throw() entry that captures R6 to R9

TL;DR: Nit only: the open-coded "brk #0x1" after bl bpf_throw_unwind() in the
arm64 bpf_throw_entry could be ASM_BUG(), which would give a clearer report if
the call ever returned. Not a bug.

> diff --git a/arch/arm64/net/bpf_throw.S b/arch/arm64/net/bpf_throw.S
> new file mode 100644
> index 000000000000..aac1c5e967e1
> --- /dev/null
> +++ b/arch/arm64/net/bpf_throw.S

[ ... ]

> +SYM_FUNC_START(bpf_throw_entry)
> +	stp	x29, x30, [sp, #-(16 + BPF_THROW_REGS_SIZE)]!

[ ... ]

> +	/* bpf_throw_unwind(regs, cookie); the cookie is R1 of the caller. */
> +	mov	x1, x0
> +	add	x0, sp, #16
> +	bl	bpf_throw_unwind
> +	brk	#0x1
> +SYM_FUNC_END(bpf_throw_entry)

This isn't a bug, but would ASM_BUG() fit better here than the open-coded
brk #0x1 after the call to bpf_throw_unwind()?

Immediate 0x1 is not one of the BRK immediates listed in
arch/arm64/include/asm/brk-imm.h, so if bpf_throw_unwind() ever did return,
the result would be an anonymous "Oops - BRK" from do_el1_brk64().

Other arm64 assembly with the same "bl <noreturn>; trap" pattern uses
ASM_BUG() from <asm/asm-bug.h>:

arch/arm64/kernel/entry.S:
	bl	handle_bad_stack
	ASM_BUG()

arch/arm64/kernel/head.S:
	bl	start_kernel
	ASM_BUG()

ASM_BUG() emits brk BUG_BRK_IMM plus a __bug_table entry, so the report
would name bpf_throw.S and the line.

The follow-up commit 9a710c167b82 ("bpf: Restore callee-saved registers from
the frames being unwound") keeps the brk #0x1 as well.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39472833568
--===============0240370079051438660==--
