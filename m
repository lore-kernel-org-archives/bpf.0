Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357C334C09
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430501; cv=none; b=pIGxN88QoMM1eVaeef72H3JGnL0+M/DWlGRjftP/RGVJKrHwrTHCtWNYjxAU0b2PnWKJy7H7C0lvCbL0WJLLcbgQbQbzYetpw31apMRBQV23xdHF8NJWzQLt4lxABa0OvyNQVOxfMf2XnOLra8n9OdoJqf4NWsAUwQfDw6w9M20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430501; c=relaxed/simple;
	bh=H4CuRR4VgTObrluSIbYmRUINTFA6uOTSNj5WJ+dHHzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6FjIlcxCuJTK69jVRcm0inlvoxLiWMIaynfrVZgD3xrXXIGayZeptzbugrqDMMk+0Cc3h6iT9m4ZGW7rGrh2oTrfY1ZxsW5eUiIedQaJ0yTtmIpzXNlXG1gwuckmFUiqMEKB5VwM3K35FGLkpl2qOcDZA0S/TzgCKQC1Muz8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ7gmsiE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ7gmsiE"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483487335c2so51443285e9.2
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771430499; x=1772035299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6/R+cnzKq4YuDjNShEB5R+EYp5ks+twiHDV5tOX8xc=;
        b=VZ7gmsiEsYMuZOUaAhu4UvHS6Yy/5Njr2pEZThF8KcbGfXZNUfAzZ3WzMBploRL7/a
         30vaLXbUZbjYYM266H6TgJxjzm+uho0tyjrGLPWJpAu5/ukKf2vXpPm5+zNKGFwvpCBp
         /TAPvBJYgDFs+D/aWrw4jPbAGNgfq4HEmdH5cqZbUSy8H0cvEeWnM6FwJEgHR+QDPX0Z
         yGanbiU0bAJvuz18BoSyuAKW+ANdCGpx/tcknhPKhqX9ESCnRdB0vC0d2SXYyIveTPBw
         zSLzrzSETNoHHYy4iflAWpanOUc3dzSNpVTg7yBqzVgujLWVZCT0ZRCEpAdTsIrbnK3O
         szuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771430499; x=1772035299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E6/R+cnzKq4YuDjNShEB5R+EYp5ks+twiHDV5tOX8xc=;
        b=AJKrwe9P9bAyEoTZ5HeqaVsp3Vc6rhC04a9jfIMVmmucOKJhV2K6ZljEzWkUbfBsTn
         bmGjp6W69OzZ00lGHzn1QQH/MZaqyPDXoZBEBsYCfNIq8lgBBHBfyOVWrLKF/L/t1umi
         AwC4ZbCI8Y4nj8XZKjCeam3d1b1NeEgGRpEwmEd4nUP3jbSlAM07CZolZEpUtm/CM7PB
         9K3qzH/XGIqA0HNcn13zHJOOA8Cu2atB2yeHY5egfihfJUQkUjfWi2ZJd6DA/vAoTL15
         QYci4B6MD+p7ZCBdwDLcaQMVBZ/sMvzKTlzNjK5QgOgKCtOdblpk1o273Nt8bWure1yl
         9DYQ==
X-Gm-Message-State: AOJu0YxHuVLKwmxRyV9PSftQfeszpelcIRz4W/7TOZJk0qlVZRnZ+U5O
	1RLiJEDCtNTe0fR05ks/EBL1Y7rULo1+7wjHWSZZ51Vq7zrC2yDQIoPN
X-Gm-Gg: AZuq6aJ1KuIkDS8LTSw7SqWrf2Vp60OL2KDs210Ls6tur67mKqaur7GBUfMPFbiEtF9
	bVizZaZput4mN70TjLqldooFtqQ9WTIN1X5u7zyTmaYpKjiHgMckvLfagxo8GgbQzUD4hnrGmdz
	IKbHR/pes9W/eLEo7xkf7YIQxyYIc3E2Nh/j91W4O+PIkCwf/2CLOr/Uql/bVe4R8rdWG7b4YpP
	eUoNBrMAjKyZX8636cAy3pKF2Lpv18MRJn6EFd273wDtZyTgfFlFgEMw/vtkpch54MaVZWA8sFr
	pp0Go5oov4/cCNxZZhKLzT6eHZmkb3mixzKMLkuuHz8YkCT82AVyvwn5XIBqQ8rDYE+dAb3E62F
	++WcNobnO/zamKRZCjfb1d06asf1bTRKyhM+7qXjGqhyCOzPkA4Elz+DGuIBMdxrcsgeyJDAdTj
	PseFLN8d+qVYFX2G7h3g==
X-Received: by 2002:a05:600c:8a0d:20b0:483:78c7:e1c1 with SMTP id 5b1f17b1804b1-4839baa7e29mr17554265e9.12.1771430498749;
        Wed, 18 Feb 2026 08:01:38 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a78c89sm415857615e9.5.2026.02.18.08.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:01:38 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Wed, 18 Feb 2026 16:01:19 +0000
Subject: [PATCH RFC bpf-next 2/6] bpf: Reject sleepable raw_tp programs on
 non-faultable tracepoints
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-sleepable_tracepoints-v1-2-ec2705497208@meta.com>
References: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
In-Reply-To: <20260218-sleepable_tracepoints-v1-0-ec2705497208@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771430494; l=1133;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=nk3zyURxWC9Wu716g+e2Uq0Tvjt8EwOdzZdiHS1s3eY=;
 b=GI6H3bHJYvIfGshWmqjsSxoMiWlNIAMk/KHPtkvHAom2fcdIaSaT7KmTbN0DXOsKzPuoUxG+H
 53zqrJQpQNBD8NPSs0bmmoi3/9WjM4gIDw7Y3jIxMcP8AA/l5YUq1H2
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add an attach-time check in bpf_raw_tp_link_attach() to ensure that
sleepable BPF programs can only attach to faultable tracepoints.
Faultable tracepoints (e.g., sys_enter, sys_exit) are guaranteed to
run in a context where sleeping is safe, using rcu_tasks_trace for
protection. Non-faultable tracepoints may run in NMI or other
non-sleepable contexts.

This complements the verifier-side change that allows BPF_TRACE_RAW_TP
programs to be loaded as sleepable.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/syscall.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dd89bf809772501c109789b39dd5f58f688354e2..af6c93d332fb70a8a14d7768048000b0b7f34650 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4261,6 +4261,11 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
 	if (!btp)
 		return -ENOENT;
 
+	if (prog->sleepable && !tracepoint_is_faultable(btp->tp)) {
+		err = -EINVAL;
+		goto out_put_btp;
+	}
+
 	link = kzalloc(sizeof(*link), GFP_USER);
 	if (!link) {
 		err = -ENOMEM;

-- 
2.53.0

