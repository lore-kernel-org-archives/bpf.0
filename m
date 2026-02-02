Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B18293C44
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770060799; cv=none; b=KqXmK7HITaFJh1+DTxoajqHYdTBuDs6XQEAF0TxnYBKKlwIYrHu1+VmxuwizHsTkGmWuhXp9kPISqDSaUDTKiA5bJhL0dYe6BnfZYuR4UHG2Kr7E+rs/Dnm/XzA/4aBCP9j1Z+a/CK5io5g2kLxTlzxdHp0xumjMbESMC9bFkGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770060799; c=relaxed/simple;
	bh=koTekT6H8e27fXboayfyjDDD98AKj+jhJ9GN5+joOSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdQMOkXa7iXq4tLP3ooiRQoCx+0vyRE2HVpF5pQfya840O/DZCZ8wYjWsgB+8CEfCGXH6/XN8uVHbB8lmrabsboGCAWU4/sFvhLi7mDNjE/zw8yOeBbxux//q3XrNh3P6Kwq8Q2Wm0n8sA80xGooDKrVF2Kpwjse9szNCPFBBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=Phaj1P5Z; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="Phaj1P5Z"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-501488a12cbso59304671cf.3
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 11:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1770060797; x=1770665597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+ESVoidZukMTod7xUHwBIRfWMBnMRPCaPC0gOCfDm4=;
        b=Phaj1P5ZSYMZe3mr/VtfXQQlg8BR+fDIXcHbUoQ5NEiOYZCs6hPjkQW21z+5CTEePc
         TX+ndpPcuHD52mMu/Vd5ImoAewovKLofe5YWgPZL8wqVz4Y7yKdAm6RTgsg3z37IwqJD
         8SBDn1tEx7r1JJQIEcdinJoPwPwiVa9xm1UrDz8EPm1xbUh+y9S3BPwdk0GtAl3ZlAS9
         TdOZ3Qkzk1IEuK4D3vj7jv2x0Ubcc0+9eUmM7eNsQyJW+ZSAFU05CBgjQmrIQoAbPBzo
         +OeITy+cTuyfl7bKBz0bw49p9dIRTDfVpo+UQXibgYNJPx3+DsQzMDOFYmj3dOuv45l6
         IyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770060797; x=1770665597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+ESVoidZukMTod7xUHwBIRfWMBnMRPCaPC0gOCfDm4=;
        b=IEMZqx39penpHWx4Qn3KSFZH1D781QUNsHrZUCQmfxUauQAdFgOP1cAudcRoM7g1VB
         GpuOzMYLUNsWPKQN0IJ0aYgNgqU0TTpduaw+YfldU0TvpJ//5jxxuhF9OIRvn5JdKHZY
         /kVzspbPRTVCAhrQ1YmQpyQqqRoirRcm9xZb+kgx5XijKqYpn5M1kFJnhrainS6LXSG8
         tCq23lUf/qpAeOREeIlV5j8mAeA5W1YYxRY9Ta5InffXXtUQk5uiEI6657w8hvoZ7YMD
         GqSOUFaLr3beH1Gu/NQxZM6FS1cWbELy/N+3GMYcWnBbJPbMm4n3HaWzId91pabHg2ox
         WTug==
X-Gm-Message-State: AOJu0YwzArqz/WM7Z0nrEZ1gJFo4myofgd4VJNsGifk+I7UtgTILXnbw
	28DeFQiMINizvyuxWG02g0FQhC43aMhcKDouoeJizTnyHXiGOdHzt6GTZNIyXrHHXskpIDByXrL
	F2F2m
X-Gm-Gg: AZuq6aKut9CgrxHjButzPg5F6AGOzT2smo8znrsWBmpH31AP1foZ/EqOCFQYW1ttc6w
	HjaZ2tTU8nle47hxM1yftjyTaofMa3QP8ohLuAx7Auw7zncsXd8RCcCkxZGfWatPTqo+VnqxEDF
	p10QbSOOw2wPGqkFetNL231KNlFzvPEbd/wRuow1tfLsNiwefqHOPUWY5WkSxl9JEJHgiVc90QD
	TZoGIOEM7XJ9ySSEPYPCFaeiTrKbs8/47t+tBHWuxqZV1bmaRRXYyf42V+IaJ4YBENWFpaL8Xvk
	DWW2cdOcwvh7PE+tjArlPv/HRBBdPKpvLZV0Iv8uRoJUTPIomt/7vfmRtwyKP2CfVj6pkn32zni
	skl4A2qnuuB9xEBDI6uGjF0qguemE3ZCUDVdcSGeW3CJLxMeXkNYt24Zv9QrnYYXKp6fq9yFOR7
	Pe2Kn0RgXQBA==
X-Received: by 2002:ac8:7dc4:0:b0:501:3c1a:6404 with SMTP id d75a77b69052e-505d22c8e29mr152350581cf.84.1770060796591;
        Mon, 02 Feb 2026 11:33:16 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745d7a9sm111971941cf.5.2026.02.02.11.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:33:16 -0800 (PST)
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
	Emil Tsalapatis <etsal@meta.com>,
	"Emil Tsalapatis (Meta)" <emil@etsalapatis.com>
Subject: [PATCH 1/4] bpf: Add bpf_stream_print_stack stack dumping kfunc
Date: Mon,  2 Feb 2026 14:33:08 -0500
Message-ID: <20260202193311.446717-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260202193311.446717-1-emil@etsalapatis.com>
References: <20260202193311.446717-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tsalapatis <etsal@meta.com>

Add a new kfunc called bpf_stream_print_stack to be used by programs
that need to print out their current BPF stack. The kfunc is essentially
a wrapper around the existing bpf_stream_dump_stack functionality used
to generate stack traces for error events like may_goto violations and
BPF-side arena page faults.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
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

