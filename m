Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351B175A85
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774223455; cv=none; b=aVpkfMtVTF3rZ7apKXBKBWuwARnPfet6phqCiPWLpsau1gTgH+48vAq/szB58HVMdZe/nsnbi++yAhlg2L4w8zz1ASXg+DVx9o8fo1jyPmOg7SwxU1EuLWy4exJdD0AzlZxjr7eQ1FJBVCUt++xhfsAIqxuZukcgHOqZaLFKycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774223455; c=relaxed/simple;
	bh=LRl8AOtQ+QSoqiuzcsYRqyjdWZfyvJbTUJr6ucI0q6g=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FJqSpT3e/s19iFzUmEo+FZYJrFJroi0ZY0a6XbFikPaY5Wr9fDLrQzSZtiLdyLyoPtsPHTz7VmA9WDC56hInqZhqnHKbM6K66w1lIAvN1cHDXHrbQgXO0XkD8l3ioTILV8niFXf48qmHTgB5sADcndJZMQchkv8FxshW/vPMnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPACs0dB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPACs0dB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3FCC19424;
	Sun, 22 Mar 2026 23:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774223455;
	bh=LRl8AOtQ+QSoqiuzcsYRqyjdWZfyvJbTUJr6ucI0q6g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=KPACs0dB+BiU726LKiNpqgrd3kgSEcZua3xmFnJri16h+/FWXPvx/Eum7rgX7IOFm
	 ytsTerISuXgfJSZm/8criqokgdkLdP8OAirWotgbix8SKKHNBcBH/irWy5ldXLgbWP
	 iOHFnpF6Aj0Bd5xKnaqEcPdTOwkURKo1O0ob64/ZhfcfvwuM/Eyc1pEZ4JPfn6VU9J
	 rJFHifoirbPy5jeNmAVMFRijJQunRTIVibrt5wbN1Wsf0r/+kvK3efoJfrfV/LOyfG
	 N7WY2yzOcy3vyNsZCeNuyowhjdWETnzgrmUtvLBt32onU1NDWOPPJQ+s9mhGrxvIUX
	 NA7NX/Coi39fw==
Content-Type: multipart/mixed; boundary="===============2021886991752922692=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86e725138c1a26dceb2a27cecd06d0fafaed5731985b817a3ddbc9d60d4869ce@mail.kernel.org>
In-Reply-To: <20260322225124.14005-1-alexei.starovoitov@gmail.com>
References: <20260322225124.14005-1-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Support 32-bit scalar spills in stacksafe()
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 22 Mar 2026 23:50:55 +0000 (UTC)

--===============2021886991752922692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 80a9eab79cac8..186c912cf72b3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -20070,13 +20071,15 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,

The unchanged comment just above this hunk in stacksafe() reads:

  /* 64-bit scalar spill vs all slots MISC and vice versa.
   * Load from all slots MISC produces unbound scalar.
   * Construct a fake register for such stack and call
   * regsafe() to ensure scalar ids are compared.
   */

> +		if (im == 0 || im == 4) {
> +			old_reg = scalar_reg_for_stack(env, &old->stack[spi], im);
> +			cur_reg = scalar_reg_for_stack(env, &cur->stack[spi], im);
> +			if (old_reg && cur_reg) {
> +				if (!regsafe(env, old_reg, cur_reg, idmap, exact))
> +					return false;
> +				i += (im == 0 ? BPF_REG_SIZE - 1 : 3);
> +				continue;
> +			}
>  		}

The comment says "64-bit scalar spill vs all slots MISC" but the
code now also handles 32-bit scalar spills at im == 4 and partial
MISC checks via is_stack_misc_after(). Should the comment be updated
to reflect the generalized behavior?

Also, the commit message states that save_register_state() "populates
slot[0-3] = STACK_MISC" for a 32-bit spill, but mark_stack_slot_misc()
preserves STACK_INVALID and STACK_ZERO:

kernel/bpf/verifier.c:mark_stack_slot_misc() {
    ...
    if (*stype == STACK_ZERO)
        return;
    if (*stype == STACK_INVALID)
        return;
    *stype = STACK_MISC;
}

On a fresh (uninitialized) stack, slot[0-3] would remain STACK_INVALID
rather than becoming STACK_MISC. The selftest in patch 2/2 correctly
identifies this as STACK_INVALID in its commit message. Could the
description in this commit message be made more precise?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23414666848
--===============2021886991752922692==--
