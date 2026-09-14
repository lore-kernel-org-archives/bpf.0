Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E244E655
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405412; cv=none; b=CWaNdK2PGCOyQIkYN6azxDbfBptQ96H9ILZFW6By+c82Cn+EPcpEPAhJVU4d5LnZq8k83e/kFQ4ZmJMx0SxWFlzv2d1VTfL/RIucr24w25fYioUWQ1JZ0yawpJg5+3PD9cZnvrjkzcuPyIoCWsSyDP3kVhUi0NMk7O+vT6ETcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405412; c=relaxed/simple;
	bh=ndsHv7XbPEHZWMoV/yc0iINhBYbiVJhVQnIgng0dX0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AL0pYErvdi54Xn7iUlfkm+vziI16dXSw8ZMsYtEy1zSjljbakWFZrXTZHMPfarJVMBklw5j2mCg2X0/tLcM65JoRRGnMqepJ6O+C63ocGtFupHc6z8FU/AWVmcVxQmklbdNG2+qdt9gAuNu52vESgRGnTX9PObeIVXxhP84q0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CE3ZhZWy; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CE3ZhZWy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=DNP9SqF2jJlj8r02kVfWqqiRkgnQWLA7bH2+qhtQQ6Y=; b=CE3ZhZWy6NRrvPA4t13Xk87Ubz
	rpTZU9SCMNUAqGnQBUJ5HMKIeL+MXjd1qFCyIWzGcRnCCbIcgczgrVozpPHs8aH0sUqDglbULWFyF
	04oj4xkWVf8uyFcrDFBTel279I9vwHw+/3HNlVMuwY5ZCn6HPJjH3vmg1/Y8B34WXGKrRswvxDWsW
	qu22sHR4cCG9Ru4vRHNQ6h2VoVGa7vSW2UdTiDY+7LAm+EoVI29rNEKLEUIGPaP2JJen9GHvgc1lz
	Lg0d1lNvlkeZkqN53F6dKMCZFL3plwcDVP1jic+omnwTR3eBZ5p9B0jKb5scqB1wCIGXn0Z8HcPoF
	1cpfqcGQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x6A5X-000C8C-0Y;
	Mon, 14 Sep 2026 19:03:27 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: memxor@gmail.com,
	eddyz87@gmail.com,
	a.s.protopopov@gmail.com,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 00/11] Misc BPF gotox fixes
Date: Mon, 14 Sep 2026 19:03:15 +0200
Message-ID: <20260914170326.249953-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28123/Mon Sep 14 08:24:19 2026)

Address various open issues around gotox instruction, see individual
commits for details. Also BPF selftests are added to assert that these
are addressed.

v1 -> v2:
  - Remove jt_spans_subprogs and reject right away (Eduard)
  - Rework jump table to no longer keep it in insn_aux_data (Eduard)
  - Fix up comments in bpf_compute_scc (Eduard)
  - Fix up commit message nit wrt signed_loader (Anton)
  - Added 3 more fixes related to gotox along with BPF selftests

Daniel Borkmann (11):
  bpf: Avoid quadratic successor rescan in bpf_compute_scc
  bpf: Bound the number of indirect jump edges in a program
  bpf: Cache the jump table of a subprogram during CFG discovery
  bpf: Reject indirect jumps that leave their subprogram
  bpf: Don't remove indirect jump targets in the nop removal pass
  bpf: Clear insn array jitted pointers on map reuse
  bpf: Retarget indirect jump targets across prologue prepends
  selftests/bpf: Add tests for the indirect jump edge limit
  selftests/bpf: Add tests for indirect jumps across subprograms
  selftests/bpf: Add tests for gotox nop targets and insn array reuse
  selftests/bpf: Add tests for gotox targets across prologue prepends

 include/linux/bpf.h                           |    2 +-
 include/linux/bpf_verifier.h                  |    6 +-
 kernel/bpf/bpf_insn_array.c                   |   16 +-
 kernel/bpf/cfg.c                              |  208 ++--
 kernel/bpf/fixups.c                           |   63 +-
 kernel/bpf/liveness.c                         |   18 +-
 kernel/bpf/verifier.c                         |   58 +-
 .../selftests/bpf/prog_tests/bpf_insn_array.c | 1061 ++++++++++++++++-
 .../selftests/bpf/progs/verifier_gotox.c      |    2 +-
 9 files changed, 1276 insertions(+), 158 deletions(-)

-- 
2.43.0

