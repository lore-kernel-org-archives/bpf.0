Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF88436606C
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772909332; cv=none; b=iqfknqdMkaAE91XmmPv/xH0eJUzD1PUsM9GsKJHrSpMBLRp5yLpY+Z98dm9MfAQfm5conzpFeQxlsgbLOFWvI4dSyxhPRZEzjRRpU4fdT+c3j/pGWkqxIjAIJENJBau6CYGmmxoZqrikEoIJuZodrUuXDKIJfFWDJ6IR/1c5MJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772909332; c=relaxed/simple;
	bh=eHVDJXcq4X+CS/xdUeZXnnsD92vTKDdOsghs0xKnffw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=unP46ngIEdIMKvjUfDXkSRoxaCCrAp3K8/v4CQWVYivHTxms5foj1yfzs3R3GKqgfM0WhTgOa0Gimq+pRCoxyO8CugM6JOj/wb5VTL/ncik2m3RK4zO+HN0QTYFzsdbqUvP9fmL8f3ipTLjogJYwj4K4j+UAKlS05uy2pFx/lVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlKePTKg; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlKePTKg"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506aa68065eso90962421cf.1
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 10:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772909330; x=1773514130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i+9ahsnsWSySdyvH6ljLR9Nw5pN6696R14hb58xCC1g=;
        b=BlKePTKgdjvfYj6OjTlRRoVBbOQoQAc+TfCym3ANH6bI/GMqy7o23GpH/6wIYjUaX8
         A6KgJBGPDvj9llZDZ7We/5NBY22KNqUAooVeKM4x17C/TaQWJlPAouajRXl8AfBJWqiY
         gyB3kGnSKQERuLJFLFwSzgRZxLNNaNnHFuJv+tPZMDuUwfPhXQgJ5laqNwBVGO7zKSBt
         t0PzmXF7ouTPEgFlVFrC6aF6UyMPEjWpSNtNRh8zRelrh1tJ94KO0kizMANQfszemHyd
         TM2dByWpBGgR2jjCYnge7kx2gKusRN9Jbv9nGndn/VOUvg9GQbAuhaWijG3+kbwUAi4L
         D/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772909330; x=1773514130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+9ahsnsWSySdyvH6ljLR9Nw5pN6696R14hb58xCC1g=;
        b=Uqt4e5kFUO72CeQRpTQI338g/zdJg3hq6M9Ubi2ma1WfEirif0VFnrADqLOVlBVwEW
         FWka5CnsBGZk098xIZ15+5s6Uw5iDFVPXziIHk0zyEABl3WSesDqKCe23mIvTGawU3qC
         PskcrUyM7g3mZsJU2vcihKN4i2aVS6bJ3jAejlnb+pUZFDxkjikGS5oNXQ3A/hF7ixZP
         E5/mSvctFhNxDS9tdSfxfRLqg2BQFC2Dnh/ia8iov0n159FvC3h2Fm9C0Sah2h7qv2s4
         3jHi7XugnHSaVeDSDW7GVPtlqaqHhdM4xtlECi5UI4T9b+vZzwUQ2fk6ZpJJx3UK7T3/
         SPIQ==
X-Gm-Message-State: AOJu0YxtE2WhstpTIZT3H7DMIDNyooTD8vbu2Ceo6XAZ2pc6a0jV+cQ0
	bzdQaFIQkwl5KkU6aHi0jRTWVeW/p1+FveoR/4nd8ql77V34V0zzVKs3
X-Gm-Gg: ATEYQzy6ut2kooAonaycR9ZpZHpIA4F0eILt6xlCODGei0PTSJRy3Bix157QcuaUlAE
	wrrX5SrwddIBVg++SXB5cOTCuarN5ieAKd5AHHKAdHgWQ0lSjLWS1gLnTsB84jazUxjUqbKK7pH
	Bw8Qdm8gYSAujjXRcPMUNQeQ9RFkM2rguMxckSvMJKMaG8KM6lbCvGzl16i2wRQBzlH1yIh+tjy
	Cr9r/B8wLDdGdT1vXI2PooyL1+duggDeuRuligCpQ8uCjDkeMYUvw3P1cXCV8Jp3ubkFi+xuzjx
	UyWN3QK9oUcjziXTBJUzLgWe1ufFIxUbZYHNDhXY7yYsnxNsEYI0R+KfLFNecxEKa5dEwhHLfte
	vdpKPq4Lw0LK4zc1hNZwozSV+kfN2T6+KlsAk0VLpV+XydA7Fkl925vwCJuXk0mdFYarJ55bvyO
	oHNrDxEveG0g5PDuSTRHFN74rvdNUTYcdqSOc9ZmaZcgJ0yioIwiGVU7ctaovXk8fDrpsclY7mW
	agZABuS5iDElx2IvUI6q5y/Q6WK1NNgJy2OUDjDTnKFdn6g9at/8AOciQc1OA==
X-Received: by 2002:ac8:588b:0:b0:4ed:b0f9:767f with SMTP id d75a77b69052e-508f49753d4mr82093431cf.70.1772909329738;
        Sat, 07 Mar 2026 10:48:49 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-509101c6a55sm2010471cf.23.2026.03.07.10.48.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Mar 2026 10:48:43 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 7.0-rc3
Date: Sat,  7 Mar 2026 10:48:39 -0800
Message-ID: <20260307184839.33830-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08:

  uaccess: Fix scoped_user_read_access() for 'pointer to const' (2026-03-02 09:24:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to b0dcdcb9ae757c8a8ba2fb24d34f8d147bae707b:

  resolve_btfids: Fix linker flags detection (2026-03-07 08:51:51 -0800)

----------------------------------------------------------------
- Fix u32/s32 bounds when ranges cross min/max boundary (Eduard Zingerman)

- Fix precision backtracking with linked registers (Eduard Zingerman)

- Fix linker flags detection for resolve_btfids (Ihor Solodrai)

- Fix race in update_ftrace_direct_add/del (Jiri Olsa)

- Fix UAF in bpf_trampoline_link_cgroup_shim (Lang Xu)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (2):
      Merge branch 'bpf-fix-u32-s32-bounds-when-ranges-cross-min-max-boundary'
      Merge branch 'bpf-fix-precision-backtracking-bug-with-linked-registers'

Eduard Zingerman (5):
      bpf: Fix u32/s32 bounds when ranges cross min/max boundary
      selftests/bpf: test refining u32/s32 bounds when ranges cross min/max boundary
      Revert "selftests/bpf: Update reg_bound range refinement logic"
      bpf: collect only live registers in linked regs
      selftests/bpf: add reproducer for spurious precision propagation through calls

Ihor Solodrai (1):
      resolve_btfids: Fix linker flags detection

Jiri Olsa (1):
      ftrace: Add missing ftrace_lock to update_ftrace_direct_add/del

Lang Xu (1):
      bpf: Fix a UAF issue in bpf_trampoline_link_cgroup_shim

 kernel/bpf/trampoline.c                            |  4 +-
 kernel/bpf/verifier.c                              | 37 ++++++++++-
 kernel/trace/ftrace.c                              |  2 +
 tools/bpf/resolve_btfids/Makefile                  |  9 ++-
 tools/testing/selftests/bpf/Makefile               |  1 +
 .../testing/selftests/bpf/prog_tests/reg_bounds.c  | 76 +++++++++++++++++-----
 .../selftests/bpf/progs/exceptions_assert.c        | 34 +++++-----
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 39 ++++++++++-
 .../selftests/bpf/progs/verifier_linked_scalars.c  | 64 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_scalar_ids.c      | 56 ++++++++++++----
 tools/testing/selftests/bpf/verifier/precise.c     |  8 +--
 11 files changed, 268 insertions(+), 62 deletions(-)
