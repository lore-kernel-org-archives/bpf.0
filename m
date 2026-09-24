Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0B48593F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245411; cv=none; b=l9X2KFZra19LBZxvEULI9IeMr1XHHpAT/yGjXbxsGbfonMU2QpYZHIuJzEYzxFdDU7kUfRXNff8PDi1TznvbWKuq9+BkUc67BQSYqWCvOR3peEDZiG9wK6bEcMrXcExvbymQ+KTr5XCEZo3ACof6oKAp8f+76BISE0ClUtTwztI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245411; c=relaxed/simple;
	bh=/ODbsO0ib9XHINNISR/G61Yufsf6FUpuX3+F97Dv1cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHhdcjuPaINO+mDWTsjvGxJUEgi3jxjgERubbd1lMrBVlA1J4dgDmfzoExtTfmy9Ti+YkMKbbC04a3VH4uieMWQRCsQ07OGzPAWktZw0++AT5y6jNEx1NcAwK9wNORaL+Jxw+PSzWS/BwjtGdrWXUdqtrbvwsw2bOp2uXVI1Q4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LerLZwDO; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LerLZwDO"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so1431673a12.3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790245408; x=1790850208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xJZ5kVFapcaMDUxwmgn/TUrBXfLGg98xcJ7wbSfqudQ=;
        b=LerLZwDOXDMktDZiKHYhSGkuE3yoNeNKdIBaffqELINxeu7438UyrR6v8p9nnhw+61
         nj5ZVYyptHccEDCt000RXLD54U4aPARZU0oH5xSK0xM6c4P9vGVCQt+41qS5rn6HEeH0
         1JsfASl8/mbxrdkbBSZMGss/EJZkPOJgJcK4XiTcLsJEMTri29w4wxQmCTta9OgLwd0d
         qehvlFEiJo9iH70fH57tV6+o61jOH5OrmWD3Hnc4oegTSNRRZXKEyYfl5etX60hmx2x6
         efK/aXmuyeShfSMBAHRlZvLNJKmOz1LnYNsnF1naIFndd6u7FFxM+MTSSYRYCIlpEdhi
         A74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245408; x=1790850208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJZ5kVFapcaMDUxwmgn/TUrBXfLGg98xcJ7wbSfqudQ=;
        b=om1a10orgU4VM64ieG4eVzureKCiTln1JOJNNpj9JQDMnGifKOMmkCOzvZkUZml1sg
         psiSV0GzujLuuAdI15aoUJaWgpf4FlVbdjggBDw3/i05a6feUN5eQEu2ptwxDCU2YPYw
         vlpYOVTkIMKYRT2HK/GqjMwbjbaKUTVk34beix3r5d9ChrMUwSunvob1zyTqvKYK/P1a
         uk9rXydPiQUPuVjcUaTy+PvG6JKNCVYZaHaMIreaXBaG4i4vfFOAxWOU7+eEO9091fnt
         ypS8ArBybj+qCxGFi1/kQsaT6dpR1MUEQXVM6eA+T7tQm/mJ0jp/Fiyk2ov2bOyQC5MA
         cHbw==
X-Gm-Message-State: AFuF++nNsga+jv8w4cbXb1ughRrDo/cb+fyurXtcmQl3nR8sUOYlKaQ6
	4/IAkfDwPNwRe//OxIlx6u5zRg3cTCX7AOCbobR2gQnRyvzeo5v8ebeTlbYSARimuA==
X-Gm-Gg: AYBFou0I4AU/BTbbT4ixLkAkK69rEVpKhUv5UOosKU8bf33Z10E9Gmxj74UVAKhPNea
	wKoc+PPGHmniNE+6DQJFrvmen5D40kzSvtizKqm/8G99YWfuFzA8l0Z2bv8vwJO1E4TavTs9Y/V
	5LVEYJ+PBbRWpBizo396C6yXeR8CnBscDGz45ocld05V27GdMwVSfLUwdAT5zQSWmv5r3JDZDAC
	kWf1Fs8UQGQ8r/lnyINE37hQzVxZzRaqbFkTf8IHqeBWmirkTBdMcy+34GAI8hTuHIJ0m2OXrOc
	BdZOHL0YdEzvafCHlUqG1KCA1HGQ0Gtjm+xTKgya+uq1uIMDMRR7FREiMXTvGQ/No8CVTiqbult
	NLx1wM/ujG8QFSJMX7xW7CV9nirJiMy63Lq9/AsL05jnRpJ1wjKuDdir7JpS0qbFB9aTMGcYRU5
	h6pkT+jlVeQXMqNSABHEM07ajXCN0T/CzQ6eOXTadHaGjZm2m/x0Bkn09GTiz2LdYCxYg+AHBj3
	l3utS3F610HYwfSbQZY2Jts
X-Received: by 2002:a05:6a20:7f96:b0:3c4:1916:9d40 with SMTP id adf61e73a8af0-3de0e6f4f73mr2034103637.12.1790245408389;
        Thu, 24 Sep 2026 03:23:28 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1afb9416sm2661582b3a.7.2026.09.24.03.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:23:28 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	leon.hwang@linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH bpf v3 0/2] bpf: fix per-cpu initialization of a BPF_F_CPU created hash element
Date: Thu, 24 Sep 2026 19:23:19 +0900
Message-ID: <20260924102321.2120434-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF_F_CPU update that creates a [lru_]percpu_hash element writes the
named CPU's slot and leaves the others holding the recycled element's
values, so a lookup of the new key returns a deleted key's per-cpu
values.

Patch 1 zero-fills the other CPUs.  Patch 2 adds the selftest: the
existing cpu_flag subtests always prime a key with BPF_F_ALL_CPUS
first, so the create path is not covered today.

v1: https://lore.kernel.org/bpf/20260920093153.439743-1-donggeunyoo.kernel@gmail.com/
v2: https://lore.kernel.org/bpf/20260923000801.1764758-1-donggeunyoo.kernel@gmail.com/

Changes in v3:
 - patch 1: key init_cpu on BPF_F_CPU rather than on onallcpus (Leon
   Hwang)
 - patch 1: re-flow the paragraph naming pcpu_copy_value() (BPF CI AI
   review)
 - patch 2: pin the thread across the delete and the create, and name a
   CPU other than the pinned one, so the BPF_F_NO_PREALLOC arm does not
   depend on staying put (BPF CI AI review)

Changes in v2:
 - patch 1: cover the BPF_F_CPU entry condition in the block comment
   above pcpu_init_value() (BPF CI AI review, Alexei Starovoitov)
 - patch 2: skip the new subtests instead of failing them on a
   uniprocessor machine (Sashiko AI review)

test_progs -t percpu_alloc and fourteen neighboring map tests, x86_64
under QEMU/KVM, 4 vCPUs:

  without patch 1   31/112 PASSED, 1/3 FAILED
  with patch 1      32/115 PASSED, 0/0 FAILED

Donggeun Yoo (2):
  bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash
    element
  selftests/bpf: Test per-cpu initialization of a BPF_F_CPU created
    element

 kernel/bpf/hashtab.c                          |  11 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 105 ++++++++++++++++++
 2 files changed, 112 insertions(+), 4 deletions(-)

-- 
2.53.0

