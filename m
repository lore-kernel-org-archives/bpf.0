Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AE94BFE95;
	Thu,  1 Oct 2026 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898784; cv=none; b=ltymVDxQ9MxnfXmHx8xKNH6LLTuG0F7qWGJo7Fy+EHB4EhZSTxUswI4zcJ/9vgnAiUms14z/EeSbDu0CzhXYFNfRot5G24tubOTiqTro3hiGLW5D5Hbj1eGXBFR2+cKJiRvMy9su4/JtkKsr58lI6TFd2Qx98JcHCWyuBjNC2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898784; c=relaxed/simple;
	bh=/veSFjfpDTvESgnF+9YOuO5Zbjr+NstFT32TDXd2PrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPg40wF5sExeLkiD+rmQlc988gps3qg9ra9AEf3SJUTPGi5PPvxwP4INQVO4s3+JnhLAtZFm+rE9MSMjKCnPswIb9a+oHAHsanO8LWpqMZSx13ySHQHifQSC6PwbclIzAlhDPaQkiOr+Qubd8EVjJ/fQzzhfgai9IzIion9wn3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fkWHkcZU; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fkWHkcZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790898783; x=1822434783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kxANHnSNVsfo3V4BZi+LzUk1TCDNoWGyrIauKbRV8tU=;
  b=fkWHkcZU+CO5EHTs/ocYxLC9Na/oNcYlzpzOFJafHcmnFGSeyvpWIZNs
   xTbuOnPKi9jV5Dwl5K+DXLeqoAyRiK6VC5th06sUa3lVVfKeWhfTjcTSH
   S3GqboWkUnrIsxtHRcnHulbo5hlW8UAP47M6U2SantVWp3Wvxc2AUpmY8
   nyEuOdwkQieIUcuURzLHDDXJC+y7/Gs1j91/OWDb0bjvm7TaZuoW1dG/G
   NqMYPBRb9cMFwD/+jZZypivM0nFltWTVIDEZT0XQJ02lcFoLtbNl22Ch2
   hm4S9yy9kZqeIIMY79m4FfaJAWw9EX22KfDJiFUKIjzMgXGRXb//sSWZy
   Q==;
X-CSE-ConnectionGUID: ptytDu1ySeKuSb/4yPeISQ==
X-CSE-MsgGUID: Uwuct7xkTcCCJ1tokDDJLQ==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30183707"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:53:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:1540]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.83:2525] with esmtp (Farcaster)
 id 57b5f7b1-3a2c-421b-8838-145ea894ae32; Thu, 1 Oct 2026 23:53:02 +0000 (UTC)
X-Farcaster-Flow-ID: 57b5f7b1-3a2c-421b-8838-145ea894ae32
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:53:02 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:53:01 +0000
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
Subject: Re: [PATCH bpf-next v3 8/9] bpf, trace, net: prepare CONFIG_DEBUG_INFO_BTF checks for a tristate
Date: Thu, 1 Oct 2026 23:53:01 +0000
Message-ID: <20261001235301.7224-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <973216fc6e2c9c225b847f0f82941b5e1e2d49944c2b16ff5cbcdcdf2910e8d6@mail.kernel.org>
References: <973216fc6e2c9c225b847f0f82941b5e1e2d49944c2b16ff5cbcdcdf2910e8d6@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Right, fixed in v4 (patch 5/12, with the other tracefs and bpffs
requests that load the BTF):
https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/

event_btf_ids_read() now calls bpf_load_btf_vmlinux() before it takes
event_mutex, so the btf_vmlinux module load and its trace notifier run
without it; btf_get_module_btf(NULL) under the mutex then finds the BTF
already parsed.  More generally, in v4 the lookups themselves never load
the BTF any more (see the reply to Alexei on 4/9): the probe argument
parser (PROBE_EVENTS_BTF_ARGS) loads it explicitly, holding only
dyn_event_ops_mutex, which loading a module never takes.  Tested by
reading events/sched/sched_switch/btf_ids, and by creating kprobe events
with BTF arguments, each as the first BTF user after boot.

Jay
