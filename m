Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE61F27EFEE
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141884; cv=none; b=CylkgofvM55ljLw1C0zDSkqFllUtO6asN0qiFtq1MXZ84lUGKKH/ptnw7WG6YMz7Mh47YfYcCRzjnNXp33TVYWWEgAxTOprPdnRJtRW63GfHzZQhBHd6kIly10DF17+I3b4w9mTi39SngT7GK3Gbd7/uo9IfvnPBwe4hSdlCNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141884; c=relaxed/simple;
	bh=l9k9Q2kWIwnld1BWFwfLia81NWmbJFNUaD2vREvhLOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYEEELBZ+ZmbbPzcbHQk7GoLdMZ+yK1dPQer2Z5lKn8+avhF1q4X/aHlN7OlAHS3GNYzwbY/3iGENfsXaalIN37vqpRf42hRaln3Px5kflKxpIuP64yfFuWPdbSrUChLCnxbTd6QmsL/rB20s+7YuNLzMXAyEVIKeX4puvJjC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=OVd1OJRW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="OVd1OJRW"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c70ce93afaso635413885a.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 10:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770141882; x=1770746682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWxPPnesqNe7Wjfap47F0eTmWPd/UkwiOB8/aQ3QVNE=;
        b=OVd1OJRWn4kUjXGQg/ALCXtofmK09NyAWtdZfXdzCHU/hot7EPwa63Bf51wNIbsptt
         igU+VJ8m8+1TIaQnOJFNi1E1myjpCMpEPg/mEC+J+SbNmonOacccU9y0XVaKmWn5twvw
         9o6SL6Vr5r78OELU18KCaFHvpGNl/zGjaRNEAn+xPvTjZ2D42Brt9ucIpzOE9ccf5lnb
         f4j0RDyifbHfbIxlrn3sYXhobVK7X3b1l/aANhh3pciQE2L8Xck7MJ9x3N2PwzXK5Pl9
         9RiCdRNCcg7giDAeYOZxNCchUTKgv4kie0yXgVbRivI2wS41E6BkXKUtk0FmUjl6wS1w
         jmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770141882; x=1770746682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWxPPnesqNe7Wjfap47F0eTmWPd/UkwiOB8/aQ3QVNE=;
        b=PBm46WMZiccPEqizpUXM5BvNOU3zns6r/IWCL3aO8/DZL9iq0etlHFePQUdcNf5Pq5
         Z73H/eMDX2IEsxSuXwc7J2J8m9Sn64hfz6/JkPZKsrmfUXeQZulf3c0f4UkXz996MAvJ
         zxMllrP+xOSdSRGsGyBPnfAeAZzZ/Pinz2pkRE1BDgGvCcHz4x6AWn074kOu38tG8z62
         QyDuQxi9jYm1hr4xBM4GRgXVYGvmN0z+l7mRq41AIFEnnpm5Yp7n0QhVrLxhMPTheqdY
         J49CDtAWqaO4wh5XVgLIdyEUnhRH1LYtZ4XsTGmry4hNde6q+7P8lq9GEbfDn8ITh7Y8
         G0jA==
X-Gm-Message-State: AOJu0YwFahvZs1Ki3Kl9IGWKq1G/YH/qiFmJsxo+rPOd2WFmrn/qrU2o
	GT6m6NTfoo+3wQU67Kie5ic3aZkpL71Soe8dzqzzMrhpc2O29Y6yv/qF1mVF2pC34VAP43SvP0v
	w0AKA
X-Gm-Gg: AZuq6aLjwaXkwVMHSGIL/UHHWJPU7ZsDIcVUe0Y6r5l0q/A7AzXb8oIgi01gONQHkU9
	OiDu+OCtZ1eENhc5x2y0zcwlD6j9tuJJzAj2Sx/3ABbq9j4nRs218T8dfjRHRcP4OLkBP7hf8pt
	r17OoN7OLFSnNawWZT90mdioflVlLoWgSsp65mJ83gUnzHuDg39DoZCG733cz73GNXBjS1ILX/s
	Yd5uVDJZDigqzbvfVPqR1GQ6QhQ3nZLot/ddtb0Bvlbe1wmxdXY7RDWFRssRwtBpBaOjtoMvPZi
	PtrkWJpkIuAXnLGCAEJl9O3Mq4m0xTtF6WxSpeGUVkQdsueGxS+4kG/c0ca9BxC0zxZ2uO5jaba
	wgpOwtXnHofGayh8vjQUdYY6bzo2f4WspN1C/foxm6oaeMFeItLAEpOCJzZKcJhNMPB5sJotMUN
	89/k5P1mJcyQ==
X-Received: by 2002:a05:620a:2a07:b0:8a3:e51d:63c9 with SMTP id af79cd13be357-8ca2f860eb3mr58176385a.25.1770141881722;
        Tue, 03 Feb 2026 10:04:41 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fa8144csm20469185a.14.2026.02.03.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:04:40 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 1/4] bpf: Add bpf_stream_print_stack stack dumping kfunc
Date: Tue,  3 Feb 2026 13:04:21 -0500
Message-ID: <20260203180424.14057-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260203180424.14057-1-emil@etsalapatis.com>
References: <20260203180424.14057-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new kfunc called bpf_stream_print_stack to be used by programs
that need to print out their current BPF stack. The kfunc is essentially
a wrapper around the existing bpf_stream_dump_stack functionality used
to generate stack traces for error events like may_goto violations and
BPF-side arena page faults.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c |  1 +
 kernel/bpf/stream.c  | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b54ec0e945aa..c30a9f68af6b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4562,6 +4562,7 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_IMPLICIT_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_print_stack, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 24730df55e69..be9ce98e9469 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -245,6 +245,25 @@ __bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const vo
 	return ret;
 }
 
+/* Directly trigger a stack dump from the program. */
+__bpf_kfunc int bpf_stream_print_stack(int stream_id, struct bpf_prog_aux *aux)
+{
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	/* Make sure the stream ID is valid. */
+	if (!bpf_stream_get(stream_id, aux))
+		return -ENOENT;
+
+	prog = aux->main_prog_aux->prog;
+
+	bpf_stream_stage(ss, prog, stream_id, ({
+		bpf_stream_dump_stack(ss);
+	}));
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 /* Added kfunc to common_btf_ids */
-- 
2.49.0

