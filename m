Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB63C583A;
	Thu,  1 Oct 2026 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898721; cv=none; b=J8V3MZlQfEvOu7rT128iT4s6sgGBK57EWGCpy9yImlveJ9QAmuMS6PeR9M3uhkVx2cU8VwP37M/4yuL7kESs41cNRlHRdensLYJAoDE17J6MxTyYwhYEz4y16n+GhIviqCEk50mEz5kiribIYLVDp8dYTNeWblbQvAZk05Ee+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898721; c=relaxed/simple;
	bh=bU11VovPjoyYjVgudOA7JiEU+GUMnqxum7fN1vek8ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJhZNyI1RntFI/YrHLW4xguLvKGuwqEARLu1Lhok31/h9ZhRmh1i/LymgX1NPCpob7FPyb4FEWRN2fKApzSPi/dz8HtOPvtzgj1XT09Vxrdm6bOvumBMJPZfdkWoPWdO4DkLvm9n2maM7i3kDzN4ZTJ9KmliDe0pl4FxxcdLtQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bxRp4J9D; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bxRp4J9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790898720; x=1822434720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wKQqvL66kFf8Q740fNIzAGFauNJRdmZX96lGPI+MdIo=;
  b=bxRp4J9DLWfUH6qOd2aBa+kOsX3C/G5jLyCUJU0QmVYlVxNBku+VSTFa
   2aJws+crKIX+qRfUotS5NUHjePQFyMjhF7ng70KXxm6i4LmS7xNlgUuvE
   3TxsLn/51b0Y5gNgdBS2q5aybE3YjwdqGoAUKeDuHKnmJIAKlRJk8wMVK
   ruSi4WVTj5hxfGAlzWzNIuP1sZ3c7MiLRtu1uryYiwHi2dR7XZ99iCw9U
   Bzypg/hF6sgwUGXFDmjWN+DROlj1Bv4tkO0hRYJb7ds/lceJHwfsutTPz
   K2R9v51Kjzi/azr+yLGfsgCP01KHA4DG66qFEYXg7reou+eBYwOlV/ZW1
   g==;
X-CSE-ConnectionGUID: bkBCx83VRlKpK+SGxyMqSw==
X-CSE-MsgGUID: rw2AT4/uT8ODTlWVp9EJJA==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="29970326"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:51:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:21552]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.96:2525] with esmtp (Farcaster)
 id 10769654-4ac8-416c-8a19-6b052ce32c52; Thu, 1 Oct 2026 23:51:59 +0000 (UTC)
X-Farcaster-Flow-ID: 10769654-4ac8-416c-8a19-6b052ce32c52
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:51:59 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:51:58 +0000
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
Subject: Re: [PATCH bpf-next v3 4/9] bpf: take the vmlinux BTF from the btf_vmlinux module
Date: Thu, 1 Oct 2026 23:51:58 +0000
Message-ID: <20261001235158.5109-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9faaf7e8ce215ae641225ac696e5ff94b2367b688d509fc9dde43df10a0b066f@mail.kernel.org>
References: <9faaf7e8ce215ae641225ac696e5ff94b2367b688d509fc9dde43df10a0b066f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Agreed on both, changed in v4 (patch 4/12):
https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/

Only -ENOMEM from btf_parse_vmlinux() is left uncached with =m; any other
failure is a broken BTF and is remembered as with =y, so it is parsed
once, not again by every later request.  And /sys/kernel/btf/vmlinux now
serves the raw bytes whenever btf_vmlinux.ko supplied them, whether they
parse or not, as with =y.

Jay
