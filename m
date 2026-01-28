Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA286378D9B;
	Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619038; cv=none; b=Tsh+Y4XjRevfJ4Iyi5XhYpspazeEwTgTo4neL5rYzTqlVD6bd3mAT6vBLOppW5KoTXZC1QOJAKXotYfVGAqznH/MuHdGD3fTnF1xXz/5J3JMBEsps5tTyG538+q1QQYnyNlhky4FSiIU82T4zd11NbX3bOJCp1hNk/sLL9i5LL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619038; c=relaxed/simple;
	bh=Vgz8udadx0cwepC/wsp/hEk+Bl4FBDA/00MijiNSly0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOTjCONen+6Zmr/afUQ6bgcA2GmeTjpCd0wcrvsSdFEVtb7cRFuhdZICc8/Dzw48vfbv9FLhnJusxwYansrdAPHqEgrnV4S+rl0diYUKiXaTG2NazO4FBMI9WuhAN2Depsahqb12Bd+jSB3v4elXeCSCtZD++deauSpqbimSH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtlM6Spw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtlM6Spw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9CBC4CEF1;
	Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619038;
	bh=Vgz8udadx0cwepC/wsp/hEk+Bl4FBDA/00MijiNSly0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtlM6Spw+83hTzIkZLcSXE1dgusRIqZfidCRPGyq3PaZDJQa9WIT71sHFy+VlbnoL
	 J4Fgq/6C7J8i79jMSLjGmMv7out8vV4lf4HpORi42gCVNb3/JbSYjWWYtPTWBIQiV0
	 iDwmn6cWJaO52FgVTMMcCp/RQtWpl+VZLSPgfOZ6l+TqJ/OqnSUcMGuQDTgxJ45ipJ
	 zSud7R5toJkmE0WFFC4bzLsZHd3/HNJYXWDNQdqtlBhfUlL/qV+LIJDALRwo5K2Rl/
	 KlEKgSynkBSfO5we5yqoGSbdMl2MxU/QHyLytcno5aeh5/pdj6wR16EruEZUauV4Cs
	 vPP8jya4LPsTg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kW-0000000DBCG-1tTl;
	Wed, 28 Jan 2026 17:50:36 +0100
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
Subject: [PATCH v2 24/25] docs: kdoc_parser: better handle struct_group macros
Date: Wed, 28 Jan 2026 17:50:22 +0100
Message-ID: <d75c01aa92b61e1934e62efd9492986b69a93129.1769617841.git.mchehab+huawei@kernel.org>
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

Instead of converting them on two steps, implement a single
logic to parse them using the new sub functionality of
NestedMatch.sub().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 3a5614106af7..d2eb93f9d489 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -124,10 +124,11 @@ struct_xforms = [
     # matched. So, the implementation to drop STRUCT_GROUP() will be
     # handled in separate.
     #
-    (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
-    (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
-    (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
-    (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
+    (NestedMatch(r'\bstruct_group\s*\('), r'\2'),
+    (NestedMatch(r'\bstruct_group_attr\s*\('), r'\3'),
+    (NestedMatch(r'\bstruct_group_tagged\s*\('), r'struct \1 { \3 } \2;'),
+    (NestedMatch(r'\b__struct_group\s*\('), r'\4'),
+
     #
     # Replace macros
     #
@@ -153,7 +154,6 @@ struct_xforms = [
     (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
     (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
     (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
-    (NestedMatch(r'\bSTRUCT_GROUP\('), r'\0'),
 ]
 
 #
-- 
2.52.0

