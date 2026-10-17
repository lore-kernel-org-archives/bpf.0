Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D23AFB07
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255197; cv=none; b=oZMfsxhwHhCQS7PyT/t0Y/Qu+9JgQmzGLMVaIpL+EJyGhX1D/lSp7dcyxGkVqILAtxeOl+LJaadQ+jKL8JqdgGSI6zUCA0Yg61NZLxzdxE7NJAYl796v9FnceiyhUuoQyVdJ9YqqzN2vmxgt52x2XvmjVifAPGqD2M4mCA/Iwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255197; c=relaxed/simple;
	bh=7y7OlqPEWMDpkt6fNcFfW6b/HaoNiQGS8fE41yTEnTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO+xLnSz7kMEJfiVN7tXhgeTvyoDAWzncgMiu6mpWk5nlxhJ4t5pfeiUaLPX/E7nhs5tzSZzPDkUMJZTzVRmGyKMgh1Ft/XMikxS+LOYjp+Hy3vOdfGg1RhR5s6a4WYds4CON6Qrl/TV0QbFEch00Pzy5mPHgRjhPkUZaTMXJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rljogdd5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rljogdd5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso799119a91.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255196; x=1792859996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eayYgvoE+n0xxqYtpK1csTmdRYUbISrVRKq/92ywn2g=;
        b=rljogdd5rOB1yy+Bp7F4RcURqBSHNbLz9udmRJ2LTUeCYF8NnNj0AMcGBHy05leIGf
         0VEISPRT5LS49CkfgsewAGITWhi8dCkkx/HRMQsc4ntHXbiGcetB/A3tiIrBz31YLK0e
         TfpYQHZDcnofYe+gwhZg8RperaNDGgNLpf5Dpst3Rsj/u2dekk4/AulTLEe73DMG4+8k
         XhCRK0Bu/hqHmf89HWUdBiBfU9f54JzeekeGnKAcEPMn2nMFUDN83J0AAgGpkcg45GZx
         icjsrAbPh7Tmbj892X46nTlUZ5/+bPHPhd5J9xekdxJE2Q4ixI6rGVQRaeX1BAn9ljje
         7SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255196; x=1792859996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eayYgvoE+n0xxqYtpK1csTmdRYUbISrVRKq/92ywn2g=;
        b=PF5yxOx2YVsyCYNy0eyREAmvmupdw3r0z7MhEpJsNgT5bC5EHfnruOK+KBKdzKaWsy
         wotcBhDdyN6AZxXtQF6lA6RmWlSYuhLfu0T/D0mBW836EeO8Y++kx3AVNsYcALzeCSpO
         iD97pd996KSDDFOs1Dalh61W0x86TOOWzdy2OWpTBSE5qiDrwlVi6AWwQyTBV8aN7aTb
         3Gqn4wBFHu9OBiyS2+ZBw6cl77yRz9ifpsvx/Af4PVOo+JvEkjI3sRmjHNBhzG4uk8Rh
         uW9fYSFVL55b+m/YsT0ROMn8RemlFDsZY1EZ5wUN1bcH42x7gwDGf8Khef6AN7VX15jE
         qq7Q==
X-Gm-Message-State: AFq9FYJOe9JWQM8Hew34B56J4UK85XQUl+1/UNZadGI3c52eVibA+R59
	QkZFXvUs+YJHNyqPwIblJhrN2I+7DsaGk5NRRE+2lLWI/iSruP1AtADFbbOorA==
X-Gm-Gg: AYBFou3f3W6gogdtUM+FN0RKaupaRpLCHoJ+LcvK0USpGhI3xmwV0nb400zh9NfE06S
	3nDOtr7fZm5r2li+cJIVzo0pj5kMOmCkd3vRHNFvFnohfDbH9q8RVcL8EwkqXsOE6eCoSeZFLUh
	SY8B6NO+R9+wxOWV9DLLrt9kliKvct8j8gYLFqYontZYS3Mof1GoldPVcPwEvN+r1Fm027vyFZB
	/1E3Lk0279epdP9TO0yPkDcFeE/HbcS4KuRaPuHkr7rOsDcVCNGPlsptWD9QgRirw74MXZU3lnN
	CjnnWjU0oYjNLtaVVXdPob6bdg2NpGoqgI8MHQX/aRvrTgU3oVQSjXQ4Ihq53yzQO6mHFt0IiAg
	8Z50CNX7RqNCXF7ku3qCA5uY4cAqJt0aUksUs4/v4zlnQZVmQlhtWfVxzhIdZ0J5WKH7Y6sisrt
	M0XTzgfVnIBrVBTgYbA7zVq+CMOiXXRPnwbpPuM3e7FN/O01qLXiiVDs7T47bGfbh4pvN9qVKLJ
	MkxOg0BxwbHqWxT3T7guHhVKGUX09uU3muKQDyJKQE9hyTGJHlrgpF55AXfZml18zAaCyAlpEq7
	CE4atFKG5TWwHe2KdFUaYaRAuR7/Jppzon/vxbKgCOc=
X-Received: by 2002:a17:90b:35cb:b0:3ac:8fff:5a1b with SMTP id 98e67ed59e1d1-3acef3d9570mr2902298a91.34.1792255196077;
        Sat, 17 Oct 2026 09:39:56 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd093380dsm4335754a91.3.2026.10.17.09.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:39:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 21/43] bpf: Don't bind a program to a netdev that goes away
Date: Sat, 17 Oct 2026 16:37:23 +0000
Message-ID: <20261017163745.3341787-22-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_prog_dev_bound_init() looks the device up, takes bpf_devs_lock and
registers the device for the program.  The reference it holds does not
keep the device registered.  If bpf_dev_bound_netdev_unregister() has run
by the time the lock is taken, nobody takes the program off the device any
more: the bpf_offload_netdev and offload->netdev point to a net_device
that is freed as soon as the reference is dropped.
bpf_dev_bound_resolve_kfunc() dereferences it while the program is
verified, and a new device at the same address finds the old entry.

unregister_netdevice_many_notify() leaves NETREG_REGISTERED before it
calls bpf_dev_bound_netdev_unregister(), which takes bpf_devs_lock.  Look
at reg_state under that lock, and treat a device that goes like one that
is not there.

Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/offload.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 5a10f40a7831..f7bfff1760cc 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -266,7 +266,14 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
 	prog->aux->offload_requested = !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY);
 
 	down_write(&bpf_devs_lock);
-	err = __bpf_prog_dev_bound_init(prog, netdev);
+	/*
+	 * Behind bpf_dev_bound_netdev_unregister() nobody would take the
+	 * program off the device, which goes once the reference is dropped.
+	 */
+	if (READ_ONCE(netdev->reg_state) == NETREG_REGISTERED)
+		err = __bpf_prog_dev_bound_init(prog, netdev);
+	else
+		err = -EINVAL;
 	up_write(&bpf_devs_lock);
 
 out:
-- 
2.55.0

