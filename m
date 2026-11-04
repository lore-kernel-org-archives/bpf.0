Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759187;
	b=zcyvVtaG2h1FJEPYBqfb64RqsD+ITwqRM8Am38+dRTKzesG5/h1uvGoFzgdPZsYVd01l
	 eRSBSO4O6YW0w6KK1u3o9WL1yNdRWNnaO8M5mpmWfph31LqIdu0bCnVo+WeeFPSzHjVsl
	 cVGHj0lRYDJhSodZH2/DWAFa3rIgYwteQ6XAvAtUYbqtC1h8/TDMC71lp7IV32kJM3P83
	 NiHPvxWf2Iuy6GlgrKu1kQytpVlRKr6zuQKd1qbwM/qx7Ec+/McGaxiz7Q2/rR0LceDfW
	 OPhy1P/hHQmMvVUB+2Fwjoi0mdg3FCpdJBYWKCpPORZbTsFOLuQMi1gKPRQ6MayBFpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=zid1k/6UZskVzJMqyOQqLRcmeMMFnOUpkJZ/a+E0ZIs=;
	b=fQJvG+jarOCwmJfJnvGYbqiL1yA7MZOVzylUYSNpJ5D+r34Zj1SvF1QVuN4TyyHZeM46
	 IUagA7Arrwm8McqmWw41/ZmXk7y8kuKYdmok7D3LFftYM+gbu2rKdkRwWb1P+MbX1CDKp
	 rnQITkIkBcWcPyG3FWIQPTzx+m0XQICBE69Fhy7xDSbGvj8ya+8v17aqM5sqPkMmlWa1W
	 1Sp1wUo+8i2DJEEe2P9gFYzR7U2od3ulPWGpmtcxlhSs8zXHt9tLrNDbQV1cpyquMKyOL
	 GDXcx/lMq30mtRmbQqXeqULocuO3vOfpJXUw69HvBrXlIs+dFNvI3AbCOFqTS7K4kUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="GY6dOFm/";
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951A606A329
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C951A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GY6dOFm/
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-89d6bd67045so73163b3a.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759186; x=1794363986; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zid1k/6UZskVzJMqyOQqLRcmeMMFnOUpkJZ/a+E0ZIs=;
        b=GY6dOFm/ELILMBuZ0HaFVYyupFPlKLVIr7q6uYh7qMn6Ux6ME8ot0rCTZatUml0aFL
         ShJwb5VqMnwQWewqYVyXluzp+0cc13Yum6JnVr7B2oZUer8+Ow7ZhB6MIQ9+f5DRNRYf
         d5+7S190D2DVXMhb5aiZ+l9cnJBi4VCatQgHJopG321bQRAWGDgNRo7uasmUxhtJ9QNI
         TVbtMT25XKXVywH09OeN45XJrDJlrwfacEer0vLYn4k5TzzETGHcwEMvbUq/QxfYjqMq
         ujfgAGGsKHBVFGxULT8GVFe2HA/uFpE32xv1GJNLEwXW44p45wyPSQ1o1SfkHknvRFDH
         mEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759186; x=1794363986;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zid1k/6UZskVzJMqyOQqLRcmeMMFnOUpkJZ/a+E0ZIs=;
        b=XlGPavDtsl0Z0/dcnfrZSKgirlMEerS2bLjh9q5PEApMEDRT/xF8UueVk+Hit7AgiP
         U0NohwtLv3Ur44s1QyiyyOWp1V3UbQu8JTL9DCz8k0PEDnQ74EoJAzGPKwynXfpXF4xz
         XXK5xHa4i2k5mGNHEdyIgqLGWrzSHp39jNcgToKUZwu80nJLgOxmOcx9sK6vMgrww63f
         IEaSGigToGhzkE18Snv/XFdjFFYsXov+TMWJqlNuKYNdxW53oo2QMQKBSUHk84uhQza7
         GhD4xNp9O5r99xLS8/TJ2KVcq4SOUqC5M35UgmygIb/bYKwvtgo2/Jx0JxbtVj8hxW49
         LsDA==
X-Forwarded-Encrypted: i=1; AKwUvByjspy4quslQQZ1bvWM3p41+4L3qZT1Z7bvbL8gGG5mFI4HG9lBWWF/HOG35eTfU657Eos=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Y37lp0X2/nCz7nPIw9D1v2RUPwMkLSqb+UfZQSbwtyyfn3sk9
	RdTA+SXc4kvvFOg3ZR9tMzdfLSIc7Y73YnVvIwSXHz0R8DRg+uys/vmN
X-Gm-Gg: AYBFou1mxhO3V9haO0ZCPokure53XJ4HpOCx6bSrU1/y+j2jU2vY2CRy5FVXb7BAJQI
	2d0yH0YEe+hxI2s4HVtiKE8KPjtlLvpZpdd0ahZhWG8hJ7MMqU++ACYY3UXXvx2yJfiIZ79GiUd
	KGr6gwZeuDaeFnM3fP/GBPeeLV0du6TJc0sB/Z1JLX2aAE2jVIBBOciMjrT3RlY0uVgF63cSod6
	HKSVQOOlyi9n0OD9WFfBDf2pku47kMgdtgYj31i6XTOdNzqZ+uvxaR0Y7dhuK9yl6sTI5cwQHTs
	TKeVT58+rv0XjTMaUYF+0OR4QXCN97sb4dKplU7ICMErkZzZiDmSo10tL2QCzQzr2YNzwtlmEsf
	C2DTbnXKIW2EOaIWCwgbvKlK6vHj04MczhEhEGK99e76UhJqPpGb2T3Nw1a4Wvry5OB1MhQEbbx
	5wmixNAIRE1Cg4LChHu2B/SgT/3oVwIZNTadvhqy0drQmeCzABumVMg4CGcGbhVMSlvOAL0GjcA
	kgI5Hbih7FMVC4DLsFlbU//UEhGEuFXfYXDb4FUoIMIiKIwvgTflpKhKs2akLNRlFfCXuVPfy2r
	Jb+wT+r24poKYKBAuENnPD5Xp0AbybPDlxKDopz76ighu3ziWpiJ2CUaJeMXkgzyaeaUdXW+7lC
	aNYew6GWdOtae/E2PTZvR7gx20nAcbJGyyQ==
X-Received: by 2002:a05:6a00:1382:b0:8a0:31e5:8cc3 with SMTP id d2e1a72fcca58-8a8317dd858mr10312051b3a.10.1793759185937;
        Tue, 03 Nov 2026 18:26:25 -0800 (PST)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09a7ce4cbsm218798b3a.11.2026.11.03.18.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:26:25 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:26:25 +0000
Message-Id: <DMM2K9N35AGL.3KWJ07UTOLU4Q@gmail.com>
Cc: <qmo@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <linux-kselftest@vger.kernel.org>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v7 1/2] bpftool: Use batch lookups for hash map
 dumps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tianyi Chen" <hi@tychen.cc>, <bpf@vger.kernel.org>
In-Reply-To: <a107a124d50c11a6d26363acce98e5e3b8377155.1793732386.git.hi@tychen.cc>
References: <cover.1793732386.git.hi@tychen.cc> <a107a124d50c11a6d26363acce98e5e3b8377155.1793732386.git.hi@tychen.cc>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 03, 2026 at 11:01 AM Tianyi Chen <hi@tychen.cc> wrote:
> Bound the combined key/value buffers to 4 MiB. Start with up to 256
> entries and grow on ENOSPC using the same input cursor. At the buffer
> limit, continue individual lookups from the last emitted key without
> restarting output. Also fall back if the initial batch is unsupported.

This is overkill for 32 ms per 100k elements.
v4 measured 0.774 s vs 0.734 s without the redirect to /dev/null.

n_buckets >= max_entries in htab. A bucket with more than 256 elements
is not a real case. The growth is dead code. No subtest in patch 2
reaches it.

bpf_map_get_next_key() walks the map in the same order as the batch.
So continue from the last printed key after any error, not only after
ENOSPC. Then no need for the growth, can_restart, the list of errnos,
three return values, fprintf(stderr) and the end_dump label.

> +static bool map_dump_can_batch(const struct bpf_map_info *info)
> +{
> +	return info->type == BPF_MAP_TYPE_HASH && info->max_entries &&

No need for the type check either. The kernel has three batch lookups:

  kernel function                        maps                      cursor
  -------------------------------------  ------------------------  ------
  __htab_map_lookup_and_delete_batch()   hash, lru_hash,           u32
                                         percpu_hash,
                                         lru_percpu_hash,
                                         hash_of_maps
  generic_map_lookup_batch()             array, percpu_array,      key
                                         array_of_maps, lpm_trie
  __rhtab_map_lookup_and_delete_batch()  rhash                     key

All three walk the map in the order of bpf_map_get_next_key().
A map without map_lookup_batch returns ENOTSUPP and takes the old path.

> +		if (err && err != ENOENT)
> +			goto error;

The batch takes the bucket lock. htab_lock_bucket() can fail, and the
batch returns that error. bpf_map_lookup_elem() doesn't take the lock.
So a dump that works today fails here.

Something like this (not even compile tested):

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 4b65edf..a522d80 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -59,13 +59,18 @@ static int map_type_from_str(const char *type)
 	return -1;
 }

-static void *alloc_value(struct bpf_map_info *info)
+static size_t map_value_size(struct bpf_map_info *info)
 {
 	if (map_is_per_cpu(info->type))
-		return malloc(round_up(info->value_size, 8) *
-			      get_possible_cpus());
+		return (size_t)round_up(info->value_size, 8) *
+		       get_possible_cpus();
 	else
-		return malloc(info->value_size);
+		return info->value_size;
+}
+
+static void *alloc_value(struct bpf_map_info *info)
+{
+	return malloc(map_value_size(info));
 }

 static int do_dump_btf(const struct btf_dumper *d,
@@ -741,15 +746,10 @@ static int do_show(int argc, char **argv)
 	return errno == ENOENT ? 0 : -1;
 }

-static int dump_map_elem(int fd, void *key, void *value,
-			 struct bpf_map_info *map_info, struct btf *btf,
-			 json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
+static void print_map_elem(void *key, void *value,
+			   struct bpf_map_info *map_info, struct btf *btf,
+			   json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
 {
-	if (bpf_map_lookup_elem(fd, key, value)) {
-		print_entry_error(map_info, key, errno);
-		return -1;
-	}
-
 	if (json_output) {
 		print_entry_json(map_info, key, value, btf, cpu_ids, cpu_cnt);
 	} else if (btf) {
@@ -763,10 +763,70 @@ static int dump_map_elem(int fd, void *key, void *value,
 	} else {
 		print_entry_plain(map_info, key, value, cpu_ids, cpu_cnt);
 	}
+}

+static int dump_map_elem(int fd, void *key, void *value,
+			 struct bpf_map_info *map_info, struct btf *btf,
+			 json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
+{
+	if (bpf_map_lookup_elem(fd, key, value)) {
+		print_entry_error(map_info, key, errno);
+		return -1;
+	}
+
+	print_map_elem(key, value, map_info, btf, btf_wtr, cpu_ids, cpu_cnt);
 	return 0;
 }

+#define MAP_DUMP_BATCH_BYTES (1U << 20)
+
+/*
+ * Print the elements that batched lookups return. 'key' is the last of them.
+ * Return true at the end of the map. After any error the caller continues
+ * with bpf_map_get_next_key(). It walks the map in the same order.
+ */
+static bool dump_map_batch(int fd, void *key, struct bpf_map_info *info,
+			   struct btf *btf, json_writer_t *btf_wtr,
+			   const int *cpu_ids, int cpu_cnt,
+			   unsigned int *num_elems)
+{
+	void *keys, *values, *batch, *in_batch = NULL;
+	size_t value_size = map_value_size(info);
+	__u32 max_cnt, cnt, i;
+	bool done = false;
+	int err;
+
+	max_cnt = min(MAP_DUMP_BATCH_BYTES / (info->key_size + value_size),
+		      (size_t)info->max_entries);
+	/* The cursor is a u32 in htab maps and a key in all other maps */
+	batch = malloc(max(info->key_size, 4U));
+	keys = malloc(max_cnt * info->key_size);
+	values = malloc(max_cnt * value_size);
+	if (!max_cnt || !batch || !keys || !values)
+		goto out;
+
+	do {
+		cnt = max_cnt;
+		err = bpf_map_lookup_batch(fd, in_batch, batch, keys, values,
+					   &cnt, NULL);
+		if (err && err != -ENOENT)
+			goto out;
+		for (i = 0; i < cnt; i++) {
+			memcpy(key, keys + i * info->key_size, info->key_size);
+			print_map_elem(key, values + i * value_size, info, btf,
+				       btf_wtr, cpu_ids, cpu_cnt);
+		}
+		*num_elems += cnt;
+		in_batch = batch;
+	} while (!err);
+	done = true;
+out:
+	free(batch);
+	free(keys);
+	free(values);
+	return done;
+}
+
 static int maps_have_btf(int *fds, int nb_fds)
 {
 	struct bpf_map_info info = {};
@@ -836,7 +896,8 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	struct btf *btf = NULL;
 	int *cpu_ids = NULL;
 	int cpu_cnt = 0;
-	int err;
+	int err = 0;
+	bool done;

 	key = malloc(info->key_size);
 	value = alloc_value(info);
@@ -895,7 +956,11 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 		p_info("Warning: cannot read values from %s map with value_size != 8",
 		       map_type_str);
 	}
-	while (true) {
+	done = dump_map_batch(fd, key, info, btf, wtr, cpu_ids, cpu_cnt,
+			      &num_elems);
+	if (num_elems)
+		prev_key = key;
+	while (!done) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
 			if (errno == ENOENT) {

pw-bot: cr
