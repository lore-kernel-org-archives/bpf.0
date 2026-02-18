Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA0E342503
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430502; cv=none; b=VgYOOZAWcZcbjOC/peb+8HKTWDJJFpHssca67JXESDr394QcQnVqhtU9uBbZgMwQDouTBv6GXBATm89/B3Y+FiX45XdxSb9opJfZQm9FEjEbAcz6EQvXCq12zJp7xP3z2DRwToFNh8a8Ebo2RVqGTPW3fVDkm2z52VqnRfGlesk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430502; c=relaxed/simple;
	bh=eZ98ZUWH3SsiXhkvREDZF2jEJjnRlvrsRr2Jb6qTzO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SV14GxKtQsEDC9TSi0+Te2hTIlHlLJ6a/jPDFODs2G81jZk0FPCKYPWAu7YZw1uldOqDvw9a+xQbrOqv7PGS0H5Pb4/XKh/hT3k6hU2axju/sfWZkbeXuweC+qYar6cEpq4jUmLCrb/0mPULo9a737JLuXV6ZscuTnz9ZvzlHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/VEvvpz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/VEvvpz"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48336a6e932so33771785e9.3
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 08:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771430500; x=1772035300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=opPAw072aAINaJdQwGNXoPXm490muRwZWXum+nJBw58=;
        b=I/VEvvpze8Hoz0JJ+Ka//1rhZZf0TLLVHmDP/GdpFUa1NS7DuQ/DEoNgfH+oXje7aX
         9u+zjcMybe2FmUmELzlLx0xAUbwumnwq+RyY/nGX+UYMT3walTEDklqv9mad2WDnnHQT
         xN7oNY3Jvr2ykHM5Hc/lUjR0n3m3PjynoVqEjGZoJQBdZAKG8+xFiMoY9TFISsK5Bn0e
         ey41W6/o69P3xlKirEuT3gc+ZcyfQ+tOSK6V1zeDbwxTFoCyFHwFIjwLB7cLkQ0gkInJ
         RT4J30EK9YP1EwjuPx0dCnSs9zLaDbxdU02MUonHR5BSquzroWHpgfeKgFVLn94bLzcQ
         EfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771430500; x=1772035300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opPAw072aAINaJdQwGNXoPXm490muRwZWXum+nJBw58=;
        b=j7o52K3k1ROlRlVlCS2p+9U+Igs6EJBNFeU3jYWesfTC4u/T2MRlZO8sy6+C+L+yfI
         QeyVRxNyFnPM4jsnT/3HEilvwCXgGAjI6O3a6RqnGjUS+rZGUQFpLQjZM1u22Fpovyxa
         LNXFfPt8BCsIwVRG/ak5myvuikIbgKaYO+WRyN5GfG4M7NTpUx8fLUOwMdRHPRbpHuF5
         anTJCGY/xjivVPuiWYLP0o9dXU9J4MGX7XFdIQ1Rr7I2dps7v4yJrhAQT1oWQI+vKv1d
         ShNF1NAS4wYQKGn03tphq5MUaZIwWKinYPQFLCl0UOCukxQT/5WBmhCz08WK7m1Y0YaL
         HcZw==
X-Gm-Message-State: AOJu0YxN/dooaK6Gf5iewAgld+8fvLpXQUtrzTE94rks+Rg4DyxkRqLQ
	NgFyrqieqk4yApOCSuXCTjO9kvDMoPzHzK+54A9/r88Qxf+S5y2SwGqc
X-Gm-Gg: AZuq6aI6GctGIsFda1FAy+FhRGXLcyz8MwXGFYhK0GRzt0BrpFVIhzLBDe4heyUatD7
	gMB1UEICRImZP6FiorpYBhXARBPALohAIrLpSicyLjuF4EAY91ZPF6adGb6+jqQiVB4HOpQwoOA
	IXkvp9q1Ri0PWpHOUTqB4XeWbXEoNJY1B96th0iS25PCq2UFBlWcI4nY2EWYKLzHoBVbybuR8A4
	xSf2PfOUAt8HgXHuj4OCSFUZCbeAAbk6OoSJ/dVkyfN5J9cYQY6rkcJ/4DZAuUNFgk+tJvYjmoN
	iYuY4v2yLcj54CxSs90RdME4Ajb7yo31Bz1jZ9B36PLTzyBWjjAQXstq49YKDWqn8Bq4hJJVPNP
	xatBERTgt8ewyGTrjVAFXZrrQgW5AVcY2zPdl/8mLrvxSYgV1WSx+VjolEWeTUOV35dDo5bbQJk
	EA6kLrYc0=
X-Received: by 2002:a05:600c:83c6:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-48379b93357mr217310415e9.4.1771430499866;
        Wed, 18 Feb 2026 08:01:39 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d834ebesm607698715e9.13.2026.02.18.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:01:39 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 18 Feb 2026 16:01:20 +0000
Subject: [PATCH RFC bpf-next 3/6] bpf: Remove preempt_disable from
 faultable tracepoint BPF callbacks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-sleepable_tracepoints-v1-3-ec2705497208@meta.com>
References: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
In-Reply-To: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771430494; l=1197;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=9r8VFZqxvVCWMWVq2MamRGM1ivT9jGAZqOGd2kSLiBA=;
 b=/1Fr1PM28o7EuuSAN+Yh1ntEAto5Og3D6ypOjEx6oed3bybVwBg/rB1aIl3b3AJxBq+Nq+6x5
 Ma/susDqZZTDwOb6QExY+LeYMipDpxCbBZd/8FO0KPeAGqfdthJJilg
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove preempt_disable_notrace()/preempt_enable_notrace() from
__BPF_DECLARE_TRACE_SYSCALL, the BPF probe callback wrapper for
faultable (syscall) tracepoints.

The preemption management is now handled inside __bpf_trace_run()
on a per-program basis: migrate_disable() for sleepable programs,
rcu_read_lock() (which implies preempt-off in non-PREEMPT_RCU
configs) for non-sleepable programs. This allows sleepable BPF
programs to actually sleep when attached to faultable tracepoints.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/trace/bpf_probe.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index 9391d54d3f124ab0d56ec57445cfc79baeffc28c..d1de8f9aa07fb76e9ee8037ce43099efb95b05d5 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -58,9 +58,7 @@ static notrace void							\
 __bpf_trace_##call(void *__data, proto)					\
 {									\
 	might_fault();							\
-	preempt_disable_notrace();					\
 	CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U64(args));	\
-	preempt_enable_notrace();					\
 }
 
 #undef DECLARE_EVENT_SYSCALL_CLASS

-- 
2.53.0

