Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87299478869
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530882; cv=none; b=Sriws5DeEkbroE/nhIV1TSmiQQe+avFNI90PiDgQv8CmGw3d4PKuY1xTGjq1Ey8vg1eNqyAyONjV6Air+HbjbmT+Uio+iJ9KJ9b7ReV8Bbv+LONAR5d4e0rf3g3eftnZJ9iSKCrsISbLmP2Ygoql1m3mx/bmj9Qr4ZtY9XfKtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530882; c=relaxed/simple;
	bh=xSnrJfL3YVXidGjGDnCFQj/K1Cu6ocx2tcbM1uTJpLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpoxtP+lld6LfZxXr3pO7tpnDcWa+j5XiYEyErP+PtFXlvE9YfRMjmdRJyxnTQpyuLZEJlTcI8L9t8zUtxDO7sBur4fk8i23NtDSkBKIZAtz7xySGtGIUKXyGrevvWSdO1EKfeI9MJJR68lykxLgLIbDKCTWDtBqXpRuMCWg55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdTv2wZi; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdTv2wZi"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-487048857f6so3316360f8f.3
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791530879; x=1792135679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQsME9TdWbiG+uha3v7w3SB524sSkXuwVYvZMbnTC/g=;
        b=CdTv2wZiBEGL38+VI0tVstW3vJsjga5+Ey+C/1M+dl/1Iw9GEdBD7e1nnXWF/CSeZC
         bhMpYTW+MYhMPtTeXH+6nN7svl4V0YKMOPj8x1asLMFGeFIC6Lkg9m75TrUcTM0gasR5
         bpjz67wXoAAuoMuJ+Ter1vnwvEnVpCZy8xLkcd71id87510YBOhpS5Xv8MwmefSc+kre
         Mg+gcPEHsOEPeBen4yL/s1qhOFuLqBQtZvruUfBYzxiV0kdzqDeERriUJvifi4kmGQ/i
         S6pbess2iYSVcSfm23gfwK/Htl3VOAJ0H1q1bC6UF2iIPpN2AhVCKN1Hhm/SEThY0l+n
         /bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791530879; x=1792135679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQsME9TdWbiG+uha3v7w3SB524sSkXuwVYvZMbnTC/g=;
        b=SREwFDJDBh+xtpPkCM4HJcFsEPZclhQD/ayvlWVIZYvNRFAXqcsK9dboWBFLO3hfU/
         ue6eV8Yj6tDNAl4FqVzNtJyOSQe1gtaqglP7GwXBbhusGA8CPeVDKdOsakn0FrG2WH7k
         2CgwJisPtAogeC2Drm2kqU5UVS9Uul+ItfjK6Y0NFy/P392CmEOnmq4toWLt7Y7ROqse
         vdDj1j0hbxSuvstF9FxLLuhjM8e2vYjd+Fn/vxSusvBhjTPWDYxhdesYULZrqW+Y9XBs
         7lICA055hwlbttw9+Hb9P+uFPqWztqN/okFqfCsSiSwHGNGr2eu659koSK1BNMMiGjXv
         cEmw==
X-Gm-Message-State: AFuF++lLfUauyVm2I3WBkByAGLRk2ZX5VFiXeCR94FiXvS+sGUbbXBe8
	U0L2zzA/ptolr1m0ErjTn5uLwCGBGpTbL1iGmsi/7UvlirI7XGrmVLTj19PMO/aBnlU=
X-Gm-Gg: AYBFou1ZJNbhPZjtAqZC77/rqyG6lVf+rtczOODY3YlScifKwkouc0riQOCB6zO+Q9W
	CTrNN13iwUOn5FP51cyYTItJuSWbR7nq8/Nx80nXyKkCKLW/RrFJaNF6IRM9BufHIUdcTiEqGk4
	akE+EWFzO9DUOvm0c+ZAM+C7f4hKWT2e+pMxVs6MXo0G2hNufdVVkRq7T6QYnncKPqzH7d+jZK0
	pINrICRr5Br9ulXh3oRT5pO0e7eGpGSdnw2/I5AWDvnzcZMnYB/OKFprOKoBQ2F1MMmNWbbFmyi
	2+f93tv+Qbb3F2D2Xx6mlF8zGi8QRSRgrzSAG6at38uJmzBAlqj30mJrKsASGf8ZQN2bONnf1B7
	aJQWSrgUSabGjpXomYmKKGSDBh3AoW/63Dent+QMJCjYpRQoNyLtPMVYCSWVROW1N1IfkymbOk1
	mXZ0tcYiNtgRGskusuhd7JAujSGz3knZYlzAf+GAhshvoH1DN/xk/9rZTTYxgiFN3B7e+P11eyv
	7z/mzTf63y23JEtdmb3PpcKDfyo8c0sGXDK+A==
X-Received: by 2002:a05:600d:82c7:b0:49d:17d4:aff2 with SMTP id 5b1f17b1804b1-4a18e444415mr19224145e9.1.1791530878653;
        Fri, 09 Oct 2026 00:27:58 -0700 (PDT)
Received: from MacBookAir.home.tenber.ge ([2a00:6020:a725:dc00:8c53:eb98:bbe2:fd44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ae17e9sm2497952f8f.57.2026.10.09.00.27.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 00:27:58 -0700 (PDT)
From: Jan-Gerd Tenberge <janten@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf] bpf: Propagate precision for outgoing stack arguments
Date: Fri,  9 Oct 2026 09:27:52 +0200
Message-ID: <20261009072752.21037-1-janten@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF subprogram arguments beyond r1-r5 are kept separately in
bpf_func_state::stack_arg_regs. State comparison and precision
backtracking account for these arguments, but propagate_precision() does
not seed backtracking from precise stack argument entries in an
equivalent state.

Consequently, when state pruning requires precision to be propagated,
the producer of an outgoing scalar stack argument can remain imprecise.
A later state can then be pruned despite a different argument value.
This can cause the verifier to miss value-dependent safety checks and
accept an unsafe program.

The conservative fallback in bpf_mark_all_scalars_precise() has the same
gap: it marks scalar registers and ordinary scalar spills, but not scalar
stack arguments.

Include precise outgoing stack arguments in the backtracking seed used
by propagate_precision(), and mark them precise in the fallback path as
well.

Reaching the affected calling convention requires permission to load a
BPF-to-BPF program and a JIT with stack-argument support. This is not an
ordinary unprivileged-BPF path, but it is reachable through an
appropriately delegated BPF token.

An isolated x86-64 QEMU reproducer confirmed native kernel stack
corruption, including a complete overwrite of a JIT return address. The
reproducer is available privately on request.

Fixes: 0f6bd5e7a804 ("bpf: Support stack arguments for bpf functions")
Assisted-by: LLM
Signed-off-by: Jan-Gerd Tenberge <janten@gmail.com>
---
A source reproducer and benign load-only regression tests are available
privately on request. They are intentionally not included publicly in
accordance with Documentation/process/security-bugs.rst guidance for
AI-assisted findings.

Please queue this fix for stable kernels containing commit 0f6bd5e7a804
("bpf: Support stack arguments for bpf functions").

 kernel/bpf/backtrack.c | 10 ++++++++++
 kernel/bpf/states.c    | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 47282ffeeaf9..707cf12d5e91 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -705,6 +705,16 @@ void bpf_mark_all_scalars_precise(struct bpf_verifier_env *env,
 						i, -(j + 1) * 8);
 				}
 			}
+			bpf_for_each_spilled_stack_arg(j, func, reg) {
+				if (!reg || reg->type != SCALAR_VALUE || reg->precise)
+					continue;
+				reg->precise = true;
+				if (env->log.level & BPF_LOG_LEVEL2) {
+					verbose(env,
+						"force_precise: frame%d: forcing sa%d to be precise\n",
+						i, j);
+				}
+			}
 		}
 	}
 }
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 012b82513a3b..7f995521baaf 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1062,6 +1062,20 @@ static int propagate_precision(struct bpf_verifier_env *env,
 			bpf_bt_set_frame_slot(&env->bt, fr, i);
 			first = false;
 		}
+
+		bpf_for_each_spilled_stack_arg(i, state, state_reg) {
+			if (!state_reg || state_reg->type != SCALAR_VALUE ||
+			    !state_reg->precise)
+				continue;
+			if (env->log.level & BPF_LOG_LEVEL2) {
+				if (first)
+					verbose(env, "frame %d: propagating sa%d", fr, i);
+				else
+					verbose(env, ",sa%d", i);
+			}
+			bt_set_frame_stack_arg_slot(&env->bt, fr, i);
+			first = false;
+		}
 		if (!first && (env->log.level & BPF_LOG_LEVEL2))
 			verbose(env, "\n");
 	}
-- 
2.54.0 (Apple Git-157)

