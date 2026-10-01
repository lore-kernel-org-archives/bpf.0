Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDF2233722;
	Thu,  1 Oct 2026 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898752; cv=none; b=A8HE4Hs0HhSnkEGisPU9i2pwIkbvrfFOEMI5Ju+OcQWdb6117hcglq4xo1//Dzc/hCcSHJBbBeicf4LPVRAWo2sVagF96PB8KU6bUSHtxH45v1Q3r9EUzmEv35tFydgznGir2aQJtIC6Jcs+Xf+HpsXWPZbRqUxMGdkKLh4QST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898752; c=relaxed/simple;
	bh=NrJ238JdYWDlWOUxA5Z9MMDXRLYVZBfMuVUdx48Kvdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dxjaNtHCj0T56My4CuLEJG6ushX68waCQqEDfrePIvwA9O1gIG0EvYBsZfWdu/MhteopdlCn/wad/Ivo+qyXJs6ZVkkHGO4BOFCQs3DJIPzkseLsxbqAx4YvfB1pWw5iVUGBPg2rx9BHi+omrHEUD/p4oN0zAjBJQeYo43rzY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fQrZKEHa; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fQrZKEHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790898751; x=1822434751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=chsvdAv+AD1RToPnKUfGFKc1ecRsWG+BUh3agbKP94k=;
  b=fQrZKEHafT5rUW29PTmROn1R05s+T9aVCxDWQaHEm6VZ5dLnrljXuwAi
   gH9JE25ecCGJIq/WGF5TN9FR2x23k42xIAxczCtQul6S8ut+bsX8gpfAr
   Y6b0R6Eg9DQmnJCekDIF1h5yEGKwiS174zeXqihWY1A5xLHJ0k3LpGFCY
   +VnLuepYP8HSUSNORUG3ECZjDAM4O6BuiL/Tn51Yclq/KFobJfyT/zmPb
   YG4Px7YU8kidLlaiVuVX1v09Yy/JY+cB3DDoalM0g3T60YXvjv9tyFMgp
   0CHMf5iMCO9cpXJierfnimpeQwkvNTVCr9+u/hVXUHEmpfpKXpoCWTAUl
   w==;
X-CSE-ConnectionGUID: QEmvWz8ERsOrBp3SH8nNLQ==
X-CSE-MsgGUID: xrKA9kTfQKOp92pr04MSYg==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30055940"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:52:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:1357]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.113:2525] with esmtp (Farcaster)
 id 4f6ba821-d170-46f0-9367-89b80bda748b; Thu, 1 Oct 2026 23:52:30 +0000 (UTC)
X-Farcaster-Flow-ID: 4f6ba821-d170-46f0-9367-89b80bda748b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:52:30 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:52:30 +0000
From: Jay Wang <wanjay@amazon.com>
To: <sashiko-bot@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-modules@vger.kernel.org>,
	<ojeda@kernel.org>, <gary@garyguo.net>
Subject: Re: [PATCH bpf-next v3 6/9] bpf: keep module BTF until the vmlinux BTF is available
Date: Thu, 1 Oct 2026 23:52:29 +0000
Message-ID: <20261001235229.6107-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925225915.76BCC1F000FF@smtp.kernel.org>
References: <20260925225915.76BCC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Right, fixed in v4 (patch 8/12, where the deferred reader is added):
https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/

A dead entry now keeps its raw data only if its sysfs file serves it
as is (sysfs_bin_attr_simple_read); for a .BTF.base module, whose reader
fails with -ENODEV once the entry is gone and never touches the data, or
without a sysfs file, the data is freed with the rest.  Tested with a
.BTF.base module whose .BTF is corrupted, loaded before the vmlinux BTF:
its file fails with -ENODEV after the parse failure, rmmod is clean, and
kmemleak reports nothing; the same module without .BTF.base keeps
serving its raw bytes.

Jay
