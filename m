Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC11643D
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285748; cv=none; b=drv9vOL0yvrEG0F47cWAOJhw7sbsMOFXqSivcoDvEOJkewMBFhh+mV/Vbd+0NVI6sM9yXK+BU/GYX9FQQqqegmHep+gK+VaxX5gE0pEzF3z3i5vLZUDoyAfrSyukTzLQmSmSKlqRpKF3ODAvaKR18cX+pEcjOYXAzuJKp5JK+NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285748; c=relaxed/simple;
	bh=f25wy+TKRH57oEWqB9I5la4ALSimHuNCA8ykrqfTsug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FgCN0A4W/i/1p4BnDPe7Rqnq4E7NvZI3Qcu0GaKSZcdUeJXq1MPxvib17KeBrXH0vOacqPFWuxijXr4rOu5AEb4Nqh/UaLeuTk4A1gH7GFc3mKiYV04vUp13jxfvSHfQO0onyTStiZ4g+/5QG0ThPyRqSoA49YKfxzVpZCA6jFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rDZF5V3f; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rDZF5V3f"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712285738; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Knmdibu1v5gphAfIVAIuzmc4zwQ3MVNx1MeDrPneweE=;
	b=rDZF5V3fCN5D4sakuUDAZYYkaeflEEecJ1mzpG6RwOqAhOAK6+ogOjI1NR0MjiyW/wS3BkBM1IWGsITF2q+LsV+ieKnfyfk2uB6oWuZRa5CV7kv/7CY+HMDesS7PNrvKPAE+5ioEHEa7z7dSRAqf70R10JongrZJ+rar6e83sMg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3vouxW_1712285737;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W3vouxW_1712285737)
          by smtp.aliyun-inc.com;
          Fri, 05 Apr 2024 10:55:37 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH bpf-next v1 0/3] bpf: allow bpf_for_each_map_elem() helper with different input maps
Date: Fri,  5 Apr 2024 10:55:33 +0800
Message-Id: <20240405025536.18113-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, taking different maps within a single bpf_for_each_map_elem
call is not allowed. For example the following codes cannot pass the
verifier (with error "tail_call abusing map_ptr"):
```
static void test_by_pid(int pid)
{
	if (pid <= 100)
		bpf_for_each_map_elem(&map1, map_elem_cb, NULL, 0);
	else
		bpf_for_each_map_elem(&map2, map_elem_cb, NULL, 0);
}
```

This is because during bpf_for_each_map_elem verifying,
bpf_insn_aux_data->map_ptr_state is expected as map_ptr (instead of poison
state), which is then needed by set_map_elem_callback_state. However, as
there are two different map ptr input, map_ptr_state is marked as
BPF_MAP_PTR_POISON, and thus the second map_ptr would be lost.
BPF_MAP_PTR_POISON is also needed by bpf_for_each_map_elem to skip
retpoline optimization in do_misc_fixups(). Therefore, map_ptr_state and
map_ptr are both needed for bpf_for_each_map_elem.

This patchset solves it by transform bpf_insn_aux_data->map_ptr_state as a
new struct, storing poison/unpriv state and map pointer together without
additional memory overhead. Then bpf_for_each_map_elem works well with
different input maps. It also makes map_ptr_state logic clearer.

A test case is added to selftest, which would fail to load without this
patchset.

Changelogs
-> v1:
- PATCH 1/3:
  - make the commit log clearer
  - change poison and unpriv to bool in struct bpf_map_ptr_state, also the
    return value in bpf_map_ptr_poisoned() and bpf_map_ptr_unpriv()
- PATCH 2/3:
  - change the comments in set_map_elem_callback_state()
- PATCH 3/3:
  - remove the "skipping the last element" logic during map updating
  - change if() to ASSERT_OK()

Please review, thanks.

Philo Lu (3):
  bpf: store both map ptr and state in bpf_insn_aux_data
  bpf: allow invoking bpf_for_each_map_elem with different maps
  selftests/bpf: add test for bpf_for_each_map_elem() with different
    maps

 include/linux/bpf_verifier.h                  |  9 ++-
 kernel/bpf/verifier.c                         | 42 +++++--------
 .../selftests/bpf/prog_tests/for_each.c       | 62 +++++++++++++++++++
 .../selftests/bpf/progs/for_each_multi_maps.c | 49 +++++++++++++++
 4 files changed, 136 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_multi_maps.c

--
2.32.0.3.g01195cf9f

