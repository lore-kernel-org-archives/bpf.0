Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671035;
	b=JzhiISWZaO7GJTZO2G7S3gTb6hNn+Jx+9c4ippOBtPF3e90LlhtduXekOEJjM5ayhQr/
	 JwxKATJRD0mwS4ZLYP+HTpsZb5YJnYjFGfMjP2xYrdkmxdD7sdts+DdDoA6zGRXHJ6G7s
	 g5id1qWmfDOhHkpQ2WRkTe+NLCAbPA6JV1kTDj++bNl69idCl4HReuRd+n5pZDYfMHdiF
	 y1IWt+QcCrYrBkyFv8URUiEEYQu53eY6SwxnwVoRMDUBhmkQ/FfDdLKxCKy/EJCG+LQWe
	 z6h0Tbq4/isV3BQ7DosV8N52qTgugsnXmfoMR7KZ6StUJa3G556PFFjw5MmVZ9L/n3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=u3D6JB/pv0rrXcWwuSv+aY8D7iPNeAwX6178znatTYk=;
	b=UMngWPpDe7Mj/B1pc3VXc5ChIhnQdx1rIF09h3bsS1C0VMiGz0TY5GN7Fdb5I+OBblG7
	 +aN2RHDfrpwaTTp8bk6Q9JlqnrdmUEYA66CubENcfX2sdpvq3Td6pBqCO0SgWZHYKAinu
	 Cz2xA4RKb2x0577bWTCVejGkF6/vin9oX1OoYWWn65LdHirSbfKOz6UI+gXagaJnT4tKw
	 HiZCp5lpVc49ytPmVa0lJbzu2Rp31hpsaCzYUtwcBGrlFmRPcaHEUYkep7tEF8e0LB/Kl
	 6o6usB6qdgruUt4hJpWjlyCy/AkPVCF+UwXF0qOZyA7mj6oYoJsDQEuuG1gzPAl3nPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cA4curFt;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6322606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 05:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6322606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cA4curFt
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so2674348b3a.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 21:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671034; x=1796275834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u3D6JB/pv0rrXcWwuSv+aY8D7iPNeAwX6178znatTYk=;
        b=cA4curFtIR7VjacFiL2BZHMdzikp3eT89x0fZJmHnvbPZm1cxyN6R8/32JFr/cK8p2
         bW5D4oPVvxtTC6dZ2Szz/qWDyL6RyMPXF4/pknYrQGcTePSFb+RF2vJklgG1tf/cs0YD
         e3SHKsYU2tVCjzIWs2hjksKWhyit+VnOSPNO8aup8bGJxXE5BeFwlgpqM04VD3RuMjgq
         QpwiUprzSwIypwWNnCDJnYOC0vvTKq8eZeWDd1LsSfk8gBIiJg5b1u6QT08T18ujSi34
         ihR8sUCpOsjXnU3x9a9baGXLLOtEZ++lC3XE2aGcuBa3o91yPHOJgCvHN4UQxqkIdL0n
         LD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671034; x=1796275834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3D6JB/pv0rrXcWwuSv+aY8D7iPNeAwX6178znatTYk=;
        b=cxfUn4HaxJOyIEyTIzXniBmnmQI9FxS7VrAwBnZpOdKIUk0C9wlZC4S5jD6NiTSTGf
         3qkJJQ6FHywWr4Q2qcrhPqLPbv67eh0r1xGgnE8OKSw5Sc3ygb3aqOhLdtzD6OitgpqW
         +ML3SJi9Cx3AjTeqymnS4JjiqjmMvmg5+jrgd36XP2Dj9tMFs51iM1J6I2kOmi2EkG56
         wq7Elv3o4d+y/h6BVPGATYtokfyL3FG8Uh89IB4A+9R9o4GTNzpDYSQObQNHgYLarzlm
         AGT1edocS5jaBLSi4rVHLNEMjUCDt0z1xlzYA830qlSkgGohopjNUkB0w+c/gXr2JIsQ
         Lx3g==
X-Gm-Message-State: APuU4Z8SVRb1tC7Vj7HKP/iI68OhGmIrAUuYrIVlPeFuBuph4SaaKsOH
	2eW0pxg8YTh5cTLOW3enj8fi88uOzhM9HnpGG47nMWa3gvtpuUA77a6OG2bGqg==
X-Gm-Gg: AZFdTZdFy0sePiM37OxcOjAJ41pyJ3NZXWwZAJKYgOTMKNAppHDWIiyaMr7VYBrN01i
	aVGU5xTkYNLg/OgHwd//sVBk1RHnjehkuT/JSWUzvomSTp/17lpk17MjHlga5GjsJXSULrsvc9R
	b3Ejsp9ahqhKoi83M9tSGZHw0CJxik3nxbfEe/JNrAI2RYhoiVfmNUib3ghc9XXkympwPfVV0ZN
	BeyNQyrliNGJGBO3ohAxXFaECif2R4HRjvnazL52oevknyl3xPoPWALPYGGFKobbdjHojqJbztR
	RColg5h4a8D7ykzN4ZROwpSrrqvU1ZO6GUcY1teo0x+rIkTAgBsj3+BGhfnca0aPdAKKi3w1j+K
	LkXmLsJqXBGPd8CisCvjl2MT+1eqqthQ0nWoiyX4eB1ZJm/LURTSXgkGal+B9+WazbnvBuM+hyR
	D/vY6oT7i5qtkLwfOgUgOeZUr05a0Mw7BQAyx/4PRw227NoUhjpcI+LzXYODm2B5SUUp/iGvptR
	8zMTDWzF4TsQVeWXK0nQ+TUefk8O54RqmlLytCZhT/hfAa9+yigEyLW2+HaQjSGujOImc36/Eq3
	icmjkT4SycJQRMCz+PbZBqVie9I1Q9cvu4RXpq0oXj7JRJMPqrA3SEkLl6rES1s/
X-Received: by 2002:a05:6a21:7d0b:b0:40a:4e89:ede3 with SMTP id adf61e73a8af0-40a4e99315fmr706550637.79.1795671034056;
        Wed, 25 Nov 2026 21:30:34 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c29sm9961429a12.1.2026.11.25.21.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:30:33 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	yatsenko@meta.com
Subject: [PATCH bpf] bpf: Reject kernel threads in bpf_task_work_schedule()
Date: Thu, 26 Nov 2026 05:30:06 +0000
Message-ID: <20261126053016.1145482-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
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

bpf_task_work_schedule_signal() on a kernel thread sets
TIF_NOTIFY_SIGNAL, but the thread never returns to user space, so
nothing clears it and signal_pending() stays true. Interruptible sleeps
in the thread return immediately.

For kthreadd this means spinning at 100% CPU. io_ring_exit_work() waits
on ctx->ref_comp interruptibly, assuming a kworker gets no signals. If a
prog running in that kworker schedules task work on current, the wait
returns -ERESTARTSYS and the ctx is freed while ctx->refs is still
switching to atomic:

  WARNING: lib/percpu-refcount.c:114 at __percpu_ref_exit+0x77/0x110
  Workqueue: iou_exit io_ring_exit_work
  ...
  BUG: KASAN: slab-use-after-free in rcu_cblist_dequeue+0xd3/0x120

The callback can't run before the thread exits anyway. Reject kernel
threads with -EPERM, as bpf_send_signal() does.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/bpf/helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index bc0dd36a2799..42f3f7599567 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4806,6 +4806,9 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 
 	BTF_TYPE_EMIT(struct bpf_task_work);
 
+	if (task->flags & PF_KTHREAD)
+		return -EPERM;
+
 	prog = bpf_prog_inc_not_zero(aux->prog);
 	if (IS_ERR(prog))
 		return -EBADF;
-- 
2.56.1

