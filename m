Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148293;
	b=j/PTAieTah02iW18OmeKsi+5IMo7l9f4Xn4soXEdC9Rw/iHLzlTABXftQ19wA3AMH7xN
	 2xKTy2v2kxo1fbezNawHZPG4mxf84uqtaG21lkS9t42V2V2Zz6aJdYpyLr2GMpq7RNPIN
	 ddpYbzWseRuP4QEQath6Avu8wKbnPZCDYmiF3ONXAZ+6Jo8S/cXFwslMKXZ2SQxa13Bij
	 inTsCkmNYuP3uwdhedM9KvJO6kOkKHRchCgtXkPvQZOvsudmG/dSvqbWi946cOriCUfEO
	 3mKBN7c0ZZhP22sXOdkfmqok42dqjqqCBc2+Aph8MEIcnt+mbI84c5Qe3yfwaEBFN/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=8I3jgHK+6BtC3JOzf+0Q54xIg3MFuJSHblQVFWPMIuU=;
	b=v0+1yk8FSDc20PAFtC6UBp7N4gpha20Wl74mi8kaj0CTBMBBownYngpZXbdGKxdQ2+KT
	 oC3KsU2zww45Z5OEY+pRl9FF4SrLjtL0SVluhLVru11KbhNPYW/NERIRFxMlFCtQE1F6t
	 DawoKR99A42vS6Xjk8/YLNrjlA59cOgwaVJPFlyws28/jGe9EPnMiehQW/Z9F4vD/cgd9
	 UuwEriPwh+wlwFXGnS3sY44MyfxN5K+FVGvbMPGDgL8iMBJOKeEQu0QL1gOi+Rvan3I7m
	 HJ9guPwgqYLAFQ6iEFoBFE0xppFAVIp2w3bIoLlATVHl+32jsBykgJ9eEX9l7I+2Vcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BFpWJK6y;
	arc=none smtp.remote-ip=74.125.225.74
Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F6C606A324
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 00:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43F6C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BFpWJK6y
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48dee584cffso170257f8f.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 17:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793148291; x=1793753091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8I3jgHK+6BtC3JOzf+0Q54xIg3MFuJSHblQVFWPMIuU=;
        b=BFpWJK6yFKay3FiO4dfQJFjKW7aE7OlvhcxnLqEKkq9iEBurxkbvy4bTPOyOs2xEWY
         cTteUqibSOrWcRAYX3XiWePqx/glpr03Vpc1+Mc9Qmai4tBoVONW94mIZ90J23GlcUG5
         Cvu6vqA8kiFmk5rSyNNh9XGmQKYfy8UPfN+CO2TrisX1N7prioMGQqFLY9NyfFbEk7XY
         Q+wPiE11no2uDXZqXGma+Jt1qGmXL09r8WYZ4E3NoVsDy5kgSgdlIz2wveIB/4Ku3P5r
         hM5i4eZW011pG/RrVQf1Q1jo5tcACgZrafKgwXzhBTnzH3AWE2DRjhIkbSNNPM4zUhV0
         DJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793148291; x=1793753091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8I3jgHK+6BtC3JOzf+0Q54xIg3MFuJSHblQVFWPMIuU=;
        b=RzjGBYzvKgU+CrOtgb+E+VCSQ4nvuj4iWqTlVVJv7/yotlUvpVAKb6fFQE1MeLOoLe
         eo3NM8qOnMmWOMl2Tw1mFad0Iwsv2NFwrRHkieZA6zYEWANEgc4itzSuZQHOxOgMS9sx
         YCmoUMQwufF8gsAEF8wZdeIolX1uRkRjSDlM0qeI+xKGkZdZbswHhEXLF5Elw/0sLEm9
         It6ztmlmIGJd2Zv+LwXaeM9IkMjSqTUv1u+KnfXTkc69U/dvxRBC3uE8fbE7af+6GU8V
         d+8Y2hFElsESek+hoYPYoObR5WFzuvvOgU7iELPiUqkpu7f4forSedzGJHz//HL7I90X
         2YPA==
X-Gm-Message-State: AFq9FYJBPgQTG0Cn5/ryiuhpu3jaqnV7OzsaMtv4j+cGHVXnltn+SgzL
	m7pkOoykxN4tDue3wMXG22hMtso6S0zFH2tYcx7c7ndRp5G+031fzrjtRI/zRaku
X-Gm-Gg: AYBFou2jKEKR/IP/bolflJ3Wf8Nfrbevt5LSZaOpLLlTOFSMMBZZ+0ATgPttPPUX6nv
	+jumC7daazY0YQDvbM+ZrtJCOBOs4k4P8uZMW8bsikRu3QkFIBUYXw+UMJdkREmmAjevdWPYKaI
	5FPMbAfREdNI2yzHaUpM+E5XCNwPQEBaG2xBrmWM1vNEi+dXVnOqc6Xd0fJXVpyfch/AqbfNuMg
	jPLrF2jweFsh6+F0Sl4LJrZ0h84KZSDATYEmonq8g5rGc3AAKxSItJwojoqt9u/76vPwEuuwthz
	Yl3XADQwMPMw++JrwqUQIRwu0gugZ5ybR7eGn2hgNo2OZLji9c7C0WmhC3XbGY8UzHUzbgVANxk
	6Oycql8+tvN3YDJ1IEqBRvRKkE1fCLd3yDS12ZxfSZ6/NSDH7HA3rqD4ocnMoUoq7Ln8ItwsmuP
	kOjJ+x1a5joZrv8N5Xnt/HAUePB1bVh8gNLGmezyLnWQXNOD0DcVRA7ewsPLriT4I/upQnNnV49
	iZxvdXzThZCYgVNmE2QDc600+ZvZzS9q6MVpJGYcNfPgVlR4ogJq8PBx7NX6MfkPTuMCFzu+YEe
	98wmOOvgagJjPwuviKMF6u4TPTaP2IgYuP1f91U+m90I9qrlQYBVtqCreJT/mXFz7AF5d7EWopn
	J5mosfdUXzwkAH1KrsAg=
X-Received: by 2002:a05:6000:2611:b0:48d:f99d:a0d3 with SMTP id ffacd0b85a97d-48e5d312a6dmr2822889f8f.46.1793148291358;
        Tue, 27 Oct 2026 17:44:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd4be6sm23327423f8f.37.2026.10.27.17.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:44:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 00/11] Unwinding for synchronous callbacks
Date: Wed, 28 Oct 2026 01:44:37 +0100
Message-ID: <cover.1793147364.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3718; i=memxor@gmail.com; h=from:subject:message-id; bh=/ipdMIhKchYSGe5nw5RLVTIsFTp7qxnPwCoy99L/6E0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuh45NJl9Z5R1vwlC6dsqf5VsGfv3sO3ZIXmr7ybVfrp tpdjCF6HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjI8ixGhq44QavtDtunh9xM 9RNe0P5brLJ2KrNBqnJmU3PTaqnCeoZ/qhkSzPdDpoS+rI2tnW4W9txiyn23WtupR56b7Zy899l cTgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A callback that a helper calls cannot unwind: the helper is a C frame
in between, and it holds things only its epilogue drops.

Code that unwinds due to panics or exceptions doesn't often control
where they can be invoked, and reusing the same code in callbacks would
lead to verifier rejections since unwinding across such synchronous
callbacks is not supported.

With this series, we allow a helper gets a pad of its own. A new macro
bpf_call_cb() calls the callback from an asm goto with an extable entry
at the return address that points to a label in the helper.  unwind_exit
of the callback lands there, the helper drops what it holds, and
bpf_unwind_leave() sends it on to the pad after its own call, with the
r0 the callback unwound with. The normal path pays nothing.

To the verifier such a call is a call of something that can unwind:
unwind_goto has to follow it, and the pad gets the r0 of the callback
with its state. bpf_loop(), bpf_for_each_map_elem(), bpf_find_vma(),
bpf_user_ringbuf_drain() and the comparator of bpf_rbtree_add() are
opened up one by one. A callback may unwind with what it may store into
callback_ctx already, and the fix for the pointers that don't outlive
the helper [1] will apply to r0 as well.

Tested on x86-64 with clang, with and without kCFI, and gcc for the
objects. The arm64 objects compile, but the arm64 run is left to CI.

  [1]: https://lore.kernel.org/bpf/d2369629-846e-4fd8-b567-a0fd8863256c@linux.dev/

Kumar Kartikeya Dwivedi (11):
  bpf: Give a helper a way to call its callback with a pad
  bpf, arm64: Let the pad after a helper call have r0
  bpf: Let a callback unwind into the pad of its helper
  bpf: Give the inlined bpf_loop a pad
  bpf: Let the callback of bpf_loop unwind
  bpf: Let the callback of bpf_for_each_map_elem unwind
  bpf: Let the callback of bpf_find_vma unwind
  bpf: Let the callback of bpf_user_ringbuf_drain unwind
  bpf: Let the comparator of bpf_rbtree_add unwind
  selftests/bpf: Test callbacks that unwind
  selftests/bpf: Test what a callback unwinds with

 arch/arm64/net/bpf_jit_comp.c                 |  129 +-
 arch/x86/net/bpf_jit_comp.c                   |   25 +-
 include/linux/bpf_unwind.h                    |  282 +++++
 include/linux/bpf_verifier.h                  |    6 +-
 include/linux/filter.h                        |    1 +
 kernel/bpf/arraymap.c                         |   11 +-
 kernel/bpf/backtrack.c                        |   21 +-
 kernel/bpf/bpf_iter.c                         |   32 +-
 kernel/bpf/core.c                             |   10 +
 kernel/bpf/fixups.c                           |   43 +-
 kernel/bpf/hashtab.c                          |   26 +-
 kernel/bpf/helpers.c                          |   50 +-
 kernel/bpf/liveness.c                         |    7 +
 kernel/bpf/ringbuf.c                          |   23 +-
 kernel/bpf/task_iter.c                        |   21 +-
 kernel/bpf/verifier.c                         |  162 ++-
 .../selftests/bpf/prog_tests/unwind_drain.c   |   71 ++
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../selftests/bpf/progs/unwind_drain.c        |   69 ++
 .../selftests/bpf/progs/verifier_unwind.c     |    3 +-
 .../selftests/bpf/progs/verifier_unwind_cb.c  | 1064 +++++++++++++++++
 21 files changed, 1974 insertions(+), 84 deletions(-)
 create mode 100644 include/linux/bpf_unwind.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/unwind_drain.c
 create mode 100644 tools/testing/selftests/bpf/progs/unwind_drain.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_unwind_cb.c


base-commit: 4169c9c90532df9585c0a2ae513337a58f5e59ab
-- 
2.53.0

