Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AF37BE7D
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791009715; cv=none; b=n6E/5i0ngKkb0o5h+EJ1nrmQrOHWm3WY0QDU648tka88+unfvqLF5g+05VeSE/wJjSIhVSJnjV4AMiUaHjMVGpcGoiFJS6wGfN+lLp91XtPvqP1r7Q1kp7OA2HbzdTO7YZz1KLSYslpg97B95d8LgWy8KWtCZZGjDCRM9d89ibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791009715; c=relaxed/simple;
	bh=Ft/2WnP2ps3/fBEuFcw7OdRkXuXboIYNtyZxDWWK5UQ=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=H5pXHy6cEzoV85DaKmelpJz16J6VLyfi9lztpTAGgdJUYC1GPXf2sl4dRw40gONb1X7DPqfC97b8sLFpoxpByEYl2O9vio1QHycZW3yP5dKgk8NVZXaj3kGELNr8RAqoRtfS3pJDQ1XawPn4Bi2r7t5tN0T/VeI0xeBtf2ePKe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XGeVVoxp; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGeVVoxp"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a6df9494e5so36939a91.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 23:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791009709; x=1791614509; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jVG6AlODq7cmQhMYgJzsMhMHRGmznwDk8B1ECX83RpE=;
        b=XGeVVoxpOiXYZtYGqG2yU2GxkPlaJskUAPh9fd+fTTtkhO/CiXOUeP7vrTtwweqegv
         Ljmt/9il3LgQJk6CajihNmrwh0E70LRStYzdv7PnpZUe8h2V6HejSTM7CZQNqgcvIZsI
         AcbU5Ri+BcVw08rxjTuH+vVLhxKSlGFpSxiDzv4oQIGydsYjLCD+/e+8EK1xm7FVq7T5
         1hR/soVkKp6K6bkZUF6OM9RWrt23cVJ+mDLXjylGf7pnrclIfO9Ayw55JqqhkYITfoNJ
         oAcXeji8Iu0lj+dlrcqVXl+BhPpKdHwQ5Hh65K3R2l3TvLIpjcA69NwXsYN7URlDQ5QZ
         xS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791009709; x=1791614509;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jVG6AlODq7cmQhMYgJzsMhMHRGmznwDk8B1ECX83RpE=;
        b=Y3Ftx9aR7zlq0cQfKCOIhnzARCA8vgzS76H7/TxSN4mELF7/OtiY/HVpSxCmzGI3Vc
         GgB0NqMHsotjyHzsE25u5JZxxYLai5FSTMxF10ltiWeVIuZq9JcBLCOlkhzfCaUiewLz
         8imelBc9bXr7glMTnECgErNxigOeltewnncKt1SzUiiti0w+y6btDRJlvNurxsB2gmX5
         Bb2ZUVZgfZ0ykvzGRb4Ut/Cx2Gn9g12lo7O3FILMpSb5Lo9MzHUvHWichV75YCPs/Aaz
         YTkav4FML1TrO83nEYfD0RooCDtiVxXHy/0hUEoEjBXpVAtR5srkYARL/jhDwF6+CCyG
         QI9A==
X-Gm-Message-State: AFq9FYI4n5d2HyIbfkZB+OW0rVYY7BFoD5SPh5IZ1Qjn3i0kEMe3UzVw
	hkpXB3jYnVkT87+zKZxepgU7FTk99j/wGbL1tdsBAzvNimfDjmfR2TdO
X-Gm-Gg: AYBFou1eSCXhCnVcKGOeInkdp6nnCvyWO7lfp43b+xh1V8lnwi02eG1E/est1p5DscX
	fsvJEP6LXqeRmgln67F+UTLzbq1CT395fN+FefVv21ngp68vl+NQUiCdtoim84lrH1hok3eDk43
	or8+pJpmPeI5yNwe40hLCUZOP9Dg7Gki1Zanc5vbdryxAW6k/wYi2U5nlMmrqUNZnl9+1PFk14f
	6mKKBbnjNIYuJt52ur9A1ovzVA2sbP018xDVIb2iD0ien+G1R9gakkDuyvHJpecAVHvBY599JGE
	k7i5EvCUjt+y8lCnJ4JF1GvkVR2WspJXd6wlqeoYZFhV6TEQEUpeP5TB13qLmmsJJexIDAt3Y1u
	WkTn4StkjdRC+ZLuWowTpBLBOtoAVnsteb0uzQqoznYbkXr7IECCD2uzRaFu7bPZ+aykjzSeIlE
	GRb1ejsxkmsZO07SM6Yr8CzZUZMq/50cZXipUs0RoXpBBEdXYpFmsKQSi6ijPQW/vHou/uSirAB
	mRTJGXn7Ntys1Y0wKrLpD5lII1LnT8WMYxngWh8vWbta07tfYW/jCnFVLqJkgUG69VdyMSEO6PC
	FoI=
X-Received: by 2002:a17:90b:3ec7:b0:3a0:2900:f55e with SMTP id 98e67ed59e1d1-3a6cec20416mr3084840a91.29.1791009709004;
        Fri, 02 Oct 2026 23:41:49 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d65d85csm1772623a91.4.2026.10.02.23.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 23:41:48 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 06:41:48 +0000
Message-Id: <DLUZYDAX6849.KKV543CJGGXH@gmail.com>
Subject: Re: [PATCH bpf-next v8 2/2] bpf: htab: Reduce elem_size by 8 bytes
 for small key sizes
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <mykyta.yatsenko5@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20261002161738.621133-3-tjmercier@google.com>
References: <20261002161738.621133-1-tjmercier@google.com> <20261002161738.621133-3-tjmercier@google.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 09:17 AM T.J. Mercier <tjmercier@google.com> wrote:
> +static __always_inline struct htab_elem *
> +__lookup_elem_raw(struct bpf_htab *htab, struct hlist_nulls_head *head,
> +		  u32 hash, void *key, u32 key_size,
> +		  struct hlist_nulls_node **out_n)
>  {
>  	struct hlist_nulls_node *n;
>  	struct htab_elem *l;
>
> -	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> -		if (l->hash == hash && !memcmp(&l->key, key, key_size))
> -			return l;
> +	if (htab_has_hash(htab)) {

[...]

> +		unsigned long k = 0;
> +
> +		memcpy(&k, key, key_size);

My bot is saying that this will break 32-bit builds with FORTIFY_SOURCE.
__htab_map_lookup_elem_u64() inlines all of it with key_size == 8.
has_hash is a run-time load, so the compiler has to keep this branch
and it's a memcpy of 8 bytes into 4 byte 'k'.
fortify_memcpy_chk() will hit __write_overflow_field().
That's a build error in i386 and arm allmodconfig.

has_hash is a compile time constant in __htab_map_lookup_elem_u32()
and _u64(), just like key_size.
Only htab_map_gen_lookup() emits them, so the map is BPF_MAP_TYPE_HASH,
never LRU.
Don't read it from htab in these two.

pw-bot: cr
