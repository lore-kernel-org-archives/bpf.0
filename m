Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9403101A2
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189038; cv=none; b=Yi8I6e0lRS8erZmeyqYuDxspK7aer/fX3qXr27rUiMIUj/xZrJKLT8qD2ujnIZdjJUAL7uHc3InqPGGAmJYL3/fbS/qj1TOnmRMMxpNO7HkpAZi2LEwecOBuUQfuXnPWRn1xVvemc9j2A527E1tt1hQrAaeysnh0Jzy2QHX/C1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189038; c=relaxed/simple;
	bh=1t+ebrD+omSX2Y8Qg1+IcALIwGAXTvO0Cqbl/9D+IWY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G+Q6DeGIKsK3W0yJyZUwARPSVnvpUT07F8KD9RUlZ1FGaSH6V8KXQ3WIzj1h3X5m64QvLbg58vR9ZGlLZ4xfJ584wyvCBulKPVIvxLQIjhgS0NJHDgmy7SYZlvTQ321wwPIjYxogUPq7GBdOQWSfF9d/PAlPFrdroVonx+ZGNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=e7ZSkBfd; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="e7ZSkBfd"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128b9b7e3edso2717769c88.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 10:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1776189036; x=1776793836; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAaSuwNHVxek9gP50NuLA6+tK7jdHFKrU3+fRfjRZdI=;
        b=e7ZSkBfdpEJzomQlgVI1OPLSIKs2VdewHpnGX6PQ/qmLGN/i2bQP9NIMY2AyPdM1M6
         CmE1NPQaG4oUshfuUxp60iYkvVVZ1I3hVdm8uc9eIB+ICZi8GCmY3Xn7ty1/YDNz1kc5
         th8nd0w7cjs82/52EptnkSlbp7g0ppqeCjfUqox13ko2fyDzedI4slhe65skOiAxJ4Tq
         b/Y3v06TTa61wDQxqmCQLJ94yKsUjLOy9tftKdwqSIj77bCjpUNTG83IaGRPy3Ja0L4y
         dDdWpHQNM2q+GHO44Cvm8kbdLG655B+L7r5sDo9TIw9a9/It+jAYzh1fd/2YaK2HndEg
         U6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776189036; x=1776793836;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAaSuwNHVxek9gP50NuLA6+tK7jdHFKrU3+fRfjRZdI=;
        b=KBEWcKkFJflNmERSLsbC5Kefhbf0TYqDqaFY/tHfQx6FqX5P72O0X0A0T6TkagPgXO
         KuDwMUssJl7lwQr2+d3vkB21jzTe0lZm5FqqVby0EmGrl7Gea0udENntYbuPez8/av+J
         OBuyI6ZHHa42o7OIktsGHxqKKMvguiXMdjfZVWb8OvBr+DFe6KVcxbcp6rK3TgyPQvWX
         GJJEenO9jA4xRaEx4ti7y7cdKhD0xN/BF35h9XHiDXq05GKoXKpGAoQu4zaayaKJDtMh
         8OaqcljP31HVMPa9hkOCH3cpLB6RvqmitYcoTC2SOlWJbk95sTQg1reEXvAC8ZxmBEfH
         oZwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8eF3cEtuHBCTlILz4jTXpuY0HuUockaWEGLfMMX5IQDUayCECO6MmLCI3aJBwycpOppWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD1hw7kF40by1qx06AiRxNaor95WwGgAT7j+mZRkvGdHxrq2j4
	7SjBr9isO69/R31O2oZAHtfAv/TUIWEYYGnSfnV2t/y7j1pVfKDCgvDPHaOsQLGoLHk=
X-Gm-Gg: AeBDiesbOBM+SMEtP6CRS5V5mc5KVSR432NQnQRbCv2Tci6GTgXBUjXMbCqZXjNafps
	blNJvXcBt6dPt0nN0xqRa7a+ZOFGJJTF7l057qL720IGs9PMj+U0wJ6eAb8nKmYz71nkjGHkKt1
	DD2lBd+1VvRPZwPVIydJVL3XDqihwbsCaoU4ehEyZkpkPazH3F8r2qHmsuzxwc+n0aE0l+3klQF
	ACw+DlDeL/BrRkS/qXp2H2Tp2inGHBTJx8CuDl3bheW38nPymRuMRNOhaFrvG4rOUMtCc+VoQgm
	+zXwKCGMhDkCl2c9mK8ybAhaR9s1k33M7vhvyybgkgwxAlaRhLmu5GrQNCG9ujfarJ2sFzDeEym
	UYddgNDEjYkk7zAQCRdjNb/QchgYDymm616Tyr3SAbrDgbYFyGaX1BN9nDxm5oDLcsGl4zltpOI
	VpCJoL47Lh6EGHoks=
X-Received: by 2002:a05:7022:6b8d:b0:128:dedf:f56d with SMTP id a92af1059eb24-12c34eddc14mr11895818c88.24.1776189036201;
        Tue, 14 Apr 2026 10:50:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::cfa6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346eb228sm20868955c88.9.2026.04.14.10.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 10:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 13:50:33 -0400
Message-Id: <DHT2GPE7GKLZ.UUW9AELFEBUC@etsalapatis.com>
Cc: "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH RFC bpf-next v2 01/18] bpf: Register rhash map
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>, <ast@kernel.org>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <kafai@meta.com>,
 <kernel-team@meta.com>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-1-3b3675da1f6e@meta.com>
 <DHPTXQZL4ERG.3QCBWTRWKFNN@etsalapatis.com>
 <0f4b66fd-4e50-43af-a952-4a0f615e6377@gmail.com>
In-Reply-To: <0f4b66fd-4e50-43af-a952-4a0f615e6377@gmail.com>

On Mon Apr 13, 2026 at 4:10 AM EDT, Mykyta Yatsenko wrote:
> On 4/10/26 11:31 PM, Emil Tsalapatis wrote:
>> On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>
>>> Add resizable hash map into enums where it is needed.
>>>
>>=20
>> These changes in isolation are difficult to reason about,
>> can we roll this into subsequent patches? Right now this
>> adds a the BPF_MAP_TYPE_RHASH without there being a way
>> to create one.
>>=20
>
> Thanks for taking a look, makes sense, I can squash it into the latter=20
> commits.
>

For the squashed commit:

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>> ---
>>>   include/uapi/linux/bpf.h       | 1 +
>>>   kernel/bpf/map_iter.c          | 3 ++-
>>>   kernel/bpf/syscall.c           | 3 +++
>>>   kernel/bpf/verifier.c          | 1 +
>>>   tools/include/uapi/linux/bpf.h | 1 +
>>>   5 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 552bc5d9afbd..822582c04f22 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -1046,6 +1046,7 @@ enum bpf_map_type {
>>>   	BPF_MAP_TYPE_CGRP_STORAGE,
>>>   	BPF_MAP_TYPE_ARENA,
>>>   	BPF_MAP_TYPE_INSN_ARRAY,
>>> +	BPF_MAP_TYPE_RHASH,
>>>   	__MAX_BPF_MAP_TYPE
>>>   };
>>>  =20
>>> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
>>> index 261a03ea73d3..4a2aafbe28b4 100644
>>> --- a/kernel/bpf/map_iter.c
>>> +++ b/kernel/bpf/map_iter.c
>>> @@ -119,7 +119,8 @@ static int bpf_iter_attach_map(struct bpf_prog *pro=
g,
>>>   		is_percpu =3D true;
>>>   	else if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
>>>   		 map->map_type !=3D BPF_MAP_TYPE_LRU_HASH &&
>>> -		 map->map_type !=3D BPF_MAP_TYPE_ARRAY)
>>> +		 map->map_type !=3D BPF_MAP_TYPE_ARRAY &&
>>> +		 map->map_type !=3D BPF_MAP_TYPE_RHASH)
>>>   		goto put_map;
>>>  =20
>>>   	key_acc_size =3D prog->aux->max_rdonly_access;
>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>> index 51ade3cde8bb..0a5ec417638d 100644
>>> --- a/kernel/bpf/syscall.c
>>> +++ b/kernel/bpf/syscall.c
>>> @@ -1287,6 +1287,7 @@ static int map_check_btf(struct bpf_map *map, str=
uct bpf_token *token,
>>>   			case BPF_SPIN_LOCK:
>>>   			case BPF_RES_SPIN_LOCK:
>>>   				if (map->map_type !=3D BPF_MAP_TYPE_HASH &&
>>> +				    map->map_type !=3D BPF_MAP_TYPE_RHASH &&
>>>   				    map->map_type !=3D BPF_MAP_TYPE_ARRAY &&
>>>   				    map->map_type !=3D BPF_MAP_TYPE_CGROUP_STORAGE &&
>>>   				    map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE &&
>>> @@ -1464,6 +1465,7 @@ static int map_create(union bpf_attr *attr, bpfpt=
r_t uattr)
>>>   	case BPF_MAP_TYPE_CGROUP_ARRAY:
>>>   	case BPF_MAP_TYPE_ARRAY_OF_MAPS:
>>>   	case BPF_MAP_TYPE_HASH:
>>> +	case BPF_MAP_TYPE_RHASH:
>>>   	case BPF_MAP_TYPE_PERCPU_HASH:
>>>   	case BPF_MAP_TYPE_HASH_OF_MAPS:
>>>   	case BPF_MAP_TYPE_RINGBUF:
>>> @@ -2199,6 +2201,7 @@ static int map_lookup_and_delete_elem(union bpf_a=
ttr *attr)
>>>   		   map->map_type =3D=3D BPF_MAP_TYPE_PERCPU_HASH ||
>>>   		   map->map_type =3D=3D BPF_MAP_TYPE_LRU_HASH ||
>>>   		   map->map_type =3D=3D BPF_MAP_TYPE_LRU_PERCPU_HASH ||
>>> +		   map->map_type =3D=3D BPF_MAP_TYPE_RHASH ||
>>>   		   map->map_type =3D=3D BPF_MAP_TYPE_STACK_TRACE) {
>>>   		if (!bpf_map_is_offloaded(map)) {
>>>   			bpf_disable_instrumentation();
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 8c1cf2eb6cbb..53523ab953c2 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -21816,6 +21816,7 @@ static int check_map_prog_compatibility(struct =
bpf_verifier_env *env,
>>>   	if (prog->sleepable)
>>>   		switch (map->map_type) {
>>>   		case BPF_MAP_TYPE_HASH:
>>> +		case BPF_MAP_TYPE_RHASH:
>>>   		case BPF_MAP_TYPE_LRU_HASH:
>>>   		case BPF_MAP_TYPE_ARRAY:
>>>   		case BPF_MAP_TYPE_PERCPU_HASH:
>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
>>> index 677be9a47347..9d7df174770a 100644
>>> --- a/tools/include/uapi/linux/bpf.h
>>> +++ b/tools/include/uapi/linux/bpf.h
>>> @@ -1046,6 +1046,7 @@ enum bpf_map_type {
>>>   	BPF_MAP_TYPE_CGRP_STORAGE,
>>>   	BPF_MAP_TYPE_ARENA,
>>>   	BPF_MAP_TYPE_INSN_ARRAY,
>>> +	BPF_MAP_TYPE_RHASH,
>>>   	__MAX_BPF_MAP_TYPE
>>>   };
>>>  =20
>>=20

