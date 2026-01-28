Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5B372B57;
	Wed, 28 Jan 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619035; cv=none; b=QyDDMMBB0nXMUKUo7IDqng31A4dUuoyoNNnC7lGLyFzPugA62iYgGxfhVH4KkZNruIjNDbWXawZoy8Ywv2OzTFzH9xve7UTx92vOyFsFFADW6gXpQt8sYqq/n8BfUoI0Xqrl6F3x5pQaN7oTMmsmQi8xLXy6OL5HWYTTbBws9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619035; c=relaxed/simple;
	bh=E/NkbGhW79SHOexEJ6i7PkHNPXwMx9nBDdwcfT26Xts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dyy+CKekGrIo5wEuZWfaVr0oRtcoCTVfpid5COwCAhmhDNrf/BY6xw2V6Ktc19jkkgrdg1Nqa9LXY6b7ZROJji8DZZTBy01ueRFj6xWpLJ+yNfKrj0vP4G8b8Plx8ev9cNCjrnNQ4DrUxuyXygZywf9Am0GIamKKbWat5+Q4xVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgEs8KLT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgEs8KLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE43C4AF0C;
	Wed, 28 Jan 2026 16:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619035;
	bh=E/NkbGhW79SHOexEJ6i7PkHNPXwMx9nBDdwcfT26Xts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgEs8KLT+fSZYa8scXr97qocIE/yUTDBVKxLaLukMi1ByFu5mIxBSfoayfdkTbHU9
	 gvgHyPzicYKXhL1Fqtab7yXDC2reL52BB04G9w6xCCU4uxbWKsqeobFn9yoWmGQahZ
	 MDP2GsVGXADgVlA9PcbBI7USYzfFw76k3H3Tnu413mhONC/yhJTllDDDW3ipC/xze2
	 WBb+x9tqbnuAh5+4/UhzPRG3n5/sGcCNCzUDBvLEmbGHJTBfixcTvXb+71jdHEVbrM
	 tI+PvhWJ06HdUJgnMnZIpM7AQGuAQihMb/U5YsMiwcd3j5TDc9+VdVqfTk9PkR/C0H
	 YvxZSHqulIc0Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kS-0000000DB0F-3O3I;
	Wed, 28 Jan 2026 17:50:32 +0100
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
Subject: [PATCH v2 14/25] kdoc_parser: handle struct member macro VIRTIO_DECLARE_FEATURES(name)
Date: Wed, 28 Jan 2026 17:50:12 +0100
Message-ID: <1c649fb1db817040e1641a3f8980f15787725eec.1769617841.git.mchehab+huawei@kernel.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

Parse the macro VIRTIO_DECLARE_FEATURES(name) and expand it to its
definition. These prevents one build warning:

WARNING: include/linux/virtio.h:188 struct member 'VIRTIO_DECLARE_FEATURES(features' not described in 'virtio_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 33710c4be145..db140363104a 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -152,6 +152,7 @@ struct_xforms = [
             struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
     (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
     (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
+    (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
 ]
 #
 # Struct regexes here are guaranteed to have the end delimiter matching
-- 
2.52.0

