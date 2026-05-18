Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE83E4C8A
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092655; cv=none; b=LoEvXwS5dq3r+wxi4xFW03U5zKtj/1ezHcGlefh2NDAng51ROMSMdq/sf0V2lqCU2TjGFZRQvoRNy8s4Zuclayh7p8tJkyMTIAYaEUW+bK+sYLJtQYYcFtQaeb3wNBg/wZfwLPn3NDq7i2RlZyeVKjmGrDF6iHPOYDoS2NChlpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092655; c=relaxed/simple;
	bh=DOfWH6hLKc3o9vRvYL5MSuCO1dG989HvIXld9/XiNFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epQBlkp12j0LClbJ6ocFE8zBoszylYxI8NRRNwF8FDCEpzyqSZqNofgudbwUeUYCmri9sr+p8oynkWCc8PX4KjCi5NAoX/Z7yB95NYxzFr3K5yNKoRhXfqL5B4tY5YlcKsRznhejbdy65DRqX1sWGujhzIaM4q+vMryj9raC6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mO0o0eTP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mO0o0eTP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-365cae89bf5so689475a91.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092654; x=1779697454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4/cZz+D5VB55BisYY3cQwNyjxNuoDjRYz6rglyNSPk=;
        b=mO0o0eTPa3N8fHbdHmiWgjWP3+npe4MPM60zDiziD7kqb1Iw0JK2DnZwzQ41UW2tSY
         I8G6Lvhcp2ACn0kHXI117LybXaOUHzlJtJz58Wfltd8OIE2r3pH8SLng9GAZ7gA2gf1W
         auRyO8HsEcqKJkGrGvBXOzWYs0ojDJQd4q3HdmwrWcJN3ovcgGgBh7v99CPwGYbs8vMo
         uflE+EVN5RAY5C90op/ZcQx5f2VbA7N42PD4XagUzWf9pSvtdfCiaQ9hyT/cs0XzcT5C
         1LzRqowhikY4FH5EUfc9s2iIDbOVygGU5mhji47vslZvH+chXhkvLAdb3V0xYD9bbSMZ
         Eh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092654; x=1779697454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A4/cZz+D5VB55BisYY3cQwNyjxNuoDjRYz6rglyNSPk=;
        b=csNpdjVKApX9E+JBDiSG0eyw1x7j2z60guQevQGMRj6JDh+8D0yWyExzfqsNU2B2Ub
         ZGvfFvLXJ0lMr7SMKtNhPoDGRy2HWx9i/EsUL1YZ1UQh+EUqwsDuDMVDCmmfj4aS/F+h
         UuyuVM+hrxYhiXIqy2azjyZG7oo8rLJrCCa3prr8t04qN5BA0itBWm+1YqXBqZ3gS45m
         ubG3THTLUdCcRzDAsU6i7sejeRM+sL3eSw0q/CcXIUJ43AGxXDvaARgAp0WXfwfbz9cM
         Li1DIIwGHaNjffh7It/sEpJyhC9zQLq0HQtZbvdXv/3DjbHej4LBTk0opX1BRmkel4lz
         Z7Yg==
X-Forwarded-Encrypted: i=1; AFNElJ+Mn03xholAZdGvcARXMopylK4Y8HpxmNsCogDETsHs5EYP9U9SdJFmxxGPaiEPTG/ujLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB4j+VfeCZ6grzKXN4UI1v1CoqoH7efItDkd1u2z8oIl3upYw2
	ZwFaxqH0mxyg/i0z0A36t3+Y457zroRalX3siXlTW8m4xBL1pAWWo6V/
X-Gm-Gg: Acq92OHkJbPwkSFbWUYWGlcQ9lKFtv7rl5meLvH4D1Xt00zP+T/Y7Fl0SicR+5NuZ+D
	43yQUY2cT6yGafnFT8gQ6/bOe1TbFXK8ZdaC3CvUq7rcGkr+SLaZcwdrh0ozUdUmXQQaJUl32X8
	f00sclRWON7Nvm9IKUXgA9TQGKBqUf1PPb8VyUbIacYAyjdvtV4AloiLKbcKO1v96nMHBDSI5+3
	MVQuOkOo/k3dbLuEoea2avF5Q9FTLqU3L6NLCM0exbLh5OhCFpgpFIW+cuGjOX9liDHfcMUN4/1
	8xfAhgvT+KSz1ILsG4e7lzVR6xGc+omskPe6p0rjF+xHFa8P1BTHg82LbkluMGldWTtj1A7BPdQ
	g2jPkxTWtxlOj8YLk61wBB9C+VnHWLfbr41nc0C5uN6y3AN0GswXX2Qt7V2VmniWpuV0HUpoDt+
	xYaUE6WV32GBQxav5nLrQyEniFwwoR7GHhWEdPIDBaW834CqJq8HAYpBDmv0NjKRqZdvHYJxiNx
	bi2u2blRb1WG+eDfzwq0SJmcDO2hw==
X-Received: by 2002:a17:90b:3505:b0:365:3154:7b1 with SMTP id 98e67ed59e1d1-36951dd55famr13420003a91.26.1779092653628;
        Mon, 18 May 2026 01:24:13 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:12 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/6] bpf: Add bpf_ktime_get_real_ns() kfunc
Date: Mon, 18 May 2026 16:23:39 +0800
Message-Id: <20260518082344.96647-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Currently BPF programs can obtain timestamps via bpf_ktime_get_ns(),
which returns CLOCK_MONOTONIC time. However, the skb->tstamp field
populated by the network stack uses ktime_get_real() which is in the
CLOCK_REALTIME domain.

In the series, kernel reports the software/hardware timestamps through
sockopt and then userspace bpf application gets them and calculate the
delta only through an unified time unit.

However, prior to this, when a BPF program tries to measure RX packet
delay by comparing skb->tstamp with bpf_ktime_get_ns(), the result
is incorrect because the two clocks have different epochs.

Introduce a new BPF kfunc bpf_ktime_get_real_ns() that returns the
current CLOCK_REALTIME time. This allows BPF programs to perform
accurate delay calculations without clock domain mismatch issue.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2bb60200c266..863645d096ef 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2317,6 +2317,11 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
 
 __bpf_kfunc_start_defs();
 
+__bpf_kfunc u64 bpf_ktime_get_real_ns(void)
+{
+	return ktime_get_real_fast_ns();
+}
+
 /**
  * bpf_obj_new() - allocate an object described by program BTF
  * @local_type_id__k: type ID in program BTF
@@ -4859,6 +4864,7 @@ BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_ID_FLAGS(func, bpf_timer_cancel_async)
+BTF_ID_FLAGS(func, bpf_ktime_get_real_ns)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.43.7

