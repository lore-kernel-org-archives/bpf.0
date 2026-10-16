Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AC03C1097
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180130; cv=none; b=NNFnlMgBru+XEUpm0XJ5zpJWVSbUUSmt1vR7M4ShYpDcwHRT6aXvGLYXd5vHgXPaAFCOAhf4QJJIQfKqMjlHCy66F8/AOMBk4wqJO2D8FNTHacosibSzhX3V9ZddB6ZlXbwtWHPwy/KG6tAOl3kHK7R32aCjnaxe+oQNaY158Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180130; c=relaxed/simple;
	bh=VHBA7r6iRy1nPFZtImbOCI38Ps0WpG7S8UGhNtjYXU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ns7WbYE6npeVcyKUVgx59Z09FJl80Nqeb+eDtD/lkkxlr8cG5oZrvEfEDFOS4dcan2zA2wGL3a5xXXv3RXle3d3pwUsnUnn4c0Hwn3q5yEp5Xzi1NDZx13z8rbPGVfpDRN5KLBXZ32MQOo3vriaVs9y58Q0H3+1uo4SxXd2tweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n0o7h/pm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0o7h/pm"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba328513b9so290200e87.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792180127; x=1792784927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WaOfGjXPhKxu1i7K6sDhYeRAcqvotbUInh3VVNr1THY=;
        b=n0o7h/pmdZQYjN5X/dRovh29Ozt6LM1pGQOorFEDExB83a5ive4Mct5+8wzfbf0lt1
         pss+Wk5F+0tnTtBryerh/If9L30PBYU9pt7RK6/CgKdMa/RK6uVDKZzPr8/wx3X4VhLa
         WLwevEXhKvROTImq8UDniOc4FHvoJpEqlYfm+Wgbo+15Qgs+s8qx5Qf+CUxSvnmS4rJ/
         z3AsZ/gHBXQdXhDnNi/QKXiS0vYJDg8I7QIcOhyoOwq+8fuUcfAQuxiCb5Cst+aIBOhf
         nyk9qvexWP+vqa5HDMdljyALJstun2li+HIG5ghbU0xPOx1Oa1tkgYsrgIiZv/IrWpC4
         x0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792180127; x=1792784927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WaOfGjXPhKxu1i7K6sDhYeRAcqvotbUInh3VVNr1THY=;
        b=nQ6n/ZVbFFhro20Qk4BiCGsZc3XeXZqldBk2GPfyZDLDkAUqq2o0eeL5d7NFBzYNzI
         g66CA9hzLTUlAys+r3z865JvJtMGqAsGga8h8LGi2nAA+D3soNIVy5dj62x2TpWRkuS2
         IDTt4+6G+ZuaQ/RYFGbXVrY3Pn/YFqMoxclBZseXNJuggRQOsp8c3pXarTM23yKBOn3v
         rn2nQ3wLVDPo2ffBdnN+5p649ISpeOEBqc+iVV9GxXyl//P+6Be0Eqa/ITIabTCswH6d
         c2MHuKYMG4U1LjodMqhI1G9XsuePLgrxmtOJJ1/qx7YHloR5JLTnlBG/YIqASd18gFmo
         tuTA==
X-Gm-Message-State: AFq9FYLD1WsulutomujxAzrb54WfJJFFLqcXwaur8OmnZa/azLkTfld5
	Ju47W6nY7Vr3D2utJPBfktJsBkQVBQPQA1HquiYyK8AJs/YKxQFLzLtCe8T6aHBZlkY=
X-Gm-Gg: AYBFou39Whk9KuiiSr0aRJzI8tSoLw5h11acahDxSivD66brMFyzC0PxJIuPP5xQlhr
	mBbVKDkJTegsWQCzre20th6WWcH7An8bLF+0nuaYgm2Z0f1ovQ0IujfT8jVaUVB/SHrOAHQp/Bg
	7XDcgb00G3CP3HdhNayWbe8Z4CHeNWN5m9WusAOaSxNs5mY3f3o8H+qFSwt1owbqIZfwrmY9ab5
	5xuMIGPw9vuehCoxFZkqjweP4gP08VdNwM+6au03u4aoGZ7/kdvH/dANIuyS+bT5Z2ALhjO7WnR
	qbtbFU4T0EkqffFxhv5cv5sJW9P4GFbv4nuXLU1KUV6H5A4JeNdBwqugLUkul6sryMgQQ1o0nUF
	I0hRO6y+S+0Yx2/hiU0MpL1E35tn39Y0G2kgJ9vOcjvJYLDrDsREfOXzL+2aIkyquJbxduzMCIR
	DlTZuobncl/2EEz0y3pWgio0eYmpBzpLpQnw1gHmmaaRDy9uYnEFm3HiaNc1cRj4t2rYkyflbHT
	BjuIzXzZLddPXPYlsVjzOGhCim3ay9Hvmf4k2w9qmG3kX86PFCU
X-Received: by 2002:a05:651c:1990:b0:3ab:13ec:d38 with SMTP id 38308e7fff4ca-3ab292b5814mr1697021fa.13.1792180127018;
        Fri, 16 Oct 2026 12:48:47 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab2a4691f2sm1179411fa.19.2026.10.16.12.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:48:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/3] bpftool: Fail map dump for maps that can't be iterated
Date: Fri, 16 Oct 2026 22:47:57 +0300
Message-ID: <20261016194825.230433-3-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016194825.230433-1-skokovmaksimevg@gmail.com>
References: <20261016194825.230433-1-skokovmaksimevg@gmail.com>
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
  Error: can't dump sk_storage map: Operation not supported
  # bpftool -j map dump pinned /sys/fs/bpf/sk_storage
  {"error":"can't dump sk_storage map: Operation not supported"}

An error later in the walk is now reported too, as "bpftool map getnext"
reports it, and the element count is printed only after a complete walk.

Assisted-by: LLM
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
Acked-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/map.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index d809b075e734f..4b65edf74859b 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -856,6 +856,21 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		}
 	}
 
+	/* Fail early to avoid an empty dump if map type cannot be iterated */
+	if (bpf_map_get_next_key(fd, NULL, key) && errno != ENOENT) {
+		const char *map_type_str, *err_str;
+
+		err_str = bpf_strerror(errno);
+		map_type_str = libbpf_bpf_map_type_str(info->type);
+		if (map_type_str)
+			p_err("can't dump %s map: %s", map_type_str, err_str);
+		else
+			p_err("can't dump map of type %u: %s", info->type,
+			      err_str);
+		err = -1;
+		goto exit_free;
+	}
+
 	if (wtr) {
 		err = get_map_kv_btf(info, &btf);
 		if (err) {
@@ -883,8 +898,11 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	while (true) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
-			if (errno == ENOENT)
+			if (errno == ENOENT) {
 				err = 0;
+				break;
+			}
+			p_err("can't get next key: %s", bpf_strerror(errno));
 			break;
 		}
 		if (!dump_map_elem(fd, key, value, info, btf, wtr,
@@ -897,7 +915,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
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

