Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2535930E84D
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609189; cv=none; b=hzrz88P6vuajygD2u8JL3SnFRk8kmZRSCUgte/TD/Y4fLlqoUHjmUJvYOH/A7nKK1fzy+8iXAD5c2AdsHDJBvs3/rkTfLQFH94EMTtsPWBh80KZzV3FMaZVE2B3m/xABOU4+7y2xsslhFAkTWQgdP6sdQ6u9ovj2RDCNzAKL1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609189; c=relaxed/simple;
	bh=8MaJNyR191CxvKCR93XU24t6Fvj192M1OImBTqOldyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8eN0jpGBPKUrNNRncj6JdMNvap9rpQ5A1HvtYWL62ZGgaLL9Ou0ifc+1UIGvbYj557OwGGXlNYUbM1LSd6NiW6pt6P3j5e0eX5AWdPTNUWrfiYu3zlmVyV4Os6tl8ZV120gRzocpCU2QK76/OHaeb2W2POjqsQ4qQKL394Fcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1V4Seib; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1V4Seib"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82746ed8cb1so3589244b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 23:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772609187; x=1773213987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+ZnasW3opnYA7MfT6mnv63jy4QSymfVfISLyys32YA=;
        b=N1V4Seibkan/HhSdngD92EXhIC7OxQ3Lyu/Bg4XJ78nz3Qh/F7jnAe96MQOh00B0tA
         8Tb812uVhs7t+XlUHi9abcULtLKt7rvSJXwr5XebgvcVqtFXLEAbTVxDZ9sVLMyJI1Z2
         KndGfu0ZEuupEWRtv6zBhll9XV82Wk6ItAPU0nGkt13+ezwYbtM+5YUwnhCoqzYsjWdC
         Q1SGrozd/kQcVhL3BfJM9Iv9Vh4tyABzBxKUT/JnNGuh104YBwy4pTQ0unHBTLhXrjRU
         +OEXehLJmQXJPx4ZLdA2KJowRNFMXSv2tvmeHDoaf2U8MnOGneQRLIP82dSWiTT8S0Ll
         GD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772609187; x=1773213987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+ZnasW3opnYA7MfT6mnv63jy4QSymfVfISLyys32YA=;
        b=Xpyk11i/av4cgYW6/gb6NfrvXT5lyM6aPGzpro/5yzh/ig7OEwnrFP9R1Qos3r4Zj9
         5kW/sTG/2zydblyNul27bgP52+WKykfiqXl/B5Wicn6ohfhapFlRm8Q3+Lb9UAY5mj3N
         gM7lidwA2jScqjql5hcpUGeKmNvKFw8D7sJjSpcnUi/aUk4YEWubWXQjPeJYXZw+C4Pq
         01SVwZQzORfGiY925HUk+OIJAImwsH1A5SjFO+lc69x/33MeBjEG0W3CyrVm9BViVgus
         0uQIvvgydMLpFoQAiB7h3ZDwA6QDJQC/wSD72mScdY5vttkhBxM3GybefwtTg7pTkeh0
         84Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUe6aolknoPjF9gAxmp3yLjr/R7mxRyX98CobhTGGBrnr3zZEZcuLcM6txEkt7EWlIcCVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7V8V1Fbw1LKl4DMaVs1XTOShDh7z3VSVytl9U81OVnnGo3/Pb
	TD8nE7gh2Rh6+f/SuTmErWvv3yzZXCXjJ9INCveUf+9aU13n03FFIUSN
X-Gm-Gg: ATEYQzyTYk4joSEtXuGg9UHuSK+ba2mj6sZxTQXpZ8V2CP38iQzCUhLlqs2oewsrJ7H
	GsI6FXbep7Md7GAoNsrm05x15LWfsnk+m4OLWaXBflVbcNCGvNNaUYIhCcxZ4tGTouT4ix4710n
	IXvZdUxRSX030mWmsMcXY/eNHTy3I2pU3qfwNT9dbaHJrenb7+G3u2iPcsOtMtrxftque8UeDzv
	py7lw6WuONa8wj+fzKymZwhUhWRsvwI9KLVDeP6d/gYW0l/So5Fb166PfYA6f0dwS6EXjGVEWFg
	eQ1XT4DmAlf8bcSCyyolpEIlB279ub9FiRyJfqhC8Qou/pvR20yyt+vcMYpf/5xDIXxe8L99zjS
	usm0KBF9i3lY/My8gLNe/ONudQkfS1/Z+CKacL0Mue0v4Fo6eMo5x1j32V3J6AGV5fNrrW/Ra8Z
	rcBNe+5oDvNIl4G8UxyzIMEynADkf7jMFFeP4E6drKLuCvKv0fvA==
X-Received: by 2002:a05:6a21:1f88:b0:394:5721:591b with SMTP id adf61e73a8af0-3982e19b2demr1068798637.39.1772609187532;
        Tue, 03 Mar 2026 23:26:27 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c737d395271sm654989a12.19.2026.03.03.23.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:26:27 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	wangqing7171@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run3 (2)
Date: Wed,  4 Mar 2026 15:26:16 +0800
Message-Id: <20260304072616.185060-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a3e5ad.050a0220.3a55be.0056.GAE@google.com>
References: <69a3e5ad.050a0220.3a55be.0056.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0378e83b4099..b1e3e9f59930 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3783,6 +3783,8 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
 
 	bpf_probe_unregister(raw_tp->btp, raw_tp);
 	bpf_put_raw_tracepoint(raw_tp->btp);
+
+	tracepoint_synchronize_unregister();
 }
 
 static void bpf_raw_tp_link_dealloc(struct bpf_link *link)
