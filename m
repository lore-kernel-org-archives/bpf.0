Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D403191CA
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783510; cv=none; b=QpN6NuVs7/rwz3ylgKj5Th6pOn+bZB2+++IK9q26FkG95kyykrkx32n2y4JmZYv72U0YzE+U3YI8U5AWkxJicrKYd06nK3ccBY/Dm/nlDcKkxSPvjCaEG0/7+FCiIH81CMGoI9QZrj9IcRQyamc4ac+iz1rj7ypsF9rk1UMTGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783510; c=relaxed/simple;
	bh=nrHVK1u+DNukr5PA/rdgSzRhuLIlpJxlV83iATM2A7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kkTezCHEWbzZMxwxld/Z+tFTyKgxn/PnG12PQ6B5jdyK925Y9bVh0XYWZ5mn73s4IPGU0e1rogBPMaNRke+aDcS/YCmQWPDRNQ97/BtjIhFZjGutIYVdB6fsRKk7EFybJCYzIM7qeFRLg6wW1dDpVrYUaHL5YwzKKFOwlxDo/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEUuhnmp; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEUuhnmp"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1279eced0b9so2166998c88.0
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 18:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775783508; x=1776388308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3iugr7o1kAgk7CxblPSIQzUeeHF0ep5ulY5UcKyd68=;
        b=JEUuhnmpvPp15S0mQVY9U7pFr/br9gdtH2tmJHijuK2RTLBNNk63xjKgkEgNTZeCvY
         ilFgtbLRqhnxiQbhWJejJ7ep/VUM2tLk0WhBMK1lUSAPjwWPJCwbZJm29djrduEQ/Zw1
         ul2duDtIYYK6J7jGiVjMmhWqXekUD9VzVEQWZ/OtScNxkD7Rp99jjwj9YiSjywA8RCsE
         qFezMh+e5Sf62yIkgQhrwsOSJb5AUmahvvrayxilB5uarAk9NVEcj6WBbONxoslDyktJ
         Be0VO+twsYLiPE8kyiV9X7fKqDQDG7IyMwSNVs3NVhayE8eccdn5tp3D5vYhVCCMAY+H
         kK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783508; x=1776388308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J3iugr7o1kAgk7CxblPSIQzUeeHF0ep5ulY5UcKyd68=;
        b=PVaTU12vuT+0CsNDFCbQGmC7QcNQHawDRWGurxd1SkQRRPeTmwatxzXCJungH5VKYp
         1SiMTY7C5QiZH1S/DV6AZh1XDXvZZn9NYFXJQgnf5JA8ejCY9CzTdsVSKFg5IzswsqRV
         Qhh8dUiUgY6tGvXXyUTpdjMLxqFZe62p7qunXC4UiYOa3xF/Ic7siOEBDnQhXxcr1j3b
         Ip//anrw0SxiY3YbmNCLP4evWfPAeqdEdqxDr1VEqz23i4vx3R6a6e8qsk8xOYYFxTbp
         Mi9Suuc0XtC/UTyw8NIR3t5RO6pOKNjqOvx+W9d4YyokoTaC9QjBoyDgwkoYwZeQ7v0c
         eKvA==
X-Gm-Message-State: AOJu0Yysx1EXmzBQYbnOelS14J4qLxeuAHAa41kSFixeubM2R6wVeK69
	tAhgnZZJDinnDoFDjMwHoL1A490VGL6+XvPtRwPBIbEKGPRS11/LCq7g5rRrbdV1
X-Gm-Gg: AeBDietvTagGXZTI3HzoT8glQutPnk1xXYHXtUAEnrdU1EfpDu0asCCf5B+9977j+h1
	K9zK5i5zXzq91w+FWQOGKFpiGp2V32a/AXtnUrkerGrPUhwFj6pOAP412jzCP7zMAX9hj0EdhT6
	nG//nCySABAMZYFL6ZMqm70cj3cMo2JszXbF2uCATBAPa86aj4AVeAInyNRy0hdveVwGZMKBclM
	RI0VWAQSUNgcIJtH0m7jBtqcR9AEzs3YGHNfYPxN9Ne6m83e7cIDyFJRrViIEAnuwEEYwyks/wv
	o9NJ/UoUuj3EwZZo+xAtqnXcsOULVvCqRKB98KkNCUVEO/+LeIfWy3KfIfMHFOMqFeRGEegzBXx
	pspFYoGog6KzEpuJyXtPvW63dxoIGg2LQ+6ahxWbjDUq3dmRqXrq+F3B29/TVRUk1g+vBMpZf4/
	pF4gbBbCpfAzz/APM9n1t8aexGU4bI0zk211DwlXuU5X1CKu/uyk42zynRUNyOv9lXl8nX64uje
	EtRPlA=
X-Received: by 2002:a05:7300:7495:b0:2c8:8ae4:962a with SMTP id 5a478bee46e88-2d5870ac142mr783895eec.2.1775783507731;
        Thu, 09 Apr 2026 18:11:47 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f3a8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5627c44fcsm2174922eec.23.2026.04.09.18.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 18:11:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v2 02/13] bpf: save subprogram name in bpf_subprog_info
Date: Thu,  9 Apr 2026 18:11:21 -0700
Message-ID: <20260409-patch-set-v2-2-651804512349@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409-patch-set-v2-0-651804512349@gmail.com>
References: <20260409-patch-set-v2-0-651804512349@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Subprogram name can be computed from function info and BTF, but it is
convenient to have the name readily available for logging purposes.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 15f7f9f35be9..410939d7b325 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -664,6 +664,7 @@ enum priv_stack_mode {
 };
 
 struct bpf_subprog_info {
+	const char *name;
 	/* 'start' has to be the first field otherwise find_subprog() won't work */
 	u32 start; /* insn idx of function entry point */
 	u32 linfo_idx; /* The idx to the main_prog->aux->linfo */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index dd81cfbad680..cd2a56308e59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19682,6 +19682,7 @@ static int check_btf_func(struct bpf_verifier_env *env,
 			goto err_free;
 		}
 
+		env->subprog_info[i].name = btf_name_by_offset(btf, type->name_off);
 		bpfptr_add(&urecord, urec_size);
 	}
 

-- 
2.53.0
