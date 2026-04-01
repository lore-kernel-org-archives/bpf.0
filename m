Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24D42C11EF
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775062952; cv=none; b=M0k+2R6xnjuV2NwfSDuv5i/Qkbgj0UX8wB1QpAS/Ff5wbVGfgvIPlYWBDlBa5RfuaNumJ9QvvnhmA1xizQqlZjQr1Ukf2CvDgjP/c36VzO32fjBYrBxX0NDnmvsFt0WTXKmxK+ASoYZewArusWmmyvgNbNRaf+9++fdin1y37X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775062952; c=relaxed/simple;
	bh=3dVg/TSy1X9QtrlBpE2P4iLhZp500zfZsuEoGQiGXNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpwOxLRvbryHWJfsPbphPmZt0Fy1gxyM67hrmvqPgKkpkSqGsLHCCC1PQ07odrwANGEBVJ9UnZHuQQry2N/6c8AGdY+7M7ijcNLx1qJmnHGYpo2yJlUqeb2Czya2+Hr+GdEkpofKkF9aU9d2zbAvm93BlgeRu7WPaUUd45VDwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OTatl/uk; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OTatl/uk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775062948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dbaA5kmAwiVciqOTOWXlL76+4uK/f1qeK28hScfIFQ4=;
	b=OTatl/uk3BrEZtVnecx5AfaVonVqjMkKNEUWb04NBobjsj+qJ6NGuLjZDOgSzSd3p9VEP3
	tIlrImyNwK2C1vY4J2ccWC4+t7J5+GtxZonqhYyj7a7n2+DO56V3xXFpwAEjK+OlLgOUXM
	nzpJm97d5MhmFbtrdlvGZ2slNjq5jTk=
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: bpf@gcc.gnu.org,
	jose.marchesi@oracle.com,
	ast@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH 0/2] BPF documentation improvements
Date: Wed,  1 Apr 2026 10:01:13 -0700
Message-ID: <20260401170115.495836-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

A couple of patches for documentation as I start to hack on gcc-bpf backend.

Thx,
-Vineet

Vineet Gupta (2):
  bpf, doc: Clarify Pseudo-C notation and w vs r register usage
  bpf, doc: Improve MOV* documentation ...

 .../bpf/standardization/instruction-set.rst   | 49 +++++++++++++------
 1 file changed, 35 insertions(+), 14 deletions(-)

-- 
2.53.0

