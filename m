Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8018E29
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038588; cv=none; b=Dm/sFoOTf2h2sAkUc53919fyVLE9+Su5yWoXZfKt4mmBYXXLHhzombr5tYYu4UyyCsR+E8TUP9P72DTe59QXMoc//pyi8Q6ViI8Bc7S/daRS0v/B9gA6MHOju/zJaI4G506IwK5DQoR3XzTub0W/CD47ZYCIGoKNGXk49WiBKwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038588; c=relaxed/simple;
	bh=GsocjRusLOSBgpyiEj6N+uxOdLxvbXVLa7t+3dE9fK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JB7YhieaoqJTFcsIa+EnjuYJlGhS1GUv7xkGc5GgKCp9WDTUg+YjjdpwkKc5p6HSWqR8keCchSh+Uxtwbb8wSujFDgoX49vMeyPpW/HgViqAfRoUhNDpjuAFLpZtE63pjrdotqufyaV2XwEndh/7Bvzo+2A8NCXA9jtF1IzLUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D6b0+bIK; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D6b0+bIK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712038576; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eTIKFbnr5fF7XdNx+hkpCYMyLYnJY6js4goe5aOEOlM=;
	b=D6b0+bIKXC9NsugGJqgaWT2DJKRAC4xca1JLzbt9C5LuT1Y7kIe57HYWjdwwbi0HTGSJa8pLWfQopvr+4IzfkBcG8ae3pgloSUYIoMSxLTDJggoSCB6wwSgSSJzxcu9U3BtNMkhV/8ZWYxoSf/1ug5xl6QA4nN4dhAeJp4W0GT4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W3nHHye_1712038575;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W3nHHye_1712038575)
          by smtp.aliyun-inc.com;
          Tue, 02 Apr 2024 14:16:16 +0800
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
Subject: [PATCH bpf-next 0/3] bpf: allow bpf_for_each_map_elem() helper with different input maps
Date: Tue,  2 Apr 2024 14:16:12 +0800
Message-Id: <20240402061615.48894-1-lulie@linux.alibaba.com>
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

Please review, thanks.

Philo Lu (3):
  bpf: store both map ptr and state in bpf_insn_aux_data
  bpf: allow invoking bpf_for_each_map_elem with different maps
  selftests/bpf: add test for bpf_for_each_map_elem() with different
    maps

 include/linux/bpf_verifier.h                  |  9 ++-
 kernel/bpf/verifier.c                         | 42 +++++-------
 .../selftests/bpf/prog_tests/for_each.c       | 67 +++++++++++++++++++
 .../selftests/bpf/progs/for_each_multi_maps.c | 49 ++++++++++++++
 4 files changed, 141 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/for_each_multi_maps.c

--
2.32.0.3.g01195cf9f

