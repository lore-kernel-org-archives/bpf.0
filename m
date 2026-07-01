Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4503B47F2C3;
	Wed,  1 Jul 2026 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907049; cv=none; b=nGegrL1HOVWpfoloeDaqzVaFnZou5dRfnFFuodBQCv8cW/tKZzDYU/TkYUBUOrqA5jLFf2/mfhNnUSXdj697PMUL00lGqNci48uBQ88yySIJtISzUrONYIrgdUqt7Ig/K633JW21FQ/Ude0pPTCmU0nUyqqSh7+9R5VFDgGE4gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907049; c=relaxed/simple;
	bh=ZUU03A8w/B6xrDBbWiu8jFWT8odRw2O+gPvzJy/toPc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FdKcLbGEIUXJ3pAtiufl5U/EZOsgFxrdsNl/BnuJ42Z1bToO5ApTBbQC0euGU8fwgPgH73opZj2ce3IkpIqgv31vkvHIJsuPDAguhFhUGilMj+M8ophOyMgfVVCtNYESHeRLfGm1bHPAUS0G/mxD4asmgDLTDXQWnOZexI91rFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nji7s0qv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nji7s0qv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9371F000E9;
	Wed,  1 Jul 2026 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907047;
	bh=rhYXZRLA1X9ujZhf753ZxH8w0AlHmBTOEKHArhSHUxs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Nji7s0qv1vbRhTj+m7RDJN39fVQFcuRNmUHb56NhNqBkTwOpz4/SMnKa17/5b5gDm
	 63CybCXVtyWyNuUs13SWTFVLJqFG/E2wtJNZP2WgQm8BUM2Gu05hkgQQB7PRug60b/
	 QsYMToJxDqJo2qWSpSyg1jWOAk2OX6IxUP9EVlmg8MDTGVgpS9KwOakNNokhjlbQYY
	 I43N7QP7cD0QG4DPSBv7RDj+mP+F++Hgpao6B9TZgxoqCBgQ0ZoGMnDSLtMntnqecx
	 FYapASxnvsArpEfVbUy4cPlTtuEBQvem6j7s2OQQuUOgMNSOMWHR/wtjXt8TZfQ/cE
	 zI5oNJhPprRqw==
Content-Type: multipart/mixed; boundary="===============2339572275471711898=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f8a1b24c80382f961103107220cab7b4de971c263d62c643b24d69c399a47abb@mail.kernel.org>
In-Reply-To: <20260701111337.53943-6-jolsa@kernel.org>
References: <20260701111337.53943-6-jolsa@kernel.org>
Subject: Re: [PATCHv5 05/13] uprobes/x86: Move optimized uprobe from nop5 to nop10
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  1 Jul 2026 11:57:27 +0000 (UTC)

--===============2339572275471711898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Note as explained in [2] we need to use following nop10:
>        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
>
> which means we need to allow 0x2e prefix which maps to INAT_PFX_CS
> attribute in is_prefix_bad function.

This isn't a bug, but could the changelog be updated to describe the
approach actually taken? The patch bypasses uprobe_init_insn() (and
therefore is_prefix_bad()) entirely when can_optimize() is true for the
nop10. The is_prefix_bad() function itself remains unchanged and still
returns true for the CS prefix.

> Unoptimize path (int3_update_unoptimize):
>
>   1) Initial optimized state:
>       48 8d 64 24 80 e8 d0 d1 d2 d3
>      Same as 3) above.
>
>   2) Trap new entries before restoring the NOP bytes:
>       [cc] 8d 64 24 80 e8 d0 d1 d2 d3
>
>      From offset 0 this traps. A thread that had already executed the
>      LEA can still reach the intact CALL at offset 5.
>
>   3) Restore bytes 1..4 of the original NOP while keeping byte 0 trapped
>      and byte 5 as CALL.
>       cc [2e 0f 1f 84] e8 d0 d1 d2 d3
>
>      From offset 0 this still traps. Offset 5 is still the CALL for any
>      thread that was already past the first LEA byte.
>
>   4) Publish the first byte of the original NOP:
>       [66] 2e 0f 1f 84 e8 d0 d1 d2 d3
>
>      From offset 0 this is the restored 10-byte NOP; the CALL opcode and
>      displacement are now only NOP operands.  Offset 5 still decodes as
>      CALL for a thread that was already there.
>
>      Tthere is only a single target uprobe-trampoline for the given nop10
>      instruction address, so the CALL instruction will not be changed across
>      unoptimization/optimization cycles.

This isn't a bug, but there's a typo: "Tthere is only a single target"
should be "There is only a single target".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28514315910
--===============2339572275471711898==--
