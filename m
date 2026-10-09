Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C4432BD6
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791547658; cv=none; b=lQRfblnzF1vHsOaNJW6gS6bBMU4sFkFy0MfjVUxRrrnIYHoGT0C+25VAh0vSSt8crWxYZ5f2O9wagVUVoCtcUOcyiOHVuFDC3WtFUsn7R9zpixcBiOM4ROV7B2TNoOkUVosoq7z3nFJ1xN9QM7H3wx/WQRn5rSq/T9J++9euBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791547658; c=relaxed/simple;
	bh=EckT4ecjnXvhfTOYR+5voDL47gbtUjba8WvnsT0bjUc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=idWGg3kClJ6FBGckjQkmK5R2t+GGet63AlCQ+/KfaNtBPH/4PdHJolnNYvpsF2CgP9nz4Js4kKskKuZ1ge0PGva3o6pAJlB6u91+5KS3+qVSiNSxuDUodN1bz5VUWZjrlp7a3MSyjrbzEquma+qO7SBP/72ChPOuy31BYrmUqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSIvS5JC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSIvS5JC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81581F000FF;
	Fri,  9 Oct 2026 12:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791547652;
	bh=7kJB/hirga2rTmGVF1x3CnXU37xp3cXTgGnJIbUPthE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dSIvS5JCkP8Z7KjURBDXsfceurOHK6Y7xomXTkRUvxYgEuLlytvlnAQakZFfT7Z4F
	 p2VLZMnpwDvtna/j8c6cA76RMGLwjqG0nrE82T2Xhps7wTRftASK5sZ+/BdfFKrIas
	 JWCARVUx6igvbtP72vsgKMgJWHwHalxdUjyLUx2pnTD3W5xid96Tfun8SStwOIxVTd
	 YuBIbVH/208zm2hneO5D9gXPxo1/ErEKdUBGlxZ7Gdh4G1dXe/iaTI38872pa8T64Q
	 MV8gxI+Wcj1SxnHC2hmDt0odvo7bMHia00Uu7z7T8+CgxfPdsW/9lB5/anZAgaPPOs
	 LZU1DodJk58Bg==
Content-Type: multipart/mixed; boundary="===============3592105562042583579=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e552bb2846575b625bfb8db88a7d567467a337e1c42a1a6c75829b34909b44a3@mail.kernel.org>
In-Reply-To: <20261009-scev-minimal-rebase-v3-46-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-46-bcba9bc53ac9@gmail.com>
Subject: Re: [PATCH bpf-next v3 46/51] selftests/bpf: tests for register base/step arithmetic
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  9 Oct 2026 12:07:30 +0000 (UTC)

--===============3592105562042583579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: tests for register base/step arithmetic

TL;DR: In verifier_bounds_step.c, the __no_step check on the "w5 = (s8)w1"
pattern looks unable to fail, since the trailing {{.*}}) swallows any "step="
text, so a missing step reset in sign-extension would go undetected.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_step.c b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
> new file mode 100644
> index 000000000000..3a0d22aa4fb8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds_step.c
> @@ -0,0 +1,363 @@

[ ... ]

> + * w4 = (s16)w1  -> [0, 168]    step=0+24
> + * w5 = (s8)w1   -> [-128, 127] no step
> + * Bounds and step stay in sync, the step is dropped when the value does not fit.
> + */
> +SEC("socket")
> +__success __log_level(2)

[ ... ]

> +__msg("r3 = (s8)r0 {{.*}}R3=scalar(smin=smin32=-128,smax=smax32=127)") __no_step
> +__msg("w4 = (s16)w1 {{.*}}R4=scalar(id={{[0-9]+}},smin=smin32=0,smax=umax=smax32=umax32=168,{{.*}}step=0+24)")
> +__msg("w5 = (s8)w1 {{.*}}R5=scalar({{.*}}smin32=-128,smax32=127,{{.*}})") __no_step

Can the __no_step check after the w5 = (s8)w1 pattern ever fail?  It looks
like it would pass even if a step were left on R5.

__no_step expands to __not_msg("step=") __msg("\n"), and
match_negative_msgs() in test_loader.c only looks for "step=" between the
end of the previous positive match and the next newline.  The positive
pattern here ends in {{.*}}), and with leftmost-longest matching that
trailing .*\) runs to the last ')' on the line.

R5 is the highest-numbered scratched register at this insn, so the last
')' is the one closing R5=scalar(...).  print_reg_state() emits
"step=%d+%d" just before that closing ')', so any step text is swallowed
by the {{.*}} and the span left for the negative check is empty.

For example, if the reg_step_reset() in coerce_subreg_to_size_sx() were
removed, R5 would keep step=0+24.  zext_32_to_64() would not drop it
either, because reg_umax() at that point is still the copied 64-bit umax
of 168.  The log line would then be:

  R5=scalar(smin=0,smax=umax=0xfffffff0,smin32=-128,smax32=127,var_off=(0x0; 0xffffffff),step=0+24)

and the test would still pass.  I checked this with libc regcomp/regexec
on a log line built the same way.

The comment above the test says "w5 = (s8)w1 -> [-128, 127] no step", but
no other test in the file covers the coerce_subreg_to_size_sx() reset:
step_movsx only uses 64-bit sign extension, and w4 = (s16)w1 takes the
no-op path.

The R3 check a couple of lines earlier works only because its pattern ends
in an explicit "127)".  Would dropping the trailing {{.*}}) from the R5
pattern, e.g.:

  __msg("w5 = (s8)w1 {{.*}}R5=scalar({{.*}}smin32=-128,smax32=127,") __no_step

let __no_step see the rest of R5's state (var_off=...) and fail when a
step is present?  I checked this as well.  The later series commit
c7b36680c7d9 ("selftests/bpf: tests for register base/step state
pruning") only appends to this file and does not change this pattern.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37923187511
--===============3592105562042583579==--
