Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606A4AD4C1
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214022; cv=none; b=VjFG183xwjCa3s5p27QpLJayt1R3jIolUnx2Hq/kHUz+Gyz4dN/gkpWGgkyZF0AtkwOGNejX6ZCluGpSSxSoLw97XJnleIUgM35VxHEXA1c+oJ8t6H8cqEL1a+Eu50JlXfmQYWEA8F3tGFFtjoyrqpMocWZl5471c7NVpVRlr7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214022; c=relaxed/simple;
	bh=5KvQezVLUuC5pXF8PiWbNQUJXXCv2PZY1rBHQVHb2ik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FJzz62jRXIGO8XZZIM9Dzrv5dat9zOuKRRC5fi+aOfjat0zmtOH6B9WjGfYuNkMNa4VqrJsVrwwMa89+81rRZSwNhrwwvL8HWtBAo4PTL3Fq6Fdc14+1W7cTxLZFZTh7qO5Cqk0Zbx+hTGVPtRPzbGJtYYGQEp4VaDriAZ1jl1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsPq0Sfu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsPq0Sfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772211F000FF;
	Mon,  5 Oct 2026 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214020;
	bh=MvrLURg9i5EyN2kOH+zQydx7lWUHwVuhfOtZlTEQ2Xo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WsPq0Sfu1egeTSlRLiN5zzDF+Ab2KLjq3uA8nMZUYpFVSHyF5iZdXmEa/tF0+8vFx
	 rJ3rAUXoGgEPdx+lSKn92fKE67PWXTTQFRLrSIcHpfddM/VCPp6PoekMQFdbYj6jHz
	 HF/EFL/ezY5ZZViVKKP8pOPw+rxKEHuqehOR6DVGwmKBU4En4tJekQpvBSGRt9UOT3
	 fHCKb0xHmqzWU11ZCzm3O+vSWlpwbcv7Q6DKbOUy8Xw3WCO0gLWRdqcqwljSWiL5JK
	 +SYS14/HzUQK0BXAM0waE7wINHLt0oMp9TFQ+itIzhxCfDYGGJxln3Z6uVVasjQi9b
	 fiDPe9+PWE28g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 1/2] bpf: Require referenced or trusted pointer for
 __arg_trusted arg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261005-a3-arg-trusted-v4-v1-1-50ee0268fd39@mails.tsinghua.edu.cn>
References: <20261005-a3-arg-trusted-v4-v1-0-50ee0268fd39@mails.tsinghua.edu.cn>
 <20261005-a3-arg-trusted-v4-v1-1-50ee0268fd39@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 15:26:59 +0000
Message-Id: <20261005152700.772211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: wrong multi-line comment style in check_func_arg()
--

commit 66de311fe0f463c286064b3e009d6635674afd83
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Require referenced or trusted pointer for __arg_trusted arg

This commit modifies the verifier to reject PTR_TO_BTF_ID pointers that are
neither referenced nor trusted for arguments marked PTR_TRUSTED. It fixes an
issue where a bare PTR_TO_BTF_ID or MEM_RCU could bypass checks in subprogr=
am
calls.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fd3c0206bd67d..fe5edbef85a16 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9597,6 +9597,27 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg, u32 slot, u32 p
>  			}
>  		}
> =20
> +		/* A __arg_trusted argument requires a referenced or trusted
> +		 * pointer. btf_ptr_types also matches a bare PTR_TO_BTF_ID and

[Severity: Low]
This isn't a bug, but does this violate the BPF subsystem multi-line comment
style? The BPF guideline requires the opening /* to be on its own line for
multi-line comments.

> +		 * an MEM_RCU one, but neither is referenced or trusted, so the
> +		 * callee would be verified with PTR_TRUSTED while the caller
> +		 * passed something that is not. PTR_MAYBE_NULL is not counted
> +		 * as unsafe when __arg_nullable declares it, because
> +		 * bpf_type_has_unsafe_modifiers() treats that flag as unsafe.
> +		 */
> +		if ((arg_type & PTR_TRUSTED) && base_type(reg->type) =3D=3D PTR_TO_BTF=
_ID &&
> +		    !reg_is_referenced(env, reg)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-a3-arg-tru=
sted-v4-v1-0-50ee0268fd39@mails.tsinghua.edu.cn?part=3D1
