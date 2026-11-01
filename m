Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793512439;
	b=a2lCyuoPKseAcKaOZumnayFMzShvObkGyteKB9xwpq3eXenyidfoWJecEtlswkMi6Fup
	 Wat1HwSI8U9H1+LpYaHD6ylz99pX7fWpBqBgmRsmgCGMhcSAgnBHSEI6kSZSJwtH8qvmz
	 KrOnKhTVjtu0c1FcTsjVIjJNyDyt/kAPPWawYJsDm12AGr95SlVlveTJ/HIYLBO4RUzXl
	 uJR+L1m9JjwRlm34KuDK86iLlaFkOoNUlAvQZM32+Gir8s1G04i6XivCkMRG3MJim5oTQ
	 bEritU+DYCLo5NFC48RH5VS9H+zpCWlfuE5y4TytIUjlnBoHSkpDsLafONiUSMdmgWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=ioufz/eepkB2ZyxWnk5EcNVPNLUzq7sWRrlcQGZN19o=;
	b=SxSb9uab8S+ITHF/35/iwHlwlZ5G1XRR31ylRje+KoxFaCIjFZZCvVUurumJYF0ouSS4
	 4f6QvpA2PB7wLMlHRCQgaRelx/9rG0uhpJgl661DKnfCzRuGbUdeAt0zFig9TrbUaCGmm
	 SY4oLFJPevAiVtEs9d+kh4OF4u8i5Tv45kORketi+rC6lNED3c3fuO/eItcQJIIbrDPzt
	 TyyhCk5MPv+1VOpIKVVcx6k31wBNHQ/fOa1NOIHqSiqxSwrHjPFoYqTHfqAiqf9toL0bL
	 kPUQvcAJ9l87zsojbw1zSIOtG+K9JkJnTDrEc6DcHQaYFmeHzGekmknAXIw1P6rcslg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k2U4h8Oc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.70
Received: from mail-ed2-f6.google.com (mail-ed2-f6.google.com [74.125.228.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC0606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 05:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBDC0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k2U4h8Oc
Received: by mail-ed2-f6.google.com with SMTP id 4fb4d7f45d1cf-6a5d790cce1so1369276a12.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793512437; cv=none;
        d=google.com; s=arc-20260327;
        b=s7BWiQVMkO2zXhdP6FMh6Vu9Xu1XEN49LDloHCqOxvRJ8V79ytw+43d1o1xOk0DU0z
         Lx6H5NQb/xy6VePW90CJBBf830LI7CnxxHcX6TBR4SDtyYZQfXvXXR/4rWcV7pisqfN6
         ifL/9KWavu/9mXM4OedK/MH3iubaZVjfbwVBP2AJEe5UG0718dIi1LZ++Gny3XuMrLfc
         2Jm/wBMTnOiWlFQR58GHNw//aaRO0Ga4PfCfxQLVJR0oMAomaiHgcqX9yisDZsgC8q3/
         OeOP0RyK9ufnfT6H8OikxQz7kGYHH7FOrqhrG5XceGWFFCSuRrqAL27BkO+heVKM9r9L
         5lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ioufz/eepkB2ZyxWnk5EcNVPNLUzq7sWRrlcQGZN19o=;
        fh=NPVFJnkplS0XBaxDJfGZcLOa8RPQHO8kfhXKRMGAFb4=;
        b=M8SZzR2MRLSpSnYDF9APkTKmj7l0QLyjNWV+dewIYuNkLuTJO2aodu/KozjUCApEUi
         CYdlXK6aXqVXT4d2Wn60azTATFpWdSjH1MSTJ6z/APPaguQjZSdDFftWKMULzr+mMzdd
         f6NS6RugQ7KM1sbV47fhfXbTnsY466UOcdvIGbzNRnQqvVkMLZEKGhWQgg3K5RTudVMW
         xBWMgtZcZnXYVTdPI3JvW2VblJAgQrgfsEfCivlqnPy0LNojyF4/JVf686JCW9RpB6iJ
         Vc/cFUVDKDEhZ5iR8TIxTS5aPnHz8CISnECKEnqimVUeQKj3IxYd6dNbaa0bP0CjqT/s
         Kizg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793512437; x=1794117237; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ioufz/eepkB2ZyxWnk5EcNVPNLUzq7sWRrlcQGZN19o=;
        b=k2U4h8Oc27dGjhUi9Y5Cv8wpa7aVCR7L+0rkN4lIyy5JTScZPOFkWsw/S9mcGxISP4
         CXMWGoi/h0MuEQ98ydoOZMnc/0QGMnTd4j0LuLZrW3+/29pXai8K6jgwG98LexePnahL
         Fu7ZYxAtxxRPYMC8k8GOqBYLDuzy5PYLgko06v9Um9Zc3O1q+vcRQboDAVkILaCOC48G
         iCR9wMtYe2n3frGHonhUqMmX5ZCMsaIOc3Ijg352ENjiGrkT11TP+27JOdQclKECNGlD
         jP9hto9IP34uCk79NR/KP0N3Go7sYtJ/8Dc3D0oYz8+DJTp0YTe7eCAtTxbIJBe0U41v
         TK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793512437; x=1794117237;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ioufz/eepkB2ZyxWnk5EcNVPNLUzq7sWRrlcQGZN19o=;
        b=R4ZwtFngWxisgr4etdM4Ji7yPrxHm+ky8/FBwReA3e1k7jar2o+r76MpNYfOZEp7O3
         LyEs1zT9uk2v0o1RnnTmNgMxWHgvBf9z5N3Jc1kwKplLfp/5qenbt8ophfxAW/zIHPo/
         CHcF2K5Z5CewuQR025hAYvUhc9drSDBzrpVuds+CkKZSEGbronTpAbEsgwapf379stSb
         Q3TtbGAybhDWbKHx71K5CFZ2pb39ANFvoUTCW04iqYziDAzdVdVU1LPrbCUJpHZESPTg
         Q/qU39RAeuiPUIa5tKgasl8Lp7z9qHnEa8EwJYYs63e07R9xmZg2+2H54vy5ZryarvzC
         80Cg==
X-Gm-Message-State: AFq9FYJtiXtLiIjuY4qnOKjKXDkVJRAKb6UON4oYf/yDxUe0WwfsANet
	/27QjVIm+BRBZDiiEmzHyXkP7bol71sDl7/ZwB0BpHmqmkWgBvApca1vQ7oPNmhTKGZ59yYTN2X
	XhR3ackJTehSM8egE/Hrq3yfUAsKaaYzBVWfE9dliD/O2
X-Gm-Gg: AYBFou1HkAvAnIaekwCuKgCLXcA3HTiUwUXkzd6SkGy0LzZaldmbMrpEB5mfjPJWBEH
	HxB8yMswbt2HEqPGHcjL65BW4AvqzNwu7b8KivHuLJVCOAUGhUy6j6oCSbGEFJkVZlLj5G3jihT
	EqQTrFJCbACsGTaBq0BN7OnWIHprSwnzKB0DqOJn6PhwVgJWKNwEaep7n3el/LfCXnPKdQVDDIR
	8CUG2jSEzDbZDkZP/nOrZT0UxtZF6lzIEzEXelaSBw/LsAqixOGZLErpMkC3OEfWQLbzIqXYEc/
	Wz4k1xE/UYx1QYu5nplxL/eOcbSCJOYZZPSXnNgZM9COmxwcxVjGRJGy+1xXnlCkg37NJoiV9vz
	iBxYW4W0FpspyjXAMD1MlsxKmvU81/wZp34PFtHELp4UXPlXfV0UDnMb5cA==
X-Received: by 2002:a05:6402:13c2:b0:6b4:5870:9c03 with SMTP id
 4fb4d7f45d1cf-6b4d3372ca6mr4888718a12.6.1793512437076; Sat, 31 Oct 2026
 22:53:57 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5rSb?= <wanghai8081@gmail.com>
Date: Sun, 1 Nov 2026 13:53:47 +0800
X-Gm-Features: AclHuK9tE6JHACrbCzlvwTOKIx8KmeFMX0HOSVGkBlumrgtgnQ6-OURgSCS6O-Y
Message-ID: <CAPig4swEOLsU0K=Xskyh1p2nQALRfSojSW82g5LdsQd6nSetMA@mail.gmail.com>
Subject: [BUG] libbpf: btf__raw_data() returns stale data after btf__relocate()
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I found a case where btf__raw_data() returns stale data after a
successful btf__relocate(). The type references in memory are updated,
but the serialized data still contains the old references.

I reproduced this with libbpf commit
85c0d575a447651bbeb8e2376eacd64c30dce9a6 on Ubuntu 22.04, x86_64,
running kernel 6.8.0-138-generic.

The reproducer creates a split BTF with a pointer to an int in the
base BTF, then calls btf__raw_data() to populate the cache. It relocates
the split BTF to a new base where the int has a different type ID.
After relocation, the live pointer has the correct target, but
serializing and parsing it again gives the old target.

Save the following as repro_cache.c in the libbpf source root:

#include <assert.h>
#include <stdio.h>
#include "btf.h"

int main(void)
{
    struct btf *old = btf__new_empty();
    struct btf *target = btf__new_empty();
    struct btf *split, *roundtrip;
    const void *raw;
    unsigned int size;
    unsigned int live_id, serialized_id;

    assert(old && target);
    assert(btf__add_int(old, "int", 4, BTF_INT_SIGNED) == 1);
    split = btf__new_empty_split(old);
    assert(split && btf__add_ptr(split, 1) == 2);

    /* Populate the serialization cache before relocation. */
    assert(btf__raw_data(split, &size));

    assert(btf__add_int(target, "padding", 4, BTF_INT_SIGNED) == 1);
    assert(btf__add_int(target, "int", 4, BTF_INT_SIGNED) == 2);
    assert(btf__relocate(split, target) == 0);

    /* The pointer has ID 3 with the new base. */
    live_id = btf__type_by_id(split, 3)->type;
    raw = btf__raw_data(split, &size);
    assert(raw);
    roundtrip = btf__new_split(raw, size, target);
    assert(roundtrip);
    serialized_id = btf__type_by_id(roundtrip, 3)->type;

    printf("live_target=%u serialized_target=%u expected=2\n",
           live_id, serialized_id);

    btf__free(roundtrip);
    btf__free(split);
    btf__free(old);
    btf__free(target);
    return live_id == 2 && serialized_id == 2 ? 0 : 1;
}

Build and run with GCC and the libelf/zlib development packages
installed:

  make -C src -j2
  gcc -g -O0 -UNDEBUG -Isrc -Iinclude -Iinclude/uapi \
      repro_cache.c src/libbpf.a -lelf -lz -o repro_cache
  ./repro_cache

No root privileges are needed. Keep assertions enabled, since some
API calls in this reproducer are inside assert().

Actual output, with exit status 1:

  live_target=2 serialized_target=1 expected=2

Expected output, with exit status 0:

  live_target=2 serialized_target=2 expected=2

In the new base, ID 1 is padding and ID 2 is int, so the serialized
pointer ends up referring to the wrong type.

It looks like btf_relocate() updates the types and string offsets
without invalidating the raw-data caches. A later btf__raw_data()
call then returns the cached data through btf_get_raw_data().

I tried calling btf_ensure_modifiable(btf), checking its return value,
and then calling btf_relocate() in btf__relocate(). With that change,
the reproducer produces the expected output. Checks for both
endianness caches, file round-trips, and repeated relocation also
pass with the change.

I also added a regression test to the Linux 6.8 BPF selftests. It
fails before the change and passes after it in both test_progs and
test_progs-no_alu32. The broader selftests run needed compatibility
adjustments for libbpf 1.8 and had other failures and skips, so I
don't have a clean full-suite pass.

Would btf_ensure_modifiable() in btf__relocate() be the right way to
handle this? I couldn't find an existing report; please point me
to it if this is already being discussed.

Thanks.
