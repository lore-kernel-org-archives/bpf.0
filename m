Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01937BE81
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 06:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791959100; cv=none; b=YfNnklzjfuCUw55s9XaLh7aMliR0NnfPQsgccpVdPqK8K9DbCrhaHUTAi83dsmjcMXtsc/GyMTfDp49yulaGJTrYdnZJtw97DnboxejxViX8TsHzoVrFvu6i3WFjBYqHcyP9pOCmgfre/0SB57wXo1eN8LCUZbBij2R1UGrOboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791959100; c=relaxed/simple;
	bh=wT9KfUxDTOAu89c4sxAb8wXWXUXJ/Df7bwfvcjApo4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nb1CnEwLUxFJ8MvVZmu9HQA7tGDp4Vyd9BhzIbYebD7AE5RrWghK4OEbVUVJ1DQa76eTC8L/nRa/LnKGBMJz2BSEk0Aanf4jWb8fZ9kOlT6xzM9FxOx3fUehfdX2JZh+/afgijn+g1rOILT2fGQfLUnhY/XxaDVtMMmTmCZnVYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2/j8RAz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2/j8RAz"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso47967a91.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 23:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959099; x=1792563899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O77XLMAdbvfeLp1j1TgVELADlqP4W7JqNL9jlyw258M=;
        b=J2/j8RAzN3/N3XzP6EvnuCaPcCZ7GfAJb4lEBga3k7HofUB5Un22H45IkyL06tVzlP
         1xEn+NgfCGyZJ0i/84DBDw/XZpchpt7SXEVZPhwOQc/g8UxL5YeeaN27OrdcNDZad2HT
         UITCJBGIhut10agqNHB2pUlmo1HXcgTN4hYBuKlurtG1w4YHn5L8Hnrv0l5l91qde6DE
         3z3pfSL5YQLkclYzesqI2XVnwN3l32lDnEhBkQ+or+KptHvuI53AVvX+2VGQNdFyrz8o
         UgBKrKYM8WTLOje0+HS2YvnklvZSFiml1C1abm6zv9PHvXVR+3GIJncxbuS/4Z1/hqxk
         CZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959099; x=1792563899;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O77XLMAdbvfeLp1j1TgVELADlqP4W7JqNL9jlyw258M=;
        b=qxrbnKIrTRd2xhwwz0Zx0TzERpDwUv+WlgIni7upZbvckweJSChDQP3ki2OG10K6WK
         QvOdyrMstK+BjlZFblaXqFueYcC2xr5SSGqeCwKCIBUze/aLsQW1Z1nQZ4y9P5LO3l8e
         cbf3txDbwT3Y0SJIM+DpAHL8iueNHGCjxYuW+EiB7ZdD5gvyjkhG6uby30m+mUFzURUd
         n3wnWO+/gCzXgi/Eoy5QoStL0Lb2+E+NCSNpRkD6sDev7djBEtdnDRnaRvlwsu8ejvlj
         I9yda4/O3O+yQjNwQKuNXJtmVO2Rr8gYIWhXme5n2XW+chMkhpIworoA7/uV60I4M0AW
         o1BA==
X-Gm-Message-State: AFq9FYLYZKImsUU3OVJK24OoL84+c4J6PmlrRHDoTZWBRom9P8pdkKcY
	24OoD/TZM2nBA3rWiyp7CrFIfM0BNQ4RmtK46yA4ajQkINpL6SfAnLKtijGGzg==
X-Gm-Gg: AYBFou09uVvAMogj9g/Gb+Edu1b5wKZnbkk8sFmNvwGhHwE5rADEL/Ucg6v8BuslO2H
	DLxmGIeCNyv+l5WlDKYHTiu0+6kQwTC5jqpqATYi0uJ5ibkJq4g710hx4DQcE3aUF0iGtBvlV+a
	VfZEJ/fRmufaiaAiUOhZwTcy+VTlvXEh6TndUHQUDKAFC02BAFld97bHPHYuT5WeAoo6wokRwSF
	Vbbs4zqTxXLI4h3bxGGFGyBxmGcHwxSAjPluEMf/+uu0HUKvNO71nw1hVKanoAgel34qGM9I9dT
	pNLTfBw0zmET7F8gZaMyI0tl2gzf39zyH1NvW16/dm3v1gnuk6bJYjEXNELUYakeLoPRkvjXTIM
	2f2izWvb5sayYnuvjRVT+1D1CifC76y1o39g9rHGRx/9I7/6xdVkBmxIw62tT4AzPAIxQFvnERB
	fhmuqQ8h1lRyGDjS0vY77F0PFXrmbzugHSuekaSGvoogGZhlZLzQfjza5ca74uMmj0lCUnVJ40L
	IlmVUMSez6bXoVj
X-Received: by 2002:a17:90b:3b84:b0:3aa:f4af:1e16 with SMTP id 98e67ed59e1d1-3ab3a4871e5mr12385990a91.7.1791959099129;
        Tue, 13 Oct 2026 23:24:59 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e41126sm6614238a12.23.2026.10.13.23.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:24:57 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: BPF_F_ANY_ALIGNMENT for byte_array_size_spanning()
Date: Tue, 13 Oct 2026 23:24:42 -0700
Message-ID: <20261013-scev-minimal-v3-followups-v2-7-6d9d61965486@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
References: <20261013-scev-minimal-v3-followups-v2-0-6d9d61965486@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The test case indexes inside `char bytes[32]` array with unaligned
offset. Use BPF_F_ANY_ALIGNMENT flag to avoid the test rejection for
unrelated reason.

Fixes: e187fac8ac6b ("selftests/bpf: Tests for varying offset access to PTR_TO_BTF_ID")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_btf_array_access.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
index be001cc77f81..9dc2c9a5f8b7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_btf_array_access.c
@@ -114,6 +114,7 @@ int long_array_in_bounds(void *ctx)
  */
 SEC("syscall")
 __failure
+__flag(BPF_F_ANY_ALIGNMENT)
 __msg("invalid variable offset access into struct outer")
 int byte_array_size_spanning(void *ctx)
 {

-- 
2.53.0
