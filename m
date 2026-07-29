Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5943047F2F7;
	Wed, 29 Jul 2026 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338331; cv=none; b=lWRaVmDx9od0p6iDrwVVgYCVQ+3Grr3nGny7wOskdY0zeXno4kxBe0NLK0FNwW3zvuLeLVeibJDDi7wPQ+5xkSozXaKMl5N1dDyRjXE93z4i4GuoVRQFumdmRaBbNhkkz8dsO49X9Y1F9qaJaJijs8fLnOYp8705P2ESCAjz7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338331; c=relaxed/simple;
	bh=kvzOz+pD3rr/TmfPHw9vR90Y3iMUBOxN+9qGwOovYBY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H7yk5VcLt1JsCi92rrWEDym9u3OZRzXJtAAKAGfNzaNysmqxqXl9xBVfHpIcHNV4BQxY0Rk8Kx6kR0AMOKYpnxRbL9Pvh402IoT5uLhY2tGmdHgtE4FbTZTj85ryT8kQYtMeOfhXwaI3VP7y02Ijzjpqy3urV+khHU5gsPERehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOlKR37J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOlKR37J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50519C2BCB3;
	Wed, 29 Jul 2026 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785338330;
	bh=kvzOz+pD3rr/TmfPHw9vR90Y3iMUBOxN+9qGwOovYBY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LOlKR37JBMYe8uy4Q9QwaHPP0x7I6o2KRXw4aJkGWNowPfEOX7679+pvfdh1VXOH6
	 5K50lYxgTJZKm7tB42oAc9JQHmz1j2BtZLf70MDc4AB/Dff/oKL8HgrqzQvcXn7r7G
	 8EE2Z8Ylm05MVxYKltdkgiEyd6HDUzwvfgcYG/JB8zchwSqaRwB8szwrNIxsJFxEZn
	 0RN3438rnR26jQx6002MpmRTxbjHQACyOkbplbPPR6me2NXGvk6ULqETbENbiAPXnd
	 ti1sjm6iEuonrC2QMPZk07zyHrXBYzAe1Z0BJJ/0lo/bileLR94mhRW2m8cXyPZO2Z
	 L7m83KDvbTdkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C632C53200;
	Wed, 29 Jul 2026 15:18:50 +0000 (UTC)
From: Yiyang Chen via B4 Relay <devnull+chenyy23.mails.tsinghua.edu.cn@kernel.org>
Subject: [PATCH bpf v4 0/4] bpf: Preserve pointer state for commuted
 arithmetic
Date: Wed, 29 Jul 2026 15:18:26 +0000
Message-Id: <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMIZamoC/x2MSQqAMAwAvyI5G4i1rl8RD7amGhAtLYog/t3ic
 WBmHogchCP02QOBL4ly7Al0noFdp31hlDkxKFI1NapDWyKVFfrTbGLReIeXRjKqnTQTF+wgpT6
 wk/vfDpAcGN/3A0Corz5rAAAA
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Wade <danjwade95@gmail.com>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785338329; l=3434;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=kvzOz+pD3rr/TmfPHw9vR90Y3iMUBOxN+9qGwOovYBY=;
 b=jFMjmF8sYmrK3IVJNkS9/UMTjigMq1lhiAAkr9vrzQfjS7R8a0A+NQ+uaxo9GtAE4tnJ4ka6s
 8w/BTSllS8nBaO4E2pOmr1RItt9fdlU7wrvIWtKPO+joSs4gcRC7or3
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-Endpoint-Received: by B4 Relay for chenyy23@mails.tsinghua.edu.cn/kernel
 with auth_id=900
X-Original-From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Reply-To: chenyy23@mails.tsinghua.edu.cn

This series fixes pointer-state propagation for commuted scalar += pointer
arithmetic in the verifier.

Patch 1 simplifies sanitize_err() before the pointer-state change. Patch 2
keeps the full pointer register state when the pointer operand is the source
of the add, preserving fields such as the stack frame number and parent id.
Patch 3 moves the untrusted PTR_TO_MEM early return after state propagation,
so scalar += untrusted_pointer remains usable through the probe-read path.
Patch 4 adds verifier selftests for stack frame number preservation,
readonly-untrusted memory access, and dynptr data-slice invalidation.

Changes in v4:
- Target the bpf fixes tree because the affected behavior is present in
  released kernels.
- Add Eduard's sanitize_err() cleanup and revised pointer-state patch, reusing
  the caller's temporary offset register instead of verifier-env scratch
  storage.
- Correct the stack-frame Fixes tag to the BPF-to-BPF call verification
  commit identified by Shung-Hsi.
- Fix the dynptr test comment style and retain the source-register clear so
  the test isolates parent-id propagation.
- Carry Daniel Wade's Tested-by and Eduard's selftest Acked-by from the v3
  thread.
- Rebase to bpf base 0ce37745d4bf.

Changes in v3:
- Preserve the complete pointer register state with verifier-env scratch
  storage, addressing Eduard's comment that copying selected fields is
  fragile and avoiding a temporary bpf_reg_state on the verifier stack.
- Keep the existing RUN(verifier_basic_stack) dispatch unchanged and add the
  stack regression directly to the existing verifier_basic_stack program.
- Keep the original operand direction inside adjust_ptr_min_max_vals() by
  saving the scalar operand in env->fake_reg[0].
- Move untrusted PTR_TO_MEM handling after the unified pointer-state copy so
  the commuted form remains PTR_TO_MEM before the early return.
- Add readonly-untrusted and dynptr selftest coverage, responding to the
  bpf-ci/static review finding that the untrusted pointer case needs a
  regression test.
- Clear the original dynptr data-slice register after deriving the commuted
  alias so the regression test isolates parent-id propagation.
- Make the readonly-untrusted return value endian-neutral by loading an int.
- Rebase to bpf-next base a23a71823352.

v3: https://lore.kernel.org/bpf/cover.1784696371.git.chenyy23@mails.tsinghua.edu.cn/
v2: https://lore.kernel.org/bpf/cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn/
v1: https://lore.kernel.org/bpf/cover.1784563939.git.chenyy23@mails.tsinghua.edu.cn/

---
Eduard Zingerman (1):
      bpf: simplify sanitize_err() signature

Yiyang Chen (3):
      bpf: Preserve pointer state for commuted arithmetic
      bpf: Propagate untrusted pointer state in commuted arithmetic
      selftests/bpf: Cover commuted pointer state propagation

 kernel/bpf/verifier.c                              | 45 +++++++++++-----------
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 30 +++++++++++++++
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     | 17 ++++++++
 .../selftests/bpf/progs/verifier_basic_stack.c     | 41 ++++++++++++++++++++
 4 files changed, 110 insertions(+), 23 deletions(-)
---
base-commit: 0ce37745d4bfbc493f718169c3974898ffec8ee7
change-id: 20260729-c3-035-public-bpf-v4-0b28a4e0e1ef

Best regards,
-- 
Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>


