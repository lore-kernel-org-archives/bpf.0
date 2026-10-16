Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A938331F
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180128; cv=none; b=rwexSIfz2iOsYdLEZddSvd++DZh9QZTA9phG9OMPId8cujuWBRAvMkpUSlNA3X/QqiQ4+x4WAFs9X/3TZam7CIYbuXb0iM5z+gxFLD4qQ/N9m3bnZ7KwnpBG9TSFTD1c6jdovZwij99sGjS3BVd+vzefTgj9Sba63kqsQFRlqbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180128; c=relaxed/simple;
	bh=AzQPYHNUT/j8RTXPgsRDr9DCQcEVkrrbx97M++n4ilQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImkunqdmzmBt1au9HRm3EiYWyvNGYxy6TSjXvISDecPgZtr4dQyGJtBPCwdC73E/ZzYHlEYu5LPPgHFe1xvetI5ed4/1VFR/9BSgWQF1PnhvUigTJjA6uRNuWQ7A1FTfrQNWHPMWYlCLkoVpMXRgkcS4p8eE1kB1spmu6r+erIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcujVhjO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcujVhjO"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3aae7df0971so1630661fa.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792180124; x=1792784924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ecu4e6dTaJMs9MJADJOqGuLLxiqMNrvgukmjE5VhgYo=;
        b=GcujVhjOrdu4BzJmXeffLlwoyzTSEu8fec/PkKTpfF+ffRdbN7nbrvnfuqi/vuo4Zz
         F0U+BnqhYEiyOuwBQOgmeuFrOtXL+a4Z4Ns7nnJ261VtmGA6ii37y9zdxUiGNBmT8G3h
         B2liOeVx3mEzrUo+gVeaY1LHejgNMtT9UlIhPiYQM/Xju+u+WadjF4oeYWAkj0NR9EUm
         p4fA9YDoENt+3TJwZEVBCkhGSsh4kEj837vUvSxEbToOea7ehp2wGYlRyF2nPO4+9ixw
         /2sOsngSVrbijAu23Gq/Rk6EtgnZDYLjFsBQVioTtL20LuPzTXcDr4ctMXnAry+3PADk
         JsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792180124; x=1792784924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ecu4e6dTaJMs9MJADJOqGuLLxiqMNrvgukmjE5VhgYo=;
        b=rU6V3jKFgLHDQLyd76lwim7zmHP8J/1A9TWIbjAlaREKSgO15dZVDS07SyxWs2Qi+h
         iH8W3mP2rgtuCtebnHdeGLKZF2EZB4dQfUKBivO6dV5pWt9vxvxOw5Emz1RE3txfyrHB
         M9Fs+DKTV0DvuNSScVDyAlbs+V29w2aDaR8VAMHZ272pzKTYT6PpePeP2x5lVD5O5VS2
         bWB6fMfX3Gme7erEUj5opvUuB815Kokr0wKCXJ1+ypJFlJJ1u/5TG8rEFsKITT/fdrbF
         MH59DBmSZeFQBG5yQZGNKXWXWfQVGDQWubKLby7tS9na8/tb/p4rjGulLiuJyDMb6zRV
         Kp5w==
X-Gm-Message-State: AFq9FYJ1wIBoTNCYELAJiQGFm9P9g3Gt+r6kdRf3gcNsQMUbg+eUfF3X
	benYwMdDUrcarqAKEzoNV+UnB4D760DvMn4fqUErU3zBMZirOy+A02jZUgHzdCLiFyk=
X-Gm-Gg: AYBFou0gAgMIqfU1KPviXAHI/HV7l5TfsZx48XEd9hW5cgb4vmO30eAfzlQ+y9oN8cb
	54kDnJVVFpe6HQKcbQA2gMzp16ZREOxE9m8QwhdZL6wMzh+JCzjWHc7qNmxntaeCCbBW8JIVUoB
	CzilAtV+62ecv/sjUPSt3nC5NuKCQE8HW5VyFr8Ie5er/ZSh/Y6IImdgJpDkaToLNbQ1B3YAaqI
	JAosF67DCYhyc7ZGJwXArYyhQeXSQwEo0JUYhHbqpfnBWsMgPhh3ocy4fLT6sCvxRKCN6meXpgH
	/mOKe13hYR9WlFd2DLn5/WzT6QMnH21cGFHiPcnh11zGCqti/A34c7WUihtOw2CBCI0obBSjGTc
	hc0/PwGcXyyb0/7ikRsyDIVz2+soUZhN2N6CAdwbhI9ENw3xJIvcKbkqgquzXk39Bvm6Q7QovPS
	pwt7525UXePHTx1OTCEzkjn3qeme+hVjfxmuB7yz7Z5YWwHfXaoz4XuqgP4MOCKINRMsRrHkz2R
	aKO40nJgZylZ/ZeJir5SBDC9wSwz00Aoy1XJOfPeISac3xNaWX3ADhtPXRbTiA=
X-Received: by 2002:a05:651c:b08:b0:3a9:829e:1df3 with SMTP id 38308e7fff4ca-3ab2914761dmr1718881fa.12.1792180123656;
        Fri, 16 Oct 2026 12:48:43 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ab2a4691f2sm1179411fa.19.2026.10.16.12.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 12:48:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/3] bpftool: Print ENOTSUPP as "Operation not supported"
Date: Fri, 16 Oct 2026 22:47:56 +0300
Message-ID: <20261016194825.230433-2-skokovmaksimevg@gmail.com>
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

Some BPF commands return ENOTSUPP (524) to user space: iterating local
storage maps, element operations on ringbuf maps, creating an LRU hash
map without preallocation, freezing a struct_ops map, or running a
program type that has no test_run. ENOTSUPP is kernel internal, so
strerror() only gives "Unknown error 524":

  # bpftool map getnext pinned /sys/fs/bpf/sk_storage
  Error: can't get next key: Unknown error 524

Add a small helper that knows ENOTSUPP and use it where bpftool prints
the error of map create, map element operations, map freeze and prog
run.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Assisted-by: LLM
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
---
 tools/bpf/bpftool/common.c | 11 +++++++++++
 tools/bpf/bpftool/main.h   |  1 +
 tools/bpf/bpftool/map.c    | 18 +++++++++---------
 tools/bpf/bpftool/prog.c   |  2 +-
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index f9b87efa7c9a7..ca5fa2f0bf9b1 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -72,6 +72,17 @@ void p_info(const char *fmt, ...)
 	va_end(ap);
 }
 
+/*
+ * Like strerror(), but also knows ENOTSUPP (524), which the kernel returns
+ * to user space from some BPF commands although it is not a userspace errno.
+ */
+const char *bpf_strerror(int err)
+{
+	if (err == 524 /* ENOTSUPP */)
+		return "Operation not supported";
+	return strerror(err);
+}
+
 static bool is_bpffs(const char *path)
 {
 	struct statfs st_fs;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 6851346a60305..b1eb4b5d991b8 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -98,6 +98,7 @@ extern const char *cert_path;
 
 void __printf(1, 2) p_err(const char *fmt, ...);
 void __printf(1, 2) p_info(const char *fmt, ...);
+const char *bpf_strerror(int err);
 
 bool is_prefix(const char *pfx, const char *str);
 int detect_common_prefix(const char *arg, ...);
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 20d59eab09a12..d809b075e734f 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -228,7 +228,7 @@ print_entry_error(struct bpf_map_info *map_info, void *key, int lookup_errno)
 		print_hex_data_json(key, map_info->key_size);
 		jsonw_name(json_wtr, "value");
 		jsonw_start_object(json_wtr);	/* error */
-		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
+		jsonw_string_field(json_wtr, "error", bpf_strerror(lookup_errno));
 		jsonw_end_object(json_wtr);	/* error */
 		jsonw_end_object(json_wtr);	/* entry */
 	} else {
@@ -241,7 +241,7 @@ print_entry_error(struct bpf_map_info *map_info, void *key, int lookup_errno)
 			msg = "<cannot read>";
 
 		print_entry_error_msg(map_info, key,
-				      msg ? : strerror(lookup_errno));
+				      msg ? : bpf_strerror(lookup_errno));
 	}
 }
 
@@ -1032,7 +1032,7 @@ static int do_update(int argc, char **argv)
 
 	err = bpf_map_update_elem(fd, key, value, flags);
 	if (err) {
-		p_err("update failed: %s", strerror(errno));
+		p_err("update failed: %s", bpf_strerror(errno));
 		goto exit_free;
 	}
 
@@ -1136,7 +1136,7 @@ static int do_lookup(int argc, char **argv)
 				printf("\n\nNot found\n");
 			}
 		} else {
-			p_err("lookup failed: %s", strerror(errno));
+			p_err("lookup failed: %s", bpf_strerror(errno));
 		}
 
 		goto exit_free;
@@ -1188,7 +1188,7 @@ static int do_getnext(int argc, char **argv)
 
 	err = bpf_map_get_next_key(fd, key, nextkey);
 	if (err) {
-		p_err("can't get next key: %s", strerror(errno));
+		p_err("can't get next key: %s", bpf_strerror(errno));
 		goto exit_free;
 	}
 
@@ -1253,7 +1253,7 @@ static int do_delete(int argc, char **argv)
 
 	err = bpf_map_delete_elem(fd, key);
 	if (err)
-		p_err("delete failed: %s", strerror(errno));
+		p_err("delete failed: %s", bpf_strerror(errno));
 
 exit_free:
 	free(key);
@@ -1381,7 +1381,7 @@ static int do_create(int argc, char **argv)
 
 	fd = bpf_map_create(map_type, map_name, key_size, value_size, max_entries, &attr);
 	if (fd < 0) {
-		p_err("map create failed: %s", strerror(errno));
+		p_err("map create failed: %s", bpf_strerror(errno));
 		goto exit;
 	}
 
@@ -1427,7 +1427,7 @@ static int do_pop_dequeue(int argc, char **argv)
 			else
 				printf("Error: empty map\n");
 		} else {
-			p_err("pop failed: %s", strerror(errno));
+			p_err("pop failed: %s", bpf_strerror(errno));
 		}
 
 		goto exit_free;
@@ -1462,7 +1462,7 @@ static int do_freeze(int argc, char **argv)
 	err = bpf_map_freeze(fd);
 	close(fd);
 	if (err) {
-		p_err("failed to freeze map: %s", strerror(errno));
+		p_err("failed to freeze map: %s", bpf_strerror(errno));
 		return err;
 	}
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index eb077236d2eaa..43599c79c93ac 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1499,7 +1499,7 @@ static int do_run(int argc, char **argv)
 
 	err = bpf_prog_test_run_opts(fd, &test_attr);
 	if (err) {
-		p_err("failed to run program: %s", strerror(errno));
+		p_err("failed to run program: %s", bpf_strerror(errno));
 		goto free_ctx_out;
 	}
 
-- 
2.47.3

