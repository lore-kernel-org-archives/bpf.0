Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767947CC73;
	Wed,  3 Jun 2026 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484319; cv=none; b=kcQg8jk0MMyJ9L85jzISB+QoOeBpNWoB3+I2pwljOa27fncayCnmis4FaFdqY/kGCHLdiJmgllOAYeikuzgQuSTfOwMYq7D+UBoFozvH2HVtdYCBQfGUJ4qSGeu2exBnyJuNwz6YnQtW1E0znCr2tvOZjOx4En+bD18xbldTukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484319; c=relaxed/simple;
	bh=3iQFNxGl8Rg1Q9XBTfWjdHOBjYO/uPV9l9LdxvnZ0gI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bS7KdXXR9WQfHGmcYkRJMRrh4OIZm4leGlAre2xUWEFHj0bx2Fb3aOJAimBDTeAK+12Z6ADsg/IB1oDhXlMYvRYY3C/fy5YY0qkNmn4F1gqUMVRwA9e4su4NxCgsSaiKNp2Jf7JCa2FyrK9HmLQTFgDDhK3RTqPTTkXeJD8F0LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=C2dcLvV+; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="C2dcLvV+"
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40ea2c692;
	Wed, 3 Jun 2026 18:53:21 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: martin.lau@linux.dev
Cc: emil@etsalapatis.com,
	ast@kernel.org,
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
Subject: [PATCH v3 0/3] bpf: fix sysctl new-value handling in __cgroup_bpf_run_filter_sysctl
Date: Wed,  3 Jun 2026 18:53:14 +0800
Message-Id: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e8d1dce2803a2kunmafab39db1ed241
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHUhKVk8dSBpIS0lDT0IYGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=C2dcLvV+x+6Fwst5QwoRZ5HtjBGafNFwspg+vl03ZENE5T1k2z8vogaWcd1uZhzWG1zNy8B/ojXlaurWHTKQ+D/80gZY6yvC2UnIADp1V2nY1n4zkjfYj68OxLCV8oy3DXy7YmkV9/0r+VbIW7IHUtmBxWE9LzeSMIk0L3Fa4so=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=aI9DSUszQyFmuggSb+iLcfuzFQ75V2aBUn9ihatzX68=;
	h=date:mime-version:subject:message-id:from;

This series fixes three bugs in the sysctl write-buffer replacement path
of __cgroup_bpf_run_filter_sysctl(). It resolves a kvzalloc()/kfree()
mismatch, adds a missing NUL terminator to the replacement string, and
updates a stale return value check to safely restore the replacement
functionality.

Patch Summary:
- patch 1 NUL-terminates the replaced sysctl value
- patch 2 uses kvfree() for the replaced sysctl write buffer
- patch 3 restores sysctl new-value replacement

Changelog:
v2 -> v3:
- reordered patches 1 and 2
- added the missing Reviewed-by/Acked-by tags to patches 2 and 3
- fixed the incorrect Fixes tag in patch 3
- simplified the dynamic test logs in patch 1 and 2, and updated
  titles

Dawei Feng (3):
  bpf: NUL-terminate replaced sysctl value
  bpf: use kvfree() for replaced sysctl write buffer
  bpf: Restore sysctl new-value from 1 to 0

 kernel/bpf/cgroup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1
