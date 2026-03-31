Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D3D44B67E
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992961; cv=none; b=X2P/yg6O/IhvLK6/JvHsvCOBtH0b00TydLI6M+Qdq16FvUKP37yaPz03MzWmlGNQyn5hEA4YrHiWuComM5AlbBARP+Hbv0+Bh+uwV0k0FRBHaE3ST3rxHtzG+tPfpDe2YEojPl4RbTLttKFrvNhUT8LVWGD84oc4E1k/UvojUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992961; c=relaxed/simple;
	bh=kPGcHcs0fqywSVt59i/2lh6t66WzWodKo0oSAhlIuY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSk0rRGDIIJpcF6PWM0SkpODIqPHh3vJhUS3gCUqO1WLMeA+DnQvxwd3HNRLlsefqvdDc9oMqt6MrEHChOKXyZqioUS00QNlq+9zTmbM2M/To5Jdcivko+B1gZ7mema0mEffs+Gyks9gYIUUd4HblaA+xesX2EgkuYM1pcGBv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9tDVFD2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9tDVFD2"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ab077e3f32so26220055ad.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992959; x=1775597759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt5cPR74jSvXwDYFVJuLyAp5aI0ADQDmLH6axOJXgDM=;
        b=d9tDVFD2+p413wPlCimTqjay9A744HPC8Z0CWsIWUerZS/nWw2hFCMOrUiYShdAn3G
         6w1LLmdNIGUzUel+gR64BnW5ooDlsUXkgP6jzMaIBidJYggWkxOyjhpotmC9Ih1Q470C
         OYqAXISGmXR3YteoP7dq/sXdCj4qxaMVw6X5vrZeL9irZg/JZ7Ohz8pKnvHD27fz73KD
         FEi79x/xzkICYC1GW3tiKoAE/Wdaizsej0KOrhpvOdmxX8OG1O+nh6cqXGeAbBD1qVIo
         jiykzOUHoeFn0pdUcOlZ25OqgjX/q9KbbEVPEn6atrjTCvWeuz+8c/qii/Z9eNUeBKLS
         SOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992959; x=1775597759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zt5cPR74jSvXwDYFVJuLyAp5aI0ADQDmLH6axOJXgDM=;
        b=UZI/vBmi4UqfhNHFOIibliCf780tylJTCtVj9ZCVx0WZgaYNmUICIaywcMhESSS18w
         Jc2Hy9nqBsm68maY/t1FHnzmAM94T4kA7MLzZ0I8mQXxjT3Gg/mcvY1VP2vXmykwFU+f
         i9Zhf1WvMLcDzBrC9kTd2aqfLwLxB3ZyfCVLs4dWPmygOEycgAzfurbGiepUC4288Mrg
         ZmUWD3UAszRycI+BYPSrMh4tjKWEj+wZ+3rFy2flcQyeZXan/5C2UxZRLGbg1fMn+yp3
         7SOHit0Mzc7kxqehx3TL3KBTJEv2KE9QesALydDeRlAb6jBs/YNOMXqYbbWePQKDgvS3
         LkRw==
X-Gm-Message-State: AOJu0YwGC8rPUSDzleESPgrXOC4dhPSzKmf+v8D+mLn/2+n2MBFYf6T5
	33wmAdWY5PZ5JElGMX9Z1Ohr4ClirDrICmxCjcb9xgj9VstBuEv2SRT1mf0jRg==
X-Gm-Gg: ATEYQzwqh4e7FnIFqzkPc6zfZnIyZmkKfGaJbjoRF2Qx3j76ygZCmM2mdRN1Leanr2w
	TzYBxgNDNDVOrLW6D7jGSWa+Uwe3Cj8NeMOf9b4wWxHU6G8dAJcJkJIipwKIZ6zKSIEjIMbkodd
	xgpIKzwkTLNCrF/7iTrEFbkyYsaBSTui2Q8+41mHGmM48RbYeVM3PapFwjEU57VAzLYeUoIeJaH
	zr2UoPMg/dREVt/WHVM5qyFMHnI+u2VNwPNs93ncwvgD3gjM1H9JaeQ1oasg8VRM79iqO3ntNFI
	hXF1YgzE1JgxpxcIdkViMp706NUOJPeeruMkniB5u9/FEqYR0Y0j8ZDo8XBAXLiRSBvTqed5XQd
	WvcfdLG2Fa2WgdKMfvHuMcnSpg1zq59w0kfPm07k946sgzOnCO/R71sFJLtF8cDc2xc88TC4qSU
	4/BnIvx3dfCyKcnQ==
X-Received: by 2002:a17:903:4b0c:b0:2b2:5091:1c1c with SMTP id d9443c01a7336-2b269b06116mr6726605ad.18.1774992958969;
        Tue, 31 Mar 2026 14:35:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24ae15201sm91965475ad.84.2026.03.31.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:35:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/5] selftests/bpf: Fix task_local_data data allocation size
Date: Tue, 31 Mar 2026 14:35:51 -0700
Message-ID: <20260331213555.1993883-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331213555.1993883-1-ameryhung@gmail.com>
References: <20260331213555.1993883-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when allocating memory for data, size of tld_data_u->start
is not taken into account. This may cause OOB access. Fixed it by adding
the non-flexible array part of tld_data_u.

Besides, explicitly align tld_data_u->data to 8 bytes in case some
fields are added before data in the future. It could break the
assumption that every data field is 8 byte aligned and
sizeof(tld_data_u) will no longer be equal to
offsetof(struct tld_data_u, data), which we use interchangeably.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/task_local_data.h       | 12 +++++++-----
 .../selftests/bpf/progs/task_local_data.bpf.h        |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 7819f318b2fb..a52d8b549425 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -90,7 +90,7 @@ typedef struct {
 
 struct tld_metadata {
 	char name[TLD_NAME_LEN];
-	_Atomic __u16 size;
+	_Atomic __u16 size; /* size of tld_data_u->data */
 };
 
 struct tld_meta_u {
@@ -101,7 +101,7 @@ struct tld_meta_u {
 
 struct tld_data_u {
 	__u64 start; /* offset of tld_data_u->data in a page */
-	char data[];
+	char data[] __attribute__((aligned(8)));
 };
 
 struct tld_map_value {
@@ -158,6 +158,7 @@ static int __tld_init_data_p(int map_fd)
 	struct tld_data_u *data;
 	void *data_alloc = NULL;
 	int err, tid_fd = -1;
+	size_t size;
 
 	tid_fd = syscall(SYS_pidfd_open, sys_gettid(), O_EXCL);
 	if (tid_fd < 0) {
@@ -173,9 +174,10 @@ static int __tld_init_data_p(int map_fd)
 	 * tld_meta_p->size = TLD_DYN_DATA_SIZE +
 	 *          total size of TLDs defined via TLD_DEFINE_KEY()
 	 */
-	data_alloc = (use_aligned_alloc || tld_meta_p->size * 2 >= TLD_PAGE_SIZE) ?
-		aligned_alloc(TLD_PAGE_SIZE, tld_meta_p->size) :
-		malloc(tld_meta_p->size * 2);
+	size = tld_meta_p->size + sizeof(struct tld_data_u);
+	data_alloc = (use_aligned_alloc || size * 2 >= TLD_PAGE_SIZE) ?
+		aligned_alloc(TLD_PAGE_SIZE, size) :
+		malloc(size * 2);
 	if (!data_alloc) {
 		err = -ENOMEM;
 		goto out;
diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
index 8b6f7af43648..1f396711f487 100644
--- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
+++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
@@ -87,7 +87,7 @@ struct tld_meta_u {
 
 struct tld_data_u {
 	__u64 start; /* offset of tld_data_u->data in a page */
-	char data[__PAGE_SIZE - sizeof(__u64)];
+	char data[__PAGE_SIZE - sizeof(__u64)] __attribute__((aligned(8)));
 };
 
 struct tld_map_value {
-- 
2.52.0

