Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B536224D6
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 01:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774144014; cv=none; b=kHH0qvtKiaGIrqQIqRUveKqa+T7eZsblFQ0rABfZ0wMuEr9GP+XKuslirWdEO2lxJjlF+7RvFZeY3Rq5WE7B12t5UAEugH5aljj7eTpT9Hrg2BLKv5UFS0lhmsU1LhicwRMAwfOoRPt3Fi4ZsgZJcGeAID3B1drerb6agBwSQtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774144014; c=relaxed/simple;
	bh=+oD8gvoMdhTJTWjxuSGGXI9V4+JveNwwN2c1sWuG6pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY7STSstAX8u5meGN/jzzaEpTd4+Sf9ZVH4P1wqsfQ0q2InZXlQgxpv4bkjCr87IxK0QC3KILUvr6NCIG2lIK6YeqWzgJcO9tM7Dmbj6hH3MZGd8QOiIOKTicRLA25eHEZ9KV1JEi2sVU85CZUEu1u64C9HFrq9ADdqoHyGKcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bW6nfAR8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bW6nfAR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774144012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nd72fcDAH65f/XPbi1wNaLTF0mozFaAntHhS92PxMzM=;
	b=bW6nfAR8rketciwV/sFBv4BR/ad338ZFcn5Mc4DDgnO6tAtPs+9kromdHCvjk267SAcU8l
	8X6KFSZa0NljfsNOnUPlZuDup08CJTzrzG6F8eFUDA02EkTT02nng+qSnoyI2aMoAL5ODx
	p5Xxr+6rjT425Ssv6j4fS0T8EvPdlwY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-U9mpWWl6MLm_891dk8x9EQ-1; Sat,
 21 Mar 2026 21:46:48 -0400
X-MC-Unique: U9mpWWl6MLm_891dk8x9EQ-1
X-Mimecast-MFC-AGG-ID: U9mpWWl6MLm_891dk8x9EQ_1774144006
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 139ED1956055;
	Sun, 22 Mar 2026 01:46:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E73E8300019F;
	Sun, 22 Mar 2026 01:46:32 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Philipp Rudo <prudo@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org,
	bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv7 10/13] arm64/kexec: Select KEXEC_BPF to support UEFI-style kernel image
Date: Sun, 22 Mar 2026 09:43:59 +0800
Message-ID: <20260322014402.8815-11-piliu@redhat.com>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Now everything is ready for kexec PE image parser. Select it on arm64
for zboot and UKI image support.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 38dba5f7e4d2d..59f948a6f69d7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1608,6 +1608,7 @@ config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select HAVE_IMA_KEXEC if IMA
+	select KEXEC_BPF if DEBUG_INFO_BTF && BPF_SYSCALL && KEEP_DECOMPRESSOR
 
 config ARCH_SUPPORTS_KEXEC_SIG
 	def_bool y
-- 
2.49.0

