Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCED2FBE
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959093; cv=none; b=S0U1eFATyRY+2NNT0vE8dBJQ2wP46nePtPkcHP8Is0vOddPjhaMD0sDkEUoXd4vECj/0Y9OFqzkj92JP0fwnQCMhFb+tnE/6tdEFy8n/fMxooPb5lnef/exviyzw+rbWlxWv1qlwOXM1vCSuOCQ+eVsFxEQVnQlZ8s41MUx5jgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959093; c=relaxed/simple;
	bh=3KU+Yh/N4O5tq32/93PVPh7s30lB2LwY3B7SM4MwxQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fxe8cF5JEBVRPRjsCasi1FN46nJ1ncYLcIbzT4ZFVhQpfU0Dr+LdcT6qByw/BtI/JFa6Xvoz/uLJUDl+zHnmbHEIGwDV/Y15J5+tKC7sT8fVo/zxUkNiwcalTRx03QQ+dQklzqRUE2kACPk/F2CznlzDpW3zLJ1klWZqpCnRTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l252FnKI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l252FnKI"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso1374593a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 23:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959091; x=1792563891; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=okM87j2whyXkmY2gWDhPCnRgp8izy+Yr2EreYx3trtE=;
        b=l252FnKINsWyHOB9kYNxBjE/Bgo1Vp1KVtMiVxOo4zPccZh2Gy5GRchGRTHd0vAXa6
         GlfuNDXV4+AxoI1xQTRRYgdToEUxy1kYPxCdqORF/L5FSlTW1wO7bR0HtCTmPtL/b3mc
         RdhFVYIgFZ41/8FW+Q3Ou++3fsL7Ucfdya3Lfwn9Bbdqfx2/ekQnfzbhT1lZ2PnLHPRJ
         Hy8stmQMr8hdQEQxJGNuRIpIgSg6MDJFSTZPuH10UVjz5NPoCphDWvJrdm5Dd12s5lQU
         udZjmvcOUoqcIQVaUvNqf2iexk/NdJSg6biXPBw92fXe2AywDtuYk5wOGEvpcxyIzsGe
         w8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959091; x=1792563891;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=okM87j2whyXkmY2gWDhPCnRgp8izy+Yr2EreYx3trtE=;
        b=L60EfwySKSCZquBRfjw1SJZx0oYbBxZxcQkf8LmccVh0hJLQ5L+zizu+wzGsfEX5il
         tP7wkdjXtWojAR9PYqZLWjQEwDgnG3hntyvI64sV8DnmQlycSbdlu/rU92NTPGK+ybSA
         k1aODWmAFS2vbvUcVByZ+VwJNcxXSKCJX+ysstbMtZK6qJhoDDaLtdZ8gAOotpqrCt1S
         WWqFYrYqg6EwmNk3rJPm1luk7LDUyZZBv6CVh3znFREpScm/Q2MJP9XFKo6DmAjvvirw
         pWmn44WrJCIoDtQpFEYm6idv1vEPErKJqwdDY1O6mM+PGZRKmF98NHStcf448+Fdot4J
         Gd3A==
X-Gm-Message-State: AFq9FYIhcxFIMhZ3l+orEYG/tS/+N3jzk+IBZaNmjePQLh4s+hUxC3lB
	HY+1Am6eAwaCiSytnO/PQxF3KCNYLmegtPRZiWxC/4vUGgLJ3hglOwyh0dFRkA==
X-Gm-Gg: AYBFou3n44Zn4C6UYQQhmjoG5lQdmN9zHpxWUj6lI56mVS4iITgddpp7sF/7gU0TG8M
	yiqsN96X2u4eUYOMsMg6ugr/vUUBgiLS3n2uNKZI+2OEPHjsd0fSZI/u04z/WElFtqlmprr9txz
	OaLhgGRRpHMvKQY0DqSCyZDQpUcwXBoJOCmbzKHQOkJfFk/8gdy5S8MTKDtbfOTycvu3hrnY4hM
	RSxuxwE5kjG6WTe5Wbc5Y6hI7wF03AYmV2pX8DWwgBrw4XvJ5KIkwnXqCeaDAuS4gRlZnrCOuZn
	+ectc2DD6GWENIT5xj8OwzwqtckG6iLdaMJ3r6QX/tds22vUfq6F8LfvWJ/vvf16MDNV4bT4b7Y
	z5b7T6LvSm82MnmoJHQZRf+rg+wBJdnM/elQKisHthJJ3YknO/vThljXVH7djs2S4YRgxzmycjs
	UP5mlT9UT++dWV3qsISdvtc0Q817NMW1nAV7GW4MG+nKYahaeSHZI42sBiJtPGRaUB1OGSauSxS
	v/VN0A71lHCjec=
X-Received: by 2002:a05:6a21:670b:b0:3e0:de4c:71f0 with SMTP id adf61e73a8af0-3e16be0aa3dmr13352185637.31.1791959091402;
        Tue, 13 Oct 2026 23:24:51 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e41126sm6614238a12.23.2026.10.13.23.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:24:51 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 0/7] bpf: follow-up for scalar evolution series
Date: Tue, 13 Oct 2026 23:24:35 -0700
Message-ID: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261010-scev-minimal-v3-followups-c1e3f247f224
Content-Transfer-Encoding: 8bit

Assorted follow-ups for the series [1]:
- Handle ARG_SCALAR and ARG_PTR_TO_DYNPTR in
  bpf_global_subprog_stack_access_bytes().
- Fixes for other nits reported by bots for the series.

Changelog v1 -> v2:
- dropped patch #1,
  "bpf: static subprogram arguments liveness should use BTF type info",
  see the v1 lore link for explanation.

v1: https://lore.kernel.org/bpf/20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com/
---
Eduard Zingerman (7):
      bpf: more precise stack liveness effects for global func params
      bpf: avoid duplicate declaration for BPF_SCEV_REGS_NUM
      bpf: reg_bounds_sync() comment fixup
      selftests/bpf: stack effects of scalar/dynptr global subprog params
      selftests/bpf: harden __msg pattern for global_callee_btf_arg
      selftests/bpf: harden __msg patterns for step_movsx_bounds_on_line
      selftests/bpf: BPF_F_ANY_ALIGNMENT for byte_array_size_spanning()

 include/linux/bpf_verifier.h                       |  3 --
 kernel/bpf/verifier.c                              |  8 ++-
 .../selftests/bpf/progs/verifier_bounds_step.c     |  4 +-
 .../bpf/progs/verifier_btf_array_access.c          |  1 +
 .../selftests/bpf/progs/verifier_live_stack.c      | 62 +++++++++++++++++++++-
 5 files changed, 70 insertions(+), 8 deletions(-)
---
base-commit: 763187dbbf83764a57d5811168ef9de7b9a60e2d
change-id: 20261010-scev-minimal-v3-followups-c1e3f247f224
