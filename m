Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1658B2E8B6B
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473134; cv=none; b=Zrk15Ea31xINbWkcicVLrWtzv23I7bxqex3ypy+rdoyxKDmel4jhaN7O2yQa1hj5aHuDLxyDGFqPkRtE8WRIkB8eqN2GHXpqrvCjG8iXPA7EOZdD6OkAG6sxrplWT+aB2czmveAurCjI1q/K2IfuuCRM09vEvo3tIgo7ijtT2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473134; c=relaxed/simple;
	bh=VEFE+Le3J4kokQ2bTMHgmn8JTCyDAPSCdILWGP3vRAs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HVAO7ifP/vFiGK0c465z20hj0iV8qFDjmy/tKi7o1XF2xlyvBilDbGNg5qcLZo6nreRyfbDluM9iab9GoORAScajbTfMgezHf+1yPZXAiv7cOGUWwJWG1wPPqrpv3qcOyKnl66C3O1rX7Yizpr4/lva0M2tkpARIagzoeDWXb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjUyn7NO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjUyn7NO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b6d9c981so125928f8f.1
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 14:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774473131; x=1775077931; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uKSyXsXjvD0/b9TNOxiddMFRBG+BCzc+FJTLa0tgGsM=;
        b=cjUyn7NOlGGcbnkg+KXlGxzH1+BM6PdTkafBRGNhBb5snN1a2iMO+g19jqEAPtjH+k
         gPD4o6TYQrl92dQZxMcHBoY4DHYy/Kw77zY6LPqea04l8ge1nGc2QiSfsLiiGH5vYmJE
         ivIoHAf/fdZbgZnNh0sKEqXSOEYKO2XhKvRjWUbfydO42XpoF6WxnoTRZ07W0uMNq7vB
         LdFVU6L4Jr679RdRegqicxgMJWofe9zn9rV1qDUhxFFI9JyqPxeDzQ86i1pdW0ERdxSW
         XzHlrPU62DZwckYfldFHhY+3k8wZ6tjZ9Xo8/KNgt/1Cr69jCi9JrnDj9VlnGBXK+deS
         XnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473131; x=1775077931;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKSyXsXjvD0/b9TNOxiddMFRBG+BCzc+FJTLa0tgGsM=;
        b=jrMQF+Gx9I4OJyM5Rk7HAA9VHpJxjAN4nPPgGqQE22zK2Gn+mD62llOACs901C7drq
         nbFRnO+65/oO4XbRvwbnx2iqOly4fxWr3dEwLvoGmAyx+Ln1YS1YRZ84rg2GVgcqi6XC
         lly9UA0MyCGps1+I11weFDrMM3d5O+JC9DqRqmK+RtWzslGlWuUWaO7oCExSqdTVEjq8
         yK/AVkzDR2pXyAfsdUa1joCzIdB3wILMOCla8qXzTs1fKFbckQ9UrRCsKzWN1NfZcejw
         T6FY6VmRbf+f9rlXnVMnGtxyGE8udu6cyuGarf58PKyInFE35R+FjXy7cMWpKCm3AFWY
         hgxA==
X-Gm-Message-State: AOJu0YwfefSd1eCt9XHF6nS1hsIuBR7+yQuZAsBIv9GwvjD4iPGmenKq
	wsx+uoQfqk3A99GUFJ2aisu47vXhUQcyPHrN8XaVrTy5Na776pDr4Jm7
X-Gm-Gg: ATEYQzxPBd4478yjQqDeU3C7MPVpxcJbup1Q4IJraKug09phVlkPerprBMDoczKOJCf
	ob09wSAw6FsCXkkRHdrwZf1RK73/8ECNnt4Ar5FQ+Yy42PtYAConXvo/Y/UjyCnGwryR4tCXtv/
	pM1Ty5MeMYbcNS9fV8BRGtmmkQe61QHuGO5qlCJx6fDdlppFIBCGJ2ORfdVQ6mgIouuUt0gcKck
	EBCiznYA7q2Kaq44ApZxVeSiZwg4IvctMkYwYJJy/tSJ7OGy82VCDvwlAIhnWQovjoXpMd8vbbs
	nUmL4HFF1Ng/sbfNcjROCX+YFxSlgLhyetWwo0XbdDnL/CJzYJZOqpLOHZjrNW3IliftuNv2g6V
	EWlZ/95S5OvacuJjwt7wun6wnA5Xv8ISP2iKeC1I5sPu+edaubq/9Zjah+2DW3MB04yfFK/fif2
	Hxl05F8DeKsny8Kg==
X-Received: by 2002:a05:6000:4381:b0:439:ddc0:4bef with SMTP id ffacd0b85a97d-43b883786damr8154472f8f.8.1774473131295;
        Wed, 25 Mar 2026 14:12:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cefd7sm2433931f8f.17.2026.03.25.14.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:12:10 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH 0/2] bpf: Migrate bpf_task_work and file dynptr to
 kmalloc_nolock
Date: Wed, 25 Mar 2026 14:11:53 -0700
Message-Id: <20260325-kmalloc_special-v1-0-269666afb1ea@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJpPxGkC/x3MWwqDMBAF0K0M99uATVKl2YpICeOog/FBAqUg2
 XuhZwHnRpGsUhDoRpaPFj0PBHo0BF7jsYjRCYFgW9u11jqz7TGlk9/lEtaYzMs5Yc9P76YeDeH
 KMuv3Pw5jrT9DpzEfYQAAAA==
X-Change-ID: 20260223-kmalloc_special-933ec4c543d7
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774473129; l=1264;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=VEFE+Le3J4kokQ2bTMHgmn8JTCyDAPSCdILWGP3vRAs=;
 b=uFvdhUhy2dMzADomQoTQaU2NRCYziDdYkt2v4yL6quxKkmyjxaYq+83s6CC0HG75W8MN9IMze
 YHpKoBJW3XcDtIy9ZahLCNcw3CmTGuTt9L/WbY+OS3SQiLFkIIHKx7L
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
to kmalloc_nolock/kfree_rcu.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (2):
      bpf: Migrate bpf_task_work to kmalloc_nolock
      bpf: Migrate dynptr file to kmalloc_nolock

 kernel/bpf/helpers.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)
---
base-commit: 9f7d8fa6817e2709846fc7f5c9f60254e536d138
change-id: 20260223-kmalloc_special-933ec4c543d7

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

