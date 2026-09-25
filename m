Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023250C286;
	Fri, 25 Sep 2026 23:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377373; cv=none; b=Nomx1L5xYYWXxhw/lm8hq84ercIaIbyx3Ir3mBGrVEeubxAlNGDw5usm7TboLI6Og/c8uxyWzsauureljHnD4dK6FfcwswlMbNEdpfYLmwsCBqfZg46EpTuIWByWghEy5GQ8FjlO/rxzYfMVoDZw7HfqsUw+/RUqJdiHOHWlPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377373; c=relaxed/simple;
	bh=npqPsx71c3A0lHOniUX7D7FN1GXlUvIoGBCJSOsBsC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1uuFnn2U50IjN736lWJXX1tU4uEi/sPyEesIBEU1AnM4Ra9NbMqUlkzgZKH+tHVyTjlLYMW4mHxkitQy5Y3LSMiDnEAbI1E0+4+8oZUwfYxpSANX0903m4heWTMU5UeVbIuV+kZD+lmkyrdaUiNYKFLLqzMuePe6JX+tSZiUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MNUJ0s6V; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MNUJ0s6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790377371; x=1821913371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4gLqE0UPSSjstr5S5r2WPwxuCXJWHs/Q+tdJoXNSzM=;
  b=MNUJ0s6VhPfbMjOlfQ+lX9HK9Qt4aedAGR3B2sMhzMyz2ukyq1innKTW
   tf4CXaRMk6Q66ST/tIl8JwfAQFDgNxXONcnkLLZx1QUQ9RCZ4n4itu2X5
   SJXdDBupntybUyAaqQi5pyuY2scdHWLeE8/4ObBzHFNM+N7hCmfDI1KaJ
   tWPMLKiqK/4W8lHylE4/C+vvsOme/Gcagv12/QJ/Tpf8PFINLXgJYokjT
   y0hxpTIJPmC97MpCszZFIfP0FsNok90oJxbxuDOJWiEzQqwptmRiZvHWh
   BzwwyEEpM2RTi3HDowJgvnzCpqAsC9KRyL96CBFKMTCtb/bqQ4uZVilVj
   A==;
X-CSE-ConnectionGUID: 9kyTpTh1RnGZNdonue5hIw==
X-CSE-MsgGUID: Oz26GpIUSJGspVFK+agedA==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29582880"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 23:02:51 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:3346]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.187:2525] with esmtp (Farcaster)
 id dd8dc2cd-dd59-493b-ae58-6fe81df24e22; Fri, 25 Sep 2026 23:02:51 +0000 (UTC)
X-Farcaster-Flow-ID: dd8dc2cd-dd59-493b-ae58-6fe81df24e22
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:50 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:50 +0000
From: Jay Wang <wanjay@amazon.com>
To: <olsajiri@gmail.com>, <bpf@vger.kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>
CC: <bot+bpf-ci@kernel.org>, <alan.maguire@oracle.com>,
	<martin.lau@linux.dev>, <yonghong.song@linux.dev>, <nathan@kernel.org>,
	<nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, <mcgrof@kernel.org>,
	<petr.pavlu@suse.com>, <linux-modules@vger.kernel.org>, <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <abuehaze@amazon.com>, <doebel@amazon.de>,
	<jay.wang.upstream@gmail.com>, <martin.lau@kernel.org>, <mason@kernel.org>,
	<ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 3/6] bpf: fetch the vmlinux BTF where kernel types enter a program
Date: Fri, 25 Sep 2026 23:02:50 +0000
Message-ID: <20260925230250.34076-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <arUI7ORFZCegI5ep@krava>
References: <arUI7ORFZCegI5ep@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Thu, Sep 24, 2026 at 01:26:36PM +0200, Jiri Olsa wrote:
> seems valid to me, could we just check for these two print helpers in
> helper_uses_vmlinux_btf ?

Yes, that is what the series does since v2 (now v3, patch 3/9):
https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/

helper_uses_vmlinux_btf() also matches BPF_FUNC_snprintf_btf and
BPF_FUNC_seq_printf_btf, so the verifier loads the vmlinux BTF when a
program calls either of them, and the runtime peek in
bpf_btf_printf_prepare() then always finds it.  Tested with a raw_tp
program calling bpf_snprintf_btf() as the first BTF user after boot.

Thanks,
Jay
