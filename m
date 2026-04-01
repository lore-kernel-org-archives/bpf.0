Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F1334C1F
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775086830; cv=none; b=FGFR9E3t1VfEez1FYY+UccSxne/4As56mfAfuFgRzxdvHyfE+PdNb95pv3Tojf3/V98q+jztsXIQyyAl+DNMrK2bAfaCY2Bya2A5MOWyyAC1n7t6gLSmOmGSfp9i+34S0wfneEBmIsbbsq9G+2wEnFrSWjp5yugQKNqmgf2Iccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775086830; c=relaxed/simple;
	bh=1m7ZVF2vDL4UqtGoLO6FbAufa1XGSQ5NtPx4G9/qG7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lwc32TY2TTo60XYkzKDRAcM8qloCt27KuKoWmH/JILrMO35C9ZJ1qDRaJJKPn7YTEljUmQInwzZ/AROONIcLT+SNsYnWWoibZ8f6ZCgLGgkmQ0o2dNhR7PyvsDf/TSpHavfLQGrPau1KFXnUzBAEi2S9L9WzCg3aSKv834Qiolk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VaiNLNl+; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VaiNLNl+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775086827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AyjMZ5vOq5urjuRPMM8TDbtsgNxY8JY3bbKEPMX7zKM=;
	b=VaiNLNl+xIMaaKGwmBWyBvukEgKCNoF9GMC//NQC4tDioSsbXlRv+lcRHgk2dr85g1rBLK
	fA64v6z4SVFR5SaziNZgBZR5THCs7d7kezI3UEqMMLFKlQDwBGjfnXnf0EpEVWAxl4mPKk
	zoKYSLqNGghrvZuqQgb1su4WXi93lc4=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: pull-request: bpf-next 2026-04-01
Date: Wed,  1 Apr 2026 16:39:56 -0700
Message-ID: <20260401233956.4133413-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi David, hi Jakub, hi Paolo, hi Eric,

The following pull-request contains BPF updates for your *net-next* tree.

We've added 2 non-merge commits during the last 2 day(s) which contain
a total of 3 files changed, 139 insertions(+), 23 deletions(-).

The main changes are:

1) skb_dst_drop(skb) when bpf prog does a encap or decap,
   from Jakub Kicinski

Please consider pulling these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

Thanks a lot!

Also thanks to reporters, reviewers and testers of commits in this pull-request:

Daniel Borkmann, Willem de Bruijn

----------------------------------------------------------------

The following changes since commit cf0d9080c6f795bc6be08babbffa29b62c06e9b0:

  Merge branch 'net-hsr-subsystem-cleanups-and-modernization' (2026-03-29 14:37:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git tags/for-netdev

for you to fetch changes up to 64c535db769e9ab917343d61045802e832d621ed:

  selftests/bpf: Test that dst is cleared on same-protocol encap (2026-03-30 15:52:25 -0700)

----------------------------------------------------------------
bpf-next-for-netdev

----------------------------------------------------------------
Jakub Kicinski (2):
      net: Clear the dst when performing encap / decap
      selftests/bpf: Test that dst is cleared on same-protocol encap

 net/core/filter.c                                  | 50 ++++++++++---------
 .../selftests/bpf/prog_tests/test_dst_clear.c      | 55 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_dst_clear.c | 57 ++++++++++++++++++++++
 3 files changed, 139 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_dst_clear.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_dst_clear.c
