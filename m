Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7217372049
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790442139; cv=none; b=PHwu1zTL4Hg7h2cMeuLoCfYW86KS0G+t9iseSWSg63kaT4I1LC3KxlgvQbvtEe7ei7AEndSFGjHx3kMGMPMZ2cbc9DuYBhFVYBQXdYzWWptr4rWjuk3SSVQFMFP9bnyDd+3x0Pq84ZiIgwYdgL8TeFZxQfC3NSp+Tgkc+WaG/fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790442139; c=relaxed/simple;
	bh=zJF4sscpF1aQho/bRZ/pm9XthLOuzMaUDPLUWBgHDD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEiB5h5K61YCvT02iXUro8nVH3wSpCn/dac4DRa4Xl4LHYTyDA/vWDZEfdCqqEURvGvnfgZh1zcae3rP6FetrjRfWk3p/kQs3+5DDXKWxbMCaDjriF7zEPX4dS9FydwqR7R2ixOlQwvEb2hh0RL8GCi4xLADZjFIGQ5782ZvqYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNEIYzjp; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNEIYzjp"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c7a1aeecso1594856e87.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790442136; x=1791046936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikRv2horgnDI807qoA7PJBJJX5O1tS+tzE6IfcIPsw8=;
        b=jNEIYzjpG4Mt5KrBZJ8o0rFaaMQrATb3Hu5pY08zb/2emH0+OHEA9NtRmTftIhGNMP
         eDc3LMAK09SwtZ5O3eD6FT4vT6Igpr3N+ihTjPxFFlbhvvZVJ5qsfxBXHHDIggI9VpId
         XaEFf+CY3EW2JW7MzpJZWnLHcELAXjpvTi8wD5Z1SnFqnvcL/AEAelB6wzonA0KbUL0k
         YOvjyHWCNnW3RYmhOFuQ1epZPFgI4eC22Tw7qn9+hilv6EYF6nrBButaxmFnptqGjnXW
         a8xVTNIczvVRUzO2Hs/66lrNATSSctTbdLdVXHu1Em/6DbAidOpNuKwz1QBh9ydKrTJv
         UQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790442136; x=1791046936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ikRv2horgnDI807qoA7PJBJJX5O1tS+tzE6IfcIPsw8=;
        b=BvtHuPigo/uC3SA6AxyloyDJM7CsAMezbDa7461mygK0MpjxKHI/e8jG/+D/0Wicio
         LUxx2JHe4B/2sahxj88spQYM2ntXPJkkVnFHEAMkbEzvcWrWtOma7NxPCLgXO78jOu5f
         HBxjc5kuX/lQddP+2iNqALIw/ZK+YmnGW7Z7rXOpxis4FjO8qpyoyZv6nJ4ydnbMih2t
         FuccK261nDoBO0mo2aJfgbNh83HcIqZH6EV8DUHpyJtxwCLk87eGGDZJk8E9Wm8etLaF
         Ls0hUaoZVooYH9sTbNtx/DZruvqTzFQKjw+DTPB4hC2oiNfbr0CPKWj0e981lOReDRcC
         34aw==
X-Gm-Message-State: AFuF++kdesXE7w4ODsyaEbF4QsW4+JN9bIZ4HLU8qOnT/96TDSpx10Sy
	COWM32MqwK+87VAjvT2MmXrwWrkqsdvdPSWASUmbDx9hfbtMHrK6sZG+InfJaXkZGHY=
X-Gm-Gg: AYBFou07b38EdpAuKG+XGhn8hC0N5OaJAVc4DSbEguuwpe/B8XPWSV8ZpI+4HREylnC
	EUqaHQjUJh6i+ZpOoHLLqQJV/HYvDmXMm9qQ9qbkWooOVA9107w9fA7I1RoYc9kspDaO7FdjBSE
	2JxJJkepae3TF4d3cqus17bSAyZiMCHqHfwVdVBqzbB9WiVulv/8KynPrho6SwQof49NgtanzGx
	+MSJN5oCb1pm56ZmiNEPpqIPcbupQcCJKVAE++z5v1vBS2RIvJOja+RGX5sWsscUZgcGGCUSU3r
	7I0gbeE5qFdNkIdHz/CEekdxFiMavnVUYW1rdILUhstT2J6/hOoiz/smVZIllwxWQ80uJWvqvPS
	S3ZAuFJwNj8S/vfBM1d8FjcmxkuXQyEGz+0QxnWdggGy7+nbu/96Z2SCWP8D1Xq4rq6dYrraAm8
	/ywEt10uYA9bdFyCiNMkLdArPm1lmcppwlq104FoZ0dSzPUnvweLi2BxlD54m+nr5azq/xdket1
	ViPfiznmyY4WNQPVw==
X-Received: by 2002:a05:6512:130b:b0:5b1:58d6:4542 with SMTP id 2adb3069b0e04-5b8df0d444cmr3153254e87.14.1790442135516;
        Sat, 26 Sep 2026 10:02:15 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.117])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6b078d2sm1317178e87.63.2026.09.26.10.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:02:15 -0700 (PDT)
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
	hi@tychen.cc,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf-next v3 1/2] bpftool: Fail map dump for maps that can't be iterated
Date: Sat, 26 Sep 2026 20:01:26 +0300
Message-ID: <20260926170149.541352-2-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260926170149.541352-1-skokovmaksimevg@gmail.com>
References: <20260926170149.541352-1-skokovmaksimevg@gmail.com>
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
index 20d59eab09a1..b7f62fcbb6fc 100644
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

