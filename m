Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DCE3EF666
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896725; cv=none; b=C+PR2NlNstVnlgSgO5TphOHEisXH1fIhV+KV1siuy+Kd2mSmgBUewH0ur7nesqlQC2BE3SNCekD2aQo8rC8N/i0jI6jkvDUluz0xyT+f0zNBToAbm+BEVNuGvR/T7ugSGVKVppQEuwwY1CCkiJCTk8GNWLlqCWRF0NMb4MKj2jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896725; c=relaxed/simple;
	bh=L0EmNB+T24JPK5ArViBPd9yjY6LfiTkUU+W0mIolNpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4Ic6vJ1KF+/zmxgS28slZaPyln64rkUvYic0YWf3vIE1cVb359vLXItnfguvYgOCuN2E3wNgu7Qy9pJmow8dV2llZPGv+HcFoOuFSK5ySIEFmRaDIJaysel1Nj2FAg6YiMLJWV2KF+6Z7J+Hp3+CqVgJZrfNCW3oevTYst+x00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSufOInx; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSufOInx"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccc09d65so1920967a91.3
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 02:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789896719; x=1790501519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8atFdaYK5/9ZUhclkm6dEsdH9+hosS1PWpgu4tx2p6E=;
        b=iSufOInxLt+iwEUhz4JtVDNUaUggir4n5uKEdv2XQI37KKfxfD+HDjkIlUpyYVB30v
         32UlBCEeAHNOSaBG/YM/3s6FwrRDiX0Nxt4X88rak+culj+pYuedjmKbSi6Uv5VO1hF2
         lOmHEoZmoaZ6Qsl2BmrUHJZ1fe6NAD9C4YG8iGxwTKUzlBIjJ/k5h4FEqu+xVZCrtOEZ
         qZV+YjWTHoafqy88xN2UVN8ihDD5BnTQvMn+F3VUuzetEe/P9JsYhmylKPMOxs8DKYC7
         C/Zeupqcs2syepLtecRWRIUvSI/sTufAx59d02E7PPurHNTsq0eo0UG0lIx9JbTwS2H6
         j4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789896719; x=1790501519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8atFdaYK5/9ZUhclkm6dEsdH9+hosS1PWpgu4tx2p6E=;
        b=qlZ32AShRKy6dpX82a+rV/BpkA6IOLR6UE61fYJFMu7eyZuKZK6wMpQFzeRIQ1UsTp
         whLvdPDMV8q/uvn4rnHhPopSNWt4m5uuZlFMUZ6ktO9aUX3PN23/nbrsp7TzRGARqaZq
         0jiqpRbmVJeYRtDzXwkpoT/zdIXc1qihV4/N9lSCSLSQd5uXFZIeAiC9vXsH9cWGoivt
         NX4poEOfVMtJuKwedXv/IRj7R8p7xj+Z8CjFAd5uahzNxlgd9BE5COtO3fvKpJ0E5TzU
         vAr2jg2GmRGPlw7+0Ju4S8eBAeZBW0UvjJBCS5rQKipg7qDUF0LYb32Nht+kifzYwDwK
         4abw==
X-Gm-Message-State: AFuF++kvBvF3MwqnRo04cm5yG+XKWPJRH2CV0I07Gm4ocqaL64hPQuSl
	+dfR/5wz17oVWRNivytczYmgN7C50m6DIo1TOZmsZoGsjlrtjy0rFtUr6wa8xs8=
X-Gm-Gg: AYBFou33KzdmT4pkdrVzYI4cdgLEpR2dwkIdyCy1dN2fcjxu2Boy6DBcAv1LCIqtIe0
	NM27+BdVJNGPdsnSjsL6EGvV8M0BlbjB9ndDHNymsfO3YhDbGN5p/X/AcRrbkcL/0oaFFqll2qx
	cT7++eqPfaLtXLyqL85XspHdmM59F/1vlhs5SdnOeLPve6LUy1vQA2PAITHKjMhmlBVC0O5LHBF
	1KPbKJZkbUCrAquRVloSree0K8VutgHuTi9FU2ew6sd6pXQlHH7gkh5xNU5WwAu1xFn2okAtsSZ
	BFDhEC5rRZ+YHcJV6Dw0tjAqiXWv6WBk8aPL8evImVUPJS5n9MQ0ZSBH5KVMHBdjpCx5bSJJYaY
	eNm+FrMpX7TkZH/FpzqQsKWrpaDyJ5rNiAGb0QRAEOtPfkEA4zdYeCaGIsH97u0k8cEWxyxEErU
	8H2uzjgkvZ1luO6GdAbfxwJwJCvs8Cmf9MOIawDt+VXz5xk3YtQ1saHeeTc1Ead3+1+AOfoCUoy
	zmNUPErXlVPGQboWAtVg43IFWnzUjCSxtZOxe8=
X-Received: by 2002:a17:90a:4cc7:b0:3a0:22bd:6ef0 with SMTP id 98e67ed59e1d1-3a022bd85efmr3299579a91.30.1789896719162;
        Sun, 20 Sep 2026 02:31:59 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:e0d6:4b87:c472:c9ae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6fb75539sm8093503a91.3.2026.09.20.02.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 02:31:58 -0700 (PDT)
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH bpf 0/2] bpf: fix per-cpu initialization of a BPF_F_CPU created hash element
Date: Sun, 20 Sep 2026 18:31:51 +0900
Message-ID: <20260920093153.439743-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF_F_CPU update that creates a [lru_]percpu_hash element writes the
named CPU's slot and leaves the others holding the values of whatever
element was recycled into it, so a lookup of the new key returns a
deleted key's per-cpu values.

Patch 1 zero-fills the other CPUs.  Patch 2 adds the selftest: the
existing cpu_flag subtests always prime a key with BPF_F_ALL_CPUS
first, so the element always exists by the time the flag is used and
the create path is not covered today.

Tested on x86_64 under QEMU/KVM, 4 vCPUs, on bpf/master a11212910cf0,
configured from the selftests' own fragments (config, config.vm,
config.x86_64):

  test_progs -t percpu_alloc,map_init,htab_update,htab_mem,for_each,
    map_kptr,map_ptr,map_in_map,lru_bug,map_lookup_percpu_elem,
    map_percpu_stats,batch_map_ops,htab_reuse,timer,task_work

  without patch 1   31/112 PASSED, 0 SKIPPED, 1/3 FAILED
  with patch 1      32/115 PASSED, 0 SKIPPED, 0/0 FAILED

The three failures are the new subtests, one per allocation mode:

  #304/18  percpu_alloc/cpu_flag_create_percpu_hash:FAIL
  #304/19  percpu_alloc/cpu_flag_create_percpu_hash_malloc:FAIL
  #304/20  percpu_alloc/cpu_flag_create_lru_percpu_hash:FAIL
  test_percpu_map_cpu_flag_create:FAIL:value on specified cpu
    unexpected value on specified cpu: actual 3735929054 != expected 0

3735929054 is 0xdeadc0de, the value the deleted key left behind.  The
BPF_F_NO_PREALLOC case reproduces as reliably as the preallocated ones:
five runs of each arm, five failures without the patch and five passes
with it.

Donggeun Yoo (2):
  bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash
    element
  selftests/bpf: Test per-cpu initialization of a BPF_F_CPU created
    element

 kernel/bpf/hashtab.c                          |  6 +-
 .../selftests/bpf/prog_tests/percpu_alloc.c   | 74 +++++++++++++++++++
 2 files changed, 77 insertions(+), 3 deletions(-)

-- 
2.53.0

