Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0826ED2A
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164435; cv=none; b=jXqseRC973HAHkU5iXGiYsQbq/R0FFZjhsBUXyKmn9DpkoHZFmZTI1XTIQbeVrYol1nqyULfsv4PyszA7SF+PzZjjEAtznQ4XdUAkHVtplTM1UotLe4lJBgg0eXszrBDsD5RDxfPZwdA3grZba9h/W+Z1o+kgBCjiTxt+cOGBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164435; c=relaxed/simple;
	bh=zTuuLUaWX2nnbSpNamvQH8sri2HhCf5G7tUFH903TXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=POIcEcvb/HHz5K8TfXtKUiipaE4cA1Ry/oi4UCyKsP4o7LHOlDP5GW+w7FPzs5wIZW645t3fkwO7eWzCEvfa1QClMPVyc0CifI9D6Jf4KZJtNbqyoPdgnMx9sR9wTj6JItcoy0rs0uMovnFlJcptUF3TlZFJBDloSiM0mHcyqYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b79cBtnh; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b79cBtnh"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2ab46931cf1so19450715ad.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 19:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772164433; x=1772769233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwdSgM1NQbWP7Rhe378wlcNmZqA7RqveMVNj2ZfOXJQ=;
        b=b79cBtnhX5DYVf7TRGR0jTubka9G1aJBvGFK86o0gRpavdkPf5JrbuQGcogKxjU3Wg
         SwePW7ajFrxDrHH05sEsgAICPtydywgxz3ZUJIUAQo78nJhh32C+6CVrPQxxDRa+TKwd
         so52/1n3KqT6eg7X0roR+mAO0qAOors3jN4nvnpoEcfiHQe7PjyTANqlkgzMey4g21Qa
         hK3RSkGtExzUA9TdLCKrwpvKQLnhP0to/BU2ELQfE3RocbqkzG19qJOh7+BWao8Gj1Yr
         3W1BUJXgviT21caFHpehh17NraI+7WgJqnDJ0ew3AohTGRjbHCgEaQ8cZpoubcIa9ZLy
         zvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772164433; x=1772769233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pwdSgM1NQbWP7Rhe378wlcNmZqA7RqveMVNj2ZfOXJQ=;
        b=n2kz1GKOTa6znNxKY2AsFHQSS2f33KcEqiar577vYIwvjbyJirzp1ucUSNx/trxqEw
         U4Ea1Dz9rKb7f73o//5IM9n29HGGGhDQUil/QdMORc/YeHztsd/muTZzpJh2Dh6MW5Go
         Pn8p/Sgzl2wkbKbPjvuyHeF3wKWaZeAEMWFl69q2B2c8Cp/yfdSaeOjXFbGtpu/bx7M1
         sNB6R67qFZLtBNo0M3qNbhLnuexjqmRfZ0oUAaBDwhXFxeh82YcmAAdUUMFhwXT2w5bK
         fko1nLkI9lLtk2HTZalevXkoK/jsStKx7tTJO2M/rqjiXcQYmVWEngDYTdu4FQnLgCG7
         UbQA==
X-Forwarded-Encrypted: i=1; AJvYcCUuvjbPoj6l71lLNIXxCwR9RQBsr1BOJbHA3Jv6REflnTRX5tGMAJy4BM7b5ZxMyMJyCms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnIn4YJSbYIuu7zyN+2ubl2obkTxQJN4ER6LYO1JM+FbgKr6Xn
	gR0tH0nDi/fTcltWH8X5zhd8A+dsw6YMrQf1wAG0fq6CtaC65cv16Q3p
X-Gm-Gg: ATEYQzz2jdJkeZxfO9WOP+Nub//16ZUXLzTKX3FAlTsiVNpUOBo8biXDl0p2iqDkyYn
	PRg+/Q91U18guxHqRjvdbgXIWR08bg0dzajWILsy0e0Tz7hUZ6WQ5PgSAO8J9zToeuq1QttThOf
	rX37Mx/5g/SdyEdSpBzONGWaM/SrkonsgrMY+i4oU6xN7o6GGnGxX2SRewtCLlcOaJLOLsd6CSG
	uoEpZPSFcSdrBtTNJU51Fqjobig6wzK5qFvfAjQ3kFw3YxxVAzjn3eDDFHWjk6K38T16RvusKp2
	DCcWyZH/leYVc59aHbUynJ+bFQ8My4zlGhGVdrLYXBR0Jgt+tUwgTfLFEsy9y+KxagjwPhNi4KG
	Kc8od7eh1s62h0evcj9C36NUNf1jWRqCGmh5QFwOVRXee9FvO/hGxvPp0Wez+G8srsWeyi6wSdf
	4FdYiqHh5EuDORMVvLSDRDH5wXroOsDgTVfFfYgT8+8yTDfjZu1w==
X-Received: by 2002:a17:902:ea08:b0:2aa:e9f0:146c with SMTP id d9443c01a7336-2adf79cd7d5mr56815645ad.29.1772164432629;
        Thu, 26 Feb 2026 19:53:52 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c3b01sm41487125ad.31.2026.02.26.19.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 19:53:52 -0800 (PST)
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
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run3 (2)
Date: Fri, 27 Feb 2026 11:53:41 +0800
Message-Id: <20260227035341.1108372-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a0544c.050a0220.3a55be.0004.GAE@google.com>
References: <69a0544c.050a0220.3a55be.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2d14fb6d0ed0..038bf4436959 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3783,6 +3783,8 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
 
 	bpf_probe_unregister(raw_tp->btp, raw_tp);
 	bpf_put_raw_tracepoint(raw_tp->btp);
+
+	synchronize_rcu();
 }
 
 static void bpf_raw_tp_link_dealloc(struct bpf_link *link)
