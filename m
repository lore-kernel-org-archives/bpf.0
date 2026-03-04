Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398033F59D
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595525; cv=none; b=Mfl2ho1v2J8woi5OlzaNpMkg7j/+MZbVACNYBKpTqawp6bVGKCuP6HqZP1AJIYhockWnWTNPYIHNclBPJEQxhsew5X/IHgrmYcRuiJRotvht2zDbVrPowwexUFiAOGYiQjS85bq4enNYXQqqMMTzYyGVe22MODNPRv19IPK0YWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595525; c=relaxed/simple;
	bh=8MaJNyR191CxvKCR93XU24t6Fvj192M1OImBTqOldyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9jUPdDEJSaq9JwVWOLxuxV1Xx6IA93bj87L/sbUaU1zjU/Befyun9h0Vj/MaFOu7Mp3Fj9P2d2ujWBngby3Oel6nYDTMl2JM5XFUhSg6Rze0co2MIPqIS1dIMW7wO8rbOOTg2J/15JZTIpiH4lLpNtMHBbDNq/SOSVPP+OC5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBV0hajB; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBV0hajB"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48069a48629so68158835e9.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 19:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772595517; x=1773200317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+ZnasW3opnYA7MfT6mnv63jy4QSymfVfISLyys32YA=;
        b=CBV0hajBtlS7icQ1+wP9wj8rZ457M19CW0/iGR2Bx5AKLYrocDWBdn/fKYkrtcRlYg
         z+cPcXF0+6399h8xyYlpGWhs85iEWPYHAOJv5T/QQdbZxydRl+sAiv2Jo/Y6+y/uYRVh
         fYT7Ddvw58EYE+dyQHJD/jN0dv2izjOdtNbrFlo1pE+2y7+jRPWL6t1HI1NnITTbrBSp
         j1ZWv5fsHrMGO72TVZudM3D91BiDjAJJdFBivpdMBDdusyv2D9rcVfSKmvpOXfLphgVf
         fCLldsFETlK13OnYIGv8iLdkaGzvmw26dhiwu9vaIbt1bjS8pORtOaLN/lFZj/BejyJ9
         ZsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595517; x=1773200317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+ZnasW3opnYA7MfT6mnv63jy4QSymfVfISLyys32YA=;
        b=cpfGomtLq+I0pkP7FF3WU5aeTiVYp29bfPqfKOgTwWiXUXVbwsUkhUZnFe4jb5ZXIO
         VjdBaFgQPdfFB5458C829RsyWMpRkBeA8nX/gXus05ZFx1egrdgJ9XA+1dV+zuGYVpc3
         dcojMU6soyBcwRxhuRpTW0lkQ7ru3lknTiTkaJpQ+4znR2CxnEIpnZwG5338LT5FNI86
         xX1fufxWHATxUHtuR33YEHOPbH7iXPTeNnQJGJH1ZaReYtZTEJHKOluPN2DtcBRGAgrk
         jk/tq7LFwE1FdqAL2SR7iQB3ycYddcHMu/yP/i6pPv+gu7kNZpHBeAGjlp8vIbJf6AOM
         ZZkg==
X-Forwarded-Encrypted: i=1; AJvYcCXTHpeX7q8+5s5o00n52TcCOQ2/ibPOuRkiMdEfu88NW+cr6UMk/05F6eMDYj54mR1XllY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3uY1QgNVdyypFADaCuS2EnLJO9wCi+7U046A6EPhuGok1MFR0
	0VFmEg31PD7LcFrmhPNx+KU1Pn3rPmEzhwe30o5xORbqqP7myt5R8JXw
X-Gm-Gg: ATEYQzwrF7oDW/z2RY5Hcq9EhUs9WgKiD46wmhfr1oX6c/QP6lqIjRyWY99zb5eQamU
	W0Hvnq54zswDscVoaqXlzytfg+rV8V21ne4kkl3ctezEDdclNeS8ti7JGIYKDhMO1MoLCkV70E4
	jJo1EdCKN58Pmf1iBug21yQcyHlrfwwiNfVrTypU45FRNgdy5NT4SjQRqhv6+MAOpuphvNhqgRv
	sg55XzSfgxHlTBYr/FqJSci7SfrZne3YVqtjkWmxBsePlmlEOK9XLfnWQ0pE5LBQgoRplhta+Om
	EoZjtRriaoNK+lA15v0WucCwbOy0IC69ovL1DPiudFOn/4j/UzJXGnlw1+mMjBedI/wVsW/R8at
	5KMfpw2gyBB7EawYFhlHsBtTXQzmAiSzDQlGryeMnC2Yhqk0heYCQn+y74RomxGl2JK8h/u0888
	FKLFOVLnmJUw3Shxu0OiWFG44l1PIa5TJqU31vqAqp8BjO3p9ctg==
X-Received: by 2002:a05:600c:45c6:b0:480:6999:27ec with SMTP id 5b1f17b1804b1-4851984b278mr8723645e9.13.1772595516894;
        Tue, 03 Mar 2026 19:38:36 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1116698sm26700792f8f.16.2026.03.03.19.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 19:38:36 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com
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
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run9
Date: Wed,  4 Mar 2026 11:38:22 +0800
Message-Id: <20260304033822.107697-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a7276a.a70a0220.b118c.0011.GAE@google.com>
References: <69a7276a.a70a0220.b118c.0011.GAE@google.com>
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
