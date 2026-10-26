Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983933;
	b=sbISXpu1+35ZQqO3AOuyabq437mJ+AplUrRIujepZI70WtP62gmq6mNdNaY5UqI/b7Tw
	 mmjA8wz6VfzfMtuJoeUbl5bHrXs4rcronzv8bUnClLFi2km4NUGUjCG99MOwAmkDH63Rv
	 lj1L++Yp4g8nBvJNzpaWUm96KmnjTZ2myjUSFl1sVhyRqr6n09gZtzTvhiJ5l0nUHqDEG
	 jUiEvadSfHpRJFymHHLfzjwVPHJ04sRBbMjWsbfIFhdNEcJlvc7j1ik+4ALiQzuDEK8Eo
	 2BeYQNrFZ4oldhEK/9laTjCVeLBcXnYJ0BeIwoTmqByED9UkKy1ZYmxNcZIlV2Kf62g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/1Mp/J7iho47emwpMUtQWBvYkNZG3D9y+8mz2hGGGDU=;
	b=I6tzWEffwOM7u4pojAwmKk8yYPK1MCrJaRk+ypOh5jFC4F/jb3vJvXV5t8vgsAjT6WjH
	 6I3f7XWHJDnC34iR2Jb5k58wtbplTYplDvAriS+NVD/RxPJYaGDLZqglgP84Cjz2CuViV
	 2bb1J5eKXRVBCjNV5yaUbhLvtk118AVSxnhMZrHVZBtmCCtMiuybb6yW/+LSIXKmHKeSz
	 nBAgBPj9muRxxvTkMRDhEPhfpqWQenl/G37JTvxwTgy950REsE2KqmqRmX9z1xdah/gcq
	 kSzgPTXrvgtEFN17+BauJvWXauzyZ7gqpRB2+fDl25t6ZwFUiA8piFW2XYUD4KU9FVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g9xd9AFK;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1A606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0A1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g9xd9AFK
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso12918275ad.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983932; x=1793588732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/1Mp/J7iho47emwpMUtQWBvYkNZG3D9y+8mz2hGGGDU=;
        b=g9xd9AFKOq9MosVO+Fxhx3vfd+IXD2eLojhq7poKzGTqRLRF9hlPhsM8JAuALy+ytz
         C+ZU2heHA5M7MppI9nJJXvIw/UV+3m493mCwXeBIPDfcZH7ept/qdk92O3sdB3A+pJM+
         HBKI1xBLVOaKQdzSFku2sI+mQANqxHyNBSLbHH7K0lSo4Nf5/JOFwV/cWO7eysglVHaA
         8JZpLarFYfmW5hIfx0qbTmIeZjwmagV0mVNP8amyotCwwdHaENMAE0z5vnylfmc1hbFz
         VaSPEHIUh1yUQ9wjChHopdnN88GGR3G8LAbATjmnK2pO8HcI0/lm1pPr4b0DsMxd6D3q
         3Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983932; x=1793588732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/1Mp/J7iho47emwpMUtQWBvYkNZG3D9y+8mz2hGGGDU=;
        b=gUd1K/atDBwrQN7ZBgv2Ho4fNNN25SCmI5ghJ1i7z8XMIU7ovBbn21XOxvC3K+52PP
         1DSp7NBXNXKeXhkvjLgr2MiZj6y77tsDLxxIHIxr2T+xWwbFI3Ij1YvRcAQ/4GQUK81L
         /ZiiLOoMeBY6aBOXv/3SESsZtgaBC4+nfpqOuca7o5cjKNCxLBdGBnbZLlATvmV2RDfr
         PBQpHqWe7UA9heGs3CYMDIWPg7psxIo34gzPXArowa524IbFySrsUYz4VLBAFe5BwM0W
         gwzNhSDO9sV7rGSSsbdnvlhkZ9d7BhSaWrsYT5bKrq/KM/iCBtbet7EbM2Kixfz5QHSD
         +ghA==
X-Gm-Message-State: AFq9FYIUyi8y3tINS5jRlNc3yWzASx8Jed+xP4eQI+/20CswBxSCYuDY
	QRWOC2So1V2rYzDxJgi+fdSuWebJJey5lsRruwL6tIYFjJn9mLWa0cDe13B9bw==
X-Gm-Gg: AYBFou0ih1m3E5WUGU3giN53YNp+SMEFgqkm/kFWKFIj9U4XVvYxcAAJZeE2tfV/njg
	Peu15PNYUJSAZfH5uQx5t3aeVYyWy14Z7yI3yu5g3G2Cb+P3AbnQzvqBYx+mmKEitq5kSfLLm6X
	9VnlYWN2kE9PIFvMnfZFYo3Jq7QOjquLfPuNqxF6ze7IfPhv4nwiM1F93sM86zJoGDvS2ZLgisQ
	3xtK1qmhYmZ23/kN5QtO3e9L8TQ4IYeck+pVqjUIk2jwjbLS/YQgKZkxy2N7lXC1M1aPepqCBLr
	VTPZKTdMizcSBGBCoFKqC0UCx7Py2Zd5AKVAu78LflwvLlxUGOMKKiBRndEL+UOjExhwUGioUdC
	Z8booICVobTFAB40gd39rlCYd+z3L82jdKrI7MDsMxFxpi0coVDM4kATCI3gp5RTS2YmvF/z1M1
	cBl9xFlPgIx7jKPq8Adl+IFlRwAGwkEy92kjvrK14+KWH3Cwj0A08jb4DbNivIJgbgKLEhHXgb7
	qyMaDBxD6BzV3YGWYLngBzi80ndNd4elCsDmF9Zj7ppeNeBkkYygX/XbcRGLhAoAFrfYdnQ4CVn
	50y3h89IeX10ImLCeX6hwS03J1gjLQPA72NB+Tk6XXhkUw1/Ve6/M9n+njU5zgSKXebBnPV+hsi
	c09bHp/zDrSpvkFGJRLwBbp97
X-Received: by 2002:a17:902:ce0d:b0:2e8:e617:18 with SMTP id d9443c01a7336-2ea9c84f540mr44315415ad.48.1792983931784;
        Sun, 25 Oct 2026 20:05:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9af31421sm10807205ad.7.2026.10.25.20.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:05:31 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 59/81] selftests/bpf: Make room in veristat for the stats of 1024 subprogs
Date: Mon, 26 Oct 2026 02:59:20 +0000
Message-ID: <20261026025943.404450-60-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

veristat reads the statistics at the end of the verifier log. They have one
line for each subprog. Two sizes in veristat are too small now that a prog
can have 1024 subprogs.

  size                    old   new    problem with the old size
  ----------------------  ----  -----  ----------------------------------
  log buffer              64K   1M     777 subprogs make 82K of stats.
                                       The load fails with ENOSPC.
  lines that veristat     300   1100   With more than 296 subprogs it
  parses, from the end                 does not find 'verification time'.
                                       The duration is 0.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 9cfc9b4b41c1..6b295e7d6f32 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1013,10 +1013,11 @@ static void free_verif_stats(struct verif_stats *stats, size_t stat_cnt)
 	free(stats);
 }
 
-static char verif_log_buf[64 * 1024];
+/* the stats have a line for every subprog, with its name */
+static char verif_log_buf[1024 * 1024];
 
-/* Keep room for all 256 subprogram records and trailing statistics. */
-#define MAX_PARSED_LOG_LINES 300
+/* Keep room for all 1024 subprogram records and trailing statistics. */
+#define MAX_PARSED_LOG_LINES 1100
 
 static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *s)
 {
-- 
2.55.0

