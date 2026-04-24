Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615636897C
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058584; cv=none; b=r5vgHJkEPUkymLaZJgtVf9CbaySEg2e2CbbMTmfNNF7lpY44eGEiF/8RFxkyENH4IPhA/9KYhiFBtJwWPLvoZyb4aP2bz0M9XfcGxj6nttZ6T5GFU+atnYaoqdHviP2o+VbFV6b4r/OPFIPj2osFMvqAhUMqaDe3EIjZDd0lfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058584; c=relaxed/simple;
	bh=e7CPAhtL/7WA6bKuSKkL6SR3jCvxUb71kMFXlGHDq28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxchpTLoFyMvXKCcn6XpfI/XmgIHDpHeVOF4mWX7FJmBHMqgBLCTDSAwSTFmu4w9X5VJx7Bg0eo6axacEeIfz5nfW+pSHSiRzB1izaEzRKyKJTcZo/pAD9JQg3w4MPrI0nSHKAK9Dy3MWATgw7askMoCX2Y8+igxyTZAnq5OhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp0uxjH6; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp0uxjH6"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79ee5037d44so112436867b3.0
        for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777058582; x=1777663382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdRxiRXADHl0ryLLNv0iiogQt3moYE5dwZLqv6J/TcU=;
        b=kp0uxjH6eX7okSssQv0H90a6d3ZoZwAuWkIVF93S/nMjR8R6XUhvSlPGm2reRvy/P8
         LJ0HsP82RHYlkA7hnzoRx+FdFtXdFuaeOIxDUGOH9LnGEninunHur50Wd5l92aIQrPD9
         wwMOuapGDtxBfGP1I0qWTtpViO1aOkUp+vl4FDYiBNBZ9H7NZrTvIeintlpvl41h6w+v
         UXpTuWtgCOMa6TzTVEbHHKm5EpcU+EMTJFlOe/TU+aMXqFPm60n75OSX9x3vamksXY5D
         9+UUlUrJ5NsmbCfbYUaHScCWaXiDtP66tu38vW0sRLZp1SFOYPTJ39573p/GTOZ1MG8q
         vthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058582; x=1777663382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WdRxiRXADHl0ryLLNv0iiogQt3moYE5dwZLqv6J/TcU=;
        b=SA/UW3AW4uA6YbJBIgbWlz5oNcxV3aaNqjkejxlpOlCEpw5lr8bwOHRDXlJgKM7JLK
         w0axP629STYgG3MRLnqOToWg+hLVM4GJb4SuVXqxQ6ZaexrLe4Bc0PBY2ZXYLHdq7UzD
         cFI5m+xkwOADCZ0IAtmxwkjDyfz84G4KdXK46owSFIcL3pm/l17Shy8C7rllojMh/mve
         NCMUNm19UzaFhQ0RAFng7JcaZnYjhQddo7Orh/Sd+sGg2QAh7LyrZwdmDVAPSeVWvn1T
         uSJFixIA1twTETrcAPBWegf5xKkTO/EtvlrjnCZUYFpaUvOQcqVOfWEjBrf8yUF5+gMF
         pFtw==
X-Forwarded-Encrypted: i=1; AFNElJ9CAasutNHKd3vz9u4pJNVt66Rc5aFpFMXEgIYgdAIM2GLT+8LH0C9wB6Hwc6a+qfLCjeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8ir2G2GNueEpiiP6nXFR2dLpZt91A069uwMYcPZ8kyFCULAZ
	R4v5J2rcQR1+k9xWME62L24EC1f/0v3NiWbXZ80jcuci5mc37tjHt3q/
X-Gm-Gg: AeBDietqK2VPJvMN046teQ4LoBSYIrrTaqT5Mm8Cp80M+8XsR81VBf7tTHMhTcZjThb
	+ck8I8BCA80NAoIYYA2nyt+/WZ71Iaa9QkCI0iSmd/vIaNt5c6HiMc0SBgsFwA8+ppNFvejzOQ6
	3D4szU+ToBUUDoRsRHC7X1Ap6VrhWwbiLmwgKdvQ35NWYcRU9CgLNE42Ra7dQeDuulfV8oBDyu/
	m15fm07cD/BpbuGRByvqfUkAtNDQWCUg1rHxC9p0f9W4OkkeI/VNxDlokCMUATcuv1PNR48mNn6
	zrioiWe+bQb7a9GqsojEa1wJF8eU/CObao/NRkoFftScEgiesYTB9hMBFfvfTdtpYlQJis/mif0
	p7uNz0DUyRIy6CGRJjTnxLm+pFyxyk0RhK6x9Q+GszFmaKkIbOrskEwwYKkTQYFa3EgyZsJ600F
	gpAMpL6zjhF05/L1PP0JcyGzyGz9j8r37r7a5OtFtD48SclpA3dQS5/BCElhtDVY80LQGCTWyh7
	d8P5TMSCILj+uNw578g
X-Received: by 2002:a05:690c:4c0c:b0:79e:c253:f723 with SMTP id 00721157ae682-7b9ed45446cmr250619827b3.34.1777058581893;
        Fri, 24 Apr 2026 12:23:01 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:cc96:e003:f6cc:4ed])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b5254sm94726757b3.41.2026.04.24.12.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 12:23:01 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	mic@digikod.net,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Implement dtor for struct file BTF ID
Date: Fri, 24 Apr 2026 15:22:51 -0400
Message-ID: <20260424192252.695240-2-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192252.695240-1-utilityemal77@gmail.com>
References: <20260424192252.695240-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a destructor for struct file allowing it to be stored in a map
as a referenced kptr.

This dtor is analogous to bpf_put_file, and calls fput to release the
reference.

Acked-by: Song Liu <song@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Changes in v3:
	- None

Changes in v2:
	- None

 kernel/bpf/helpers.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index baa12b24bb64..4739e2bf0f31 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -20,6 +20,7 @@
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 #include <linux/security.h>
+#include <linux/fs.h>
 #include <linux/btf_ids.h>
 #include <linux/bpf_mem_alloc.h>
 #include <linux/kasan.h>
@@ -2752,6 +2753,13 @@ __bpf_kfunc void bpf_task_release_dtor(void *p)
 }
 CFI_NOSEAL(bpf_task_release_dtor);
 
+__bpf_kfunc void bpf_file_release_dtor(void *file)
+{
+	fput((struct file *)file);
+}
+
+CFI_NOSEAL(bpf_file_release_dtor);
+
 #ifdef CONFIG_CGROUPS
 /**
  * bpf_cgroup_acquire - Acquire a reference to a cgroup. A cgroup acquired by
@@ -4763,6 +4771,8 @@ static const struct btf_kfunc_id_set generic_kfunc_set = {
 BTF_ID_LIST(generic_dtor_ids)
 BTF_ID(struct, task_struct)
 BTF_ID(func, bpf_task_release_dtor)
+BTF_ID(struct, file)
+BTF_ID(func, bpf_file_release_dtor)
 #ifdef CONFIG_CGROUPS
 BTF_ID(struct, cgroup)
 BTF_ID(func, bpf_cgroup_release_dtor)
@@ -4874,11 +4884,15 @@ static int __init kfunc_init(void)
 			.btf_id       = generic_dtor_ids[0],
 			.kfunc_btf_id = generic_dtor_ids[1]
 		},
-#ifdef CONFIG_CGROUPS
 		{
 			.btf_id       = generic_dtor_ids[2],
 			.kfunc_btf_id = generic_dtor_ids[3]
 		},
+#ifdef CONFIG_CGROUPS
+		{
+			.btf_id       = generic_dtor_ids[4],
+			.kfunc_btf_id = generic_dtor_ids[5]
+		},
 #endif
 	};
 
-- 
2.53.0

