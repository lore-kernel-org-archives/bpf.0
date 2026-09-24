Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC554A13BE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266084; cv=none; b=qlNyH03NyjPhJDex2x7CiVhIb4pne+XfUXimKMES4LssI6S7wUTWzD4QgIwcCBwkfTEzDAg9xmN4da4P2F5R5MbXK19mhI40hsnydb08LRdvecK12svIiQeaj9RbIXfmOcMbDRmj2K5+E9ynYvIL/PVMWl+O2GjNecDdvUv8eDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266084; c=relaxed/simple;
	bh=sziXoGyA6UGJllRA/Ie85NjFCXBSTo1NKVZeW6Yq6WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYgPsZvfuPY2nlfXqcWD69WrfdZ9xDcvNlv4j2o6DgvAjdYv+sRA5zTxL9OEXdG+G5mh4q26iCCocuJES9C3E3H9B1jAKeMy3Tq4rJz7siF1MsEAEIW3aMobIPkilZzHI38CuRSUdXg28Dw7lRbSu7PnCFpRmeIQM6yNBeCDf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT4fEbL2; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT4fEbL2"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b79so2098570e87.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790266081; x=1790870881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BbdAxPRSQudHFXkDFge6mH3yayN/WLn49JJ5+xvwtOU=;
        b=lT4fEbL22CGyCHvGFSSvoEKjqq4AqF8drmgYRaihdyIwhFIUVRv3mQSXI1b9BBD29/
         2M/KndTzINr/FZKCKZH5KgwyqKvbrFsX2kWrkFHCcP7BfBx3k3cm7UWDquwrzi9jb/i2
         1gkhVKOcHn7QroIruOfTAd39Fs2bEibNt/KjI0HOJg1tyyDvmFDEwpr1OQG7JmwmUSZY
         Tw4fbqDT3Nu11K8y85os/lVPVpKhmYpIjvw0lIlVtci8b9AsupZyU8Wc49FIMLW3sIY8
         v30g+GI19izvSyTxPX2yVsY1sZOziZuitIvyl6TpBiHqCGq8Xqk3zs7TmfhhPJFDPHWq
         urkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790266081; x=1790870881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BbdAxPRSQudHFXkDFge6mH3yayN/WLn49JJ5+xvwtOU=;
        b=WvqeG3HQG055vXmSg9EsLYMxDSvZypAWvUkEbtD14T/kq5tPzKQQWhwnkNafG0+OR1
         AX6AWbo5q29DO+pTXFkWVY5rO+bs3FMpeIbQG7/zRPNWPd2k+SLQIPnFVbVuPFNHObIM
         fDKojCusjYyyns8Y9schURuIdEchSFLS3Orb1SfDOkfy5Rc/JfQC4A6Xj7PsaM6cXwM9
         Gl64HOL16AaAs2bG2KoJJboAUjUT4o1Kr6qK9J+g5NZecoCJPld5VPEBobR/ElPAUOq6
         8AlQYaqWhJGrm2JNsf7A/nO1MmwaiJXpvzwucaVypp6tE/O6dYYvqZUxKsO3ia9XehAK
         2bug==
X-Gm-Message-State: AFuF++kh+8jN9a08uj5OyMZT9kmZrrXjzc//O9HCw5UaQMgmXPFaGIp5
	xXdcmm85DXSdXAA/KwXSpIZ4cah15ChmdRyY/S7A4EBhkZ9tzuiF4iJT5aBr8fEhdURdSA==
X-Gm-Gg: AYBFou1TlBVgk/vv0FGrJTMi0fCs8AL8IWnuqveUvFJPL/TjSFj8npzHb52w+a8VMPZ
	1l0fXcepjX9fkigC45U9WFtafKswcmtNap880z41u8/GssK9zn0LZQSDKi/071bUw1T2gApAs4u
	zxcpdQabtLewcKDcRYxCSqwTbbg9g24isZ7wg7dcpReIIdv3EodvW8nMYeQXuYGIiMvPNkBfAj6
	8Hx+r3Uvl0LFGDALvYUZToBs9IaL/inHG9qI3s71yfJ3XyG6SfrrQvvybJPhw24SRbyOmiC/aKJ
	VwkihF9yI52Xp7WYs3LrZH2SxIBg3QXptyZhnC1RyzsAEOJMAt3n/VwqcN8j+YMdQTkq1IP/bqX
	Z0BvAr4qYykJbgzDgyhRO8+3z9SsMlx7EHIXkJ4k0wsag+aUP9M53a5wnfqglbU9tzBXKnBhrGX
	0SbJ2RSUpZ5QWRnH9/0atUQH9/0eVw3g8gNNozBwQMCNNHRQp2tF1vtydD62lOxGSp5PtVgeDRd
	BeSsUHjUrcEg+A=
X-Received: by 2002:ac2:4c50:0:b0:5b8:bc5e:b583 with SMTP id 2adb3069b0e04-5b8df2129bdmr1107032e87.59.1790266080489;
        Thu, 24 Sep 2026 09:08:00 -0700 (PDT)
Received: from localhost.localdomain ([80.66.93.93])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d8552fd4sm1563292e87.2.2026.09.24.09.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:07:59 -0700 (PDT)
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
	kuba@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf-next 1/2] bpftool: Don't report an empty map when key iteration fails
Date: Thu, 24 Sep 2026 19:07:19 +0300
Message-ID: <20260924160732.485650-2-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924160732.485650-1-skokovmaksimevg@gmail.com>
References: <20260924160732.485650-1-skokovmaksimevg@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

map_dump() walks the map with bpf_map_get_next_key() and treats ENOENT
as the end of the map. Any other error ends the walk as well, but
silently: bpftool prints an empty dump, "[]" with BTF or "Found 0
elements" without, and only the exit status tells that the map was not
read at all.

This is what every local storage map (sk, inode, task and cgrp storage)
gets, since their map_get_next_key returns -ENOTSUPP. On a
BPF_MAP_TYPE_SK_STORAGE map holding storage for five TCP sockets:

  # bpftool map dump pinned /sys/fs/bpf/tc/globals/cilium_lb4_reverse_sk_v2
  []
  # echo $?
  244

"bpftool map getnext" on the same map already reports the failure.
Report it the same way from map dump, with a hint when the map type
does not support iteration, and print the element count only after the
whole map was walked:

  # bpftool map dump pinned /sys/fs/bpf/tc/globals/cilium_lb4_reverse_sk_v2
  []
  Error: can't get next key: Unknown error 524 -- map type does not support iteration

In JSON mode the error is emitted as an {"error": ...} object, as for
the other bpftool commands.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
Assisted-by: LLM
---
 tools/bpf/bpftool/map.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 20d59eab09..00e49ae05c 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -883,8 +883,15 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	while (true) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
-			if (errno == ENOENT)
+			int saved_errno = errno;
+
+			if (saved_errno == ENOENT) {
 				err = 0;
+				break;
+			}
+			p_err("can't get next key: %s%s", strerror(saved_errno),
+			      saved_errno == 524 /* ENOTSUPP */ ?
+			      " -- map type does not support iteration" : "");
 			break;
 		}
 		if (!dump_map_elem(fd, key, value, info, btf, wtr,
@@ -897,7 +904,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
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

