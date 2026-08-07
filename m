Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A42882D6;
	Fri,  7 Aug 2026 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111389; cv=none; b=tSekdWuG7gJ5gOIixIQczHMHVKLWWHlwif/FJuBjmRERosCuldHJUGpArRucc4kndvkwNRtXS2ifmTdz9rHFSGWS8VP42ULc1vFirnUjfB+6FHtvUOkcfRsv+KblT3HK9vSpvai1qaslosfpVfjUicxvS5JE2HsIU/BPuBgtvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111389; c=relaxed/simple;
	bh=803VMVtuNFjJwmA1Gpcepev1zXiHU2PI79gfmXG7X7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERfWWvkt3JbQ6x9Epfa/ftnm2bcHcvxOgWFeBj3KulqXHcSIk+gv1fbiDaRK5Vj2Thj1kvnnFlIUfkCKEbVMYFA/DlPTLjMqO/h6HG+IsVaz+YKzuJiy5+AwjYElK/OeLlOt9fW+QMdRdnM0nKY8vL97ij6S5V8OqnutCXT4rhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=VElgfF+D; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VElgfF+D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=8/3fjk4KnJn1jTFLlL5u0Rr+hvk4FnIlBMzkK2lh24s=; b=VElgfF+DdmPU5IzKH25mtu5Hme
	kVDekUwKWsNJshaxlx0rDARb/grF6Rp72cKmxFRr946EZ79CNwqba0CIQPdLkaoV/JR7njUoaadex
	2R1n3b0a+8ht71KxyvlGsrEPR6KNfAhh7EiZvSBHootpLbpoC9TX0bXiNCN3TVR/G3M95cyjtFm0a
	gBB69yLFj+Fnmjx36PORFF1LI1hhU93MELIdqqgfxLam9BIP+REFSNG5HmL8S4qr1BP5zFS6xMom+
	UVNr9pMKixH8aBnLeyTww52CTZICiRgi6r79PSrrZH/CqSaTHl4x8H67XG1pZnq1KcsunzyrActz5
	Ucfj60uA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wsL9z-000Ezu-2w;
	Fri, 07 Aug 2026 16:02:56 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [GIT PULL] bpf for v7.2-rc7
Date: Fri,  7 Aug 2026 16:02:55 +0200
Message-ID: <20260807140255.351483-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28085/Fri Aug  7 08:24:10 2026)

Hi Linus,

The following changes since commit 0ce37745d4bfbc493f718169c3974898ffec8ee7:

  Merge tag 'block-7.2-20260724' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux (2026-07-24 20:02:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 7a3c0289c3c8eb4607dff448ae9ff9f902c813af:

  rqspinlock: Reset tail when preserving queue on deadlock (2026-08-06 16:32:42 -0700)

----------------------------------------------------------------
BPF fixes:

- Fix BPF verifier to preserve full pointer state for commuted
  scalar += pointer arithmetic (Yiyang Chen, Eduard Zingerman)

- Fix a use-after-free of request sockets in the BPF TCP
  iterator batching (Jose Fernandez)

- Fix a use-after-free of sk_redir in the BPF sockmap send
  verdict path (Chengfeng Ye)

- Fix a netns reference imbalance in the BPF conntrack kfuncs
  (Chengfeng Ye)

- Fix bpf_get_fsverity_digest() dynptr assumptions and silent
  digest truncation (Eric Biggers)

- Fix bpf_tcp_{gen,check}_syncookie to check sk_state before
  sk_protocol to make sure it is a full socket (Luxiao Xu)

- Fix rqspinlock to reset the tail when preserving the queue
  on deadlock (Kumar Kartikeya Dwivedi)

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

----------------------------------------------------------------
Chengfeng Ye (2):
      bpf, sockmap: Fix sk_redir use-after-free in send verdict
      bpf: Fix netns reference imbalance in conntrack kfuncs

Eduard Zingerman (2):
      bpf: Simplify sanitize_err() signature
      Merge branch 'bpf-preserve-pointer-state-for-commuted-arithmetic'

Eric Biggers (2):
      fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
      fsverity: Fix silent truncation in bpf_get_fsverity_digest()

Jose Fernandez (Anthropic) (1):
      bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()

Kumar Kartikeya Dwivedi (2):
      Merge branch 'fixes-for-bpf_get_fsverity_digest'
      rqspinlock: Reset tail when preserving queue on deadlock

Luxiao Xu (1):
      bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie

Yiyang Chen (3):
      bpf: Preserve pointer state for commuted arithmetic
      bpf: Propagate untrusted pointer state in commuted arithmetic
      selftests/bpf: Cover commuted pointer state propagation

 fs/verity/measure.c                                | 15 +++--
 kernel/bpf/rqspinlock.c                            |  5 +-
 kernel/bpf/verifier.c                              | 45 +++++++-------
 net/core/filter.c                                  |  4 +-
 net/ipv4/tcp_bpf.c                                 |  2 +
 net/ipv4/tcp_ipv4.c                                | 43 +++++++------
 net/netfilter/nf_conntrack_bpf.c                   | 72 ++++++++++++++--------
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 30 +++++++++
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     | 17 +++++
 .../selftests/bpf/progs/verifier_basic_stack.c     | 41 ++++++++++++
 10 files changed, 198 insertions(+), 76 deletions(-)
