Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621C285CA4
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299930; cv=none; b=QTYnBdRYQIe4rMpQIHVhmqRRJXfnfLBmSlDl+uN2xR9OlZcQSQuUpRx7ln2MCeaxs1RKPE8e9KgSmdGERf6W4stst5ekfaqbnBi5CW6jJ6xgwDkDUXlKi26rAaJzutybWNzKFEWwmf7UO1XgKilnlGDKy5jXxUB1Ayf7SHtTZWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299930; c=relaxed/simple;
	bh=3W2qsB01EVLuBJUcdx+icsHw8H5k5NDhkucaHGNVIrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nt69TsK+KOI7pqMnXxMZVkxn6F3/a99QHGoJdBuZlN8UVNare2UaHZB189GyWXGvcwx6crBC2yiErSrwJfKfTKEHEdkbKJdrroa7my86VDOaS9AJVw4ivHHG71yfYG+4tsjzII6qEf6YfPe2qewDRugiWxxF3Le1gY/B2elrnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLXk+3tr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLXk+3tr"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso512335a91.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 04:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782299929; x=1782904729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k2ugntTRhaMmg6Rq7nEjHmb0/Nlk4n5kF2nW1NYPQfU=;
        b=dLXk+3trHHPQX6zSPC3i4FwQqp2IXUyqwMc/dTQPf9bfg0zxBYHCuc59u/o1YrcdPM
         aFKRte/853MVA8i7DHuEu2smiO8nduRHspvlX7Y+BcQMFmP8MJ1V7DaIizTaqYrmruez
         GkhGDNyMX6tnFfZwzC3rdq9Loz9VeMPIKFof8RAD/Q21jAKvl0AgadWq8c2Y3b+tfXzU
         7/I4arn1o2fJBA0TQrgvtUI953ouapR3JWwKLWlF1wP+T7TAA+U2OZumWpIH7K1ruJrh
         ia/MRQEc8qT76c76gsAEQAGnPCTvyiFML5PbYUX5CSEcdb3T6MBxq+50PXGzWXKH21SC
         WGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782299929; x=1782904729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2ugntTRhaMmg6Rq7nEjHmb0/Nlk4n5kF2nW1NYPQfU=;
        b=ViYg0LBopgKYxBqHBP6CAZZ5TvNSN5MrsIGqDqLRU1uimBZVT6ql5Job374wRGaKva
         ntav+suIC9XnK/naQT1xahvn69uSdi52A3awn8cWieKLnrLtQcb68GsoXrc5YPlSRq57
         yKJTmWtOfQMV8avkWTtVA+0AvN1CeuBlfTinPk1yjP7Xsfz/nWcuxM57438f9VeH+3e6
         nNbjUobrhnodXrhvgMM5LT7T644yCI6r8DBsNP8hPY6U8Q2CSLzMg4DjQG9qLN13K2PD
         g6RYyx0djD9Cv7wT84mjNX7ap/lbduF7V2/VWg9uKVzqJJdCbpq4Be4CMXQQDj3rxXzb
         jU1A==
X-Gm-Message-State: AOJu0Yzvmu0nKVnlg2wm7ncyE2sy7IQgkjrKvlI8EWV3EGCcS4BzqL4k
	5JjvsEJ2miZnDySRMf0/G6vtdQ4NVmErZ9+ihuAq6xkStPQ+6WXuoFE7kPq9d00uYFFO6g==
X-Gm-Gg: AfdE7cki5Fj3x03GPlknhGf+hpjEvMvTksMxxANnCZ4laYWvnibexxYfWJuqMo/c2lX
	8rLfDckJDiMA0jlXpxMOeQ/nyc0Zcj+hooCQOWDMNlbVoAysRDGwpSg0SrsaUXRZG+yXeOxwWhP
	UcZuJ++slzwiLBtl47lyEuNU5H4XwIXDsELSQvm4vGPfH68KEHW7QEPCNpjIQq0wnMYx9oY1eUy
	yzkw+rlClCvD3ijigCuOJVjKbRPhHHoe40nJs+cOLF90hfq5n786wqFJMfeduJEm9hM7SHBBVtq
	JUiGkSpwqs+XqFeMMZWyAoFvv8f0aPY3XYEMAwUVqWCWHoj8eOHZ+D2/7XgeLYQM900/MH/iTTJ
	o5J6mnNVR7R5zLwwb53yK6vKK/pMxLiloiqdeMx5sGpbDuLRzKXecw/Wb9sTwD3URbR8fEyM37y
	XrJdcUrdH8vjZBbc1/zevEbjHPfaDevcjpoS0tbbLytkVrS9kitQ48WOVsIvMY7aGKR3i6djiLK
	x0LriDpAzdAttjcZx9LHlYIH2Q=
X-Received: by 2002:a17:90b:580f:b0:366:132:fda6 with SMTP id 98e67ed59e1d1-37dd0d4c3acmr7879930a91.11.1782299928661;
        Wed, 24 Jun 2026 04:18:48 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([202.8.105.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3aa1b1csm2290385a91.5.2026.06.24.04.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 04:18:48 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf 1/2] bpf: Preserve link info metadata on ENOSPC
Date: Wed, 24 Jun 2026 19:18:36 +0800
Message-ID: <20260624111837.889209-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_OBJ_GET_INFO_BY_FD for bpf_link copies struct bpf_link_info back to
userspace only when ->fill_link_info() succeeds. Some link info providers,
however, can return -ENOSPC after computing valid metadata when a nested
userspace output buffer is too small.

For example, perf event tracepoint link info can determine the required
tp_name length before copying the name fails with -ENOSPC. The current
top-level error handling returns immediately in that case, so userspace
observes -ENOSPC but loses the metadata needed to retry with a sufficiently
large buffer.

Allow bpf_link_get_info_by_fd() to copy the top-level bpf_link_info back
on -ENOSPC, while still returning -ENOSPC to userspace. Also let perf
event kprobe, uprobe, and tracepoint link info fill their metadata before
returning -ENOSPC from nested name buffer copying.

Fixes: f2e10bff16a0 ("bpf: Add support for BPF_OBJ_GET_INFO_BY_FD for bpf_link")
Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/syscall.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6db306d23b47..80ab02b1c813 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4060,7 +4060,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 	ulen = info->perf_event.kprobe.name_len;
 	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &addr,
 					&type, &missed);
-	if (err)
+	if (err && err != -ENOSPC)
 		return err;
 	if (type == BPF_FD_TYPE_KRETPROBE)
 		info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
@@ -4073,7 +4073,7 @@ static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
 		addr = 0;
 	info->perf_event.kprobe.addr = addr;
 	info->perf_event.kprobe.cookie = event->bpf_cookie;
-	return 0;
+	return err;
 }
 
 static void bpf_perf_link_fdinfo_kprobe(const struct perf_event *event,
@@ -4116,7 +4116,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 	ulen = info->perf_event.uprobe.name_len;
 	err = bpf_perf_link_fill_common(event, uname, &ulen, &offset, &ref_ctr_offset,
 					&type, NULL);
-	if (err)
+	if (err && err != -ENOSPC)
 		return err;
 
 	if (type == BPF_FD_TYPE_URETPROBE)
@@ -4127,7 +4127,7 @@ static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
 	info->perf_event.uprobe.offset = offset;
 	info->perf_event.uprobe.cookie = event->bpf_cookie;
 	info->perf_event.uprobe.ref_ctr_offset = ref_ctr_offset;
-	return 0;
+	return err;
 }
 
 static void bpf_perf_link_fdinfo_uprobe(const struct perf_event *event,
@@ -4180,13 +4180,13 @@ static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
 	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
 	ulen = info->perf_event.tracepoint.name_len;
 	err = bpf_perf_link_fill_common(event, uname, &ulen, NULL, NULL, NULL, NULL);
-	if (err)
+	if (err && err != -ENOSPC)
 		return err;
 
 	info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
 	info->perf_event.tracepoint.name_len = ulen;
 	info->perf_event.tracepoint.cookie = event->bpf_cookie;
-	return 0;
+	return err;
 }
 
 static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
@@ -5536,7 +5536,7 @@ static int bpf_link_get_info_by_fd(struct file *file,
 	struct bpf_link_info __user *uinfo = u64_to_user_ptr(attr->info.info);
 	struct bpf_link_info info;
 	u32 info_len = attr->info.info_len;
-	int err;
+	int err = 0;
 
 	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
 	if (err)
@@ -5554,7 +5554,7 @@ static int bpf_link_get_info_by_fd(struct file *file,
 
 	if (link->ops->fill_link_info) {
 		err = link->ops->fill_link_info(link, &info);
-		if (err)
+		if (err && err != -ENOSPC)
 			return err;
 	}
 
@@ -5562,7 +5562,7 @@ static int bpf_link_get_info_by_fd(struct file *file,
 	    put_user(info_len, &uattr->info.info_len))
 		return -EFAULT;
 
-	return 0;
+	return err;
 }
 
 
-- 
2.43.0

