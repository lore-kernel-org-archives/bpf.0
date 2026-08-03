Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CA941CB5E
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 17:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776607; cv=none; b=rvw7JCpkuH+swoaE8yeytD3M4mUgbr9BB/RjmYdWmAj14Ea0Z12PLtfqFvIa0IO1113qeZwKyqZUJ15JbWVSseM+nZUVvqGH215tialfvI/60G6XAJEbndO11AGkoVHZh0H8bYn72TJhnvSg5lWyvbpstGicvwVRCPnXMY+efow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776607; c=relaxed/simple;
	bh=vUE/mWbDN8ycN7vKHjUDHw7+RlSiS6mzJk/McluOHL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXTeuFZwLNsXbo/5aZ4KTfx62TN+2k0K5mYsjjhLMi8RQz5AIiUOoswkYeeaNqy3HB/e3L7PCDSAZ3P+/yoDC0jnUOVqeNWc/znuMfzHfpEsG64WVtgRneIvkKAqFGEDtxUcOG1gluMRdPJcd8VpkHHC483soY6E/cXC1iKtg7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F8FVWVn6; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F8FVWVn6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785776583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LLSxbxqvILIbt+u5G5hBhmdTtYgzxV5l6Zg8awViso0=;
	b=F8FVWVn63QbsJinySrFUYTEVEeP+f9ANzTwP346x8adIrncetr7Unrwuze0MHL9wNaWEIt
	k8GvpsaBHIFbQKStqxFYwJWFPsrHl0cofrkQsevDr1MoZ85lED/Ed0dkUytiUlLEfzz5ex
	ReRs7GLuRYv1aMtPVox6GJsWcgHtF4g=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [bpf-next 0/4] selftest related fixes
Date: Mon,  3 Aug 2026 10:02:47 -0700
Message-ID: <20260803170251.1898102-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

This is a set of fixes accumulated during BPF_GCC testing and an in-works
verifier enhacement series for 32-bit tracking.

Thx,
-Vineet

Vineet Gupta (4):
  selftests/bpf: map_kptr: force BPF_STX for the scalar store to kptr
  selftests/bpf: add --no-error-summary to skip end-of-run error log
    dump
  selftests/bpf: report failed subtest count in test_progs summary
  selftests/bpf: vmtest.sh: preserve command quoting when running in the
    VM

 .../selftests/bpf/progs/map_kptr_fail.c       | 11 +++-
 tools/testing/selftests/bpf/test_progs.c      | 62 ++++++++++++-------
 tools/testing/selftests/bpf/test_progs.h      |  3 +-
 tools/testing/selftests/bpf/vmtest.sh         | 13 +++-
 4 files changed, 64 insertions(+), 25 deletions(-)

-- 
2.55.0

