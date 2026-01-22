Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977203542C6;
	Thu, 22 Jan 2026 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102433; cv=none; b=QhR/CalySWWFtHn3AbLZsV/kaJC9lkIZFXjO8JdJvL7fWIOlmxkqdmQpdXzpV+xkEqh+4W2moIixY1qyYEnMy0dlaqoZ3SE/t9HcIIeiKwA4h7jPwHzoIml1kwouS1aNSOcEs9sbPtEAFk5SkQyzEZqFrSPPGU+p67PlYXG0IXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102433; c=relaxed/simple;
	bh=3c9sDkew6GCT5xUI6wSas5sFIuGc+u8uHeh8LoCRej4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UjXe+f0BdXc/vYF6tQ28lXAgsLpR4x8kXkueKhcFdYGh/K5r+CXnWsQl2JNfqFAhAABmqYzdoFgwaiz1i4Xj8fVyMdlYk3Vne0SHLVz/BBakmjtldis69SATa9aIBWohWwNKm+h7h7AbA37VtQ//K5dSqAKOzjqybMkcP0eBKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clqTqZOy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clqTqZOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A966C116D0;
	Thu, 22 Jan 2026 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769102432;
	bh=3c9sDkew6GCT5xUI6wSas5sFIuGc+u8uHeh8LoCRej4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=clqTqZOyXuVxdn6h4Qmi80y2KviZ4uf4g0CGe7zQx+QUpyzazlFuY6Gw794EqaJEY
	 Ho+C0Lufvbg7UTLdbHvQ3GTzcDM/0Lq2a5K8xVKWZ7HMUQ3bvGYBZhLw8mm83PK+bC
	 x5Y36rWfC3N3uhJvMkBFA0EjeJ/fH5uS5uahshTEpvU3lWdKCgsLXB4lvreGT0pj+B
	 TmLw/MrCB7M9beg6kUBbKF+4t9vZDg0TdlYQiUMFa9JyyKYWNonJtczQfxWjqnVKCs
	 jVwkNzZHzL9hsGEW+aPT0qn95hkEAy+ltM0YASMWOZDBSOFQn62MnV0sh9KfP7nBtw
	 s2zXAPDHqIKMg==
Content-Type: multipart/mixed; boundary="===============8053750252812221712=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <22e06dcc5ec469f864880ccacfa910635460878396907005ba9f80f40d01779e@mail.kernel.org>
In-Reply-To: <20260122165716.10508-4-adubey@linux.ibm.com>
References: <20260122165716.10508-4-adubey@linux.ibm.com>
Subject: Re: [PATCH v3 3/6] powerpc64/bpf: Avoid tailcall restore from trampoline
From: bot+bpf-ci@kernel.org
To: adubey@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com,sachinpb@linux.ibm.com,venkat88@linux.ibm.com,andrii@kernel.org,eddyz87@gmail.com,mykolal@fb.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,christophe.leroy@csgroup.eu,naveen@kernel.org,maddy@linux.ibm.com,mpe@ellerman.id.au,npiggin@gmail.com,memxor@gmail.com,iii@linux.ibm.com,shuah@kernel.org,adubey@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 22 Jan 2026 17:20:32 +0000 (UTC)

--===============8053750252812221712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index f3ee031edc26..9a8236d161ef 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -662,16 +662,11 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
>  static void bpf_trampoline_restore_tail_call_cnt(u32 *image, struct codegen_context *ctx,
>  						 int func_frame_offset, int r4_off)
>  {
> -	if (IS_ENABLED(CONFIG_PPC64)) {
> -		/* See bpf_jit_stack_tailcallcnt() */
> -		int tailcallcnt_offset = 7 * 8;
> -
> -		EMIT(PPC_RAW_LL(_R3, _R1, -tailcallcnt_offset));
> -		EMIT(PPC_RAW_STL(_R3, _R1, func_frame_offset - tailcallcnt_offset));
> -	} else {
> -		/* See bpf_jit_stack_offsetof() and BPF_PPC_TC */
> -		EMIT(PPC_RAW_STL(_R4, _R1, r4_off));
> -	}
> +	/*
> +	 * Restore tailcall for 32-bit ppc.
> +	 * See bpf_jit_stack_offsetof() and BPF_PPC_TC
> +	 */
> +	EMIT(PPC_RAW_STL(_R4, _R1, r4_off));
>  }

After this change, on PPC64, the function unconditionally emits
EMIT(PPC_RAW_STL(_R4, _R1, r4_off)). However, r4_off is only assigned a value
in __arch_prepare_bpf_trampoline() when IS_ENABLED(CONFIG_PPC32), and is
initialized to 0 otherwise. Since __arch_prepare_bpf_trampoline() returns
early with -EOPNOTSUPP for PPC32, only PPC64 executes this code, meaning
r4_off will always be 0.

On PPC64, PPC_RAW_STL maps to PPC_RAW_STD. Will this emit a store of R4 to
offset 0 from R1, which is the stack back chain location? The comment says
"Restore tailcall for 32-bit ppc" but the code runs unconditionally on all
architectures.

Looking at bpf_trampoline_setup_tail_call_info() in the same file, it properly
handles the two architectures using if (IS_ENABLED(CONFIG_PPC64)). Should this
restore function have a similar guard, or return early for PPC64 since the
back propagation is no longer needed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21257691486

--===============8053750252812221712==--
