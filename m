Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3938E5DC
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742390; cv=none; b=Bjw6+8x99WF/CZV1+FDEjILVDPodPEekU8v4UGpLVkr7SYkj8gUndD7jznHTdFDoxa+8B99yN6Aijt02xrva/Ug1QKMxCBSHWOyyuSKVBGhlpe/tgQOBKZpRWXS7ATVD1RmLmY8xYaKGM3PP+zqohkPLtQwq91JfbUhYZFLzAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742390; c=relaxed/simple;
	bh=1fftUoidy4jgxh7YVMqg1ODr71CmedOL1GmKoW63t4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hivjC/EN4SWox+lZ8SsOQSs7nuX3CBf5sPuJ/FK+p7/ox/9d2n3xK4yhKt4AIAC06xxZJ0Y71v3nWodbyONp55IuFC4YRx1DiN+hjhoJgOXCVi2FCea16acbasaxwDvaKB3h8mXEmQZ+mRwvnRMSZb834SMyyPRAxRYLT5s4w7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWIaDqop; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWIaDqop"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so6258315e9.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 07:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789742386; x=1790347186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92mac3At0JuDNMP0ZbTfo1sG6/Sn1KQAOj5nr4PadmI=;
        b=LWIaDqop2NTa1aaXbB6dvItVtK0vGt764amd/VZG7hjFl2i8k2oWAfye+gfe7cYUFM
         TqzwON8Z6B/v3pMqrm5nitGUBouGulq4kinepaiLq+frsidJYIkpCz0MWSIBdUtR6naI
         09XMbp8fqy/zxrYM5psW+eQdY+LQsDIKlZrA7MXX8UOaQn0NS0jRNtYpSt/TM29iPnFC
         tzXSqvruNu3M1NeS94lp/Cx2xWxNl32/bd3+FyM3qmzJ1lsady7zNBruuMEp/OYc4Imp
         vTt6gQE2mKHQsdSyQHutHcYjuGc9mp7J/XhvDbXvfpAPDZn/wzUwxjobmns16biPpuu7
         Hqtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742386; x=1790347186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=92mac3At0JuDNMP0ZbTfo1sG6/Sn1KQAOj5nr4PadmI=;
        b=oOsVleis92g86Vz1+ktAw8x2+7NJhuVh1iwFE3NSzsAsE/XzLVmooFtYDX2N+DWtpS
         eios87HelHlQ7tqZ74FVeBSDY/PCxrYMQHNWaV+1I8222cG3GTCVzHeRJ3KTSniCF2lx
         uFEWX2BySbRhyfcd9GC1k4nivQX42VBmpAErfcq4Xqg/o84mjc/q9kOnT3NNyMqJxkfp
         5p/nSJGjMRzkqpiF85MB0FgjSC2k4HDFyimD0w64xB4Yp7vqT5ylKAKO8rLCOnaPVJ5E
         3fRMlNArErzRxMJZVBQBvo9s0BVZm4bvAlYr4bfDZTVCRD4Bm2q6BX3fX2hM3QSeExrQ
         vRsA==
X-Gm-Message-State: AFuF++ktfmBmz3wtL7gYoPv4sreWjqERNMxpaXxW0BEPfcWFa1b77bRa
	NK9ZJCxWuee53rD8+1N5p0NH6VT9Z+LvjnUzNQXmsms7IDdq5ld35b8+
X-Gm-Gg: AYBFou0LI5CFHaDvCcphg4j0tZtNaLIUn9Mqribc/4uLDeLIJs2AfB6sA1uLiuPu1bp
	K0HsNG79pJFng9a7YV1ReJfr7kU0r3NtiOv/XsQBaEzCDtchLCEaMv4XuTBs9bX4ES/NIxhAImx
	XyxaXxN15NWHRPNkaPFMV6d2eqSBxkFuUNHPlY5KDG1gNsO5RYeJmNGoFpM2lfEdfes494EXjpG
	pSPB0qYO5gh829jPzqpqLTDAyAHq1n9Kvf9ddlkGVpyiKMTcTm0v2+DGzoYHMttK3tMV1l2+BFw
	cfnSwyG6C4Td50eoZgDncXdsOo6QxdaajT0fQgz+Wxagrm1clGD22AoHAb3tUx+FKedlq2drxuA
	WZahMLrpF24tc5ZfAqZZkRPfhJ+7d5QsMLSPSHX1vroRmorxXsJBdRL7mWte7NilcGYCr+gdhZC
	pv3eVMrlvblD62Ha8jnGMxuPAxsmErMS6gKo3x4SjniEOnO3LJE+bJQG+V79tqleQPUCuCZnN+e
	Zd7T1SS7y6etYE=
X-Received: by 2002:a05:600c:5254:b0:493:c47f:3c55 with SMTP id 5b1f17b1804b1-49fc56732aamr36801425e9.5.1789742386348;
        Fri, 18 Sep 2026 07:39:46 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcab7e333sm45448015e9.7.2026.09.18.07.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:39:45 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	tasos.papagiannnis@gmail.com
Subject: Re: [PATCH bpf-next v9 4/5] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Fri, 18 Sep 2026 17:39:21 +0300
Message-ID: <20260918143921.10931-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918140305.C88251F000FF@smtp.kernel.org>
References: <20260918140305.C88251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Severity: Critical]
> Can this upgrade to a trusted pointer cause a kernel panic if a user loads
> an fexit program attached to free_bprm()?

> Because free_bprm() frees the bprm object before the fexit hook executes,
> reading bprm->mm yields a garbage pointer. Before this patch, the verifier
> automatically inserted a BPF_PROBE_MEM exception table entry to protect the
> dereference of the untrusted pointer.

> By upgrading bprm->mm to a PTR_TRUSTED nested pointer, the verifier bypasses
> this BPF_PROBE_MEM safety net. If the fexit program checks for NULL and then
> dereferences it, could it trigger an unhandled page fault and crash the
> system?

I don't believe the fexit/free_bprm case can cause a kernel panic.
My understanding is that in fentry/fexit programs, the arguments are not
trusted.

The trusted-or-null annotation is only used when bprm itself is trusted
which is the case in LSM programs.

More specifically, the following program did not result in any kernel panic
and prints 0.

SEC("fexit/free_bprm")
int BPF_PROG(fexit_free_bprm, struct linux_binprm *bprm)
{
	unsigned long arg_start = 0;

	arg_start = bprm->mm->arg_start;
	bpf_printk("%lu", arg_start);

	return 0;
}
