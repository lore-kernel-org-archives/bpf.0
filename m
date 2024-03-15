Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCAC323D
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710469120; cv=none; b=pSA4CD8suMQpJQDd/wWJ8KVXt2MK8tQqwUTL9JNvVaQU77i4xB3bpe2MsyT7SzYCy8k9Xy5di6ElXU8LwCcLINj8oM4f2kzbw0+E7BBcLN7ydV8UTWEZ5rfG3YRnuxcer9OQZevHaSlUM+j+aB+ocoAioSEzPht6EU6MvEtuamk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710469120; c=relaxed/simple;
	bh=sFIHlDkiDbQz1EUiCk41naWcAdhReTzM/Jx0ZsiYdOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MbmyjMCQ3+0EPw4svJ1hBIli9XXolxo5v0VqtQq6NqHaqcOectngEpqDF/4ImmaRBYqh0sKjT23/KlAPXjh7eYfyB21w2q1Nje0Mc4vJ2PhB0/osDwEfy2GhWM2jM2lhwBsBNDQecrFYn6NpJtWvftrLvwygFw+mv40+sEaCmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5gP2kIy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5gP2kIy"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dbd32cff0bso12226075ad.0
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 19:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710469117; x=1711073917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn4VceAaSSB9eYHcfCWfsBIXc51JqUkkWLAuMjiRBSs=;
        b=N5gP2kIypK7Uy8X0RhYvh8Hi46vc915LfPUPUwf8SgDXge88v14/3FEEQrJyC6HYOD
         ulNYs6X4jtgSbEwNSOTw411P0LpES43v4u5lG89GqRsfjbs936ARLSd6aW94cgNVQhBb
         +YRiw5pZhYihgg3FSKdagVyzwhrqbfzqk2GQ2fJRGVVge+fZqOLImuA4iZOo9f4LpdaX
         qB8yrUM40qxjO0NNKcoy+zczDLKUKEgyuGmk7d0PAzGOYnDPCo4p6ojx+CyWVLGDXrlU
         q5HmYSexN76pd1BLcuuQYeK2xjwYXZ5zowO+wNIudNaFOXcRZ8BZEgJ8ufcfMpdKrA+u
         IIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710469117; x=1711073917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yn4VceAaSSB9eYHcfCWfsBIXc51JqUkkWLAuMjiRBSs=;
        b=GbHi8yKz6d7YzHUJJ7MvPxJY9VvBat/7LV/qQB2qtGuV8USdhYT73Lk5TBpqQJb+kZ
         VCKdu2dRk8ICvUiYIUzovTCuqqdg3am9pjsghfN5NAQe34UNoXUMWSQmj7yZ6A3l7GoW
         ovRI50WoU4kQgAQL1gWBhBCtIRyKKVmWAsCahr5yHaQDutJIYijcxMvsQByiqL7YRqKs
         Qg4CQce/nMUsK4cojVfC3vkAOSYtgc1lZ39IT0SYaaQYaEbsMdhhIbYEWFUH7Ke0FxuZ
         2V3ddjmN+01vYprNJYYt+kuJ8vuw7bLKw0T73GPJnEnU3PjWGCmGiTquKkQqDmebhnQi
         ZO4w==
X-Gm-Message-State: AOJu0YzC1fK+E+RZjTB5YlJixG317jjUNqsO94NFtfFecN85WGgvE2Ga
	gtbhokp+h4pfqMZZR2i28XiEbKfn5cOqt13XHP8tN0fSfIqfRKQ4yfyfHy0b
X-Google-Smtp-Source: AGHT+IFvJpboAD+78k6EBrlhpreG6diZWZfwqhYKjkMvsBQWf60f5KAMYjk6Ma5+JBfYAnk9kX9ObQ==
X-Received: by 2002:a17:902:a3c6:b0:1de:de3a:67f2 with SMTP id q6-20020a170902a3c600b001dede3a67f2mr2699571plb.1.1710469117472;
        Thu, 14 Mar 2024 19:18:37 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:12e])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170903288c00b001dc91b4081dsm2468461plb.271.2024.03.14.19.18.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 14 Mar 2024 19:18:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf 0/4] bpf: arena followups.
Date: Thu, 14 Mar 2024 19:18:30 -0700
Message-Id: <20240315021834.62988-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A set of follow ups to clean up bpf_arena and adjust to the latest LLVM.

Alexei Starovoitov (4):
  bpf: Clarify bpf_arena comments.
  libbpf, selftests/bpf: Adjust libbpf, bpftool, selftests to match LLVM
  selftests/bpf: Remove hard coded PAGE_SIZE macro.
  selftests/bpf: Add arena test case for 4Gbyte corner case

 kernel/bpf/arena.c                            | 25 +++++--
 tools/bpf/bpftool/gen.c                       |  2 +-
 tools/lib/bpf/libbpf.c                        |  2 +-
 .../testing/selftests/bpf/bpf_arena_common.h  |  2 +-
 .../selftests/bpf/prog_tests/arena_htab.c     |  8 ++-
 .../selftests/bpf/prog_tests/arena_list.c     |  7 +-
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../testing/selftests/bpf/progs/arena_htab.c  |  2 +-
 .../testing/selftests/bpf/progs/arena_list.c  | 10 +--
 .../selftests/bpf/progs/verifier_arena.c      |  4 +-
 .../bpf/progs/verifier_arena_large.c          | 68 +++++++++++++++++++
 11 files changed, 109 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_large.c

-- 
2.43.0

