Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E8F24728F
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992959; cv=none; b=tMNyzjVv0pP/RyZXZB0nPTfgHF6WnzN1/Cq7YezEq4eOXop4BTg1V1u5RcKOemE6Gx3nsjcIcT9owLMX3wUF8bu++u8ASkwpWJ4aH6kR/PyJcSPnk5BfMD1cIo3KPP4yQiah4eNK70Ldsn5meAXXCQArIqG5b93czvXpplz/+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992959; c=relaxed/simple;
	bh=4pYEruskr2d5VFzGjNuVUe7W6mzTa0jzLorw+2jLBZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDOfhyE+CteypOtOyJU/pgufbz8ZDwcsjMEeCHh4a5lDU6ekCCmGcWmciY2oJfxxHDJskeGBpYJrZ6nybE0/MN5C6+/LzHK0aWMiWjALj95Py37G/U1HKu+vKNf7gAflxp9oadguqmbL+iWITm7yeZGZ1BjwvJjHMaFERUyxtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpZQA/h5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpZQA/h5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b23f90f53aso37884945ad.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992957; x=1775597757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3y2Y+nTHjjkMqGWc9KTbb9zChmURp4PZDO2SmaDULME=;
        b=RpZQA/h5wuHg/ZKDU+6gQar1K65OXJ+52+fUf7I70GQata4PerOvM2XeBL4QRhMncR
         2ZzHtgwIBPouQdX05TeN+j+82gnLWhNhQEJo7OYZY4tuETZgWyPw5uBSO8CRbClvHyaX
         GE0XZNhhs8ABbaxiHNhO5tcEb3c9RznO2IvE/BELGArYiLF773elsTRGkZcqEUw+cq/z
         0EbbqbnBA4JlO+jSHOE5nnxgsFw+wmTBuSz+669C73QkTJFp33cIKpX29RKTxLqyRZqN
         mqoWfd5IDRkkHvMgbgmvaAMaSfSY/PNzjDUk4Y0aENCXjq9lboM/SiopJfvXYUrWp8A5
         R1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992957; x=1775597757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y2Y+nTHjjkMqGWc9KTbb9zChmURp4PZDO2SmaDULME=;
        b=qXtvT4rkw18Xrp9DW+f7Uw88F2DuYWYi7rkrdKxjOopi5wDTnpSDHbfBaRyogzEqSo
         bYhPv1eweRa/vx9r2AAco9VPGY580Zw8UU9ilvIhpoPVTYOzoqqLgnpgBO0Zo5ki3zx/
         6ibSeKKr8QH2TAZL1mn168B6dwbjoiYmXftngrQX0jo+UYwjf5Je6yy81SgTasx8STrd
         kSAD6zphY3Ttwv/4oFvjWm+CmBWIyxCHR4XWkwVQxhkO2AXNMqYIo/Tmw38EU7+G9DVI
         dbOAI5uZqgS8gJ9GvM4ov1WfHY9F9sml3oQrJhHsZemVX8l00QAmmbjDOFEFvK5JW/gh
         DgHw==
X-Gm-Message-State: AOJu0YwE87CKrESpQHRI9WjqfHPhUkzQev9LTFOvZ+0ldKrDa+926a9z
	xjIFSel/ZeEUDE4bgQlzcrqFfu1DL5M8fgUKZSS6BlcN5lr9OW7jSB0HjKnPmA==
X-Gm-Gg: ATEYQzyqhpFENmZxpcnkCA8maWOAueYCMSH+Kb9z/PRTOdEc1DX6GBCgRjnp09Dx7Sz
	YWDNPp7XaKtAIHbRvPfxibqiaQJwkZbd3yXpd2Tc1S30qaPU3UsTxSdjhJ6EjvNN0Zjrc6nl8QZ
	nmbTYv7RhXA5+ZUnui1G/ybBCSBck02iCRe5huuyP//l4SGw9W/kKLACgHf7sWjIZ2dIwl2By58
	i62PmVWEdsBRpLYDIzFfJ1gdJd7MgGY65AmcM+NI1zsFkLOpzoHQFXOUCoGSxccpbXb07bCo+hH
	Y34iDN0zXkndFw8gZ6F7JvQ2CXlGeIK8zgR2lQnc7Nz94COH4RKMbUSC0FyrQfCEajif+BNejLe
	x/CxSnA20ORFpPP7T1NkJGamOQFQ67qF2ZHyq61oxvUi49W847remLqWwxMAxOCsbQet6t0/BXi
	ofeWkfWEef6MonUg==
X-Received: by 2002:a17:902:d58b:b0:2b0:6f21:8289 with SMTP id d9443c01a7336-2b269cffcdbmr7677175ad.25.1774992957516;
        Tue, 31 Mar 2026 14:35:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:14::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24279a428sm158469155ad.66.2026.03.31.14.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:35:56 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/5] Task local data bug fixes and improvement
Date: Tue, 31 Mar 2026 14:35:50 -0700
Message-ID: <20260331213555.1993883-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset fixed three task local data bugs, improved the
memory allocation code, and dropped unnecessary TLD_READ_ONCE. Please
find the detail in each patch's commit msg.

One thing worth mentioning is that Patch 3 allows us to renable task
local data selftests as the library now always calls aligned_alloc()
with size matching alignment under default configuration.


v1 -> v2
 - Fix potential memory leak
 - Drop TLD_READ_ONCE()
 Link: https://lore.kernel.org/bpf/20260326052437.590158-1-ameryhung@gmail.com/


Amery Hung (5):
  selftests/bpf: Fix task_local_data data allocation size
  selftests/bpf: Simplify task_local_data memory allocation
  selftests/bpf: Make sure TLD_DEFINE_KEY runs first
  selftests/bpf: Remove TLD_READ_ONCE() in the user space header
  selftests/bpf: Improve task local data documentation and fix potential
    memory leak

 .../bpf/prog_tests/task_local_data.h          | 97 +++++++++----------
 .../bpf/prog_tests/test_task_local_data.c     |  2 +-
 .../selftests/bpf/progs/task_local_data.bpf.h |  2 +-
 3 files changed, 48 insertions(+), 53 deletions(-)

-- 
2.52.0

