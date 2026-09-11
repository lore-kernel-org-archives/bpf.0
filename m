Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8353D9DAC;
	Fri, 11 Sep 2026 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141308; cv=none; b=YXbP+OYatSFGRGn7bLvWFXbfXOCjkbgv4BAmxCMkLrJm0uXcXIfHRZe+z9cugoikp4pmWPNTWMN56zSs97TBmvE+QCRY/4teRb/XKcaNd2/VFLdpxVG+DR979uUkgG6Ih5NNjaKAeqCdGcLBagOJVf2BUj7OpCazASoB42X+eno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141308; c=relaxed/simple;
	bh=xpUQND1FMCb9Y1TU9Z/UGvSsj1t7Mrlh2nVIxll7ld0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=aRatH4nkJjWyZ6EvEX3QvLp6URTALTV5EE4rT/endqZJwtYflXGLGt6iaui0qpApAj3INkUV98Jpe0lI+I+AoE8P3Em7c1O75UCYVz8fkKA4ky8dM2q7KMdobc7WiOG55sMTdSCnTNyWM5HytfA3BENscz0TsZuvHbjJCu9E3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEWxXcKb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEWxXcKb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF06F1F000FF;
	Fri, 11 Sep 2026 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789141306;
	bh=zroWIaP8y3hH8h1qyRdfIRzXQGahACBvm63S6Ay25DU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fEWxXcKbCr547hvvPkj/cHA5gxnUh4gJ4NdFZOmD97nOcO5LDSxhmgag5s+u6Cja9
	 sYaBPrMZ/GNncMiidPlI3gnusqOfxFrHJDRCb6iprFDm/WNY0QvP4KQsX8O5Em3hDd
	 kO+M5KcMWjknGsrppWbM9xON+1ZLc8mVzUvAhKi/tuRij9vcqPA2LOH5dLoqxLysvN
	 3w+B2mbKCAglzOoUvKr8NRLXPNL4pmNx9PZWpa39v7cAqaBlsrusISxMB3IKnlSl2T
	 0cIzy9IshNX8d6pzpxiDBR3V2O+7yctm/OHv2fTLvSIeW5HUWjA0DMSdiNzEXo4zPZ
	 Kp26aOzPzeUqQ==
Content-Type: multipart/mixed; boundary="===============1937953573834693219=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d8f2687c7b00a0ce9f54fe1ba4ed7d461860dbbe33464a014b90913b0652aa95@mail.kernel.org>
In-Reply-To: <20260911145011.kErTVDkS@linutronix.de>
References: <20260911145011.kErTVDkS@linutronix.de>
Subject: Re: [PATCH bpf-next] selftests/bpf: Replace %pK output with 0
From: bot+bpf-ci@kernel.org
To: bigeasy@linutronix.de,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,bigeasy@linutronix.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 11 Sep 2026 15:41:45 +0000 (UTC)

--===============1937953573834693219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> index 07c834433b38..75ff1142c185 100644
> --- a/tools/testing/selftests/bpf/README.rst
> +++ b/tools/testing/selftests/bpf/README.rst
> @@ -187,7 +187,7 @@ The symptom for ``bpf_iter/netlink`` looks like
>    ...
>    15: (bf) r2 = r7
>    16: (0f) r2 += r1
> -  ; BPF_SEQ_PRINTF(seq, "%pK %-3d ", s, s->sk_protocol);
> +  ; BPF_SEQ_PRINTF(seq, "%p %-3d ", s, s->sk_protocol);
>    17: (7b) *(u64 *)(r7 +0) = r2
>    only read is supported

This excerpt is a historical clang-10 verifier log illustrating an old
failure case. The patch rewrites the quoted source to "%p %-3d ", but the
actual code now reads BPF_SEQ_PRINTF(seq, "0  %-3d ", s->sk_protocol) in
bpf_iter_netlink.c - the sock pointer argument is gone entirely.

Should the historical log remain untouched, or should it be updated to
reflect that the netlink iterator no longer passes a pointer to
BPF_SEQ_PRINTF?

> diff --git a/tools/testing/selftests/bpf/prog_tests/snprintf.c b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> index 4e4a82d54f79..f2cd442c4683 100644
> --- a/tools/testing/selftests/bpf/prog_tests/snprintf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/snprintf.c
> @@ -16,7 +16,7 @@
>  #define MIN_SYM_RET  sizeof(EXP_SYM_OUT)
>
>  /* The third specifier, %p, is a hashed pointer which changes on every reboot */
> -#define EXP_ADDR_OUT "0000000000000000 ffff00000add4e55 "
> +#define EXP_ADDR_OUT "ffff00000add4e55 "
>  #define EXP_ADDR_RET sizeof(EXP_ADDR_OUT "unknownhashedptr")

The comment says %p is the third specifier, but after removing %pK from
the BPF program (test_snprintf.c:59), %p is now the second specifier in
the format string "%px %p".

Should this comment be updated to say "The second specifier"?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> index a2652c8c3616..36690478992f 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_unix.c
> @@ -44,8 +44,7 @@ int dump_unix(struct bpf_iter__unix *ctx)
>  	if (seq_num == 0)
>  		BPF_SEQ_PRINTF(seq, "Num               RefCount Protocol Flags    Type St    Inode Path\n");
>
> -	BPF_SEQ_PRINTF(seq, "%pK: %08X %08X %08X %04X %02X %8lu",
> -		       unix_sk,
> +	BPF_SEQ_PRINTF(seq, "%08u: %08X %08X %08X %04X %02X %8lu", 0,
>  		       sk->sk_refcnt.refs.counter,
>  		       0,
>  		       sk->sk_state == TCP_LISTEN ? __SO_ACCEPTCON : 0,

The header shows "Num               RefCount" (18 columns before RefCount).
The old format "%pK: " produced 18 columns (16 hex digits + ':' + ' '),
matching the header width.

The new format "%08u: " with argument 0 produces "00000000: " (10 columns),
so every column from RefCount onward is now shifted 8 characters left of
its header label.

Should the header be updated to match the new field width, similar to how
bpf_iter_netlink.c was adjusted from "sk               Eth" to "sk Eth"?

Regarding the commit message:

> Networking recently replaced the socket output with a plain 0 because the
> socket pointer added no value to the output and the %pK should be removed
> fom library handling. The format remained otherwise unchanged in order not
> to break any tools which are parsing this information.

There's a typo: "fom library handling" should be "from library handling".

Also, the statement "The format remained otherwise unchanged" is
contradicted by the netlink header change from "sk               Eth Pid"
to "sk Eth Pid", and by the field width changes across all modified files
(varying from 1 to 10 columns vs the original 16-17 columns).

If maintaining format stability for parsers is the stated goal, should the
width-preserving spelling be used consistently?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34614571384
--===============1937953573834693219==--
