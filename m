Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5213A244
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770251938; cv=none; b=lXw6xePpRWPk2jemoTIJKId1UmYz7ScbP6JQ2SivxzD/7vqOhkNBMdze6HEOy6PQczPuSJi+t5Y40nejGZqt5AlPIiR34yfkyLJ23NK2gRRML/1K6N2u5QOP1CCWEJcqZXZi5oiOPAIPJizyg/HOam7MliVcZYXe1EMCHQiIFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770251938; c=relaxed/simple;
	bh=6izzyiXqQKTVtKCUm8f3bzEuTElO5YjCcjk5ipyAP4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5xzb+TnGMq9DWjNvcp3DUohyv+YwKyJ3qS0wfIMs2qcoeQMOVypz0FhIyI8qjdpT+/Pbgl2nbirt7TTdJ6JgvyWLUD16ZpvSc5YSch5UrpoR+FTPEMAQ9nV7LGEc2nRpJtLyaPhVFh0+PMVrhnJWB0LkirFp9GiVZ2FCbDu/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEBKQMju; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEBKQMju"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-483100e97d8so2140115e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 16:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770251936; x=1770856736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FRjcqGVOQles1O4QLclaqY8XmDYsXJIHotXUncd4a4=;
        b=MEBKQMjulAvUiG+xdIPQQXyDE9E5yB65C8dCFYqPyjAbZbHe2kCzIVgFbF6wE9BQX4
         CBTm5jEhTwu12/IA7EuXIv2ci35OsOjN71mL4oYHfRtRdnTWLcinHo1u9mP3d/NA4O/6
         Sp6bi57tJZASpuHVh9YGKjphl2sZJXOT91g35T+U6c4xT70p+5vyRazKaWnHM3YCaKgh
         UPY0/HzZcZhNYktqKmwo4bDsliEoW0MybOzjgHIq2+wvuHeZ0jdL+RxcREEbKKiRFTZ7
         CySu5yHPlqqPhwXTxq/5fpF3stVSSjHQKjW7uN0lzxu9doSX30CDfRMlEvOofzncXmcF
         PCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770251936; x=1770856736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4FRjcqGVOQles1O4QLclaqY8XmDYsXJIHotXUncd4a4=;
        b=PEufQZa36lmG6FQMJom/QfE6Q2YfKh7w1bqmYOzt/tNUCFE4aTcSAME6zYezhDLRXA
         GIU742PMnbdbs9u1P7GyWJumsm3wVFr01TUYy0NK7IPLlNeaLnEoSzD9QemlDKY65qbf
         col1ymGqhXa2iHGPqT4J80diy/Dg0qaSViDv05+QCoKK4/wFCakKl/ex6EbXRW/W+4RU
         L1ZVCw5GfFjARjkN7/DKwL58o2HxNebo85GDrMAFmMr/daVOo71ocEe4NePDXOrMN/t9
         h48xchK2njjTdf8SJnOfmiMMQebIdevqY0c9Ty2EnGN46cC3HE61wAWI1owK4sXSz2vH
         Ptwg==
X-Gm-Message-State: AOJu0YyY6mi2vomAh6tVWNEj2txb4JPROJaNI+4vEvWrnSu87kmazyrM
	PiysOUY4eQlvKjtS8cVuEdGvdiw7t6QD+4L6qtAxNSVs1utR4m+VcoFz8zvmf3jBeXs=
X-Gm-Gg: AZuq6aKFt6waNbDrM3VaPHUTFYpezDT81vS1+BuMq9UODgNcYwa/0PtDwZMAv5PEEW0
	0mjwaZGSRzuLECi4QOexCK/m7HGnz47SYVFr3BlzclFNZph5miIV2OcJk8BvC1ePUAif8cyS74S
	RXKZdEbcSKPNcHkUhjIpJ+Qce4VMD2UWCmpp1cV5ayegrx+pLCS05ANvqTDeXr7ZYwBZpQVC3yn
	xkYxTcnXqlOSJLa3HFcDkaQTsuh5HuZaGzNrcWTbTE1Fs43q2lA83qUDa9rh0LX9xve3b+/iGiE
	OWOdNFzc289WPPh8tcssoxDr0/ExloO4tcby/XCg0ZYEPT2TF+1QUijYUd5mFVDxHQcvfGsiVvX
	DqWDo2Z/arOBWz38pgZwgeN1y7eUq5mn7Fls+frFMKMh7c3wrxsJs3nIp6gVXzkQcD9nRON9La0
	+KvPfJHhSBu45rhz3iDy65zcOjE0OkS5Gh
X-Received: by 2002:a05:600c:1f08:b0:480:68ed:1e73 with SMTP id 5b1f17b1804b1-4830e98fa7fmr61161575e9.36.1770251936112;
        Wed, 04 Feb 2026 16:38:56 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4d::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d57009sm16591775e9.14.2026.02.04.16.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 16:38:55 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/2] bpf: Check for running wq callback when freeing bpf_async_cb
Date: Wed,  4 Feb 2026 16:38:52 -0800
Message-ID: <20260205003853.527571-2-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205003853.527571-1-memxor@gmail.com>
References: <20260205003853.527571-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; h=from:subject; bh=6izzyiXqQKTVtKCUm8f3bzEuTElO5YjCcjk5ipyAP4Q=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpg+Z7h9tL8nT4IHe1HYaXgzlLrzPEwwwzMQu/kKe/ aF9xwuGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYPmewAKCRBM4MiGSL8RymIwD/ 9EGsRT0FgWolJGMjfQti717PAKxDTY8Lj5daR5m3ekaBecm9XmzZvEx48I3ejW1uYljPsCsX1F1N4W +qxPwRXQsXglN4tVTfFgaQbRHc+2V2RGdMqjNgdIv/a3DfxwueLIwD+GKzILXqiFzs0gK/fCLVuZ91 hL31+M29CwZQLsucLKdhWSIj7wXwuFIb6P7UNM8Afzcdr+4/F2INkRqU9pTYpm/D3EBROb3W3nFMD/ X1t9ES/PVsAKqzmUm3UiZSGxHsOBWIQQXd2m1UGw7ogqsic6/f7S+oEURYsCxLTuAVv9khCF2WjPFP Qs3O2Krzbd3p0nfwIg1rxbCLYw4v4itrrq+fov9KskTDCLxo4Z+wVgSjxvCeG9iRKKzoohp2hbM5L9 gl5wgKIsOOo9xk86XQEZWn80r0PLONCT9S2VqTn1IYCP9V81BmzsxpdF4l/+RekTyu8t+9IUWAPeOA nAOT/2X9tuLOwG7jeSQWD8u+pWYZCeewJblLAISibV+9uI8qV99PGB2rnfbGY7PelaZTY6vxQi74s2 tFxt+BF4PC7D2xy4s1svrAHz/LjGDn/D3zn7Z8cpSgQzp6zEywij940zSq2wfiGcDQnG2BVZn9wBdQ ujmJ6mWMZHIsXlnKmKV4904ZKP8+IMGbA+k6OKi6znG/wXofm7nFjz38VMAw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

When freeing a bpf_async_cb in bpf_async_cb_rcu_tasks_trace_free(), in
case the wq callback is not scheduled, doing cancel_work() currently
returns false and leads to retry of RCU tasks trace grace period. If the
callback is never scheduled, we keep retrying indefinitely and don't put
the prog reference.

Since the only race we care about here is against a potentially running
wq callback in the first grace period, it should finish by the second
grace period, hence check work_busy() result to detect presence of
running wq callback if it's not pending, otherwise free the object
immediately without retrying.

Reasoning behind the check and its correctness with racing wq callback
invocation: cancel_work is supposed to be synchronized, hence calling it
first and getting false would mean that work is definitely not pending,
at this point, either the work is not scheduled at all or already
running, or we race and it already finished by the time we checked for
it using work_busy(). In case it is running, we synchronize using
pool->lock to check the current work running there, if we match, it
means we extend the wait by another grace period using retry = true,
otherwise either the work already finished running or was never
scheduled, so we can free the bpf_async_cb right away.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 01052f8664eb..b7aec34540c2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1257,7 +1257,7 @@ static void bpf_async_cb_rcu_tasks_trace_free(struct rcu_head *rcu)
 			retry = true;
 		break;
 	case BPF_ASYNC_TYPE_WQ:
-		if (!cancel_work(&w->work))
+		if (!cancel_work(&w->work) && work_busy(&w->work))
 			retry = true;
 		break;
 	}
-- 
2.47.3

