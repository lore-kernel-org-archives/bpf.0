Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CEF3B7A8
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234458; cv=none; b=dYkruabSFK0/urvYHPQ+XSTpMezpiDKqfe7+ndqoxA4gfGpPtgEIih+FTK4M0a7TQ8bwni31xGIS0tVqvlyLx4hEAQs/AjewmIlIv8Qu4RSGoz9dvJcC5Vk9nJIzBHJo7U6ViljHWG+/KMB3VWMaN0xJGsyg2Hc/SQHmLAtJopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234458; c=relaxed/simple;
	bh=rjXTv/hZx/tI7XH8fMHLikg+Omjq60zaQYkDmGICMQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lywBGuWE2q7+pcRVeV7GGKkB2n1KJZhjJOb6tdC7YwRJV4pzHn566O5m3hTEPAHlbs5ZcPJHt44i4FEH7EmB51ZYzJoHwJjvWpm3Ipa6nwwC2RvTVO9m8d/3hjUFI40kSSw+vbFPXHnrEnw8ZTdDvQJx3be35KdevwRsd3ukEL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QAoVYABo; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QAoVYABo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775234454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BjcbDiBJUwziIaXx0sF2n89jR5J/y0R12kmDKcTEWkY=;
	b=QAoVYABoDjux1tTPcCnCHEtVwkLDpUDRn4b3rKV9mD2d6bMItpjxZd988FqiE1+TU804+V
	p9nJ/aw0AVJPJxQdwrn8KEjELBh8y8uo+oF10vURz48QncDRZtgAq6+YNUJX3Sld1oWTYi
	3QQ4HiV2PEFBMlBVoa8RBqKyG/QUQDw=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: bpf@gcc.gnu.org,
	jose.marchesi@oracle.com,
	ast@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH v3 0/2] BPF documentation improvements
Date: Fri,  3 Apr 2026 09:40:38 -0700
Message-ID: <20260403164040.73269-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

A couple of patches for documentation as I start to hack on gcc-bpf backend.
Changes since v2 captured in individual patches.

Thx,
-Vineet

Vineet Gupta (2):
  bpf, doc: Clarify Pseudo-C notation and w vs r register usage
  bpf, doc: Improve MOV/MOVSX documentation and add examples

 .../bpf/standardization/instruction-set.rst   | 63 +++++++++++++++----
 1 file changed, 50 insertions(+), 13 deletions(-)

-- 
2.53.0

