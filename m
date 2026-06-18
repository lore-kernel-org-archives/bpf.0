Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF49274650
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781744280; cv=none; b=dx5nWAt8cUKGB0+EqvICJyJbXBhuaZfIYHcqnPp6e441h9bYy9k4//17aWk/j2ek0q2AGMkFwW4VhAZ9ROGccKjm1eS9JnVwQPu3bQwwf4/0LHX25j45lh5z73KVywPAcTjGMAYfBIJCAjPqA8dw4zdOxWHgXpAwm/dcxML5o8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781744280; c=relaxed/simple;
	bh=0RbAPMDfAg85Yg1qzzZox3n8c+TNs6+6knhV0UQ9LYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1/iPW8FJCkKCXe03N9pPNbEIpGbNAuc59e1OE0WWHFP+79aBM3oZnyBrGmF6/mh6cT1kcIVcB+nQtPr3qDTeB5V9Im2ajhgj7fg1iVSl32Htxunwowp6/OSyZPCGCnPVXvSvUtghNLxDMc7l2AH3VsxcBj7KKOhBkpe/Im5pNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o+ktzELz; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o+ktzELz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781744267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=66qctO6wdU9oebvxVaZ0C5WwfXH2JXgvPqR04M139/Q=;
	b=o+ktzELzLEiosc8JwtbN5J6oYA4o8hnhM98zy4lccixXwVGQaVC9BOsI9AMDefUZW7yy2x
	KSuyuzukQmkVEp+R1JvLJNNICrhaTomJ8ibFwAQfuzj4oiG3VopabXRs1RXItvwHLTrm+W
	VVbppnmB57++nX5cufpI9jbk2kPC2Ms=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	acme@kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	jose.marchesi@oracle.com,
	David Faust <david.faust@oracle.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PAHOLE v5 0/5] support for DW_TAG_GNU_annotation and fixes
Date: Wed, 17 Jun 2026 17:57:26 -0700
Message-ID: <20260618005731.273181-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

This series handles gcc generated DW_TAG_GNU_annotation with the end
goal to finally enable CONFIG_PAHOLE_HAS_BTF_TAG for gcc kerenel builds.

Patches 1/5 and 5/5 are newly introduced in v5 per Alan's ask.

P.S.: I've optimistically included Reviewed-by/Acked-by from Emil and
Yonghong respectively on v4 [4] but those were before additional changes
in v5 from Alan for a few things. Please let me know if that's no longer
true.

[4] https://lore.kernel.org/bpf/20260602195512.1511013-1-vineet.gupta@linux.dev/

Thx,
-Vineet

Alan Maguire (2):
  btf_loader: Handle decl tag component_idx for parameters
  tests: Add btf_type_tag ordering test

Vineet Gupta (3):
  dwarf_loader: Extract die__add_btf_type_tag() helper [NFC]
  dwarf_loader: Add support for DW_TAG_GNU_annotation
  tests: Support GCC in pfunct-btf-decl-tags test

 btf_encoder.c                 |   1 +
 btf_loader.c                  |  46 ++++++++-
 dutil.h                       |  11 ++
 dwarf_loader.c                | 185 +++++++++++++++++++++++++++-------
 dwarves.h                     |   2 +-
 dwarves_fprintf.c             |  32 ++++--
 tests/btf_type_tag_order.sh   | 179 ++++++++++++++++++++++++++++++++
 tests/pfunct-btf-decl-tags.sh |  93 ++++++++++++-----
 8 files changed, 478 insertions(+), 71 deletions(-)
 create mode 100755 tests/btf_type_tag_order.sh

-- 
2.54.0

