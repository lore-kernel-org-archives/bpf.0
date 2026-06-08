Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33834389A
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917264; cv=none; b=kv1ytBNQZg/xmP8wt+hbiMp2R8B/XM2Guc68g/Z4x1NnARtoBc9h1P7TFecaP4h+1pR59Tq5S/u5mZeA6h2FPwb6HYY+3+aLmwNBxG24yk380enNPNIjLatHl65K6e8PFbKkqtht9n2JNKIi8oNUPPuxnAKNm3mSqDhBooRl/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917264; c=relaxed/simple;
	bh=M3DD2m+fXho4svJjmvEEpFXUcIvCQL47UP2rpzrWLYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bli0mXqmD50i0L3Pj8zfplcsTLhc1HCLDrHgjxCezppL13x74g0CKX4j10vw7vJXwlSU0U3yvRYtk9vw8Q0UF/YXB6gru3jBIlvbdQ5raJIBUOM9JqHw4YbWiRoH8yF+9LRriOTD7dacizM5ls15y1OVxxbijNYe/OSdQrz3g28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAHfg5kZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAHfg5kZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2279B1F00893;
	Mon,  8 Jun 2026 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917263;
	bh=MdfBieDf9iGin2eHbx5wHzTcdCVzv43Uh1ZskgkjRvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oAHfg5kZX/X6wqerzfIthe/y5ou16mJWyBfOf7ysSuuF1msQH9Ht7RFX3fCLUCVSS
	 IW3e/+KiXT3Rigk4N7+PXiJHQvIu6tnhihsu4Y9aXuTDX00VrNW4lBpgpkrG4a+6cI
	 uF3wQKRnktZxyjEM4t6sAjXMbtrawr0ZH6zynoF3hqsDWfrDzGppp4AYE9vlfcyR9F
	 VHwQ1zpylORwC9LlXp2pCFpNGfIibD6Cm6yrbWrPL7ZdIHjCNwwLcX0iurbtcht65+
	 JEFGBD97ShMVCTuSt1NtkvJ6Lk1EcUvA48XGIuWyVS1FttHlECXygiEEBjy6tcVKZC
	 saZKqAA10/oGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] LoongArch: BPF: Inline
 bpf_get_current_task{_btf}() helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608103516.20643-3-yangtiezhu@loongson.cn>
References: <20260608103516.20643-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 11:14:22 +0000
Message-Id: <20260608111423.2279B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] If JIT compilation is disabled at runtime, the BPF interpreter wil=
l crash when executing helpers that are claimed to be inlined by the JIT.
--

commit 58b3e664499664c93a443a71b2b41eaa41f69bcd
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

LoongArch: BPF: Inline bpf_get_current_task{_btf}() helpers

This commit implements inlining for the bpf_get_current_task and
bpf_get_current_task_btf helpers in the LoongArch BPF JIT compiler.
It extracts the task_struct pointer directly from the $tp register.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 24913dc7f4e83..b93b67d22c26a 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
[ ... ]
> @@ -2367,3 +2374,14 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  {
>  	return true;
>  }
> +
> +bool bpf_jit_inlines_helper_call(s32 imm)
> +{
> +	switch (imm) {
> +	case BPF_FUNC_get_current_task:
> +	case BPF_FUNC_get_current_task_btf:
> +		return true;

[Severity: High]
Will unconditionally claiming that the JIT inlines these helpers cause
a crash when JIT compilation is disabled at runtime?

If net.core.bpf_jit_enable=3D0 (and CONFIG_BPF_JIT_ALWAYS_ON is not set),
the program falls back to the BPF interpreter. The verifier calls
bpf_jit_inlines_helper_call() during fixup_bpf_calls():

kernel/bpf/fixups.c:fixup_bpf_calls() {
    ...
    /* Skip inlining the helper call if the JIT does it. */
    if (bpf_jit_inlines_helper_call(insn->imm))
        goto next_insn;
    ...
}

Because this now returns true, the verifier skips fixing up the call offset,
leaving insn->imm as the raw helper ID. The BPF interpreter then handles
BPF_JMP | BPF_CALL by executing (__bpf_call_base + insn->imm).

Calling __bpf_call_base + raw_helper_id jumps into an invalid address space.
Could this lead to an immediate kernel panic when the BPF interpreter execu=
tes
these helpers?

> +	default:
> +		return false;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608103516.2064=
3-1-yangtiezhu@loongson.cn?part=3D2
