Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2552C2741A0
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687947; cv=none; b=tfOa9tnKkWwpQvzKz15TewfzznBdOWYD/nCJchBEkF18LXODKDiWofo1EIVF9ZGGKF+HkpeVY7fbZd7+BpW9tLbb9IjycO9SpbmXd0VGlGA8As9D55ytlJkO1Gnbhz8zXrvNqoHJAonvqvR+87GbzUIpffu44xC/g8yZBlm8pNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687947; c=relaxed/simple;
	bh=B1m80NakgDooRdOVj2iksN5oa2GA93wbyiPxhZA1lUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXBz6g5xa4aOJM9jG5dgMePWmHAu1WNjbGFCBEYswf7R5/pV5iIaHp8FpWP2q5+PECEouHG26FsqouVkK1nPOZYBEXW3oTMg7jd2iQaZr56HLR7CIjtLjIeHHXjHwuu/7fXZ4QcgXl1ScTMJaYpZa1x6tTlt0KwUFCaapINQBqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwNJl6en; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwNJl6en"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-486e4e15deaso37758f8f.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687944; x=1790292744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EfXZCDR1Ta6cuzcl9z2wBqdNH2skXg9+3IXfRRFFvO8=;
        b=NwNJl6enXbL5fLRylHFrLqmt5pIznvAF722yBTJm1m1tt7zK8Vr2bPhz8xdxjmf+Z0
         RQKcwiqNQYoljkQ6gbVYEr9Tb3MIw8iutqrpbPxu7YqwsHku6aEKa+ZLn+bBhpvUCK35
         8dQsDhCcUjsaAZrwRM6VwQo435neY/xBvlMymRfRHjDYr9Zs/a1DsIBcjqT2V+RCXSyK
         uzh8FiE1YHE1Cy/gcLxMI2Ru3I0qbLD+zKuaoGK8x90hAdk2FYSEF63Hr1k9AwIt43ap
         gf5ceR+ZE+AVHip7FfJCxOo9CftC4oqiWkyFSDunDi5cxxO4A+gR+dziEEJ16//OGv9f
         slBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687944; x=1790292744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EfXZCDR1Ta6cuzcl9z2wBqdNH2skXg9+3IXfRRFFvO8=;
        b=TFgYO93KefiUkK9AkH6wmusKke70GbnyT5Gk7Txq2Df8WsOK8wwLcTj1foEX09Z87J
         mNUGz8ODKgqrQqwt1n70cjjpsvVrNLuNGuHx8JQRZKGVwqUYsN3AZ18/ZO7kpSc6sPGd
         xRq9dVSKwghs8KGY/a0A5cjaftM/PEbPyz1eYtvCNeHx28g/Z+KLegSJhfvhc6Pe7TxL
         bQueGtO1pflaQq+5KoeNyY3KFeiIG4CqOsmLflUkhnEaGCtHjwKzlGiSh8pDEjRr36lW
         sN0NR76ohzT0jHYf9n3p/XzukXmtO0xepIhvPLsGYkWb+TWKHcJHneLpbrkGvE8aSVmC
         F+lA==
X-Gm-Message-State: AFuF++nnKijbb1PXK0aGb//L1Fbf0FjqbJgaQB884ANNcGpOwdZ7BP8R
	rgINw+/DBRDH5lQkq4JIJbQFUPGqApogGD+3z24k8vkej6RvaI6MUdfvUpK1s6aN
X-Gm-Gg: AYBFou2JGm/JsjPxGNLftlMG5/Y0aaMd5TWStPpCrhg+F0qZA7iogBEcSihkZsrG3B0
	sXr/DqAuEeCP+21PELA6baRpSADbkRMtl5j1DdlVZZO6j8vNjhOnW5WKWsy7KrRTWMwzikEkYg4
	oWPPCAgN0V2K5BNnzBOmurr+mOFlfXkBHb+p+dOATyV+MXp9iunT6qduq5Xm2lX4/M5q3J10COO
	qo03nVJ3ESvFcrF49PcIOVZeACJzRjI3ELkVlH/Ie75r78EJZwOnBwqeYtGnn7XzKzIM8F/9cGV
	E2WQjKFZtFlaw2JkuTZAdo9DiQZYUSxM1pqHtGnhd4KIwczdEDYA7jdkPYjix0q1Z+xijL/U1k+
	hvQ6iazFz7h8mj7v8sJ/y++Bva9cIm5/1OI/dQLsOyK4VGTPXE0Sv3YTvig30AE7+XPoIyqT6U9
	BTGo96k28PPqFrq6wTctgFlIKQwbE1rA/h4fHI+iZbX5laOf3h+36ngtztZyBa/0CR2p303SqGx
	HX+xfxTv9UoAp9McYS9KNVdOcbydOQ/a2NgOHNOIKOLoVZ6HBoIX0YLmsTcP5kyhHlYMgH9eF4+
	H1O7llt/X7XazU8H2QkLhiY2SFSRSILlkiS/PuLQms2URir+
X-Received: by 2002:a05:6000:2f85:b0:487:648:ed8b with SMTP id ffacd0b85a97d-4871e36dcc5mr1108029f8f.23.1789687944151;
        Thu, 17 Sep 2026 16:32:24 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf33e01sm21912735f8f.23.2026.09.17.16.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v7 00/10] Misc bug fixes - part 5
Date: Fri, 18 Sep 2026 01:32:08 +0200
Message-ID: <20260917233222.2542500-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5233; i=memxor@gmail.com; h=from:subject; bh=B1m80NakgDooRdOVj2iksN5oa2GA93wbyiPxhZA1lUo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRbLwnEfF6ZwN8vGyk/Z6eGxWE7Xje7x2mnnA3rue8 dmC6UYdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMh2FUaG5swfxTHWfvrrqydc XWZx2Cg0WXMJx9M/XfcPdwh3djdYMvx3Z5zDfN41t608ePOvfypWLS/KlLmyTMKXuq2I73gX08k MAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas. See commit
logs for details.

Changelog:
----------
v6 -> v7
v6: https://lore.kernel.org/bpf/20260917111127.3780880-1-memxor@gmail.com

 * Correct the trailing ldimm64 rationale and exercise the early guard with
   CO-RE metadata. (BPF CI)
 * Keep the relocation-ordering regression causal after target hardening.
   (BPF CI)
 * Document the raw BTF access-string offset and PTR_TO_INSN map pointer.
   (BPF CI)

v5 -> v6
v5: https://lore.kernel.org/bpf/20260916212102.597335-1-memxor@gmail.com

 * Rebase on bpf/master.

v4 -> v5
v4: https://lore.kernel.org/bpf/20260914222514.1635018-1-memxor@gmail.com

 * Reject a terminal ldimm64 before in-kernel CO-RE relocation and add
   focused verifier coverage. (Eduard)
 * Bound truncated ldimm64 relocations in libbpf's relocation loop and
   retain resolved and unresolved regression coverage. (Eduard, BPF CI)
 * Encode the early CO-RE test BTF with the BTF_* helpers and fold the
   standalone follow-up into its owning patch. (Eduard)
 * Use one fixed instruction stream for CO-RE poison tests without a
   conditional program length. (Eduard)
 * Drop final selftest commit.
 * Trim callback lock identity selftests to the mismatched-value cases.
   (Eduard)

v3 -> v4
v3: https://lore.kernel.org/bpf/20260914131701.2529725-1-memxor@gmail.com

 * Return interrupted main-program JIT compilation through ERR_PTR()
   instead of an output parameter. (Eduard)
 * Apply in-kernel CO-RE relocations before subprogram discovery and
   validation, while keeping func_info and line_info validation after
   layout discovery. (Andrii, Alexei)
 * Keep relocation-target hardening as a separate patch and diagnose
   invalid register-source ALU targets. (Alexei, Eduard, BPF CI)
 * Extract CO-RE poisoning into a returning helper so validated
   instruction cases can propagate its status directly. (Andrii)
 * Restore the existing inner-map UID comment wording. (Eduard)
 * Add bounds checking and selftests for truncated ldimm64 CO-RE
   relocations. (Sashiko)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260905083418.3723623-1-memxor@gmail.com

 * Propagate cancellation from constant blinding through both JIT fallback
   paths instead of rechecking fatal signals in bpf_check(). (Eduard)
 * Preserve packet-pointer displacement by comparing range bases, without
   extending the generic ID map. Veristat showed identical verdicts and
   successful-program instruction/state counts across 2773 loads. (Eduard,
   Alexei)
 * Reduce the packet pruning regression to 20 instructions and force state
   checkpoints. (Alexei, BPF CI)
 * Reject unsupported CO-RE poisoning targets in the shared relocation
   code instead of adding a CFG fall-through check. (Alexei)
 * Cover unsupported poison targets and supported relocations in dead code,
   including both halves of ldimm64.
 * Assign callback value IDs unconditionally and compare inner-map lookup
   IDs through check_ids(); explain the bug with a small program. (Eduard)
 * Move map_uid beside the other IDs and shrink frameno to preserve the
   register state size, keeping the existing memcmp() ranges.
 * Consolidate callback tests into the existing spinlock tests and reuse
   their map fixtures. Retain one-element and nested locking controls, and
   check nonzero IDs in timer, workqueue, and task-work callbacks. Clarify
   the inner-map lookup test description. (BPF CI)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260905070003.3193366-1-memxor@gmail.com

 * Address inner map corner case for callback map value patch.
 * Drop patch 2 since the test can be flaky.

Kumar Kartikeya Dwivedi (10):
  bpf: Make post-verification instruction rewrites killable
  bpf: Preserve packet pointer class displacement in regsafe()
  selftests/bpf: Test packet pointer class displacement pruning
  bpf: Apply CO-RE relocations before subprogram validation
  selftests/bpf: Test early in-kernel CO-RE relocation
  bpf: Restrict CO-RE poisoning to relocatable instructions
  selftests/bpf: Test CO-RE instruction poisoning restrictions
  bpf: Assign lock identity to callback map values
  selftests/bpf: Check callback map value lock identity
  libbpf: Reject truncated ldimm64 CO-RE relocations

 include/linux/bpf_verifier.h                  |  27 +--
 kernel/bpf/check_btf.c                        |  12 +-
 kernel/bpf/core.c                             |  21 +-
 kernel/bpf/fixups.c                           |  24 ++-
 kernel/bpf/states.c                           |   9 +-
 kernel/bpf/verifier.c                         |  25 ++-
 tools/lib/bpf/libbpf.c                        |   7 +
 tools/lib/bpf/relo_core.c                     |  58 +++---
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 192 ++++++++++++++++++
 .../selftests/bpf/prog_tests/spin_lock.c      |   2 +
 .../selftests/bpf/progs/test_spin_lock_fail.c |  67 +++++-
 .../progs/verifier_xdp_direct_packet_access.c |  35 ++++
 13 files changed, 418 insertions(+), 63 deletions(-)


base-commit: 8d9eae69170e6d780da07408fc6471f877cf65e5
-- 
2.53.0

