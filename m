Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED438331C
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239540; cv=none; b=uX18gxPAQBzxjjOUJQ+F2IS38NEEVinUpKFZPijkbNOeB5/hPTmlC2bKjeVW94BSSGiPNl9H/wMOrKzhwqSzwQ7vAzOCF3J2ggSYL5AyOPezsDCPImKdjG5c0jP2j+md7MJEl9fgRWYrVnB4sCIrcEnhKDenRoSL/d/wOkDtkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239540; c=relaxed/simple;
	bh=ET02yudpTVpDKAfYKMipGbABTJmZB0Fkj/3NMmMn6ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VIuRrGOjTGc71hfcATtQUfbcaGVjsxgBwKDdkvNLxHX/po8HcbB/E1k2+G4gbZNhbLsW55atxTHXPJAmu52qnj/fiGEMJuPNaepT87RcT014bl2HaWcrg3MG8tpc4fwCybgIGOoovzbgUSlbjT8NWA+dZeBJUj757kZpfqGSv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcHAt0AN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcHAt0AN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so22595105e9.1
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 08:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787239537; x=1787844337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wwb1+VWDQFtZ7Zc7K8oYCiwpiZ5ICOZorV8IsL6a4vg=;
        b=bcHAt0ANvlapJyj5UnGWO16uwrCfKMgwh/qoP3dXBrcc7yalItEFne69iRxFkIs2v7
         tTBGxsoe6/YY+/0EKUZ2MJeDOE9wXEr41bokkRaxYx1XQHamnaLBdPCHDbk3LXWORmOG
         AmNmYmdC6TAjPhbFCZggVgfsaeqDmTD1+FlT93aJTra7z/5++BI7wXYYNkn1YTYdFI6m
         1BraMHPCqB5pkhNHg8JS/i41Q19ED5mdL8pQNtzp+kofFMKiix+9KNjhhl4yBGm2Fem4
         wDO1N+eyAMgXlcWTEA3ysiNw9nIs6y39z2rG0/OGNuYuRZ13a2xiHaJPz8rkwi8Y9b3r
         C5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787239537; x=1787844337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wwb1+VWDQFtZ7Zc7K8oYCiwpiZ5ICOZorV8IsL6a4vg=;
        b=fiYLsmDON9uD+IPiCWQzj0Usjaqti0ygR2FfNkyJt0yi7z4W7ReCb+LzWsucYBq59Z
         XiP5KZJXliReT7nT4JlyTpouxZb1nP/DByoW3LrNR75N2+wctKQee6DK9GLbGga4RmFn
         j/9h3fcPe6Qt8RmZUcYZhzt1OuaoqBEgkAln//gpV9y3LUSRcjnZ2RHxBe+YNlRVmZ1C
         bZqVW6MAu02fvp/1B2nQt9kznkeI3Q02xGPmdqt97cwfbqHKgd59tCeD2X3UVtWxIIs1
         QlTtihUe+W3mUFYugCiWfHNFWLBSjJ85CFmjlORC49cCYoPWljquFhsI+yN5nLjK03s5
         VbQQ==
X-Gm-Message-State: AOJu0Yz+fV9LFjSyVQ19u1MvyRoPRs0h8Ecsz71ryjk7ehGDnPGbEB8H
	73q+IWWjG6VU/J03xytDu9KDUJCOhpVSu225Jx1fbY/F4Emglzvb8UXX745KEeMNXM4=
X-Gm-Gg: AR+sD13p7nOZ+5EjnBnbggwKarsOcVD7xIqbajgSiDTyhbnPaMP/7fAvuK5dyZvLUIM
	wRwRReeA7YsJNi94mQ3ZToIhe37rWFlp0cXCPoVUWIhmvQbcdJ79EP9h3SXwcLVatkYxwQo4fD+
	eSUItOELD4Yc6Cn2S4eobqTY+gaTXBJkopPEJZxggWTDtCK+lz1XMHu9pV98jereyQSAuAG3Zan
	Y5OP/+4aGfY3Ap6DXIRy5rLWseVPrv/PtXRNUJynE2u/oMwb3wm78M8tosqOyLQbFXHkg24WABX
	+0lOcJ1w4XvvADXw71WftgTCoKWdB5cwHt9Md/1CNdnNRpxsDhv0vll9HitnnWFFlu4Sw2jov8J
	FE7vbxjw1OhScj3ZQGlIjPMHMOSsXx4RIwrXL0BZI9uT1IzTNzcru0ON3xIzmYTH5gcrQyvONyT
	C5nHerlCkB2hTiiIBb0VT9FnhowmueT+CkWziKga9Z74yuaQF9Ayi4LvkecmWC
X-Received: by 2002:a05:600c:6211:b0:499:a760:722f with SMTP id 5b1f17b1804b1-499aa1ba0b7mr251550965e9.13.1787239536613;
        Thu, 20 Aug 2026 08:25:36 -0700 (PDT)
Received: from runham-think ([141.5.46.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa074740sm158441485e9.7.2026.08.20.08.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:25:35 -0700 (PDT)
From: Syeda Mahnur Asif <s.mahnur.a@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: netdev@vger.kernel.org,
	andrii@kernel.org,
	Syeda Mahnur Asif <s.mahnur.a@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2] bpf: Fix NULL pointer dereference in bpf_sock_from_file
Date: Thu, 20 Aug 2026 17:25:31 +0200
Message-ID: <20260820152532.621639-1-s.mahnur.a@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_sock_from_file should not dereference a NULL file pointer.
KASAN detects a null-ptr-deref when eBPF tracing
fentry/fexit programs are attached to points such as
__mmap_region and file_map_prot_check kernel functions. This can
result in a NULL file pointer flowing from context to the helper.

A minimal check before dereferencing can fix this.

Fixes: b60da4955f53 ("bpf: Only provide bpf_sock_from_file with CONFIG_NET")
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Syeda Mahnur Asif <s.mahnur.a@gmail.com>
---
v2:
- Added Reviewed-by from Emil Tsalapatis
- Fixed name in Signed-off-by

 net/core/filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 16845987b244..7c3caae4bafc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12182,7 +12182,10 @@ const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
 
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
-	return (unsigned long)sock_from_file(file);
+	if (file)
+		return (unsigned long)sock_from_file(file);
+
+	return (unsigned long)NULL;
 }
 
 BTF_ID_LIST(bpf_sock_from_file_btf_ids)
-- 
2.53.0

