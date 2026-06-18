Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955F1175A7F;
	Thu, 18 Jun 2026 03:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753837; cv=none; b=Eonmo6skqFKQUr0iAF8BHwvTb/BAaHmtj5VQiwx4RDtN0iCuZwxKhGPoxMGQd59bnefCJ/2DnVc4ltZWVUZuQBY0nb2qlVS7Wm41cRbbS0N+WrdUrDgS/m38PuLqrgBSVRQ4jWFuQ7Va/wSeHcROR9zrUmQbn6QkCaVVDswoSMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753837; c=relaxed/simple;
	bh=3hNrtWDOJ4EKm1eU4+zwpgKNmz3xVyAiYqvrYeCFNI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VvnaCzwdam0/4dO7d+UwD9N0a6r3E7sbCUXUxTvtof2SVqkJbhqgHToKy59kCSxD+aVIju3ODfPTcxV29lvNatDkPCMd4QaEUZhuFLiHNgMQ4b7kXJoFnwVPby+GgAbuXeHv89eTkkcOuuf+N1AW3B6sOKJZ1S03aVL27zI63qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=d+t2rThR; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="d+t2rThR"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42d8d4990;
	Thu, 18 Jun 2026 11:31:59 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Song Liu <song@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: Question: BPF stack build-id lookup while holding mmap_lock
Date: Thu, 18 Jun 2026 11:31:52 +0800
Message-Id: <20260618033152.1541795-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ed8c91b9403a1kunmf1a17f198b0ce
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQh5JVhhMHx5MGU0fHUodGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=d+t2rThRK1FWqYcBmWV3Z00gfk58PctNNHhkl5vo5qgv/jXWl6SabRXbcd1fYfOdaf4gGM1yBitWnr3DJ5CXyunDGCoFTbT9o/IhuaEIjv3+eA5l5NgrFmt0FJYJo0dqchY0UpFb90f/bejintMFRUTviOjB0GAa+D6n1XOmPbg=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=bYDpZepRS42kHQfCV94DqqHuisGv99igJmwhldcBRIk=;
	h=date:mime-version:subject:message-id:from;

Hi,

While auditing lock ordering around faultable build-id lookups, our
static analysis tool flagged the BPF stackmap user-build-id path, and we
manually reviewed it against the current tree.

The path we are concerned about is the sleepable helper path:

  bpf_get_stack_sleepable() / bpf_get_task_stack_sleepable()
    -> __bpf_get_stack(..., may_fault = true)
       -> stack_map_get_build_id_offset()
          -> mmap_read_trylock(current->mm)
          -> build_id_parse(vma, ...)
          -> __kernel_read()

`build_id_parse()` can read from the backing file while mmap_lock is
held.  That can form an ABBA dependency with file read paths where the
inode side is held first and copy_to_user/copy_page_to_iter can fault
and then need mmap_lock.

A minimal Lockdep reproducer preserving this BPF stackmap carrier and
the reverse file-read edge reports:

  WARNING: possible circular locking dependency detected
  __kernel_read
  stack_map_get_build_id_offset
  __bpf_get_stack
  *** DEADLOCK ***

The local fix I am considering is only for the faultable build-id path.
It would snapshot the VMA file reference and offset metadata under
mmap_lock, drop mmap_lock, and then parse the build-id from the file
reference with build_id_parse_file().  The existing no-fault path would
remain unchanged.

Roughly:

  1. Under mmap_lock, find the VMA for each user IP.
  2. Take a file reference and snapshot vm_start/vm_pgoff.
  3. Drop mmap_lock.
  4. Parse build IDs from the files.
  5. Fall back to reporting IPs if the faultable path cannot safely
     release mmap_lock or allocate the temporary snapshot array.

The tradeoff is that build-id parsing would happen after releasing
mmap_lock, so the VMA/file relationship is represented by the file
reference and copied metadata rather than by holding the VMA lock context
through the file read.  That avoids file I/O under mmap_lock, but may
change edge-case behavior if the mapping changes concurrently.

Does this direction sound acceptable for sleepable BPF stack helpers, or
would you prefer a stricter fallback-to-IP behavior whenever build-id
parsing would require faultable file I/O?  Another option would be to
avoid build-id parsing entirely in the may_fault=true stackmap path unless
there is an existing BPF/MM helper pattern I should reuse.

The local draft subject is:

  bpf: avoid faultable build-id lookup under mmap_lock

Thanks,
Runyu
