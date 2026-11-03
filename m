Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732249;
	b=tLDvl3lK7rohwFGnPjScCg+B9AaKzfQAw2/hhfou2iqiFf9sppxFD5Q5nw9CMeVKPZ+a
	 DD01UPcIYZGntSXxKGpfu4IJJPOnTiqaiGYSqa74riBS8lS66NV/llLh1jQnY0WjoYjPn
	 oGHDbGF1YXPCUgFZzVubDLlhfCJcE/JEEEeS6pNtLgGrtRKcEP+Qsbafaz2a22m4bDygD
	 w8L4WcWKWcf/72zboQKHl83oum2D4Vegd361sCgFRgE41kKWm4cFo+MMp17Zv+qK4h15D
	 rKBPsAAalZgFvrunhqoA1NugQE5ivNobpOQ11boO3Cy+G/G1qfXO9+f3fZzCmKJdD7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732249;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=g69S8+GH4E7ROUQ2MTyefLA1cl8CrsvgE37YTTMn6hM=;
	b=DZsS9ZpyE1FSLvg0al0oq52U7KPrSb63CRHe3drgSbNrn9nAvBu0yA3X24r+Q/fQN/QI
	 oI3WmwCUOxvJKuepBLFJ+XV35UYCKbJcp8cxkpu3OGakjnVgkkcFHDtLKXdsSdw6+WoxS
	 X2iTr+yuGjIT+bj08XQV8M/xQ6ijA9mqoWFelnaY5zEbjPKGNI0t/W3VPx3/InXCyYlqN
	 swOejKJylvqKOlfdBURms0rOlM4YIQrW5QaUaE1QIjrl/10inJJYgMWyh3T3NNL0jOkRD
	 qv1QlCltEKbw4zC3ZNRJtgx44p6k4NOCi32S9Tt7yq5tQZ4i4C6/JWhRGa4UqFh2X1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HUk/lRG1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AA606A333;
	Tue,  3 Nov 2026 18:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HUk/lRG1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC871F00A16;
	Tue,  3 Nov 2026 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793732249;
	bh=g69S8+GH4E7ROUQ2MTyefLA1cl8CrsvgE37YTTMn6hM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HUk/lRG1DCACpNbIEvFSCCaLByFE6/f1tD9ghwDOOEqQLFWskW1VlGUIZK8DrFxEI
	 gPDQ69irGX5PnzCXlkdXca8P20SHZWIGp3vGEhFwpuAdxZEUXSpqgiKglTJgD0HhKg
	 C8I8TSk1FcdO15fIKurX6HEGnwjrY4UMFZF4t7fYLIu5LewH9u/CZGS+bHd3NbHfUb
	 QbvEX4SZuCPsUwuZOKTfV/Fs9o2PbwzWTbra2N6T2Ma//GMSG3m0BAAoq44SmkZs2R
	 y8cTkuHPiJ+dkqYkUenn+p2tSBaqRRSCG3G2taRmTk4epUd0p4YoVUXOz1R38tXU5W
	 oleh5A9WM85nQ==
Content-Type: multipart/mixed; boundary="===============7381898502898168857=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <daf9d2a5cb93efffb7a93acacf6db462120c05a9d39c7947210e904644908242@mail.kernel.org>
In-Reply-To: <20261103181816.254686-6-vineet.gupta@linux.dev>
References: <20261103181816.254686-6-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v4 5/8] selftests/bpf: write the mixed arena/scalar ALU tests in asm
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,jose.marchesi@oracle.com,david.faust@oss.qualcomm.com,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 18:57:28 +0000 (UTC)

--===============7381898502898168857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: write the mixed arena/scalar ALU tests in asm

TL;DR: Commit message only, no code issues: it refers to a follow-up patch as
"6/8" and says an arena-capable GCC is needed; both should name the commit by
subject, since series numbers vanish from git history.

> selftests/bpf: write the mixed arena/scalar ALU tests in asm
>
> They fail to build with BPF_GCC:
>
>   progs/verifier_arena.c:566:5: error: optimization may eliminate reads and/or writes to register variables [-Werror=volatile-register-var]
>
> for
>
>   volatile register __u64 reg asm("r3");
>
> and GCC means it. With the warning silenced it drops both scalar
> accesses, leaving nothing that uses r3 as a scalar:
>
>   call	7
>   if w0 == 0 goto .L136
>   r9 = arena ll;r3 = 0;r3 = addr_space_cast(r3, 0, 1);
>   .L136:
>   r0 = 0
>   exit
>
> `reg = 1ULL << 32' and `reg += 1' are both gone. The tests need one
> instruction reached with r3 live as a scalar on one path and as an
> arena pointer on the other; what is left gives the verifier no reason
> to reject anything, so the __failure expectation would not hold. A
> local register variable is not guaranteed to survive a helper call
> either, which GCC is also entitled to act on.
>
> Nothing here needs a compiler to allocate registers, so write the
> whole body in asm like mixed_arena_stack_atomic below, which tests the
> same shape. Both compilers then emit the same sequence, with the
> branch landing on the shared ALU op:
>
>   call 7
>   r6=r0
>   r3=1
>   r3<<=32
>   if w6==0 goto 4          <- lands on r3+=1
>   r9=0 ll
>   r3=0
>   r3 = addr_space_cast(r3, 0, 1)
>   r3+=1                    <- scalar on one path, arena pointer on the other
>   r0=0
>   exit
>
> And while here also bring in __load_if_JITed(). A program binding an
> arena map is rejected in check_map_prog_compatibility() with "JIT is
> required to use arena" during map resolution, before do_check() can
> reach the shared instruction, so without a JIT these would fail on the
> wrong message rather than skip.
>
> Both tests become visible once 6/8 stops hiding them, and pass:
>
>   verifier_arena/mixed_arena_scalar_alu64_scalar_first   -> OK
>   verifier_arena/mixed_arena_scalar_alu64_arena_first    -> OK
>
> Notes:
>  - This does need an __arena capable BPF_GCC.
>  - Under clang the rewrite is not a no-op: the existing version spilled r3
>    to the stack and did the shared ALU op on r1 reloaded from it, so the
>    test was not exercising one register live as both a scalar and an arena
>    pointer.
>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>

this isn't a bug, but could the changelog name the follow-up commit by its
subject instead of "6/8"?  The series number is not kept once the patches
are applied, so the reference no longer identifies anything in git history.

The same applies to the "Notes:" line "This does need an __arena capable
BPF_GCC", which only holds once that later commit has dropped the
__BPF_FEATURE_ADDR_SPACE_CAST guard around these tests.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41694978246
--===============7381898502898168857==--
