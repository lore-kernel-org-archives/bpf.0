Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792538385;
	b=XQKyFcIigHsZvjyihPWf8ZHDj3SqXKyZmxz3iN9T209X5BQjrWb8T4c7VOKzaGFCUTDF
	 RRLbGZMWHi99M1l/bb4WfjO76DVp4HongIlcAy9IKzgesYlvOLG54i0BfEARje6JeZOJ3
	 miA32n7m3M3Q7Uaf/PBjJZK27qKuK1CHhnNPjhqkPPQ9wdhjL9JYPkHDSLgmqHgn/MaRW
	 Wjoz8kss5w5aa8kMYzZnwaKgeiz3Zz2FhBPg/xZIqTpLrNAD76WSVgJhO7GDlK/eD3zx4
	 P7gLelwDP9rNkY4aK6NEXlBWbhEd5ptv7ivlJAT/lLc3Zr4Ogi4D+9shXqsnQnjGyVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792538385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=91dTE/cU6sybz9zyAeBrkKV3MoHqK3zp+AFE2Mkq0Fs=;
	b=wTC0gxsCVdr4gsMN8BFYGmtqEdoc32emoy7g2a92QMFlP0zcdioAZSrhP9zBjQ7Xyury
	 ahC2WHzEbBHOtPjCQoh7bfZJnKjk31ZEUQJYL2IjnMrVNXIrkdFjkUBgPOOO3QLj5kNUn
	 w+bBvLVbahcE0mCnPDjm38OaxbtIAbcAHPxEHPOUhG1AL2bq1PA85L419Y58Ym3jeXMKk
	 ZJsR9eOtpm8GqmhZMyF4Zd45hPuHirOq16VwFpzsJ3oipBS25H6n+vSQbLLs0vivcrg/X
	 sJ3SIsT8m4P051HjNZiM6HLyVlmFxPwRVfXZ7m1Ez4VvuGh7LXosYOShGfNGQrgJqAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hG48G1qA;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40769606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 23:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40769606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hG48G1qA
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so102962a91.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 16:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792538384; x=1793143184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=91dTE/cU6sybz9zyAeBrkKV3MoHqK3zp+AFE2Mkq0Fs=;
        b=hG48G1qAGyPhj4jIvTdQ9ZkyHyYTLiPPLJLGj4n/oWUSqDlocHaWHlMMbYXZsiPC2Y
         1REUJkIm+Lkmd5yMPk7NxDW/idFaQi1Pe8WJWMQbHW9X1FOgpYpUGr5DPP12QdAy1SQJ
         AcNFexFj/uNiQRdYdEG6fYkwlE97SRboLxsEuAXf8TM36aHZnMMsohIxGC+PkH3lFqvq
         JRofy0jsc07UnlKf9y+ieGsMLm6RkRBzn4z3g4rlzUsb0qHYqZ4/eet/ALK3wxWAyT/s
         xGMm8JncJWiDtRwzQfKsLvk1nESaKhyuJynB2N81X+ICvxvkSjtTgvT6o2r3aLIULDEv
         t72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792538384; x=1793143184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=91dTE/cU6sybz9zyAeBrkKV3MoHqK3zp+AFE2Mkq0Fs=;
        b=ZLqp4F6gLzAaPRjcjKaNibVSCAvShv08ZMKIJrU/p86pTCiIWL1GLsK8lXyrJhPH7V
         r0wkYaZnuVX6xlVYeYw4bkojqr57JOn0sl+JY9BGCCEGpfpBjN2pn72HmRk3csKL22jp
         lkCC3A4sl1z7OX7ovZRAvnwFwEnfG70PkCarbOczjZR6J6B2qXBUlIo0EyXtrEUChuE6
         z1tzjSsdVt0ermb/uEFLE1KOtETvxByV9uMzAFQeQVthD7wWYbKKXyCCNwQFFCxGokmN
         TNkW2p1j7hFArab/ZlVhD2vjI/p8iMN4AmtFS103qJNjgG3OzJCseOOi0dIVtk1xsz5y
         EcgA==
X-Gm-Message-State: AFq9FYJgc8hYmALTBgWqaMNycNEHy0cARoiYATty7bNWaSMqlxNkpw31
	c8yq1/opSz5uLFUOQO0rPkAkLCjMkAU6BmWtcGReRVCLSxfWwNjUwudVGxq4yQ==
X-Gm-Gg: AYBFou0Vx9+jqrRUUe+zFe360WITZKhJzg8PTkYatAa3f3dQ5oM5TZVx9mU7CDzcRfW
	DVRXnq18p389Kv8E/X4/ysDnWgDl7wqgkkJ5e9dqz27RT0BMv5ON3Uf0YDziz6AAIXqIkDrPhmQ
	P6RB9tCZYfTbivPsIBhUdvbgo4l1ytMEQKwat0CePyYU1+s5mtKvPZvU9qUuaU/JrXdpaMZBbxm
	9vjmNfbjMgQkctixa75dd1AmVleirgbMVcv7UPjt14MWF4PmvJYIXYaCM0Mvu8LgKUndFIF3Hpm
	92wCeR8iP1K5EUDHB22LxtA2gnwpRhfSz1SFbtddrG0ZCafo+F+9CNblsR88ps0uppnNChmkBP7
	j0psFElEi06+9wwz5BEzRM/wRAaAq00uHGjvVEBLz5WcyQmwDluP5Mel0rr4nH35suzlo4XSJsC
	PexlpMG95qGCHV14UgTyRlFIG7S4Vwmx7WgjMTnJyoQUeVR5m16/LJh44pQt/DEcePqaDt7paBT
	diNwyP9R9BBGBxBhctmYx7uhQ6ceYYIAmb0Zwt/UuQ3uRC1EasTiqVYL+m1uijoc7q47eBRcfFl
	7pEeB3IdF5KsEvPT147PoqNzXDqZLFUVJj249rIewW2eRpaSATiKGK36yMhdj2BWhtsRX/xc3wG
	zQa0jBWjuXlc+aJrX3BQDlLRG
X-Received: by 2002:a17:90b:4cc2:b0:3ac:a7ee:6780 with SMTP id 98e67ed59e1d1-3ad86f457b5mr286189a91.66.1792538384368;
        Tue, 20 Oct 2026 16:19:44 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm1446886a91.12.2026.10.20.16.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:19:43 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next 0/3] bpf: Fixes for unwind_goto and unwind_exit
Date: Tue, 20 Oct 2026 23:19:38 +0000
Message-ID: <20261020231942.2568163-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

Two fixes for what the bots found in v4 [1] of the series that added
unwind_goto and unwind_exit.

Patch 1. unwind_exit of an exception callback is exit for the verifier, but
JITs looked up the return address. The callback returns from the frame of
the main prog. After freplace or a tail call that's a return to a prog, and
the callback could end up in a pad that wasn't verified with it.
It came with 'unwind_exit of an async or an exception callback is exit' in
v4. For an async callback that's fine: it has a frame of its own.

Patch 2. Offloaded progs with the new insns are rejected.

Patch 3. Tests for patch 1. They fail without it.

[1] https://lore.kernel.org/bpf/20261020181320.1284798-1-alexei.starovoitov@gmail.com/

Alexei Starovoitov (3):
  bpf: Make unwind_exit of an exception callback exit in JITs
  bpf: Reject unwind_goto and unwind_exit in offloaded progs
  selftests/bpf: Test unwind_exit of an exception callback

 arch/arm64/net/bpf_jit_comp.c                 |  2 +-
 arch/x86/net/bpf_jit_comp.c                   |  2 +-
 include/linux/filter.h                        |  4 +++
 kernel/bpf/verifier.c                         |  2 +-
 .../selftests/bpf/prog_tests/unwind_attach.c  | 22 ++++++++++++--
 .../selftests/bpf/progs/unwind_attach.c       | 29 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_unwind.c     | 29 +++++++++++++++++++
 7 files changed, 82 insertions(+), 8 deletions(-)


base-commit: d4bccf4ee7162c5688b53fe8096b046b89c20c11
-- 
2.55.0

