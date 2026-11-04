Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824285;
	b=fuJkM4ZF8WmA2KRxB7vlg6PZ+8R4qAhoXWDo3RdGloe61MEFIzV2a2ps7W2kcxdhJd8i
	 bnzX5KPJG8EmcpgQCl84jqMt6c1A4HFoCumi77u+Zz7lnzRWTLtut2tVt1hzi1+Zhx4/c
	 Vn9O1xHYfHlLxEEQ+5ikMrxjM32BKx+N9SOaK9R7D/L13iEtNK+E47q/+tVQXsJteBu7h
	 LeH5xccjcN98v0nFISRgrrJo5wnqOwdqxBO79bgLMqGPkt1KQCx6LJbQU/tolcETrKKoP
	 XrJOzW46cK3E6M8FW0pA29zYoc4z9toLYKzpQJRD7MqbfFQYlYJWUYnyz/YN2p8jwRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824285;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=QsP1oGJUZlZpjP1/87YykQzIVLED1z/hj//V22Zi4iQ=;
	b=XukxDYvhF4XCm3b/WlQRILJnxtvjwGdH4mAkUSVbb/lfL1Q5xMNcWzIS2cFNptO9xaH1
	 j0WS1iwqlE2attkpNNd7Mz/K0kjEspsDVtT6cnVebccJht3GP0DcHawSaKykoYgzqB6u+
	 rgU4fIMrZNNwut3HzgGaobRBDmO/B9AdOOzOwqK8EKbdRVX0hbi9dLzShylBduLtlaSSC
	 jJqdojUhcUszwr3meowfYaBb0I/i1v/qsUmUhW2NPvh6v4HkX1mWHNUu78Y6YNQeYeXBy
	 ndV1eV49Rgzx/3d2HXEck/8Qu3EaWsMA6LLIA3APdo1k25BQJn6IN9Jj7EjMLsKtz/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9ImckX6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321FD606AE29;
	Wed,  4 Nov 2026 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y9ImckX6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21DD1F000C1;
	Wed,  4 Nov 2026 20:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793824285;
	bh=QsP1oGJUZlZpjP1/87YykQzIVLED1z/hj//V22Zi4iQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Y9ImckX6YvAD8+w8xc088OiGYmjoTC62mheNaT3zSwlCK9lJbWFbD0tu2+hlWWhzN
	 UI/9GHXZGvS4RPLdTFwnzjCRuZ8pNoGBIM6qblE2tgO2ZqhRnoqg3PBS5Vo/BaPCVG
	 8cIz28sbcSIQfAqGiylDsfuPogfZyCUZwaunNLqobvipKx1e0yGNYoW1A0Cv0KSFtu
	 iGMEMKKw8Z/NbPxmqBFMOsCE6Y81vZ5rANnsxxFIL+1FDGaJjNAe4Rkv4fxIsJ0o24
	 fjDtD23rxXPbQH2CzAVsClM4/CiCpetxgUC3+nRfwC9ZA/iui42afxRVyLuCzfoy/R
	 52r3Xck5d+OeQ==
Content-Type: multipart/mixed; boundary="===============1535382468903377011=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <33b057d852c258c157f6aa31e45083418944efe0efaad1d72bcb5513205a67f6@mail.kernel.org>
In-Reply-To: <7a728136ad18840c94836ec1ce988f8bc2fcfb35.1793821981.git.hi@tychen.cc>
References: <7a728136ad18840c94836ec1ce988f8bc2fcfb35.1793821981.git.hi@tychen.cc>
Subject: Re: [PATCH bpf-next v9 1/2] bpftool: Use batch lookups for map dumps
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,bpf@vger.kernel.org
Cc: hi@tychen.cc,qmo@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ihor.solodrai@linux.dev,linux-kselftest@vger.kernel.org,shuah@kernel.org,daniel@iogearbox.net,ast@kernel.org,alexei.starovoitov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 20:31:24 +0000 (UTC)

--===============1535382468903377011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Use batch lookups for map dumps

TL;DR: For BPF_MAP_TYPE_RHASH, a concurrent delete may make batch lookup
return -ENOENT early, so bpftool map dump could silently print a short dump as
success, unlike the old get_next_key walk.

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

[ ... ]

> +static bool dump_map_batch(int fd, void *key, void *value,
> +			   struct bpf_map_info *info, struct btf *btf,
> +			   json_writer_t *wtr, const int *cpu_ids, int cpu_cnt,
> +			   unsigned int *num_elems)
> +{

[ ... ]

> +	do {
> +		count = capacity;
> +		err = bpf_map_lookup_batch(fd, in_batch, batch, keys, values,
> +					   &count, NULL);
> +		if (err && err != -ENOENT)
> +			goto out;
> +		for (i = 0; i < count; i++) {
> +			/* Preserve alignment for odd-sized BTF keys and values. */
> +			memcpy(key, keys + (size_t)i * info->key_size, info->key_size);
> +			memcpy(value, values + (size_t)i * value_size, value_size);
> +			print_map_elem(key, value, info, btf, wtr, cpu_ids, cpu_cnt);
> +		}
> +		*num_elems += count;
> +		in_batch = batch;
> +	} while (!err);
> +	done = true;

For BPF_MAP_TYPE_RHASH, can the kernel return -ENOENT before the real end
of the map, so that this code silently produces a short dump?

In __rhtab_map_lookup_and_delete_batch(), each element is copied and then
the next one is looked up from the copied key:

    memcpy(dst_key, elem->data, key_size);
    ...
    elem = rhashtable_next_key(&rhtab->ht, dst_key);
    ...
    if (elem && !IS_ERR(elem)) {
            memcpy(cursor, elem->data, key_size);
            has_next_cursor = true;
    }
    ...
    if (!has_next_cursor)
            ret = -ENOENT;

If a BPF program or another process deletes that element between the
memcpy() and rhashtable_next_key(), __rhashtable_next_in_table() cannot
find prev_key and returns ERR_PTR(-ENOENT).  The call then returns the
elements copied so far with -ENOENT, the same code used for a real end of
the map.

dump_map_batch() prints those elements, leaves the loop, sets done = true,
and map_dump() skips the bpf_map_get_next_key() loop and prints "Found N
elements" and returns 0.  Every element after that point is missing, with
no error.

Before this patch, bpftool walked RHASH maps with bpf_map_get_next_key(),
and rhtab_map_get_next_key() restarts from the first key when the previous
key was deleted:

    if (PTR_ERR(elem) == -ENOENT) elem = rhashtable_next_key(&rhtab->ht, NULL);

So a concurrent delete could previously cause duplicates but not a short
dump reported as success.  The comment in
__rhtab_map_lookup_and_delete_batch() says a lost cursor returns -EAGAIN
so userspace can distinguish it from -ENOENT, but that only holds between
calls, not within a single call.

Does this contradict the commit message statements "The output is
unchanged" and the fallback "after any error"?  The root cause may be in
the kernel's rhtab batch code, but this patch makes bpftool depend on it.
I did not see a later patch in the series that addresses this.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41903699624
--===============1535382468903377011==--
