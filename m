Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD094D8DBE
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790353260; cv=none; b=EbYInhaeGufT1aJf7ko4nIdKKrujrvOvaODblNJ4kwtPnM4zHjqfQj3t54e5/WLiXw7pe49pV/vJlHAxS7CXjLBfImYGOSWhAw4BvpsysTUX1wU4CNsLtrW8NzYsK1DR35Q/fZtRvmYDCRKcvjzq3PddYSi3Qxu4f7J8rCRqf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790353260; c=relaxed/simple;
	bh=Q28sniXV7om3+Qk8sgoZevKDtaOXidBbVHOpP+ehFRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxeBdAqdvTySoy3CQEWXfiT7sPf/o1hNNhjIzWXiHACWfohIv2UvGMzXcEPBpi3LCudUIw5mV6c9MEtPWggyLFgdPUEgEF/rfVX5dV5kL+t3yl3xYlTJuzVUo13pz9h0CMcq0RTX9UTfmzgGVTmmo+FvXL6FEpClxBVhKFEA6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6QEB/jv; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6QEB/jv"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a59bc470d6so9676831fa.0
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 09:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790353257; x=1790958057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DYIMNeEsRRVimy1D2TXApSJburFYEEfCHdBBJQmjvA4=;
        b=G6QEB/jvITnIeV3wiHixdHdwrZGu9C3BveEdF8G2uhVW6GSrFVNs0Z82QGbk5QfaoL
         Y592GGobU46j3++J2haPOANCdvs4GzzeJk3iU3Fvndym+B9d0WEf46aJyC2Omj3N2SXZ
         hAVfuKh8xT8lz+jNaecDuR8rzXFKiRq5Mtho2H1zXSuzL2qOOXT68N/Eoyql0caUiVxg
         wlhUfhedM/LlfG9HwMMxZrhHI3NyrVVqIBwD3hodQ3WK7P2GObxOHPRzgwEWOMBleeG9
         3+dfV7P+uyJP36Q0TmdaIoRfTgBeded/sLAcoyodBQh0M8F/z4oSoco8Q98aNBGSt3NQ
         sSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790353257; x=1790958057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DYIMNeEsRRVimy1D2TXApSJburFYEEfCHdBBJQmjvA4=;
        b=OSgMqD+/nfiPmUn13gFB4Juw3jeMsSf+csis2XX6IZgCD9A2+e6OMMifBeTWHq+q4I
         MN3jiW2y7s2BwbWZrjLXVETqOpyncLrfdtE1P2GEqjlpEEglyHVn03yD418azGtgbjOZ
         Rj1tDcUcVaUjyovJmbC5VIlDkQ3IMlkoUEtyhPD0wJVjr78Nq1Pt3saP7n/pB9r3wuxZ
         iGMCAYWMP+lCp/Zh9Up2XMuK5cm+8yOybebM0p3I83OgMEiCnfE8UpvucTD+aFJsH4pk
         Zr2QhZg1Bxc9NDridCcUVRhTcT89wrZxj9quEU2Uxr2FRRjGx+jrI/wGhkqIk6shJi4K
         rlkg==
X-Gm-Message-State: AFuF++nCUbXddA8+UWsiVxqNYXHWqRW65coAX4IdKB0Lk9WRGlIoVcwm
	9/vCXiQzSionELiy02Ag0MHdwpTjMh9sOi/ouywjsgpJibG+h/GSjvkquNljml/IqKYcjw==
X-Gm-Gg: AYBFou2EbMg3z/ZxTaMbXL6xQanevWTdoq6xP9rHJkknKScHReCp2+HYylsjVUSjAZj
	YgtIGUuAKwXa9Aj0+o0SjbQj97miAQWLCLsGgDgViliQgUrQ/HAWJey+SSnkMZr11D8dpHtwVWP
	0bz1S2QXiDsnChPJ5azW0xnr6iHXG/RvlMmTVGCFM5PQKrU6u3xX1U076dPMybi5XkWuJzwIxwM
	A3GwG7psX3AYpHpC66R0Dc5j+j5ghbwFyrnga0FpCBLULG60XV0M0OU6AZF0wPwmLN8CPiqJ6X6
	XQmHdbc6hsT7wGmnJnETIAy8i3Qu7OA0bZL5fXH0zaWGRarYVy/MF1RJz3MhI7205nEAIM0vagk
	iHUw7Fg9tfOQGoNZn8fE1pnjoctao+VSwf0UgeSk6MV60smZyo/EleGIBfEQwE76FBZNBhiYlk7
	QUHsNlZF0Cv0lO+1TBV5VNOaZKmMy9nAqVMg2AbeSoEdeLR09mUVobkaRlt4gpFfov6xk+/P37+
	VPfJpLKLMJfVMw=
X-Received: by 2002:a05:6512:15a8:b0:5b8:e89a:5ca4 with SMTP id 2adb3069b0e04-5b8e89a5d36mr835126e87.65.1790353256807;
        Fri, 25 Sep 2026 09:20:56 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.66])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8e6ae62d7sm655740e87.20.2026.09.25.09.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:20:56 -0700 (PDT)
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
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpftool: Fail map dump for maps that can't be iterated
Date: Fri, 25 Sep 2026 19:20:01 +0300
Message-ID: <20260925162031.27259-2-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260925162031.27259-1-skokovmaksimevg@gmail.com>
References: <20260925162031.27259-1-skokovmaksimevg@gmail.com>
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
---
 tools/bpf/bpftool/map.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 20d59eab09..626882f207 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -856,6 +856,25 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		}
 	}
 
+	/*
+	 * Map types that can't be iterated fail on the very first key. Say so
+	 * before printing anything, so that the output isn't an empty dump.
+	 */
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
@@ -883,8 +902,11 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
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
@@ -897,7 +919,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
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

