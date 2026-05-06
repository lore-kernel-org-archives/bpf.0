Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66432481FA4
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077660; cv=none; b=mf6fU/xVyOzCsGyHLPqJmhSC7KCd7krfi/2WkRa6VdEeG0N0GivYDWGuX2P3P2YvLjZeQH6Jdtc8Jjeh/Z4vNWxFDzVNqDKDB9//MMp3yEDEVXBz4cgXDBJLatWUZ7dP3QmMc5+uf1jjszgELjxtPFWq1wUVIvVjtV4vJPHpW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077660; c=relaxed/simple;
	bh=1Ps2Uvl/LPepHMBDlUY4AENnqrCBZ/NnJ3wO3wlwrJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p51po2g8T9hbv8Q2KmH6QWSfnO+fvZR0QzPpvt7+M9Ym7Bl8Dfcp5LPCPDPcGicsR3ro8/UK5bu457Y+4H3PgBqbEVaDNgh6XtcaFrYOpu/vDARMGe1iIl5z4lcxobpja1r5kuuNHnj0vIpgd8XnlO2YwykzjXil4yCDUAE38rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTAbnybn; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTAbnybn"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so111510106d6.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077652; x=1778682452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rJWz1pDbyoadWp6yHfOeNQO0FWEwox+z1MU3VR8Pqg=;
        b=WTAbnybn/LrcxfqTiSrW6OpRXTGN5588k34bvZtuiUVAK7xLCDfvdr9L1V8L8o+wSC
         PzNwdZVJnX5TFHlbi/iMI7rCM2lf19hNY5abPmfR71FZBqpDFTR19mQW9hXN1k1yesyG
         p8vR6mrk8MjEPpzsncOpIRyh6YP8hlApDLA+4m8f/KeYks+3QSkMJ8PXeAqF1gc83ZkI
         WJD4BC1aYNM3O6XTkWgSd0zFHgQ3WK2HzbeRHAgUJxsDHRGVM6y9t3AQrbZF7WE99rCt
         Vw+nOhADWiN7XiHPOYS83kNyhacLNak2qVcHH8v42DfZYQNhBk0mBajIgqyrQbyx+jZB
         svBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077652; x=1778682452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5rJWz1pDbyoadWp6yHfOeNQO0FWEwox+z1MU3VR8Pqg=;
        b=qos3Bq5meSwUmIWv6EAC5pOsee48ft/c/qU6b/WpKi/H7LM8xrN7bKgXh/RsMwvaOW
         wRm1vj+w7OctrxHtabzNc/35w7pBjPZYYkdKhUd4RNUwT5N48PVVBFQv46uCkGOBQDPR
         eT8Ig/Fq/0nD1KerMeYDqpt92efdlIJytbL+mGyC09/AhgGnLjLyyApgZc4z8VB/ZPzp
         eh25tUynlfdOZfxg+7TUPjfnlFvMoIweV1rh3KG3lEufyLKRJgbl9JNa8XtB6puQiASg
         i4n7lHHKY9CCH6cVnsOmO1bT90UYj2EYr/ZT2du/AMwwEHb/Pr/xE10PZXxbtR2srX3f
         cj7w==
X-Gm-Message-State: AOJu0YyqsypsMYYT7v/r3JWTyEyZ1IkkjY7ZOpK9tt+MRTG86SLv85tx
	7j4Pt2Mc/t4T0/k0nEWmb0OgX25z8RVA6hnrS6HQPnTELhMySvh11DpyZatwp5V0
X-Gm-Gg: AeBDieuuG87XTq+89Ym6vQ0++3kI8dJ0U9LnN1r7yFYphkTYlS3xawSyuxfQ8DjGq7K
	cYzooNTAIAsd3mjQGwfvMyz5viBbOVlN6t0VWmVXy+3O35u9vZTCEykhohdwKDETLHiZdxgUMFj
	V62B1dAvEjkKCrP6u5BLvVn9urbl68H2RhHkNBBoNbimVzPUSdsylwFVJ8WXo0aB0hfRPg1ohVn
	xFIgTivPAnGaYv5dmrelAfoFG88nc21JgZuK+xpdYNNGGVMbW1Se7X7m4h7q7TTZiWsOSppNREb
	dpzFsZ6wm2vQ68aCSzULtpzbBamivutXXcEuDvVlvMC0VyFuqPOvresqBoDWak7VqXaBx3S1FBh
	JBpItPqTSFLUfpdGDkFl10ywDlu/dywA6ROSiFFynBHnvuMGffLiBFDqeARef6ToscpicVgkQ8I
	tU+kCCa4X9f5itgk9bgkaOeeEQVGvCm99vRzE=
X-Received: by 2002:a05:6214:4c87:b0:89a:629:2203 with SMTP id 6a1803df08f44-8bc429754fdmr44284996d6.11.1778077651996;
        Wed, 06 May 2026 07:27:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c0e7ebdsm201474186d6.29.2026.05.06.07.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:31 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 12/12] selftests/bpf: Test using file dynptr after the reference on file is dropped
Date: Wed,  6 May 2026 07:27:08 -0700
Message-ID: <20260506142709.2298255-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File dynptr and slice should be invalidated when the parent file's
reference is dropped in the program. Without the verifier tracking
dyntpr's parent referenced object, the dynptr would continute to be
incorrectly used even if the underlying file is being tear down or gone.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index 0739620dea8a..d5fae5e4cf9a 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
 	bpf_dynptr_file_discard(&dynptr);
 	return 0;
 }
+
+SEC("lsm/file_open")
+__failure
+__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
+int use_file_dynptr_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char buf[64];
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	/* this should fail - file dynptr should be discarded first to prevent resource leak */
+	bpf_put_file(file);
+
+	bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
+
+SEC("lsm/file_open")
+__failure
+__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
+int use_file_dynptr_slice_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char *data;
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	data = bpf_dynptr_data(&dynptr, 0, 1);
+	if (!data)
+		goto out;
+
+	/* this should fail - file dynptr should be discarded first to prevent resource leak */
+	bpf_put_file(file);
+
+	*data = 'x';
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
-- 
2.52.0

