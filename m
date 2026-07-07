Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D165405F7;
	Tue,  7 Jul 2026 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783456275; cv=none; b=VPFO8AUr93ueH0CPKpyTl5nkFg3JJedbWi5yPqKmKnIdwfkytzbAdOz/pfynmJiVFNVBJeTrVaHO+4dGMupkwATa2asygt1ZkXRJSglEjn29JmO6depWQCZhi15m8srtfQSXgdhgm+iaWaMtC3mxN5oRYnbRsBUr2FkmacV5myc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783456275; c=relaxed/simple;
	bh=+c7Nub9g+n8EHHrwd16X0fxPgCYfVI7a/SXwquMfI8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q0Iv6qB/SMTRtCch1Shx2tnZyAqW7tBdO6y/+sDef0xTzmiCbN4ugQUWG3pDPFlxyFvXHKJmXBfgzyNEJ5RIqS/LjFT1S+rz4udnGnN9Vd/1z9Qz7y2IaFA15XmpoxN2iZ4ZVIYHG3wVYKGWteLlrBHYr1d97i75wW8KOf7J2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=ml6h349K; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ml6h349K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=ISsste53oDfiQAPBRfaIsEPZh0Xo6zksfj6/7gv7OKs=; b=ml6h349KGBGpH/oVp+gxQXQO8C
	vUKrGNQk9AdElAbEy+kP+nxjdeN0yB6o9uEIp/leVtjaQdNt9qv/HxDn1jVcK0TuYjFmr4/x7+P15
	Ae1IgzUtZuZ9GsFdTvsPHttI16tuEurJ2tGDXqXEfXdeDXzcClUf9MHB55JJ1/bvh2lFeKNGhRpnW
	qYXgmISWivtvxF9e8Z/2x3DE551sVdKuVuapzgQMluPNEJ21T9U98MTA9JiR+LL7UBxK9OXf7XoZX
	hVMys4fedlQNHWgmsYHQjOxzU1TiX05hk1rcVYcYH4iMMXb1hoKkk66akErnpJjDuOWRYo87sdBW+
	0FBWRePw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whCRk-0002Lf-1f;
	Tue, 07 Jul 2026 22:31:12 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1whCRj-0004JY-2n;
	Tue, 07 Jul 2026 22:31:12 +0200
Message-ID: <1c05d85a-2700-4849-be6c-ebecb2fde634@iogearbox.net>
Date: Tue, 7 Jul 2026 22:31:11 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/8] bpf: Verify signed loader metadata at
 load time
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260707193104.350066-1-daniel@iogearbox.net>
 <20260707193104.350066-3-daniel@iogearbox.net>
 <20260707195600.5C2851F000E9@smtp.kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <20260707195600.5C2851F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28053/Tue Jul  7 08:24:37 2026)

On 7/7/26 9:55 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] A lockless synchronization race between map_freeze() and map_update_elem() allows a TOCTOU bypass of BPF signature verification.
> --
> 
> --- Patch [2]: [PATCH bpf-next v5 2/8] bpf: Verify signed loader metadata at load time ---
> commit 5bc066f1169723d401bd2b1b6a80fa2ecfbca1a9
> Author: Daniel Borkmann <daniel@iogearbox.net>
> Subject: bpf: Verify signed loader metadata at load time
> 
> This patch introduces load-time BPF signature verification. It verifies the
> signature over both the BPF instructions and the contents of any exclusive
> metadata maps, relying on map->frozen to ensure the metadata cannot be
> modified after verification.
> 
> Link: https://lore.kernel.org/bpf/2f71d6c03698eb17d51f7247efde777627ee578a.camel@HansenPartnership.com [0]
> Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e00.camel@HansenPartnership.com [1]
> Link: https://lore.kernel.org/bpf/88703f00d5b7a779728451008626efa45e42db3d.camel@HansenPartnership.com [2]
> Link: https://lore.kernel.org/bpf/DJOFY21DYUI4.19WKQ3NPZ4H5R@gmail.com [3]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2e9e65297c706..462a1f8544b9d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19870,6 +19895,140 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   	return 0;
>>   }
>>   
> [ ... ]
>> +static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
>> +				     union bpf_attr *attr, bool is_kernel)
>> +{
> [ ... ]
>> +	for (i = 0; i < map_cnt; i++) {
>> +		struct bpf_map *map = maps[i];
>> +
>> +		if (map->map_type != BPF_MAP_TYPE_ARRAY ||
>> +		    !map->ops->map_direct_value_addr) {
>> +			verbose(env, "signed program metadata map '%s' must be an array\n",
>> +				map->name);
>> +			err = -EINVAL;
>> +			goto out;
>> +		}
>> +		if (!READ_ONCE(map->frozen)) {
> 
> [Severity: High]
> This is a pre-existing issue, but does the current map freezing mechanism
> provide the absolute immutability required here?
> 
> In kernel/bpf/syscall.c:map_update_elem(), the code increments the write
> count and checks permissions:
> 
>      bpf_map_write_active_inc(map);
>      if (!(map_get_sys_perms(map, f) & FMODE_CAN_WRITE)) {
> 
> Because bpf_map_write_active_inc() uses atomic64_inc(), it does not imply a
> memory barrier on weakly-ordered architectures (like ARM64). Could the
> read of map->frozen inside map_get_sys_perms() be reordered to occur
> before the writecnt increment is globally visible?
Oh well, so to make this air-tight on arm64, I'll add:

   if (bpf_map_write_active(map)) {
           verbose(env, "signed program metadata map '%s' has active writers\n", map->name);
           err = -EBUSY;
           goto out;
   }

Thanks,
Daniel
