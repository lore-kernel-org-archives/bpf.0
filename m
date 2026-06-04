Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18033F5A7;
	Thu,  4 Jun 2026 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780542693; cv=none; b=jwacXnUbOGqZdSVqNgUjnEO3bJdNer7e37ImNVTbhmLtskAaPrGk/RQLq+y+9hSxsU2JqO7t1lY5p0wl0GOx8nfVY1EwY8miH2xGZBb0jbDVdd6C89dTJmlXOQNzwo7GJy8WCZKmKe+oxBz3dCiUmSzRYhNCYgXByiq/1iirbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780542693; c=relaxed/simple;
	bh=edT8mFCaFwjVr/UxUOMemfdTwAy0NuT4bNupcI1yJMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPpzTRADiRXDIngqtbKFzEPfDx2H+oybeI08ZpipfDK6cUlxCg8LdWgBE4fDqi3vJ0nRrlabIRBvRc+dDv7op/vhrHtY2Wlmbywz/zNErnbDkt/VUTfxd/24tVr95VbyfyizhG8BWbQ+OZWWmj5eYpgwovi5BOvlBsR/qcRLcng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=B5XAOV2C; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="B5XAOV2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6m
	CbxHGoF+2AqkpPPiyT1MKl99g/hDY8B3EfUaDJNxc=; b=B5XAOV2CMmAYWs1rvT
	D2vtvs7j2uwhOijk9z8JCIltzEJPOE2Zz5A6qxl9gytpIqaBnPQroz9OdUIjI6OC
	tjFGgUWGRD+auFOOh1v5VMgnLF5/Xb3/DIuMDcHTr4AdFtXlVeY7IZnudEpSr/7/
	GomWdgF96ySmD1CDK7ddwep24=
Received: from nec8-i7 (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCnNjaz7CBq76U8BQ--.63531S5;
	Thu, 04 Jun 2026 11:10:53 +0800 (CST)
From: chenyuan_fl@163.com
To: chenyuan_fl@163.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH bpf-next v2 3/3] libbpf: fix feature probe failures for implicit BPF tokens
Date: Thu,  4 Jun 2026 11:10:33 +0800
Message-ID: <20260604031033.806727-4-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604031033.806727-1-chenyuan_fl@163.com>
References: <20260529031604.888137-1-chenyuan_fl@163.com>
 <20260604031033.806727-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnNjaz7CBq76U8BQ--.63531S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr15Xr48JF4DCrWrtFy5Arb_yoW5WrW3pa
	93ur1YyFn5Xwn3CwsxJan2k3yFkFyfJa15Jry7C343Aws8Gry3AFWftFsYqrnrKr9YgFya
	grs8tFs8ursrZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR-VyxUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbC5h0Nymog7L3F4wAA3B

From: Yuan Chen <chenyuan@kylinos.cn>

probe_fd() converts BPF syscall failures to return value 0,
which feat_supported() interprets as 'feature absent' (ret==0),
even when the probe failed due to a BPF token's restricted
program/map type mask.

In a user namespace with an implicit BPF token, the sequence is:
  1. bpf_object_open() -> no feat_cache yet -> global cache used
  2. bpf_object_prepare_token() -> creates token, sets feat_cache->token_fd
  3. bpf_object__create_maps() -> feat_supported() runs probe
     -> bpf_prog_load(SOCKET_FILTER) with token -> -EPERM
     -> probe_fd(-EPERM) -> returns 0
     -> feat_supported sees ret==0 -> FEAT_MISSING
     -> internal maps (global data) skipped -> verifier EINVAL

Fix by making probe_fd() return the negative error on failure
instead of 0, so feat_supported() enters the ret<0 path.

Additionally add a token_fd rescue in feat_supported() for the
ret<0 case: when a BPF token is present, a failed feature probe
is treated as 'feature supported' because token creation itself
proves the kernel BPF subsystem works.  Real BPF issues will
be caught during actual program/map loading.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 tools/lib/bpf/features.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index b7e388f99d0b..f934452e52f0 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -16,7 +16,14 @@ int probe_fd(int fd)
 {
 	if (fd >= 0)
 		close(fd);
-	return fd >= 0;
+	/* Return 1 on success, negative error on failure, so
+	 * feat_supported() can distinguish probe errors from
+	 * genuine feature absence.  When a BPF token is present,
+	 * a negative return triggers the rescue path that marks
+	 * the feature as SUPPORTED (token creation itself proves
+	 * the kernel BPF subsystem works).
+	 */
+	return fd >= 0 ? 1 : fd;
 }
 
 static int probe_kern_prog_name(int token_fd)
@@ -725,9 +732,21 @@ bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_
 		} else if (ret == 0) {
 			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 		} else {
+			/*
+			 * A BPF token may restrict which program/map types
+			 * are permitted, causing the probe to fail even
+			 * though the kernel supports the feature.  When a
+			 * token is present the probe is best-effort: BPF
+			 * token creation itself proves the kernel has a
+			 * working BPF subsystem.  Real BPF issues will be
+			 * caught during actual program/map loading.
+			 */
+			if (cache->token_fd)
+				WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
+			else
+				WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 			pr_warn("Detection of kernel %s support failed: %s\n",
 				feat->desc, errstr(ret));
-			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
 		}
 	}
 
-- 
2.54.0

