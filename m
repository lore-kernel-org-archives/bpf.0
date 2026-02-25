Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AC392820
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036640; cv=none; b=EqenPgsVu0efWP6nvSVvroBji0cXGB2Fu4WjGuFyHGCgdkgKKEN18mX90U3s7xvPDE9o4eXAnWcqmiwaa0tbHVYHxvDDh4dH/wNlGgQ+vJ/Ih3XIF8yGiVu1BEwkJ9PBV0xAZeiKldurC7o4vh0NYsRAOUVTw3NMEpaQtUH70tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036640; c=relaxed/simple;
	bh=c2JU1JWYryqQEGY5aDIvPL4+FD0ZnzAk3sMpEHx/5Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGIsNo1vXzEYOGLZjymzkd3v5FmCIWC5Wqo/WSiWRPQVSuxDTDUwsNM3C0Cs7prCc0peuI4R6+5edrC9hWphWb3gFAoxUQtEpU2cC/AAUePCgpoFLSuwd8IZTJ+EkAtpDk/4+iSRC6wsqzFaFOEB5r084sk5lPHhJzZHrBS8/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiboCPzi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiboCPzi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48371bb515eso87031215e9.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 08:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772036638; x=1772641438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KM49WUOt9BXRV+BysLSr+XWxVTqyWLEvW/rVajlDu2o=;
        b=BiboCPziywPAser/AdvidfTfFYXP4LRjNDSW2CuzHzD5AozPzrmARtfOZKD69K477J
         ZPOI/ZJZHSxasb9eqrSQPzhOgJfFeOuqTowgfTffy5zbVKDovB00xxEsWvUY4RHx3AuO
         fyFYS6J/KOC/3GvWTEdKPNivgIzmV4jnKu03Z6ggaIqkgIFZ85gpGMkiX1zS3hI53k9t
         NBB3CBGtpEqGydBNR2uh85iTZBxzheYocZY0bRKV+JIyZHo1K/X9qwc31mkxjvGV2nNV
         lzD1HgN2nDIhvWrlk61Fdp5kzXKE44t9H26gDZDjsXN7BW/ycd+QLNSGuvT+ONXziUBC
         3Kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772036638; x=1772641438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KM49WUOt9BXRV+BysLSr+XWxVTqyWLEvW/rVajlDu2o=;
        b=G9RIeVXerA2vLpkESVT8sHKEI5j3ODgAr5jwes6R4Qac7PcbKvjyMrFVKKkvdKp/hm
         QR3VcG5105p9mhRgbZ7g8leYAEO4RO95BU2wpkzcZsDopD5UpjabYm31wjyjQs/ecrFg
         Tfq0W8Kf+fBsFpypieLOsI3Z0zqV0CKPzOMleCbAza/lU5dydL+6LJXKLl2VApz76REP
         6Q4fX6ghgbnzlWZydVe0wUsb8vnNd3hatU6UARVUKthK4mowcyJ0dUuyQGxyFPhOoECw
         99meUdgBOVmvszI2ugNkZ28YL7HHXdEb5PEMpnLyHz6yaP7mg9oQoFewkA7BGxJPmEy1
         xOWQ==
X-Gm-Message-State: AOJu0YzjRnGpDWeWdanFGa5QIsutcJXEJOFd6FYOpdbCbEdBiDLGKDbq
	DShMKju+K6oj8j4NYax52pru1bEI+aOzJPrGALmBN9tJxHQ2RwQRFa2X
X-Gm-Gg: ATEYQzy/SN2XAVC7Xutjggu6WIy45w3gBYzoP0b6+q2+WQ34Jq0nco+W3gMJ14pXiC+
	z8p2fyhnS7ywFyrDcWorYEcxpO7jF4RTRttHkLCmVNfH+bXpFkzazVoHDVZLdC2NFoh6JiGutGd
	U+PoHLxw+j+lJsjIrCpsgDkGqhDCKE0Q6iAbv9hv8jMkKCSRAYp4XJ2l+Vw76uCxS4MXA1ZVinu
	RzIP6mkStXhBq1npQTXpe3tZ8tYRfELjnt/RIyUePKP/7rIWzQxjmERo4VEdgM9PKEIh26XAofm
	kK02/8Zv1tWDkGAVsXaosXZFWHHo8l0u+eE2scT+MGeajZGb0bxWGhC+dP7mXzf094LUgXbk0Gw
	dM/7GEOh3udOTSOri52lFr9gUVsSw6cT0DPZJH+/BRFyUgfkdjHc0bpImbRnIeK1Tn6T/fqdk/K
	8aYDo/hMkqbvS/nPXOc30fTOUGkton
X-Received: by 2002:a05:600c:1c1f:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-483a95eb50bmr324417055e9.7.1772036637716;
        Wed, 25 Feb 2026 08:23:57 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:53::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398a292babsm11185051f8f.37.2026.02.25.08.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:23:57 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Feb 2026 08:23:51 -0800
Subject: [PATCH bpf-next v2 3/6] bpf: Remove preempt_disable from faultable
 tracepoint BPF callbacks
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-sleepable_tracepoints-v2-3-0330dafd650f@meta.com>
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772036632; l=1141;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=9cRf2RbFpuFLx6WX3j3dgSF3ZBmL5lmds0ngIwKUCYs=;
 b=HR0qlkQWwNaVXblDGc7QjU9uFzZyojusYNa120Qn4eS/FMVA4LmMOh+gDGU1Kd2y5G5u0k6GM
 XE6VKZPjd96BecwHvt3vR3i7czSfaQ4s+6a0O44klscVDbEYWSLQh7y
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

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
index 9391d54d3f12..d1de8f9aa07f 100644
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
2.47.3

