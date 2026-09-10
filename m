Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6213C456B
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059169; cv=none; b=KByOGcPq1iDfHSU40RVJtKrj55BU6UNJf4rObOACP08D5YI3M1Kg7TyGCc3U4nfDKIiE85NRSroo1eWtZPPOTozpi99XemkyVmrIEm/K4AQYpzmJY2yb5UKHlLQ3kGl6VXMWSkFwvhOXajf5EGHSF8KQT5Mw6UN520RfcJjIlRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059169; c=relaxed/simple;
	bh=8VTeG0Ho6cFvSJNkf54wBCx4DhvWxyo9Ru1l0bh5feY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeO2/qtjcBqMS1eGf2k3VPzpSfUR4ke3Q/z7gz4xcZucdJ6ppZrepoc7fOhW3y/jrVRUk50wapDdc7/YxdH2MgGVLa+Pnjn4hiIE8WxA0JEHphyJxCXTiV/N1XOIV8Qrl0oSv5y00/zzPHZSeTAG3LRKv6ZwoMrU+sIuukJ+n3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXzLLnmu; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXzLLnmu"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2dso27300a12.3
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789059159; x=1789663959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Zk4iEyi9QGGhchmtmeLL8zDpDHB/77Pq2fO+dXFevo=;
        b=mXzLLnmuYTaBg1Y2hU19ydNb0Rp1r7hl+NGT37OHWoYNfsR4XyEJFodvJU7isiEPzn
         oLsGnaXZ2gn8h619aIMVULGVlQr9n/bkxrdYXJOxXnhHLBXgao+1msaajKieCeirLLjD
         KgwEqQ5qPE1uL2ee4LGjrsU7cSAKzjADMBWRMGHXIa9I40VGF3o6Ro6hBHwtAoPnsrpQ
         qRrqguZnlzMzRYZ1E3GT5ejFRGTZwTQyjAP9iBjJ47VwR/IjcJRRnKuVXz/iElyj3/4u
         9teUAEMkG7KvuNMpRkfGsq/zihZrkAuTi6zxfnUriH9hUZAeBxcwDc4KmYsSTnsqI/FI
         ssQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059159; x=1789663959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Zk4iEyi9QGGhchmtmeLL8zDpDHB/77Pq2fO+dXFevo=;
        b=dczEZ3CFlZsObgyzv1RcG3s4rVZ9lAbdt/X6D4Mb5o3Iz6C0gafWw4wCQ3fZ6WFEcF
         DCUDBnt7RVjhJhiAXoNv/wq00msuX5YCBM+rajvjWW4Tu7A5UEZTgZzTNDBZrlvFtQA7
         bPbAfdPdz0MXRBanBcXKEqOtOqvdqXKeRfBN0Givk0WMwaozbLPkTkybVpdVvztIe54S
         Ft74Yf9EAqxW3GB3CqKXbG8W7+u/IGRdU+FbY24e9p0/8j/7CDKnEm5bpwfYywpHD4qT
         Ef33lCLAqu4/ByfJT4znmsrmwNhkKUrcjryj5hk6qIYz/yMvlKKb0zaUlljfZBucNaef
         owdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxX/ZNAMrsg3komBvMcIWeE5whqNAjUVoBJgxYoAZaOuAsy9Emc+bbBFlHuwaEIVEHBjNU=@vger.kernel.org
X-Gm-Message-State: AFuF++mn3cHgWm6+G2Nq2UeEbfk8kbS0ZtBq3I9XDfFADx2bm1TTviTx
	3P3bmR8GtJI2WG0AzyAbJ6jkQ3DCqLeGrXkhLWhyc18fOum8/QTlIL9t
X-Gm-Gg: AYBFou0G+kQXcf4hdsi14QGidWVcHOyjeDKrCJo8ZIispM7u0+PACYgSBGvY4Hs11Xc
	7MeKZ7lI7t0hHOVLKslf9TJ9ZPNKhP7pNLqPyACvHEvYarbFiupBkRl0uHuTUmFa/MZpwYMq+ns
	thuDhnorbAOjupktumE38dvKDVYaOVxSbUx3pCPHQOrqamyaPCRdJV2FqDPTt5ceFzmMFzuogZD
	Oeuxe9YpzeGB5wqyd9+eDfEga7FtrbwOXgbTn8x5AYF7FYTFKK+1y9DoV1I03RNC4XsVTjZFIBC
	+YperLtgEVkfNMjjUN+AY+1eEmj6iGbzrZIs3KY3uBCQGAHstKdrLSUAhgknIgos9PHAkW/I5CW
	7mTTjG1nQQ1FK/KTbyBm4HTRtTEGinnpUg128ntHUwAm+ueAXsv+iOTs2feurcV7ZTXT5mf0J/W
	MTGGJ8yShhEeFz7Ffw2z1F0+VZZne8/xXLDzejjtHLeezMvI4bEBxX0kmKH9C5PIE2McoJ4Z7cX
	6Y2gTW5MwN4LYnFJRpK+vPJusk9s14CgTPieHZauBcBRLA1Jj4WGu0uf0QOydacsOS+Boz3IL1v
X-Received: by 2002:a17:90b:5292:b0:398:e969:87ef with SMTP id 98e67ed59e1d1-39d70b7d864mr11936280a91.24.1789059159298;
        Thu, 10 Sep 2026 09:52:39 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e602d8sm64821a91.3.2026.09.10.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:52:38 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	akpm@linux-foundation.org
Cc: jolsa@kernel.org,
	ihor.solodrai@linux.dev,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	mathieu.desnoyers@efficios.com,
	hch@infradead.org,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	marscheng@google.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/2] lib/sort: Clean up sort_nonatomic() and sort_r_nonatomic()
Date: Thu, 10 Sep 2026 16:52:19 +0000
Message-ID: <20260910165222.1186628-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel/trace/bpf_trace.c is the sole remaining user of
sort_r_nonatomic(). Switch check_dup_ids() to sort_r() to match
bpf_kprobe_multi_link_attach() in the same file, which has safely
used sort_r() under the same limit (1U << 20) for 4 years.

With no users left in the tree, remove the unused sort_nonatomic() and
sort_r_nonatomic() APIs. This drops the __sort_r() wrapper and
eliminates the may_schedule branch and cond_resched() from the inner
sorting loop.
---
Changes in v2:
- Drop the already accepted arm-smmu-v3 patch.
- Convert bpf_trace.c to sort_r() instead.

Kuan-Wei Chiu (2):
  bpf: Replace sort_r_nonatomic() with sort_r() in check_dup_ids()
  Revert "lib/sort.c: add _nonatomic() variants with cond_resched()"

 include/linux/sort.h     |  11 ----
 kernel/trace/bpf_trace.c |   2 +-
 lib/sort.c               | 110 +++++++++++----------------------------
 3 files changed, 32 insertions(+), 91 deletions(-)

-- 
2.55.0.1003.g10538fe699-goog

