Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59A53D9684;
	Tue, 26 May 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801267; cv=none; b=ei0kNgO3qk5Kb69N6McfqwXRiIWb/Ja0flgfuqKDeWlTTFHoITQaLv7Gh1tt/w3PgSOguunx7QGmdCUrq3DncXQhQq30GW4P1zShogJxmC6txlnwIeVp9hHffepFutP1m/znc18hC8ZWYcSh4sG6/ybVv10RcRJZ/gTjpLDu+Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801267; c=relaxed/simple;
	bh=gokfZwCNMyuzMMDSjM01R8L57LnbWRvThDzMOCWY/rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WQjUm4gNJbxLNbP8rQnCEVHQhn3XmfN9P3lyqnoBUPPrywZfce62Hu6a5u5F7PPyLxVufeqoiPIIIoAy07+nOostQ2fzhUvNv4cqppyc63WQ3Njzv0FkbKlxCJKCUpzZMCqR6dKTusC5dQdmP15uZhcNuzfztr1SqixrbRjLwo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Sde3WWp0; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Sde3WWp0"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3fe349540;
	Tue, 26 May 2026 21:09:02 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: martin.lau@linux.dev
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Dawei Feng <dawei.feng@seu.edu.cn>
Subject: [PATCH 0/2] bpf: cgroup: fix sysctl new-value handling in __cgroup_bpf_run_filter_sysctl
Date: Tue, 26 May 2026 21:08:58 +0800
Message-Id: <20260526130900.1312698-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e6467293303a2kunm71d1d5ad20b6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSkpOVk8YSR9DT05IGR9DT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0
	NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=Sde3WWp0qqDHmKGjRpCORW70DLXTw1XBWEW0aK2T0oJ+oOyncQZXZk2nK9S1Ddhm9qv1/aKbtA6ed7/dUprtwlDhNrKdhspthAptNos9/u6GdKzIYtwPh8yObLjUaNCHr0wZJ8X4E6V8iAWTq7WN7Y+mL7yrOZ6VbAgNrMZsQWQ=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=mT+RG8JQB38zDvcV0lHDokBtae26kvtD9dO7uSCPTd0=;
	h=date:mime-version:subject:message-id:from;

This series fixes two bugs in __cgroup_bpf_run_filter_sysctl().

Patch 1 restores cgroup/sysctl new-value replacement after
4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpers")
changed the success return value to 0 but left the replacement path
checking for ret == 1.

Patch 2 fixes the buffer free primitive for that same path. The sysctl
write buffer originates from proc_sys_call_handler(), which allocates it
with kvzalloc(), so freeing it with kfree() is incorrect when the
allocation falls back to vmalloc().

Patch 1 validated with a cgroup/sysctl BPF reproducer overriding a target
sysctl write.
Patch 2 reproduced on a v7.1-rc4 QEMU x86_64 guest with KASAN and
CONFIG_FAILSLAB. After applying the fix, rerunning the reproducer no
longer triggers the Oops.

Dawei Feng (2):
  bpf: cgroup: fix sysctl new value replacement
  bpf: cgroup: Use kvfree instead of kfree in
    __cgroup_bpf_run_filter_sysctl

 kernel/bpf/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1
