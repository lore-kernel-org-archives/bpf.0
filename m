Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E44FECFD;
	Fri, 25 Sep 2026 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377371; cv=none; b=LDZKd6FE/epLGSG1p2G/Lx+/4G6BAybLFa23j64VVBmsTki59i0+OGL3SOuVAxObHyofLKnEwyXme+XqmS5Xp56ozKfXZn0c9ch9QIeuFJallm/TlgAkpgv9gtJaKRBiMJUxYiyp8pCAoDyFd5cuept8keOBD3tC3sD9Uvmz0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377371; c=relaxed/simple;
	bh=2v+E53EfjN0kCPXf2Fn/CGhtKF69yD8PDJ0/bgBkoQg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+qRj3Suv47Q0oL64t+k2gs7H9+GE3keyAeSLkNlPiHccWAsACUNZ50ZPIl/1yA/KMlP5yNDWl28M+3ufiKrNy6cWGo4j2bXuN9tdZ8bUBjCMe/61wVWEx3xRSNPv9AORGUS1PSYno56kFR96Hp03CTDtK4caFkZJYmYXiWGP84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=T1Gbmylr; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="T1Gbmylr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790377370; x=1821913370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EGs06y+7Wh9/2IF25Dt7R6J6uiDUXBNhK4yz4i4h7Jo=;
  b=T1Gbmylr3Sbj3lIhAo3AeQk+zL5RykarmS7qvoSlupME8wv3uuJxtjEn
   BeHuVb68XqL4C0PHQLYgutNExcemrrPVXe3yi4v8eRSY2RyX2d6MFj5Jx
   Vs/Dm7868cpPy4zyDvRuERF+kbHwe1j+ECMkJY2IiFS4oEqpUKIdTTstR
   pO5Chv+A2s/f+GzZzAG6kra+/snk9IawsaZJNuZYyToPT8lKKRTwAq1l3
   F7D0SYk9rVlc25ScXCA4wmE6TXVHV1/cBRfy1eFivF0+GWpgjEk3rUbPp
   daOZRbScvCBiBSr4QV7tmOSm7v7ybLGW+RGur4Q3jO2/BZ4mEvp0FhtdV
   Q==;
X-CSE-ConnectionGUID: PE+giJ+8QROoKaR0KZd/sQ==
X-CSE-MsgGUID: GDWYo02bRTasozL9WcuyOQ==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29463262"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 23:02:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:29635]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.110:2525] with esmtp (Farcaster)
 id 7e173256-f31f-4043-84a5-ba0ef322c574; Fri, 25 Sep 2026 23:02:49 +0000 (UTC)
X-Farcaster-Flow-ID: 7e173256-f31f-4043-84a5-ba0ef322c574
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:48 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:48 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>
CC: <alan.maguire@oracle.com>, <martin.lau@linux.dev>,
	<yonghong.song@linux.dev>, <nathan@kernel.org>, <nsc@kernel.org>,
	<linux-kbuild@vger.kernel.org>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
	<linux-modules@vger.kernel.org>, <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <abuehaze@amazon.com>, <doebel@amazon.de>,
	<jay.wang.upstream@gmail.com>, <martin.lau@kernel.org>, <mason@kernel.org>,
	<ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 5/6] bpf: defer registrations until the vmlinux BTF is available
Date: Fri, 25 Sep 2026 23:02:48 +0000
Message-ID: <20260925230248.33699-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <f0a28d1ffadcd0dbc3209da34afb902c4911ad9e31cd90a1b640d4c1592cf11d@mail.kernel.org>
References: <f0a28d1ffadcd0dbc3209da34afb902c4911ad9e31cd90a1b640d4c1592cf11d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Addressed since v2; the current version is v3 (patches 5-7/9):
https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/

Most of these are real, and btf_parse_deferred_modules() is
restructured around them:

- A module BTF is now published (btf_mod->btf set, id allocated) only
  after its queued registrations are applied, so no program can see a
  module BTF without its kfuncs, same as for vmlinux.

- Only modules that have reached MODULE_STATE_LIVE are replayed there,
  with the module pinned, so nothing registers concurrently on the same
  BTF and the module cannot go away underneath.  A module still in its
  init when the vmlinux BTF arrives is only published; the LIVE notifier
  applies what its init queued once init has returned, in the loader's
  own thread, and a failed init frees the queue at GOING.  This covers
  both the concurrent krealloc() on kfunc_set_tab and the
  try_module_get()-on-a-COMING-module lifetime issue.

- On btf_alloc_id() failure the buffer the sysfs file points at is no
  longer freed: it is handed back to the entry, which stays on the list
  as a dead entry until the module goes, and only GOING removes the file
  and then frees the data.

- Modules with a .BTF.base section: their sysfs file is still created at
  load time with the final size, but its reader loads the vmlinux BTF
  and waits until this module's BTF has been relocated and published
  before serving anything, so no unrelocated or half-relocated data is
  ever visible; modules without one are served as before, their data is
  final.  Because that reader may be the thread doing the deferred
  parsing, sysfs files are no longer removed from that path (a failed
  entry stays dead until the module goes) and MODULE_STATE_GOING removes
  the file after dropping btf_module_mutex.  Tested with an out-of-tree
  module (distilled .BTF.base, kfunc registered from init) loaded before
  the vmlinux BTF, with its own sysfs file as the first user.

- sysfs file creation failure is non-fatal in the deferred path too.

- The btf_struct_ops_register() stub is only defined when
  BTF_MODULE_NOTIFIER is; checked with BPF_JIT=n.

- Lock ordering: the vmlinux queue has its own mutex, so nothing takes
  btf_module_mutex under btf_vmlinux_lock any more (the kfunc name
  check returns early for the vmlinux BTF), and CO-RE fetches the
  vmlinux BTF before taking cand_cache_mutex, bpf_core_find_cands()
  only peeks.  That removes both new edges of the cycle.  lockdep is
  clean with CO-RE programs, module BTF and rmmod in the same boot.

- The vmlinux queue on parse failure: with =m the failure is no longer
  cached (see 3/6), so the queue is intentionally kept for the retry;
  bpf_ctx_convert.t is reset so nothing dangles.

Jay
