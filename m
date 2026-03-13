Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27E344D80
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 07:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388406; cv=none; b=YV0u7ycT0dhE4HWPFjpDEc2kXXBePDO7tU3ac818fMOZARBcDhshvbfRFJ0nj/ey6jpJsA/XtR7TmgmHV60o2TMUKLI1aqB6ZreYKD9Dr1k/SK0+vpJj4bDjMty6e1ac8KHgPAWGqytRCa44L2Z3++07kdJFWo7LWk5lGkFe9eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388406; c=relaxed/simple;
	bh=1JK8eHh6PW+Tdi337CAzYY2Wb4HFtb3UExN5GdA4Jho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbNY5/hFR4wmTMFPBOFBhF8iugJ1Ba9JHYDtqeoFMpH+3Yogw9R3FjEYClpXUUlUuMzPH2K+Kob8Bq7MdQML64CN7JBHPoMku8Mg5CmJ9vu1vNMbwHVoyqzEfrJGC4GkclK3Xj6EoXHWy+vVR61VJmD7PACorHIsUFPj/Yf97C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BoVlNUzQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoVlNUzQ"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-359fea895b5so1107948a91.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 00:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773388405; x=1773993205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q195ROA1znJT9XmA5h8EfGgDZD485DMDeZ6516WPtkA=;
        b=BoVlNUzQrnzE0iGplcLs+wSDa8kvSlrw3NtofRYJsHouWOC8gZmEozu30CNCd7WL+C
         oYyDDPsxo7UUb0c21Ome+CtBvdoAqfmojAKMgijbwWUes4R7NCBYxQTJCS0oE87WukVa
         ldBADCm6550Ihh4EnmzC6ySb60uzpAeNJ2a9XpG8fFM95aCOqXZB/cckvDDZOji1qNad
         l/6JVPJyQStW5/14jmXgIutCsPQHoBtlyJ0oNVFypi1NhzsWGR0R4g7cD/EhAbDJRk1h
         AAFTB7VbSOIjL0fKNrf1jBvxOoS5gvSAqFK9mn3N3+E5nXGC3pA5vTPqAkh3tpp8Cwyz
         ELog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773388405; x=1773993205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q195ROA1znJT9XmA5h8EfGgDZD485DMDeZ6516WPtkA=;
        b=S3d70UY1mogG3LIIOv/7XiZ/P8nNDGBAc0uugspZl8FVhVoIrISNjW8SZUc3juaN3Z
         QNu3zByGix9V8hcG3UCEfkg/b/URy/umhzaoaTSpb22UsFmqchS9mUX0NBhMMxC6SwG2
         9yDKM/da2KI0UeG3JGOZFpo9/b10D35vx4op3AyKPTf0Y85vmwUE/kq3pBgUJXhUGQcG
         uC1WxkIzx+/pMBYUUm89VLTLIAMDOgq2btJyVk2fh+fyuPTUAYTcgAyPibaLOVjLPct8
         gCW1a5m3HERcrXt3U5WEry++uA8z+1ORtFFxqmnAQLcOl4M0Y4xZjodORXNfXazF7rGF
         qA+w==
X-Gm-Message-State: AOJu0YwI+XMwZmFOno5F5N+UiD4ugEKKNXdacbBQZJ9G6v4z7M0fAbFr
	AdQVO3GofQIFqg3nji5zvtXeidDxVALtCFhqUQP4Jyq7fdoZMKU2EW7Us34yRmVX6Q8=
X-Gm-Gg: ATEYQzwlMgQzxMLCiGn3XKQ0dVtpbe2GRjsjLF4EUihBS+1Ew4QSIe+zQy5TfwddZ5X
	NMOuCddUpcDXnNheWKFkORF1nx6Vrqig2XdD8qP7pSGggt9tT8rZ3Ag1sqabQ/MbL/pKaAcNnGM
	GBhvBDCft0wjjZS1dlXc3GQFRixhp7wNl5hykRlBQ22sWsx9Taep7QUuVvuRdQwIbFOERvaFPxK
	JRMB8o3Mk9uXQ0dHBfm9QaLz6CM57xR5VLNPhK4vG6MowXQ+XlWrR1xHudRQ9ZfnJ/6vOV/Nkbc
	O9PmezDKFvVmHpKNw2ifnFp7iCH1mvbqC2CYzXw9uYh+XlutuljfJYhQv7IKuzcUs/3T0D8nMEd
	XvCccMfP+ed6o/2qYuKeddQGi2ojhwt89qsAGsc2FDyhGaHok6CZG0hNym+Mlj5MlzlwFDYhozv
	8aRXzqlk9qm+uwinViC9zhXRPAG+ieGcQ4KBiwoCAPrriStvg3rsdP/HcCPxzxsm5duAMwWgOj/
	5oXfBFZsw==
X-Received: by 2002:a17:90b:2e45:b0:356:41c2:897d with SMTP id 98e67ed59e1d1-35a21e78e2dmr2233303a91.8.1773388405065;
        Fri, 13 Mar 2026 00:53:25 -0700 (PDT)
Received: from kali-VMware-Virtual-Platform.. ([185.218.127.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm9774694a91.14.2026.03.13.00.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 00:53:24 -0700 (PDT)
From: Daniel Wade <danjwade95@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	ast@kernel.org,
	Daniel Wade <danjwade95@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: Fix unsound scalar forking for BPF_OR
Date: Fri, 13 Mar 2026 18:53:16 +1100
Message-ID: <20260313075318.11847-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maybe_fork_scalars() unconditionally sets the pushed path dst register
to 0 for both BPF_AND and BPF_OR.  For AND this is correct (0 & K == 0),
but for OR it is wrong (0 | K == K, not 0).  This causes the verifier to
track an incorrect value on the pushed path, leading to a verifier/runtime
divergence that allows out-of-bounds map value access.

v3: Use single-line comment style in selftests (Alexei Starovoitov)
v2: Use push_stack(env, env->insn_idx, ...) to re-execute the insn
    on the pushed path (Eduard Zingerman)

Daniel Wade (2):
  bpf: Fix unsound scalar forking in maybe_fork_scalars() for BPF_OR
  selftests/bpf: Add tests for maybe_fork_scalars() OR vs AND handling

 kernel/bpf/verifier.c                         |  2 +-
 .../selftests/bpf/progs/verifier_bounds.c     | 90 +++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)

-- 
2.43.0

