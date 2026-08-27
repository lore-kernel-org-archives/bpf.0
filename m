Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFE035B136
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814285; cv=none; b=UxeCbSwUgUesEuzpyw2vm+tRSVKrnweha6vOP5h226lqZ0RrptMD3HjFScRgHkE60/t11lUbKfuiLMTEvIJNnaGPLfCb3uAUnTsqlLy8I1qbWXhzQr4LffO5mNxU1llp2KS3mjYcQFb5aslhzO63IbIPq6IxSfebZdGjDoyfcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814285; c=relaxed/simple;
	bh=VixAD0445C7xSqnNxgRj7Fyc+qzQPATMvhKuxLqZTC0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MzN0VTHGQVdPndRnXtzlj+xsELhQ3HQ7X+cOqWCwPEjq+ywqSUeT/+W7DZHgBbxlh2qyuM2pKvIibxCx2H7EtPZgjMFvZUzmQWb08+VNWhYEbUXseXRcELEgyKXApd2XS8dOkX9Tf94zupjyKqXqXneAOPPq4G3oVNzBmZ1dx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJljRGtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJljRGtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C7271F00A3A;
	Thu, 27 Aug 2026 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787814283;
	bh=tB1S6RzGzabE1qxNeC/msLGUzetZgjzzrgkiwnBxBUI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=VJljRGtpT+yV66yekWFyEfzVLKvzUWDMrjRgttwF5Yqp8OJq2UnhGPNdSRUb4XvZX
	 kt1YTECHfPClF/7RA94oexFBAZtlRP5QtVQT+7x8MTA3t7eCICzAAkPvahdVX6w0gt
	 jrVaVDagGBFf1B2HdO0zLiWQeYoQujfIzlzp2SEg2KWsPSuIejfH+KaSawl6wZygh5
	 M7ebqWZjR9I0Pu6IuL+LXjKCiF+xUsoAvIuDg1GxRx1QrM0OsuCOwdSFMiMugONRQW
	 sutBS1Yy/RsnUMXccK12rWsshbPY+KrzQhin/ZjwjfCgyz3ohxK2/ev5dDresM1MaH
	 fHVMya+aOCVaw==
Content-Type: multipart/mixed; boundary="===============5101253226057180500=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a029d698010cf5a0306af0758d0b2d9454903521e299f0c84bc0c26864618168@mail.kernel.org>
In-Reply-To: <20260827061155.2518937-1-yonghong.song@linux.dev>
References: <20260827061155.2518937-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 08/11] selftests/bpf: Check the member named for an unsupported kfunc return type
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 07:04:43 +0000 (UTC)

--===============5101253226057180500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> index f10e5cf6fd890..e9c82df8efb26 100644
> --- a/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c
> +++ b/tools/testing/selftests/bpf/progs/aggregate_ret_kfunc.c

[ ... ]

> @@ -72,6 +74,7 @@ __naked int aggregate_ret_kfunc_fastcall_fail(void)
>  SEC("tc")
>  __arch_x86_64 __arch_arm64
>  __failure __msg("is not composed of scalars or arena pointers")
> +__msg("member 'p' has type PTR")
>  __naked int aggregate_ret_kfunc_ptr_fail(void)

[ ... ]

> @@ -84,6 +87,37 @@ __naked int aggregate_ret_kfunc_ptr_fail(void)
>  	: __clobber_all);
>  }
>
> +SEC("tc")
> +__arch_x86_64 __arch_arm64
> +__failure __msg("is not composed of scalars or arena pointers")
> +__msg("member 'in.p' has type PTR")
> +__naked int aggregate_ret_kfunc_nested_ptr_fail(void)

[ ... ]

> +SEC("tc")
> +__arch_x86_64 __arch_arm64
> +__failure __msg("max struct nesting depth exceeded")
> +__naked int aggregate_ret_kfunc_too_deep_fail(void)
> +{
> +	asm volatile (
> +	"r1 = 0;"
> +	"call %[bpf_kfunc_call_test_ret_deep];"
> +	"r0 = 0;"
> +	"exit;"
> +	:
> +	: __imm(bpf_kfunc_call_test_ret_deep)
> +	: __clobber_all);
> +}

A subsystem pattern flags this as potentially concerning: the commit
message states the third case covers "a type nested deeper than the
walk descends, which has no single member to blame and reports the
depth instead." But the test's only assertion, __msg("max struct
nesting depth exceeded"), pins a string that predates the series.

Looking at the verifier code, the depth report text ' It nests structs
more than %d levels deep.' was added by commit b99471ca9c385, and
unlike the member case there is no verbose() counterpart for it - it
is only emitted through bpf_diag_program_structure(). This diagnostic
output is reachable to __msg since libbpf retries a failed load at
log_level 1.

If the new path->too_deep assignment and the entire 'if (path.too_deep)'
branch were deleted, path.depth would still be 0 (the too-deep return
bypasses the bad_member/bad_path labels), member_note would stay "",
and nothing else would change in the log. The test would still pass even
though the new behavior was not present.

The two sibling tests don't have this problem - 'member 'p' has type
PTR' and 'member 'in.p' has type PTR' are both new strings from
b99471ca9c385 and directly verify that the kernel names the member
correctly. The too_deep test also omits the __msg("is not composed of
scalars or arena pointers") anchor that both siblings carry, so it does
not even pin that the failure came from the kfunc-return path.

Would adding an assertion on the depth diagnostic text plus the anchor
message make the case more discriminating?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33045482525
--===============5101253226057180500==--
