Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D101ACEDE
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776819439; cv=none; b=C/B05wQz3UDX7Wo44wsuAKRbgSup0Qt2oLjcG88QYIO3uKIOsCqKinh3Fv7joF4gk++BREQNup5gRk3mcgJZveED2SemqOOK0Wdzbo87bvE4T3OHTD0Iurafvm/BknyAZQhXMNPUrZjUj7DztG8J7/RKyQdj/lMtL2HIrfiy3FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776819439; c=relaxed/simple;
	bh=Ck4id2A9QGSHL0fgG4FTSLytn91Gv4os8UfSqXoxWaU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hrTipreLn+tWyzoxQSLjD5cTUrkAdAwCL7vF+7eBYIXUS5pYCigex0R37veMAdW7MOnKW0/BX5XoGh82DoNysN6+9Zf3kuGUiA2BuQPw/etY8uhrEKlnyzsOpqq1ZGrGVLXswQ8/2QHwAPthdycm69QmBxCtZ2eB9QmeuFtLNsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6NiajLA; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6NiajLA"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dcdd23fcdfso585543a34.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776819436; x=1777424236; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MmmD99zui4xHP/+vCi9RC5lJ1VUvN9nT4/vd75B98U=;
        b=m6NiajLAl3CIxl6vNSw/TtQO3FOJgL8FQfoebbF8YHZ8dP49fOBfP3YQZQodhFDb6T
         of6Y4D+9uU3bcOdEz4WUDQWQSLRcpdOI4Vb1ixiLxZfaG2gr0PMKf2Uioug4MuHemJn0
         +MoUmZGpY79adiUiN4FM9FZ9CeiZI4iLyfAZsZyqv2WtcKucfcVKKGlcGrB2ngSJvxTb
         XE1O/bBSW9NHef/xKG5ic5TZ3l/2/wceqxGQXbmbnHZlXbs5hTSiaRNgV4bsh6ycn27r
         Kgd+4HSP18ZMu8A5QA4DRIn0O/MThZB22kl9twF5wTjPcztCKC3qbLYWcLX/TxbVYLi+
         JOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776819436; x=1777424236;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MmmD99zui4xHP/+vCi9RC5lJ1VUvN9nT4/vd75B98U=;
        b=B9PfJKiadkTuMVbA0zqWH7ihZAt4bOoWPfjgl3Nq/8wtfMoeC+U6eF4X/aPdKzqhjO
         dhTyNy46gugpAKTTVFuBUxi99kjYrMLxJ7iYNYikesM0cAGqp1dPmjmqEqwUgjNXLWF0
         Fp5j1rFEtxqIdVPiZ0Y1fsGTCA4VwalkE/EVNTaY3NytALqhqjNnt0CXPD9vewJg8E2L
         W1fe5sC91neUFD/0BeyJOnRmj1rziLXFNJVNINFQpY68Z6+43pj4KdgcaOlAvNXm6b60
         ySj4HF+DQuo84xViFQAQwlGLKWuFE115ajY3DeNL5vLI9jaoKA64bT+8+LQAQx/GvFBQ
         dWjA==
X-Forwarded-Encrypted: i=1; AFNElJ8k03hKT76UwhdKApVE9Bn/DzVRV1mVXCMm8tbw5yDh//m4eVI7VTpbcLhadDJweQJASXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YweuKwCRSuAbzhQboiXd853vn8xXiikuT73wyWh+kAmrZ+j1RJQ
	CBFB8R0qF4/xxy3VTIuxVxmX33jfTUs/iuCJWbI2dg0UVf2X/+0oIYA4
X-Gm-Gg: AeBDiesUjOwatm7GDEZ73DGQTdfXLOuZpCv0SIXDZklLU1pvBRsryJlc/5JI+HgrE3U
	eCXlCpo1AZAdWHuDiJwMA+oHf+I7yapuun3MuzTIEWi4SUBeuN+hnjNOMjp3fLt+i7217ApChH9
	6pXwaVVOwtBYn1cyS3oDPd0uulO51uVOO2b7UcklDxFAyo2hRT8Dn2xsyh1iD1t1AI11QVz+xyB
	/VKkxdxi0LATh53zxyOfRkLd0sBR4Mt40jyRWgkQuzmku/blnoVZuZqI8TKAHsTfbgiesn4WNdY
	meSLAePxsyDVBnPosqKa6P2PcEKZF8M7vDss6hkySpY/DBAvsW1m9GJdrcUx7ccjjI8MepQQXvI
	pxMGZLc+zdNNu/8KHdrSXwfJla0W/fPhFNzrnGqFzyZ7Qds1sUWlvU13C9Z6v/dGPtDNqYzz8Qx
	sRUOQEpfswgXt07VrIxIJh8AIVifEwWPAvLEvex1NJqgCmRXwted93dy8L0Gnuzte0CKoNKY0sn
	whDd7bYjfgeKUecvLnbrng+cu7I
X-Received: by 2002:a05:6830:439f:b0:7dc:da80:42b8 with SMTP id 46e09a7af769-7dcda804700mr3071475a34.18.1776819436560;
        Tue, 21 Apr 2026 17:57:16 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd56bd0e4sm4466974a34.2.2026.04.21.17.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 17:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:57:14 -0700
Message-Id: <DHZ9X7I3N8ZI.36L0KXXPX39I4@gmail.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <yonghong.song@linux.dev>,
 <eddyz87@gmail.com>, <jose.marchesi@oracle.com>,
 <cupertino.miranda@oracle.com>, <vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next] selftests/bpf: remove string.h includes in bpf
 progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "David Faust" <david.faust@oracle.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260421202233.528128-1-david.faust@oracle.com>
 <DHZ51LAF3MRD.20EUP6N4BB5P@gmail.com>
 <20a84543-8e42-4d54-96da-29754ed1cd39@oracle.com>
In-Reply-To: <20a84543-8e42-4d54-96da-29754ed1cd39@oracle.com>

On Tue Apr 21, 2026 at 5:15 PM PDT, David Faust wrote:
>
>
> On 4/21/26 14:07, Alexei Starovoitov wrote:
>> On Tue Apr 21, 2026 at 1:22 PM PDT, David Faust wrote:
>>> Sources for some BPF test programs currently include string.h, which
>>> is a glibc header and not a toolchain header.  Since there is no BPF
>>> glibc, this means it is the native system glibc string.h which gets
>>> included when building the test programs.
>>>
>>> In all cases the include is only necessary for the prototypes of
>>> non-builtin versions of memset, memcpy, etc., and in every case both
>>> clang and gcc already replace these with the compiler built-in versions
>>> and expand them inline.
>>>
>>> In the case of gcc this replacement happens after initial debuginfo is
>>> generated, which includes the calls to the glibc routines.  This means =
a
>>> BTF record for e.g. 'extern memset' is emitted, resulting in load
>>> failures like:
>>>
>>>   libbpf: BTF loading error: -22
>>>   ...
>>>   [26] FUNC memset type_id=3D1 Invalid func linkage
>>=20
>> ...
>>=20
>>> -	memcpy(&val, keys, sizeof(val));
>>> +	__builtin_memcpy(&val, keys, sizeof(val));
>>=20
>> This is not an option. It works for llvm because it inlines it for small=
 sizes.
>> GCC should do the same.
>
> GCC does the same inlining for small sizes.
> It is a bug in GCC that the FUNC record for the original is still emitted
> in this case, that shall be fixed.
>
>> For large sizes llvm will emit libcall to memset
>> that libbpf will error with "FUNC memset type_id=3D1 Invalid func linkag=
e"
>> and that's a separate issue to deal with.
>
> It works now in both compilers (modulo above gcc bug) because at -O1 and =
above
> they recognize the memset/memcpy/etc. calls and attempt to replace them w=
ith
> builtin versions and expand inline.
> If the size is too big or non-constant, they will both fall back on libca=
lls.
>
> My point is that it is essentially working by chance, only because the co=
mpilers
> do this optimization. The progs as written are including a libc header, u=
sing
> routines from that header, but not linking to any actual implementation o=
f
> those routines that they use.

No. It's not "by chance". It's working, because compilers have to do this o=
ptimization.
Just like
static void *(* const bpf_map_lookup_elem)(void *map, const void *key) =3D =
(void *) 1;
hack.
It "works" because compilers perform a set of optimizations.
There is no luck here. Compilers have to transform the code in a certain wa=
y
that the verifier expects.
BPF doesn't work with -O0. Just like kernel won't boot if compiled with -O0=
.
One can argue that kernel is working at -O2 "by chance" as well.

> Changing to __builtin versions makes the current behavior explicit.

Nope. Not doing gcc's helper_call extension either.

