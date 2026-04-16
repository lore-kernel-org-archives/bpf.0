Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674A3E120D
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350897; cv=none; b=VP9qfl8cF8FesuYC/6jHiBX3/eD5FeZUwt0vidxRKw4PlBMhCjdxd0HofoD8tSW28DM90Cc/fXg0jSLPiKWQ9Diuh0yzS5ekr/5kiRX6AYmdy1aj5iqh4RmhYWf/4Ju42Afmmo/NqurL07CjcIQDFg5iH6jMYHN/MvK6WMkMBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350897; c=relaxed/simple;
	bh=FUXTugSOvsK3UegpOw5mu3Uad1tm3VNDC20bzwxv5kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPNrFa/0SPLBN5fsvoZNAeoJii9MniNUwk0JHu9ehVCgmkAoI/iYq1LsEI5ex2FkveRXTOiQ4YkDFe+EZZ3W36LK5V/ymjJkfsdKaK+CjFfi86yFPz7tbGCQF6ABUs7Km3GiFrhpik9N7p6UJ8iDXDsqMGlfpI3qMpRAiEyL4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnBxrFT7; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnBxrFT7"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1274204434bso545717c88.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776350895; x=1776955695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BRN4O31TXND2yFrdcChZ1o8x+dbMqxcl58/N3Dhmj9g=;
        b=lnBxrFT7LmLv17azMwdy82t+6jS8BOxc3zjwZsOwRF+kNdW6qxcYfYtzbW6khCpV0x
         +aINbs1JYTWGu19HvdN9XedOxDlAZqm8C2ufjiokmQjremR0qIe7K45EL61tmbYCNQJ/
         fb6OdZeJcJgWhgcpc0zVtH3mkb6gVHhBsJO58EjmbSgze2G5bxn0HXi3kDVAz3bkuT1o
         36bgc42outIFN2b5aXqT/zTLUcwjjWSy6JtAGHCaj7SsDUxjtQyZr9g8nR/gYavchWeZ
         RLbcWO6sJwWkiXn+dDdu4wtoYWlqJ5CbHKIRYE0Mk1I/cmFhhf9eiq8K2X5Lg6N0Hoe9
         x4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350895; x=1776955695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BRN4O31TXND2yFrdcChZ1o8x+dbMqxcl58/N3Dhmj9g=;
        b=huUf/hNuOozkSnMRaLHmf0CAVGQrN9Nxb29JuPFlopZJWo4Y59L8MqFYfN7yT85ADb
         5w62ks/n32F2z2F2dGc4PdT7+kTMF2npJlbHdnKhuX/BvZd6k/oXNzUWdjHOsxvj8jou
         QOLiChc+T0Wgv/YctyG8arU4KAe7Ys1HbpqXc3O/GfV5zex5NZjctxNz38O8O46lA82I
         eM5HUF1E/zh8poJ6ifGal+nDU4yNFntm2Ao66Xw6U1RSYV1t5HZJoChv2geRMFWBZc/U
         W5odeYurvXxnrd2Vzf3rQcQ7yznk0k4advOdb+GXnwRakJhfH898V0Jwu1W9r/qzjQPY
         9OZw==
X-Forwarded-Encrypted: i=1; AFNElJ9NZDweUX4UXEl5lvQsGHMLHrvBN/3I9T8PAyieMP7Rk+7HVizgsrKCiYOWz7vViL6HI2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKILoSLrema8HQAuIEGSeQ4onK/8o2/gNLv+MjC2c2SaTSHNxQ
	LvdtCm6givshmKCGb9Q1t8/C3GGEKxrYxjyw6s9NU+SIql0Z9gnwaL//
X-Gm-Gg: AeBDiet4F8ccMezD6Pbc5Spp5O4Cv8mjexcVEZkCyx3bnoQFVelRCiXEwO4r/sHzw/4
	avzBSJSnxKInUvuVi7iPWnsxTv874oOfMWi5HrUXqHl2jKSwpMDQYw1nktUIwwSQzmQvYLaHErU
	2ps5OLfAaZJ6XY9qS8/ccpUn8gXhRiXGXjmKe9CNKh4D0RjQNUWgEr3RhbZjqzIP4S3k/gf4mR+
	5fts3kC/hzqgOrcdTzTtC9npiV9aTtxfAGJX/vMn8duVqcwlsMJHP6U9hEmFNfMPT5OjaxuB9yQ
	36uNoejvwA3U8E9AKIA+mz+7ekE471+URonni8ekngr+KNMjkoSwQ5Esdx1Z5ZP7znWQIDVb46Q
	2bdxmSQA3/zLjPTJSvgiQPznwPl/Ji7mdqPlm2P0QyTJiZWxcZQHpAif7kLV+5a/CeSJivKjJ4P
	U+aaQEKrOYVqTmKgksvlqmtFdo6LpWCgpCo4eIFY6x/7YehPL7RzbmLEGftzsPCDcHccCGSMuzU
	iyu7cF6bYRCPVq3Y/nUuhjMbWiodjP5h31dx1tFimN1KzfgZdmrGk/CHFqVjvBJftQ=
X-Received: by 2002:a05:7022:ef0e:b0:12c:43:3ffc with SMTP id a92af1059eb24-12c62f5a7fcmr1936123c88.0.1776350895349;
        Thu, 16 Apr 2026 07:48:15 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c641d18a7sm2727426c88.0.2026.04.16.07.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 07:48:14 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf] bpf: reject ERR_PTR map->record in map_check_btf
Date: Thu, 16 Apr 2026 22:48:08 +0800
Message-ID: <20260416144808.149543-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_parse_fields() returns an ERR_PTR() when it encounters an invalid
special field in map value BTF.

For example, an invalid kptr-annotated field whose tagged pointee is not
a full struct type can make btf_parse_fields() fail with -EINVAL.

map_check_btf() stores the result in map->record, but currently only
handles the successful non-NULL case explicitly. ERR_PTR() results are
not rejected immediately before proceeding with the rest of map BTF
setup.

Handle IS_ERR(map->record) explicitly in map_check_btf() and return the
underlying error code immediately.

Fixes: aa3496accc412 ("bpf: Refactor kptr_off_tab into btf_record")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/syscall.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b73b25c63073..83e206a0626a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1262,7 +1262,12 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR |
 				       BPF_TASK_WORK,
 				       map->value_size);
-	if (!IS_ERR_OR_NULL(map->record)) {
+	if (IS_ERR(map->record)) {
+		ret = PTR_ERR(map->record);
+		map->record = NULL;
+		goto free_map_tab;
+	}
+	if (map->record) {
 		int i;
 
 		if (!bpf_token_capable(token, CAP_BPF)) {

base-commit: 1d51b370a0f8f642f4fc84c795fbedac0fcdbbd2
-- 
2.43.0

