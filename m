Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD235A3A4
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784794597; cv=pass; b=GvxWUZXqKVEj9WncZ8U+VydN2eJG87w4PxHjaMiWujqm2iQlN1uiFRBcOvvlWWdTc/dUhg7GAeQTOMNgNwysMnER1zYG2+dBk9L5rtmElQzbup1JEZ2l3+NarTOM/k8cTDXbQevpkiYCYBRJq3ja2IBv/w/hMPoI3gCepWq/oIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784794597; c=relaxed/simple;
	bh=VT4MWQfU9hCucpc7cWdAlF6H9kZnwG+Gwdmmhdc0Ick=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aKWjJxY/UktdTs99mEgqmeXCVO+T3pCE/PbjOMEzFy1Gh+VL1vAMgtjMKCOam+8Ds/8VgOmB/awhLOhdINAVHR0VYGCApnl6A69MSpLYW0e1oV3TC+7KFityB7SDMtnBEZYeZ7jJOxtlBvY5UtKOITto2ajr88oENv+5D530NYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hudrlQZc; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hudrlQZc"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c96c92c0980so238801a12.3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 01:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784794595; cv=none;
        d=google.com; s=arc-20260327;
        b=Io8crslQDT1vFS+am15Xbf2aOvJHqAfqbYo1jgFLaX6YVdq/zJ16E26WX83qE4TxzX
         y7NbiYdkfx7QBmEZNpigHJ8T4MYlmGThJIX8xZ3LUEgvC3C7IQy5FdOnhRg3gJu1+caP
         CtbXFBpw2K+MRs6SUYTDWxeNobTN008ccditkJzoTYiMV+HCjVMfG1eeaKvuCOLPtkVH
         GpeKc/fneWZyA7Q4rMUhVGJFwhAi6DLFP0+LnKgBo0xapsjwoD74xefvDTUqwM/08k4P
         K8QADB2JbFuS+vfjUhsTEGnplSUBRQjEl/z9VUqqb/hmbBYWx5jtN2mn5ZrQzs+02Frl
         TM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Wo+Vi5K3kSEn+1EpaozgmT/8tPtVROlmrkhTXMeQFAc=;
        fh=FvvwLgNwH6WGctV4aEW9+jHkD9eDh5mxk5eg77XxO8M=;
        b=MbzN+AHwyd1kDJSKwVWopWz3Nu4oaOGsQ2Lx1PL2bHAqarXygqpINw/+B+LT1/WkEh
         jhy/kyR0fYBWM57/MD1TZVpMeTUQQpUz7v24zURPl6j12bBMpc741s4njeUPZJYyfl4K
         iS4VPWuEH9I3XtOq1Yp2+g5tK7SfyJKS2Ee3rgMaTmi86WU9V3CkP0+XwlVto1DkihFf
         b7vvSbeopNf6w9GIurekYYfQua8/VulOoJ0LfQWrjTJ9g5GGi9Lrvpjvx/GgwrSGV/Zr
         Vh4VzYar98WJGRe246RojmPWP0081Gf+frpVPizhkHpoHCtOeTv8z39w71mZzqtKRffr
         QgXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784794595; x=1785399395; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wo+Vi5K3kSEn+1EpaozgmT/8tPtVROlmrkhTXMeQFAc=;
        b=hudrlQZcCfRhc5K4qAFHCbIVX7cW5ty3gcBIAsEBvX7xZW9m1rYktX3y9d5B/gJpPA
         f1ylWa4AZP9KS9fxgHoLuYqWD7SUaUMhPywCieWIQgCqFcM1sh36MQnMIh+aHNx20HgI
         IsAWksYkAaPqykD065zA+yweUQi2MboCUi65DOm+Alf8x7V+RZOZAWCGKShM40Q7QZGh
         yzlqeagc6o2aUZxb8YGhoDJ+t4AkNZ/phjcQOfRVyQwy8HsF3oALRwPgmyYVPqPhtuUJ
         kRJifVVw9v136OiwbMPNLdxQAcx5/5CNmriTNTa5eaG0/FnCj2KYnfRJ3HD/CJZKP96P
         rMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784794595; x=1785399395;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wo+Vi5K3kSEn+1EpaozgmT/8tPtVROlmrkhTXMeQFAc=;
        b=gEOBZjYy0GMC2KSpCkqsaNx1dFQsZsFmkG2IdcumSKV+onuoqI/rOL24jpwDfuujye
         /TGlhkGR2Hr3bKFfzjWhv7OZ1/ORNHfr3jRRB9i0rT0yzZGb3WzmIDCvCchX65h/9Ri6
         iTR6VRmcVtHJjpuImHzh6mjmEm0WdKYv+f7zpv/T1WpeuhPh57W2d7LHjWl69eMt7HRP
         +m0hg6N7kU8CZgfkAAS+yGIOZr49sDgbCNPUQi0dKiar7AzvrzrAC40aPcXzGRvFobnj
         vDmzwTeDpfDxJEHPF9plWVL2lRL0Lxt1mNPTNFL/3YIHXnx9mmkwC6ilVYNjYuyaVFAs
         tARw==
X-Gm-Message-State: AOJu0Yzq4J/9i9QPnZoXLzx/QbznvZ3M2UxzRftZwYA2JCJF5UDziin3
	6MmhQiZ6oJauusJvIc1em3jW89xkR+NKx6bFEwddHom4o5i/as4TpTFxuyNsBW3wJ4bTfTk6erc
	yWQIIFYjHNx/auusGEDO7mnDv7v25ZMo=
X-Gm-Gg: AR+sD10gxRZpGufM6P4QPer1LK+tpZunuW6XH0NO5y4TRH16Rj7OCrsLzjWoHwNh37m
	1FDPDKHI7sRE0+H/TWk55/D/z4X8mXXP34O6Qc9fKhNLrrL56SYPfYVu4r6lnnyXuaAH2h2wvr4
	nNdvFqPaU7YCDAbZN81SsVLQM84ZwzfjRhZuWfA/x/wlUXj+seVwhDsd+n86Rytvkt992pjNT45
	1zRG41DM1cCQ8LOcNueaApi0nDfyYw9XmMC9ntGCUzZyZbX7wD73nsnvjfrlWkX
X-Received: by 2002:a05:6a21:608a:b0:3bf:9b61:f7ae with SMTP id
 adf61e73a8af0-3c44afcf8a6mr2128914637.14.1784794595473; Thu, 23 Jul 2026
 01:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Min-gyu Kim <gimm78064@gmail.com>
Date: Thu, 23 Jul 2026 17:16:23 +0900
X-Gm-Features: AUfX_myL9bF7X6cpM8-4rFrG6l6JryBzW6Ow15hH2749EXFeM9RDeP9w91553Hg
Message-ID: <CAGKGUv=sOuqQtA1Ub-5JXfA4FPosJFYKAQE4B79cK+P1erxqtg@mail.gmail.com>
Subject: [RESEND][REGRESSION][SECURITY] bpf, s390: verifier/JIT mismatch
 allows unprivileged kernel memory access
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a potential security regression involving eBPF verifier state
pruning and the s390x JIT. I reproduced arbitrary kernel read and write access
and local privilege escalation as an unprivileged user.

AI assistance was used during discovery and analysis. In accordance with the
kernel security-bug reporting guidance, I am not requesting an embargo. The
reproducer and exploit are not attached or published; I can provide them
privately to maintainers on request.

Summary and affected versions

A verifier regression can cause the verifier and the s390x JIT to disagree
about the upper 32 bits of scalar registers. A crafted socket-filter program
can consequently form an unchecked 64-bit offset from an ARRAY map-value
pointer and access attacker-selected kernel addresses.

The regression was introduced by:

  107e169799057bc6a379ddb625cbe1e51cfc7d72
  ("bpf: disable and remove registers chain based liveness")

The commit first appears in v6.18-rc1 and is not present in v6.17. The cause
was still present in the v6.18, v6.19, v7.0, and v7.1 stable branches and in
v7.2-rc4, bpf, and bpf-next when checked by source comparison on 2026-07-22.
I also confirmed the relevant logic in mainline commit
4539944e515183668109bdf4d0c3d7d228383d88 on 2026-07-23. Dynamic
reproduction was performed on v6.18.38.

Affected code:

  kernel/bpf/verifier.c
  kernel/bpf/states.c in current development trees
  arch/s390/net/bpf_jit_comp.c

Required conditions:

  Architecture:                        64-bit s390x
  Program type:                        BPF_PROG_TYPE_SOCKET_FILTER
  Map type:                            BPF_MAP_TYPE_ARRAY
  CONFIG_BPF_SYSCALL:                  enabled
  BPF JIT:                             enabled and active
  kernel.unprivileged_bpf_disabled:    0
  Required capabilities:               none
  User namespace:                      not required

Root cause

The verifier records an ALU32 definition in subreg_def. A later 64-bit read
causes mark_insn_zext() to mark that instruction for explicit zero extension.
Before 107e16979905, a cache hit in is_state_visited() propagated the 64-bit
read to the alternate path's ALU32 definition.

Commit 107e16979905 removed that propagation when register-chain liveness was
replaced with static liveness. The static live-register mask does not track
read width or path-specific subreg_def information. In current states.c,
regs_exact() compares only fields before id, while subreg_def follows id in
struct bpf_reg_state. The SCALAR_VALUE case in regsafe() also does not compare
subreg_def. States with equal tracked scalar values but different ALU32
definitions can therefore compare as equal, leaving the pruned path's ALU32
instruction without a zero-extension mark.

On s390, ALU32 ADD updates the low 32 bits while preserving the register's
high half. EMIT_ZERO() emits llgfr only when the program-wide verifier_zext
flag is clear. If another ALU32 definition is marked, verifier_zext is set and
the JIT relies on each instruction's zext_dst flag. The pruned instruction
lacks that flag and can execute with attacker-controlled high bits intact.

Reproduction and impact

I ran the test as uid 1000 with all capability sets empty:

  Linux syzkaller 6.18.38 s390x
  kernel.unprivileged_bpf_disabled = 0
  net.core.bpf_jit_enable = 1

The exploit disclosed array_map_ops through the existing map->ops pointer,
derived the KASLR slide, and obtained arbitrary kernel read and write
primitives. It used those primitives to locate and modify the calling
process's credentials. map->ops was read only and was not overwritten.

The resulting shell reported:

  uid=0(root) gid=0(root) groups=0(root),27(sudo),100(users),1000(poc)
  context=system_u:system_r:kernel_t:s0

A standalone C reproducer and exploit, verifier log, kernel configuration,
and build details are available privately on request.

Mitigation and fix direction

Setting kernel.unprivileged_bpf_disabled to a non-zero value prevents this
attack by unprivileged users. Disabling the s390 BPF JIT also prevents the
demonstrated mismatch.

I have not yet tested a patch. A conservative verifier fix may be to avoid
pruning live scalar states whose relevant subreg_def values differ, or to
preserve the read-width information needed to mark the current path's ALU32
instruction. As defense in depth, the s390 JIT could avoid relying only on
the program-wide verifier_zext flag. I can prepare a regression test and test
proposed changes in the s390x QEMU environment used for reproduction.

References

  Regression-introducing commit:
  https://github.com/torvalds/linux/commit/107e169799057bc6a379ddb625cbe1e51cfc7d72

  Public review discussion related to read width and zero extension:
  https://www.spinics.net/lists/bpf/msg139280.html

  Merged patch discussion:
  https://www.spinics.net/lists/bpf/msg152234.html

If appropriate, I would appreciate a Reported-by tag as:

  Min-gyu Kim <gimm78064@gmail.com>

Please let me know if you need additional information or would like the
private reproducer and exploit.

Thank you for your time.

Best regards,
Min-gyu Kim
