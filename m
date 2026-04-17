Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60133DED1
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440933; cv=none; b=nvkHhC4PqNvKJ9WC0E0CObsyW+hjEIJmaA41ZLrDFilUQT6VDhfXUDVjUpUXJhuApYHh68ugoN4hWCWFlPSalx64VRdbxr3Gt6IALhEdhXn29XY8//0eLt4p38U+FjNO0li+l7vB0NRSu6PQpyDyd1IKdblUt8cMzxLf1hjC//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440933; c=relaxed/simple;
	bh=IfwR07UZZe/BmtRk1ez2L/Z5riYcic+aID2eqrBLmps=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M5h1ilvpqUtnNOHejcNFEYyYt0Z21+JSDbPez7nAgahuiC7PZoOv9RajDY4qV206PCDzej4Mo/hZ8vriLbtYS5BRBlaH0lDzPChv5Lo+0di966aEZwDWmyan3oX3b3eIafCjLp4RYUmcWiAL6yQ6M12bWf+8jh9OStC6tZQbVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IiypgVM0; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IiypgVM0"
Message-ID: <d0059a19-ab24-4e9c-ac54-dafc932317e9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776440928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tX5PTdT1elsZoeY96ekwDs4qZpK13tRlQpzNlDN/8IY=;
	b=IiypgVM0KP8AUL99Fof1r/YnLdyxcrPMvdrhbPxY8MXCkEl3H2XK9CWviFJuGHRLQ9P8w3
	zCIE168HhIuAFy0doBBzk0CePJC0SF1fNaA9OcobQY9h9D87uShpugkrCltD/C6T1s6paG
	T2Fxkk/R4eTpuIDLKrI7UV/7F6Sljg4=
Date: Fri, 17 Apr 2026 23:48:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Introduce global percpu data
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz,
 kernel-patches-bot@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260414132421.63409-3-leon.hwang@linux.dev>
 <72dbcacc4cf2e76dc9de3c045e2fe1f3454d8880197b0db92c7d994ca82dcab0@mail.kernel.org>
 <fef2c9a0-c609-49f4-a165-890aaecfbfd8@linux.dev>
 <yujp3deu4uko2xkr4dghofpvhrni6szmd7wlozehtzndvhasrl@f2xjf4egi5fd>
 <3556a456-70d3-45e7-affa-355107bac30e@linux.dev>
Content-Language: en-US
In-Reply-To: <3556a456-70d3-45e7-affa-355107bac30e@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/4/17 09:30, Leon Hwang wrote:
> On 15/4/26 10:19, Alexei Starovoitov wrote:
>> On Tue, Apr 14, 2026 at 10:19:22PM +0800, Leon Hwang wrote:
>>> On 2026/4/14 22:10, bot+bpf-ci@kernel.org wrote:
> [...]
>>>> In the v3 series, bpf_map_direct_read() itself had a guard
>>>> (map->map_type != BPF_MAP_TYPE_ARRAY), which protected all callers.
>>>> The v4 moved this to caller-side checks but appears to have missed
>>>> const_reg_xfer().
>>>>
>>>>
>>> Correct.
>>>
>>> Will add a guard in bpf_map_direct_read() in the next revision:
>>>
>>> 	if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
>>> 		return -EINVAL;
>>
>> hold on.
>>  			    map->ops->map_direct_value_addr &&
>> -			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
>> +			    map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
>> +			    map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {
>>
>> map_direct_value_addr() is set, but then immediately disallowed ?
>> Where else it's used?
>>
>> Even if value_addr is working, then map_direct_value_meta() looks broken.
>>

IIUC, map_direct_value_meta() is only used for dumping xlated insns. If
no available map_direct_value_addr(), map_direct_value_meta() won't be
called.

> 
> Ah, let me dive deeper.
> 

As for the above changes, let me explain them using diff snippet.

@@ -5808,6 +5808,8 @@ int bpf_map_direct_read(struct bpf_map *map, int
off, int size, u64 *val,
        u64 addr;
        int err;

+       if (map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
+               return -EINVAL;
        err = map->ops->map_direct_value_addr(map, &addr, off);
        if (err)
                return err;

It is to guard percpu_array map against const_reg_xfer(). Instead of
updating const_reg_xfer(), better to update bpf_map_direct_read(). WDYT?


@@ -6362,7 +6364,8 @@ static int check_mem_access(struct
bpf_verifier_env *env, int insn_idx, u32 regn
                        if (tnum_is_const(reg->var_off) &&
                            bpf_map_is_rdonly(map) &&
                            map->ops->map_direct_value_addr &&
-                           map->map_type != BPF_MAP_TYPE_INSN_ARRAY) {
+                           map->map_type != BPF_MAP_TYPE_INSN_ARRAY &&
+                           map->map_type != BPF_MAP_TYPE_PERCPU_ARRAY) {

Since directly reading data from global percpu data is different from
the way of global data, such reading data for global percpu data must
perform the 'this_cpu_off' to read the data on current CPU.

At the moment of load time, the reading cannot read data like the way of
global data, also cannot cause verifier failure.

I'll add a test against bpf_map_is_rdonly()+percpu_array.

                                int map_off = off + reg->var_off.value;
                                u64 val = 0;

				err = bpf_map_direct_read(map, map_off, size,
							  &val, is_ldsx);
				if (err)
					return err;

				regs[value_regno].type = SCALAR_VALUE;
				__mark_reg_known(&regs[value_regno], val);

Thanks,
Leon

