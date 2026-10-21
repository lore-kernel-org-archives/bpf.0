Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792613700;
	b=s5tUwL5FxBpfxkQaUXJUy+E0G+njNDw7KJhZGFZD/AMb+kmEfVpykJfsyFF4qcIWTTyY
	 C6Ei4YWfoga6FxLL1RhT8tzsIjlv7XttQ982MpGXQbF0Wufnjyl+hePfFSPUFZw0kV/8w
	 uxcOUPTtjzOO3RceDShTlVeh/fdFj2l6UIBU1SkM2XOJs+12ga9mOgL57jzffGUcTa48f
	 pEWNYa5+feuw999n1qRHNvpciuN63HzPxCTljCWz1QpTiz8HJ7JEXripcaNoVbz/jjiK4
	 7JSCpCwzaykdR0bH7yGgoypu6SXMGiZtAIUY6ZjUyJi7IY4gmAQHYT6yyhn5/Bawj/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792613700;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4G+I7djq1OU0EgGUZU0V9GlFagjXrwntNK7yPtcpldk=;
	b=Jyj3C/dXr53b7QgzjIMQstVs+2CnOe9421zsWGUfYlm2nSQeOngZwpOY+T/HpVN3JYx/
	 img5rn1IGWVxe0R423VPyOWaok6NbneaVA9Qul2s3X/5FKELL+VP4YE+W2fDjIcaLQerp
	 WxyT518H6IhEKKUB3jM7jE3CjirX/5Zn1thYyptAfWP9AWRk/UgBwlRW0YqKnIuM8fuKJ
	 tK5ARkyfuyXwqgTbdSvc8KR05I6Lv86KHnikA7BBR+ywB2hX/rtu832le85gc1VszBKDC
	 bmgaRMHl+6a5Wl13/7fH+Z5q8S/31jnE2By7BpavLHz6V3sVSyW6LTlZS4GCALK8fKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f13EnAHY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374D606A322
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f13EnAHY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EBB1F000C1;
	Wed, 21 Oct 2026 20:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792613700;
	bh=4G+I7djq1OU0EgGUZU0V9GlFagjXrwntNK7yPtcpldk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f13EnAHYUIQyw4PttRcvpiWPd4e7Lck9xSEyOAw0QFzzGZh2ZJ9/jvoSCZ1jO1eq2
	 HnsMW1VRmuXIBHnVy7VKWWPUU85Ft+5ZmoiQRK2SLygiVeR96NP3U+vBmIYa/Ax0iM
	 GRKvsuZ6jIwdcsr8nYlQtqUWwkCY5BpZ9JB5PmIFRR1RPPC+xAYbaINepGc32Bb+UA
	 F8FSdj476CvniCuru+dGicGIt9lchQPNXHaGusFaaTLME2UgTbJ6/XBEsiUUsnwPKR
	 nX32FJwuQ+4tulqVOF+8XOlM9h5JtH0kkfC1lL+1d5dpfEc2rxhWsAeewp3r4zl4rY
	 7m01tiMKDfoNg==
Date: Wed, 21 Oct 2026 13:14:56 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, yonghong.song@linux.dev
Subject: Re: [PATCH v4 bpf-next 2/6] bpf, x86: Support unwind_goto and
 unwind_exit
Message-ID: <20261021201456.GA3197963@ax162>
References: <20261020181320.1284798-1-alexei.starovoitov@gmail.com>
 <20261020181320.1284798-3-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020181320.1284798-3-alexei.starovoitov@gmail.com>

Hi Alexei,

On Tue, Oct 20, 2026 at 06:13:16PM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
>   bpf                         x86
>   call inner                  call inner
>   unwind_goto pad
>   w0 = w6                     mov eax, ebx
> 
>   r0 = 0                      xor eax, eax
>   unwind_exit                 push rax
>                               push rsi
>                               mov rdi, [rbp + 8]
>                               call bpf_unwind_target
>                               mov [rbp + 8], rax
>                               pop rsi
>                               pop rax
>                               leave
>                               ret
> 
> unwind_goto is an extable entry and no code. unwind_exit looks its return
> address up there and returns to the pad. r0 and r2 are what a subprog
> returns, so rax and rsi are saved around the lookup.
> 
> When there is no entry, the kernel called the subprog as an async or an
> exception callback, and unwind_exit is exit.
> 
> The caller of the main prog doesn't tell exit from unwind_exit, so there
> it's exit. An extension is different. freplace is a jump, so its return
> address is the one of the subprog that it replaced.
> 
> With private stack r9 is saved around a call, and 'pop r9' has to be done
> on the way to the pad too. In such progs unwind_goto is:
> 
>   push r9
>   call foo
>   pop r9       <- exit returns here
>   jmp 1f
>   pop r9       <- unwind_exit returns here
>   jmp pad
> 1:
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

After this change landed in -next as commit cff94a3d78d8 ("bpf, x86:
Support unwind_goto and unwind_exit"), I am seeing the following objtool
warning when building with LLVM 23.1.4 and a recent tip of tree version
of LLVM 24 with the attached configuration (which can become an error
with CONFIG_OBJTOOL_WERROR):

  vmlinux.o: warning: objtool: do_jit+0x1330: relocation to !ENDBR: .text+0xc7fab

Something like the below diff appears to inhibit this but I am not sure
if it is too big of a hammer or if there is a better solution, hence
just the report and deferring to you, but maybe it is a good starting
point.

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d3ab36281144..b80f05f377c2 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -641,6 +641,7 @@ static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
 
 static int emit_call(u8 **pprog, void *func, void *ip)
 {
+	OPTIMIZER_HIDE_VAR(func);
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
-- 
Cheers,
Nathan
