Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876F3ECBFD
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142451; cv=none; b=gUD0IAXfGPUSWJYPUnvkAE6xLcEHdXvcfKdXtwliv3VGhu5aAy4z4N3PuimcYBoMMfCCNuYGli1sMjKmiNXxkt2a4giZl2mcq1duCE7ZVWxTginlLpmwtT3R60AQFyUnsqk50Zr6wSjSDQdDZ7s5IMDnQzhZQV4M9xzpRAggDMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142451; c=relaxed/simple;
	bh=iUH9/UD8/7S1+jAVVqkvS7L4QSQvS74xeUoUdPdp8mA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RQQrU7rf/I1BryJfCo/2bx73vKOlMx7+ei9ZKTW9W8YX7M8XAE5PPCHPC9MwRLBX9czeJ97BqU08mcSu1fUZxxpOmeDsucPUwxq9GqCq0UTm0Ji35Gm7kHTQYCebF9pXcB/bUDr4ffTQ/uYMKMARNpxJsYP7QTxgrU+8VHgVcD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+dkIbaa; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+dkIbaa"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfd96354aso665281f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142448; x=1775747248; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ayH3Eg/SuwAlbQzWSq26PLk7I955VLALeunBogkb2M=;
        b=P+dkIbaakXNmAGz56shXrJN3JSfZVcXPv5dBJQhFMogdPif4yu1G2zwsGU5xrp7QIP
         ME8GOGcs3fPiMyzdEYvFRKBKN+y14Pz2VWmieJsJf00anJLz0moF6SW9ZPBkJv8+dJGu
         XHvzlHb2LFDzUS0QeRVoJop+auq24CVHXBplbN/Z3xy0bNbCPrLzg/Z9szMr49JI1DVt
         lMKWDLyYDpQPNaRP9hkwXeFyoHEtj2YdK8QnEvV5c8zk2BBXZRtXJirH8D5KEnfLfxqX
         4SwgeUZ/La8yunMGXcVHWEaDuBKMOzj1RSAxPWpfjDFuQ7usgfXu/wtL52coNv7SE0lX
         jw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142448; x=1775747248;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ayH3Eg/SuwAlbQzWSq26PLk7I955VLALeunBogkb2M=;
        b=H15GT7Q+s5ya0tv5bN5dVj25I7c8WFSjiRzFcvgcMe4RHpU1n3WohvYOjtV8eHwvNc
         yE/bn/WJmz5cQ7BclGuAtwYWKjqaEwOxzQSDXTBmSzw+t2VT+h7EosH+G4Lt7m7i2s+H
         g6UpTqBnlc1UHe+sTn0KPRaRoR1ZzNCBK4mD3ac3si+I76sUt+5pT1cmtfwYS3k9vUAS
         y/jmDbEsQ+Y5+g+RfVxCU/pGbFF/zR2HIfibJwzVzQVpK32jmX7LRruo4ZRI4ZhsCFLO
         zf0/hWSH++srVUKjU4k2/FkmH7HAIJ52RqqZBffHQzHi+fjPvW3FtyAWmesgS0FRj5Vn
         MRdA==
X-Gm-Message-State: AOJu0Yx4RvxuvWwk3DZMp0vzyiItI+YG/i2So4ioFaobNRQPy67XJb2v
	jBM97CsWlhgw2JPbiGOY9iLhiBAhDyTc1uAeyxoy3c+m1ZCPWubeeurqyBkbBjWP
X-Gm-Gg: AeBDietEqSM++A+RcX9bcqXWZE4pE8iq1lHdkwtNGmC38YbExUJitFmJYOA+QOyemdB
	uR+eaa3qNvhnIiReSXVsA5KSnJzw0RpsckYhzYBXdsY0S15aYBcLded0y827JuuQdylwVKTgETE
	lvSC/WS552kBzQvBb+wTbannokZ7SVQbaLIHdEywS6fd6gwesqAkR0x+9Kc1o3dJtM+aAl7kb85
	aW8j5uk9wzu0d1Oem4qs8DRd1kYE66Vw65lAjFjylqqPS7tawnHyDt30Xxs+nyvfXO4jQiww1x6
	mMO9TnJBd8BGeEF+uovPj+MpP/SnkzfZzSomZ1mPQfjraVz2TrLatS07n3oiuF8UJeH1uZaJs5p
	FA0/KSc1gn6vz2mKVwDA9c7z/y9PTWbOwrzwOsNLwjNqmA0O9BD7Q5uGaAPysiGOCHFD9gacMSr
	j5cxP+3pKvhRyRqDiop66zMXygsAtylF8DIVHf/ZQHhHGKecr7U7mA+VHWwDBCn4fzmN9yQXqG7
	av8F6zLFMt7QGDGmIliID+G4AJuhTMHjxLK5Qlfn3PxhvpeGUC9+V8teNJSS2J7cNle4RTktjS5
	A8zQBFghIk/SfYDJrRgqWf98+W1ktOxaSZ1CFWZHtJk=
X-Received: by 2002:a05:6000:2307:b0:43c:ffb1:2214 with SMTP id ffacd0b85a97d-43d1f1c38f8mr6699774f8f.16.1775142447643;
        Thu, 02 Apr 2026 08:07:27 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00981c6411e4c4d8e7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:981c:6411:e4c4:d8e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f5bsm8054238f8f.7.2026.04.02.08.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:07:26 -0700 (PDT)
Date: Thu, 2 Apr 2026 17:07:25 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Srinivas Narayana <srinivas.narayana@rutgers.edu>,
	Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Subject: [PATCH bpf-next v3 0/6] Fix invariant violations and improve branch
 detection
Message-ID: <cover.1775142354.git.paul.chaignon@gmail.com>
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

Changes in v3:
  - Rename and refactor the helper functions checking for tnum-related
    invariant violations (Mykyta).
  - Small changes to comment style in verifier changes and new selftest
    (Mykyta).
  - Rebased.
Changes in v2:
  - Moved tmp registers to env in preparatory commit (Eduard).
  - Updated reg_bounds_sync to bail out in case of ill-formed
    registers, thus avoiding one set of invariant violation checks in
    simulate_both_branches_taken (Eduard).
  - Drop the Fixes tag to avoid misleading backporters (Shung-Hsi).
  - Improve wording of commit descriptions (Shung-Hsi, Hari).
  - Fix error in code comments (AI bot).
  - Rebased.

Harishankar Vishwanathan (3):
  bpf: Refactor reg_bounds_sanity_check
  bpf: Exit early if reg_bounds_sync gets invalid inputs
  bpf: Simulate branches to prune based on range violations

Paul Chaignon (3):
  bpf: Use bpf_verifier_env buffers for reg_set_min_max
  selftests/bpf: Cover invariant violation case from syzbot
  selftests/bpf: Remove invariant violation flags

 include/linux/bpf_verifier.h                  |   4 +-
 kernel/bpf/verifier.c                         | 201 ++++++++++--------
 .../selftests/bpf/progs/verifier_bounds.c     |  51 +++--
 3 files changed, 148 insertions(+), 108 deletions(-)

-- 
2.43.0

