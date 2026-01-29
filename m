Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A537BE8F;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=Z4tKiGiqoDzHX6l6nWyqWhnsMn1BK72tJIL/6aCTog9T1sdiWVlI7rduA9T1FwgD9WKF1jgymxE1XpcXOfHl4ZsTQgsGwfiz2u5rVpQmOYDu8IgnLnRL+nQtIqjHnra6EqVoJivT/nATjr7k77M6dik0IYHaIyueKN0jphgIvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=E/NkbGhW79SHOexEJ6i7PkHNPXwMx9nBDdwcfT26Xts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TG4IS+HRcxmTbPj5CPL48N77ELy4LUCYs0xTPIa/FLIyltSy9bHzP6sCXM3YMa2v6FGzl3szus6tiqB1ori8LvdkWFQQv/HESoTUU1GWLT/yCjrIO5Y3Nqu2QyCyBS++qx6iaYQuQRJfLvUQ/ksaezNzH2xU6/WV2QMFnDboYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REkXesK2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REkXesK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70ABC2BCB9;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674110;
	bh=E/NkbGhW79SHOexEJ6i7PkHNPXwMx9nBDdwcfT26Xts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REkXesK2ak+UA0WRFomQIlfjRgBC3z0jjpTzLElphbdtS8ZGZEWHiM6vmT+PFIQul
	 IadTKCJM2XLeOkykMUr4U10fj/gNhNjd4oXGv+Wi3zOx37a3epfq+rJayNLKcT37oM
	 gL5/+mZBzb3ULTrBPWSDluE99AbKNIuyq/R3QcE/cRPAAWkmBivfBGMeFmJzoURW2i
	 6wZfcNuNSSXz1hm0dAKcbxPCOXS0DWlnUIrP/geT3GiFcB11Q8KSeCtiaO/QS/nMhb
	 n1nlECpHcxaJD1YKJaWBwA85VWVnTCXqPeXlyEqchQ7CFbSdjuhZJ6SpufTTmCiMTp
	 i1FHrzIOwVfMw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4n-0000000ERNR-0Bdx;
	Thu, 29 Jan 2026 09:08:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v3 14/30] kdoc_parser: handle struct member macro VIRTIO_DECLARE_FEATURES(name)
Date: Thu, 29 Jan 2026 09:08:05 +0100
Message-ID: <61cde5c7b7faa0becb45d9319abd6882395087e8.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
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

