Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129B2C0F8C
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223038; cv=none; b=VtXVYut+CtJfJJty7myWL/3k2orqovVsMxQExNjfZ6CNfcWlQN3v/sWR4fW+Ek4k0KXCJFzsZkM+LUuhzR+52BkOH0p7r8KTojGi1cEtJq0guZUwCDiNH1o51BfwGU0CcvkAwfKxwEYKtorNH2B3AwjR0tZuEG/7ygvZywe5Eq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223038; c=relaxed/simple;
	bh=kUAusVo/uIolpu+yA/UcDhl8bKNPerMh4+LgiLWsOJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t973EuztrtNBXS8+KT2zMWtFFkFkmb7u71UL6kDT74/Llg/9dXTunIeKOtEzGBapgwuxiGOKtSyOsQOdVaM+CSvYN5MG1AP45TmrBBq92x9Lrzk+ky9nhdkUr1myM4oG2nQYJ6wzMDSvJ/Uj2S4NGyxjpiQPezYc152PcMAc+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3w5Mwxf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3w5Mwxf"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a871daa98fso14766315ad.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 06:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775223037; x=1775827837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WEANtQJBQCcUlfVrZt0B1u8ohEsvDomvZLJlhxotITw=;
        b=F3w5Mwxf4wSBj7so4Eb/ki+D9kuqX9aDYv6prSCOYLGb2bTf5eFX2W/8mQS/MN/900
         aAA6L0aeCUlp/t8XTTselTRDrfnlYKwsT7YdDm8chtrF0NpE+9Ppkl+wQGz/8UV+Uc/9
         X3eFKaHcsbtLR5cmJbG2bSRNV3jmbx4AQhVxEzSy9EtBiwz5mNdih2U7alYa0XuYzk0e
         CumcaaqBKlD7496TFcdxdFO6+VxiJmegNq/ISizNeuxtetNBW7PBiEr/ftiFycau1p7N
         uOm5WYo85OCn3RFgN87KCMijjPk2UV8KtqFkAMF5Qp+LO8iNbQ1hZEHUkSxWaLLb2c6O
         uY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775223037; x=1775827837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEANtQJBQCcUlfVrZt0B1u8ohEsvDomvZLJlhxotITw=;
        b=sBr2t/cGGsZtATUzIpm5iKrQJuwYziZkrSHtfQ9ErdQZKKgnzYlXVJHaa0en+nSuTQ
         yICgdsLxAHARSaSb1ncY4tyWvumbUnMRCcJXCpRwjlBd+ocSkUN+08N70mjAVGbpadNR
         tWHE7Gel0UUo6Tr0sEtYlShc8BsUiu0HBTByIIltlpetsCxb44okIw8jnsUvUw2Rjs4M
         pPW+7fWZj8q8RBYQY/cdIIFwryKGz50lL0NDcB67BdnjctHKs3y0bGS+taY7SrN5Cb6g
         HrEdorOKyEKUgsH4EkH0ppBgczqGeQZiH3l8kolElSlXMEcpCN2T/jhoMgae/UD3U7RN
         es2A==
X-Forwarded-Encrypted: i=1; AJvYcCUxqc8Pl/JAD42l5cF1cjG/FUM2pqQ3FH9ALgnM2+aEwi0Q22vBmEIVOaire2x7+6Pob/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywck71hGiXOjmHaxvoaoaj+UI0WNkCSWL8w+XfveFWb1kAt77t6
	BMyg6KbJc8CkkjmujgEandXYh7yzlPqsseJIRzpdjbAnIgsuKMzWY2iZ
X-Gm-Gg: AeBDiet+Lpu0ZArDqWw84cGHmp1TF7PDLhsQ2o+exLjolMB563mPqS4LZz8LM83bWYZ
	fdUVDCdkMctD4EcOD+I8IODBeRst9DKnEcSPgd6GUleywc6h9Jy+8WlwoY/g47ZROTEXiTQzMTM
	/XwJ0PCN/UvMH04ZyP7Q2Br+kPtXrBLZGlSsOA8w5kp5RVXAVCeHNfA7mHrlgqD33dRht/efTU4
	orpRK4JQ0mrcREV5+OGa8k7R8m0WOn5CCwcRDBg8PdRCd7/07dfdT+YJxf4e1qFbR+fC2r/qwve
	hifOmDJj8zoVVO8ZWlFM9EI9GRnGDCsfmsQ4/uxbHPnt9LX+/jSSjjmwWbx+/Jt5/PkIkUrU+01
	nXw2TwPF32DMfXxQJ8aZmK9f9UO0PzeMhZPu8+bGXaNmH3MLOR85dfTsalPEhzCZ/1iot7lVLBy
	Gf+IKPHa70fDVl7FF77a035LZX3tsiTvC+ogzbI7XYZ8sr+RNfQ+7qZ100o5IJmDYZFmN/Cd4j6
	WGCSEwdIjAZ
X-Received: by 2002:a17:903:910:b0:2b2:4fcc:2687 with SMTP id d9443c01a7336-2b2818014a4mr34413905ad.31.1775223036504;
        Fri, 03 Apr 2026 06:30:36 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a1e9csm64221225ad.55.2026.04.03.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:30:35 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	bpf@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: fix end-of-list detection in cgroup_storage_get_next_key()
Date: Fri,  3 Apr 2026 21:29:49 +0800
Message-ID: <20260403132951.43533-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

list_next_entry() never returns NULL, so the NULL check in
cgroup_storage_get_next_key() is dead code. When iterating past the last
element, the function reads storage->key from a bogus pointer that aliases
internal map fields and copies the result to userspace.

Patch 1 replaces the NULL check with list_entry_is_head() so the function
correctly returns -ENOENT when there are no more entries.

Patch 2 adds a selftest to cover this corner case, as suggested by Sun Jian
and Paul Chaignon.

v2:
  - Added selftest (Paul Chaignon)
  - Collected Reviewed-by and Acked-by tags

Weiming Shi (2):
  bpf: fix end-of-list detection in cgroup_storage_get_next_key()
  selftests/bpf: add get_next_key boundary test for cgroup_storage

 kernel/bpf/local_storage.c                              | 2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_storage.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.43.0

