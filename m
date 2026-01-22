Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF335F8C8
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105029; cv=none; b=BbwPXwGP68Pkpkqm1jnTzFyda+HHdPcMRsI2PLUJ4wd4F5F2pXpCQBq3t6RpZVPGRKdjvOhvGYhgL4CuD59ojs4QqhY8OqIP/83gqo3Zi7AYu/MeIDMdHfyHcHLi2SUhTs3k+N7+nROTzlXDdP5XYgQrgJJLB5y0eLkhQGVriT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105029; c=relaxed/simple;
	bh=eQrV1EKZqHsmVIGhel4h8MDp4vCTQyfOlunV7rk0aTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EM25HKXyu5V3K4Wt2qqzOS1ODQS0/6mcDXS+odCTbWjjl0FFnHeUHk1n2bTs4RnIHgKTXs9DuF0LqAKD153W5bw0uKQn2ICn15sEOk8fTkHhWb98fXPuVVQQkTo6+k7bV+SEO4yKO9j8n0jaeCsg72tZwPrKdutu14bG0DlDVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeP90L7N; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeP90L7N"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43246af170aso764480f8f.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 10:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769105021; x=1769709821; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u11OFjcXA2eP3lTIZAas6syIp1aGur4rm7EwEfRCwTM=;
        b=LeP90L7Nhn88UHHx23IpwlHhjUjce+l+XeoRv4Ocrx8yx+hhJOn5rr/bwxWXe3Ih7P
         EiuBoU1bZ8bGStvOiGLiW//UgOEV98YnBbzQganGtRM6VP1FiFEOAjE05LBpV1w4dCxf
         84OeURuOyhAsNEnIPs7nMvlrQgCoUgYPUewZVJzmfxtE31VRGqOwVjiDvMC9GPzHPqjy
         ouy2mCCyGiu/WFgtOeug3CS7jJz1Wt/HVlk8x3fwAmA9tygMUjbMOdTNhjwt1eOgg6bJ
         jL4b/6TuOcpTB8q7L4T5Icx/L4A5Cs+m5nferIPSdnY5Zx5N/WRvj5Pnk52dZvcmtbRj
         2maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105021; x=1769709821;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u11OFjcXA2eP3lTIZAas6syIp1aGur4rm7EwEfRCwTM=;
        b=wnZUBdO3puurQVu6oSf5TQpkOeRhvGJpiJ4BeJZ3Djuam0fLHrcd/BKh7EB9l+ot0p
         qbXVChQX8+uek9kYCX6qcxYvFJgov/ZCQO2ALSUoxph/QmGnnmZFFqZY3Yx4ovi0jIee
         k/LgTfTRWL0kO8heBP6rC0gsd9bAJX/QeDOFk3fSGT/truocI7mAnoGlaZKsyPumku7R
         nmx8mFsmDw78HRVQYPJNq9c2O7WYFECLqx17yWx3OgMp8ZD+7mnDFPaKxAtl9gesMEZX
         qI7JKLGSU9q4uVSJFydcYInhuzes/FdWWcBKVf474LMOFDhmq9/SokpoQ+FJ7k4GqAiQ
         mTAQ==
X-Gm-Message-State: AOJu0YxhJTnNgtwPWo9mllGQlJCtZS28SEYGqZ18a7MAXvlA/zx2xd57
	ZTugamxcCoZGg1ShpNhFXRcdFO+7VkQQ/BXxn7dz+qgBDyIBCh/bMMHp
X-Gm-Gg: AZuq6aLIbMYXa5V/xebSuoJ4LNZxQg0fB8jFRk5zYNr+EUyxgpMsuarg+qA1MqF/C/v
	sB2wONvN5L+sGrPjomAgSbGtokZgrsEeKhYrTg+ep5rQ9UFGtzyV7r7DARhTKT6fx+tXS3i1XBp
	DfKZmoOiDhaFjmQl/V+pFE/LmeeX54vVq+0txk82fENzEBlDSSFIhE5cowzPhADEfY4flSILhxt
	wBmJ2pXDFV0ZJ327wtPrMezjbjqtxKcxaC/DuubSe2uYnzqrZ1+7OEknwIhx19ShLUNRDMEJ2KP
	IcjKaf+AC+JA+kp2yrYulop6SsiwGOI6TmTiqXQ0tj6ItF8ejK3G31fN7soEQGrBBEnu5IPxEtj
	Jz6t5MjGQSLjmFVrKiMHuTOejLHGE/aQaGKV8cqQZBPBarbuvakUUjh5vST1Y0S4iV73w3PJhxc
	pUK8Xvg/TtV3Vx
X-Received: by 2002:a05:6000:1ac5:b0:3ea:6680:8fb9 with SMTP id ffacd0b85a97d-435b1ab844amr486047f8f.3.1769105021221;
        Thu, 22 Jan 2026 10:03:41 -0800 (PST)
Received: from localhost ([2a02:8109:a307:d900:df8b:2445:a6ca:bb5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e717cbsm356207f8f.24.2026.01.22.10.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:03:40 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Thu, 22 Jan 2026 18:03:16 +0000
Subject: [PATCH bpf-next v7 3/8] bpf: Introduce bpf_timer_cancel_async()
 kfunc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-timer_nolock-v7-3-04a45c55c2e2@meta.com>
References: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
In-Reply-To: <20260122-timer_nolock-v7-0-04a45c55c2e2@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 memxor@gmail.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769105012; l=1373;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=iCSt7+osU3bN2hvBtufPvUtJOwZp+w582TPHP9+szgQ=;
 b=LtRPdMl0ftioIWpd3fr65CTG0LXl8aApElapFIdJyoH5MSqLP2oiF7ViQmNGzvZVbimLoGvZU
 uxm3T/4tDTDChMknbv3B7//OIqosIB7Unh0P/h5maXK9j6F15Fa/9YQ
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

From: Mykyta Yatsenko <yatsenko@meta.com>

introducing bpf timer cancel kfunc that attempts canceling timer
asynchronously, hence, supports working in NMI context.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1514683d260d3b8c3193caa7ba1c4a1cfb86d64d..79f53bbcc953a3b919679f31c92b22122ad75e4a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4435,6 +4435,18 @@ __bpf_kfunc int bpf_dynptr_file_discard(struct bpf_dynptr *dynptr)
 	return 0;
 }
 
+__bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
+{
+	struct bpf_async_cb *cb;
+	struct bpf_async_kern *async = (void *)timer;
+
+	cb = READ_ONCE(async->cb);
+	if (!cb)
+		return -EINVAL;
+
+	return bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
+}
+
 __bpf_kfunc_end_defs();
 
 static void bpf_task_work_cancel_scheduled(struct irq_work *irq_work)
@@ -4616,6 +4628,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
+BTF_ID_FLAGS(func, bpf_timer_cancel_async)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {

-- 
2.52.0

