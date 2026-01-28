Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A398E308F1D;
	Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619031; cv=none; b=GUIoIktBOJn0e7CRwGJ7c8CwHbtYxm7E99RbGd+fYNx1EK0TN0a7VceNXTx2Zknv7IgSx+CtLW9iyEE+YKKsYQJJJkUOn3LT7CkLR8Zed3krdUwfmA7fHRVLBsFxEF0g/3eVpsZFjaZulLTDZuFG7CSa9y5hXuTdxHgGJC9xvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619031; c=relaxed/simple;
	bh=aGtXVSLt63dj+krdfmEJciMSaeT6Bvc5GNuMaIsTXoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFj1mPyPpFEwOMo/P1JMqeedtgDM9YXHxbDJso2h33/LeGjYSWKMyyarGQrTLOIJ4j4cpIJrzLzPt+ukxZtB/4+G+RnLHeMVtrlTskiY8T7PR3KwggBIrSLcTTL7NOR7aMT0TEH9RfcNk7nUG3M6WW1/Db/1iA1YSJC78XIUCaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRDmxRMZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRDmxRMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82133C116C6;
	Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619031;
	bh=aGtXVSLt63dj+krdfmEJciMSaeT6Bvc5GNuMaIsTXoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YRDmxRMZ0TzXKcpO7QPAVwYDCDc3JRzXCi/2vphb6QF2Welq2DuKlFB52U++EO8hL
	 K/40ydkrdzvpiAs0fqddXMZBPj3aj18lb+m7tBinObVxGJaqrc42AatBYVJ6ji5MSA
	 YEpTNsBwsHAzeYrIY99+LitgQ8/LQnOfJVhwonUg84ZmdD5kcUlseiNbHpQvX1LRMl
	 +72Y4kOMUjOvY2INLp/+QZwhB5ZcpTNtSZPPTIqMNOB1bjS1RIWFDqavuxyj68jxxg
	 rvW+STocPvu27AVf7kQPsDsnV0IepbwsNmkWiULIfhfTw4QevaOKTrrAB07Hs4fme9
	 VX6y4qXJ1/qFA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kP-0000000DAlv-17Vl;
	Wed, 28 Jan 2026 17:50:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 02/25] docs: kdoc_re: don't go past the end of a line
Date: Wed, 28 Jan 2026 17:50:00 +0100
Message-ID: <1784349130a32df07aca486eb88711dd5d21c3b2.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The logic which checks if the line ends with ";" is currently
broken: it may try to read past the buffer.

Fix it by checking before trying to access line[pos].

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 19e777e2c97e..a0402c065d3a 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -265,7 +265,7 @@ class NestedMatch:
             out += new_sub
 
             # Drop end ';' if any
-            if line[pos] == ';':
+            if pos < len(line) and line[pos] == ';':
                 pos += 1
 
             cur_pos = pos
-- 
2.52.0

