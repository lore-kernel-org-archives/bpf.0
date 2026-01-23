Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B03346AFC
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153848; cv=none; b=qSksxZIKhruzgfqEp00N8thq709t6Y+1DwlO2Df6TbmVsCS9jyMSF6n6t3N88tvbM0K0qyXWUTqLrQmkZtI+1JKUz7Aem4orw88D7JDPyrBvGrNImoA8jxyxHqR2r26JdfSXQAUDUMY0EAPUESZl8CDqik+7+pyUSEGbiFm/14o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153848; c=relaxed/simple;
	bh=mSDxwBVD18PlqYhebUKPcoi11BSc/00xy3TAGxUREuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq+TXU6IJy/I+PF4uHyYu+TjA6cpYIUDrlEWDgFzB2wOJGd9QUbUbqzLHMg1RE8df/Bor+qWHy/l4m/1+XYb16Y3JLYuO0HBT3gqvLbgNNHW7LPEt6hE3ATxgHHqmVNGYr9QzuAW8IeIL5oKriDcHpvQqHqNgBv/9OT1BUGfToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l17vT96q; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l17vT96q"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso672053b3a.0
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153846; x=1769758646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=l17vT96qqwHbs72Ym+kwBHiOjfu7n30Z2pRTgJUN2R33YQbfV5wTbn1GIrGad4KkRW
         Is38vaf7kOxzDUB/MwsT3BdICcxC+bfnDc43umjxIYjyc7PCy//+KB+mZrz7QbvyIKMw
         9MBT6LwEZlW/K7Mbk8fsgNJ9kjc5W4LTGRkTcfgXXENiLGm7XGrPydK7WpfL/GrsR7KU
         LQTjELHhp30SesMZFHiZBe0837JLvUSq/maAzThLG7ZbuA6FPk8lZewFIzHMJCno2h43
         RXDCVLRNZMWK9JMIlCG6NGJVcYAYC8pUVbFvSFzQtE+tuwPLN6kBlRgSEYkClHxDtARU
         kGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153846; x=1769758646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6couASguPY6BXT1cGXkKjPK1OxE68MmNkjTJGExLgc=;
        b=pupj8PzzDDEqcC2pRaUzAB5tVlvJNPSXwix72ltPdn5pcUDYXJ1K984MOsAHAjdHD9
         l5FlYP7MI8IMwjNILcxRhMgkUBUxhDsD6nGvHcnmrwv+WNNrBoOOgYKsKgXBUuoT1qAx
         CKK8J4ah7knEljwohL6q3YlmopvwtgrC7YOrzKMXHDTVFQiL1Rhqcmf2UOGzq5jSJg5N
         vvbN0kKI865cmWZ2/8KkR/SYVP1MisWTfmvzYTsaKWxjdVpy9DFYV5rH/ooGL/lqr//F
         +HlV0efP9wGOfokuZX5MusGMO04LSYq8nQvuQumJrSl21f32Z/aUOzLnE8ZVySAZVwuy
         cx+w==
X-Forwarded-Encrypted: i=1; AJvYcCWbhU+jZPSbK7L8ue5xyh2CyZ+DloZ0GWhxCU/i9np+wsvCzf+ud5xJdZiU+DoMBxhUU0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRsvfvEWB+deM6eCZmUS8GevclS/RjGqrp/NAwADWwXp4kBFo
	mfwIay79Fq3cd2mUOwXBY2E4/yWB7tyuAWmWjzPKk7kEbOvGCaoT+8by
X-Gm-Gg: AZuq6aLfxIUDIjmRYC0LxdOuM1sC8dMpNHLcth9EyeD5UYSVzUIsf8UpzftTF9YqKue
	YZw5s/xVI1L8D+hCPsCt4VV8TestSL1ElST8Hl+YgGlfVH2KoV4ngZ0zp20hL6CKVimy8oa5V0X
	njBFF3J4Rrzo5KmX1sn982SjJZYbsBHlp8bH7M4K4XcGT9FC5WcwxvLgb/LUqI22koKMBVnzXGn
	C7x4D8H8KRw5Z52RRcNBb3hzSRqSRlsFzf0idcJaLIX3h3cRra1QUnkc6Sce5gOf3dkwsmw1Auk
	FwfmIPUAveMNSsbnlei+1g93sexMccRrb2YaBHXzpmFfNUXaNqABEDtFnSBM9g0YpIPc8n+slJi
	SRHGRQiQyoYW4y3K7rRWMUARnhAMCkckWu1+lqMogF3K5BvkCS37nWwttn1PhuZUw5v/blkuKDM
	tTlk3kxb74
X-Received: by 2002:a05:6a00:3ccd:b0:7f6:4922:89c4 with SMTP id d2e1a72fcca58-82317e4497fmr1780587b3a.55.1769153846166;
        Thu, 22 Jan 2026 23:37:26 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:37:25 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v11 12/12] selftests/bpf: test fsession mixed with fentry and fexit
Date: Fri, 23 Jan 2026 15:35:32 +0800
Message-ID: <20260123073532.238985-13-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 211332bdcccb..86e8a2fe467e 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -161,3 +161,19 @@ int BPF_PROG(test9, int a, int ret)
 	test9_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
 	return 0;
 }
+
+__u64 test10_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test10, int a, int ret)
+{
+	test10_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test11_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test11, int a)
+{
+	test11_result = a == 1;
+	return 0;
+}
-- 
2.52.0

