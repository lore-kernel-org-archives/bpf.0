Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D093C872F
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442409; cv=none; b=JvCHuyRHi6lDehK+tisoMZs2Un/sw9RQfRmBivYx04t0CKdjUvR9QELHJtFX1j3rbOEFjSfKm10yh/AnuLBdKkj0l2acutuSsrKgNaBe/LPa5lOwoeyLG1EVBjusR7knAHgNi+ldlntBsfVhjgFTVK+TtbBGlqLJ3+JELjh3Fh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442409; c=relaxed/simple;
	bh=oicMRIDMquVSdhV+nyUcbfFUP+uFr3c7n1xFK4x/FTU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kDDL0/shBjqWlnBpkQ/la3j4lXVrjtja4S6b3MAfKA64yw1gKPFCrHIqpmiFS21p61SqrANS1FP+jUmxtOO7ixEwBWR0ooBhoyDSJZ+uY/zuxXXEKFRgS6O+j6kHj9S/vfngFgtiZ4XHuEGyntkzB5YdlXGRgePAFv9RENVmCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bTHz/ys/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTHz/ys/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48534237460so29256855e9.3
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773442406; x=1774047206; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDGpGzqG60M9Azdh5alR5eRheOMpxSNLCkqlQt8tL3s=;
        b=bTHz/ys/8J52afVo2FqTqKtUf5viHk15ZfhZQeruPrH3IYN9foMUkprJrvaec0wcbj
         Ku5mflfDWugqVk1faVik8otqf6eqT3KgXOX1N6nhR0pheifmvpeOH54t4TlbZXJACzpa
         Ykp59nEStdOkmv0wAKN3XuubDXzPYElJM4NRvj6n2FwyJrsnNDDgIjQKYWkxeGnEqyQn
         9ezb1n00djU6om93C7H6vfV9MfLZDrr+dkl5mYC1Le+UqKPtxl/D03pwc+gvod35Ktub
         aks3+cCpS6cYpID7kTMqmm7Fzf0V06Ejs2i+F+q+OaceSFkFbiOmKZJ8f1aYhaT5Abpo
         Q4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773442406; x=1774047206;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDGpGzqG60M9Azdh5alR5eRheOMpxSNLCkqlQt8tL3s=;
        b=ed1kOt5iFGuvFR9MOJEzhZmTMYgyG3bqTotpOC+NEEnG6LgOwTclCCZyJijqVxK1+o
         FLo2iqJo1DhKw+nkbY3ZPt86k7c7CXUusMsMtR43WKzEjebEfngEAEkOUr6jap46MQOk
         HkadV+Ue/icR0d27wJX7JBvFJnQAXZXeIn55q4vobJjxzQx+p4gi8xsjz0+RCADzGFSP
         HM4EGY4XfOQZqEKKnwgqwXTLP7PRqp6mW6elElQlAZ9nJ1S2hKHEoCuyrJ9rNudx4+1l
         e62XaPP6I2bBHLFIJkA/HWdd1ECYQYAeGsySMYs4D9jxFpIBeDKtLY8InZ9EpEqc+v8/
         IDzQ==
X-Gm-Message-State: AOJu0YyRbLo8jiWKKDeTlzm9jo3gsVWUbbEDhDblt7RblOijTJ6wJRd0
	pd7E83XocmllYXTit/imonkLGKY/mK6FwE1BIde+xO0kX7Xzt9VYOX0SKsG62A==
X-Gm-Gg: ATEYQzzaWa/VHhfJJ6MMqyCaMFf67xF59THbWyZoA6XJMD94dEOs1TU3ur98qAt7gE8
	G1htdoN0OBsL1rx9HpOKS88N2vXzerw/rFUZosIW2JwAdXHmJAPcDqZT8W/EI5u8pFLxwCMlq3o
	CKN+x5FPYKYDrp3SAFy6oefYdu1dzsKax/26VYNiPLbvArNaIp5gLlhpPMxGsOS+AUYt7gUG76j
	L7DOOgxasbAOMm8orTO4S/7eYgbets/8BkxqdmGFObOwQ7ToOSkyze4wjynWiTPUMYnMpThkwjS
	s7DFw+vlyt92ROZnA8R/BhfpqQq9q14a9yFK1oWKrWseKMlfdZD7txKwWe1rPPjBgx3FA824DE/
	MrJBrfkjaHNlBQVWT8Tke6XuvJzL+rXgzZ7VVoUPxceAHsqAPxKmSwdzDG1yuWFG937Teij0RC5
	CUbs3AUY7pCyJ94GFWPLMOEtfBau/8nOZ7u8YMvDIEh1yM2Tqaojq72VUcLKKrBmpq7aH5maUrP
	K/SVR0FWD3DxZDfZqpLR6Oz5ZomkCkTMZ+FR6BHIEOWjEtSr+OSh+KeBrH6rIZJEokcRXwazUp/
	mUma7DTWAio=
X-Received: by 2002:a05:600c:628c:b0:485:3aa1:a7f1 with SMTP id 5b1f17b1804b1-485566c6a59mr77833965e9.7.1773442405844;
        Fri, 13 Mar 2026 15:53:25 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e001bfc1843b6ac5345.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1bfc:1843:b6ac:5345])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6700fsm28471115e9.22.2026.03.13.15.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 15:53:24 -0700 (PDT)
Date: Fri, 13 Mar 2026 23:53:23 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next 0/4] Fix invariant violations and improve branch
 detection
Message-ID: <cover.1773441432.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset fixes invariant violations on register bounds. These
invariant violations cause a warning and happen when reg_bounds_sync is
trying to refine register bounds while walking an impossible branch.

This patchset takes this situation as an opportunity to improve
verification performance. That is, the verifier will use the invariant
violations as a signal that a branch cannot be taken and process it as
dead code.

This patchset implements this approach and covers it in selftests with
a new invariant violation case. Some of the logic in reg_bounds_sync
likely acts as a duplicate with logic from is_scalar_branch_taken. This
patchset does not attempt to remove superfluous logic from
is_scalar_branch_taken and leaves it to a future patchset (ex. once
syzbot has confirmed that all invariant violations are fixed).

In the future, there is also a potential opportunity to simplify
existing logic by merging reg_bounds_sync and range_bounds_violation
(have reg_bounds_sync error out on invariant violation). That is
however not needed to fix invariant violation, which we focus on in
this patchset.

Harishankar Vishwanathan (2):
  bpf: Refactor reg_bounds_sanity_check
  bpf: Simulate branches to prune based on range violations

Paul Chaignon (2):
  selftests/bpf: Cover invariant violation cases from syzbot
  selftests/bpf: Remove invariant violation flags

 kernel/bpf/verifier.c                         | 103 +++++++++++++++---
 .../selftests/bpf/progs/verifier_bounds.c     |  46 +++++---
 2 files changed, 117 insertions(+), 32 deletions(-)

-- 
2.43.0

