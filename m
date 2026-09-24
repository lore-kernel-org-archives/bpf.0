Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3970486BBC
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245415; cv=none; b=nMC7WnJ8q0ezepMWQuivZRLjMvLewwdOn5jSr4gxltEPpYl1JTiavSlzrOzR/Itcn+l1HETseFylJZmluphOy0jtX2N6TpFmuHA5G71VFhMeD6YcirIQx6dkux3fQvluqpizZuARnMff5I2vRasfeUu+WID8Wirv1BAKBWk6J/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245415; c=relaxed/simple;
	bh=+nouV9zt7W78M6dmzDdd5dBqebiYPUKmIdR5QPLIlO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3tUETaNMoV/WHQPyUdpTVnmYRMWnB5JQO7zCRBPk9m47v1OrAIK7iqlrvHy9qIpcrUspHEwS5FSdvPPQvgF1TLRpsYMefoAD+ew7y3yOp3r/c9w1M9B2eo6VI6j4aVFqF6XG1J5KY/Bk3znRdz8RxkLPANtq+DLcBJavmeTtR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLXjTmfi; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLXjTmfi"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc50bcf87b2so921476a12.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790245413; x=1790850213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aYSc8z6uUhpoN5DPnRJYqvNeo+ZWN39hf5KrJMSzHAo=;
        b=YLXjTmfipOU1YvEV2kGztDWFzvx/DUB0Q6CzG34A+HILvW82XH3JxrpdWLvJYyIqt/
         dQW1gs4cXnYIldLc5l5YJqgJjs1M/xVTRAomP55RAtO3iF7cIoEzZlfeXmrNFaakKkeW
         pLrrv+uTsKnkIF6t4I0FsuCY3B8pOCZGYkRqc0WVOMCI0WPG+jwE3KZwyir0rzTubLY/
         Wsb2VZOLCwYHUFuyyV1dDAcxZmTE4GIGtcApWOfASs2grSCljusbi4feMlshPKdXzHYf
         YjE9ZEADYZhxoP7iEc0Jno94Tj4HICQ38fGDlpSK7g/7IPYv3FIA+iWmFPCdIWWoI4gk
         SAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245413; x=1790850213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aYSc8z6uUhpoN5DPnRJYqvNeo+ZWN39hf5KrJMSzHAo=;
        b=YOBJGw2abQ139MPxXnMIlTvCl7i4Yrz813fpf8kJDRlIMDx9UL9CKQLC2egIYvQa2+
         XuY1Bc4sneZUYkKCRTMxOFsV3vimPerWB6iR9F2fhG+FFHtyi/5MLijR5R8dck0KbLdP
         Og3Jk/Gz+WAndFSdlNY7jFg4CMe9E+uDaya1I7nwtleB68AjSPCrSXaivAtxBGRzONCE
         WIJz1KiU6mXqTwEvIuE8nTvn94QY67zlsRfPcT1WlPm0bOZzYIKITDMkR9gGvFdl2VUJ
         PYnMW0f1CIEjtPxnlynMLejJK7CzxAsxfJqaBudc+/imOuB8x9yfu0+I+Js8bfTG2bai
         Z4rw==
X-Gm-Message-State: AFuF++ngFMjD3bz/+HC3oFXBIvZtnnqzeRVL/l/Ham035BIcmVjPHbkg
	/Gv98GS+C0/Qv0PZBzjTpC+ni4I4cBsEigdLyDXvLHswE+iBOCqS3G0u5YTjK0QL5w==
X-Gm-Gg: AYBFou15zHyHlGWK0kaY4jCi0TdZaP/ymn5r7vKrzgJDQ/kO6jlSTyOOyoScmnuaEXD
	7EuE8+azILNsDQjyBua6BekZYWWm21CxDxn2zxBFSDRwjmH9+38g4jENjlFMWF3Nf3KQPpwG8UO
	lTbQeUElEqckqyTpH/BycKYY8pA5b100kIp80225N7NR52k51VdDec2Aw0SBBPUyH23TVX6fhTZ
	MJDneJKwH8tquASjDDM+gzpBtvICVeunN//s9fQ6p7/XtUplypOG46D3lcg7a29qTxoenMWX44j
	BjsmRXwCOJiByZRxJ3JVET/xpb+4IahzvLNrHeoF65iJaTHlNt4zIOHJEHK/ecLjVK0srLHyX/+
	sZ5DBnffdTbvFcWZh2j3jFJRGxM8bSYBf3qcsHzJTgLT4N+B2Tu5yuHnAxU9521thVYwu2bNP8p
	6nObHTbz4zGYOjnaczYcS5XbClpE5+TFYZJcXW1mAF/UdZ21VuslGQ9kegmiksDpaHMFuTqvNnC
	4dHCve0W6SSFgHq9UdJv6JB
X-Received: by 2002:a05:6a21:a45:b0:3dd:a196:30a0 with SMTP id adf61e73a8af0-3de0e9a08b3mr2035615637.80.1790245413127;
        Thu, 24 Sep 2026 03:23:33 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1afb9416sm2661582b3a.7.2026.09.24.03.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 03:23:32 -0700 (PDT)
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
Subject: [PATCH bpf v3 1/2] bpf: Zero-fill other CPUs when BPF_F_CPU creates a per-cpu hash element
Date: Thu, 24 Sep 2026 19:23:20 +0900
Message-ID: <20260924102321.2120434-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924102321.2120434-1-donggeunyoo.kernel@gmail.com>
References: <20260924102321.2120434-1-donggeunyoo.kernel@gmail.com>
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
pcpu_copy_value().  pcpu_copy_value() writes only the CPU named in
map_flags when BPF_F_CPU is set, so on the create path the other slots
keep the recycled element's values:

  update(k1, 0xdeadc0de, BPF_F_ALL_CPUS)  every CPU holds 0xdeadc0de
  delete(k1)                              element back on the freelist
  update(k2, 0xc0ffee, BPF_F_CPU | 0)     creates, writes CPU 0 only
  lookup(k2)                              CPU 0 0xc0ffee, rest 0xdeadc0de

Zero-fill the other CPUs on that arm too.

Fixes: c6936161fd55 ("bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS flags support for percpu_hash and lru_percpu_hash maps")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
 kernel/bpf/hashtab.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4f495dcbf670c..f9464e566f109 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1054,14 +1054,17 @@ static void pcpu_init_value(struct bpf_htab *htab, void __percpu *pptr,
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
+		int init_cpu = (map_flags & BPF_F_CPU) ? map_flags >> 32 :
+			       raw_smp_processor_id();
 		int cpu;
 
 		for_each_possible_cpu(cpu) {
-			if (cpu == current_cpu)
+			if (cpu == init_cpu)
 				copy_map_value(&htab->map, per_cpu_ptr(pptr, cpu), value);
 			else /* Since elem is preallocated, we cannot touch special fields */
 				zero_map_value(&htab->map, per_cpu_ptr(pptr, cpu));
-- 
2.53.0

