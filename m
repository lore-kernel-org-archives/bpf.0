Received: from cvsmtppost03.nmdf.navercorp.com (cvsmtppost03.nmdf.navercorp.com [114.111.35.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABF37881E
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782114446; cv=none; b=pvOIUBZ6E4UrDrEOv5uRfwfZJZC2uIe7IV7fGaGubDta2/uFXfCRK6diS4BsVOcDXggbsU+EgskNEiHuSH5qqKkbHHkk+fjZ9iwpw9AKMC7ZHwMgGCxWzTg/R/KThm3X8T8q6OFRLdvnylmPCxm7ZyQNbLZYf06DDKPwyHnBVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782114446; c=relaxed/simple;
	bh=z/cFibn1bQGfsWd6sEKBUE+7Caj17UOCdL5MGEGC7kI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKf+nskkyiQyUqBvoNJ9djuzSgW8ctdQDuRAd/UJH37sFX/ORkKStdU+7//GaS/c0OvClbkfYkeNcWogGz0JXUmD0yErG42mHN18AjwyFdJK2/cr6O453xTCwORGxPkNaMfinNRPZopDAK+q7jXgSHIHaNzgftHzzDZD5kTQpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com; spf=pass smtp.mailfrom=navercorp.com; dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b=XzFNAfSD; arc=none smtp.client-ip=114.111.35.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=navercorp.com header.i=@navercorp.com header.b="XzFNAfSD"
Received: from kr0m-real-1 ([10.111.46.243])
  by cvsmtppost03.nmdf.navercorp.com with ESMTP id xaV66ESAQNySU9+5v+7svQ
  for <bpf@vger.kernel.org>;
  Mon, 22 Jun 2026 07:17:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1782112620;
	bh=z/cFibn1bQGfsWd6sEKBUE+7Caj17UOCdL5MGEGC7kI=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=XzFNAfSDINkgVOtcSzL5N1DM46z1VUWWquk/P7H/CarqT7yTrV8KvGZznQ80DDtCH
	 h/hav4Y1lbW7BucmFWIufp3SOuw4MeeWgtHs+SowMFEJEoipdISJLyg4fR/dE5d3Q/
	 hBxNQwA6hHdVhRIN0NNZDLhS91PDoi3sNV34NpQrRbU1ejt3IX0PrLJKoxAniHTvIy
	 +RvHPt9Wgo/d1Y1pYwthRDeVyPsA6/iZSg1b67B/V8rvqOkdHr9rVo+NtiWFBxIMlt
	 BQzyAZgWkBoJU+po+dAAhmBhXTe8aFazGvzlPBQ3xnC6uEXpDl2Kh3MBsyRmJf1i9R
	 nOWttK8Sg/SDw==
X-Session-ID: DdIOxQejRgSKkF4yUeKqew
X-Works-Send-Opt: T9YwjAumKAumKAbZjAgmKqKXKoJYFHmwFBwYjHmm
X-Works-Smtp-Source: PZK/KAU/FqJZ+HmlKxUm+6E=
Received: from localhost.localdomain ([10.25.121.184])
  by cvnsmtp02.nmdf.navercorp.com with ESMTP id DdIOxQejRgSKkF4yUeKqew
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Mon, 22 Jun 2026 07:16:59 -0000
From: Gyutae Bae <gyutae.opensource@navercorp.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minsu Jeon <minsu.jeon@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>
Subject: [RFC bpf-next 1/3] bpf: add BPF_F_COMPARE flag and compare fields to map elem UAPI
Date: Mon, 22 Jun 2026 16:16:47 +0900
Message-Id: <20260622071649.31541-2-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260622071649.31541-1-gyutae.opensource@navercorp.com>
References: <20260622071649.31541-1-gyutae.opensource@navercorp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gyutae Bae <gyutae.bae@navercorp.com>

Introduce the UAPI surface for a compare-and-delete primitive: a new map
flag BPF_F_COMPARE plus compare/compare_offset/compare_size fields let
a delete request name an expected value region.  Behaviour is wired up in
the following patch; this adds the flag and fields (kernel + tools/ copy)
only.

Co-developed-by: Minsu Jeon <minsu.jeon@navercorp.com>
Signed-off-by: Minsu Jeon <minsu.jeon@navercorp.com>
Co-developed-by: Siwan Kim <siwan.kim@navercorp.com>
Signed-off-by: Siwan Kim <siwan.kim@navercorp.com>
Co-developed-by: Jonghyeon Kim <jong-hyeon.kim@navercorp.com>
Signed-off-by: Jonghyeon Kim <jong-hyeon.kim@navercorp.com>
Signed-off-by: Gyutae Bae <gyutae.bae@navercorp.com>
---
 include/uapi/linux/bpf.h       | 6 +++++-
 tools/include/uapi/linux/bpf.h | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 89b36de5fdbb..4705b02fb6a4 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1397,7 +1397,7 @@ enum bpf_addr_space_cast {
 	BPF_ADDR_SPACE_CAST = 1,
 };
 
-/* flags for BPF_MAP_UPDATE_ELEM command */
+/* flags for BPF_MAP_UPDATE_ELEM / BPF_MAP_DELETE_ELEM commands */
 enum {
 	BPF_ANY		= 0, /* create new element or update existing */
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
@@ -1405,6 +1405,7 @@ enum {
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
 	BPF_F_CPU	= 8, /* cpu flag for percpu maps, upper 32-bit of flags is a cpu number */
 	BPF_F_ALL_CPUS	= 16, /* update value across all CPUs for percpu maps */
+	BPF_F_COMPARE	= 32, /* compare-and-delete: delete elem only if value region == compare */
 };
 
 /* flags for BPF_MAP_CREATE command */
@@ -1586,6 +1587,9 @@ union bpf_attr {
 			__aligned_u64 next_key;
 		};
 		__u64		flags;
+		__aligned_u64	compare;	/* user ptr to expected bytes (BPF_F_COMPARE) */
+		__u32		compare_offset;	/* start offset within value */
+		__u32		compare_size;	/* bytes to compare; 0 == whole value */
 	};
 
 	struct { /* struct used by BPF_MAP_*_BATCH commands */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 89b36de5fdbb..4705b02fb6a4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1397,7 +1397,7 @@ enum bpf_addr_space_cast {
 	BPF_ADDR_SPACE_CAST = 1,
 };
 
-/* flags for BPF_MAP_UPDATE_ELEM command */
+/* flags for BPF_MAP_UPDATE_ELEM / BPF_MAP_DELETE_ELEM commands */
 enum {
 	BPF_ANY		= 0, /* create new element or update existing */
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
@@ -1405,6 +1405,7 @@ enum {
 	BPF_F_LOCK	= 4, /* spin_lock-ed map_lookup/map_update */
 	BPF_F_CPU	= 8, /* cpu flag for percpu maps, upper 32-bit of flags is a cpu number */
 	BPF_F_ALL_CPUS	= 16, /* update value across all CPUs for percpu maps */
+	BPF_F_COMPARE	= 32, /* compare-and-delete: delete elem only if value region == compare */
 };
 
 /* flags for BPF_MAP_CREATE command */
@@ -1586,6 +1587,9 @@ union bpf_attr {
 			__aligned_u64 next_key;
 		};
 		__u64		flags;
+		__aligned_u64	compare;	/* user ptr to expected bytes (BPF_F_COMPARE) */
+		__u32		compare_offset;	/* start offset within value */
+		__u32		compare_size;	/* bytes to compare; 0 == whole value */
 	};
 
 	struct { /* struct used by BPF_MAP_*_BATCH commands */
-- 
2.39.5 (Apple Git-154)

