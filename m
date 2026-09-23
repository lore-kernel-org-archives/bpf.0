Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768DB9463
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122110; cv=none; b=svdq1StBL5ozeSJfQ8rrGxbU8WpkjciahIji8fDtRGVFcY35QBnmumPZgxW30ThnqMazo7RDS6JNrcZeomflzwX42omasCarb4obOoAq5WJBez203AyJtVf+/wsQCSC8QN6etRvzKFKZCMCB3Kv8JRgOLSdynoVgymK2ERabWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122110; c=relaxed/simple;
	bh=fsWaJap2Z4snPeSf3DEBaGqtx3ZtQ4arg0Z0hs6TbO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehVAbIdN1EUHX++K02R8svqOxaokCRYC6rIt47LTn3HqL8cKUF5NSs5u+hwLen6UEVe2Capgmlnv36TQOEjZrjhjQp0+7J6KKMOaDkZ2NpP782p5luOh/4O613KR8BnDKD0ijKNQ5B4Ewu+rK3X9E3Lb1RV7TneTTolrRCOTXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cq2yw6Nt; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq2yw6Nt"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f05ffcso2124115ad.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 17:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790122107; x=1790726907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LKmQCvI2wiAQJXN+O58M5/YjmdCMCrm9Tdz8ibDBbpU=;
        b=cq2yw6NtCjOj5tsW3Fow42xuVBtmfqLBQd+bB7gR7tl5wIUu1xfQNzdLixk0ytZiCf
         p+ai/8XVv9RwHk4DvpPoFiY9r0mT1cOXs760+Oywj/Nqn0mPuWG7jf1zJBMxicilaHX7
         kJXC+0JULD8btF76QXkcc9PhsguLyguPLFBCT6pu9Qn8+0LIzXuUWNHxCb3AdNB3nW1/
         StB0/hJM+nXtKrOTE09Gj3CiZdGCWSnvM9Wu4Iyswjw82gjweRM1e/IBiucWHqOQf4QT
         y3YErqU3T/ToEs8fYLLjj5SQisLyJKhADr9kfMwDCrV9uMPgYvDxJkAjR7L0DWqkrHMh
         E3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790122107; x=1790726907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LKmQCvI2wiAQJXN+O58M5/YjmdCMCrm9Tdz8ibDBbpU=;
        b=izPQ6SqlL/vI4RCKaeTlNCxl4K8H6SvdQUJpg99tQOR3SG9iIpvhfJ/403bSYkRUjB
         yYV3Oxf/sUISFVMMddcbJlAlhnQNXdni/iZVLXJ/bpDCmOr21W8QCBHPcaI96y96mR3b
         92PH6jd2g2LFglM1ZRsW/g4kw9dl2+Q0fTPfXgGCDF3VxwukKRhJbNdve3yEbDGNpX9a
         lDYhOyMocC+6XdzFz6tY8N1irTE9rPRrchliaiIx5u8WEVHNdaduJsD/1Ncp5SKa7O2Y
         kjALnygVM8cFxBZP4FqkknKKzl9/SpZAcSTP4BJKu5AoAo8x/HrkuEm6MVq+58STV09Z
         usRQ==
X-Gm-Message-State: AFuF++k5unuRyaRuuzCSWUeR7GSlc4DEOknhk38b5dULwOqmSIrdXjOT
	U/ZqCPTu+mR17t86RgQeFFyhD1N+sJabM+kkfMEAjuN0MQTsS0n06MppKGdqFR4asw==
X-Gm-Gg: AYBFou05RJ3Icx4YbpKiC79kcPzei3R4ebm/k/1m5Mzhx62BwRrz9eFV2u7hA4dEFlU
	MtS8gZf+1UTvTz0UdYxrhxrOfmZtFk6dhfU05KTW3ILVuZtaalBpzS5/0GSrik855xX+Sx0jzeR
	utcWlCdguL92sFu+6CmahKaRtE502/1mH1tFpvNahIIGZm5zfN7CQn3ul9BBIWLCKwLLNabCRAa
	Wqc8YDoHCCrXukota4tszKC/OTtD6YtOb/fpmP2J7KupolWSSmntCuygCcGkc9wSHOz9YoPL84Z
	3oQTWf9hU33yTUSkcd+cZvdcFiyN0GfS3sw/gKQ7hQCcCX8/N5cA7bH4ezbOjVU+bdkm0LV6ky/
	/4OV5L9gMfnsFTR78yY/v/Bt3OgJn95hVVKRl0FDZS5BP8BKW5AxdWCX0lVSw/F69zP3imbXof+
	nE5TdbkDPKwyupzzIo+eA68wVqH98cbWOqw/n1cOoRZ22L1Cml9PlrcbjeEKCd89IIjIDQ53dPA
	ovEZh3HdFbMgXZS51iSnvZJEWY=
X-Received: by 2002:a17:902:e741:b0:2dd:c053:e0fa with SMTP id d9443c01a7336-2df69e017bdmr8199925ad.41.1790122106661;
        Tue, 22 Sep 2026 17:08:26 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:2466:805a:e198:cde8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5c3a3dsm2021425ad.43.2026.09.22.17.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 17:08:25 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
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
	leon.hwang@linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH bpf v2 1/2] bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element
Date: Wed, 23 Sep 2026 09:08:00 +0900
Message-ID: <20260923000801.1764758-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923000801.1764758-1-donggeunyoo.kernel@gmail.com>
References: <20260923000801.1764758-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcpu_init_value() initializes the per-cpu area of a newly created
[lru_]percpu_hash element.  The area is recycled, so when the value
comes from a BPF program (onallcpus == false) it writes the running
CPU's slot and zeroes the rest.

bpf_percpu_hash_update() passes onallcpus == true, which delegates to
pcpu_copy_value().  Since BPF_F_CPU was added that writes only the CPU
named in map_flags when the flag is set, so on the create path the other
slots keep the recycled element's values:

  update(k1, 0xdeadc0de, BPF_F_ALL_CPUS)  every CPU holds 0xdeadc0de
  delete(k1)                              element back on the freelist
  update(k2, 0xc0ffee, BPF_F_CPU | 0)     creates, writes CPU 0 only
  lookup(k2)                              CPU 0 0xc0ffee, rest 0xdeadc0de

Zero-fill the other CPUs on that arm too.

Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
The merged arm no longer calls bpf_obj_cancel_fields() on the named
CPU.  That call is inert here: it acts only on BPF_TIMER,
BPF_WORKQUEUE and BPF_TASK_WORK, which map_check_btf() rejects for
[lru_]percpu_hash.

v2: name the BPF_F_CPU entry condition in the block comment.

 kernel/bpf/hashtab.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4f495dcbf670c..f7a9c432d9b76 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1054,14 +1054,16 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
 	/* When not setting the initial value on all cpus, zero-fill element
 	 * values for other cpus. Otherwise, bpf program has no way to ensure
 	 * known initial values for cpus other than current one
-	 * (onallcpus=false always when coming from bpf prog).
+	 * (onallcpus=false always when coming from bpf prog,
+	 *  map_flags & BPF_F_CPU when coming from syscall but setting
+	 *  only one cpu).
 	 */
-	if (!onallcpus) {
-		int current_cpu = raw_smp_processor_id();
+	if (!onallcpus || (map_flags & BPF_F_CPU)) {
+		int init_cpu = onallcpus ? map_flags >> 32 : raw_smp_processor_id();
 		int cpu;
 
 		for_each_possible_cpu(cpu) {
-			if (cpu == current_cpu)
+			if (cpu == init_cpu)
 				copy_map_value(&htab->map, per_cpu_ptr(pptr, cpu), value);
 			else /* Since elem is preallocated, we cannot touch special fields */
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
-- 
2.53.0

