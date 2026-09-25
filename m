Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F1B4FECF3;
	Fri, 25 Sep 2026 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377371; cv=none; b=sC2Sg0DBdMfvoUoDYjsgu7TuildzMKVLrrn4F77ZmVk762Dyb4VAM2VFEWETI4bidhR8MTUS9hBqtiYjOMJhd1dpFMpXouzCWMPSS5il/EaYmPSXVAZtnddw3T8thKywGY9XKQ2JvBIN8T0HPg2J1NrFFk6Pi08zab1yd/6dzbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377371; c=relaxed/simple;
	bh=kAlnZKvsJXF8UdeRWTk5A/4iKeoqGjl2i2Lk2cHmMQE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpDsxGqFvHRgFdauOhV0bSGuKgYXS0bKmrGc+/7/1GM8gBk+Ye57vsuHR2OOicyBzTariwLoSXn+COeAqGiVi+Py7chqV8nnTviyRhAZ4wGEMJlpzazhAshjOHpiFA1hAo/i3Oxtg4XlHFTg2GJu98KvJJfslo4UJKFcFrNZi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=C88Nrga6; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="C88Nrga6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790377370; x=1821913370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kexz7IHrii64hYzXMs+kv4tcWioxOfPUGVC5P75GX4=;
  b=C88Nrga6MXhzZhanOEGexAVigt5r8EHfs+VeqsWfz23qeCHq6Q/C9MAf
   VcVBdGIo3OxNH+byc2s5rJZde8yctHDbYaHNsdLbvczftqQRzrNrHE0Px
   0AsCgyQOivRnpqfq7p6iIy4Jy3+tuaUQYdSZ8RGHMwBtmjlQNbmVK6r5s
   r2tbtjGjU8n89AIN7DhvEGFDOgJbtDrsWi6XExy9AzbTARG8dLfI+wHtC
   WCadFZ1i/3xh7z8s8Aao71ea3I+7ZIisqBPgLKcIG/uu4Csu40zYvrS+v
   0jBC5PjFZmb4YydC4nu8gIQqRSJ9v6nJekTrMeeUh5GuwELV1nUD5xu3A
   g==;
X-CSE-ConnectionGUID: vLbjFj0wSauxYqhEwMroLA==
X-CSE-MsgGUID: RQHvTxToRMOUHxV4c/Vy/Q==
X-IronPort-AV: E=Sophos;i="6.27,123,1787011200"; 
   d="scan'208";a="29469732"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 23:02:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:22522]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.18:2525] with esmtp (Farcaster)
 id b6fdf5ce-9bc8-4213-abf3-ff838dd3d8ec; Fri, 25 Sep 2026 23:02:49 +0000 (UTC)
X-Farcaster-Flow-ID: b6fdf5ce-9bc8-4213-abf3-ff838dd3d8ec
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:49 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 25 Sep 2026 23:02:49 +0000
From: Jay Wang <wanjay@amazon.com>
To: <sashiko-bot@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH bpf-next 6/6] kbuild, bpf: allow building the vmlinux BTF as a module
Date: Fri, 25 Sep 2026 23:02:48 +0000
Message-ID: <20260925230248.33900-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923055905.ACA941F000FF@smtp.kernel.org>
References: <20260923055905.ACA941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Addressed since v2; the current version is v3 (patch 9/9):
https://lore.kernel.org/bpf/20260925224229.1850-1-wanjay@amazon.com/

Both fixed: the %.ko pattern rule again depends on the vmlinux ELF only
with CONFIG_DEBUG_INFO_BTF_MODULES, as before this series, and with =m
but no module BTF only the carrier gets an explicit prerequisite on it;
head -c is replaced by dd.  (v2 also strips .BTF from vmlinux with =m,
so module BTF is generated against vmlinux.unstripped, which keeps it.)

Jay
