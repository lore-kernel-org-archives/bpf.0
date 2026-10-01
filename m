Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5614C6513;
	Thu,  1 Oct 2026 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898739; cv=none; b=HTxGOvn4lget6+MvFk0KSAV9t1cLTog+t+P6PJRLBEsXqak16L+098hnkeliSlk/zLhzemETlYjosjEPMffgSHZ703pNyDrf/ueH3yLee3WIgyWLIFMEpOp4UWovpypYHYL8WLOd/a17VYzwy+36UngtaSlJIiJRmkH+5bxw+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898739; c=relaxed/simple;
	bh=0WfOqWPaE1QNn+Bw3rV7NoW1h2b+lpDuNpv9/6hbWiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3xhYDLwScq4WYyxsm2aljeacLPdVptyHK/NZDvIrFdzmaE9FwEBj8fKoyOYioRAeSogC1YBsWq493Ak5LdxHikFShgMbud2/0N0pZCxmG5DWGcQbnwjlhLeW9hRokuXQddCyCd6PK28IvfGHfipKeyV3OIafAm7wEjX40Qnltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=cDoEwFsq; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="cDoEwFsq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790898736; x=1822434736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u97zBSY8/TkqrZMHyWn9ZoJVLvLo48Z/nceC1J6XvwI=;
  b=cDoEwFsqey4WptfruK8vwdTtWw7xS3ksHw6bcTLw9cO5oX13AsRYrrfp
   wdLfAjqrEJYLig9QfmuDfHmeRcwgV8H5zNynESp/SNgc3YIvgxgMDAmXi
   F6kg+0ySSUP4apK9MwtSMJA4bIrJIbUYV/tu5VintRq/f4KKra1AC3DBc
   HAwS5Zw2KjQDzEGUlxbeZhKAf1iFT/e+sFfoLcKHptl3jJxPpVLh/NExP
   Rft2d7dwxw4AC/9uaE6gTXv3kLTE7lDwOdFkLr5dtdBE4mJhfEJeTLYs+
   nKic54L59EMURWTzBj5VWgrCSN/cZuhJAAkGUDOUqmvCUtBYq1SDQMKZu
   Q==;
X-CSE-ConnectionGUID: BYg0bv2vS5qlesOGhIoAXg==
X-CSE-MsgGUID: ZTKopwaMSgWew3b/6WqzhA==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="29966744"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:52:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:18447]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.137:2525] with esmtp (Farcaster)
 id d09a9436-0aaf-4a33-acde-8d9beb9f1001; Thu, 1 Oct 2026 23:52:15 +0000 (UTC)
X-Farcaster-Flow-ID: d09a9436-0aaf-4a33-acde-8d9beb9f1001
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:52:14 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:52:14 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>
CC: <alan.maguire@oracle.com>, <martin.lau@linux.dev>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <nathan@kernel.org>,
	<nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, <mcgrof@kernel.org>,
	<petr.pavlu@suse.com>, <samitolvanen@google.com>,
	<linux-modules@vger.kernel.org>, <ojeda@kernel.org>,
	<rust-for-linux@vger.kernel.org>, <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <abuehaze@amazon.com>, <doebel@amazon.de>,
	<mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>, <martin.lau@kernel.org>,
	<mason@kernel.org>, <ihor.solodrai@linux.dev>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 5/9] bpf: defer vmlinux kfunc and struct_ops registrations
Date: Thu, 1 Oct 2026 23:52:14 +0000
Message-ID: <20261001235214.5706-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6190890bf058dd560c895a769a114cf36530d1b8a9521fb55434566217882eb4@mail.kernel.org>
References: <6190890bf058dd560c895a769a114cf36530d1b8a9521fb55434566217882eb4@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Right, the comment and changelog were stale.  v4 (patches 6 and 7/12)
states what the separate lock does keep:
https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/

With its own lock, btf_module_mutex, which the module notifier takes,
is never taken under btf_vmlinux_lock, so the two stay unordered.  The
code is unchanged.  In v4 fetching the BTF no longer takes
btf_vmlinux_lock with =m at all (it never loads or parses, see the reply
to Alexei on 4/9), so CO-RE fetches it under cand_cache_mutex again, as
upstream does; with =y nothing is queued.

Jay
