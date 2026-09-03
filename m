Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED194B7154;
	Thu,  3 Sep 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445818; cv=none; b=IpoN+kC8SjlbpznCoYZMndL15tAICQVg1Ahxq6EFkiQ9LjWsNYvS/ZPaarj3Mb0gu+9yUIkKbgCUYei+4OZUXZ7CaWYYo+d8xdzXEw39tMA+OUgRZBGP81Mykypt5VTlNFaeghndvblwDaceNV4jS87zcVwQI+UuaZpH1LGhTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445818; c=relaxed/simple;
	bh=Ck4xh9AUbEc9i2r6xDGoD70h7Q+c1zZ/SIcb51ERnOA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CJegsL+cSyTNtdW/ifrIkkPWogRrpN+MRfMkcpkqlUGj7tU3Vlf3PlScUU8KI3zQ2CnIwConbnqN2yCGLRkDVtT+nuCSc2/bDk32ZlvUW6895ygVwpL4G1rQ6OgvEnY+hHiO9vRdZxWLJkL/2/Da221LeH2bMLQaepSjUzf9OSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=di0le+H1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="di0le+H1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50021F00ACA;
	Thu,  3 Sep 2026 14:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788445808;
	bh=707+tY5qzyxFaMkKRrNsjyywFZu1fFG9+Ds/zEPgCo8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=di0le+H11q9aiATgQTs+dJpEk7U8OOqYBo5/sIuK3UsWWotfgZaovraYdRSBbibuR
	 2maOkPZoXLd44Qi6YdN5mScwBPckFmReMAjgvllvDKUb3QulrKnk7eC107RbLIQogG
	 Z21iez0teogMliBiPxkUA+2wqWoq9ZfrcUSHMbpM7JDJw3vxo9GUpivwhq+vFOjSUT
	 cfX0l5h34l4d9zK5yEosfLmcKHhTQU95EDmsbqAF7BA8RLRozsFRyLXCE+C9XfcnEm
	 ecO3OF7AhKiPfloo4gi43OQA+OdLXnxOY3TlpM7KBgIMwifPwUOXpZeT2gzBALkmiN
	 erxaLR7tBnzuQ==
Content-Type: multipart/mixed; boundary="===============1914617035758815366=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <21a37dd7ec1500e6e9533607a0f44a9a1f9714658916e0ec415eb32153b2a1ed@mail.kernel.org>
In-Reply-To: <20260903133434.17860-1-utkuerol71@gmail.com>
References: <20260903133434.17860-1-utkuerol71@gmail.com>
Subject: Re: [PATCH] bpf: disasm: guard print_bpf_insn against BPF_MEMSX | BPF_DW
From: bot+bpf-ci@kernel.org
To: utkuerol71@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,qmo@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,utkuerol71@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  3 Sep 2026 14:30:07 +0000 (UTC)

--===============1914617035758815366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> print_bpf_insn() renders a BPF_LDX by indexing one of two size tables with
> BPF_SIZE(insn->code) >> 3. For BPF_MEMSX it uses bpf_ldsx_string[], which
> has only three entries (W/H/B) because a sign-extended doubleword load is
> not a valid instruction. The LDX branch checks only that the mode is
> BPF_MEM or BPF_MEMSX; it never rejects BPF_MEMSX | BPF_DW. For that opcode
> BPF_SIZE(code) >> 3 == BPF_DW >> 3 == 3, one element past the end of the
> 3-entry array:
>
>   UBSAN: array-index-out-of-bounds: index 3 out of range for 'char *[3]'
>   KASAN: global-out-of-bounds: 8-byte read in print_bpf_insn
>
> The out-of-bounds slot is then dereferenced as %s.
>
> The disassembler is expected to run on unvalidated instructions. Since
> commit b9c5d822f677 ("bpf: Add source and instruction diagnostic context")
> the diagnostics facility disassembles instruction context from
> check_subprogs(), before check_insn_fields() has rejected the opcode, so a
> raw BPF_MEMSX | BPF_DW insn reaches print_bpf_insn on the ordinary
> bpf_prog_load() path whenever a verifier log is requested (log_level >= 1).

Does check_insn_fields() actually reject this opcode? Looking at the
BPF_LDX case in check_insn_fields():

  case BPF_LDX:
          if ((BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) ||
              insn->imm != 0) {
                  verbose(env, "BPF_LDX uses reserved fields\n");
                  return -EINVAL;
          }
          return 0;

BPF_MEMSX passes that test regardless of size, so check_insn_fields()
returns 0 for BPF_LDX | BPF_MEMSX | BPF_DW.

What actually rejects this opcode is the bpf_opcode_in_insntable() call
immediately above check_insn_fields() in check_and_resolve_insns()
(kernel/bpf/verifier.c), which fails because kernel/bpf/core.c registers
only INSN_3(LDX, MEMSX, B/H/W) in public_insntable[].

The reachability conclusion is unaffected since both checks happen in
check_and_resolve_insns(), which bpf_check() calls after check_subprogs().
Could the commit message cite bpf_opcode_in_insntable() instead to help
readers find the actual rejection site?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33762867197
--===============1914617035758815366==--
