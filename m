Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017722;
	b=ODCndQaPRR3Nu3q/8eoMeH2AzA9bXpuywDE6c6P5OmXsx3lrLHLWO802VLFpthXkO1dZ
	 qoVW4C9CtotD0f0596zw/wEC2U6VnCDGrDhv5emUzledQ+rkhAKIocJ034T+TmfyDTuak
	 wt7Oi2FYgVH1LiUkZXsV54/mY0SMwdBkdOxqpqR1+4o4NivQGXti4u8s0h6yhNmjOcRoj
	 Cu8uVRzbEyAv8oFuZ3YPEYaPO55SCIWdSLQwxz0lk5Ev4tdgR/EN67z+8Rv500bKBnWPr
	 to/nCmY8sAdkt474frstUyeBzTMPwJCntX6OeuLd4Axa4kNBmTpDg27CnUtLzdyyW2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=STcyX3m8xxFaNUr4S3s1ec/7BuFxwi0Gt4EVxDhc2s0=;
	b=KntnsTC7KwKO15OLGa0ClSnN/XChlbM7bAPCGWsPI5sGC7J8gSblRE/DpEdDzm+b/f4v
	 piregKEMEKSt5lN0NTq0furNV0jbwMcPZuH3rsD/aa+kvDC6KRMsQTjYG4QA7Iqnyd5m2
	 xiDa/DhwGq2b73DC4y/yg4tH8kkdtf6oSwRu+g8Uk5fxuHxwqfclxmM/jn7qNrCvDTfh/
	 +jBoRc6x0D9VDVJMpnAhYLIj+Uuaw+QbClVzb4G9/ytMsb0uruGOfYMOwHqXqHFDahdMJ
	 30GZF34IhskKQ4eMhuieZpv3hdw8RoKZogN12OifI7Ic4VmVRdL6Yy35119E2zveMCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fOvsEboP;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1832606A330
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 02:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1832606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fOvsEboP
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so12344225e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 18:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794017720; x=1794622520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=STcyX3m8xxFaNUr4S3s1ec/7BuFxwi0Gt4EVxDhc2s0=;
        b=fOvsEboPOXzv2NtMebSHBJWYELI/Lhy87yEJT+bblgG68i/+nZYejm2bvGtN5izakn
         sxJetVFEdlGXFCrnrEG2RKfMtCIrtP/oqrX9CU0jwP1+8zv2hCyUCHwNsiUj3R4XV3K8
         KaEi8vmYGaabZWLw1zYQya9csnBVPraRG8SlvbjwQj+NpAex3OOpdvL7yLCv+uQGoDKL
         0X/Y+GT4UDUu6KlQaEyiSQJOqTnXRlziFeFWi2poYeGEke2LvL1FmC7AZI522IA0Hp7q
         yAxEXavkDuJPNZvoD0Xl7hBVwCW4KcwrbIQ1fVenUfnFOhK9aWA4qcG9yHbADU2V0yKC
         uN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794017720; x=1794622520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=STcyX3m8xxFaNUr4S3s1ec/7BuFxwi0Gt4EVxDhc2s0=;
        b=rxg7alHxRPMHhjYKLdux7ezmh+yBwSe3idCnaKFKhdmA1f/TZ4ybb7LEeqW2wpOk3y
         ZBvheVhZbGTa72KZ45TCp43lHzqgOJILIrOXAewZd2AiOqPKP0MsjWP7XZaJFZZxlvnu
         5TGude8mPpFpYvVF0KxNGsnpsKlN7rY+dN/g7KWdFqpy3AqWX3Iy4zqWX+ZsvP1X7yY9
         Qi6HTn/HfWnbnegd1aZCGWhBvbm7u1J0Yr27ZpcK7hsqN5sBgYEsROtWZUTRmD32OAxY
         i9Lq3hsw7BDmdChWtwSgCA/O8rz+pk2nJ8lA2EqEJhGbOUyQvlsv9kPa1mxjf8nqE6t9
         dbTQ==
X-Forwarded-Encrypted: i=1; AL+hErGXm5tN6Cbri7+4slrGjTirJIm7NTv1fihZUpGdcs9646jy94GHcoJCPKJxgbGOrJSnFIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8839FMynK7QsaZVZ1+hs9URJeh/+rJcQV1t/Ym4Bg4/aou5Szy
	8Len7BNOCsCRrLSc2wmwXeHkdfjan8Nji+F9QVDAsqmqxeHAuYDCT7+A
X-Gm-Gg: AYBFou3bYxXhImBV1b+pd7pGB4n1SUdDeDag7g5R+Ee164orVOcOwBBOMWTU8Ssa5Lb
	ckECiPMoMQVF2XlPLpOsNeV6Hx+D79roivTpDamdigU1vtxsoBFF8G6Aw8/hLu9AJvF9Zq+LpJf
	hyrzwj7yg77BA/EL6t50L4aSMg0Dkeu5NDc4pHBpr6tV8NqbuKJ8+unebHYxnLz+nnTa1yNraUV
	Ch3kIKRV/WOhl84iWCso9vEn0vbA7/UBRGgpeupROA9kVgTReaSe+lXiNpD9EISnIhzd1bJv5yJ
	1c4ffpamjCzmmgDfCq3ehSys4aV51nByLg4QWuIJbkD16f7fCpv+Vqy741BKbOWLT2W1h7t4MhP
	Ljo62vUFTLg4cbZ2tJiBBuhb/F8BD9nVYyHGrd4905FZmb8LPN765EfmFwJADccbrbfL1YrD7mE
	HL5K/R1t56O9ukiZtuUldtaieiUF2sMSAIDAIoT25P+h0BQ7DeYrxhRGGRZN1qdlhp2NJR47Vu0
	SeIrLFlkdqIaYTAGCwzjra8YR+JsoGhsIUls8cD12BT8mIDOHsmvQd1VRfskAIKh+WJNBmCbkiE
	2snrpqX+ocE5X5kQx0SwbZJV88CfMcBlyRLALCkI4IrOgkMD7IX5nMNtStS8E4LV4qZtjfOuaWD
	9b+Y=
X-Received: by 2002:a05:6000:4301:b0:492:b948:1576 with SMTP id ffacd0b85a97d-492b948165cmr7641858f8f.18.1794017720351;
        Fri, 06 Nov 2026 18:15:20 -0800 (PST)
Received: from localhost.localdomain ([86.124.84.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5f11sm6367449f8f.49.2026.11.06.18.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 18:15:19 -0800 (PST)
From: Radu Toader <radu.m.toader@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: tj@kernel.org,
	peterz@infradead.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add scx_tickbug, a scheduler that holds a task on an idle CPU
Date: Sat,  7 Nov 2026 02:15:09 +0000
Message-ID: <20261107021509.968928-4-radu.m.toader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f043064ddbaa8d0c3bd479100993d6f157076ed25b1ab98b78c05bb2f1effae8@mail.kernel.org>
References: <20261106094343.174905-1-radu.m.toader@gmail.com> <20261106094343.174905-2-radu.m.toader@gmail.com> <f043064ddbaa8d0c3bd479100993d6f157076ed25b1ab98b78c05bb2f1effae8@mail.kernel.org>
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

All three are right. This patch is dropped from v2 at Tejun's request,
so none of it lands, but the fixes are worth recording for anyone who
takes the reproducer out of the archive.

The starvation is a real bug, not a theoretical one. tickbug_enqueue()
routed to the local DSQ only tasks with PF_KTHREAD and
nr_cpus_allowed == 1, so a user task pinned with taskset went to
SHARED_DSQ; task_allowed_on_cpu() then stops any other CPU from taking
it, and tickbug_dispatch() returns before
scx_bpf_dsq_move_to_local(SHARED_DSQ, 0) for as long as nr_held_now is
non-zero. With the hand-off you describe that is unbounded and ends at
the 5 s watchdog, which contradicts the commit message. Your suggested
fix is what I used: dispatch anything with nr_cpus_allowed == 1 to its
local DSQ. A task pinned to a subset of CPUs containing the target CPU
is still delayed by the length of one hold, which -H bounds; the comment
now says that rather than implying the case is covered.

The sleepable comment was wrong twice over, as you note: the op is
declared with BPF_STRUCT_OPS() and not BPF_STRUCT_OPS_SLEEPABLE() as
scx_qmap and scx_sdt do, and since 136deea435dc bpf_task_storage_get()
allocates with bpf_map_kmalloc_nolock() regardless. The comment is
dropped rather than the declaration changed, since nothing here needs to
sleep.

The README now says the scheduler reproduces the condition
tick_irq_exit() handles and can be used to check it, which also matches
the past tense the BPF header comment was already using.

Disclosure: this reply was written by Claude Opus 5 (Claude Code) and
sent on my behalf, in the same session as the patch; the patch changelog
carries the same note.
