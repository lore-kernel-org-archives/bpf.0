Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CD256C8D
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775866635; cv=none; b=n1oXdlhL8jVAXQNWFfDx8f36aThHrwGn5qvFmNKbhhSLFlapK79sLbyS1WSJHAvzc4cpS/uMisPlKJlY5k54nMnRbwbaw3x/qFx8IsPyTw/6uImHT8XNzoF5h+bAMBLJ/KFcha0mrXLikA6ZefRzri6JUKMhntnH+nTmIXh4D4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775866635; c=relaxed/simple;
	bh=lwr/BZdnzpyNNg2NwLakVIP3TG1oh36S0z/Hctq4hHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l/o8lSbVGSrjnHOBODV6aWYqKWsUsdZJdNMHct0goS568Fdk3Eamjf3ww1CLT+GnNFDj6+GCSJ59YvIXaBcLFrJvL4dbJ8ggxwOzwP4vbcd5zILF694wlV8m9zp2L5y/5cKpN+LDe0egaj3/TGJcQbLB0VS10yrHPMyecY8QDyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gA93PnsL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gA93PnsL"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82ce49785a0so1225901b3a.2
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775866634; x=1776471434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGroRrPUmeJuw2t/fNDoydAUsIKWbQ4ohVi9Js90EoI=;
        b=gA93PnsL7T7q0KlPK2wAnNDdFebFyn1RNvffNGstJKOvHc6N5FavdX1aMbCQOdUt/I
         WhgtbPeWyIno/U4uLxoMedN7a5Keu7uQJ7ZG87xbvQQGXvzaA/EU+hq0u3aaK9xm8MqL
         krvS90GXzooMdLukcV+PUhTJb+aoeNqit+tyGZROBHMq9SJ0vuqSrNzTeUYZ+B5sIx0i
         u8/h+Omwq9z+9oPCS6/sPEwy/O/8DBxGUMbD/PHPqTwAxRwJcf/ctNskhgtsgwFKvF8V
         NLKgRBlJv89QBynotVABIZKdHYXjr+ewwotQU81XhxdN2HwmHbdyg9rL0vKcxgr+XSsG
         /thA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775866634; x=1776471434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGroRrPUmeJuw2t/fNDoydAUsIKWbQ4ohVi9Js90EoI=;
        b=jl+YRG3Zcw7gLjWpTExlIbj7Zwxcy62S2YOtjRDhX4WQ6Q60Jw7tLiakBtOfwxcAl6
         30No2ugLVD2wZUSZCDK/H6DkdS+r7aflTD3whk4Q5KkX6renkOQH+VoY9zwtb5f3o4mR
         1+H+ALNUBWCByKLYcTcGmkCZPjiN5JGZbsO3J3PfNihaX00XJMhIxxh3SC92648rZtwk
         D8XiI3ew6+PTa0iSLLnRhnyXCYPlcvDcStttXpFTMkgGRDC5ykS5+ZkVU4Oag+c3VTJv
         cQa96g4Dn0Ixk2CjNobTO/5p5KoZZvTTtFXR8OFojA4E5vwNgxyHVb5lxXmoxGBepRXU
         b5oA==
X-Gm-Message-State: AOJu0YwkocSsW6KClRk37MwgaZQWw8gFC2Z1ISTBWGxE24K5OkfeCdOK
	V2FnHVSHsIVRiFzH4ys1qiAEDRveFdX0Eyc6wsbars5jq787X6bxdWk89uv5FA==
X-Gm-Gg: AeBDieuFeZn7Z7QQgFT+1v1XtXnqbGFF5qoUGkPfxAXKYJFv5UDREu3tlwSILip2gfr
	MKp8hOppVdMCBuYsQ8hPsKqUsc2B89DAxshOycxC806ohH/IQo/mrwU2r4YS/MMosiaIKHldVoQ
	v3eto2tdo8Zp8vS063YQBJ8xZCzyBL/34UQzpyDDFE65gAS5USKOR9vOayKNoV6SPkAdSaUzqPq
	hO5TYxUXq9/yAJ/VoOR6bAYG386+zJ26+1oJnZB7PqWiKz9QBqZLh6kr2vC4iWzkSa33EHLplG8
	Cj3FSIJRo03u4J2fwhDxb+AxK7zZdX9eD4dfAx+m/M/XLFHWJZ//cBBaLWt57nkAE80rqvVAt1W
	99gjmIrmw+ONg7RH94P3zRYNx7hxK36XeUv665sFMejvXQN71uHlVkeLXlcX3wNXo61BBzOHtU9
	ClLXH7GbLMga1X
X-Received: by 2002:a05:6a21:338c:b0:39e:badd:c1d8 with SMTP id adf61e73a8af0-39fe3f3d7c9mr5409820637.31.1775866633992;
        Fri, 10 Apr 2026 17:17:13 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b3b29sm4016549b3a.36.2026.04.10.17.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 17:17:13 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/3] Use kmalloc_nolock() universally in BPF local storage 
Date: Fri, 10 Apr 2026 17:17:08 -0700
Message-ID: <20260411001711.3418264-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Socket local storage did not convert to use kmalloc_nolock() since there
were observable performance degredation due to kfree_nolock() hitting the
slow path and the lack of kfree_rcu()-like batching freeing. Now that
these concern were addressed in slub, convert all remaining local storage
flavors to use kmalloc_nolock().


Amery Hung (3):
  selftests/bpf: Remove kmalloc tracing from local storage create bench
  bpf: Use kmalloc_nolock() universally in local storage
  bpf: Remove gfp_flags plumbing from bpf_local_storage_update()

 include/linux/bpf_local_storage.h             |  15 +-
 kernel/bpf/bpf_cgrp_storage.c                 |  11 +-
 kernel/bpf/bpf_inode_storage.c                |  11 +-
 kernel/bpf/bpf_local_storage.c                | 146 +++---------------
 kernel/bpf/bpf_task_storage.c                 |  11 +-
 kernel/bpf/verifier.c                         |  26 ----
 net/core/bpf_sk_storage.c                     |  19 +--
 .../bpf/benchs/bench_local_storage_create.c   |  21 +--
 .../bpf/progs/bench_local_storage_create.c    |  11 --
 9 files changed, 55 insertions(+), 216 deletions(-)

-- 
2.52.0

