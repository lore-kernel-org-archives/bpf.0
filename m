Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0843E0230
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545349; cv=none; b=B84dFX7EFGNxb4hz31oR2CSDvTT4g9wqGjzQGVuSOOrQV0TTgL6Wi730g3i55+BMNZ/efI9wAL8QxULLjU1/+AxFn++t48C0dyKYvi56iU2Xjim5IZ2s6DYkhttVfudmSAPlGjh2PxpdzhMafOjgGs00oDqnuiKOd4pCL7s2lk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545349; c=relaxed/simple;
	bh=6UVyPnwfuIaWdRvabyeH767jDbIuT5Z5GJsM12VkD1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AA1U8/7QX+NRAQavItC/x9IPqxy8OCtL5fKVztbaprV9topSmOprO9ljKOa2g5IzcXZzMXNhn2GUh8zQuMWduFATf79jxyYJfJKPQ9EWdVDPnWQFtr9ZO1FbNZ+qFgjutTWnHnmSW+7Q3Nltkp6lGw2IXxMF3dIIc1CwJOqy31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G8PUZbWX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G8PUZbWX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Hy8/SKJFSP/T0/8Mjr+DVPSHc7y45n8lqF361n//c2w=; b=G8PUZbWXlDM/jh79Md3CGSAmi2
	IIdLkuD6YfMT2Uszk6rwjrhkCUlPOi4pGyhuOi9AlgQK0Zv5NYQCq8hTifDGnI4QqDCHObREKlOCk
	UAknC6H/j5o9wXp8LDtKWXFaAhZDXSCq1f/zsIflE2TKwlzhHnlSVou4/1SDboV4Mw0oFwnMnPrzH
	pCTnpYaemvvgVdMmUaiNtMlTZ/t7qxu76Q5Hl4x6DTt/GFKuzWNcJAjCXGvXV8/eKAY6cr+7efE+p
	pv5yBXQn8wwaQp9NzlPgDWUmEjlm8ZZ4uvESLEslnXd7msa3uG9ZBdrgDTSzyp2ZT1JePwo4A6kFn
	4EpBLoOQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whZcI-000OUT-0j;
	Wed, 08 Jul 2026 23:15:38 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: ast@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/4] Misc BPF fixes from sashiko findings
Date: Wed,  8 Jul 2026 23:15:33 +0200
Message-ID: <20260708211537.371874-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28054/Wed Jul  8 08:24:53 2026)

Addressing some misc/random findings from sashiko that are worth fixing
which popped up as pre-existing issues while working on the signed BPF
loader series.

Daniel Borkmann (4):
  bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux
  bpf: Give vmlinux BTF init its own mutex
  bpf: Account insn_aux_data allocation in bpf_check
  bpf: Account scratch buffer in bpf_prog_calc_tag

 kernel/bpf/btf.c      |  2 +-
 kernel/bpf/core.c     |  2 +-
 kernel/bpf/verifier.c | 30 ++++++++++++++++++++++--------
 3 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.43.0

