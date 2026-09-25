Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9229388371;
	Fri, 25 Sep 2026 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377370; cv=none; b=sB81N9Vc6S/65HDTRskrTnVhAm4/s+JSXmKe1HtMCDsS4pZLKWi8A8IDeGXX7DIsL5cHQHf1rwdQLkRz7N2MEdtqW0CT8JtsbHLzFEdgQn61Wb4BVVTl8Y3qkWWg/cdDV+A3yhfddZiyr5k3kxwYaQ+PB3gWtj9RjM0MxTkh34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377370; c=relaxed/simple;
	bh=SbYi/DjOhCqJ8mXV3mGa01FI5/IYT4ssrla6E6TXutE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldzdelvKgMMMAGst97ttuac3Cz8odLLhzD6aGZGcvsH4S6hzrHDtyjX26VV7n7TQajGMnhy29husRJwHsh5E4K29XADDgAd6AaBttrcauYHK0Z7j7UOyYHN6kWhRmq1gwE6yPCAQItYZvF6LQ3cbu3Wa5uPVZHl3mfamY8GomVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=HkXRF8Fv; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="HkXRF8Fv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790377368; x=1821913368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cMzXx4MuZPmcNyCYNX3fatLUkd5Gzu1kWkljyHNC5CQ=;
  b=HkXRF8Fv+TsmgZ+i97AK1aXlAXYrSqvGFfixvb8OMNxyXRwrfb+XQ5nj
   SvCHlC/dqaRUgqQPEbTZDVbZ8sumP9vJ0nCmqUIdSEXr9s0jEHlTs0zei
   kGR9VL8TQZTq+6MJKnZoOuYmsqi0i9TDwXYBoBmKNsof2L6xZrQynfM0B
   rXAf0ICUhuhZQHxxa1tewEd9huMjZJOwW7JoB9AWCtTd5XAkbLTB3ftJb
   5stpXkL0yq6RtLWzoyOnKEFVMiotT0JaNWjP87qaNyOuEC5lDuqQlTHUB
   IwrG0yeQ91UCZb2I0/YInbBB43Y8H3zannZWt4WCZVpHrUaMvVlysprMc
   A==;
X-CSE-ConnectionGUID: Zy4vAtvCSImgrqH3d53zkg==
X-CSE-MsgGUID: b5RYACgbQrWsT8zkfPEadA==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29666420"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 23:02:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:15791]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.144:2525] with esmtp (Farcaster)
 id 33e770e7-948c-40b1-9ffc-22bea103a660; Fri, 25 Sep 2026 23:02:48 +0000 (UTC)
X-Farcaster-Flow-ID: 33e770e7-948c-40b1-9ffc-22bea103a660
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:48 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:47 +0000
From: Jay Wang <wanjay@amazon.com>
To: <sashiko-bot@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH bpf-next 5/6] bpf: defer registrations until the vmlinux BTF is available
Date: Fri, 25 Sep 2026 23:02:47 +0000
Message-ID: <20260925230247.33629-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923055633.5B74C1F000FF@smtp.kernel.org>
References: <20260923055633.5B74C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Addressed since v2; the current version is v3 (patches 5-7/9):
https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/

Most of these are real and btf_parse_deferred_modules()
is restructured around them:

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
