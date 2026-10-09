Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B223090C4
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510571; cv=none; b=BGbxbVXephovE2NkFKoFm2f3940LPtD6GLRlmMTxCTlUfzppuzSbD0l8tA3Ri8KY1xr/SzI9kmxuxp0zS9zOQDPEwIzjvrnKYYartZ8Y2TKGK/Vkm4EysqDD2LFoQj3TZmolehsesJ76+knoEdZ8RWJK8cjk6HB2gsvE7nYrJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510571; c=relaxed/simple;
	bh=QXcG3CNqcVsxyGOs8QcnTtCg3DM+0//08kfa4yW2fzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UHWdrsimmFV3LqWPoTNaRM1SQL+/v5IvTQ6tjMBF041fOygC4xJJUpijmTvj7GK2gffq1UAqy+WdwqDtFREQ2PJtK4wYoeXE6lUWTPYMVBq1Zkw6TDtMPv3r5MrxJvfOUHYhT9xKaMIHpgyzCXzGqwIlSAscn/hJm4FZAjJF1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5b1KrSi; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5b1KrSi"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-353804b591eso186662eec.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 18:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791510570; x=1792115370; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wq7VN3dZejiWmjkmf/Qhm3vdAdVy0qg7yR+WR6uOQz0=;
        b=Y5b1KrSi+yxim5VrFzFv+vcXJ9ENUZeSNZy35i1aRmEpZDukokmph3tjCUwFWbWTjm
         6rVOIN+jccIXKMKogOIqC0mDCbYRjMoHpFEowt71eCk2ZmlUkhoFphAPhPdk4f/wXLOf
         rujThIZpENSgd/HbYVRJfxqaS3ufNoaiP06BXkvJU+r+r8kg/IOHmqSIAKUZ2Xwd6/mG
         fq9qtMgt0q7iujT4VU1zjIed5OGdn5ZP/8KcTzjr6uTEGgnaObfBCQAweB6UvY+kKzP0
         QVOl+pYodQRgobD8NIXQTHryZsAO9+6B8QbVdL1Wvj5c0P+qiMm7Id+sR43eU9RvZbxj
         MO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791510570; x=1792115370;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wq7VN3dZejiWmjkmf/Qhm3vdAdVy0qg7yR+WR6uOQz0=;
        b=VhgBQt4GTdNp+hvCmDp8X2Q0+575/W9bXbdikM5ue8F7ny3W0fR89k4FliL9iDrG+C
         TOCRs0cbSfISp5diuRShezraAKO+y1tM2Qj3hMUai5YkNLNhpQpKq5W+fT7Cia/Dvdsw
         GdCKMcGQHOEMr6T4f4pVt9KKO698iI6+xaL4O0xxx51u3LofqtNNCFuBJlBgujoFaLNl
         sBxakvhzaE//K9nzVK0mBEB7ZmI8rDNFgxGQH8TlgivfhlSaAfESzclZr7ztmcRZaJ0V
         39qJckl6GnjNMIUE2rDjUYnW0LZ55YNMPZjfh25WR2UUcGbz9u5e9QAodMjgSZRVWxFI
         kp2g==
X-Gm-Message-State: AFq9FYLST8UxG8JPGVTwYUHMJUOvZCRv1zXbTZ9M5NrOgrJbh4N59O48
	WmXdrQmmzeKSYzG0Fi709TvYDxF9tnUIWsfLZSTjZyVfyk3zjJUQNCWL
X-Gm-Gg: AYBFou1TUmif2MWkgTFDHkYWrwWjJu3GUCVEWVC759U+XmQggz/AOLmyOfWJW9/AJHD
	3K8azZ/FsZe70ZUVOreYl4h5ifg7uooqDgk+ZHGt1sKBmAsr4V4//dFVWIq1OoUMdh9Gj6YOlYB
	rgvdXI9D5R3XeirKV/Le9d1fbS0lDFCB1rncKP/TcO/XbNIJuwKUszYX0sUDHPEQhI1u+io7TTx
	bm0Jhd4UHefekNry8aDs8B6cXjKIj/SW+ets/oRk/xLa+4nLHwGgL2BG6TV/qDpCIAI4KGnYO3C
	WKNgIg7OPzhSyGsNgs4PebObPEeaBvFQwzK1kA+3skJoPrt7+oIvHDu8qRK/LFSc2VDWvToQpOI
	BskT+csC6aNs3w+w8iCm8s65RAzxIvP9v65j/cI+X76hLd3oacD02DMohAzG1WlFjuDw0whUksr
	/FSE2kD6qFjn1pA9N6t3CQ0yeZ6siaKZhEAigKVL+0XcsRNg1AVuf6ckyn1CKPIswYSw==
X-Received: by 2002:a05:693c:4098:b0:351:6f76:65fe with SMTP id 5a478bee46e88-3537e11bbe1mr927945eec.28.1791510569712;
        Thu, 08 Oct 2026 18:49:29 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2fd33sm1851013eec.28.2026.10.08.18.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 18:49:29 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 09 Oct 2026 09:49:25 +0800
Subject: [PATCH bpf-next] selftests/bpf: Wait until the .data map of
 test_mmap is freed
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-selftests-bpf-mmap-wait-map-free-v1-1-96d066daea2d@gmail.com>
X-B4-Tracking: v=1; b=H4sIACRIyGoC/x2NQQqDMBBFryKz7kAMRdCrSBdR/7QDmoZMaAXx7
 o3dvbd4/x9kyAqjoTko46Om71ilvTU0v0J8gnWpTt75rnWuZ8MqBVaMpyS8bSHxN2jhCyQD3E0
 iQe6LzOKpzqQM0f1/MdLVROyFHuf5A3vpCeZ8AAAA
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

After destroying the skeleton and dropping the last mmap of the .data
map, test_mmap polls for the map ID to go away, up to 10000 times with
usleep(1) in between, and then checks that the ID can't be used anymore.

The map goes away only when the program that uses it is freed, which
happens in a work item after an RCU grace period. With other tests
running in parallel, that can take longer than the polling, and the
test still gets an FD for the map ID.

Poll until the map ID is gone. The watchdog of test_progs kills the
test if the map is never freed.

Fixes: 642c16547027 ("selftests/bpf: Validate frozen map contents stays frozen")
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/mmap.c b/tools/testing/selftests/bpf/prog_tests/mmap.c
index a271d5a0f7aba..0e297ed5da0fd 100644
--- a/tools/testing/selftests/bpf/prog_tests/mmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/mmap.c
@@ -280,7 +280,7 @@ void test_mmap(void)
 	munmap(tmp1, map_sz);
 
 	/* we need to wait for RCU grace period */
-	for (i = 0; i < 10000; i++) {
+	while (true) {
 		__u32 id = data_map_id - 1;
 		if (bpf_map_get_next_id(id, &id) || id > data_map_id)
 			break;

---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261009-selftests-bpf-mmap-wait-map-free-6bffaf4dfcf2

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

