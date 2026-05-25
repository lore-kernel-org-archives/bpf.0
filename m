Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988F33E35F
	for <bpf@vger.kernel.org>; Mon, 25 May 2026 22:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779748806; cv=none; b=oWXgkcnoouQAnx7YQtVDMhRoqfYMdpDhpQHINodfviIyODVjvhg7PWb7CMUssenIqCgDiuque2v3tpWpdZrHaeQT3eaw+5HlJ6pv2KaU6H7ba7h88bhb51K2uQk5lMS2q2LL0lmPfkh7OgGn9kEPLnvJ4tkfnceTfCt2KpTtz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779748806; c=relaxed/simple;
	bh=h4cTLY5LUwhCYvDd8djQaBEGvR95AuQaz8garCflqhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gq/TFEkI8nRyo/mbro63ezNFRYikbntZjCFiFSSpLY4o5dHIOEkpr5UcTbA0Svn4c27LQQGXGEmEIDF0HBzUIKfTAFre7MT99n1srtd0YT+lE5AuCzqe4VmN4pk4YkFW11wlhnDjCR6vSvZEwmiSLGuPzETS0qtLGHPJ5gkKRtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tXP32w59; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tXP32w59"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779748802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lUbGR03UvLkKwwvL15wDJbGv8iti2jQo3BRgBm+JYdU=;
	b=tXP32w59zR8tzlI6UFIpc+2VisC/cEWDXZTr/jc8/jPvrMq1AuH9Rni3PtL8jESzqPEONo
	XChyFgW+8F7df+8H45+xTJ2UEfSowx38sk3qlCmem7wiLgxzzus7qbK+PxawqHRAO54FnC
	wQ6b0icdUYKwV4td/xke84XpzFaJXIU=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 0/3] bpf: Implement stack_map_get_build_id_offset_sleepable()
Date: Mon, 25 May 2026 15:39:45 -0700
Message-ID: <20260525223948.1920986-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The series introduces stack_map_get_build_id_offset_sleepable(),
fixing a gap with parsing build_id in sleepable context in stackmap.c

In particular, this fixes a deadlock in
stack_map_get_build_id_offset() doing a blocking __kernel_read(),
which happens since commit 777a8560fd29 ("lib/buildid: use
__kernel_read() for sleepable context").

See previous revisions for more details.

---

v6->v7:
  * Addressed feedback from Andrii (mostly patch #2):
    * implement proper CONFIG_PER_VMA_LOCK=n support, following a
      VMA locking pattern similar to one used in PROCMAP_QUERY
    * change the contract of stack_map_lock_vma(): if a non-NULL VMA
      is returned, then a read lock is held
      * remove now unnecessary vma_locked flag
    * and various other nits
  * Add vma_is_anonymous() checks where appropriate (AIs)
v6: https://lore.kernel.org/bpf/20260521225022.2695755-1-ihor.solodrai@linux.dev/

v5->v6:
  * Misc refactoring (Andrii):
    * add stack_map_build_id_set_valid() helper
    * simplify control flow in stack_map_get_build_id_offset_sleepable()
v5: https://lore.kernel.org/bpf/20260515005244.1333013-1-ihor.solodrai@linux.dev/

v4->v5:
  * Add comments explaining mmap_read_trylock() (Shakeel)
  * Rebase on bpf-next (Alexei)
v4: https://lore.kernel.org/bpf/20260514184727.1067141-1-ihor.solodrai@linux.dev/

v3->v4:
  * Change Fixes tag in patch #2 (AI)
  * Nit in caching implementation (Mykyta)
v3: https://lore.kernel.org/bpf/20260512032906.2670326-1-ihor.solodrai@linux.dev/

v2->v3:
  * Split patch #2 in two: stack_map_get_build_id_offset_sleepable()
    implementation, and then introduce caching
  * Drop taking mmap_lock if CONFIG_PER_VMA_LOCK=n, fall back to raw
    IPs instead
  * Cache vm_{start,end} in addition to prev_file (Mykyta)
v2: https://lore.kernel.org/bpf/20260409010604.1439087-1-ihor.solodrai@linux.dev/

v1->v2:
  * Addressed feedback from Puranjay:
    * split out a small refactoring patch
    * use mmap_read_trylock()
    * take into account CONFIG_PER_VMA_LOCK
    * replace find_vma() with vma_lookup()
    * cache prev_build_id to avoid re-parsing the same file
  * Snapshot vm_pgoff and vm_start before unlocking (AI)
  * To avoid repetitive unlocking statements, introduce struct
    stack_map_vma_lock to hold relevant lock state info and add an
    unlock helper
v1: https://lore.kernel.org/bpf/20260407223003.720428-1-ihor.solodrai@linux.dev/

---


Ihor Solodrai (3):
  bpf: Factor out stack_map build ID helpers
  bpf: Avoid faultable build ID reads under mm locks
  bpf: Cache build IDs in sleepable stackmap path

 kernel/bpf/stackmap.c | 215 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 198 insertions(+), 17 deletions(-)

-- 
2.54.0

