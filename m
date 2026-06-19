Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987F2DEA6B
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866976; cv=none; b=vByNzQH/sd6fJ0HbU4fk+KP792phpJbvIqgTX6iKNjCwM6yueQFGGudy4I1ClrJyXNaTZ+HgpPMGqnG+2pGvx3A41r+KAGlG3UfrEESEiO+0s73RrZoey/0kJ9/TjuuiorzyscdgNDiOiuPMz8i4K3lI+Up7VK91+DHOnfugkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866976; c=relaxed/simple;
	bh=kwvcxH6Tz0OHpnFnkAP8wPmaS1edxlyxpgx911v3jnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVPd2MwC2ubsbNwT7l+5M/WFOWjTsS//hgZjHFMbl1CMQvg0feATzUwzSKtSuBepg/KYZhylQDlK7SzJu66RAVrQ/oC6nTG7UyEtzqOW7MA8mpw1m+PFgD2ZU+Qk7TyIXU+FovzxyO/jmnlKT6jKmYs1H6Urdle53zpiwFVv7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0ClgphB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0ClgphB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b3637b90so14894485e9.3
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781866974; x=1782471774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svkOZpQQq9NW7asD1cGAFjuew46RJC3YF/ZCnRaZE6g=;
        b=j0ClgphBajaDaxjxhwzLyI8GMDDSsmtl6Go/FwDZd1LvzYPyFe1R8j2IdOzF8xL7CC
         v7w4BPtmH4NPdQV4Ux7+Z7+jb41ntAxGw5FWl3Vbib0srf1ph2LEjPPiFxGZ77nfq3GE
         OQIvxuJJcJ6JzQAXsAEPfiftsNgkX5C+zVevjoVtHFXu98sRihFxC7su9Dm/EBZaA4Gu
         J5MteYw602CdBtzTSdrTNCnckzgsBKZ2kAm52eD04HSBo3v6ndHnITR/iKsUrQHoJo/I
         fuXDt/c++cDZoJF8jHMRlxAgOuSsOz2GgQ7q8H/FXCG3SsIIWnsNSvbFY5bt1EpkfEQ9
         KvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866974; x=1782471774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svkOZpQQq9NW7asD1cGAFjuew46RJC3YF/ZCnRaZE6g=;
        b=qBbWsPp1PG4HLO47IXSKR92EABR4cw/UHO6UcA9CGJE5SCaNGuntpQCMudqtHRBvPO
         2nKRYdiItr6FfZNCiHFHAmh1nOabSUNqWH0GKI0hsJIIlVpR9yET5aTudIH8DDQVjkiP
         dkLApNzu+7La75aChXAXROzWAg4TBmMEmLnq7cHGB96gNoyGWg1bDhDX5Fl9chDG6w64
         SVcczlmrOSxzorue7nVyazEQjb2yqOmDKKUUmh8uIit40JpWHJSeQg+oeUWr6IR2pr8o
         g6LWMZMljjaPE/ZxyK/v5sWEGR99GEfojmLFPEF30EuNa6CVU/hCTl+6DrrFoWAFWk/a
         1Utg==
X-Forwarded-Encrypted: i=1; AFNElJ//6AvoaBx71VJzcmNoLHeV6jGankXXxo1waU+HzpSnhwzwRUJH2xy3mK5+swYKFhS+fj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTPe9sBWmvFO60MRFTP9K985ct7NwOBPf98fhEuN1awwq20Lb1
	YQGksjKpy02TDUfGjXz55LvQ0Q5ZfOHTuTFDILK5vxRs7IgaYPOsMqY=
X-Gm-Gg: AfdE7clMrIivPFnLWDR5O0Td941y915Hbb+TodFjHpUFAAqe6NcR+83ybkojs4Sss5m
	iKXASI3/tOAADH+YLvHePFf/Lpy9P8KrcNGY2r1x8xCQu1IEkDsyVyY4evrX9nm2oEgDXYr/gvy
	Z2hM7g+bPrC9AiJP/w05YU7R0qwK1KZYZVvPlTtfQXJ8j9zWFUpgyVd7i/glMbQepb2FlGmgIzf
	ojHQzE+oQYARUUabs0Qf2o5o7gduWOE25f3XmmjI2JczbwQsIny/0SCqGkQEATMb0jCByXT0kZ1
	J7BU8n6vvN2txpuLlc3kDbLwk3Vkox1lLcBZH/F4egp8rGsU3TLB/WkdnGsDSquxciPmdL92MRy
	Q0LwHgHv1fjga6xISkOjFncH2r0hCP27bekckBV0gCzzQ+yxIjhchofkMUEoDvcVhfJoF
X-Received: by 2002:a05:600c:6050:b0:492:2e48:81e6 with SMTP id 5b1f17b1804b1-4923ef4ce21mr39156735e9.4.1781866973321;
        Fri, 19 Jun 2026 04:02:53 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650c115fe4sm7278073f8f.36.2026.06.19.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 04:02:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: xukuohai@huawei.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH bpf v2] bpf: Reset register bounds before narrowing retval range in check_mem_access()
Date: Fri, 19 Jun 2026 11:02:51 +0000
Message-ID: <20260619110251.2576334-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

When the BPF verifier processes a context load of an LSM hook return
value, it calls __mark_reg_s32_range() to narrow the register to the
hook's valid range. However, __mark_reg_s32_range() intersects the new
range with the register's existing bounds using max_t()/min_t() rather
than replacing them.

If the destination register carries stale bounds from a prior instruction
(e.g. BPF_MOV64_IMM), the intersection can produce a range narrower than
reality. The verifier then believes it knows the register's exact value,
while at runtime the actual hook return value is loaded, creating a
verifier/runtime mismatch that can be used to bypass BPF memory safety
checks.

The else branch already calls mark_reg_unknown() to reset register state
before any narrowing. Apply the same reset in the is_retval path so
stale bounds are cleared before __mark_reg_s32_range() intersects.

Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
  - Use [PATCH bpf] subject prefix per Jiri Olsa review
  - Rebased on bpf/master
  - No code change from v1

 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf281..6de9af4115dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6196,6 +6196,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			 */
 			if (info.reg_type == SCALAR_VALUE) {
 				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
+					mark_reg_unknown(env, regs, value_regno);
 					err = __mark_reg_s32_range(env, regs, value_regno,
 								   range.minval, range.maxval);
 					if (err)
-- 
2.47.3

