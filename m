Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFB93148C5
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162370; cv=none; b=lEsPVz3i05K5GDT4wOMvL83VBlzD0sulMi0V3332J8tuAGHmrYLwNwyO4JYDNNK3gfdUxVRgyJFix2kgg317BgHhnZYpmev8NtO9TvE6FsB1UyJOJbLMinmu/Y7jZEJl1EFzzi9cbdE+/dTqDFVvfsnEQtlaSrM/WW45LDFi8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162370; c=relaxed/simple;
	bh=g4+lpkTFzZ84Hu9S3hC2BBSv5+W9Vj77HwAIY4AFkiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T30c2OqoEEURfjT1zA5w6p25wJNfYNE5U9Ov3Ip6tO2+WrzVh6YAXn6IofqbeiKVDeTtuQJNgfxZsAqFaH6ycs9WoUwkzHZ5xwK5Sy0uKnQQhdy4KSDP9GmieT1tpYbRlaRlLkr+LSDRO5jdtFzjcnXiuKImFYGBfMef0Jte6cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CLrSQzXN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CLrSQzXN"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776162358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO/v3k9uUxqgU17CMnruT3FSNRmDF0Sm8EGBRKKm8Hg=;
	b=CLrSQzXNwTPKlEJesI77hXB6EDg5TC3T4M4UAVfXNp57yYwGuda6Qoi+Y8vD/zFV7z1hFN
	ZOdQ1Kpx+YwG+rHnR4O8RRXx9/rPUuKEib3lo9JDvnkD/tcct4sJr+VcZ/S9uGIMtP1HWi
	wbl7uzOwEJTG/G08BQGHHhM+wt6mJIU=
From: Leon Hwang <leon.hwang@linux.dev>
To: mykyta.yatsenko5@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	herbert@gondor.apana.org.au,
	kafai@meta.com,
	kernel-team@meta.com,
	memxor@gmail.com,
	yatsenko@meta.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: Re: [PATCH RFC bpf-next v2 03/18] bpf: Implement lookup, delete, update for resizable hashtab
Date: Tue, 14 Apr 2026 18:25:36 +0800
Message-ID: <20260414102537.386868-1-leon.hwang@linux.dev>
In-Reply-To: <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
References: <20260408-rhash-v2-3-3b3675da1f6e@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 08, 2026 at 08:10:08AM -0700, Mykyta Yatsenko wrote:
[...]
>
> static int rhtab_map_lookup_and_delete_elem(struct bpf_map *map, void *key, void *value, u64 flags)
> {
>-	return -EOPNOTSUPP;
>+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>+	struct rhtab_elem *l;
>+	int err;
>+
>+	if ((flags & ~BPF_F_LOCK) ||
>+	    ((flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK)))
>+		return -EINVAL;

At the moment, we can check the flags using bpf_map_check_op_flags() helper.

This helper can be applied to flags check in this series.

>+
>+	/* Make sure element is not deleted between lookup and copy */
>+	guard(rcu)();
>+
>+	l = rhtab_lookup_elem(map, key);
>+	if (!l)
>+		return -ENOENT;
>+
>+	rhtab_read_elem_value(map, value, l, flags);
>+	err = rhtab_delete_elem(rhtab, l);
>+	if (err)
>+		return err;
>+
>+	check_and_init_map_value(map, value);
>+	return 0;
> }
[...]
>
>-static void rhtab_map_free_internal_structs(struct bpf_map *map)
>+static long rhtab_map_update_elem(struct bpf_map *map, void *key, void *value, u64 map_flags)
> {
>+	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>+	struct rhtab_elem *elem, *tmp;
>+
>+	if (unlikely((map_flags & ~BPF_F_LOCK) > BPF_EXIST))
>+		return -EINVAL;
>+
>+	if ((map_flags & BPF_F_LOCK) && !btf_record_has_field(map->record, BPF_SPIN_LOCK))
>+		return -EINVAL;

ditto

Thanks,
Leon

>+ [...]
