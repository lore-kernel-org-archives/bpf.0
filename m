Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A563290C9
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789428529; cv=none; b=f7NwvixxZyhepHxQonVMnaNmpy8cjS4CwAP03YiJFl8SjVq4yl+TrtU3AiVxKViqWrZorOr+kX9+2vVK5zQTKMakUNXACN5m+QeEqJsvEZ4yZtyWm/QBDp+X6ksBr0A0hWGOZK9SV9NbAjGl4egM2Nb9WI4JhifkUAIwuTB9Ra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789428529; c=relaxed/simple;
	bh=ONV+s5dItgfFpK/8ND53AXoVa2Hg7ElnFJQEqTKZC6o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ukESVa8ftwipGBb/GVLjAVarLQztYBd65EbcXXwZx0N6vi47gHxk87ZnYQ3sqMZeE2MMdwOKERU4n6DlRQzi5r+4TrzDydOPG8sr2JTR+OwoK5jaXTzQ5KIIaya58wM1DOxEUvYCDuwVPKt4xdFK4KDRm2ythVfVTZ9FDqZloVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8Oe+Dcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8Oe+Dcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 858E91F000FF;
	Mon, 14 Sep 2026 23:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789428528;
	bh=Raeks8FWhKEE+NGNqn0V48A/G4a3UOBhL/Vm/xXEegA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=I8Oe+Dcl1urTSLe2KBF0Ak9BFzNR6s9ndRhLsYtIaY6gfYRg3V6kB+U6TSzkNlLGw
	 KkY5Assr9i7HH0WSXA4tU8U58bPB4dudLVjtYWk/+dUECyFhPoRiIGqgnDSxy3pYJd
	 3dGcnVQRTnnU26Y/7XDvT4Ussscb/ovUVr1tF4ZRWr1JODfwK1OIHuzpp8IxlSyxAz
	 zD9Pb92KaajhvWPALuPXYa0qT6rXC8OdVnYCdib/SLVpUIC4ikFYxi7Ds0TNszX+SC
	 fK0zhNaRaRz8upDIvT9sbfNoW7rWzMFtN4XCbP7u9I0EGZZQ7k5xxy9lO2WUnPJbwg
	 sV7CTA6X4FguA==
Content-Type: multipart/mixed; boundary="===============3689578111613863652=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5d72de95729f0e75fd04152f2256786331697a00f2efb456f26694b9f39171a3@mail.kernel.org>
In-Reply-To: <20260914222514.1635018-7-memxor@gmail.com>
References: <20260914222514.1635018-7-memxor@gmail.com>
Subject: Re: [PATCH bpf v4 06/11] bpf: Restrict CO-RE poisoning to relocatable instructions
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: npc@anthropic.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 14 Sep 2026 23:28:47 +0000 (UTC)

--===============3689578111613863652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Restrict CO-RE poisoning to relocatable instructions
>
> CO-RE relocation records can name any instruction offset. When a
> relocation cannot be resolved, bpf_core_patch_insn() currently poisons its
> target before checking whether that instruction is a valid relocation
> target. Malformed metadata can therefore replace jumps, calls, exits,
> register-source arithmetic, or non-immediate loads instead of failing at
> the relocation step.
>
> Handle poisoning only after the instruction has passed the same class and
> operand-form checks used for a resolved relocation. Route invalid forms
> through the existing diagnostic and return a hard error. Keep poisoning
> supported instructions, including both halves of a plain ldimm64, so an
> unresolved relocation in dead code remains valid.
>
> Move poisoning into a helper that handles both halves of ldimm64, and
> return its status directly from each validated instruction case. This
> avoids routing the success path through a common label and leaves the
> helper free to report errors.
>
> The shared relocation code applies this restriction to both libbpf and
> in-kernel CO-RE.
>
> Fixes: eacaaed784e2 ("libbpf: Implement enum value-based CO-RE relocations")

Does the Fixes: tag point to the commit that introduced the defect the
changelog describes?

The changelog says the bug is that "bpf_core_patch_insn() currently poisons
its target before checking whether that instruction is a valid relocation
target". That structure predates eacaaed784e2. In eacaaed784e2's own parent
tree the pre-switch poison block is already there:

  $ git show eacaaed784e2^:tools/lib/bpf/libbpf.c | sed -n '4986,4989p'
        if (res->poison) {
                bpf_core_poison_insn(prog, relo_idx, insn_idx, insn);
                return 0;
        }
  ...
        switch (class) {

Tracing back, the unconditional "replace insn with invalid call before the
class switch" behaviour was introduced by d7a252708dbc ("libbpf: Improve
handling of failed CO-RE relocations"), which added the `else if
(!targ_spec)` branch that poisons and returns 0 ahead of `switch (class)`.

Then 353c788c2054 ("libbpf: Improve relocation ambiguity detection")
refactored it into `res->poison` + `bpf_core_poison_insn()`, still ahead of
the switch.

eacaaed784e2 only added the *second half* of ldimm64 to the existing poison
block. Poisoning was already reachable for field-based relos before
eacaaed784e2 (bpf_core_calc_field_relo's `if (!spec) return -EUCLEAN`), so
a malformed .BTF.ext record naming a jump/call/exit could already be
poisoned then.

d7a252708dbc appears to be the correct blame target for this patch.
eacaaed784e2 is the right target for the *following* patch in the series
(the one that rejects truncated ldimm64 CO-RE relocations), which does fix
something eacaaed784e2 added.

Because the tag drives stable backport range selection, the wrong tag means
the fix is offered to a narrower set of kernels than are affected.


Also, the third paragraph's "Move poisoning into a helper" is imprecise:
bpf_core_poison_insn() already existed as a helper before this patch. What
actually moves into it is the ldimm64 two-slot handling.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34904671165
--===============3689578111613863652==--
