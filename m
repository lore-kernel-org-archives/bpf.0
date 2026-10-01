Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5568537186A;
	Thu,  1 Oct 2026 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898768; cv=none; b=BNy5B7nmHGjbNNY0C4kLxPibNxNfz93q5Ab/AXXPSTzEG7v5fubJG9dvC9tjjjJDZp4DsUyCkKOwENJ8OnzEIHEJM1V3Svupn4OSF5K3+K+dayvrxJP2iAdCJhCyAIvoG03QYBAxMVW3WhEHZZlMWBTXxCZZp4JfnDzNHvuTFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898768; c=relaxed/simple;
	bh=MqO7M+mvSQMO3JQmCGR0AVEuUeQzbidqlxzL2huJzMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqi+YuAdLHKGU/Yv2v+HKZrleBU7rWVGBSnysY/31x0ORuoLSKF96bGSjSUQfXl7MUHX5gM0rPAOtbZnVuFbYXDyDvnWLW5MaYeuUx8So+YmrWVv2lgDZeVdv+MoetHgIo37tjkfPDJ2xeFy45h8hPOYvERDokxHLwOGbqZlO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=QU5bkk1Q; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="QU5bkk1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790898767; x=1822434767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aydqBv496UeANF4rMw/vv1EHEgivglGqXta/Yz62tu8=;
  b=QU5bkk1QwNTXUfy3izQEGLNZRIMtvRQj07JUBi9cczqNNaTSgektFFEv
   fp/R9Qjf6SCcQpN/228z2TTt6qnFo73GPrmmMiVejIRr/e7Bf18r+NTgQ
   1KgUBmcStBFoF4IDNKKe1IWN61NREJOxo1wApCz7GFoYAwrF+I3ytAIMp
   GXTj/gt62HVq3cTELP4A9p4OpYbVLJ8heSDYQw0BeSza5sJGQ73p/n+b9
   KQUGDcbXVjvUoKR+qjnsr0TWnDrX4Nthzoy/JbrTt5cV1rQWKJlJiyCmm
   w+t/Kmpi0n1fg4keIcyIB1dQ9jUIZJrvKIicMyqAZ7HXC5m8Vmd7CY9D5
   A==;
X-CSE-ConnectionGUID: psVFRns1SpWRx25GR6tTbg==
X-CSE-MsgGUID: iM3Kf8gVTh2ksLGfFFA3Pg==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="30097947"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:52:46 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:25408]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.224:2525] with esmtp (Farcaster)
 id 6cd0ce69-4e9a-466d-a721-b29fee402ad1; Thu, 1 Oct 2026 23:52:46 +0000 (UTC)
X-Farcaster-Flow-ID: 6cd0ce69-4e9a-466d-a721-b29fee402ad1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:52:46 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:52:46 +0000
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
Subject: Re: [PATCH bpf-next v3 7/9] bpf: expose deferred .BTF.base module BTF in sysfs from module load
Date: Thu, 1 Oct 2026 23:52:45 +0000
Message-ID: <20261001235245.6625-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <3541dcaa6eba351d0e66f2c324b2919453a7ad4f1a29170d8ce9b4435feeb0d8@mail.kernel.org>
References: <3541dcaa6eba351d0e66f2c324b2919453a7ad4f1a29170d8ce9b4435feeb0d8@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Right, fixed in v4 (patch 8/12):
https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/

The reader no longer loads the vmlinux BTF itself.  If it is not there
yet, the reader queues a work item that calls bpf_load_btf_vmlinux(),
and waits for the module's BTF to be published, for @gone, or for the
load attempt to end without the BTF.  MODULE_STATE_GOING sets @gone and
wakes before it removes the file, so the drain no longer waits on a
module load: in your cycle the reader returns -ENODEV, the drain
completes, GOING returns, and the kworker's modprobe gets the rwsem once
the writer is done.

On the lock comment, you are right that the btf_module_mutex ->
cand_cache_mutex edge is gone.  v4 states what the separate lock does
keep: btf_module_mutex, which the module notifier takes, is never taken
under btf_vmlinux_lock.

Jay
