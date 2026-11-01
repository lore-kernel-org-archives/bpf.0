Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793523579;
	b=RCCcY6fE+fYg2pVoYZ/xznGBUCHmEmHZe0PFiV1Eb6INDE90Pk0TyTiJeKE6JHNb2Mkv
	 JBCp+SV/C+uvRbMo1xxgyFVF/uz/sOgDlobocdw4PSrSDd/zscrdWcUV0R/JvJZat+2zC
	 cjnHGuDOesYP3Y+1TwjmXNtJmai1JroQOVyOZGi0a7YR5mREJEnIXV5u4KogGs2/cs77q
	 e8+Bvb667vjWsya8+NsjGWKyq9xRowzM06IwQDPImu3yYIuPXvz4f6GrZ6WWUtQ8Xfq/L
	 Ou3C+cnru9plQVaLnx9qI9coaWZfojjmWkOK0SxCw47SAXKLBpf2dsVRvFhm/9tBTBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793523579;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4kxF/94wbk2i6i6EpQc2k4Yrf154N/75+q/upOz5nY4=;
	b=hllDFUx083Hi3Oxe8bP3+h5AtNr0uHVYM7fvDMNcF/W7oXCcG17XrS0Px6lrDhJg/U6Q
	 UuwTUJ88QGGzNy5vBiwjbjBIgOTLuOJqzeCjtfkGZV7GrHCXLGIuayzBRsgk04WA1zsBi
	 dg0WkggtZOFqlF1snU3C7o14jSWy5C2AoPVZdl5Gm+CeWZFTmdhoFKTwFaQUtXj2iSjIp
	 GzzAGtej3dJhwAgvAM41HPdxbghTwd78tf1IDxiXzpE4BpHeaQkjGwg+MpyIIZ6KGG1vC
	 EAsnkTejgsmwLt5BA+McDaOXnrzPQ1G9j5oj09ynCNEhapjXPQQEzs5hUjsv1eWg/Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iaNAkeXr;
	arc=none smtp.remote-ip=95.215.58.23
Received: from mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57747606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 08:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57747606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=iaNAkeXr
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zJCLMv9oohgEU5GfF1c6n3tzdOi91gEiAjTsaLmb7pg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793523575; v=1; x=1794128375;
 b=iaNAkeXr8vinftj3+7HcK3/9YLM4DfZqFenKDNBGnqUU+p3IvJUaZJ9eGskMwK/19Di6NT9m
 KsD1xKFeixNvYBm/b/vwl+SKmKTgf/QPbyhLT5B2ENIHpEA5mkL9mlDTbVI196tIttV91qcGx7i
 j6HY0Ifky0Pj+j4sg4enqHFY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 406eb5847f623d12;
	Sun, 01 Nov 2026 08:59:35 +0000
X-Mizu-Trace-ID: 406eb5847f623d12
X-Migadu-Flow: FLOW_OUT
Message-ID: <455f7257-25b9-4070-8313-42af8005b948@linux.dev>
Date: Sun, 1 Nov 2026 16:59:28 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] libbpf: btf__raw_data() returns stale data after
 btf__relocate()
To: =?UTF-8?B?5rSb?= <wanghai8081@gmail.com>, bpf@vger.kernel.org
References: <CAPig4swEOLsU0K=Xskyh1p2nQALRfSojSW82g5LdsQd6nSetMA@mail.gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAPig4swEOLsU0K=Xskyh1p2nQALRfSojSW82g5LdsQd6nSetMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/1/26 1:53 PM, 洛 wrote:
> Hi,
>
> I found a case where btf__raw_data() returns stale data after a
> successful btf__relocate(). The type references in memory are updated,
> but the serialized data still contains the old references.
>
> I reproduced this with libbpf commit
> 85c0d575a447651bbeb8e2376eacd64c30dce9a6 on Ubuntu 22.04, x86_64,
> running kernel 6.8.0-138-generic.
>
> The reproducer creates a split BTF with a pointer to an int in the
> base BTF, then calls btf__raw_data() to populate the cache. It relocates
> the split BTF to a new base where the int has a different type ID.
> After relocation, the live pointer has the correct target, but
> serializing and parsing it again gives the old target.
>
> Save the following as repro_cache.c in the libbpf source root:
>
> #include <assert.h>
> #include <stdio.h>
> #include "btf.h"
>
> int main(void)
> {
>      struct btf *old = btf__new_empty();
>      struct btf *target = btf__new_empty();
>      struct btf *split, *roundtrip;
>      const void *raw;
>      unsigned int size;
>      unsigned int live_id, serialized_id;
>
>      assert(old && target);
>      assert(btf__add_int(old, "int", 4, BTF_INT_SIGNED) == 1);
>      split = btf__new_empty_split(old);
>      assert(split && btf__add_ptr(split, 1) == 2);
>
>      /* Populate the serialization cache before relocation. */
>      assert(btf__raw_data(split, &size));
>
>      assert(btf__add_int(target, "padding", 4, BTF_INT_SIGNED) == 1);
>      assert(btf__add_int(target, "int", 4, BTF_INT_SIGNED) == 2);
>      assert(btf__relocate(split, target) == 0);
>
>      /* The pointer has ID 3 with the new base. */
>      live_id = btf__type_by_id(split, 3)->type;
>      raw = btf__raw_data(split, &size);
>      assert(raw);
>      roundtrip = btf__new_split(raw, size, target);
>      assert(roundtrip);
>      serialized_id = btf__type_by_id(roundtrip, 3)->type;
>
>      printf("live_target=%u serialized_target=%u expected=2\n",
>             live_id, serialized_id);
>
>      btf__free(roundtrip);
>      btf__free(split);
>      btf__free(old);
>      btf__free(target);
>      return live_id == 2 && serialized_id == 2 ? 0 : 1;
> }
>
> Build and run with GCC and the libelf/zlib development packages
> installed:
>
>    make -C src -j2
>    gcc -g -O0 -UNDEBUG -Isrc -Iinclude -Iinclude/uapi \
>        repro_cache.c src/libbpf.a -lelf -lz -o repro_cache
>    ./repro_cache
>
> No root privileges are needed. Keep assertions enabled, since some
> API calls in this reproducer are inside assert().
>
> Actual output, with exit status 1:
>
>    live_target=2 serialized_target=1 expected=2
>
> Expected output, with exit status 0:
>
>    live_target=2 serialized_target=2 expected=2
>
> In the new base, ID 1 is padding and ID 2 is int, so the serialized
> pointer ends up referring to the wrong type.
>
> It looks like btf_relocate() updates the types and string offsets
> without invalidating the raw-data caches. A later btf__raw_data()
> call then returns the cached data through btf_get_raw_data().
>
> I tried calling btf_ensure_modifiable(btf), checking its return value,
> and then calling btf_relocate() in btf__relocate(). With that change,
> the reproducer produces the expected output. Checks for both
> endianness caches, file round-trips, and repeated relocation also
> pass with the change.
>
> I also added a regression test to the Linux 6.8 BPF selftests. It
> fails before the change and passes after it in both test_progs and
> test_progs-no_alu32. The broader selftests run needed compatibility
> adjustments for libbpf 1.8 and had other failures and skips, so I
> don't have a clean full-suite pass.
>
> Would btf_ensure_modifiable() in btf__relocate() be the right way to
> handle this? I couldn't find an existing report; please point me
> to it if this is already being discussed.
>
> Thanks.


Thanks for the report. Yes, btf__relocate() misses invalidating the
cached raw_data, and btf_ensure_modifiable() is the right fix, same
as btf__permute() does. I can fix it.

BTW, how did you run into this? Is there a real use case
that calls btf__raw_data() before and after btf__relocate().

