Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226D1BBBE5
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106982; cv=none; b=biQad/IbrTwO7ZuG9eqJyIm1/ngU1aoBQ7L8UGRSL5lWpRfbPNCWpSQor8ISFOYcVAs8d6c0q6eizynEEBd4x/WRkv48FjvdGYtchNtBQgs6c+RSSroDcCg9tyZjP3cCB3fgK7602J/xKqQB9XFfjCiec3jyCZtu4omZgylmOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106982; c=relaxed/simple;
	bh=3YNnHNzoRQBEKeQfH7qO4P9qrWEQ8S86M2M1cS9RSUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yoz9KEuzGcIf99jlLfTj73Py6ZOIu8uWzgS347/r55ANDwVafCSGIw7MCfkdBrXoYmPux3C0SMwThseTFnfq3i8+Gi9ZXQ5jZ6oJh5rgXnFpoXpI66gPP8t4V21Ns27BTooZ2HDrlTEYVvuyGr33HgjrxhebVojIR7RDT15otdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrXsccnt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrXsccnt"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so539272a91.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776106980; x=1776711780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQIBhE9cQY6rnR7Ha5FrwWAKM7NUKPJp0JpQ1iItgcQ=;
        b=RrXsccntvss8ceSGxVPqtHdXjw/UR92fvNFM7sTzogHrCCGFeOZ+6x87uJsfseKYr5
         rSGKWxoqVWxsweKh49YArjmnPC6dqPqgn77AWxWMwuMC7AFgUOFjhL4VxHWYxpI337Lg
         fWJ9dwMsMnvgbg74Cb4nzlKEV9gjjfOl6O8UXhVgYUxxFgYoHFfWHV9sXmETKjVcDL8T
         4R/XzSMFbyj5q4rEP0epyPU9f1CZgn79D45eVJPEMQHTNbSA81kDRjtaQNU04C+B5P/H
         BBeV1QVIobNa8LkBESH0uqIyMcWzhZqXddyjSSUAzQ8JjhRlnC/wCLr/nC4L5IQsvCzQ
         35cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776106980; x=1776711780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQIBhE9cQY6rnR7Ha5FrwWAKM7NUKPJp0JpQ1iItgcQ=;
        b=rSCjvsnyBTIDYDZRURPnSuSCEYSgeGN2Z7KL6vxCMyoxo5obzEvbP4ZkocYYNHj8bb
         OjtdulE91fbAhrSZbDRRfghvUvv166eX5N2p5fsmCz6OJ3f01B9TZGIZZ33GAqFxcU2/
         msJwvhnpW++txsrXQpbQHHIFokIWh9JeyeFHRoTyXrVVpdKAnbHk6dbNkMtt01EUsSpm
         +mnJ4JhcieHXrIrwBPWYtAIeiJxuuGvkJFtk6VmB9DbTQpHvyqAKDcpXHxJ7EaIPJffH
         RZWXoL7JtohTaJcn/m3NrBwwZb2dsEJ5Xi+NBY3okFlkA9clR6p6A681SPrcgBCJf7n6
         D8mQ==
X-Gm-Message-State: AOJu0Yw9UK/X2HmJrREjmmyuCThj/RVipkclE8pEWB+w5ywocaiOiX4N
	yovol6J68BvR8ktzOVLROL1XOPgkOBjGd5jrzv7yusoM4/kk0vGqArcvL/gcOw==
X-Gm-Gg: AeBDiestyRXonRii2zL+CvG8/TqeG+ARXOF4Dy5BPKIxP/kIA3n78E2Z1th7CKqtgHf
	CdnYSOSpkxAWYWywAkDeBd3goXBpgmSdeRTTpL8O+CxdCFFrqnZku6wUkPbJcns/GLutiK3MDGT
	E0Tvg9BT0OAukFw5eoD8a1W9g6VLM2UVVsUpzrSnmcnU4j0hbJAck9mmdtPDkfyQOZtb1UBLuBl
	hiCNcv2Xir2uHvOVewELIJl6iBzouWhsX18E26kXq46Vasy13FR/Zr7L109l3jhI/F4WzJkn5aA
	ozDlhb8SaM2QO6SkihWQ0C35mDrwJXOPXJchgkG0O2v3kHSmJ3H0dvKFkNiU+rrvMzd1TJxjhke
	D75At/bpFwWP1noJW0giTvROS1EfRlMMiaD7m4IMf3Xs2QlnLfwnYy248kckbS1Q5w3IEKKrcRf
	1dvwh2d18sH0NV
X-Received: by 2002:a17:903:986:b0:2b4:5d87:a207 with SMTP id d9443c01a7336-2b45d87c372mr49538155ad.30.1776106980532;
        Mon, 13 Apr 2026 12:03:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b462320562sm32667515ad.37.2026.04.13.12.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 12:03:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 0/3] Fix garbage data in task local data
Date: Mon, 13 Apr 2026 12:02:56 -0700
Message-ID: <20260413190259.358442-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The patchset fixes two scenarios where BPF side task local data API may
see garbage data and adds corresponding selftests.


Amery Hung (3):
  selftests/bpf: Prevent allocating data larger than a page
  selftests/bpf: Fix tld_get_data() returning garbage data
  selftests/bpf: Test small task local data allocation

 .../bpf/prog_tests/task_local_data.h          | 13 ++-
 .../bpf/prog_tests/test_task_local_data.c     | 96 +++++++++++++++++--
 .../selftests/bpf/progs/task_local_data.bpf.h |  5 +-
 3 files changed, 100 insertions(+), 14 deletions(-)

-- 
2.52.0

