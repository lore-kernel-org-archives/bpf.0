Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9936850C299;
	Fri, 25 Sep 2026 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377379; cv=none; b=A/beS8T5oI1CEtA60is9QpbswJ5pUUkyWaIGwADQGdpC/4JKr9nDSV5wf1gY3KNTSmfh4Cn8aaNHb0q8CXqslx50RcYwimWQdJXLG9V+oi/cXWswadVVU/2O5hee+hYBo5U/QwuO7IOVI1j0fXJatKNXOeOVjumOKN8LhFoiVIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377379; c=relaxed/simple;
	bh=yr1SOWqIiEj7Q00feEiT/qKFzdWBE2zUQNEIQtzu2J0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bc8iTeF4id3I0qJa9PSIhdmJiPoqawdLAG/Plnh0rFIpOjpHqoNpemYGUxkim5VwowJ3ELw4ZNFL3ZEgqUMogWdzl0I+1Gt4keeSMRkxjdrHysqxpDvtrlzOUD/aMoigNFkn6bXpn9NGWf/S2FhigiG6kR9W7umykkBZZVzSopk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=iYCIjcBF; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="iYCIjcBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790377372; x=1821913372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=orMjQaXKz+qvrj7AuxAJgiSxWem/Ez0qj7EgH5yqoJE=;
  b=iYCIjcBForOltEtxDcQRdcdiDD3VzoNjio0bI2+dnRvZoC0PL4ZvvW1F
   N+K1qq/Vm517Dss654gfuJBDava/v447wX2VO62IWabq6bkb1rJr/+7vw
   paP3ujYMt3jxBzPPwTcY4nuNLHO7H3bM4Bj0dKVkHYrA9ccZRP0OpsmjD
   f7SyRBzy6nP4mLRIl0CfZjtzfINAe27AhPR5L74dOPdVZoXAT4aZHBNxl
   z/adz4YeVyyg9CDaEkSYxGJUvZyfBfw7dRxx/y64vG+FvZe478ImFDafK
   ejf9QbC0SSFFvoN0GRoAzQyfWme1qyJkHXC2mdPAnoGFXh2rJpqwThQBB
   w==;
X-CSE-ConnectionGUID: +vRb1HJURJaBXnnVwYBI9A==
X-CSE-MsgGUID: xKJZBMPWSTC+oA4FyJwMrw==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29469738"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 23:02:52 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:25731]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.144:2525] with esmtp (Farcaster)
 id bcd82e75-1286-4605-b7f4-016f5a08ce20; Fri, 25 Sep 2026 23:02:52 +0000 (UTC)
X-Farcaster-Flow-ID: bcd82e75-1286-4605-b7f4-016f5a08ce20
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:52 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:51 +0000
From: Jay Wang <wanjay@amazon.com>
To: <sashiko-bot@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 6/9] bpf: keep module BTF until the vmlinux BTF is available
Date: Fri, 25 Sep 2026 23:02:51 +0000
Message-ID: <20260925230251.34380-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925212938.3B4D91F000FF@smtp.kernel.org>
References: <20260925212938.3B4D91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

No change for this in v3:
https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/

I don't think this can happen.  do_init_module() runs the
MODULE_STATE_LIVE notifier chain before it drops the reference it holds
during initialization: the "Drop initial reference." module_put() comes
after the notifiers, under module_mutex.  While the LIVE notifier runs,
the refcount is therefore above MODULE_REF_BASE, and a concurrent
delete_module() fails in try_stop_module() with -EWOULDBLOCK (short of
a forced unload, which is unsafe for any user of the module).  So the
module and its kfunc sets and struct_ops stay valid for the whole of
btf_apply_deferred_regs() here, without a try_module_get().

Jay
