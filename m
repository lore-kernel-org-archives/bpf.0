Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864A509F17;
	Fri, 25 Sep 2026 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377373; cv=none; b=BfdyI49Z5xkDaS3ZYbgDdzzpNLC1krzcK3NGy9H34yY+KjAWNISEl2KWvQzv63zC8PIdWVW222N6g8GWMWBhuGIZ57XnCGyOMFy1huk0/INB+02AKBsUKBGYA3F0DPWeFCOq2sS1Zhd1P0gJNH+XVXQ7rlDdbP4jVE0JobTKcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377373; c=relaxed/simple;
	bh=XFDwBn0X7gWj9JAALLConbPCcAT6qEKvO+fHh6h4pdY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMq+D/nSnfAXWoz/nqx097/vGO+8H6EDHE3ktSc859I2h9xaCoWp8Q9b/GkreGu0l/BaV2Tyxve//caSjjDqkMqOdLNpPcoPVMyc1xmWlB2fILfClePGm4DlzgXS0Mk5TqVgSsqq2no+EdPVyIXiEWrIifyi+Qsswd625ES5i24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=hk/hOpWh; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="hk/hOpWh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790377372; x=1821913372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKSO8THHwYBe08VRm/opRxxMasd0P/ZtRf9RqErgqD4=;
  b=hk/hOpWhIYwDssLpP6Af3OWtxebmgI9JGTtrJ/HuV6+6IF36SjcwzpaH
   hSpOsS0nnUfyLw0NWBM5Q258XMCHoNThdNgLtumjWEwG+zNkh6mnRDyC4
   AQjwrd/BYERWQjmG0iZPRoy7YDhU4jaFuGvRO06QFj1GwitxdVUqnJVmR
   SwSI9VnzXnNy5TVdZxpra1vuCukGUZZ8zrOLMUGrTTPwmK9bLjZi49noE
   RaRvp+ApzwARLd7XfaRMHihIuho/DdwYeCnBOodNpXiTjSdjSM1VPVFPK
   HDp6AJ62KkC/HACKUDuvN3/DIpDKKnq5mWR6JBD/fm7tiRJbNuNMXEKlX
   g==;
X-CSE-ConnectionGUID: SYultWzYQIGWzCBYuasbJw==
X-CSE-MsgGUID: ycXjobLFQ/yMvYUeBwjwpg==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29482114"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 23:02:52 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:30404]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.27:2525] with esmtp (Farcaster)
 id b4b0b8e5-35f3-4e1a-b6b2-c408a9d7ab12; Fri, 25 Sep 2026 23:02:51 +0000 (UTC)
X-Farcaster-Flow-ID: b4b0b8e5-35f3-4e1a-b6b2-c408a9d7ab12
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:51 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:51 +0000
From: Jay Wang <wanjay@amazon.com>
To: <sashiko-bot@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/9] bpf: fetch the vmlinux BTF where kernel types enter a program
Date: Fri, 25 Sep 2026 23:02:50 +0000
Message-ID: <20260925230250.34259-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925214242.367201F000FF@smtp.kernel.org>
References: <20260925214242.367201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

No change for this in v3:
https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/

This cannot be reached with btf_vmlinux NULL.  In check_reg_type(), for
ARG_PTR_TO_BTF_ID and ARG_PTR_TO_BTF_ID_SOCK_COMMON without meta->btf,
arg_btf is only used when the register is PTR_TO_BTF_ID; a PTR_TO_SOCKET,
PTR_TO_SOCK_COMMON or PTR_TO_TCP_SOCK argument breaks out before it.  A
PTR_TO_BTF_ID register only comes from a place that has loaded the
vmlinux BTF: attach_btf, kfunc returns, BTF-typed helper returns, map
pointer access, the program context types, kptrs (bpf_find_btf_id()
fetches it), or a ksym.

The ldimm64 case in the report needs a module BTF fd, and with =m a
module BTF only gets an id once the vmlinux BTF is published:
bpf_get_btf_vmlinux() does smp_store_release(&btf_vmlinux) before
btf_parse_deferred_modules() parses and registers the modules kept
until then, and a module loaded afterwards is parsed against the
published vmlinux BTF.  So a program holding a module BTF implies a
non-NULL btf_vmlinux.

Matching ARG_PTR_TO_BTF_ID_SOCK_COMMON in helper_uses_vmlinux_btf()
would load the vmlinux BTF for every tc, XDP and sk_lookup program that
calls bpf_sk_release() on a socket from bpf_sk_lookup_*(), which never
touches kernel BTF, so the series leaves it out.

Jay
