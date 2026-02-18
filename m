Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AB934405C
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430504; cv=none; b=KFAHJkpsuOAXwlVzTM+pEG0n8N2ZKt3nwCV/8tMh8GOrG3+SrpaEYdKAIv6NcUxDdsYuMbteoXMoHhaPdNbNlAOEf7froLBwGBLMwDP/Ipy2YdYdo3cMMSQOvkQuidKnW4NPn52grxGFtZaGBQEsCxUIHM5BSF+OlQ0lXUuhjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430504; c=relaxed/simple;
	bh=g6G8AmdFH0+j8266JJZ1Wvj17bB7iaCblOKx69vF1fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFqM16K2Mxyqz1q88acKJojTfmcHzBSzHvMN+6A0y6DHmn8cDVFcum47+vRMA40b8BYYVh9ZqesGJ1Cu5c9jVGisetbC9kHLBoBTlrDqq8OV8m4Hnb94uWLH/hXLnRjRxeOaju+N/1x+nsDQW6xXZ2BuHpEoixFtNMOb5rFjPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKVtXn34; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKVtXn34"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48336a6e932so33772005e9.3
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771430501; x=1772035301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWeOXyHomaM3sPRyNLrucBFUq/EUmMilVGkSTxEFGeA=;
        b=MKVtXn34C+on1BxiVv0sqVhnlFQhGnSzbajNZm4Jyl+Z4FAudZsUT7S04a+OJTz2fp
         jZmAd8Wbrtjest7dql1KiCOJhDjxim4tn6PILe1lVynNRMJnu0RVeFvJXIvHHUf8i+Dz
         y9iQpR0Y2gqFsWX79BGLc6dqdfuLt1et/YN9I7CLCg7lVKUm0DKn9Nty4iL0BOLkpbZh
         xnqphwQqzGeimNAMRyAVp/zXX9fcb36xS4YOvkVr7JFoCdv+HLLWSnzvve8jtKzJR3cK
         HT5/+HMZdgDxV7PuqHSjX9ZXyEd2VFecpPe7Xp/EmKe5v8+HrHG9h1d6FHmT+xz/VHx1
         nrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771430501; x=1772035301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SWeOXyHomaM3sPRyNLrucBFUq/EUmMilVGkSTxEFGeA=;
        b=XC4K0FjU8sBFfuZ+iOgqs4TYjUKGfIfjOw2itjmuQQzmuU/G7F0MHkdDX/+PFgM276
         WW9b1PsA2X2dgPCeqyTDqcHpyl6II38pgLdxNWpOtFQmkQuCZlh5n2T1SwcfVbTZR7qP
         SbATiGZN68zdrYt5M384N7nFwfS1YjX7+LDnkl4F/ZdUUJ4M/t65eJdumjreBYufeuom
         LQukJTpkqUCjyDOu6Blj4bF6QCYI/KRMQ1v2vE4wcTp9pxpFuLXkVFQVjWxpUM9UHiQK
         tNjDIgyAz7VCdMdjtAe6534kbSg4t1BmSaUwoEugksawQSw2Gpv2B+YYyM+MYMtJtcKp
         +ljA==
X-Gm-Message-State: AOJu0YyIrhW3wGlDh1DbnLwRF+OQ37Rg2Tt1524nRZJY4qmPkCgw/91a
	Yj59DTGQdWChHnGL1uBrZcsaTdlMpPqGuSkZK6oAauieJfxCXAswQEC2
X-Gm-Gg: AZuq6aKWIjDBKaj1JMC9IOgUpYITu45pxAFooQIaqll/rF77onj3RH7ZpRFnnlpNnCR
	FrXMeYy5BtWvpGaHVKWx9qBJRn0BWw4vuvPVzpEP0xjra3kz/H3ZBcl2/phPPZixy0B35iBflEz
	PiJAUhiyoo/c9HioJN6qD9Ub6ekr5FH7eL40XDR++UUlcvxdU9Hv6iYtL+lyrup3GHr9p1aOrdU
	YvdthrbIzxJZwv63FS6ja7y3yjS8Nts6D+GQzivTCx+eaiFxBQ6TerjQqVxkysZ9CBo0RIgdEDO
	HN8kgLVySZUYz5JjqxG0p3vUfrZMsk5ALvuWeNZQr7uHEQ7kBdUsXRo5PqbjSxexHsvRc6prGxU
	2Puvt6wFzlPlv0IE0nIhZ0YDZl1a/tGYyFyw4vr0csYZ/F/AQupZUynfKu2hoawOS0qWYvfLzIn
	4JvIDUtBU=
X-Received: by 2002:a05:600c:1c19:b0:483:5310:dc67 with SMTP id 5b1f17b1804b1-48379be817cmr289626435e9.20.1771430500853;
        Wed, 18 Feb 2026 08:01:40 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d994670sm479276565e9.4.2026.02.18.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:01:40 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 18 Feb 2026 16:01:21 +0000
Subject: [PATCH RFC bpf-next 4/6] bpf: Add sleepable execution path for raw
 tracepoint programs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-sleepable_tracepoints-v1-4-ec2705497208@meta.com>
References: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
In-Reply-To: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771430494; l=2327;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=7xikHfBb4u5HnYA3fvTxvJjv6Z+KFXp+Nr5Da7egqJk=;
 b=LH0ptm8fgk3I72nuEWeuwdyjNTTwh1p61boIA3ZqVqbeHqH/5afeuUcg6KGonXd6iZNrZxZkq
 Y3db3rIVTZZDwQylKbr1gF+blWWMLMfo4jG0cEPA9TjMnA+YNuB7qkX
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

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
 kernel/trace/bpf_trace.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f7baeb8278cac8c4f93bfd62469dab26586f4531..6ac9f2dc36549269937c58f4d4add244d7739edb 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2076,7 +2076,8 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_trace_run_ctx run_ctx;
 
-	cant_sleep();
+	migrate_disable();
+
 	if (unlikely(!bpf_prog_get_recursion_context(prog))) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
@@ -2085,13 +2086,26 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	run_ctx.bpf_cookie = link->cookie;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 
-	rcu_read_lock();
-	(void) bpf_prog_run(prog, args);
-	rcu_read_unlock();
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
+	migrate_enable();
 }
 
 #define UNPACK(...)			__VA_ARGS__

-- 
2.53.0

