Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334ED50C2B0;
	Fri, 25 Sep 2026 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377379; cv=none; b=PPL+1Y0to8dml/64tHxpOZxSP5vewTKUm0fvwwsVdTr1X0dtE9vxu/QIFaVv+jgEUm3lEQ0xjhzTXwsHopusETTtyGPaauBhhHTyN3S8owHWyRrlsCpFgf8rydHilI53Lpr0AlP+snDqtX6wBLEex94qGvM16i5vBt7Cui2hkbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377379; c=relaxed/simple;
	bh=/c5Co9F/am8EjP/vE2uczd6+1rxzpiX4bq+WxQVokQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhdUZowl+gf0+kcT2xNqj35cF3SOLyojqWV5H483VpHTeR1IT8C07vPqxirtVkuMmD3j+tPkN00EdrdOHltIM0I70y3w7Qa0OJamGQwVFe1z1GzG/3E6rkcSzOeQR8BjIeR9pJvliRg+pmOmEDqJDpNkgNE/6Is06flrEgHXgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IUJUYpw5; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IUJUYpw5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790377373; x=1821913373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/nC5Hs6za1TBw6xFElyyI5lgMUaptfWcUfplRQMPLdU=;
  b=IUJUYpw5i+Si931kCt8RZG29wcvsJHkEde6EE+TeHE6iy6bm6LNGj7M0
   gVjRnnAUb5jH+7BWQHWdfYSACvxuTsYaOc/mZuiGNWDhd/FHtD3h+M/Vr
   l/ZGi+gzq0Hpi5ubFWDgUA+nd7x7JnA3ErbQOH8MJFmIgn/iF9YO3H/9i
   NX9URxuSp9cqpxJVc69AJqWJerVpWSwLBgybRI/BXhl58Eevu5abzjpG+
   U25Y7oPboe/0PqWcPnuOZV/UupR0rMCluQg07DZGcn6ZgaRF7tLDL1eDs
   ECUJNM/0MY0bHB+X1Hh7OCku+1+BRW6sTNRXSeJTDORVeo0hK8SeQTxu1
   Q==;
X-CSE-ConnectionGUID: 0e0YVNQNRTC6OhS2S1B8ZQ==
X-CSE-MsgGUID: u3vSdn/eT5egbyqJCBrOxw==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29582881"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 23:02:53 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:25894]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.104:2525] with esmtp (Farcaster)
 id a5162554-736a-4bf5-8a0e-aec9cf76434b; Fri, 25 Sep 2026 23:02:52 +0000 (UTC)
X-Farcaster-Flow-ID: a5162554-736a-4bf5-8a0e-aec9cf76434b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:52 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:52 +0000
From: Jay Wang <wanjay@amazon.com>
To: <sashiko-bot@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 9/9] kbuild, bpf: allow building the vmlinux BTF as a module
Date: Fri, 25 Sep 2026 23:02:52 +0000
Message-ID: <20260925230252.34602-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925213305.A7C371F000FF@smtp.kernel.org>
References: <20260925213305.A7C371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

For "depends on DEBUG_INFO_BTF" this does not happen: Kconfig turns an
m upper bound into y for a bool symbol (scripts/kconfig/symbol.c,
sym_calc_visibility()).  I checked it with olddefconfig: with
SCHED_CLASS_EXT, NET_SCH_BPF, PROBE_EVENTS_BTF_ARGS, BINFMT_MISC_BPF,
IO_URING_BPF_OPS and DEBUG_INFO_BTF_MODULES enabled, switching
DEBUG_INFO_BTF from y to m changes nothing but BPF_PRELOAD, which the
series excludes on purpose.

Looking at the other uses turned up the reverse case, though: RUST and
GENDWARFKSYMS say "depends on !DEBUG_INFO_BTF", and !m is m, which a
bool again takes as y, so with =m those pahole restrictions no longer
applied.  v3 writes them as DEBUG_INFO_BTF=n (patch 8/9):
https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/

Jay
