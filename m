Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636321;
	b=V2+BNTB70a4+LkXbvIgV1yWu78irCTJme3evNuzKsX+HD1IRn+47IIbvLBLdmhYGS4YW
	 r9XNY/OIZPGA0OJUsA06lfBfgoFFFebPUycI9RlgOGhfqV4iotQXZbEvmC+eFicH7Fm14
	 No663kKWRnw/BedZhB3RITGwDygJC6XQSQbsZOB+MRrbdk81mkn7cuPNAx6hPSvJhMQsV
	 8bRa3umqX0s1jKfQhE6dyfMQjctsbca55xZH3FqiHiGnE+jl1SiOlMyPIIHS4Zx/3UGgV
	 ETNxSLVRivuRloHzpQsjchYuvDwsI+t16cGHMlwGwXWptXmHqd6FXASrDkbfCchDsAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636321;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=1pXNISku7OkvrpER8JmzaF5XCEeRI5lq6DHrbtP84jA=;
	b=Bh0CwXAktNJq7jwBUHlVmls7l6lz4LRoNhNNyb2OWxI7L4TTAXLuUsbmVCK45XMbFhXI
	 Zjh/p5BV3qMLUpEdha/enS69VC2pj7yvjfh1xzdmB5lAorz6zbtkL63M2MGPr39GaDYyn
	 I9iKJPeFFU9y++93qxjGnSQpqK1qnkdynhmzULHkBAITrRvv1+MoUpw+GlIcWuQaITKpu
	 7grV4x0sQ68/rbP/VHRluo+46r4vnP5K6V8GnYcUQNOVQtEJrZi1xTBQ7ltujOrzHJZrY
	 XaK3V7fRKakoLE8cRl0jIFX1+eogl6ogAhqa764dg+hpcE4zbdX0IbPyQZBsMxzSslQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntrl2QFX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882F606A327
	for <bpf@vger.kernel.org>; Sat, 14 Nov 2026 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ntrl2QFX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18601F000C4;
	Sat, 14 Nov 2026 06:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794636320;
	bh=1pXNISku7OkvrpER8JmzaF5XCEeRI5lq6DHrbtP84jA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ntrl2QFXgFWl6rAgSm04fb0h5JtdQaS7uDoJCc+iKSuczdTBtvk4nxspF+TLYGKdA
	 GwofDUjbij2iJEV97Hnlwsk5sZY+vfwzO4IxovkjHMd7Um804f78cbmFJfM62a9bTn
	 BsZ9w7KBB3k1hpGyV757dNHBwqE8ubFNYU2N6WwBRXsLHbXenamAeXv+xEaV5RmfDx
	 Pao9UpR1/eSDd23r5mak41Z9E61T8m/VVoQPJSsfOf/UFnM+b20/8DtoRxDajFM0ZR
	 ktFSYwXpTUHbfbZLeUQIbRjCFvaUXGyx0FVSaryd70MyRkc5mzagcZ37t5Hn9PRf77
	 ieaYjldV5a22A==
Content-Type: multipart/mixed; boundary="===============8636202805981772488=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e1a107d10179101de9f2df9cd4f24e6879d34a93608e87bfc3589e0892e1e3d6@mail.kernel.org>
In-Reply-To: <20261114051805.683966-6-alexei.starovoitov@gmail.com>
References: <20261114051805.683966-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/11] resolve_btfids: Tag the functions that return errors
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 14 Nov 2026 06:05:19 +0000 (UTC)

--===============8636202805981772488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Tag the functions that return errors

TL;DR: With CONFIG_BPF_FMODRET_SCAN=y, selftests' test_kmods may fail to
build, since its resolve_btfids lacks an LLVM decoder; fixed later in the
series, so it is not bisectable.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> @@ -2174,6 +2182,9 @@ int main(int argc, const char **argv)
>  	if (btf2btf(&obj))
>  		goto out;
>
> +	if (fmodret_scan && fmodret_tag(obj.efile.elf, obj.btf, verbose))
> +		goto out;
> +
>  	if (finalize_btf(&obj))
>  		goto out;

With CONFIG_BPF_FMODRET_SCAN=y, scripts/Makefile.btf adds --fmodret_scan to
RESOLVE_BTFIDS_FLAGS for every resolve_btfids invocation.  If the binary
was built without HAVE_LLVM_MC, text_arch_init() is the stub in
text_insn.h that returns NULL, and scan_open() fails:

    s->flow.arch = text_arch_init(ehdr.e_machine);
    if (!s->flow.arch) {
        fprintf(stderr, "FAILED: no decoder for the code of ELF machine %u\n",
                ehdr.e_machine);
        goto err;
    }

fmodret_tag() then returns -EINVAL and main() takes "goto out", so
gen-btf.sh (set -e) aborts BTF generation.

Can this break building the selftests' test_kmods?  The selftests Makefile
builds its own $(RESOLVE_BTFIDS) without RESOLVE_BTFIDS_FLAGS, so it has no
LLVM decoder.  test_kmods is then built with
RESOLVE_BTFIDS=$(RESOLVE_BTFIDS), and Makefile.modfinal -> gen-btf.sh runs
that tool on bpf_testmod.ko with --fmodret_scan.  On x86-64 this should
print "FAILED: no decoder for the code of ELF machine 62" against a kernel
configured with CONFIG_BPF_FMODRET_SCAN=y.

This is fixed later in the series by commit e8aacae5279b ("selftests/bpf:
Test fmod_ret on tagged functions"), which drops the RESOLVE_BTFIDS override
in test_kmods/Makefile.  The option defaults to off at this commit, but
the series is not bisectable for that configuration.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43561939812
--===============8636202805981772488==--
