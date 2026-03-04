Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A4364948
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772595254; cv=none; b=XQK4BjPMIus4/E+8lub1mSDV4Peugy6/PtGrnxC0Ryii3SmL13Q72o6a4mKucelhlQxb/OMpXhpdSDXHdg35bCu1ZHlr820o9kyY39e6roMrHmnnM6v8miBoEAXv9nYz4ZmQJ3e8ItbH9wgUH0/GNXDOO7KE1agRCE28uIY/KSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772595254; c=relaxed/simple;
	bh=qTZPgwQFfZF726H2LsPRAZjxMzMORAsQg3BbKIyncXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HsliYnR+LntpKOBzQip9yERwAGExDERDeromoOYAuoZUNUJDqodtfGRrpZFvSN2X0ZUTEfphU6pX0t67tC+c47Iz2owROFEHDH0IhHg3wtATIHps5XUEQRmq03w0a+ls6anjf1QNQwlld128rzR5tf4iXI+CSt+4Jtkh/mx0LE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bloeOm4E; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bloeOm4E"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48375f1defeso47711435e9.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 19:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772595252; x=1773200052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VhA+A0/NyLxM6CBEmmYDuFUudcfDtb7OxH4QUWLpnc=;
        b=bloeOm4E79dDRogp+SDtf2SvOsQnyEGMGZ4hW7xv2AVagVIBzfkKqVBN9kVrGPcg6L
         5J34TmjiC/fOOOX9sgV2C6EdfBTJG5at7iVV/pNYNijrEfWE6gPnpTa1LW7aMW2Q/r9m
         tJ2QMUkYvBZT4mUaJGFaUESFa+U8VkIRSBp3Jj5lPX0h4x/mRW8v19XVVvOY5HvSIe/d
         jPB4adVjuAn/2TGbwmszNfxkXhScpD/f7MLXzZYr+a+OtfS+ykgC+GQCJpEAXucmqju4
         S4vqhl5rUb0/NRhz5EaWAsBaZfwxiHt9IeO1T/l6N/A0C9Zt24Xv0q7aLS5O9DtsOe2o
         41LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772595252; x=1773200052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/VhA+A0/NyLxM6CBEmmYDuFUudcfDtb7OxH4QUWLpnc=;
        b=PU3Re8cC2Ufttun8BXG1CpMeK+WJpL0MyDZYFShqb9uEUbiswFDIFEzRUNNKS0YcPS
         cz6L7q6VT8kvNXeP5umkxtVWkCYyHe9bwUfkmaqHp6lUCn5gWOpoF8rb0u4X7Kb/DWL6
         D+amQTh7i9KGAlQO5znfp1T27s/EgerJQWR+uS8DISBzUFJispaEWQo1R6m/0fY8XD1v
         Kn/ci0lgHnhzhizMrQuevmWPNeaMseDkiOzB0F74/8InLilsjrfpdxHJtsmigk0J3Efo
         bymg3hAajHO4LzJiqxd/Sc9BX14XLmLJmIa3AQAc+HceNXPl916jh4fcYfdysjyFxP3N
         5HOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnNL9SQx/gSsWhgSw9yxpQSubi2Y1Gn3xLrjDEJlc0lRHmxvkcJdqv9Ez1jbARxsJ8ORA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dhcvSy9bSf9Abyvo/MJyVgbFc6977JDC+A5LTJCbCO9vDwmh
	v3KqH6TPVgJdg8uO3H4Fxy+6TrWntjNbCdVzDwd1VI7WWmecL2YWL2rE
X-Gm-Gg: ATEYQzwrsCwIODGxzPC+da940FPlcj5ThnWmD1UVj/pYpZYxUFqws4LbZK5i24DcWXu
	/hL/JID8cagCgYclQ3kvk8rSTC4HdAXVrMoYeqJAalaSkofPm3UOgtwpWyN7aTsCsd2R8VoeoQb
	NXrD3ZVg5sNn81oOlSOiZUQLaHxEjUTb7zFdJaSiNMde/WsfeaeSP7kHlbFFLJ1Ww/Zn5K27T71
	JfawW5wbuS3r9xApFyfR07DfwblS1kBktfkuq4pWKAzuMBTsM99HzriluHBnZVJNQYJa1ppelXd
	ZZQAd8r4jE1BMuIsxZU7KqCe7SjZsBJuJRWr3jRFxtu3l3evxqw0T57lMZdAgbybLgEzE04lXfD
	3U2huzUI4oO51UrrI+0WaMw3ZJ6LYCrx/Jx83zsntx1QOLoiTRz8niey99zkRjwHAQXftu4gl59
	igTOLoQJtQQ+qGTAs0xjqlKQfKhvdKcIk7/DHGJQ77NaydQp8H0WDwiFhNioh0
X-Received: by 2002:a05:600c:1d06:b0:483:b01c:9508 with SMTP id 5b1f17b1804b1-4851983c5fdmr7534685e9.2.1772595251618;
        Tue, 03 Mar 2026 19:34:11 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b3cc2e65sm23654265f8f.2.2026.03.03.19.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 19:34:11 -0800 (PST)
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
Date: Wed,  4 Mar 2026 11:33:57 +0800
Message-Id: <20260304033357.105915-1-wangqing7171@gmail.com>
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
