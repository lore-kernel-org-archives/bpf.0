Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6F13CAE7F;
	Fri, 10 Jul 2026 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676619; cv=none; b=GX76AZZ1YzAs0QiPaOs9DudMJSLzcO3k0Pyz6kzWyUkUg0hVIvxsgvlWfkJnXMTVlO87wYFBvk64ZAAcSNHLFnWojqUwsSbLSlv+E65/WS6T0G+CTY910t1QJUJCn6OxTWtM06wn98bKibMEDmEl5mdKsRR2dj+mVTLzp3gmrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676619; c=relaxed/simple;
	bh=rfAJYIKEyJBvHHEZSSIffrChICbhN//G+RBczA9Elks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZvWKjzm84yUP3HNCG7lIhLfHsXUjIy7rG9HJJTWuF5ICii+FvlgMYlS2FnTDFBK5Aa+R7upFvr9ODr5N9ZO4T/lSGOlskFTIeIar9N2cB1XivLhC9j5adBwRY8lTTEdlezJJqpxXQH5nWiRx9spPBGy+bGIHecoEuIUuVYyTks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=QBNPivkf; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="QBNPivkf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XlSCz/vEAT59jkFzSKID306vJ9pfGWD/ederCXV+e7k=; b=QBNPivkfJvR+OmYd29Nkbjj/jV
	1KyUVwUeUe4MWRyLZkphhir9yDm6qQFWrJOWUo3G+CMa42XIp3F01zdS7lprbDW+/LZBT69/ndjlN
	XIkS+RqtY96lQvGJ9t40gdGeUXuJ7N+fKEsbSXeaDimwVXZ4yTqHrgVHcSan/JzDpXv2mFO7GkR0B
	I+Bx77QY6wTS6+zQVWmR7zXZruxaiJbN7HwOy6Kkejeid/Fyl6dcS4g2w3pScJbucc1s7S3uLIS+j
	JzSID6zQrNwNjImDYKoEOGHaJ2TlZYKIcWgnXkPKP2RdqeZfGCKBxx4fawAplVeMP4dGJxCaJ6hA7
	EjS2hJxg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wi7lC-000LGw-0I;
	Fri, 10 Jul 2026 11:43:06 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wi7lA-0004Rv-38;
	Fri, 10 Jul 2026 11:43:04 +0200
Message-ID: <326eda4a-39e6-4f1e-8fe5-dc1cc9ae6739@iogearbox.net>
Date: Fri, 10 Jul 2026 11:43:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 6/7] riscv, bpf: Mixing bpf2bpf and tailcalls
To: Pu Lehui <pulehui@huaweicloud.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr,
 pulehui@huawei.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260708064436.2971933-7-pulehui@huaweicloud.com>
 <a721df30ec2f824295000183c8e91f2c19d0bd56ae115b835b402be9eacc1c71@mail.kernel.org>
 <b4aadfde-9745-4c71-8dd4-ce433331f91b@huaweicloud.com>
 <CAJ+HfNi_icVbeB=jw-xnXrwzigZwP2OVRbzaF3VC87i6fDpdDw@mail.gmail.com>
 <fc972c33-1b66-4979-97e9-71627fb6179f@huaweicloud.com>
 <CAJ+HfNgPWwX3dfu=62TSMKeLD8m9S0rc2k9G8rVN7r2SuzQ6MQ@mail.gmail.com>
 <23cb9eac-1775-44b8-a9ec-10edde808a30@huaweicloud.com>
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
In-Reply-To: <23cb9eac-1775-44b8-a9ec-10edde808a30@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28056/Fri Jul 10 08:24:04 2026)

On 7/10/26 2:53 AM, Pu Lehui wrote:
> On 2026/7/10 3:51, Björn Töpel wrote:
>> On Thu, 9 Jul 2026 at 17:09, Pu Lehui <pulehui@huaweicloud.com> wrote:
>>> On 2026/7/9 19:37, Björn Töpel wrote:
>>>> Sorry for the delay here -- the bot had me thinking a bit.
>>>>
>>>> On Wed, 8 Jul 2026 at 10:54, Pu Lehui <pulehui@huaweicloud.com> wrote:
>>>> ...
>>>>
>>>>>> This assumes a fixed number of instructions before the tailcall entry
>>>>>> point. When is_subprog is true, the rv_addi() instruction is not emitted,
>>>>>> which means the tailcall entry point moves forward by 4 bytes relative to
>>>>>> where RV_TAILCALL_OFFSET expects it to be.
>>>>>>
>>>>>> The tailcall entry is used in emit_bpf_tail_call() when calculating the
>>>>>> jump target for the tail call. If RV_TAILCALL_OFFSET doesn't account for
>>>>>> the conditional emission, could this cause the wrong entry point to be
>>>>>> used when tail calling into subprograms?
>>>>>
>>>>> This is not an issue, subprog can not be the tailcall callee.
>>>>
>>>> Say, that we have an entry function that does bpf_for_each_map_array()
>>>> into a callback cb(). cb() is a subprogram, so no init of TCC. Now,
>>>> cb() calls another subprogram that does a tailcall.
>>>>
>>>> The callback to cb() is coming from the kernel, so a6 could have been
>>>> clobbered, no? We're entering a subprogram coming from the C ABI. Now,
>>>> if the callback calls a subprog that's tail-call reachable, the TCC
>>>> can be garbage?
>>>
>>> Sashiko reported the same issue yesterday. I verified that the verifier
>>> rejects cases where a tail call is invoked within a callback;
>>> specifically, while the callback's return value range is [0, 1], the
>>> simulation of the exit path in `check_helper_call` (handling the tail
>>> call helper) marks R0 as UNKNOWN, causing the verifier to reject it—so I
>>> didn't investigate further. However, I just verified that the verifier
>>> *does* accept the scenario where a callback calls a subprogram, and that
>>> subprogram subsequently calls a tail call. I believe this scenario ought
>>> to be rejected; perhaps some changes are needed in the verifier,
>>> otherwise tail calls on other architectures (like x86) would also be
>>> susceptible to infinite loop issues.
>>
>> Thanks for trying it out!
>>
>> Ok, so seems like we need a verifier fix pre-landing?
> 
> make sense to me, will try it.

Thanks, yes, please take a stab at crafting a verifier fix + BPF selftest
and let us know if you are stuck somewhere.
