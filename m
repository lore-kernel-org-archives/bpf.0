Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032201;
	b=b8imZkLP1QS8wDXFUWgIhROVutQekGamTJi5Gx1N7xxVdwl1N6c+UdE92lESxNI5iabV
	 kjlyluM3I3U3E4gDKyOf/v4ZoLpcsp5n9pj/SrTf3vBo0/V3QUL5m2tIoul2BpnrKYc2M
	 cwxxXWPugRfGOmDvVA7WwLabc+IiRhNfyPmrw7xdBCKD5lWWnB9hr6PUEk8N+q3DtaMKf
	 SJNTsJYiOF2sUkc2aVznbzFwN3LszzThybTu6RuPuAyZncynUl90kFgTzVWfQnrgjxs6E
	 hPafP3/mAISjkd1A1+RMuM+pCRKi9AYrOmYw3eabAjB+m4dCkNTHYGQcHfhrU3JhL4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jjilxrpwleM7JjznJ3SOmEz03/yuCCXHu5R1S91kJ5I=;
	b=UIrbT+5kvdJus+UA4X1l71N4CmlFIj5frJteTUyj4Q7D3VyAwsZFaY+rUvtD9WJnGk0a
	 G6Zn0EQ8E8kzxyu3QsBDudVUbXztNz2430ukUvG87m8aYln1Kha1nNkCn0Hoyr0tW3BdU
	 g0SAwD6BNI25MtPDgDjh9pWT0+O5RgrZzNrJI6HczOTBxpEcPn9ngkgqJBFw+rkBdGA+0
	 H2SDtUOxL85jAL0CG4R/9D8N0FP8LC8OSuAyVbh+i96ekflSsU/qHI+8G98BQtlDt6L1S
	 iexwQQ8NRUY6Uuf/OGuBv8bzyz1t9+lmkdQW2dYJAyxgBq1cGrUKnVHogFchSwMO2tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MkplGEdg;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D5960A6F44
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89D5960A6F44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MkplGEdg
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-185fd3a4ca3so2566617c88.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793032201; x=1793637001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jjilxrpwleM7JjznJ3SOmEz03/yuCCXHu5R1S91kJ5I=;
        b=MkplGEdgwv61Zw8JhaNpM5yqOMQ8yrSLA258S+L/taf1GNFtMPZn1LO5xfzNxX2vHQ
         X6byKfV1WyVJTBy4kDP35Rn4sOSjwFOo7sx+4WGIuYgOZP0xcqgBxTvjW30gdSsPC2Ry
         gXUxNfNZv6wA84y2fYIZoRqmTjsCiTIi+t0GB5ZrmVkbDIhn0ZxyctJOpiq7rFOmLdW2
         8PN0rHwTJXzwpv1s6r617NdtDSEqIRMMaKHcZMCpriOSljWCYEAkiUFMSUE5D4lwOvGc
         +N8FNgdbv9yhn4MHBanaQ8wK0QU9r1955YxxHHGY4yuyHg8vj8ND1tGEhr8puZ0d8MJb
         1JgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032201; x=1793637001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jjilxrpwleM7JjznJ3SOmEz03/yuCCXHu5R1S91kJ5I=;
        b=MWgaF2OGLCL7ORxxwAfXxrHkH3frWdjME86SiGlFoXUWPpZgYz5SjPSmBquBgmu79Y
         SDPutgro4QbniAe8jV7PywbpXX4nt9UuSPHJCefgVNJbYctj2wjLVyDlipydbZtQv+sW
         C7rS5GPHU9sMkKXgWjmTpiHf3fLVeAEBnFqkS+IPgS8xwU785JhjAj3L/NNg0hqYQCXJ
         3W16XwgBK/UnfYF43SSx6+Ohof4A06TAukrpKAmBwdcNdbOcasmniJ/Bp83hpfWdGdYj
         XGpA+28y5D/VFJbSNPMQP57VnEJbDLoObTVPBfC17Aynqd8q3Ofvj+CgDtVkQykw5tX4
         fr7w==
X-Gm-Message-State: AFq9FYLpQ8aNk3dkWMetWY/pu/cAOC6GIlZowwyx1Nhxz0/+qW4BoCe9
	v7Hwqw+qXVOlH3rJjqADMOlY/PPrtPiEswrP1qtCsm9jZ7L6wZ/es6L4RgNe0l0VlYo=
X-Gm-Gg: AYBFou2INgMy5uVkpsAL303wuYzgOxLJYsCykSy4pac+xZ0ZWm3uXuC3DIL1lEuunmZ
	c4zycsTuMNyOk+d5Mw7kTRGsLKIfX9BO/gw6ldW8wQXsgT/VLF/pZY7V7dR55P+Vfp9Tf6qXBxC
	awTkvyqcKR5yc9BoQ00WN2I+Sr3+k3VL61K13nS0fQgJKcnZPBT3tbZld0wxvUReUKxs3jpugvo
	h/QTtiD8WBiJevf2CfIVwejmVa9lvFY0mzxn0PLiYXpz/6xeBxNZXVHtUACoqLJ14C6ka3PxI62
	oAJUG4Cv8yStGWRBH8y9H+FQI7JvTz1E43M8PPlC+XjUoT60c1mbVRSdZabxJADi/k2DT7+yMHv
	TaxsgiIVrlEg3faXfZFaTOv7wyp4FeAlfJVBG0D6+Ex6Xzf3LhoKGvNbOcMZDJErWSbomTfwjlw
	yDtsONp1KknPes0EgB2veE/Yituej3Yu0musw7QypH8TBx6P2uib360QOCS9a555aYnt8iSIIlD
	gRZwBHPZP9uLbFRp7z/mR9ZPfIiIJ3uG2gmy+cs7kGMzk6PUe33kipbTeg8acXLa3w7e5QCWjp/
	rBDCUWDlsvUu1jw4OQwQtz3mQzUT0e3AkpLltBxpx5jJFd1Dxm0FI8IRI3USlfmq2oTBdRRUuZ4
	=
X-Received: by 2002:a05:7022:ea44:b0:1a0:9d29:c32a with SMTP id a92af1059eb24-1a09d29c4c2mr4635325c88.9.1793032200306;
        Mon, 26 Oct 2026 09:30:00 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:f859:3f74:c064:3281])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7b23sm36119014eec.19.2026.10.26.09.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:29:59 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Ayushman Rout <ayushmanrout27@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: Fix bpf_dynptr_copy() for overlapping ranges in one packet
Date: Mon, 26 Oct 2026 21:58:08 +0530
Message-ID: <20261026162810.12862-2-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261026162810.12862-1-ayushmanrout27@gmail.com>
References: <20261026162810.12862-1-ayushmanrout27@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When both dynptrs point into the same packet and the ranges overlap,
bpf_dynptr_copy() can copy wrong data in two ways.

If one range fits into a segment and the other one does not, the slice
of the first range is used as the buffer for __bpf_dynptr_read() or
__bpf_dynptr_write(). The range that crosses into a frag is copied piece
by piece, and an earlier piece can overwrite bytes that a later piece
has yet to read.

If neither range fits into a segment, the chunks are copied from the
start to the end through a 256 byte stack buffer. When the destination
is above the source, a chunk written to the destination overwrites
source bytes that later chunks have yet to read. For a copy of 1200
bytes with the destination 100 bytes above the source, the first chunk
writes source bytes 100..355 and the second chunk then reads bytes
256..355 after they were overwritten.

Do not use a slice as the buffer when both dynptrs share the same data,
and copy the chunks from the end to the start when the destination is
above the source, like memmove() does.

The selftests added later in this series pass with this change.

Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ayushman Rout <ayushmanrout27@gmail.com>
---
 kernel/bpf/helpers.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..b74c03669b5f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3291,8 +3291,10 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
 {
 	const struct bpf_dynptr_kern *dst = (struct bpf_dynptr_kern *)dst_ptr;
 	const struct bpf_dynptr_kern *src = (struct bpf_dynptr_kern *)src_ptr;
+	bool same = src->data == dst->data;
 	void *src_slice, *dst_slice;
 	char buf[256];
+	bool rev;
 	u64 off;
 
 	src_slice = bpf_dynptr_slice(src_ptr, src_off, NULL, size);
@@ -3303,25 +3305,31 @@ __bpf_kfunc int bpf_dynptr_copy(const struct bpf_dynptr *dst_ptr, u64 dst_off,
 		return 0;
 	}
 
-	if (src_slice)
+	/* The other range is copied piece by piece. A slice of the same packet
+	 * may overlap with it, so it cannot be the buffer for that.
+	 */
+	if (src_slice && !same)
 		return __bpf_dynptr_write(dst, dst_off, src_slice, size, 0);
 
-	if (dst_slice)
+	if (dst_slice && !same)
 		return __bpf_dynptr_read(dst_slice, size, src, src_off, 0);
 
 	if (bpf_dynptr_check_off_len(dst, dst_off, size) ||
 	    bpf_dynptr_check_off_len(src, src_off, size))
 		return -E2BIG;
 
+	/* like memmove(): from the end if the destination is above the source */
+	rev = same && dst->offset + dst_off > src->offset + src_off;
 	off = 0;
 	while (off < size) {
 		u64 chunk_sz = min_t(u64, sizeof(buf), size - off);
+		u64 pos = rev ? size - off - chunk_sz : off;
 		int err;
 
-		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + off, 0);
+		err = __bpf_dynptr_read(buf, chunk_sz, src, src_off + pos, 0);
 		if (err)
 			return err;
-		err = __bpf_dynptr_write(dst, dst_off + off, buf, chunk_sz, 0);
+		err = __bpf_dynptr_write(dst, dst_off + pos, buf, chunk_sz, 0);
 		if (err)
 			return err;
 
-- 
2.54.0

