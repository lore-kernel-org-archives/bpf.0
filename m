Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D052188F
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169199; cv=none; b=VHtVDJznqVOZztmHDVayv/2HDmsM7iAZmfsNm8LffyOhjfXCt0PJKYWgbPl5Dq+eevSp5jIzZdSuL+yozTF6HnrI/mrdoi9lbfu7fDVZZA74FvVAHRDUTCcnc+4nRzPN7ShIgRXv1FUZxB9WmFMscflOZGw+osr262sF8EN2dtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169199; c=relaxed/simple;
	bh=E57hGkXXcOiRuieWeRLKAZYK0o+7nOZmwKUSkf/BMWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n7sT9vvfShyDlBgRzXo+qB0GX8DBe8FEacJLBDXno2sqJSyNOOVJLa/AeOq2owC/aLrNWgHcF2FqMq3Sxq5YJ24hlGq7TllJUqXn4xfZ2sVDezqYi7FDStJi21iR2kXuI1EBhV99/R5DFgZHo9SbEqlRdnfnZhMtk8ppmJeouao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJvzlfB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJvzlfB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC251F000FF;
	Wed, 23 Sep 2026 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790169197;
	bh=Brq11JiQMtSBkUEqN+n8Jvorm4ynblPsW9UBJIlHGdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kJvzlfB20cGGmwmvAT+oWPj0LfJ111rqEvNppQ9ASS/zdx2QfYIi/2iWN60wPwjEe
	 yLVWWe8Yq3RqPIl7tDcK7wPTqKybNZLV9EMHylmXhFVydDppPogtxEyuEhiuWl98Ac
	 NJ6g9yiU9JBOg+90URaARVKe9BmQZ3rf4wIAJ6OwUToTt3tqWl1vH/mnBkW1yqzz2h
	 dW2u0PY7fNFOp9z7lLeq6u9cobiNTRkyOreDKl9ExOgJAXYdZ2PG3w8oBxOcjTOLwg
	 dhgshfDJvV2SS6vU4a+xkIkfwfxzUl+CFv2PhXeHIE0A45qxx8hcBxFZV0scID3K0R
	 rdBpgkCbSVSmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Enable gotox tests for
 riscv64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Pei" <cp0613@linux.alibaba.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260923130856.1157-3-cp0613@linux.alibaba.com>
References: <20260923130856.1157-1-cp0613@linux.alibaba.com>
 <20260923130856.1157-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 13:13:16 +0000
Message-Id: <20260923131317.8BC251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation in verifier_gotox.c
--

commit 265e53ef1a0972464a42276e591e566a09035885
Author: Chen Pei <cp0613@linux.alibaba.com>

selftests/bpf: Enable gotox tests for riscv64
   =20
This commit enables gotox tests for the riscv64 JIT since it now supports
the gotox instruction and jump tables. It modifies verifier_gotox.c to
include riscv64 in the supported architectures macro.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/t=
esting/selftests/bpf/progs/verifier_gotox.c
> index 5b18c9a27717b..4a38f7da720af 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c

[ ... ]

> @@ -409,6 +411,8 @@ __naked void spill_fill_ptr_to_insn(void)
>  	: __clobber_all);
>  }
> =20
> -#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 || __TARGET_ARCH_powe=
rpc*/
> +#endif /* __TARGET_ARCH_x86 || __TARGET_ARCH_arm64 ||
> +	* __TARGET_ARCH_powerpc || __TARGET_ARCH_riscv
> +	*/

[Severity: Low]
This isn't a bug, but does this newly introduced multi-line comment follow
the BPF subsystem style guide? The subsystem guidelines explicitly require
that multi-line comments have the opening '/*' on its own line, rather than
beginning text on the same line as the opening marker.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923130856.1157=
-1-cp0613@linux.alibaba.com?part=3D2
