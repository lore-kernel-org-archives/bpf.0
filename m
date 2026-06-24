Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773983BE17D
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316308; cv=none; b=YpOtELnAGNFhsuau/GDFBu1augqTOv6RLGzR/oU24EDUx0JUcBUiBivChjmkcxIVBLNroqPE/O+r06GS/r1fEEv/Ou6i6vfpgzUhmMCstkoIKQudC9lr42R7/RXJSqrr8cHFf9/BnLCgyQp5SEx4+HMoO2v5iXPOv17MwqYH4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316308; c=relaxed/simple;
	bh=yrnRw5+gukeZe+pWinnHGKzPhHGVD7BDVRyl6IFn1g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLxmt1ANWaE49D6nrw+A2epYfd46KlV8SZCt5j3xVdfXAl4nFz9eVb5SZgb5dmifs9VDNeQbm3S8LsnQM/fQASNak4KuZZK59HYjgwJ2cE8IA9aAo0f2OTCn0ZGZ80eAeGdhFEdFZ9RxQxlrQKNrKj0Hek7t3lVehBljQ8quzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aG7YmYm9; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aG7YmYm9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782316305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGcFW1mA3CdJg0xl6hBWv/hPxa9tOt5QAX9Yf8XEHlc=;
	b=aG7YmYm9uZ9XmNQs/z6AoGaxSUc+SSpOWCjy5tvba18q7+BI+GEpOBrRTALMhlOTGcA4q2
	aCq+MqeQUXLFcGC15ZAnCx6FPULPPcF2i6993PXHK9LJSbmxdYdwOWIWnuxOxYWGw8vXCE
	FspeNoQkaYov0d+pbmh3Eh9nKEqTRLE=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf 1/2] bpf: Copy per-CPU map value padding in copy_map_value_long()
Date: Wed, 24 Jun 2026 23:51:14 +0800
Message-ID: <20260624155115.85196-2-leon.hwang@linux.dev>
In-Reply-To: <20260624155115.85196-1-leon.hwang@linux.dev>
References: <20260624155115.85196-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In kernel, per-CPU map elements are stored with
round_up(map->value_size, 8) bytes. On UAPI lookup paths, it copies the
rounded size for each CPU into a temporary buffer.

However, copy_map_value_long() passes 'map->value_size' to
bpf_obj_memcpy(). When the map has special fields, bpf_obj_memcpy() copies
around those fields with memcpy(), and does not copy the tail padding
between 'map->value_size' and round_up(map->value_size, 8).

The temporary UAPI lookup buffers are allocated without __GFP_ZERO. As a
result, when the per-CPU map's value size is not equal to
round_up(map->value_size, 8), UAPI LOOKUP_ELEM and its variants can return
stale heap contents from that padding to user space. The same issue
applies to bpf_iter for per-CPU maps.

Pass round_up(map->value_size, 8) to bpf_obj_memcpy() from
copy_map_value_long(), so per-CPU maps both with and without special
fields copy the entire per-CPU slot. Remove the now redundant round_up()
from bpf_obj_memcpy()'s long_memcpy path.

Fixes: 448325199f57 ("bpf: Add copy_map_value_long to copy to remote percpu memory")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7719f6528445..ba09795e0bfd 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -570,7 +570,7 @@ static inline void bpf_obj_memcpy(struct btf_record *rec,
 
 	if (IS_ERR_OR_NULL(rec)) {
 		if (long_memcpy)
-			bpf_long_memcpy(dst, src, round_up(size, 8));
+			bpf_long_memcpy(dst, src, size);
 		else
 			memcpy(dst, src, size);
 		return;
@@ -593,7 +593,7 @@ static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
 
 static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src)
 {
-	bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
+	bpf_obj_memcpy(map->record, dst, src, round_up(map->value_size, 8), true);
 }
 
 static inline void bpf_obj_swap_uptrs(const struct btf_record *rec, void *dst, void *src)
-- 
2.54.0

