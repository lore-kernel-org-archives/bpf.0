Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646244;
	b=d+WDIRUcHvDowSMMvWUwgsjoxdFuSq7UziCugu7ygY8qP6zhAi47n4FRpT5KFUaHDqf6
	 91gJjol8D69VSBT6+c4ryaOVSCX98qOGq3cZhgKc+dNMqBl5U2p2x2X7eGDxo+CRZaUSz
	 Y2Qe9qBTPE9YObUhTyrqYGJD27vW6uEpk7/XNnrhtvFqykMkxCS3P5RVDn21kO7LfVIsF
	 cnboQ0nR5hE7gyVZ22EXHAF5ZARWizSyT5P52HtrvzAHlCnYaEFtBoz3NYk/azMfun5ki
	 EY+5j5E4MfUz2pNh2vzgEfGDk7rC+P+Kde8m9v8KEAKcjkgfawtb5iwJfi+9LgvUOAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646244;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=JHptizFxoa6u8AVcaBQ6Vo5m007YfkupU48z11B9r+4=;
	b=18ywqKYLWcPZ6DguJXJBj0RfR2XnmsU8oPScWW2WsXIwYAZOAoOnBSmETODICPAdjGXe
	 r0fplHOYNpDiEcl1FTq7q1g5lr+OBxudbYTt4Gtpc+7KC6PylRvob8NAlqZh2hxDrKCkd
	 XSAgo+YOw3V3T0wC2GJN/0Z5XEdLCwf4/BSqf2+b/oYva+5bl03Y4cgNHHyzhoiibLyBz
	 VbUFZqvhuzYidl8Qx4p1xnP2txzpczJBfJX9ZNfDJd6QxPhP8zCaAb04IHa96ghH9v3zj
	 ff5gAsOdML8Yl/XLUpGlLMk7dFOiwCPafFqrNkFQa3ODHQK4Sf+qLO+zs0UD0277Xog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=UDx2XaPU;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C83606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 19:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6C83606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=UDx2XaPU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=JHptizFxoa
	6u8AVcaBQ6Vo5m007YfkupU48z11B9r+4=; b=UDx2XaPUiJmD1D0iz0xbwavNuu
	6mYpjhOU+QoAN1FXgOCuUwls4/pVG8evlpJNtfsPaOVkXDJCvqzvKMmOzoZXDu2s
	Fipwcq1h0c+1Az8IIHri8imfyc9H3CZ5vcb+sYoS24NdwIw+rE2WoGYrX9/uzA81
	gwAHaXKllES5eSkqg=
Received: from localhost (unknown [222.195.81.114])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBn6z+Z3uhqRsx4AA--.1463S2;
	Tue, 03 Nov 2026 03:03:53 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: Fix stack argument precision propagation
Date: Tue,  3 Nov 2026 03:03:48 +0800
Message-ID: <20261102190350.788433-1-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:3pYKCgBn6z+Z3uhqRsx4AA--.1463S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW8uw18uryrWryUAFyDAwb_yoW5WF1Dpa
	ykW3Wag3WkZ3Z7CanxZ3W8WFy3W3Z5Ar4UW3WfJa48ZF1Utr18trWYgF1avFsxAr1Dt34Y
	qr4YqwnrGa1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6rWl42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
	4UYxBIdaVFxhVjvjDU0xZFpf9x07b7oGdUUUUU=
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Outgoing stack arguments retain scalar state separately from registers
and ordinary spills. Their precision dependencies must reach ancestor
states when verification reuses a state or falls back to marking all
scalars precise. Otherwise, an out-of-bounds map access can reuse a state
validated for an in-bounds argument.

Patch 1 covers outgoing scalar argument slots in both precision paths.
Patch 2 adds two load-only asm regressions in verifier_stack_arg.c, based
on Alexei's examples.

Changes in v2:
- Keep the patch 1 fix and explanation unchanged; rebase onto bpf/master
  at 03b013897454064e0a2d84a8ba9a24753eb02f2b.
- Replace the standalone instruction/BTF test builder with two asm tests
  in the existing verifier_stack_arg.c, as requested by Alexei.
- Reuse that file's compiler capability and architecture guards, which
  already cover x86-64, arm64 and RV64. Drop the separate host-side guard.
- Rewrite patch 2's explanation for the two replacement tests.

v1:
https://lore.kernel.org/bpf/20261027061303.1754535-1-xyx2021@mail.ustc.edu.cn/
Review:
https://lore.kernel.org/bpf/DMJI3GWXQOC9.UA3K9X139AR@gmail.com/

Validation on x86-64 with Clang 23.1.4, JIT enabled and panic_on_warn=1:
- Built all four kernel variants and their BPF test modules, plus the
  complete test_progs runner with BPF_STRICT_BUILD=1.
- The two new tests distinguish the two precision paths:

                         State reuse       Fallback
  Unmodified baseline    wrongly accepts   wrongly accepts
  Propagation fix only   rejects           wrongly accepts
  Fallback fix only      wrongly accepts   rejects
  Complete fix           rejects           rejects

  Rejections report the intended map-value bounds violation. The two
  corresponding in-bounds controls load successfully on all four kernels.
  These programs are never attached or executed.
- All 274 subtests passed, with no skips, across verifier_precision,
  verifier_spill_fill, verifier_subprog_precision, verifier_scalar_ids,
  stack_arg_precision, verifier_stack_arg, verifier_stack_arg_order and
  iters on the complete candidate. No kernel WARN/Oops or panic occurred.
- Compiled the test object under x86-64, arm64 and RV64 guard definitions;
  Clang 20 correctly selects the existing unsupported-compiler dummy.
  Runtime testing was x86-64 only, and the unfiltered suite was not run.

Codex assisted with implementation, test integration, commit messages
and validation. The v2 test code was supplied by Alexei and is used
unchanged.

Xu Yunxiang (2):
  bpf: Propagate scalar precision through stack arguments
  selftests/bpf: Exercise stack argument precision on state reuse

 kernel/bpf/backtrack.c                             |  11 ++
 kernel/bpf/states.c                                |  14 +++
 .../selftests/bpf/progs/verifier_stack_arg.c       | 115 +++++++++++++++++++++
 3 files changed, 140 insertions(+)

