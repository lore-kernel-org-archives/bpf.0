Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC123A9635;
	Thu,  1 Oct 2026 23:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898692; cv=none; b=HwPVaYJgxvsJ6K1PrdltLQaSt8g886j3TYB1iGFV9YQSxKZb9mBs3cZakvmLdgPi5/VPPOj1P07ohunVNcFGK1fKox7XMtEQessYuuvF0IdYyZX3tocGdipmBR9zzjGg66/LDHPn788EPvIfnKMcQlVPS4FolYSdzwctuwNr93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898692; c=relaxed/simple;
	bh=E4SnCaFYxr6lAWkTGxym06Vo1B+vuoPzDviTpwQrMSA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWk2coeJcENp9ilwqthe+FyKX97/DS2ODUOc81kzONoTyY/oCzDKvcNcyA7D2sR31yEM2C1gpsmFesH8IFCdsriSjRpK0cC9YS2rizYPLudsidWUTKprYxWcQU8oBjWmjjUNnIeXaIJp2KY1BBWB/merdKlfR4euoOSNE47f4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VANaSBrd; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VANaSBrd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1790898689; x=1822434689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+gakBsFf0rsEzmOYbq/bI2y9Z71TNc4ZwgCbBPMtrZw=;
  b=VANaSBrdorE4qxYJ8w9vWnZz8TYrjaxonWHXUFm+BGoh8wY4wHjpAHH3
   ByHwxaTW5zzbAdJfhTOBWk17sT7S1wL1yTxwc6wJfDlNJUx51naMAdB8L
   s5TB6xczAn2wAvdWGqzDgwjiB4SkDwDOlxKjleyKDckashqe3xtWDicsU
   x6s24iBWbWQKt9/ctP/lDDc9+3Lhd6T5ikAFMPF+NOUh1cbt4qE+bd/I4
   hAAw65qZzuL3rtDGH6LerVwHITWCehpLXmVtPg7O/2OmUFhU818LU6cDk
   rHZyk5xyMO93dTfq0FSWe+qjZXdmKkNy96zpjYbHfLRh85sPJf7oSoqCr
   g==;
X-CSE-ConnectionGUID: 2n5c2uYJS5Grx2dF5YETyg==
X-CSE-MsgGUID: 3bnsxS3hTqWFx6UmPgjbug==
X-IronPort-AV: E=Sophos;i="6.27,135,1787011200"; 
   d="scan'208";a="29970246"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 23:51:28 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:5728]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.137:2525] with esmtp (Farcaster)
 id 51a7109b-3f32-4603-95cf-00e4fb61676f; Thu, 1 Oct 2026 23:51:27 +0000 (UTC)
X-Farcaster-Flow-ID: 51a7109b-3f32-4603-95cf-00e4fb61676f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:51:27 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Thu, 1 Oct 2026 23:51:27 +0000
From: Jay Wang <wanjay@amazon.com>
To: <sashiko-bot@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-modules@vger.kernel.org>,
	<ojeda@kernel.org>, <gary@garyguo.net>
Subject: Re: [PATCH bpf-next v3 3/9] bpf: fetch the vmlinux BTF where kernel types enter a program
Date: Thu, 1 Oct 2026 23:51:27 +0000
Message-ID: <20261001235127.4111-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925231100.6A2481F00893@smtp.kernel.org>
References: <20260925231100.6A2481F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The scenario does not happen; v4 keeps this behaviour:
https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/

With CONFIG_DEBUG_INFO_BTF=m an allocation failure of the parse is not
stored: bpf_load_btf_vmlinux(), which parses the BTF in v4, returns the
error without publishing it, btf_vmlinux stays NULL, the next request
retries, and this check does not fire for anyone.  What v4 does store
with =m, as a later bpf-ci review asked, is a parse failure for any
other reason.  The payload was checked against the kernel's size and
SHA-256 when btf_vmlinux.ko loaded, so that means the build produced a
broken BTF.  The same happens with =y, where upstream already fails
every later bpf_check() with this message.

With =y the parse happens at boot, through the first vmlinux kfunc
registration, as it does today.

Jay
