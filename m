Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF13254AC;
	Mon, 23 Feb 2026 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864559; cv=none; b=nQPkmWYlflIzoTy+3jVvosP5odCGXznN356UJrSsLYiZsb6779MOzSDOSXhokZpGVQzK2jvRRwMPyYmDfL8SaZzscDAMXQk/hcLz3ceQ/nOzwojksLz9tUKRD/OTWj2X4SnqERB73wFZ76aCadwgjQdm1UMUlEpfK7pz6GIoM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864559; c=relaxed/simple;
	bh=hpBxMDhkOBo0fWTc1IIu73vXXw50TUIIFKRJti8sr7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET2SlKLbhH8AxxYLMMwlJ1rXDjqsy4MFlakVkmq5k2Iw1spThVKf8E4l3YU3kFQ6luUjNTTMnN4H94LaW8GLQTI5i8dDH+fNvia5jdV4sGpbw0oxwQ27/i7GXVmhk2Biku6cEobsnRBS8HmEtq5KeHE1zMugEnPdntxKsyqloy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tmh6wjtI; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tmh6wjtI"
Message-ID: <65ac70d2-72ed-40ee-8e0d-bbaee525f8a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771864543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+razHazSB6EJhbfIAGNdwccjEdK/vcc1wfb8MmG0YE=;
	b=tmh6wjtIywNxkHKRBJAhS4doKKdeL3a44CN226i+NgqHydHrGgBJsjGIaRXU8YaK+xDYGC
	hM6cad76VXZasfQACGf6WkzThDrAJiZWqEFBPFdKh9xJpVmvjfOfE43jDGsNknHqJML291
	lSrc1losEwMIwdvG5KgiSkjpVJkvbqQ=
Date: Tue, 24 Feb 2026 00:35:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/6] bpf, x86: Add 64-bit bitops kfuncs
 support for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Peilin Ye <yepeilin@google.com>,
 Luis Gerhorst <luis.gerhorst@fau.de>, Viktor Malik <vmalik@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20260219142933.13904-1-leon.hwang@linux.dev>
 <20260219142933.13904-3-leon.hwang@linux.dev>
 <CAADnVQLNmQGKf5S5ZNwHYzScYBhnWFmnzLg=5Xxy4SgYKE3EfQ@mail.gmail.com>
 <c6c2ffcf-acdf-4bda-ad82-dc4cc1a9260e@linux.dev>
 <CAADnVQ+iQkvb9-wOchuPrUOneqzx9Rrqto88=R7GUOqih6PhZQ@mail.gmail.com>
 <4c40705a-4e6a-47ea-b420-223318d1ad09@linux.dev>
 <CAADnVQLsJV8OaLCxznwbnxdLVOQ+t=MmAr2O8Y89iPErCvphFQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQLsJV8OaLCxznwbnxdLVOQ+t=MmAr2O8Y89iPErCvphFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/22 00:51, Alexei Starovoitov wrote:
> On Sat, Feb 21, 2026 at 4:45 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>>
>> Good idea. But I concern about the "in kernel disasm". Do you mean we
>> will build a disassembler for whitelist kfuncs at starting?
>>
>> I noticed you've mentioned the same direction in "bpf/s390: Implement
>> get_preempt_count()" [1]. So, I added Ilya here to discuss this direction.
> 
> Much better. Keep it human.
> 
> "in kernel disasm" already exists for some architectures
> (at least x86 and arm64) since it's being used by kprobes.
> The ask here is to figure out whether they're usable for such
> insn analysis. x86 disasm is likely capable.
> 

After looking into x86&arm insn decoder, they are able to do insn analysis.

> re:"whitelist kfunc"
> I suspect an additional list is not necessary.
> kf_fastcall is a good enough signal that such kfunc should
> be inlinable.

I thought it was to build a light-weight custom disassembler, which
would only support limited machine codes (whitelist kfunc).

Obviously, I was wrong.

We can reuse the in-kernel insn decoding ability to validate fastcall
function by checking the registers use.

I'll post RFC after finishing poc, on both x86_64 and arm64 of course.

Thanks,
Leon

