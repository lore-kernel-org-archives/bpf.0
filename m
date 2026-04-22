Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7680365A0F
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873249; cv=none; b=b13MC950Glfc2/BKP3bN+YszyQpeGY5NTODBxTjRv1yFnPH+WfOXEUfTQX1Iv36q8kk62Eb8LLzbtt4tPSzpym9NE8ayWGwgSYjqU0HOhvFFABG1PoqHUl11GOEyaSYxrfSO7aK7C8Hvvj0PNB6lTr+au06Gi+sxmMzBrGc17VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873249; c=relaxed/simple;
	bh=chz0KLfckL0pVVlDTYqB5/Vp6ANh7y0usPSuATngaPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o12EpfJcmIFjqIl8UTl1RjBwde6yQbkUlAJs1V2pC29JFHUPPhJ4zs00HBGL2+autACI3sAqSYTjHvzWFkBCHI0zKFc0xW1V1dX0HWUQoaCG9Tyl8AEnre4/vFI7TeKIAj1zELlNOUhyz40pnxQLg90Kx52ZzCQHpC3lxWJVvyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDoee2vF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDoee2vF"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66bd474d90bso567471a12.3
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873245; x=1777478045; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xYtCgCBSrJ171ZZx5YpgZR8oV4HLoKU+fvgbBYIH/A=;
        b=sDoee2vFt+loZjPVicWVQ8vvilrMCeE2eHW4Dj1H2ggz0T9oFTJbMvF2jKa6PdNJz/
         HlXlXJwUVY9cvExQXXDQ9fYnphnQLtJN4BFBl1PRJsv/nlbOWrqYRXp0ZbuZszpRWBZr
         VYzILXdtcXL6JTJQlvj3badhmroynC0D1NuCWYPtcGfAJjw5vKutacKP2kTJa6xFZpFQ
         ez1ccNgrTffPq8bAWU0Gxnav69fFd5qHg3FVGe1sOzXH8AMq8P5HyldobgZJrR5DkUOJ
         lEUWvPvneZXU0e3t1wO1kG3dPdnCHJstbEakg9T6hKm39bapzqzHKV1Eik9nl2nzl1oc
         7ILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873245; x=1777478045;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xYtCgCBSrJ171ZZx5YpgZR8oV4HLoKU+fvgbBYIH/A=;
        b=cMTfCUeUkwlhUIhMoeoVZdEDL2VrSiouo+eimhVit+JEn4sFEt390fPnI/0G1ngXHY
         mdfEqQhDuXlYKvyiv8KCUClYn88HuTDWq50UIPNICTYivtzhxlt0SZ1nMl2slajPx1PP
         oJLkJktuNH/hs+nJ2Fj2ChQNwkQC31O6XfA00tDvV+q6/RQ5vAsuFuC0FzrK69hYtF9B
         rE5kdYJ3iEUecr8rdchrO1cPsQFChccp2gI0u0knSkpkW4Y3Plp6oKOMv0dIWSa715uc
         eRAt5xA4k3Y6W4C0r1e9MPxQmAsF/XkVszT2NCpJYUg1elyw7kp/Yi3RIb8lFI6YLslH
         gP/A==
X-Forwarded-Encrypted: i=1; AFNElJ9e7mk6+7873XgbAp2spmg30UiSx8Id/4/Yxy6fQAWRVcTzQTHuc21wGR/TWqQwbstHgkI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq1enhOwxBE1cNRTI/n4u5ummQNd3lkb3v0Ruep9neADym/mU3
	rKIiREZ46gjUHIfcR2G5C7khG2gNCcV/VqM5/ctVtfRq1PfOpEgbadm+kFsiZ4Kg
X-Gm-Gg: AeBDiev2QFYa2UEtjHbFFUGIAizCJ+5VNk0I7tJSuGAojnXtMBwiRG3plpJBTsA93t1
	J+WQrJwv0KjVdFAKFxofwOKyLFl7H6cfY6LNNpG6N6KSDbGqhPbAyA0PdYYxvtVAoAUbFFyRVCc
	q4/DidGO4HIpFUWIfDtAOW0Ni07Tq47eE+BFkspT9ttJumKeoZaJRrx73qQA3/1JXNoDaFJO3wb
	MV69Tg9DikiKPNEcsi4cULP9WJiBVFWbU+qJm3TBiivmop9D4G0/AIbZSp3zjZmddW9EJmPFrm5
	dBz/1xhqmJuSS90PMMCwcV5xo2yKkhpYqvw2zJ2mg26qMjj5cmmRvm+2mAD1+XtcoFFkwTspuwG
	ZKXTRP9xqhhxXvNv4YgmtOEOYBNNo9OIC+6V2cG9yXNyShZyIgo+rRxQBi3wIxJXnN5IcxGBYwE
	FHXh8u1krNNdR6CZbA+dROdW10J1eM5Zk7TZKbhHKamqhJf5vtmLew4HxLGg==
X-Received: by 2002:a05:6402:1cc1:b0:670:8ccd:704a with SMTP id 4fb4d7f45d1cf-672bfeda823mr4709355a12.5.1776873244793;
        Wed, 22 Apr 2026 08:54:04 -0700 (PDT)
Received: from [192.168.168.223] ([182.176.170.188])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d50922sm3295274a12.21.2026.04.22.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:54:04 -0700 (PDT)
From: Ali Raza <elirazamumtaz@gmail.com>
Date: Wed, 22 Apr 2026 20:53:05 +0500
Subject: [PATCH] io_uring: fix missing submitter_task ownership check in
 bpf_io_reg()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-master-v1-1-e82f47558345@gmail.com>
X-B4-Tracking: v=1; b=H4sIAODu6GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyMj3dzE4pLUIt0US7O0VINUi6Qk42QloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AA73dz2oAAAA=
X-Change-ID: 20260422-master-d96fe0e8bb3c
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Ali Raza <elirazamumtaz@gmail.com>, 
 Pavel Begunkov <asml.silence@gmail.com>
X-Mailer: b4 0.15.2

bpf_io_reg() installs a BPF struct_ops loop_step on any io_uring ring
the caller holds a file descriptor for.  io_uring_ctx_get_file() only
validates that the fd resolves to an io_uring file; it does not verify
the caller has authority over the ring's submitter_task.

A parallel path in io_uring_register() already enforces this:

    if (ctx->submitter_task && ctx->submitter_task != current)
        return -EEXIST;  /* register.c:733 */

Without the equivalent check in bpf_io_reg(), a local user with
CAP_PERFMON can exploit IORING_SETUP_R_DISABLED -- which defers
submitter_task assignment until IORING_REGISTER_ENABLE_RINGS -- to
install a loop_step on a ring before a more-privileged process becomes
its submitter_task.  The loop_step then executes in the privileged
process's task context and can issue arbitrary io_uring operations
(IORING_OP_WRITE, IORING_OP_READ, IORING_OP_SPLICE) against that
process's open file table.  This provides a cross-privilege io_uring
execution primitive that can serve as a component in a privilege
escalation chain when combined with a vector that induces a privileged
process to adopt an attacker-controlled ring.

Affected: v7.1-rc1+ with CONFIG_IO_URING_BPF_OPS=y.
Requires: IORING_SETUP_DEFER_TASKRUN | IORING_SETUP_SINGLE_ISSUER.

Add the ownership check in io_install_bpf(), which is called under
uring_lock, matching the locking context of the register.c check.

Signed-off-by: Ali Raza <elirazamumtaz@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/bpf-ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/bpf-ops.c b/io_uring/bpf-ops.c
index 937e48bef40b..cac11c929297 100644
--- a/io_uring/bpf-ops.c
+++ b/io_uring/bpf-ops.c
@@ -162,6 +162,8 @@ static int io_install_bpf(struct io_ring_ctx *ctx, struct io_uring_bpf_ops *ops)
 		return -EOPNOTSUPP;
 	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
 		return -EOPNOTSUPP;
+	if (ctx->submitter_task && ctx->submitter_task != current)
+		return -EPERM;
 
 	if (ctx->bpf_ops)
 		return -EBUSY;

---
base-commit: bea8d77e45a8b77f2beca1affc9aa7ed28f39b17
change-id: 20260422-master-d96fe0e8bb3c

Best regards,
--  
Ali Raza <elirazamumtaz@gmail.com>

