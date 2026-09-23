Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF85616B8
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190725; cv=none; b=ms3w9eRVgCkGTLA0WrCwNLJ8EHvDL8e7r+vtXXuatzy/ODAK1W8Gw6Ven23IIbcD+w2Srf99fFDeFWbTGoHmjWeRRf1Y8e6gJflTmjCxK+vbQAHd/xNHpaY2h/NUT+Y1WyAJh0I1N5dT8EufawH6bARiBKH6HcuY976dEKI0RQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190725; c=relaxed/simple;
	bh=+OqHY29iaitoxuQMwt7upbRA0Nj9LwNznx8UOSMDbPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1CxLJDDBptrERAzzggg0GeGDRQaK/xJUuc8wcymMNIxvoStFYPwvAFUN+tMB4U6a4eHwezidvVTUwGgHKmDN+ZdLfjJwNcLx/PDzdbw/oShlootJsee8rQhQMLltmdPE90kJSBbKwtjFpMWpXLNRvhgCZeKg9i6rQ0fEdmmC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDkxtp3p; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDkxtp3p"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6e43b9d8so3537725e9.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190722; x=1790795522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gy1x9RADI47UkUOAeplRQzAwIvLirit0QvsBqrWlNs=;
        b=PDkxtp3psg/vO/j/pE7mdmuJ+qQ3qerCoBx0aEDZHmhxhhmDDik+ehGinCtyq1hv8s
         UjGGzTlvIuCmwszO76zBCb9KFni6otOFMSio3kxA38huDv6zJe8Q2G461hqEHpiEeOdb
         LhaDZHgT2CoV0DnX4OpEi7ApueYS/OyUw0fUm8hRxwZnbqapN3rLjL1ey3YlWyaSJstM
         G9A68gZAwPeaRebspWgpa8SHdWB2ShfVTBsFcU5SR8GgF+AOMXlTtWy2FOuVeP00PT6R
         u7LeGCAkQq7UiTdk/eZsiZcam0FwVJNh+z6jCNZNbyBpiHKCu1XpxzmC9UyVpNXhZTRe
         3CMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190722; x=1790795522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6gy1x9RADI47UkUOAeplRQzAwIvLirit0QvsBqrWlNs=;
        b=FE2g7Dn4F/ln/jqAHSn+HUYkkSf2P3nlOENzEpP3pb2w0x0SYyjGFLvEjqDKfZRnpk
         FDn5/rHERpRC/BXQ8cMEr+3rk/EHuFk9ROBzXCqRGm0narlTBrjgmBRzBxQ8xTBjDmpK
         MqbZW7VZw8HcI6Ii1rqRKEph12JT3qn0Yoz47A2oYK3Kph00BILy0QxXuOqS9Wo0jkVd
         h+Amtkm8RwVnVDWWhtqtamj+N9CdGhRPdyvhD3nY0BhHu9bK5Ne/xmSzEHP+4Xm6jQ3q
         n/IaCMYLa+c57OSG3cKrEYA9DddNatSOm88cyZHLS0qqwRaFrneQfxLubcPtPf1nYogE
         RD3Q==
X-Gm-Message-State: AFuF++mftRHTOATs7a4RTrbCLdZldOqr2WIkbbjAFhPSjZSSJ0jG/e4L
	SV12GnerpVebQR0cYFpUUDOIB32eYPwIZka+RPD2dj+dmsaV0ZQ9t/GdE5vQIZVZ
X-Gm-Gg: AYBFou1rcNffnOm/160eRReyDPSvjTNZxRlsPVRk09uQVHXGoGW9P39x+xGTw1Hw266
	YjPPBZ8V2Y8V5Y9V3fuYNksG0f414CkFIC0Aj0TaPfrMDv0PzCxR5xKovKttEm+NhvKH4408vtd
	EHICdl8311FbcBD/+0mVXg6LUKQ/Z31/bUp2tRF9UoZi0uAZXUwhN3JhGHIS/3Ju72xhRgTZx5f
	jeTrGDGH7vk+0BATHi4bNjziofti74N1rRINW4NTW2+Qq/MQ5dSRwsFag/e7XJG3CndeirEAW9W
	6biMWNIs0UxLqRfVNKNSHxWqjZCWFnEvQGEl5ZQS3Yh3U0vs3C4EoIVyTQwmAn8BR8ozX6c2URO
	K3rPr52nNcxuXjhcxoEYj4GTO/hkTImw7i2iSKFFLirhqmZjyu4QMh+H94JYyYYTXqECXKXkbNe
	zbHePzVcqMP4m1pj9xg5v6jO9McSU2iAIlqYklRXMCSqZNFvRFaDNhKokPBTuUm7P5arbUAyKBA
	fQ9OxyochroNhP6KmNhbxiON4ENAKaeGwJu7Srnx/X81JX24otEfbrDPosELGCD8XCo7SX/D4q7
	LXuWtvWwLMLKQxxZnYEp1KXbY/0Yaa2ZywEQphT0v9Ucm1Nl
X-Received: by 2002:a05:600c:310b:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-49fe66f4c72mr2802625e9.19.1790190722204;
        Wed, 23 Sep 2026 12:12:02 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cc90ccsm11932815e9.10.2026.09.23.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:12:01 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 11/18] selftests/bpf: Check liveness merge of masks with different widths
Date: Wed, 23 Sep 2026 21:11:18 +0200
Message-ID: <20260923191139.2816206-12-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2491; i=memxor@gmail.com; h=from:subject; bh=+OqHY29iaitoxuQMwt7upbRA0Nj9LwNznx8UOSMDbPI=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4nfm+wf/FTAseLVAvGmh4SOZa9+r8rqNNjCc4dw/x WKKudHXjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkdBLD/9TQP/I2h3vKmVu3 nWSO/vksJGTRAfMuu339x5hnizVyuTMyvKpfs7X56oOJeXLnrM43vIrenr40ccNsR68lXj33fr7 /ywoA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The liveness masks of a function instance are as wide as the deepest
half-slot the instance was seen to access. When the same instance is
analyzed again through another call site, the new pass may have settled
on a different width, and merge_instances() has to widen the original
before combining the two. Add a test where the first pass of a callee
reads through a pointer 264 bytes into the main frame and the second
one through a pointer of unknown offset, a whole-frame read at the
maximum width, and check that the merged result keeps the whole-frame
read.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index f8758eb62dac..a94365decd5f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -2861,3 +2861,52 @@ __naked void narrow_store_defines_nothing(void)
 	"exit;"
 	::: __clobber_all);
 }
+
+/*
+ * The same callee instance is analyzed twice: the call sites are visited in
+ * postorder, so the second one goes first with a precise pointer 264 bytes
+ * into the main frame, and the first one then passes a pointer of unknown
+ * offset, which reads the whole frame. The masks of the two passes differ in
+ * width; merging the second into the first must keep the whole-frame read.
+ */
+SEC("socket")
+__log_level(2)
+__msg("stack use/def subprog#{{[0-9]+}} merge_read_all_callee (d2,cs{{[0-9]+}}):")
+__msg("(79) r0 = *(u64 *)(r1 +0){{.*}}; use: fp0-8..-512")
+__naked void merge_keeps_whole_frame_read(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"*(u64 *)(r10 - 16) = r1;"
+	"*(u64 *)(r10 - 264) = r1;"
+	"call %[bpf_get_prandom_u32];"
+	"r0 &= 8;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"r1 += r0;"
+	"call merge_read_all_mid;"
+	"r1 = r10;"
+	"r1 += -264;"
+	"call merge_read_all_mid;"
+	"r0 = 0;"
+	"exit;"
+	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+static __used __naked void merge_read_all_mid(void)
+{
+	asm volatile (
+	"call merge_read_all_callee;"
+	"exit;"
+	::: __clobber_all);
+}
+
+static __used __naked void merge_read_all_callee(void)
+{
+	asm volatile (
+	"r0 = *(u64 *)(r1 + 0);"
+	"exit;"
+	::: __clobber_all);
+}
-- 
2.53.0

