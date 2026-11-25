Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643877;
	b=oWsFZFLqWduz3gHFcDnvn6TMacgKsddbWdZ0gzZce0YlCgKY8wi3T5L56Rs0fJ0mlYVz
	 GWTGeF3cB4WM0Y9Xi1MuBmoe0lEQ54upY9FgB5ghp5Ei7oNfABqQTfMcty4hTTw/Cpf0L
	 FAHOvzZaURsK4CgGQdEpoLpWlBBYWiQU8a9WIw4VYvlPWGdKZK4JLRfuYEobrYmstDnBv
	 uje8WyeewpEexN4W0Bq6Y3k+zSQSVu7wlYhjRoMiKnpZu3T4QWNPh6iy5Np/KrfEcxm2x
	 kc/KMhKUTLRyHuXZshTaOGxmAf6IaZJan+y7MGu1jGtWtdNAFi4H1S4tdGqtx+EvQpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643877;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=NdtF8LsP/A+ZsJC0Sryvgb8rANqF99f1f2N2Y5QleXY=;
	b=RtWGw4282SiUmMXAoTyIoe1uywc4Dhq0dJMcFSg4Q+MoEzUZd7Unb5lfevct/cXwggBY
	 OIVk/zpL1RoZqjoT/m58en49W4z+UI5XYhK/++xcNABde7rqzJpq6ubBw91JvKeWD9BG8
	 C6lne0QLp8fJikUxsgLX0hJOVuDmA9o7imJ1crJq1Hu/S+pxaE+6EUeRhW/UCkqpUF4/W
	 FdhRb56fGjoIqIRIQzt7S8FjW9BFcVM+GosfWrrtIYnEozvd52IpGm4tdna3hyhjhnzoU
	 LnCGfEWkbKZbZQsc9JM0yhGvHH5Cdwa+isFTCGZZqcRT74oxLIvtwnfdO2fbAWRN0eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKJuDHNn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A4606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oKJuDHNn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465011F000C0;
	Wed, 25 Nov 2026 21:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795643876;
	bh=NdtF8LsP/A+ZsJC0Sryvgb8rANqF99f1f2N2Y5QleXY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oKJuDHNnw6ovmRuFI8Ou0pL5OSBPIaBGyyWpXeYwFv+n2UwKx7cMVM+cNp01jMol5
	 lwc046w2VdyK2HOouPMiS6rucCa5TkXzOlY2my09G57nQCnAe0NFVAvAwPoBXC3Ns+
	 Ui5c5rRE/2P2OeIfIX09He1c+z4HvEPH/4vs4ro8xp97cMmV2K4aS7IuxFUKRlWAX1
	 2PEN5E+LMHgrcRtToS3SzwTzIaskJt25jKM9uYUxv5OWZhE9U7hL6QudrVrKiSSJZe
	 4N0EyKuzeabsvrxo9KjsIMLfhHnMGHxoAXUqJEJVUh8Q3b2SbFn3NQVG3526NpLngX
	 G0R92oNaq6FOQ==
Content-Type: multipart/mixed; boundary="===============8085904527264693219=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1bbb6f70251c5f33bb728521ba463dc33796749b1406e8e91f2ba51739ba2ae2@mail.kernel.org>
In-Reply-To: <20261125212849.868523-4-a.s.protopopov@gmail.com>
References: <20261125212849.868523-4-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v1 bpf-next 3/5] resolve_btfids: Exclude a set of functions by name
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,jolsa@kernel.org,almagui@kernel.org,john.fastabend@gmail.com,bpf@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 25 Nov 2026 21:57:55 +0000 (UTC)

--===============8085904527264693219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Exclude a set of functions by name

TL;DR:
- Exclusion list may be incomplete: fmod_ret on copy_to_kernel_nofault()
  returning -EFAULT could still break arm64 ftrace patching
- Driver xdp metadata kfunc implementations may need excluding too

> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> --- a/tools/bpf/resolve_btfids/fmodret.c
> +++ b/tools/bpf/resolve_btfids/fmodret.c

[ ... ]

> +static bool excluded_by_name(const char *name)
> +{
> +	static const char *const names[] = {
> +		"copy_from_kernel_nofault",
> +		"aarch64_insn_patch_text_nosync",

The commit message excludes aarch64_insn_patch_text_nosync() so that a
program cannot make ftrace patching fail.  Is the list complete for that
purpose?

aarch64_insn_patch_text_nosync() fails only through:

aarch64_insn_write()
  __aarch64_insn_write()
    copy_to_kernel_nofault()

copy_to_kernel_nofault() ends in "return -EFAULT", has the same shape as
the excluded copy_from_kernel_nofault(), and is not in the list.

If an fmod_ret program on it returns -EFAULT, ftrace_modify_code() on arm64
returns -EPERM without writing text, which looks like the same
ftrace_bug() and stale trampoline failure described for x86.

The read side looks similar: aarch64_insn_read(), used by the arm64 ftrace
code, returns the -EFAULT from copy_from_kernel_nofault().  Should
copy_to_kernel_nofault(), and aarch64_insn_read()/aarch64_insn_write() if
the scanner tags them, be added here?

> +		"bpf_remove_dentry_xattr_locked",
> +		"bpf_set_dentry_xattr_locked",

The commit message gives specialize_kfunc() calling these two in place of
the tagged kfuncs as the reason for excluding them.  The same substitution
applies to driver xdp metadata implementations returned by
bpf_dev_bound_resolve_kfunc() and called from specialize_kfunc().

For example veth_xdp_rx_hash() returns -ENODATA, takes only xdp_md, u32 *
and enum pointers (none named bpf_* or btf_*), and has no bpf_kfunc tag, so
has_bpf_types(), bpf_funcs[] and excluded_by_name() all let it through.

If a program skips it, *hash and *rss_type stay unwritten while the
verifier treats the kfunc outputs as written.  Does the by-name list need
to cover these driver implementations too?

> +	};
> +	unsigned int i;
> +
> +	for (i = 0; i < sizeof(names) / sizeof(names[0]); i++)
> +		if (!strcmp(name, names[i]))
> +			return true;
> +	return false;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45706808075
--===============8085904527264693219==--
