Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F41E25F9
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775168036; cv=none; b=VHmf6LQ7MqM/Teq7bWZtxeTqq5ioo0vBkKt/uvwlzsHO7kBlM2WLF6tbsXoCH4nym9WHA+unIS2PhfsGocdVjsTPlJ19uybpwCJ1uck0IWAgN1BeKH1Kay6p387+2jW/sRhEMIyPwwzfT1gARWEXcdE8O/uMYke0797qX91GGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775168036; c=relaxed/simple;
	bh=D9oejTp1KGpDKdr17w7Ohc5Tlk03SXXTxei16F08jsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULXEZI2isI6fw8s8q62EZjGY8LZzWJqv4iyNsWG18hgrZghCoOkqYOfuRN+CFIAWzjKdJEu+7am7ah+cj3vpIiCMTVydn3DnlSGjp3nBXxSX5otV1JUPJ/TjdyU3KIvYsp8QitMEcLufHqhAVUbMzUwYWWPMPV7kjlqegkU46wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fQF2VeQi; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fQF2VeQi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775168032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rJU14X0at/Y7/Q8R0OOriu+0NkcRDM4T6W7WlGs5/rw=;
	b=fQF2VeQiwteSH8u2lOaiw0ztqeNHfH3Jnm1haPlH7OL714LQhgT4RKF3db6mfqI4bxnt0C
	+kqf6HxlrzP3R+Q+5tvEmgf5208VqmIooMqgizoF19bBxCyILdVOw1YLqIOVndkIq8yEHb
	rBjC8CrQ9DEZsZsT0XPox7W0tYtuKkE=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: bpf@gcc.gnu.org,
	jose.marchesi@oracle.com,
	ast@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH v2 0/2] BPF documentation improvements
Date: Thu,  2 Apr 2026 15:13:37 -0700
Message-ID: <20260402221339.1614989-1-vineet.gupta@linux.dev>
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
Changes since v1 captured in individual patches.

Thx,
-Vineet

Vineet Gupta (2):
  bpf, doc: Clarify Pseudo-C notation and w vs r register usage
  bpf, doc: Improve MOV/MOVSX documentation and add examples

 .../bpf/standardization/instruction-set.rst   | 61 +++++++++++++++----
 1 file changed, 48 insertions(+), 13 deletions(-)

-- 
2.53.0

