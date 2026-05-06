Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D631F9AD
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050267; cv=none; b=cZaytmHqyq19h1d9t7wsHGfp0hkD6ww4+cJ9b9qvnVqqepXZhqoe87d6OI9tULJOtD0v84CbPdvsAiMv0dXZ33luF8C52aB/PRKW2obXJauIP2eAzcNYYJbtqgxlol7hdhtYP7vAazfg+vgcMJzniSnXIVZFI7gDNKFB3ceRKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050267; c=relaxed/simple;
	bh=hq9b8olvuWRx4WeDloiu0ugxrtPl6E/lDQKST+EaW70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XglLYNOWnPTTRs9M8L6ap50lvAcQ5nytpOXwbm9bJzA9zbUXyoTcfXYyEzpcuqDkbEV9O+onNhMtrdsbPz01Z6AU3BSVOJjvM8epM5wRs+/+d4Y4v/onfkS/JkxbLH1rE/MrmH/j1EkLvLhf2Lo6Pfkb+++fXTYKf2JmFKgu6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jg/T4302; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jg/T4302"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso46023605e9.0
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050264; x=1778655064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FKCYrCfjR0x7tcHMdX4UuPX1bP6IEGV8zRSSogIlHs=;
        b=Jg/T4302MITdGcvSDtHQh+hAPiZsMikwaOao1/t6dFSItP9DZYe1MqTjLqJbSLXq0G
         jVI4YV4IlVS+U1wqpr/5E3IoDJuIy+Fyaeh8ruWCrVc5BQkif4WjkpVCMBBpxKOlfbYs
         IkBIDF1dGELfrlIHRaoy7RKhwb7FChYT1DAYhjPiMY8VYhPH8vYUSgLP7jb2s/3uuXBs
         YwGfDgJ0O0N0rnwLy3YLoX4HRxaQ+ZOCa6EjsUXHXQhApARmf7JpE/uTmKxUH0ewwOFl
         vyWot7en6SBvL71Mj/+0KP9jd8zDzUTbqE/j8BC1sUqVl5tgy5LQ1TQx8X4dWzAdUbmI
         YdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050264; x=1778655064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FKCYrCfjR0x7tcHMdX4UuPX1bP6IEGV8zRSSogIlHs=;
        b=HzISbnwpOtq74pC9CsEslr2Np6FPtBDFtFk1XOmAFXI0WAerLxEz4v6MwMgLhaUcW3
         ys0BYetJeSbILAV2DOkkXvJ4p8jpju0iWfLcVoK9N2OKuCjyOROZRwo2j1DlNqb8edTJ
         mdIraPAJvbslGE9IBimoHDcMSzpZyeI0uL1z+PKD8usLVa7wBqiBPBNfoyC9yOayKCg+
         NOGwtEDwcvy7Y1L1zPtRR5E0spZYfdw0apwF/Qg9TH1BwQJoT5OSbyX5oZZ2LaPMopEU
         thLd4a76lYSt4hODzoYifh9MUqr+MZXw3Rb50ByuDyS+PUZu0rgKoHBEsadiSI7CIqaz
         lPcA==
X-Gm-Message-State: AOJu0Yxj8guijhfbCEgxIHBq7Bsrw/u/SjQ1ynInfZJ7GZ/9UhJVzcdM
	W7pXxKLHq6Jt4a4v0zbqbkA8b22zQodH9GnzAucTHcDYuqpAqnUJnUom
X-Gm-Gg: AeBDiesdOpRo5LK+Xc4TSEP+08dIETwORqUZFhq8TfWlCMoJuDQ1kSh9ESmOzPjus4h
	wWDccq3bFheSrX3K5sHkMzWnxd0GTbaDwCqBsh2jCrTBJ6yKWZZFymeGWliCl5xK+WZ0dCzBLmA
	AOfd28kYwPOVnUl05NeAhQHYsvaK1xNMXbcZY6WCD/6CkRJHkx7tVoND4Bj/gT8t+bIVD8eGDFf
	JDwAGV216LudPzsIoYvNIITnbDLDpHSFKJfhkb8XuEsnIngnW79gUgEPEIeC6PzTz8p4aWw0Swi
	IBjrn4kvbsGLG0SuMeFaOiCzV++F3E6G4g4lFVnrTWO+j8AxS6G6WbvJGa6KCwqyzIYIqtNJbDR
	5i0ym5lhTu60i6ywzFlQUlkLgow3uxua2QJh2TC/zBKLYUSxE7CvsUwBV1HNioYcueHk3dBx+bI
	yYm61JMzGcc4FEOXAH7zykAqBE6ODo5FfaBk+HpduSd2r1bucm9kvhXJvqWYG+yCovsMOUNK4I/
	A8p1y0n2hQiyePnh7bJqxkfM9sDZXyZJIPs08v8
X-Received: by 2002:a05:600c:1d18:b0:489:149a:f9e7 with SMTP id 5b1f17b1804b1-48e51f483d8mr33429975e9.27.1778050264294;
        Tue, 05 May 2026 23:51:04 -0700 (PDT)
Received: from paul-Precision-5770 (2a01cb0404624b007a7d1e818d0f651e.ipv6.abo.wanadoo.fr. [2a01:cb04:462:4b00:7a7d:1e81:8d0f:651e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538aca14sm23526775e9.7.2026.05.05.23.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 23:51:03 -0700 (PDT)
From: Paul Houssel <paulhoussel2@gmail.com>
To: paul.houssel@orange.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Paul Houssel <paulhoussel2@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Florian Westphal <fw@strlen.de>,
	"T.J. Mercier" <tjmercier@google.com>,
	Li RongQing <lirongqing@baidu.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH 0/2] Introduce CONFIG_CGROUP_LSM_NUM to render BPF_LSM_CGROUP attachment limit configurable
Date: Wed,  6 May 2026 08:50:46 +0200
Message-ID: <20260506065048.592474-1-paulhoussel2@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In include/linux/bpf-cgroup-defs.h, CGROUP_LSM_NUM defines the maximum
number of BPF_PROG_TYPE_LSM programs that can be simultaneously attached
using the BPF_LSM_CGROUP attachment type. It is currently hardcoded to 10.

This limit was introduced in 'commit c0e19f2c9a3e ("bpf: minimize number
of allocated lsm slots per program")' in the first patch implementing
BPF_LSM_CGROUP attachment, and has not been changed since. Rather than
reserving one slot per LSM hook (a 1:1 static mapping across all 211
possible available hooks at that time), it introduced a dynamic scheme
where only 10 slots exist per cgroup allocated on demand.

In practice, eBPF-based tools may exceed this limit. I therefore propose
making CGROUP_LSM_NUM a Kconfig option so that users can tune it to their
requirements, rather than being constrained by static hardcoded default
that has been arbitrarily decided on the first implementation of this
attachment type. On the other hand some uses cases may be interest to
limit the number of attachments to a lower value than 10 to prevent too
much memory overhead.


Paul Houssel (2):
  bpf: render CGROUP_LSM_NUM configurable as a KConfig
  selftests/bpf: add tests to verify the enforcement of
    CONFIG_CGROUP_LSM_NUM

 include/linux/bpf-cgroup-defs.h               |  2 +-
 kernel/bpf/Kconfig                            | 13 +++
 tools/testing/selftests/bpf/config            |  1 +
 .../selftests/bpf/prog_tests/cgroup_lsm_num.c | 60 ++++++++++++
 .../selftests/bpf/progs/cgroup_lsm_num.c      | 92 +++++++++++++++++++
 5 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_lsm_num.c

-- 
2.53.0

