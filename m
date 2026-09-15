Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C73A5E9F
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459421; cv=none; b=tW17247XIqgNubZgUVdfUl9fBPndtA35koiE/KPAnfkhkeL3i+qiqOiVsb+7iDPjOlQaKNs001NO+J9rrg3I41YPt0PxOFDtPM32BUJEMmjs3RM6ek2t16+dZdlT3mDsPXjbl/dWsbBZUfCwZN0lqWbn3v+iy0qG+7yh9+EUP/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459421; c=relaxed/simple;
	bh=FiRsDZdzGXAipkwSasDiwYJgNjGQw/oWZmESPlkGMAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okdix+iXtZQPyA31MTIttyxMV29k7zDV9sn/RLrxXioEAThavmoqgOfp9F1cooLJ0QdpvSXxRqQX2ce24SAHXgrr+zo34R9x+pSPFloBEdzx774sR4bw1Fi443FpRcAQtoZyPmJ2CJ0etfyV0r9iwKGBwxFXia+Wf7TCDHxb0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+9tVjte; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+9tVjte"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48586861639so316348f8f.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459418; x=1790064218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lk08SIy6DJ+jXcktdOiUfMwYrHwPBwEtrnZT5485SRQ=;
        b=I+9tVjteYJoafgWpTthxC6aBqPi/jYqebjhFYx6ApmThzHTEdQeSPKuC6/H0MdD1ET
         8jge1J31Vhao6XPidwrWw/PZSdNisyWuQZtuylu8HzTjoLmWd37ZXHAMRw2JtUqUTYKD
         fchU1cN5nAJvTt1H+RQfwT90OCF2U38+wbmK0qvnHoV3h8wqxb4aQujES8IGztyedjsN
         ZBNk8zvAxH1fvIxGRpOxfNLgU6318dS223SUql3ciodUGN/RhlbhJSZCPTOCa+Jx8XJv
         Yw/pINCHZQ6Af9tbGGxrvK9X3UKZnyteNcA7kEDRQ7lMaO4bgRFU4Yx0ajLthjHt+ScK
         7KOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459418; x=1790064218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lk08SIy6DJ+jXcktdOiUfMwYrHwPBwEtrnZT5485SRQ=;
        b=BwyBtLHMBdcz4/FUJJNJ1Y+YPlYl87rug/o0wrJf7SNXSrGEEtvEWVIiCSrSuoy3lR
         hdjv/Y2xTJeVhhuVX4T7l0+y6lzQBFMi79kCm+sPCoyVsWQArcpWJ6Cdbb2bs+iasWy3
         b9vGkNB6IkmQS8LvGpLuW8RHjoJxV4JxQbTtN5ZtOiY8KBtFjwfDkv/RdadD3e5i5WBU
         G1yscILBTtvPKVzjgY3wcgovmMN2Bx3l1ChQmWR1JS8g2giHaqxEp1pyIvo8bFUty2aN
         Atyk5c4jFnsmXFKK7k963IJU+TqBQZEkf/uVhrxL/Wy5wOgn1luI+GzjX5Mjon51YWNE
         tCVw==
X-Gm-Message-State: AFuF++n9QahjjX1kCuzi+SYDiyZsBh0w/2Nk8xDPllL1hjugK8jvNKx0
	dxe1lJZu9SWVeeGUgnNs9juhuwOh09EiEAf/vfCaaGG+iDU4sfDUhVZj/SFcuU/i08U=
X-Gm-Gg: AYBFou1kdR9ViwbG5tbr6me793Cda+B6JpPsN0Dgwu412L3RIs8oc09z+5kKqcuMiRe
	WVf2UsMb/+bJ5gwKtKR7l0JS6TioTlFD+3cd8F7XIrF1vGSbWIBbPTu0gRdaKtcxJI4CPjK84y2
	xmkjVgPaG5+LYBN5k0NSi+tT7YQvvbNW0OMEX9EAF1HLgVJS89ReeNS3jvOS5k86muqBMoBtyMq
	t2iFYmCpbGdyA9JoiDtnJtt2xUCAh3JlFTR/m5eEwqXARa2ujGFjuLpFKl/0OQUMskx29cpNGDg
	1vwDq4Xsh00P8AJjrtHgTuqDo9V7MARUNAldHFTIJWr+ocWBhpDiqVVnTzRNOx9TZVjeXCYJdOK
	96f2x9CLSNcY9I7FC9aL+tHnsxjKblF5572FL/iDc4csd2rI/Yf+5G0VWZsta4fxnkuh4uAiM/A
	G7sQTB/DuHlcBvI0zC5P9znf4btLX2RMpDoZMEiDtFyF/z50D93UNiI4/gl7OA1XeWGFMKW+X2W
	nNK6ReTvTjgUezzYIyEOW0+wA==
X-Received: by 2002:a05:6000:2890:b0:486:fcf2:fdf7 with SMTP id ffacd0b85a97d-48705b90f4fmr4013554f8f.14.1789459417409;
        Tue, 15 Sep 2026 01:03:37 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35c071sm33764675f8f.33.2026.09.15.01.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:03:36 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v7 4/5] bpf: Mark linux_binprm->mm as trusted-or-null
Date: Tue, 15 Sep 2026 11:02:54 +0300
Message-ID: <20260915080255.48929-5-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915080255.48929-1-tasos.papagiannnis@gmail.com>
References: <20260915080255.48929-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark linux_binprm->mm as a trusted-or-null nested pointer so BPF programs
can pass it to kfuncs after a NULL check.

The field is either NULL or points to a live mm_struct whenever BPF can
access a linux_binprm. On successful exec, exec_mmap() installs the new
address space before begin_new_exec() clears bprm->mm. The bprm_mm_init()
error path clears the field before mmdrop(), and free_bprm() clears it
before mmput(), as ensured by an earlier patch in this series.

Update the existing LSM selftest to check bprm->mm for NULL before
dereferencing it, as required for trusted-or-null pointers.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
Reviewed-by: Matt Bobrowski <matt@bobrowski.net>
---
 kernel/bpf/verifier.c                   | 5 +++++
 tools/testing/selftests/bpf/progs/lsm.c | 5 ++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6c6b8d8520cd..3539a768b921 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5997,6 +5997,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
 	struct inode *d_inode;
 };
 
+BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm) {
+	struct mm_struct *mm;
+};
+
 BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
 	struct sock *sk;
 };
@@ -6051,6 +6055,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
 {
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct linux_binprm));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
index 7de173daf27b..7441d66c080c 100644
--- a/tools/testing/selftests/bpf/progs/lsm.c
+++ b/tools/testing/selftests/bpf/progs/lsm.c
@@ -113,6 +113,7 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 {
 	__u32 pid = bpf_get_current_pid_tgid() >> 32;
 	struct inner_map *inner_map;
+	struct mm_struct *mm;
 	char args[64];
 	__u32 key = 0;
 	__u64 *value;
@@ -121,7 +122,9 @@ int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
 		bprm_count++;
 
 	bpf_copy_from_user(args, sizeof(args), (void *)bprm->vma->vm_mm->arg_start);
-	bpf_copy_from_user(args, sizeof(args), (void *)bprm->mm->arg_start);
+	mm = bprm->mm;
+	if (mm)
+		bpf_copy_from_user(args, sizeof(args), (void *)mm->arg_start);
 
 	value = bpf_map_lookup_elem(&array, &key);
 	if (value)
-- 
2.55.0

