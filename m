Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288321362
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356577; cv=none; b=flkEZgjODxCJ4npMS9Uj+EcmlRb21FGDNlp5L9utmxPp1huCi/8+M+KGEmJ8HnOnBTmW466MQRycrhoCoaXwqxv/W5gpnRMW4SZAiyysdygzUKXpR0HBeUTzWq6IdWoN2xY15dwKBjO24IFSVjnrOl1m3NiLb4Q+ldNyF5h5JNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356577; c=relaxed/simple;
	bh=/px09ujzAHJr7wkYdKqkViF89YvaXMh7Oizbh/L9Ky0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8rK7yy4bFte+9+eJAvf4O931CKxS8mBNF48bgg1KDHHh4zysPc3pOgjxLUwq4OT0nAXRYIUIphrT+t3tm3zca73V7roh6dsqGX0W/6JpP/BjTWVVrG4flg5QuL4a041vnzmLgz1hfFsh8ysR1WU3q3Y9kjRAfanU3uZhNdEodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GXBramXj; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GXBramXj"
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 127993F231
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 22:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712356563;
	bh=fSrDD1m/j/08PTY1wUCU2vVtrS5jJDIUizunq/Dwn6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=GXBramXjWBwNkGQ6YEI1Jk/ngqaO+CqcZaF79IOC69bM6yhW2EjuBec4PJvDXvF/M
	 NzlgoAluRvYzzecqw5yxxWlXla6VVQ09/Xksi+uraI5y/6Yp1sCcpdPsR8L+IX2Nc5
	 Sa59qcXX+UYFO45WzodkUyrmyoMTruq7BLk4HCYm4aFWDl/AqyM4yYGcTovU+zosGN
	 h2omRIr9Gl/CsUOr50FA7BedPUXL+lW9mAoA/Nh8Sr0HeMPjL69Qpsy7qhZlbua+Qg
	 2mItSKdbszNmDySVGiyfhXPu9JCDom973whhjE+em+y84vhAyMQxpE/6gGpPZ+E0zR
	 hNbRoYpbpRn0A==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4162b93067dso10574455e9.3
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 15:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712356561; x=1712961361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSrDD1m/j/08PTY1wUCU2vVtrS5jJDIUizunq/Dwn6s=;
        b=LsMo7OhnSlwel4uxFvTJXxKD5dV03rAKW44h950f9xLmt2a18T+wK/5evHEllgxt0I
         HzHnjtN7vWfyHsQE1ogcCqMz5Drt6LkUSelYTBoDs4j8Z8vg3Ibi1RSnW1FClJLq54+U
         qH/l+ezUgbdaRoFLfzr2cVQuGL6G0Uy6++n157RVci1VNYJ1wXitW5PcWJc7Hroluua0
         iExc/G6m2xEwHNGhxaLV5XM6b5A5IyA0l2aOKgmiH0l4VI8ba8bZ4zaO/JJ73ae0pDF0
         1PZ6OskgG5cki0LdoPlFV7Gvu1pgGbKFMoEicWT+wrtNDp2SY7zu4dXQeAGsAsDuas3n
         bjqw==
X-Forwarded-Encrypted: i=1; AJvYcCVYLWQE8OSkvsAWdGT0MUs5UvQ2enF0oVn+7IczxyLqQSatmW8yWbVia35I1Rmbq/f96xiC1MkwRbGkH9D9p9e6OUyw
X-Gm-Message-State: AOJu0YzFI3DyrR3R2mAMEGRp7iWN26faQNvrwvVocaoodZ76rEL7mzO/
	5uHbGEbhCUTjrzP4xejQAhg8P6Ofi1wv62TUrq1DirFpixO/kbGl2l1FA8krYhTsFpLZXK70AUr
	fWUPCc4mhLHjsvAyCUcnw9VVTFX5aWKwbwSIIZSGBAZVO/ldDvIriHXxavOSSOOKlEA==
X-Received: by 2002:a05:600c:19c6:b0:414:6ee:a37e with SMTP id u6-20020a05600c19c600b0041406eea37emr1931738wmq.19.1712356560902;
        Fri, 05 Apr 2024 15:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFQ6g1NqU4K3c/Xc3WNJ6JUvle0WbR6bLipgaKBNr4stR/TDUIEuDx9Uy0DMzD+l+UwmWExQ==
X-Received: by 2002:a05:600c:19c6:b0:414:6ee:a37e with SMTP id u6-20020a05600c19c600b0041406eea37emr1931729wmq.19.1712356560354;
        Fri, 05 Apr 2024 15:36:00 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b004163334df40sm1475698wmb.19.2024.04.05.15.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 15:36:00 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] libbpf: API to partially consume items from ringbuffer
Date: Sat,  6 Apr 2024 00:16:03 +0200
Message-ID: <20240405223556.11142-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ring__consume_n() and ring_buffer__consume_n() API to
partially consume items from one (or more) ringbuffer(s).

This can be useful, for example, to consume just a single item or when
we need to copy multiple items to a limited user-space buffer from the
ringbuffer callback.

Practical example (where this API can be used):
https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd8683a55/rust/scx_rustland_core/src/bpf.rs#L217

See also:
https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T/#u

[ Note: I haven't implemented the special case of n == 0 as "no limit",
because we still need to add a bunch of extra checks for INT_MAX, making
the code less readable and, from a performance perspective, it seems
that we may get more downsides than benefits, but I can try to look more
at this if you think it's worth it ]

v3:
 - rename ring__consume_max() -> ring__consume_n() and
   ring_buffer__consume_max() -> ring_buffer__consume_n()
 - add new API to a new 1.5.0 cycle
 - fixed minor nits / comments

v2:
 - introduce a new API instead of changing the callback's retcode
   behavior

Andrea Righi (2):
      libbpf: ringbuf: allow to consume up to a certain amount of items
      libbpf: Add ring__consume_n / ring_buffer__consume_n

 tools/lib/bpf/libbpf.h   | 12 ++++++++++
 tools/lib/bpf/libbpf.map |  6 +++++
 tools/lib/bpf/ringbuf.c  | 59 ++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 67 insertions(+), 10 deletions(-)
