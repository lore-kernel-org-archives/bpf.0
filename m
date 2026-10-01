Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F7F46F4A7;
	Thu,  1 Oct 2026 23:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898815; cv=none; b=uSK/Pqp+uDn5obRiRsaXySLeVoMReHci3Fzjay1stNUURx5pD9xWMLIT0TBP3w/W7weJ0QmWfkY1IPRwWSsZtGtHWW+Snzjd8q/DUrfIeNojKieMtr3H93GyDFW23aXxPUMWulEyLpGboCflasHYP12tlosVoT+Tu/hkKJgoOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898815; c=relaxed/simple;
	bh=sxgzWa7Pg4Vu0QV7HUff5HmJa7L8rhf32QKppY3kv4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrXpwWOHgbI6jShMVXqPo0jj2t6jv9/GlUY6i+BhGCE/DsZlnIYfCPP3abXqBMgWY1pqbE6+Lh7PdJ3c5QVp+9DFYEcPFLIQ6EY6MKMaST85m+mEmoGPAcgGa4Um2KCVhlUOeniDN9D7ctwkvUuS9yViQhUKqxPWvvLAWuQx9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=s71rMD84; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="s71rMD84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790898814; x=1822434814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aKYNDJBaF/a+oEVTdroRmzbc+8LBZqR2cnhVz8NN1Ws=;
  b=s71rMD84CQ5rDgVgCGSOdYE4S42eN2FwBQYpn107AxEPWjjzWkOHLhlw
   kJ0VEhrL10StCtGiV8FXgN9/Ewfs0ZmlMT4jeCHBNriUxMfRtyjb1phfu
   DDMQOzrkRXDLvxv2/ma4iUtspdnxOu2+vSt4hZAAWGbhq/P9qhCU2827E
   qaEKZxmvgqX04N8guw00xXF3g4/h/fACKhPWjS5u3l72NION/0hauNJFk
   bj7yQFi/S4V7OCt0U6NS1Irzu+/nU3GRP3L+5xCn7LjLKDdv74c2YIRNo
   fBb3CfdN5GQ8QXNDcNgzZg/dhpowpkCLn3mI8sw7UdNTiwhHJnj68Hg5S
   g==;
X-CSE-ConnectionGUID: Scd1Ez1gQp2utnFTzEvrxw==
X-CSE-MsgGUID: rtNnwBb8RneFt1wqoso4Og==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30178142"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:53:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:19497]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.21:2525] with esmtp (Farcaster)
 id edbeb6ac-af33-4878-a212-0ac95593aed5; Thu, 1 Oct 2026 23:53:33 +0000 (UTC)
X-Farcaster-Flow-ID: edbeb6ac-af33-4878-a212-0ac95593aed5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:53:33 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:53:33 +0000
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
Subject: Re: [PATCH bpf-next v3 9/9] kbuild, bpf: allow building the vmlinux BTF as a module
Date: Thu, 1 Oct 2026 23:53:32 +0000
Message-ID: <20261001235332.8074-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6e565a3c5689de1d5ba05904e3d7f477373bca8e10be75fea4b6adc048ab6ac4@mail.kernel.org>
References: <6e565a3c5689de1d5ba05904e3d7f477373bca8e10be75fea4b6adc048ab6ac4@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

All three are addressed in v4:
https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/

- The ftrace argument printer is a real problem: it can run from
  ftrace_dump() with interrupts disabled.  print_function_args() now
  only prints the arguments if the vmlinux BTF is already loaded
  (bpf_peek_btf_vmlinux(), patch 5/12), like bpf_snprintf_btf(); in v4
  the lookup it uses would not load the BTF anyway.  Tested with
  func-args on and sysrq-z as the first thing touching BTF after boot,
  on a kernel with CONFIG_DEBUG_ATOMIC_SLEEP.

- The opening of the changelog now names the exceptions: BPF_PRELOAD,
  users of kernel types that run before btf_vmlinux.ko can be loaded,
  and code that assumes the vmlinux BTF has id 1.

- btf.rst now lists the requests that load the BTF, including struct_ops
  maps, kprobe events with BTF arguments, tracepoint btf_ids files and
  bpffs delegate_* options.

PROBE_EVENTS_BTF_ARGS and FUNCTION_TRACE_ARGS do stay enabled with =m,
which is intended: creating a probe with BTF arguments loads the BTF, in
process context, and the argument printer uses it once it is there.

Jay
