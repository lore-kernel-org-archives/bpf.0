Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B60636AB54
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200513; cv=none; b=KGFFQkNW9NOTHl6PSvpazklPUXE1nlIElSmUVtqcJmbE2uybRf8Fu85DbV51ka+Yo1QbM4LLtNma8fIIK1+UWzWuaJXfxKAJ+ZSnUPEoFQSiyStbtE4El+CjblTOyhAB5gAWz+CMzU7Hc/DyAUkafR5RenvAk+ZoJatuYSF8FcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200513; c=relaxed/simple;
	bh=pMesjCa/gOkBIsk6vgDz145mredVUwi7QE/iBRjmDPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6vA4pTWsZQlx1LysgNzhIsfVWMTuL/PMYiW8+jZCpokAtVJGUvMM39fZRrCNGg67AcbNvQsKahQ8CbXejM78mLUnWBvdtmYq/Ru4foPIIoDvhOyxg0WVPL7odbn8TYY5E/LfxGpNuFFBDMqeqPDadN2b1mM2Yw6uDc46SHvVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKmzgBe1; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKmzgBe1"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e5378b281aso1884745ad.2
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200512; x=1792805312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=52tfald6BXy/mbUymb59GMIOFzcDzqbQQ+kKvj8rcFA=;
        b=RKmzgBe1A7URYboNrjONXBj5df4I64Iua/i5nxm1lTynV721gBlAItu5Crsy9HO0Rg
         qINLAafxMyDdq+ovAqhGBkTvSUcp5L5dHDeMTG5JvEsi8AndeDdtp8z0O9ehPbcLHZnk
         znuvKQ9lnhVAu2nOsBqHsA2s2itspxkRUXMFQe8rgutGzjI0nDFF95Y7ikMu1JYIsrzk
         7eT886DpZAzbQeMYg/H3F68BbwzBHWIqLILphj5/eKXSV89Z6VP4nllOdwhac9KwSwSP
         ZLuX8MnGcNDPZ/LSPdUrwcrtfSE9NTgUxKA/IKgsMhvc5H0CbCb4i2az1S7mbMPmxQWa
         BEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200512; x=1792805312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=52tfald6BXy/mbUymb59GMIOFzcDzqbQQ+kKvj8rcFA=;
        b=JfzR2PPekRIBbkCXn0822Zcjrxsk7LrkZDL/4GEM5y8GUsjyRyd+CA1yW3Zgua3r0a
         zJDk1+CO+Nii8NRMfxHL8vYhqCy5WANPIl3e50JCGlk9uHBYDByKoq0d+Gz8JP3XeGu8
         eSgrCNgN/GU9cAcIp0/9b99uxe2kwzniM4SmSAv4sauzJM0mwiyoNM1fHVoYBxWSXxcM
         dNnIVFpU2nBpL8xMEb8cgIGw5lg4BrFx6oTOl4nNk0FVpPWzG7mVt9teBHSaQ/bMLJ05
         z0QiiovLjYueM67M1IyRCO1tcd9pvN44A1UUlXBTLD996h3MDMTA2xLXvSaEi8y2MSBH
         xO6Q==
X-Gm-Message-State: AFq9FYKUZMXmkAi4uLZkhDhfdVVeIgXXqlsgb0fNlsqKEFay0dNQw20f
	eHdSMqdDiNmdtFLLQuo2dvkdNaTlWEBo/ZnI95lXcXQig9eQKWlLjgcs156UvpMB
X-Gm-Gg: AYBFou3G43TG03SEdTuHavCOpXIFO1IW9l1AtgMaAFo7VESlO/nWUtkpcSMASbKQv9b
	568iRtzrVSCM/mj+Nn7N4K8khfU+zG7QCcr0dOE9kMnwXjkqCv+5OLlmXQTXVYZ1Xygl26BjlSI
	H+qNo8BiY7ejviN2pdSx4ZGvHZ4Qh8NcwjNLnX086N1qSoYiEhKewRe8NTaq9nYTFofAn1IEYKS
	JcXV+mc9IkEBl1Vh+35R5QZeuSFCyCH3edpEy0X7VVL75x01agJ29qfpRV/S0JKoEuoMNlPJ3Rj
	R8CN667lrfDcGm6vZYtj+fXopD1ys8niiVwl/SICKybpITGdnpHrd86DBz7V5KHjVbvn8GRK8dP
	B+bORa5yL1au/1qAjJ68bz1Bc7sQsB32Ra9sg9omTCYakf9aDBejiaYv6nOLzR7JBpeYfO8Vya0
	Pkg+iyhPRYBwj7s4fHhAd+QPcV4dgPfm9E5gOcC0ff2maP91WPi7SYXlYosI3fDXrkdUQhY9GGE
	Q81M/d5KKSQdJI6O/iPEGc0jvifFq09pvEWAJkiqmAZufAFCdWXZrsGLQYcS3vDs2a3brJIN2qZ
	xTDioCiQpM+ONQblhWcJVu6+axhWnDt04M3x1MmbLjk=
X-Received: by 2002:a17:90b:4a03:b0:3ac:7e3a:1033 with SMTP id 98e67ed59e1d1-3acef5c1a8fmr1303422a91.59.1792200511625;
        Fri, 16 Oct 2026 18:28:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm11176361a91.8.2026.10.16.18.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:28:30 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 19/38] bpf: Fix stale offload->prog pointer after realloc
Date: Sat, 17 Oct 2026 01:24:32 +0000
Message-ID: <20261017012451.364800-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_prog_realloc() moves a program that the rewrites of the verifier make
outgrow its pages.  It updates aux->prog, but not the offload->prog of a
device-bound program.  When the device is unregistered,
__bpf_offload_dev_netdev_unregister() hands the stale pointer to
__bpf_prog_offload_destroy(), which faults on the freed program:

  BUG: unable to handle page fault for address: ffffc90000071050
  RIP: 0010:__bpf_prog_offload_destroy+0x3f/0x310

It takes the right to load a device-bound XDP program, CAP_BPF and
CAP_NET_ADMIN or a BPF token, and a device that can be removed.

Commit a1aa9ef47c29 ("bpf: Fix stale offload->prog pointer after constant
blinding") repaired the other place that replaces a program.  Do the same
here.

Fixes: ab3f0063c48c ("bpf: offload: add infrastructure for loading programs for a specific netdev")
Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 642f0ab8eb2d..2154c18a5a4d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -269,6 +269,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 		memcpy(fp, fp_old, fp_old->pages * PAGE_SIZE);
 		fp->pages = pages;
 		fp->aux->prog = fp;
+		if (fp->aux->offload)
+			fp->aux->offload->prog = fp;
 
 		/* We keep fp->aux from fp_old around in the new
 		 * reallocated structure.
-- 
2.55.0

