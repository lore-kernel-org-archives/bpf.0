Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C350AC35;
	Fri, 25 Sep 2026 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377372; cv=none; b=B9RPB8DBQaxc9loqzvgBmXf1CdFuocH0V1gdiqHfDcOFQ/2pTsmfWoZvIZ5luYamXOfiwK3JHucX47Ts8IN2tJrq1p8r/zfB1QFtNV0zNCgQ5FNCJKbdmrxYZYHJ7KL1XlJBZaNUnnNImFk6s/EGM5POoF6wIwN8KMKcRinyvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377372; c=relaxed/simple;
	bh=8ZPkwMUq/o3NVdZyVSjTcolvQzNsGOKzEFj7dzmkoEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgGz0M9Gntz89lo93UY7jS9AmXJD9gjSP8j2b9JlAe2HJIc1qqP5IcX5WIQEWO5NmmASxypcKx3yBvCHFtnEWdFxhc9U1G9ROgzI3todkKwAZnJKAHurGjms8dWNAo5AIpENz48Hf6UMsKHM7Zq8p7ROg4IZtnzWeGSnLVRnQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jZDc8wOo; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jZDc8wOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790377370; x=1821913370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ZPkwMUq/o3NVdZyVSjTcolvQzNsGOKzEFj7dzmkoEo=;
  b=jZDc8wOoIG0swCAAsj49rrRh+9MpHbRmFkkzG2vQXtRiVVPQnF7goorr
   YCpF/O7fguoi3Xe2M70D6D7lUZObZEXAOLPoBMZzzZIpSXJjmyfN0kcyf
   L0alsvP1xeBWCXUwcFQ9q9K0K4CUiqkLOPNNhscTt5zQEFiF6O2t2m+Or
   eUoFBUwFenghzTwUL5Gs2EdsE/z5TLnLbb2AUokEkGKWvqhbJFNjRAyG4
   0BTcT9xQ/JQk72LsXlyosBuCCjeDgubunH6lNEJzteT1WrHhmQYIuJuJF
   JeRyo6kQXul5Yj+ukrZhMr/6EJJH7rbB3nBbNeSqo4sjB3LIm64XJeQPV
   g==;
X-CSE-ConnectionGUID: /3yBxI6sS+mZzY9dHmDsJg==
X-CSE-MsgGUID: u5+7Nd9OSsGY2iyfvNqYiw==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29458005"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 23:02:50 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:7393]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.1:2525] with esmtp (Farcaster)
 id 51692136-ff19-4f9c-b9e4-481b6b1108e9; Fri, 25 Sep 2026 23:02:50 +0000 (UTC)
X-Farcaster-Flow-ID: 51692136-ff19-4f9c-b9e4-481b6b1108e9
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:50 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:49 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>
CC: <alan.maguire@oracle.com>, <martin.lau@linux.dev>,
	<yonghong.song@linux.dev>, <nathan@kernel.org>, <nsc@kernel.org>,
	<linux-kbuild@vger.kernel.org>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
	<linux-modules@vger.kernel.org>, <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <abuehaze@amazon.com>, <doebel@amazon.de>,
	<jay.wang.upstream@gmail.com>, <martin.lau@kernel.org>, <mason@kernel.org>,
	<ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 2/6] bpf: split the kfunc, dtor kfunc and struct_ops registration bodies
Date: Fri, 25 Sep 2026 23:02:49 +0000
Message-ID: <20260925230249.33955-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <9ae62cc7c8da94b68778bfd040a658730a7b098ddc64f6d23d9a4a895f71b994@mail.kernel.org>
References: <9ae62cc7c8da94b68778bfd040a658730a7b098ddc64f6d23d9a4a895f71b994@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Addressed since v2; the current version is v3 (patch 2/9):
https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/

Renamed to btf_struct_ops_register().

Jay
