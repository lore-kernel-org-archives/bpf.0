Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE5F397692
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788180554; cv=none; b=ln3ukq0WrxNlvVtGa9SDK8vjXZCjrUt2lDF22CFVlWZrIuESP75pXMoyEPbt7Y0OWHN58xct9AEUso+LkwHSXjGGDSSdWvmcmOdl3/L9SS2CN6ZnI2SFPVgUq4Nfy7/1BO1iml+byI6LG6Crnmnzl/EOtxmWHErPBL9SklAp1co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788180554; c=relaxed/simple;
	bh=dYnj6LiEqUfm1MOQ4NdyBGoVieIcnJ71VeM+0xk1ecI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpHlD/nsr0ge8k6bCDb0X+xxsGlgcebdmp09PSXdVWPPr+Yu/bexqPPW0Vqy0EIaKFXFAMDV9+RYc3ZYA38BXof6vGyzlNyIEZUUff0SfRQDHl9aWJU90EJOuS3ZL6tJfHKbUekwxjjfNH+G5CCwGfqjN1E+L0KtNGcvWn5EZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T435ByJb; arc=none smtp.client-ip=91.218.175.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T435ByJb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dYnj6LiEqUfm1MOQ4NdyBGoVieIcnJ71VeM+0xk1ecI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788180546; v=1; x=1788785346;
 b=T435ByJb3+cNexT8oBb3NFAElsEdAFsQAN71sL1VBmKfgVBxlIsz/ZkCNc+mgE4RdLpk2CE0
 cLUgbywoOvZz6Py9M+/oo40lXOcr1ZsnXt+63wj1WI+G01Ns8rup/al23ptyYRGVnxuW3+18yyJ
 xyH2h7fz/YSvLjtn9C7GbQZk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 164189ca6dab5531;
	Mon, 31 Aug 2026 12:48:56 +0000
X-Mizu-Trace-ID: 164189ca6dab5531
X-Migadu-Flow: FLOW_OUT
Message-ID: <334976a1-b8f3-416d-b5c6-588c25ab5a03@linux.dev>
Date: Mon, 31 Aug 2026 20:48:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/5] bpf: Fix NULL-ptr-deref when showing a void
 BTF type
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, yatsenko@meta.com,
 alan.maguire@oracle.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
References: <20260831110314.150870-3-jiayuan.chen@linux.dev>
 <116308d606e3bff21d07c01feb8741702547d1c32b1eafaad6f3628a776828fc@mail.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <116308d606e3bff21d07c01feb8741702547d1c32b1eafaad6f3628a776828fc@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 8/31/26 7:48 PM, bot+bpf-ci@kernel.org 写道:
>> bpf: Fix NULL-ptr-deref when showing a void BTF type
>>
>> btf_modifier_show() resolves the modifier and then calls
>> btf_type_ops(t)->show() unconditionally. For the void type (type_id 0,
>> BTF_KIND_UNKN) kind_ops[] has no entry, so ->show is NULL.
>>
>> The map dump path cannot reach a void type (a map key/value must have a
>> size and void has none), but bpf_snprintf_btf() takes a type_id straight
>> from the BPF program, and a "const void" (a modifier that resolves to
>> void, present in the vmlinux BTF) NULL-derefs there:
> Is this statement about the map dump path accurate? Looking at
> map_check_btf() in kernel/bpf/syscall.c, a map key isn't required to
> have a size:
>
> 	/* Some maps allow key to be unspecified. */
> 	if (btf_key_id) {
> 		key_type = btf_type_id_size(btf, &btf_key_id, &key_size);
> 		if (!key_type || key_size != map->key_size)
> 			return -EINVAL;
> 	} else {
> 		key_type = btf_type_by_id(btf, 0);
> 		if (!map->ops->map_check_btf)
> 			return -EINVAL;
> 	}
>
> When btf_key_id is 0, key_type is set to the void type, and
> map->btf_key_type_id is stored as 0. array_map_check_btf() even has a
> dedicated keyless exception ("One exception for keyless BTF:
> .bss/.data/.rodata/.percpu map").
>
> The preceding patch in this series, commit 55f5ad8f45a5 ("bpf: Reject
> key-less BTF for hash maps"), documents a syzbot NULL-ptr-deref where a
> void key reached the map dump path through htab_map_seq_show_elem() ->
> btf_type_seq_show_flags() -> btf_type_show() -> kind_ops[BTF_KIND_UNKN]
> == NULL. That patch closed the path by adding btf_type_is_void(key_type)
> rejections in htab_map_check_btf() and rhtab_map_check_btf().
>
> Would it be more accurate to say the map dump path is closed by the
> preceding patch and by existing btf_key_type_id guards, rather than by
> a size requirement?



I still think I am correct.

A "const void" (a nonzero-id modifier) is rejected as key/value by 
map_check_btf()'s size check;
your key-less case is a bare void key (id 0) on a different path, 
already handled by
patch 1 — so the size reasoning holds here.


