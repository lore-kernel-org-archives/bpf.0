Received: from mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4654746BD
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849830; cv=none; b=k4fMBy9G6llcZZrf/JqZsOatLcE085AxiPaDq3oWfW5tD+53hlhPZVKudKj9IJIm7rO67u1UTyet6Rp61UTaf6ZRBgj65BkwRvUT5k95tFLJUMNLnpRct0nxngNaiCvxsoTsa25HLsbILZEyqkZ+Wv/MFyGGCoWgYJL4zDwDjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849830; c=relaxed/simple;
	bh=Jdj6KrLGehB34X2w97M9mQObVKahiLPaVNwhnjAUsN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5GA9+ZYg+AmbZ0jphNue68MdE+KxK413cGTMkFBUXCh7LixLHV4CRigHLVaOxrofiCzBiwQ6kAmCkdmPktrus0y7kM9W8sd/hVqjFdpIhNBp1nHPubDk9IqSJ3IA+lQjPDaXbqXLyhzs68vs2XcPM6e4rl8S3gjDSCCCtMa+x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VtQjQg4A; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VtQjQg4A"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Jdj6KrLGehB34X2w97M9mQObVKahiLPaVNwhnjAUsN0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787849825; v=1; x=1788454625;
 b=VtQjQg4AzyoiDQezEab7rD4yC/LT2q7k6/QDw9msoX+7hcM4aW76Sy0cYn8RBBp9vcIDpY+N
 YE16NaRoXMn2sJRpjjxO9VaEeSoPlwqMsy86KhHaeQUWyg14gDNIBXSwOHri6tnj2enEZ5iI8sc
 sgu9wK/YoZDOiRz77EwWnWbY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 97ee9a0df24b090b;
	Thu, 27 Aug 2026 16:56:55 +0000
X-Mizu-Trace-ID: 97ee9a0df24b090b
X-Migadu-Flow: FLOW_OUT
Message-ID: <a96f8530-114d-491d-9802-83d72dfab16e@linux.dev>
Date: Thu, 27 Aug 2026 09:56:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 0/9] bpf: add support for KASAN checks in
 JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Yafang Shao <laoar.shao@gmail.com>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
 <DKWOY12R4ZJJ.A8KDS1DU1PHS@gmail.com>
 <1c34603a-9170-4074-b826-e98d9871e2d8@linux.dev>
 <DKZJ7GFLAU12.1WHACTBREQQV2@bootlin.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DKZJ7GFLAU12.1WHACTBREQQV2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-08-27 12:01 a.m., Alexis Lothoré wrote:
> Hi Ihor,
> 
> On Wed Aug 26, 2026 at 11:00 PM CEST, Ihor Solodrai wrote:
>> On 2026-08-23 3:53 p.m., Kumar Kartikeya Dwivedi wrote:
>>> On Sat Aug 22, 2026 at 12:39 AM CEST, Alexis Lothoré (eBPF Foundation) wrote:
>>>> Hello,
>>>> this is v7 of the series aiming to bring basic support for KASAN checks
>>>> to BPF JITed programs. This new revision just makes the series rebased
>>>> on top of current bpf-next_base.
>>>>
>>>> Please note that with the recent kernel splat detector introduced in
>>>> kernel-patches/vmtest through commit 8109e5928cd0 ("ci: own the kernel
>>>> splat matching (#509)"), CI runs on this series will fail with the
>>>> following error.
>>>>
>>>>      Error: kernel splat detected: [  100.689549] BUG: KASAN: \
>>>>      slab-use-after-free in \
>>>>      bpf_prog_eba69524d1d949b1_st_not_on_stack+0x12f/0x17a \
>>>>
>>>> which is pretty normal, as the new selftests introduced by this series
>>>> are expected to trigger KASAN splats (the test_progs part will pass,
>>>> only the kernel_splats part will trigger errors). The right fix may be
>>>> to just put a list of regex matching all the kasan subtests progs in the
>>>> relevant SPLAT_ALLOWLIST file; something like:
>>>>
>>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16}_(st|ld)(x)?(_not)?_on_stack\+
>>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16}_simple_atomic(_fetch)?(_not)_on_stack\+
>>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16}_ldx_patched(_not)?_on_stack\+
>>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16}_verifier_paths_stack_and_non_stack\+
>>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16}_ldx_oob\+
>>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16}_st_blinded\+
>>>> BUG: KASAN: slab-(out-of-bounds|use-after-free) in bpf_prog_([a-f0-9]){16}_(load_acquire|store_release)(_not)?_on_stack\+
>>>>
>>>> I can take care of opening the relevant PR in kernel-patches/vmtest with
>>>> this if it ends up being the correct solution, but it will make sense to
>>>> do so only once the selftests list is validated (but before merging the
>>>> series).
>>>
>>> We need to resolve this before landing the set. To me it looks inevitable, esp.
>>> if we exercise the support and produce such warnings. That said I'll let Ihor
>>> respond and provide guidance for this. We should probably land the vmtest PR
>>> before v8 is posted, so that v8 can go through CI and be processed without
>>> failures.
>>
>> This is a tricky one.
>>
>> IIUC the suggested allowlist regex will also mask the real splats, which
>> the whole KASAN-in-JIT project was supposed to catch.
> 
> Not really: the proposed list of regex above just discards the splat
> emitted by the progs used by the tests related to the KASAN feature (so
> any prog in tools/testing/selftests/bpf/prog/{kasan.c,kasan_harden.c},
> which anyway generate "fake" KASAN splat for most of them, since we are
> manually poisoning some valid memory to trigger the splats. Any other
> program that generate a splat will be caught by the splat detector.

Ah, I see. The regexes have BPF prog names in them.

Then yes, the SPLAT_ALLOWLIST is the right fix.

Thanks for explaining.

>>
>> I think a good way to resolve this is to teach the kasan splat
>> detection script about these tests, and drop/skip them from the dmesg
>> log it inspects. For example, match begin / end of the test set.
>> Might require special log anchors printed by the test itself, but
>> you get the idea.
>>
>> Alexis, do you mind trying this?
> 
> If despite the comment above, teaching check-kernel-splat.sh how to
> ignore the kasan selftests specific splats remains a better solution,
> sure, I can work on this.

No need. Let's do the SPLAT_ALLOWLIST, I'll take a look at your CI PR
shortly.

> 
> Thanks,
> 
> Alexis
> 

