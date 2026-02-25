Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA4395255
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036639; cv=none; b=rABme33++ioU1g6wdQGGFfFpL8GBgnvkfTYf31WXnDYnlbpyMh7CM42o/JaerwxWCiN6nou6AwgTpwsiSEGaMhmvYuGV2qC4Tjf4aclPK5eVwn7iMgk9+4PmM1nhDs7zru8GOLDIUSUzHdVETwxYtYY1qLCpMnxKTuDDkuhqPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036639; c=relaxed/simple;
	bh=C3QWKiwYCpQNFpyxEOJI+vQt3O9FoKqkVVXZ3oRDfnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gm2DB3IlLYgaCMd3DVZ7IzdC2ZxpatafJu+lRI5rb21J706o+ArtCq3deogqupVnCGwKgh5m0d/rSU4s51SUM3UAZMcmmbOoscQYt628aGQ9+lq21mf21lO9rUYMGqDLIuzRGYELUo1K2m5RDnsWY7y0j43ZdBmZNnvvt10hg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6e3cvuw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6e3cvuw"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso57924915e9.3
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 08:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772036636; x=1772641436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNoU+wp165QVxQDyOj4WazVIexpllW06c/gKdEXKdMQ=;
        b=J6e3cvuwI1WYUHPvksNA13TYJEDqER2Bv+5VvuVE7ScFIM0L0Dumq2+B49cHrbDbzJ
         tgTToX+NNF4euJUx0mwD2PvNqP2yrvE1a/E3fRMikTQW6R8daMyH12zP87t2Qf6COw9z
         +jEvTg5qRNokpIM2IZ1jLSMOfQNuF190tByYUKiyRlMF4MJivsEhdrLTKiMfsTjlORuX
         K1pnclkX2iHbo0E2++B7gLGE0eIhbkSLnX2+CpD8uenfzr0J0kbv8jT7GmQkEm6YTs50
         RgbNNr214F4B0WHqZVHDO4g5OqPJUp0jG0T3FYgpkmMpz4EdM0wu5YnvC7r/Ya2VF3Bp
         dXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772036636; x=1772641436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vNoU+wp165QVxQDyOj4WazVIexpllW06c/gKdEXKdMQ=;
        b=NHq2CgH7tGbYv2iPK/qbsiC3sn7onkIMAoP5WpfWs9bL5fDINWvyjwGN3KpPeer2JC
         Nn92EEL10ToBADQYyQaHEAO4uRNZ1gKVnYA/8RIPqu3gLZ2YzuIDBmfKzgx+Btlf8QoO
         fVpfC0IO+GZrZl/cC8Iww8B5Q80D7/Dg4wK8ecToTaUDzBqhA5QVrtLzDLq+yd4baxgQ
         GDLx1HJ8S1REZ2bCwO6e1qlpeOdC2sqwLALPDM2jgocc4+a1qFRY8e3pTa4DkH5F91Pz
         lnd576y88X6qGtxXeqKJpstFaAcr4f+rSz6JwArnlAvZYe5dgiehpqfBkYradIeL3y/F
         nDmQ==
X-Gm-Message-State: AOJu0YyExsNESVbi6W2u4zj4ZqpBnyUgKQT0n4gUWzay4fK7+dZJr0IZ
	axJ7CO0m6N4ektVgb5+37gvBo+AhO03sX3K1iCjX6GS7u8UaGhabMVTR
X-Gm-Gg: ATEYQzwm3ylOZ1e8Jyv0ksM0bFPSpIYqfDC3k29gsa4H93Gx5xEShsYIY8LHh3m2JC4
	lm3xTu0KPIa/CnE6QJP8ONSLMZyYsBaXaWBM4Vu0YuxpFC/xXjzc6sLb9vCjEgKkw5MH97ZjTWs
	agR/UiEW5rwunumm1gcHzAlzqnp6yQ5QRCCNynDPjIz4tsCmIraOiB9UBS2SY9oUv7lJnu3gFdo
	eNQJVsiT0y9Ft5kHKEBp/XLpwXeLTO5OEXSE5ZlXK8qa7sJyr8iPE5xmdM4oKjbn6b6JGEw6WHh
	lrdASnyC2i+IJ0SDg478QiKFlcPEoSKek6cH89Ed1P9b/llo6grCqdkagcCELZG2qs6q3iqdsNo
	kZhcdMMbdwm01Uu9eVyrrP/FynQ+kpNArPfmkXkWVg56d/dkSNQrTHzMdhliD/W20k2hKYzqsgC
	T5/aWzFiIJWYae2CNsfw==
X-Received: by 2002:a05:600c:4fd3:b0:483:7907:ea02 with SMTP id 5b1f17b1804b1-483c219ebc2mr17618245e9.16.1772036636379;
        Wed, 25 Feb 2026 08:23:56 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:49::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcb9b97sm25179045e9.7.2026.02.25.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 08:23:56 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 25 Feb 2026 08:23:50 -0800
Subject: [PATCH bpf-next v2 2/6] bpf: Add sleepable execution path for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-sleepable_tracepoints-v2-2-0330dafd650f@meta.com>
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
In-Reply-To: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772036632; l=2270;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=zyNDRGE2dKauL47MMhg3aMXQev+TDOSHhJuYl3aYgfU=;
 b=UlVRgygdCUnvtINsaJoTbroEvRJIO9JvFfstuOB0viT0lMI5fS7TbT0dE3OZRfC0fbEnvdAEo
 AHQNev6yy5JBDCEDiHlmU4WuawCBJtpBn4ngYi/tU7S2kFuU8bjRB0x
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Modify __bpf_trace_run() to support both sleepable and non-sleepable
BPF programs. When the program is sleepable:

- Skip cant_sleep() and instead call might_fault() to annotate
  the faultable context
- Use migrate_disable()/migrate_enable() instead of
  rcu_read_lock()/rcu_read_unlock() to allow sleeping while
  still protecting percpu data access
- The outer rcu_tasks_trace lock is already held by the faultable
  tracepoint callback (__DECLARE_TRACE_SYSCALL), providing lifetime
  protection for the BPF program

For non-sleepable programs, behavior is unchanged: cant_sleep() check,
rcu_read_lock() protection.

This allows multiple BPF programs with different sleepable settings
to coexist on the same faultable tracepoint, since __bpf_trace_run()
is invoked per-link.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/trace/bpf_trace.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9bc0dfd235af..2dd345e0fdb0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2076,7 +2076,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 
-	rcu_read_lock_dont_migrate();
+	migrate_disable();
 	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
@@ -2085,12 +2085,26 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	run_ctx.bpf_cookie = link->cookie;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
-	(void) bpf_prog_run(prog, args);
+	if (prog->sleepable) {
+		might_fault();
+		(void)bpf_prog_run(prog, args);
+	} else {
+		/*
+		 * Non-sleepable programs may run in the faultable context,
+		 * do cant_sleep() only if program is non-sleepable and context
+		 * is non-faultable.
+		 */
+		if (!link->link.sleepable)
+			cant_sleep();
+		rcu_read_lock();
+		(void)bpf_prog_run(prog, args);
+		rcu_read_unlock();
+	}
 
 	bpf_reset_run_ctx(old_run_ctx);
 out:
 	bpf_prog_put_recursion_context(prog);
-	rcu_read_unlock_migrate();
+	migrate_enable();
 }
 
 #define UNPACK(...)			__VA_ARGS__

-- 
2.47.3

