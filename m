Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793541447;
	b=Fj+0wrluT95DYjSWVzc5MGMTw4qj4ouIFSvBQPMDg50peEiTo5H6zcaW3b3M6qM6fRUi
	 dXJti25GowTUbR+7kp+qbiTJIcQxGiUB6LYfTZ1XNGbxyX6dew+2uuUrsVzSfSteXuHfk
	 gfejynVJlBy6svDAbnTjyhCo+hcHPY7YrAD8KiFmGsaJ0IiWXVCU3Ka8aZYFTAXzTrw0F
	 EGUzhU/hbX7mxRBbmxy5W5mk8pYWIU2UPzIdyi8fG+hFzaW07/lp0e33Skx7UJ368t0cA
	 WDbmKlhJTvgrB6iUeStsx/k+n1U6KjuFuMsfK9sBKEk9njLNaoEpr1xJTfaLgofuKDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793541447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Uzn2cQrdHx8KtdifFYHzLFN48FBFi3ukVc3HuIUKO1M=;
	b=gjHD9pK6c3ERiFHv3Jhd4Rh/qDVsXQK/WUM5XZ1ebr86N1vuZ4q0b/eA9jXRwTfxoZO0
	 PguR6dWEZQswNV3n56iyamONDhWOk3v+sqb1CD+ExLHeu+5yYu49ekLz97n200FJTdHgP
	 v+pYyl1q0B+JP40imthEtWGwHR8VegIJvTvzvGj0gWMdTxrPM5eENnEjkU/Fk/P9jBXCF
	 1yWkr4h/ne9YyTm5atanWgTgRhu8foEBr8ATsLBvjGT4QLzO3QuYJmFKths+1Mc/bWeSN
	 Upw4FJCe9fPa9hmC12ztzxMY3cU6fX201iSqusm21um45ZtXwp+G5EOW3XwUWY7KzWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eIu6uFQD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.228.73
Received: from mail-ed2-f9.google.com (mail-ed2-f9.google.com [74.125.228.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65B606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 13:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA65B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eIu6uFQD
Received: by mail-ed2-f9.google.com with SMTP id 4fb4d7f45d1cf-6b4c466f6easo1576174a12.1
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 05:57:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793541445; cv=none;
        d=google.com; s=arc-20260327;
        b=cW4JoG+Cd4qL1ulJcGosLzn1alfECplO5S4UQHoXafCbrEoLO7QwDJpB8NVUVuWiU9
         eDT6A5S9+AY2TMR0ZaovukRA13kRYSdM3Zo1553FyoAVGOr22lTysRMNfRR/4SaYhiD4
         zEPnTYfndKWbLqL4D3ImltjnU6PVvuQQjDsgO3sKyGIJYcqjS/eHdiYGdb3cJ18jZxZu
         0LyRY8m26o1MmFqYZlUW9GZukn4sp9ilKfUkXF6ijiO4SrGUmTprIo9xW/7M/uZ1G7WI
         n1/vQUhxUv09pXpT6uDF+szDO6ppjAoIW7s3dyJ7YwTz9kSufXHLedCq39A7GYhSZ3pQ
         NkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uzn2cQrdHx8KtdifFYHzLFN48FBFi3ukVc3HuIUKO1M=;
        fh=reXLPDvBV9anBk2vQXHDTBPjbIlXjLlO8spXMJ5OuJY=;
        b=SwDOTWpXI1xubzeJHAe4RG9+hxBglZuoIp9V7iVBAAX18HFuCRKcLDgOgcnX1USicJ
         +TncbubvSdvUfx/022h8E5S0SHeZIg8qCfaLn9h2g8ZE1NKVMXnyd6rRjADrlAivsYpz
         o3B3miIeHR4ere2DtMofFSER9HpN+x/I6mKNcROtppCEDao4/Z3TP0uEWQAN965mWjYD
         bMc/0v4nwiy3khFI8tYqcg2s6F+NZ/phb2UZ1NeQaPAcn4k1+/EcAlPTf5MJfUs3xykI
         WYIAJKCVUKjQ7tYGPuhhG1AIN9lx0DObo0j1gi2BOpnoly6bde+LwdCGUz9KQDXJqMRm
         WNGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793541445; x=1794146245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uzn2cQrdHx8KtdifFYHzLFN48FBFi3ukVc3HuIUKO1M=;
        b=eIu6uFQDRNE91zJlIPShp6hrEb8jruNpJNccy3uL/bUTVjUDVBGp9AEcmMo28VDnMZ
         1wYp9Q9MnlHBq5fe6XtgqgRMwCT7gkjbvR+PPAB4KXOiE9ndlG2MyC0Htet9lty/TLM1
         t0rssJXXZqFNiTwiHw2SL1r/Bg0+Y4ZoiuSq5mjvnPUpyHLDmjArO4AKbsaycsvO97B2
         EobNke7mFCrsvKqCtlwIJQNIt3obMVt6PvsdcFWiVF9s2x6ILH0+xrWcTO12V+ZW1pR8
         w3AJ4T7Nemsnv0Jp7tEKB7tMK8BlHl/OJCxlL3yqaT3dGwOSc5B8q6HL0hzrf+CFvp6B
         6QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793541445; x=1794146245;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uzn2cQrdHx8KtdifFYHzLFN48FBFi3ukVc3HuIUKO1M=;
        b=2LKMbsPKvaTNMv/yeNs1B7/r2TcybDDAUmXF4Ox9y5/xqNxPYdVAOTFth0P+vcB5lj
         6s9/HEjwK7jcck7twhU2/WadtVULSGHjkUJNLiOxzSPacsZdI2V3oMGEM8Jgr/tI/wuq
         WjL9Mef2jZ95H/pBYrvrX1Il7EBAASuD/UJyOa8BzA4h+RPKhZ+th3kM7MPlrpk9Pf9K
         euDH125tfLv74njgJjE3pulNedHqAh5q3TVwn2PPlKdCqYShx+X97Rb7TKJZWfd85YiW
         dZcZymfiE/Fnb/sBsKbliobYkHYGxFZMFev+xqQFB4Da0SHgYzJA3Su1WDOMCP2BM4nC
         HyHw==
X-Gm-Message-State: APuU4Z8f/60mZbdwjD3d0m/+OAjKyi8q3Kw1psgFsaaElh4I6PUu/2jp
	iPmjN5oPKi0GfevufHL1zAUWtLNfA89pT8PdcTmlnTX60Q0NMkfNQX44+NP1zG7dzMXbLDUnaAj
	/cOnL7G5lXqYNfy3JCToXya9q0SSADQw=
X-Gm-Gg: AYBFou1OWtbEjKtnDFq2zTloo4piBwrnw/jI9UEALsp5gANiAeTkPDBLlEGFaWkG58d
	gf061A49Rkjh0uVHNVUviyXTjiRmQD6dMX1bCiMqbIASyWsrQPTRs94/uIPE1mL4xNeCaUhrpqq
	3hsGjOqs6l2nWLZkDKX017zIY40DsvBGYj/8Xtamuk8H0l6QQ646xi9/SJsM0LqeVFk7dtHN8v9
	RaaeHDqZSYoUgI7HmrWweZD2NnfjaSu+4L/06oXgkB8QopsHd7p1DzA9he7i/RSacw+JWTlurGJ
	qFWp9xf+2wCx8lMgETmH/6pMTDbsD+3vZGmY7NpVrA6tgzuyiPiaS7BG+tguYc0BuGPleKrdskF
	JL/UgsVywGXXS5hIYO/hPAVJ17AMQfaM9XxqhE0wpcu7l//RrcV8bpoc4DXAi1We7Dok4HFnn0a
	RQFGxbjvkdV44U
X-Received: by 2002:aa7:c693:0:b0:6b1:abe7:8276 with SMTP id
 4fb4d7f45d1cf-6b4d33ab545mr3617805a12.2.1793541444897; Sun, 01 Nov 2026
 05:57:24 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAPig4swEOLsU0K=Xskyh1p2nQALRfSojSW82g5LdsQd6nSetMA@mail.gmail.com>
 <455f7257-25b9-4070-8313-42af8005b948@linux.dev>
In-Reply-To: <455f7257-25b9-4070-8313-42af8005b948@linux.dev>
From: =?UTF-8?B?5rSb?= <wanghai8081@gmail.com>
Date: Sun, 1 Nov 2026 21:57:12 +0800
X-Gm-Features: AclHuK_WqRetwnxTEAHFqamKJ34lcqIq9vge6V1HAILSLipHaYfa6xMfDjydZv0
Message-ID: <CAPig4sz=1FAJSRcpyGGN_dsdgUfj9Asnujiyd7VnyWu+h4McSQ@mail.gmail.com>
Subject: Re: [BUG] libbpf: btf__raw_data() returns stale data after btf__relocate()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiayuan,

Thanks for confirming and offering to fix it.

I found this while reviewing and testing the BTF APIs. I don't
have a production case to point to.

Thinking about how this might come up in a build workflow, a tool
could use btf__distill_base() and save the resulting base and split
BTF as reusable metadata. It could then keep the same split BTF
object in memory, relocate it against a compatible target kernel's
BTF, and write out a version for that target.

In that case, the first btf__raw_data() call would be for saving
the reusable copy, and the second would be for writing the
relocated output. That's one possible use case I can imagine,
though I haven't used this workflow in practice.

Thanks.

Jiayuan Chen <jiayuan.chen@linux.dev> =E4=BA=8E2026=E5=B9=B411=E6=9C=881=E6=
=97=A5=E5=91=A8=E6=97=A5 16:59=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On 11/1/26 1:53 PM, =E6=B4=9B wrote:
> > Hi,
> >
> > I found a case where btf__raw_data() returns stale data after a
> > successful btf__relocate(). The type references in memory are updated,
> > but the serialized data still contains the old references.
> >
> > I reproduced this with libbpf commit
> > 85c0d575a447651bbeb8e2376eacd64c30dce9a6 on Ubuntu 22.04, x86_64,
> > running kernel 6.8.0-138-generic.
> >
> > The reproducer creates a split BTF with a pointer to an int in the
> > base BTF, then calls btf__raw_data() to populate the cache. It relocate=
s
> > the split BTF to a new base where the int has a different type ID.
> > After relocation, the live pointer has the correct target, but
> > serializing and parsing it again gives the old target.
> >
> > Save the following as repro_cache.c in the libbpf source root:
> >
> > #include <assert.h>
> > #include <stdio.h>
> > #include "btf.h"
> >
> > int main(void)
> > {
> >      struct btf *old =3D btf__new_empty();
> >      struct btf *target =3D btf__new_empty();
> >      struct btf *split, *roundtrip;
> >      const void *raw;
> >      unsigned int size;
> >      unsigned int live_id, serialized_id;
> >
> >      assert(old && target);
> >      assert(btf__add_int(old, "int", 4, BTF_INT_SIGNED) =3D=3D 1);
> >      split =3D btf__new_empty_split(old);
> >      assert(split && btf__add_ptr(split, 1) =3D=3D 2);
> >
> >      /* Populate the serialization cache before relocation. */
> >      assert(btf__raw_data(split, &size));
> >
> >      assert(btf__add_int(target, "padding", 4, BTF_INT_SIGNED) =3D=3D 1=
);
> >      assert(btf__add_int(target, "int", 4, BTF_INT_SIGNED) =3D=3D 2);
> >      assert(btf__relocate(split, target) =3D=3D 0);
> >
> >      /* The pointer has ID 3 with the new base. */
> >      live_id =3D btf__type_by_id(split, 3)->type;
> >      raw =3D btf__raw_data(split, &size);
> >      assert(raw);
> >      roundtrip =3D btf__new_split(raw, size, target);
> >      assert(roundtrip);
> >      serialized_id =3D btf__type_by_id(roundtrip, 3)->type;
> >
> >      printf("live_target=3D%u serialized_target=3D%u expected=3D2\n",
> >             live_id, serialized_id);
> >
> >      btf__free(roundtrip);
> >      btf__free(split);
> >      btf__free(old);
> >      btf__free(target);
> >      return live_id =3D=3D 2 && serialized_id =3D=3D 2 ? 0 : 1;
> > }
> >
> > Build and run with GCC and the libelf/zlib development packages
> > installed:
> >
> >    make -C src -j2
> >    gcc -g -O0 -UNDEBUG -Isrc -Iinclude -Iinclude/uapi \
> >        repro_cache.c src/libbpf.a -lelf -lz -o repro_cache
> >    ./repro_cache
> >
> > No root privileges are needed. Keep assertions enabled, since some
> > API calls in this reproducer are inside assert().
> >
> > Actual output, with exit status 1:
> >
> >    live_target=3D2 serialized_target=3D1 expected=3D2
> >
> > Expected output, with exit status 0:
> >
> >    live_target=3D2 serialized_target=3D2 expected=3D2
> >
> > In the new base, ID 1 is padding and ID 2 is int, so the serialized
> > pointer ends up referring to the wrong type.
> >
> > It looks like btf_relocate() updates the types and string offsets
> > without invalidating the raw-data caches. A later btf__raw_data()
> > call then returns the cached data through btf_get_raw_data().
> >
> > I tried calling btf_ensure_modifiable(btf), checking its return value,
> > and then calling btf_relocate() in btf__relocate(). With that change,
> > the reproducer produces the expected output. Checks for both
> > endianness caches, file round-trips, and repeated relocation also
> > pass with the change.
> >
> > I also added a regression test to the Linux 6.8 BPF selftests. It
> > fails before the change and passes after it in both test_progs and
> > test_progs-no_alu32. The broader selftests run needed compatibility
> > adjustments for libbpf 1.8 and had other failures and skips, so I
> > don't have a clean full-suite pass.
> >
> > Would btf_ensure_modifiable() in btf__relocate() be the right way to
> > handle this? I couldn't find an existing report; please point me
> > to it if this is already being discussed.
> >
> > Thanks.
>
>
> Thanks for the report. Yes, btf__relocate() misses invalidating the
> cached raw_data, and btf_ensure_modifiable() is the right fix, same
> as btf__permute() does. I can fix it.
>
> BTW, how did you run into this? Is there a real use case
> that calls btf__raw_data() before and after btf__relocate().
>
