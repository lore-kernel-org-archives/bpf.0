Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E283A6EEC
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 22:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909704; cv=none; b=WLaa4SfRHrfk0PG6GEECFLA9V1g4jukn0sQtMpL5rcX7TC7BM6zZR65S4Ntl2PYFTTVxlyJtTYWLrF+VfipJGvbhleTOd+W19EXgmpMzSEYzUeqZPrhCG+UOIQvDG/3YC5HxUzYOaQxPU6oxIjh6GYYbusNmey2X6HNiBbDABns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909704; c=relaxed/simple;
	bh=7QEjGhfSPlAzaMjkMkQH1BfcJww+f8sPaC3t0pVGZK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=blpsbUljlCizjT01hPThUOoAeaxn7phiP4VF8CHvDc3ND70fs8yfl7rndzkunENmWkDYaAtGY2O8Rjd2lKZo437uAorGrCEbm9vQL8vscTgZ7JXU19qFJSJGkyhNa6YtzCc3hOEZSFvpQ68X1XNAY/QyQZRX0t3Ie28o3u4GiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfElevUK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfElevUK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf7683a28so1053502f8f.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 15:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774909694; x=1775514494; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3A8XHM7BXGtT2655xQYZ+LtG7Guhc4UjpZU+DOxye3k=;
        b=pfElevUK0Vn1HOTtlHFVACDqZcgqURbcQCiEv3wAoHhg924BtaMd/KZRbMveM77B0p
         D2VhaZCfmpycjyo3c6/3BE+Tf85X9Ll6asKCo2D0dleViVlTF04RSRgs5NXE9+Y3IRhk
         pepic2nQzULFO/lO7Nvl07vp0O6BP/YhJCA0jJvRZT22BQm4ybx3772Evkg1Nkb0hNeB
         X+8OBESkan7Rb/qn3zbEAYLY57yUKa9NM6Zfd4eZgO4j4LcWbmlovyfs6iosDtM2hxEk
         6s83M1sty1fvKLDcxJqBuk7kuH4qI8+nfVB0yvLMdOfmFO9pVVl795VyI0vp7gAtbmZ5
         TxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909694; x=1775514494;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A8XHM7BXGtT2655xQYZ+LtG7Guhc4UjpZU+DOxye3k=;
        b=sN6iCHWKEYFgt0FsvHPAV06p+iZ/U9FNBPeAzhUXJB81vgHDSTkWyfkW9nrxywUXcC
         YujvGfxG+qCjh41I/VudAN7xIJoGdliK88DITseEEn5R9hUJoq10kbmQ711tnBDt8aKU
         km7yHqIwJQSbe2K2STpa1ucykdrTub7Mqdc7WKJ4EwuLIUMqEd3SpkWu3K2e4gp7Fnsp
         gh9nDKOo4aTCDE3SlBisDB79ylGO7CaRJneGswVRAY5tBsMJekC9vde/2/SzudXxIIEW
         jrIFkLLbgiu9id9C1/6gDsdSJUdkg9adj2cYqe4aY9huM0laFc/bm8ktNQxJHG/IeFtO
         IlSQ==
X-Gm-Message-State: AOJu0Yz5IY/A85YEeDoc5F9FsMc6yRyBv6W5Mte+soG5tMV1K7g5fe4H
	V9FOzdxHZMeE0kFiQkYibBO/pkAX3dNuEqAhMpWWdNlg/lSFShY8LJs1
X-Gm-Gg: ATEYQzwRW+L65KDjX2RkIh/tHp9vsCgw9QjYIogMHvy//RlOtLLkbmfj+k+Zc+evE0K
	uw6MT467YdEKyz68E+1u4MyEX0vEcJnuFvcveORbUPRMrs3zIZrWo+y+0Fa46b3kuVWN01OvRzX
	JTYi3/x6ynX9V6krXKibXwsW07fUmfTmSXNzi8NdR5i3TwdgnKXDJU/Z0w93MDzcolXwqWkyZ65
	YGACpvuUFrf4sfv6N3rz6BkCA4NdAEr47bVtHMmvi7dG8970O/ErnTTS4Rs9EyoYAlGaH8D9qcC
	qTHF9CxkCkd/rtbd4OIcGCK9PEnjKIEsqz+mlB5r+99dF5MYMXh87o4Yqa/xOs3YWfS+JCYJ/Ii
	O00g4usYn+C1//KphD9IDnkagHmFlxqD9XPGSf1soHtADsjUSh+amY6AO9hrsJU5MeZRwPyIbfy
	rjF2tFgA8jFw5x
X-Received: by 2002:a05:6000:1847:b0:43c:fd92:f432 with SMTP id ffacd0b85a97d-43cfd92f54dmr11467284f8f.2.1774909694061;
        Mon, 30 Mar 2026 15:28:14 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247472csm19128280f8f.28.2026.03.30.15.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:28:13 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v2 0/2] bpf: Migrate bpf_task_work and file dynptr
 to kmalloc_nolock
Date: Mon, 30 Mar 2026 15:27:55 -0700
Message-Id: <20260330-kmalloc_special-v2-0-c90403f92ff0@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOz4ymkC/x3MYQrCMAwG0KuE7/cKI90UexURqVmmwdqVVmQwd
 veB7wBvQ9Nq2hBoQ9WfNVsyAnFHkFfMT3U2IRC451PP7N37E1Na5N6KisXkLt6rDDIOfjqjI5S
 qs63/8YpHmV3W9Yvbvh/Ktt5uawAAAA==
X-Change-ID: 20260223-kmalloc_special-933ec4c543d7
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774909692; l=1613;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=7QEjGhfSPlAzaMjkMkQH1BfcJww+f8sPaC3t0pVGZK4=;
 b=mtFtiqEDTlwZa5gmuex5C8E8/3SMKoJ/l7/Xvt+cbBOcpdUXIMf5MXnpDKb42tWp5qLAInJgX
 /HvO2An7+4QBpGnFff0WJKQU1tFg+wSIKEAJHdzNCU9UfNeX1u+VsE3
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

Now that kmalloc can be used from NMI context via kmalloc_nolock(),
migrate BPF internal allocations away from bpf_mem_alloc to use the
standard slab allocator.

Use kfree_rcu() for deferred freeing, which waits for a regular RCU
grace period before the memory is reclaimed. Sleepable BPF programs
hold rcu_read_lock_trace but not regular rcu_read_lock, so patch 1
adds explicit rcu_read_lock/unlock around the pointer-to-refcount
window to prevent kfree_rcu from freeing memory while a sleepable
program is still between reading the pointer and acquiring a
reference.

Patch 1 migrates bpf_task_work_ctx from bpf_mem_alloc/bpf_mem_free to
kmalloc_nolock/kfree_rcu.

Patch 2 migrates bpf_dynptr_file_impl from bpf_mem_alloc/bpf_mem_free
to kmalloc_nolock/kfree.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v2:
- Switch to scoped_guard in patch 1 (Kumar)
- Remove rcu gp wait in patch 2 (Kumar)
- Defer to irq_work when irqs disabled in patch 1
- use bpf_map_kmalloc_nolock() for bpf_task_work
- use kmalloc_nolock() for file dynptr
- Link to v1: https://lore.kernel.org/all/20260325-kmalloc_special-v1-0-269666afb1ea@meta.com/

---
Mykyta Yatsenko (2):
      bpf: Migrate bpf_task_work to kmalloc_nolock
      bpf: Migrate dynptr file to kmalloc_nolock

 kernel/bpf/helpers.c | 60 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 21 deletions(-)
---
base-commit: 9f7d8fa6817e2709846fc7f5c9f60254e536d138
change-id: 20260223-kmalloc_special-933ec4c543d7

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

