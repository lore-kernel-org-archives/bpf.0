Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461194266A4;
	Thu,  3 Sep 2026 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423988; cv=none; b=TZL8gjFXufZfxHGztNYu6fQX6IJAVTqT4qfSqKodpaGBlymapQKugDS/+rG06fvzlDRykgS/ELCEdEfJv9QpLpMddJWnRQIWjsbK9Ha4PgdNyNg6RN0kM7+gYyeH/naEl4tULCRqBETJEDH14rIbdkYfO+bvUgTyI+VIgVmmUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423988; c=relaxed/simple;
	bh=PT5K2ILIlBkix6vwGcMfXBl+zfIrR4BYkuVJqGyc8jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gc7ZpCB/QIMMut6/TnbQNa4YBNHVDnlu6FD/Jp8GXdND02B24t9hNS3VwfcniWiwI6LCuC34McRUx7dvXSkV/BHK6ZSeq7/EWmuEHOR1gKC+ocjegZrqkMYiecyPt34fsX/Pmvrbfo/jn7E9/i5kljCUc/DZvRnE7vWMvGvB81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=kWr4UeSk; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="kWr4UeSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=kWr4UeSkap7qApGIieyC9SvMRdg5JO/dMoyqT/y/3mtr+RbFwkNc0npYIfbkrQT6Z2F2CYZfai2Pf
	 JLrO1oZ3mD9MisjJpYjbVJ2/jv8CGogSCzBMZbt/DasZq4IjXma/jiW36noB0QGn7Ofn5KUABF63Pb
	 frzlE1LIj+YgwegQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86a992f29add-49bfd;
	Thu, 03 Sep 2026 16:26:18 +0800 (CST)
X-RM-TRANSID:2ee86a992f29add-49bfd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26a992f28481-1a8b0;
	Thu, 03 Sep 2026 16:26:17 +0800 (CST)
X-RM-TRANSID:2ee26a992f28481-1a8b0
From: liujing <liujing@cmss.chinamobile.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tools libbpf: Fix signed shift UB in btf_type_info()
Date: Thu,  3 Sep 2026 16:26:16 +0800
Message-Id: <20260903082616.5096-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Jing <liujing@cmss.chinamobile.com>

In btf_type_info(), the expression `kflag << 31` performs a signed
integer shift. When kflag is 1, this sets the sign bit of a 32-bit
signed integer, which is undefined behavior in C.

Fix it by casting kflag to unsigned int before the shift.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -259,7 +259,7 @@
 
 static inline __u32 btf_type_info(int kind, int vlen, int kflag)
 {
-	return (kflag << 31) | (kind << 24) | vlen;
+	return (((unsigned int)kflag << 31)) | (kind << 24) | vlen;
 }
 
 enum map_def_parts {




