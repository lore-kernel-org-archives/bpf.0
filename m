Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E438233556E
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451851; cv=none; b=lFgwPKHDKKSR0OiYED4xNG/TABm+zgh0KqqNR23qps3ibjVEP2fVqJoaanuzCTUTearhOnWNvviROpCQ+Trv4YA0iJmZx7ddpPbO6qXKEADfJ8fszco76oAm2YJ7v38HcKKYOo+W3ySsTuP7OOZ2/drGOHiqx040I3WTmJ3zx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451851; c=relaxed/simple;
	bh=f1lNgefGIC/YcxlXd5e/ZNS93ri6kYhQckVJurlwkG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRr+arCnZhpVXqNifNZxbo+XHLmoYIdRCXRKAbqKI4mzS312zwUSko+mRCqsRiT80BPJI/v8rA7JXgyNy8m224tVzZeB3pFDapHwm4F8r4wQUVCFeWRFTmGyqSavmejvk/Fus0CBY8oyXYCjN11Jh5OWMcZUB54t3TMzVb1JEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LyKRd3QJ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LyKRd3QJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771451838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=45YBMKDdB9CHi80ZhvvMJxTNPQtUdWSacNHeDsJ8hFg=;
	b=LyKRd3QJigcsQqGyCrt3fCAl3dxNeDrlgMXFicMVlCZPkgDgX42aYhRo9qQhPNjRS+w8FH
	ZdlWVqqNuyhwUs4emcqdjtlzwmLXIE9TRAL3a7mu8glFvuMDBXEy5pqEHZ0NFSMBnhvAJB
	jS24rzSBG5mOoMWfohA9S8S28ucPVL8=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 0/2] libbpf: Remove extern declaration of bpf_stream_vprintk()
Date: Wed, 18 Feb 2026 13:56:49 -0800
Message-ID: <20260218215651.2057673-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The first patch adjusts a selftest that has been using
bpf_stream_printk() macro. The second patch removes the declaration.

Successful BPF CI run: https://github.com/kernel-patches/bpf/actions/runs/22156645808

Ihor Solodrai (2):
  selftests/bpf: Use vmlinux.h in test_xdp_meta
  libbpf: Remove extern declaration of bpf_stream_vprintk()

 tools/lib/bpf/bpf_helpers.h                       |  3 ---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c | 12 ++++++------
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.53.0

