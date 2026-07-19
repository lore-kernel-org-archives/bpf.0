Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2331DA23
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465663; cv=none; b=AbsbTlia15aMS2Xx3BQ6dzT8A/F7JFZkXl/5OfCmamMjDSQqofE2tBipPzE67mI/p7KUub+Jb5BlZagzhGXcjDSM8Y5yRxZx0Blr17fOEZV5axXcVRmv61fv/TK/wo5PXw07eQMckd17bv4GyvA3oY5e+DXjrn6Q3TCap16Bvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465663; c=relaxed/simple;
	bh=rwB9ZHytivFOMtQ6iDyU04oX6d58HWu8MvXWc8CDXEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JFsVNhWDRmavmp0XHn18L8b7rqEJF+S+62QC7JbT/ebM1RjlNS/QgbLp7rMq79gm6aoPlWm3UkGqr09xjwy16xwOYSODUuFmgFpMW9e7PLe8QaIFtjTmDQxdeeG+wi2t4+ER2ENCjuL2sl6+X51xSkj3dGLZ8r3wyk6dd2QQqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2FXbAjm; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2FXbAjm"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-492367f3094so37547695e9.0
        for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784465660; x=1785070460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IiWqi16jx6xKOIv5FGyqEh1shDL9gMbURRG2mYLNzuo=;
        b=I2FXbAjmT7GDOWr19Y1MieyvqAcOndbwiAXpgtuU7RJmXaQzX98pl5TRkQJMck+K4I
         NkeuDX7btzyW54IcDIKkYtOjysJUpUei/1xqYMK7Vz9wat635NBlPkpnC5q+WBSHVq7P
         sBTbcmzRHjkqdT7ESEMUH+C/a0BTgah8Wc4/qYQzsbRXp+V/vw0OF3/R7n38P1PDocMr
         Pnr34so5juBf0e+xECsOqWPPBQArgHyUM5g4NzVYPFpc61ucsHK2dSXkgegh01bmw99g
         uXiKkU8XU96RPxSAKxjqzjcsDtN+ccbDNkrKm/b/RBz192DvudLNZZxBaLcyHV48pCbJ
         Qhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784465660; x=1785070460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IiWqi16jx6xKOIv5FGyqEh1shDL9gMbURRG2mYLNzuo=;
        b=JlBUn4TeOMMXRqpYBAN7z2qmpnylkfRDN2o1kPszy/z0J7S6Rfw3LtN+wHsBhjhU/q
         Za8Ob64jXMR/znY3MNxkEHVnKRPE7o6Ingm4adjRiuMPIGf30tOY3DErU3iy4xH4glVu
         D8T2iuTmw0RCFV8yqTUF3ebbpAq7W+bQL+0n2eMJp2ACo+J/b1eJ4+oo3Wlp9YlLFC7O
         O5e5vUUAzLRfKgVahfH2yC2O+XOZazR2OTlS3vRrQUPoxd6mMCEdaSi+rijBB8WueT9v
         j7CHcRK5iHPAmFaCIRIIzWaRZ7oMU1nYlL0Ws+j2bt2k7g+ejRS1pmUvxVBdpjZDC+s7
         Ouug==
X-Gm-Message-State: AOJu0YxluhR/SELvcIfghYipk2lRtNKC3TSoXo+JPvpYx/EvACuuP+wc
	+ty+EWgRh2JEE3+0SnxNTPGpt0jDJ4+yWFD23vTinqPT59nAII/scb3haQT39TmI
X-Gm-Gg: AfdE7cl27PHVoiFIreZRzz/qcDkPv0Xj1C27rEdM5SCdBGoKySeEyLSAL+IUNFG48bH
	a2LpQug3bya95UIFhrzNjS3frSFguXJNvkJ/mXiX2vnfZmYqIlfz5qfp8xwlPVHhyBxF218giKr
	DPDIlllB4PEgsdhpTvpsolklEeWsFMMaurYMMuWQSW5pQG+hPp8QZYZnO+sfWcMowCBN5KSWv5t
	IBBbkt7CPR8WmL1EdVmbwMl4c0zCTfIqaTuX2cjLm3iIwr0OGkg7NMO0t0sO01mX+6tsyf7YsD+
	qLJzy1aP6z6qx59L6HvcgEkUPHWS/DyMY3KhNsJZgXXVNjQiCnwGOv7xccMPyH0n0Wsdt8oIYpz
	E1VZdMlDOOcBDwc4+AIECi7hYtpXdOK4rnPal6d0IcbrACIOF8zqpNQ5zZ8jIpyEnh8foyCMCDI
	THq2cSdX7y2AO4dymCE3paWfACJ7jLCm3a468SdeXmunpY4br0ephH2HXtufsckDi+cM8jrAg0g
	D3xjzaFF6dlenDGudu9gbojLIis+9enoihLS0LlkFa1
X-Received: by 2002:a05:600c:1549:b0:495:4a27:483f with SMTP id 5b1f17b1804b1-4954a50baa5mr98664435e9.29.1784465660071;
        Sun, 19 Jul 2026 05:54:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm189009165e9.13.2026.07.19.05.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 05:54:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: Zero queue and stack outputs on lock failure
Date: Sun, 19 Jul 2026 14:54:18 +0200
Message-ID: <20260719125419.1782196-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue and stack pop/peek helpers accept an uninitialized output buffer
because the verifier expects the helper to initialize it. The empty-map
error path clears the buffer, but a failed lock acquisition returns
-EBUSY without writing it.

Clear the output before returning -EBUSY so BPF programs cannot observe
uninitialized stack contents after a failed helper call.

Fixes: a34a9f1a19af ("bpf: Avoid deadlock when using queue and stack maps from NMI")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/queue_stack_maps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 9a5f94371e50..c1c9dee4dcdd 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -99,8 +99,10 @@ static long __queue_map_get(struct bpf_map *map, void *value, bool delete)
 	int err = 0;
 	void *ptr;

-	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
+	if (raw_res_spin_lock_irqsave(&qs->lock, flags)) {
+		memset(value, 0, qs->map.value_size);
 		return -EBUSY;
+	}

 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -130,8 +132,10 @@ static long __stack_map_get(struct bpf_map *map, void *value, bool delete)
 	void *ptr;
 	u32 index;

-	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
+	if (raw_res_spin_lock_irqsave(&qs->lock, flags)) {
+		memset(value, 0, qs->map.value_size);
 		return -EBUSY;
+	}

 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
--
2.53.0

