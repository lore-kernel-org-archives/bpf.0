Received: from mail-m1035.netease.com (mail-m1035.netease.com [154.81.10.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31E22DFA4;
	Tue, 26 May 2026 13:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801049; cv=none; b=JkMf1oOb8qV8VuxSRyN7doJc9fNy7MnbYsUEfOm35JrbabeATwiYoGnxgY6uJ+oXufQPadijzAgnaFxoLa3UtX9ivsOsUpO2a5E2Ns42Lp4ZUkhao0NqgSMT9UgZFay27FY7u+XxJPfC+f5KGgo8OTqkL/6FP5FdCxooiGiFTCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801049; c=relaxed/simple;
	bh=gokfZwCNMyuzMMDSjM01R8L57LnbWRvThDzMOCWY/rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZY5LglMTOFp2Bgb6hpBhKy4WlmtGC5TqaZ92pbArlDpd/JCVbkqBoH72KofIXKCWI7rLSgg8WcccTnHSSHUinbcMAuMprl0LWG9QrgYiu5oagqxYSEvZC0gFt47SZgya7EvURRDd+7rfHLqihV6akhpjS5Zpiakb9uQbxK860g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=aUQqQkL4; arc=none smtp.client-ip=154.81.10.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="aUQqQkL4"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3fe349550;
	Tue, 26 May 2026 21:10:36 +0800 (GMT+08:00)
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
	jianhao.xu@seu.edu.cn,
	Dawei Feng <dawei.feng@seu.edu.cn>
Subject: [PATCH 0/2] bpf: cgroup: fix sysctl new-value handling in __cgroup_bpf_run_filter_sysctl
Date: Tue, 26 May 2026 21:10:33 +0800
Message-Id: <20260526131035.1312864-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e6468949c03a2kunmbba6535a21c1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSBlJVkxPGE5PSE1NGhpPHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=aUQqQkL43Fb7V8zhqCXWNGx5g8xdKNZ71dlpOP4rIRp4AmlmKMOBLawxmUeB/kJF2d/Lb9vMyNwKvfl3IU/gD8X6qHxTbFt3QROLNGGIT9RZ1z+cNyVvkyuKPGc5c3uMEd6oJFm75Eziy7H9KbJdCcBdRuCFSty86uDiOaUNZ2A=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
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
