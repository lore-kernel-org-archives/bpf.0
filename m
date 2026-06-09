Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516336680C;
	Tue,  9 Jun 2026 20:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035948; cv=none; b=mUr/VdNgWNA9iglAorb4V0HXjWk8CClBaieLAXM4KcZLUWYsz/sz8U5FEqNcySHGqe3dJ/hglLLVW/aEExm8lR5zr7f+ep0NGlaWgXakuQUBOrsOGbtOhm4WpIYHgiHO0ujAs+Dtdwlp3bvR78tj8xfUwknwq5Ry9dTKnrbn/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035948; c=relaxed/simple;
	bh=Atyu/7pLp9nLA3fbR0DTc7/trd1D5Mix0uq3yK/JY1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ap2tvQNUZXrF/aa3TjqCq1yOoBnBNWMD8nI+d4iyoAewvx85FBEelycdsLdViC2pUNCgcHdKsJutMqIlZMS+OKvx3SJ+SpgxShr+chvr4lKQdRpQClozMqD0DEgzfdLr8RXjpB53KCdwL8athin05h3mEQLvhxYReJJXLIYfcX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g22nnqto; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g22nnqto"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D856B1F00893;
	Tue,  9 Jun 2026 20:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781035947;
	bh=emWf4agjYWuWZV+h8FdWLJQebR+n3UTCVhIW+1ZyukI=;
	h=From:To:Cc:Subject:Date;
	b=g22nnqtou1sbm5A0gVcZ+Wk1+ftAm941psaVn/UDeVLl3TIJIQ2Fcr/OGqK5kkb9B
	 mGhyWjjckWG1oceWoGYpYK0RWtxgxmHzAnggFDHXvn7opGwB0qmuoxwyC9GWvDwWf6
	 V4jGROWKkvyoGoKRikYOoka2PAhQRU1c7TSas4nYfKpeD0HoGArZUAD423zPmd2FX2
	 WcFq1Xz/rjPUHxIcSR8bx2JKmKnwdK9+28abA0YX3UADRyTwaku1inOhnaJ4bNkTPW
	 w/laJAElTr8mbpViN3L8YqSH/TSunHGurDih4dRqj4vGrd1fstFm2deozRLvUIXyx6
	 VNkwQPmEnfvQg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/3] docs: net: more adjustments to docs
Date: Tue,  9 Jun 2026 13:12:21 -0700
Message-ID: <20260609201224.1191391-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few small updates to the docs. Mostly typos this time.
This is trying to prepare docs for getting fed directly
into AI reviews.

Jakub Kicinski (3):
  docs: net: fix minor issues with XDP metadata docs
  docs: net: tls-offload: document tls_dev_del, tls_dev_resync, and
    rekey
  docs: net: fix minor issues with devlink docs

 .../networking/devlink/devlink-health.rst     | 12 +++++---
 .../networking/devlink/devlink-params.rst     |  2 +-
 .../networking/devlink/devlink-port.rst       |  5 +++-
 .../networking/devlink/devlink-trap.rst       |  8 +++--
 Documentation/networking/devlink/index.rst    | 10 +++----
 Documentation/networking/tls-offload.rst      | 29 ++++++++++++++++++
 Documentation/networking/xdp-rx-metadata.rst  |  2 +-
 Documentation/networking/xsk-tx-metadata.rst  | 30 ++++++++++---------
 8 files changed, 69 insertions(+), 29 deletions(-)

-- 
2.54.0

