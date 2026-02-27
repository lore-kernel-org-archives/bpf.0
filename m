Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7A13B5AE
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772227860; cv=none; b=O3V3DWWOIc5KPaDxjkksAmPSkVqatu3MeY7hDuzzEdREv7Cjxu5FuLS15ABpjJ6BNr6rx+neY5U2hV0iFTzzPkrYB86ZWN/qi0rmSMOVPq9SSsOgZ9Sw2A32SvGDNrs/+Ji5UDJFiDFtetoJLlr9DBbQg0y0TDEEsFIHvrNEbnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772227860; c=relaxed/simple;
	bh=f91yvuemOeKtKN+Kf39B7FUvslF/SFEHi2hFFh9NgiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SkjbACX8ZDrqZtzDLGnuUUY3IAGI1kSRA6u2WHGYBX3fsrWL5ECJ0pxPlZCdlhcXdlNsn1HMMUrvyyk6mNPXfBidtQG+vMTYAy59T8+7idG7UdMRFnLlMQ8E8Bqh9rbE9iPwC0/CqkUlOS+bWlWHJpo1rPHuYxPmgv05khi0NCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlnYqFrB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlnYqFrB"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4398913af88so2204772f8f.2
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 13:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772227857; x=1772832657; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+5TYiCLG1VHjqvVT9Hz69k3NxqOZHubpGSkzGnzTss=;
        b=DlnYqFrBFFInf1joW5U71lLMVAhaEjfws8ZpqnPenyflRUIJIQDGgBLi3WT67sfJdz
         KQ8eAab9vqLj7O2UzSYHwvqEsTeWFp0nrwuCOLlEd5i7LQHCHd57FVApbbHqm6PD3Dwe
         0cyjY0PEJnr70TFBcYAXh/MLWhtwHkGhh5FwoicqYmF8rVX24wDOBxsWPV6EyrtjGcKr
         mlMouTeMNgRI3eZ/SiioiDXPadt0bxbiqi85hhXp+V0iwMDAqoskbRC2+1kNOjT7Q8rx
         lNfZ59snsAmYDM3arQrrz8OaDSuTLKbLDbKCnQnV4R9X/p2EJfSXR4lWcG2F1YG+8Aym
         flDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772227857; x=1772832657;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+5TYiCLG1VHjqvVT9Hz69k3NxqOZHubpGSkzGnzTss=;
        b=VgiHzNGaUUHjEfZCJKD+4FWExJLrW9R+J/iYLMz5WF9NeAnufmtZDmntc7oFtaQXOc
         wuVxwwwWh9cDJHsrtNO4YU8XnZVpHTcHawn66hBnO57aCEsXkrQkbPehRZBG4U9/222v
         O9uBG3umfkkPmcbhapmJb+TcX1CIguXzyzDoKsIBHnFl0Ni3KZFnMip1Qi+wAjOSSNJe
         NxsRmoehUUA6M8DvFvOJx0X5EAqXuN8EEqec0m+qEhkTaefptYTSeZ6DSCZhDoKgUIHi
         2QdoVCQ0UHkAlXmcTffyBgMigqA9zFOW3CYaSGxlwCU54wy/PxBGIlBLILN2dfxMVLrI
         sI2w==
X-Gm-Message-State: AOJu0YxkGJvIwuA8sp4SOT7bt8ouIHE3TrmAympXQ8GVayR8l2v/8oKe
	HUudRL3T8JK1kse+cfrdB/yBESX9jgv6Zvh3fa77XAbfP2uCUXIrhMtjmeTDQotb/3c=
X-Gm-Gg: ATEYQzxtxASpmnbfQrEDjMhl4KrlNUedpUNtc34CgC6Bd6lJ5ZECjJt4yHaKWVn6jL1
	/N/l2MGHCRG5pQC0o2Df4NQdPfUNz7OLqJ10bU21FUGkLKz+KXac1jhms23oSrzu3EBBBtbO4gR
	vn0kHgSfeqh2bvXr4YruzETB8UxImkhuH698faKSDHL8uKLuYpWiK+EaVGJRC/RAr38+Idg672A
	P1kZG6ZUyHBSZyNTiIlraHBb2JI7Ye+3flBWOlNe6XGhWhwceWRjU3/ye9xw0ZDPuTbfF3xE46e
	afn7E6Pfcv2IVh4iBv/9II7oPAywHtH576QjmFUlBNnli0lB3AuZx6j3qWqgRKXsHWgP1Nw/aQg
	Qg9N/G7H9K8ZlkxvKehCLzyqg6rY6Iml/+mJLhjKDp6IujjtULMjCK58AjMb9p7vtqfewAVX9s1
	6uv6p6DEGlxvOC6Py29XZ44K4u16kNrob3uhqU9K2wLj46aizJ3M9m+gXi3+EoeLblTHv46gWxK
	Kd3XlkpeDAZ7gz6a52/R+nAONahXaWW5pOxmmxCwSz/KzQzsoCZbEKlDMrhO8gvaxHDmrq+sfCQ
X-Received: by 2002:a5d:584d:0:b0:439:94ac:c43a with SMTP id ffacd0b85a97d-4399dddba02mr7277748f8f.2.1772227857281;
        Fri, 27 Feb 2026 13:30:57 -0800 (PST)
Received: from Tunnel (2a01cb06901b353b20ebf6654db8a566.ipv6.abo.wanadoo.fr. [2a01:cb06:901b:353b:20eb:f665:4db8:a566])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75b8afsm10121296f8f.23.2026.02.27.13.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 13:30:56 -0800 (PST)
Date: Fri, 27 Feb 2026 22:30:53 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH v3 bpf 0/4] Fix invariant violation for single-value tnums
Message-ID: <cover.1772225741.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

We're hitting an invariant violation in Cilium that sometimes leads to
BPF programs being rejected and Cilium failing to start [1]. As far as
I know this is the first case of invariant violation found in a real
program (i.e., not by a fuzzer). The following extract from verifier
logs shows what's happening:

  from 201 to 236: R1=0 R6=ctx() R7=1 R9=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100)) R10=fp0
  236: R1=0 R6=ctx() R7=1 R9=scalar(smin=umin=smin32=umin32=3584,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100)) R10=fp0
  ; if (magic == MARK_MAGIC_HOST || magic == MARK_MAGIC_OVERLAY || magic == MARK_MAGIC_ENCRYPT) @ bpf_host.c:1337
  236: (16) if w9 == 0xe00 goto pc+45   ; R9=scalar(smin=umin=smin32=umin32=3585,smax=umax=smax32=umax32=3840,var_off=(0xe00; 0x100))
  237: (16) if w9 == 0xf00 goto pc+1
  verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0xe01, 0xe00] s64=[0xe01, 0xe00] u32=[0xe01, 0xe00] s32=[0xe01, 0xe00] var_off=(0xe00, 0x0)

More details are given in the second patch, but in short, the verifier
should be able to detect that the false branch of instruction 237 is
never true. After instruction 236, the u64 range and the tnum overlap
in a single value, 0xf00.

The long-term solution to invariant violation is likely to rely on the
refinement + invariant violation check to detect dead branches, as
started by Eduard. To fix the current issue, we need something with
less refactoring that we can backport to affected kernels.

The solution implemented in the second patch is to improve the bounds
refinement to avoid this case. It relies on a new tnum helper,
tnum_step, first sent as an RFC in [2]. The last two patches extend and
update the selftests.

Link: https://github.com/cilium/cilium/issues/44216 [1]
Link: https://lore.kernel.org/bpf/20251107192328.2190680-2-harishankar.vishwanathan@gmail.com/ [2]

Changes in v3:
  - Fix commit description error spotted by AI bot.
  - Simplify constants in first two tests (Eduard).
  - Rework comment on third test (Eduard).
  - Add two new negative test cases (Eduard).
  - Rebased.
Changes in v2:
  - Add guard suggested by Hari in tnum_step, to avoid undefined
    behavior spotted by AI code review.
  - Add explanation diagrams in code as suggested by Eduard.
  - Rework conditions for readability as suggested by Eduard.
  - Updated reference to SMT formula.
  - Rebased.

Harishankar Vishwanathan (1):
  bpf: Introduce tnum_step to step through tnum's members

Paul Chaignon (3):
  bpf: Improve bounds when tnum has a single possible value
  selftests/bpf: Test refinement of single-value tnum
  selftests/bpf: Avoid simplification of crafted bounds test

 include/linux/tnum.h                          |   3 +
 kernel/bpf/tnum.c                             |  56 +++++++
 kernel/bpf/verifier.c                         |  30 ++++
 .../selftests/bpf/prog_tests/reg_bounds.c     |   2 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 137 ++++++++++++++++++
 5 files changed, 227 insertions(+), 1 deletion(-)

-- 
2.43.0

