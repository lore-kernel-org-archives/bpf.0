Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08112F28EA;
	Fri, 25 Sep 2026 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377368; cv=none; b=Rq31UUWQuM3rDJHpk5jP2f5bocs1irmluVG1zDpEpLnXRXnXjbEgey0qVy32Is/WLm4INref24oY4jMc1ss3ZRCaxANBA/BrNOB1cni8oPpicPAWki7xBotPrk/x4EeVN5txL/caOtB0JBjylMPR+sXRQUj8aagRPvGvR8xktMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377368; c=relaxed/simple;
	bh=pdCv4UcozVHgKk7UfV9mEseJYHtwD2DHpqfJ6KA5iAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDU87KLBMulpJCW/xMjW0KvhCSHJZa5f85/wwyK0ocIEKrSEbYws/oiBt7OmGz1MGeaWoHPjdVxOYF0QzXCzI3P43+mWDfGngiFWfKb4nvm+/6Y5pij6aH5GZ5FU93rFGgJ7BHly2+LULCo1dqrTLGYdDC3oCPoddhLnJtPM7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cbUWg+IW; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cbUWg+IW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790377367; x=1821913367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JQe85Z5Rbqw6JLCH1J2snkDs7p4I536/WA8nqd/VrHE=;
  b=cbUWg+IWMAYyC9x8mHM2LGsK5MsiMHWvYyFzUlYGfZCD8FNdUuxGubSL
   6tdNOu+DW6SsN25yWrjoTX5cncHyUVaYpsrNlLlFjFIPoQCPwIn7w5i66
   kzw269WLeodnbPyigKV7wT6JoBLkWxxuvE67i1PE2OawCudxGywgx7AfY
   VPhL+gJIRvC9RUqXUgzqkBa33vlSNckOSjtZU6TVY8Vl8NeTNZ1z4UnxZ
   TAnjgiRCo29lQaqTKqPNXtC2knb1x3ARWs4q/TS4Ctjf6s0lh5IzubWYR
   3UdTKzBCt6AjxkXmmSjNnGOLZd1VYqNmXiq4XkqBXNG5L3yJR7ksI88bG
   A==;
X-CSE-ConnectionGUID: uipxZM87RpSRn9Liy73PhQ==
X-CSE-MsgGUID: zv8lrcrVSNKGAOh+/qbMjw==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29482105"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 23:02:47 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:16085]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.110:2525] with esmtp (Farcaster)
 id adb83cc6-49e6-4043-b38b-78d57683a235; Fri, 25 Sep 2026 23:02:47 +0000 (UTC)
X-Farcaster-Flow-ID: adb83cc6-49e6-4043-b38b-78d57683a235
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:46 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:46 +0000
From: Jay Wang <wanjay@amazon.com>
To: <sashiko-bot@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/6] bpf: fetch the vmlinux BTF where kernel types enter a program
Date: Fri, 25 Sep 2026 23:02:45 +0000
Message-ID: <20260925230245.33254-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923060420.F3F141F00893@smtp.kernel.org>
References: <20260923060420.F3F141F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Addressed since v2; the current version is v3 (patch 3/9):
https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/

Two of these are real gaps in the set of fetch sites and are
fixed:

- bpf_ctx_convert.t: the program context types are kernel types too, and
  btf_prepare_func_args() (global subprogs taking the context) and
  btf_translate_to_vmlinux() (ctx access of tracing/EXT programs) read
  the table without anything having fetched the BTF.  It is now fetched
  in the table's readers.  Tested with a socket filter whose global
  subprogram takes struct __sk_buff * as the first user on a fresh boot.

- bpf_snprintf_btf()/bpf_seq_printf_btf(): the type id travels inside
  struct btf_ptr, so the arg/ret type check does not see it.  The two
  helpers are now named explicitly.  Tested with a raw_tp program
  calling bpf_snprintf_btf() as the first user.

Also addressed:

- The IS_ERR(btf_vmlinux) check in bpf_check() now reads through
  bpf_peek_btf_vmlinux().  With =m a failed parse is not stored (below),
  so it only fires for =y, where the BTF is parsed at boot as before;
  with =m each fetch site reports the failure itself.
- btf_prepare_func_args() and btf_check_kfunc_name() check the result
  of bpf_get_btf_vmlinux() (pre-existing, but cheap).
- A failed parse is no longer cached with =m; the payload was verified
  against the kernel when the module loaded, so a failure there is a
  resource problem and the next caller retries.  =y keeps caching, as
  before: a parse failure there means the build is broken.

Not a bug:

- bpf_verifier_lock vs request_module(): the lock is only taken for
  unprivileged programs, and none of the fetch sites is reachable from
  one: kfuncs, ksyms, map pointer access and the BTF helpers all need
  privileged program types, and the context-type path needs a global
  subprogram, i.e. program BTF, which BPF_BTF_LOAD only accepts with
  CAP_BPF.  modprobe does not load BPF programs.

Jay
