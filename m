Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792628921;
	b=XXLTjWCS3NJ8i7TzUM5DwlvkIXQR87NJKJZi34KEd0dteU1cWWuJ1QbXqVYxy/ejFcU5
	 nU7jUjS8XKdDYE5e8UVUVEMDEjqGsfGoqL9ZeEQWFncYGLaFxXVXyHnPP9lKrlM7tOHe4
	 U8oUzazyBdvMJbA2v0uwmRxXPM1PghC7UpjYzVS2KUvbtkCaV+6I/GY6tVuHyeTMNp+Hv
	 IAM77296UB82jzwY3GC6Q3R7neS14I71fpO54MNMUahzppN2LKuVq69ztZTtN0KcN65fh
	 WdajJ8OmMB64fy8bGVtaw7tJ1WZyE9x3SKjBoBiG2fUoh/IpZy77yz75R42WyNvzJMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792628921;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=mkcJ+uUk1WMpHYvLJF02mhhfYHOGYl7n0i3uXhVf4iw=;
	b=g3Dk8JWQXI/peZ0H7iK6mOSBc8NI5gIUTdyGkejfMdmYyz7e4et35sWmw/t3Oxz0f1Qe
	 yVcyJdhOeXwYG17JiOsDTiohG+k/HQ1H9bIb9libiM3YmTsNuUdpK5DYPwmeHKOcpWO79
	 5ZrrVr05a4sqmDauAdZUEYSRS5x3ZH4+MMZXwWWE8dCo3G7/OVNLkEA5KCtP9V/6ZQHW2
	 wkD7bCtxmhx1nfZ2E2UXE8az4Gv39yac57/i/owFhUFs5KtADSDhOT7gS4KYDnoPAh64z
	 BeJgr4S74BNDVdGItajCpH0H5Zg4SF8tf2+jCyXxbA6ZiPLDRYJ9vkEA6WXlc+2sUuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJlcDQkh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F1606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJlcDQkh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208FC1F000C1;
	Thu, 22 Oct 2026 00:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792628920;
	bh=mkcJ+uUk1WMpHYvLJF02mhhfYHOGYl7n0i3uXhVf4iw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=UJlcDQkha7k3LON0cdQZDxDb2yVGgIHmS/mt/rxrIZN8kG/AQITrvFZj4xSltZpsW
	 NgkFrgiio0kwKlelzgxTu/N85vZySycHWVpQDE7HfqEnrj8WVe77vV3I5PCn8x6I4Y
	 20YLgMJWq0983FLWdBZrfuKInxfJaL1aq7duwaYI1fSMYd0pk8GV1TQ7HqHQPkohp1
	 mvffOnd6P356urjxkzZzPCNE8vBykgaYj5t/PExlR0K4sWlPwVaVcZPyKCoTXqlvqo
	 elsSNx3ziEyp5tQDNcbTdAK4bh3Y13izmSZK0nIwaDmCOSO9K/qIoo79Jit64IiFuZ
	 Iw1OAKppwBzow==
Content-Type: multipart/mixed; boundary="===============1004824936618483403=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <0feb63228f884638070d176d47277c9c40dffcb528ed5ec5580209a880f5e464@mail.kernel.org>
In-Reply-To: <20261022080500.100-2-szwyb123@gmail.com>
References: <20261022080500.100-2-szwyb123@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: report kfunc sets that fail BTF sanity check
From: bot+bpf-ci@kernel.org
To: szwyb123@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 22 Oct 2026 00:28:40 +0000 (UTC)

--===============1004824936618483403==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: report kfunc sets that fail BTF sanity check

TL;DR: Commit message only: it says "three i128 test kfuncs" but bpf_testmod
appears to register about six; suggests fixing the count or dropping it. No
code issues raised.

> bpf: report kfunc sets that fail BTF sanity check
>
> register_btf_kfunc_id_set() returns -EINVAL when a kfunc in the set has
> no valid FUNC/FUNC_PROTO pair in the BTF of the registering object, but
> nothing is logged: the caller (typically a module init function)
> propagates the error, insmod fails with -EINVAL and dmesg stays silent.
> The only hint is a warning from resolve_btfids at build time, which is
> easy to miss.
>
> This happened with bpf_testmod built by pahole 1.30: that version does
> not encode __int128, so the three i128 test kfuncs had no BTF func
> entries, their ids in the set stayed 0 and loading the module failed
> with -22, with nothing printed to dmesg.
>
> Log the offending kfunc id, the object that owns the BTF and the error
> code when the sanity check fails.
>
> Signed-off-by: Wang Yibo <szwyb123@gmail.com>

The commit message says "the three i128 test kfuncs", but is that count
accurate?

bpf_testmod registers six i128 test kfuncs in its kfunc set:

tools/testing/selftests/bpf/test_kmods/bpf_testmod.c:
    BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128)
    ...
    BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg)
    BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd)
    BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd_many)
    BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_stack_hole)
    BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_pad)

At least five of them take or return a bare __int128, and
bpf_kfunc_call_test_i128_arg_stack_hole passes it through struct
prog_test_i128_arg.

Could the message either state the correct number or say "the i128 test
kfuncs" instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39699006936
--===============1004824936618483403==--
