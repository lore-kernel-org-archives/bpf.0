Received: from mail-ed2-f29.google.com (mail-ed2-f29.google.com [74.125.228.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299A2BE630
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 00:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790554543; cv=none; b=nN1I6PW69JALE23MVJUCjx8kV10mv2bmfnMvDCZ9YAMOT9J6HfFfkbGDexKLfuH7SvzXU1xtYtvqogMXPvVfxTlBvEIjVTnBdQoJdFul/H8e0en9+LEfmaT9ZAltAQqhof786QgiK8dLBztSyq7YVrYMUAOwsuXQnO194bDfx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790554543; c=relaxed/simple;
	bh=n8K0NwHICEBvM67S1D/cOrMe6EYu6MSmR4GKAVOp6n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+jw03ZGJKt1DR6pJ11OebqUbRfXxO944Mogf1LK7A45S1H5QAlIz1JZORz1AgcGB+O+p2LK2FXXtLaYtNI/NnicuwE5EQMDBie2D3ayIJxrCgpaGWbEY9LDFG6TrJDxrS5mv4xzu91I8PcqBKGT6nxu4sDiZWM8WJLqdjRHZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5Pb8qMh; arc=none smtp.client-ip=74.125.228.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5Pb8qMh"
Received: by mail-ed2-f29.google.com with SMTP id 4fb4d7f45d1cf-6aa0ee64afdso2787859a12.0
        for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 17:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790554537; x=1791159337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=01is61vUaZrXog5DXCmETdHVbSNCdTQ8jIFD6DQpolQ=;
        b=s5Pb8qMhwhoXFCiJFyL83swxCPY3Aej6aYlyBmjOM9CMMpyyCbbyWxglT3Z3Bv8+bH
         wbRHnQ3le2BWavGLc+IZnOLeF6AaPDjK/dFjeapXT/JP1WhmZUyjqcLzGf6olRX9uFa1
         QoluyRU/T+YWYdy6uG3R7hZje+i3342TtLEwdOvL0RrLcoYB/Ne1KIJCEK4meQY4tZew
         cI/nEHlplGLNqRLmy2egTw0b939/axJ891w99AF7We1Mnh0pbMWY679yUdfQXzpgdrKR
         tQ0do2AUCk2+VW6XqpRfpsoYet/rM93iLwopwR7WhFBGjHg9XzoLw3sC8+4Jg0/CwXeS
         7UQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790554537; x=1791159337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=01is61vUaZrXog5DXCmETdHVbSNCdTQ8jIFD6DQpolQ=;
        b=AgYh9/wvr62mmLEfakl950mbi8tYoOOHnRYVif19S2P8XyK1Wkv7DhQpIvTPlEkTzc
         lwcd0rAnmSJWGiVphXSXoK5C8K+swP9Rcbir5Ev55MqjEGcdBIf5nXKcHBENYxkl4zF6
         opx6COX2iraX2eEHm+lmSjy4Ja6JdZlBBj89I536qUyZwJkCWCcqnW4/bA6lbMp6xopC
         h0G7KtDhLtC7KdpkfDjUp++9Ean6wwosFMeet5wNpps853Wd8W6uGw+Sjd3WsMcRRyoK
         0MNpjZR5hfBEGsNRAvehG+hvK5OE+TswfBqss6viDdyAzMkXrxduFT23DTpBxUBKBYwT
         d0CA==
X-Gm-Message-State: AFq9FYLErCZKXA4ARndYDbtl3oULtN5RgMOmAaA+aGZpwNlq1J1NhXjJ
	z88VUhNPrHPuqksPXYaoS3zAa8Os6FQgeOzX+xPq7VwM2o8ksQq7Ufki+FUkDyIK17s=
X-Gm-Gg: AYBFou3nHcogockwyYJWWPuasd1fX4aeD4mBzp3rzLxWzZSHq2mKNsL5y5EQeaVFp5j
	ZPFkhYCBazOEBRvb9FSiJ9HRSqST+XMI+mpHcSeUjzdCEiQ+7/hLrpz0YbK8Eu2YXUq/qX1DyPD
	sueA4UlJPFgRaVwqNb9KmH8J+h96d79ymv27A7x4dIQ9I4ci0cnmHup2DOJrZPTif4mpGD165/+
	ndSqpAoQ+kmYBJUuz1gMPyeunaoXyADHmtxA94SnRYvJ40LQAsJLM0EPGfr3ca0VBgP6ny4T+Lg
	1r8G+W/Rs8CEHMWqXWmmaki2sLgDgGzT8E1A2ZGGhjo+J4lyJ0d8tkzQi8t9bFVuzOqPEWJDjH8
	XWvhsQ1yI2KMEdgz6BX96i1Q+fEW4pOZI6PflYFrjtpySYhxzFwNt5ocWil3ivIddHwhUZdc9Aw
	EE2w/8lksJqB+sRovrL6nhXFgAPUhdnE8XtS+XT9FTbeaueCqkBoC6V81jkuVdn3oYdjWt7AmbS
	j0hmHE1JFZ6NC7JAPFkQR9nTg==
X-Received: by 2002:a05:6402:2406:b0:6aa:734b:1a2d with SMTP id 4fb4d7f45d1cf-6aac908f34amr8830827a12.39.1790554536751;
        Sun, 27 Sep 2026 17:15:36 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.99])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ab5be57b13sm1933955a12.33.2026.09.27.17.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 17:15:35 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: [PATCH bpf-next v4 1/2] bpftool: Fail map dump for maps that can't be iterated
Date: Mon, 28 Sep 2026 03:15:07 +0300
Message-ID: <20260928001513.7072-2-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928001513.7072-1-skokovmaksimevg@gmail.com>
References: <20260928001513.7072-1-skokovmaksimevg@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bpftool map dump" walks the map with bpf_map_get_next_key() and treats
ENOENT as the end of the map. Map types that can't be iterated fail that
call on the very first key: local storage and ringbuf with ENOTSUPP,
bloom filter and arena with EOPNOTSUPP, queue and stack with EINVAL.
bpftool then ends the walk without a word and prints what it prints for
an empty map, "[]" with BTF or "Found 0 elements" without, and only the
exit status tells that the map was not read. On a socket storage map
that holds storage for a socket:

  # bpftool map dump pinned /sys/fs/bpf/sk_storage
  []

Ask for the first key before printing anything, and when that fails with
anything but ENOENT, fail with the map type and the error instead of a
dump:

  # bpftool map dump pinned /sys/fs/bpf/sk_storage
  Error: can't dump sk_storage map: Unknown error 524
  # bpftool -j map dump pinned /sys/fs/bpf/sk_storage
  {"error":"can't dump sk_storage map: Unknown error 524"}

An error later in the walk is now reported too, as "bpftool map getnext"
reports it, and the element count is printed only after a complete walk.

Assisted-by: LLM
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
Acked-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/map.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 20d59eab09a12..b7f62fcbb6fca 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -856,6 +856,22 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		}
 	}
 
+	/* Fail early to avoid an empty dump if map type cannot be iterated */
+	if (bpf_map_get_next_key(fd, NULL, key) && errno != ENOENT) {
+		const char *map_type_str;
+		int saved_errno = errno;
+
+		map_type_str = libbpf_bpf_map_type_str(info->type);
+		if (map_type_str)
+			p_err("can't dump %s map: %s", map_type_str,
+			      strerror(saved_errno));
+		else
+			p_err("can't dump map of type %u: %s", info->type,
+			      strerror(saved_errno));
+		err = -1;
+		goto exit_free;
+	}
+
 	if (wtr) {
 		err = get_map_kv_btf(info, &btf);
 		if (err) {
@@ -883,8 +899,11 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	while (true) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
-			if (errno == ENOENT)
+			if (errno == ENOENT) {
 				err = 0;
+				break;
+			}
+			p_err("can't get next key: %s", strerror(errno));
 			break;
 		}
 		if (!dump_map_elem(fd, key, value, info, btf, wtr,
@@ -897,7 +916,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		jsonw_end_array(wtr);	/* elements */
 		if (show_header)
 			jsonw_end_object(wtr);	/* map object */
-	} else {
+	} else if (!err) {
 		printf("Found %u element%s\n", num_elems,
 		       num_elems != 1 ? "s" : "");
 	}
-- 
2.47.3

