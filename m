Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C41481647
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004527; cv=none; b=hB43fPzPZqH8cfP3gaeSVGHuIjhAGGyo1Z2+CDvxyG8zFT7+WGL8QLCvvPBV6u59oRpQT8xjQt1m3LI7Ce0sMyI95RuoktzCKzFYmGR2/oAEnS6zs6s9JtIunZuYBXEPAsOd5FROwOksVNcf3nwsBN+158D/hy4uY83f+fUi1Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004527; c=relaxed/simple;
	bh=brEj6MR87plGAnCfe2JFYjU1YUWfORVRC39+L7pPr1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dIl22p4WL+coeXSfp9d3zun/3oNISLCfi13Tf9L0+HK2vap2hmx/I5YRgtoBzvGhdmpxopIryxJdl/Me2Hbzc0muugx6YYo5sR5CcqZeTTbTivNP1CJXdBxxg6nQEg/P+Thh6lhrPh2MZIXMwO9c+/UPqEG/YEhgv/9gDJmj7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jE74eJCG; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE74eJCG"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-8137b129131so483652a34.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790004524; x=1790609324; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8IGUXrzN+S/YkH3Arjq7TrpUkLkILgaMIRceS8XIUBo=;
        b=jE74eJCGHhlsR5hZJuGvLmsOGGpz7uPxca/wX1mqlpvHSBiXElLwF05fs3TY5ZjnnC
         YTPt44gzWkSUYsRzGH7VAdpo3PWbmHS/fm1l7WTIAKGgwXHv4f6U2U7NqVKwRdyQoaV5
         rDGUJ25Mcq88LtAmle8g12LMDYIQvGSCWH1/pNCunWvNTMckswMhaBt9WXp86H9bxh2O
         7rcFEJl6KrCkBVtbvopto8t/TQZWmuxTw0yDWBiBsWgnTo3jFsGFFj960MAHKULfW9Qz
         Xci5HHYS9jTa7aWE7anK2eSELE3R9gdGBv2QXBuoTgHKa58kwUqk+SHbyHBTLvPQGsjg
         rUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004524; x=1790609324;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8IGUXrzN+S/YkH3Arjq7TrpUkLkILgaMIRceS8XIUBo=;
        b=pxipXMqYn5tgPF+Y+0uCaP9kBB9YauBhwuUjCdC13agujzBE9vx5IVjbfBzVs/O0Iv
         MKKi0trkcSU9k5fl5FaS5OwaSPjSwtANZ1OMqaKyikmLFCwmaBWHHJCKOWBMGC4veguR
         UjA6hq1dDgWjvG77+L2M7z35WNwQsMPYoVsNYEhe8eHCrgiWHn4yoYTdd6472fH/X9A0
         TTrYfJqf4KSq+jC6gzj09hdjj77VGybKzFaZqdscl0fN9oWtobtxxH/Ya0ztTSJLrSvA
         0vJgXT0V+9jxqhfEJQi8MBBKuWjGLovpxj2h+3SbTcZceHNZg+0o3YR6G4tNA5f9C98u
         dMWw==
X-Gm-Message-State: AFuF++lX7EM38Gr1IpCb5dMee7VaywhkXEHz/cPU+nhrabRJg78lQYfL
	EUktX15m5jsZ/QHwfdImbL2QrZShQ8wL1RlvkLDr0saG3/m+IoIK4n+m
X-Gm-Gg: AYBFou2p4Om9YdE2XVU8+y6nts7CCMHVH/5XwobxvAAL9eBeGpooOEI8BKKaKNQ99/L
	b+T7k00zBSGZFnzGeAn2njYuhSI+Zmqmtmq0pWXPkYCxDJCu59qEOhGGBrKJRgJBkPqh/Dz/4Qc
	4JmGlemXgB9tuiTKddb2rg2ROTJG5zH7KRY8F9vlvQ0zsjk5kO9TntLJD9Aa1JhHROw9r0790Lw
	EKj+Ro81zfna8euGoVOxH622hCUjW09PDDEpxaepXBMn9UkpKRfnVy4druC1Ui2n/47gYBoosjJ
	8LQYQnXZL2l4EIHZJUQjhFFC4JJk4LXFt3v5QqPjXY9zS8QwiyLHaxzbzztNqAyV76Vx3MKbEpV
	9XVhERuNaZ7xmFbj35ZZ4mrfvjTvwpBOUP3RY3pZ+RAa0vbJriEGL+UTt5QoR4IOGSKltE3S3OG
	RagHvrNMJ5PinxptzauTmtGCSX6vryx2Fa8PEYNdWrzHQCJyRdpK53WCquEQvwCA==
X-Received: by 2002:a05:6820:16a6:b0:6b7:46e9:96fb with SMTP id 006d021491bc7-6ca9bf49dacmr9389374eaf.43.1790004523525;
        Mon, 21 Sep 2026 08:28:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d146fcfd1dsm217395eaf.10.2026.09.21.08.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:28:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Mon, 21 Sep 2026 08:28:05 -0700
Subject: [PATCH bpf-next] bpf: Speed up htab hashing for u32/u64 keys
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-hashtab_fast_hashfn-v1-1-f92ae72cefcd@meta.com>
X-B4-Tracking: v=1; b=H4sIAAVNsWoC/x3MQQrCMBAF0KsMf91AO2KkuYpISerEzCaWTJBC6
 d1Fl2/zDpg0FUOgA00+avquCDQNhLXE+hKnTwQCj+zHefKuRCs9piVH68sPubpZrpwuK/PNCwb
 C1iTr/l/vSFt2VfaOx3l+ASRFomxvAAAA
X-Change-ID: 20260916-hashtab_fast_hashfn-9e52b3c2276e
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790004520; l=3596;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=Pq+G94zeejEdd2eWzvGgKPpKZfVTzId7jPB/0ZHMwU8=;
 b=j90qt0Gy78LG9oQd+SyI47mW4o+MLHNyMbh/ijibb9VI0RxGZuHWbs7+qSRajK6+0hrsnG9JZ
 zvsWLVsH9fvB7OXgbcdBKpCMTEj0A2JVKcIYvoXEtEGSqMkH0Iwp/+B
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Four- and eight-byte keys are common enough to warrant avoiding the
generic jhash2() path. Fold JHASH_INITVAL and the key length into
hashrnd when allocating maps with these key sizes, then use
__jhash_nwords() during lookup.

This preserves the jhash2() result while avoiding its length handling
and repeated state setup.

Measure this with six runs of:

  ./bench -w3 -d10 -a bpf-hashmap-lookup \
      --key_size KEY_SIZE --max_entries MAX_ENTRIES \
      --nr_entries NR_ENTRIES --nr_loops NR_LOOPS \
      --map_flags 0x40

inside a vng guest with two vCPUs and 4 GiB of RAM. Keep each map 50%
full with these workloads:

             max entries   entries       loops
  small              512       256   8,388,608
  medium          10,000     5,000   8,000,000
  large          100,000    50,000   8,000,000

Mean throughput in million lookups per second is:

  Baseline:
                         key size (bytes)
                      1        4        8       10
    small         87.55    85.65   102.20    85.74
    medium       120.88    79.02    89.12    76.52
    large        126.61    52.28    57.78    47.54

  Optimized:
                         key size (bytes)
                      1        4        8       10
    small         85.97   106.06   129.24    84.47
    medium       115.97    91.30   101.41    74.17
    large        120.27    58.16    62.03    45.99

  Change:
                         key size (bytes)
                      1        4        8       10
    small         -1.80%  +23.83%  +26.46%   -1.48%
    medium        -4.06%  +15.54%  +13.79%   -3.06%
    large         -5.00%  +11.24%   +7.36%   -3.26%

The targeted four-byte lookups improve by 11-24%, and eight-byte
lookups improve by 7-26%. Untargeted one- and ten-byte lookups are
1-5% slower, consistent with the extra key-size checks on those paths.

For bigger key sizes the overhead of optimized key size checks
should be less visible.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/hashtab.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 6f331c80130d..4f1dbd6ebc07 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -612,6 +612,13 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 		htab->hashrnd = 0;
 	else
 		htab->hashrnd = get_random_u32();
+	/*
+	 * Fold the jhash constant and key length into hashrnd once for the
+	 * fixed-size fast paths instead of doing it on every lookup.
+	 */
+	if (htab->map.key_size == sizeof(u32) ||
+	    htab->map.key_size == sizeof(u64))
+		htab->hashrnd += JHASH_INITVAL + htab->map.key_size;
 
 	htab_init_buckets(htab);
 
@@ -679,9 +686,19 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 
 static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrnd)
 {
-	if (likely(key_len % 4 == 0))
+	const u32 *k = key;
+	u32 b;
+
+	if (key_len == sizeof(u32))
+		b = 0;
+	else if (key_len == sizeof(u64))
+		b = k[1];
+	else if (likely(key_len % 4 == 0))
 		return jhash2(key, key_len / 4, hashrnd);
-	return jhash(key, key_len, hashrnd);
+	else
+		return jhash(key, key_len, hashrnd);
+
+	return __jhash_nwords(k[0], b, 0, hashrnd);
 }
 
 static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 hash)

---
base-commit: 6849a44e5946ebf646e82c6a0296840d2b3bda5f
change-id: 20260916-hashtab_fast_hashfn-9e52b3c2276e

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

