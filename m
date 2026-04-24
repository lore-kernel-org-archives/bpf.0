Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AEC1AB6F1;
	Fri, 24 Apr 2026 23:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777073521; cv=none; b=tgD52TOcbGV2Qkd9beb5dJNx9SD6kjIR5zW26V0hik1O08jHIR129YA7bNJYNGAxxsu/0EB1Ugxd+gMugiZEtja8OByv1A9K+OxfHkoC8yPy6WMG16GqIl/pHtjot5jSnbuRO51vyoIj1PLKHEK1gl8STlaMORH9LQOr57rGH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777073521; c=relaxed/simple;
	bh=HblVc0QZVcSH+BEhdYmIe+eu3V5O05SC87J/OgoXbNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouuxexNJObo7J5HoVlroFQxrcZu4UNdoJ/P5VDNQXts/Z2ux9VB7zBT7swLGetaeO0Rj36YopDCYGs3HaMSsCWLTCvAteGGwfvpkkXj7zDDdQGGrdIngA1tMnXnqbutdtT5tiL2+Zf07qkIzkf6MpjoCrTCsz7j7cskPWAQgN/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FWyOdMQC; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FWyOdMQC"
Message-ID: <d8fccecd-5418-46ff-8e9f-065d1dee6d98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777073506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyUuyE7w6pvvtI2U755rVQDGqOG1TjZmAAoWkbcJ3pw=;
	b=FWyOdMQChNJACKlHSUigRbF+UkaZINGXAnfgG0l27LLGRf/hYjHu/Lxkyy0R7Svov/3cgV
	ca7lKrp+oJsiAffpgj9aIdrEaU8SwwAp8RbrsigFrfnx1EjvABSU63IFjcjHzxaGMsifyR
	FfCrsxV2p8KUbJc33PxkbcHVFDmYG7c=
Date: Fri, 24 Apr 2026 16:31:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC bpf-next 1/8] kasan: expose generic kasan helpers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrey Konovalov <andreyknvl@gmail.com>
Cc: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Xu Kuohai <xukuohai@huawei.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
 <20260413-kasan-v1-1-1a5831230821@bootlin.com>
 <CA+fCnZfubV6LgRjO3NQvhrG2Q5o0ftkFFupLWVYS50XDnmCaog@mail.gmail.com>
 <DHSWK17EZUDP.GIJ6BX2NFR6U@bootlin.com>
 <CAADnVQLJ=fJ7t1i2+_RYqU1gqYqiLP9Zrwo4vdZsgzjK_yzJTQ@mail.gmail.com>
 <CA+fCnZd31GzdpEqR8VhfK4JtUKyyRMgbBoAbeGACJgm7WvB6Vw@mail.gmail.com>
 <CAADnVQKv5y+gq=TnOAEXSqgBRpmHNjwqCfxpLaw5XkcbQ+23bg@mail.gmail.com>
 <CA+fCnZe-b0Qqbo5gGv3HN20twquQETDfYYkE1r9tPr9zUFbW9Q@mail.gmail.com>
 <CAADnVQKuptG_opA12O=Xb9_+cHf3f=ycAZdfUp17P2HBYQzdsg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKuptG_opA12O=Xb9_+cHf3f=ycAZdfUp17P2HBYQzdsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/19/26 3:51 PM, Alexei Starovoitov wrote:
> On Sun, Apr 19, 2026 at 2:49 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>>
>> On Tue, Apr 14, 2026 at 5:58 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> I think we're talking past each other.
>>> We're not interested in KASAN_SW_TAGS or KASAN_HW_TAGS.
>>> We're not going to modify arm64 JIT at all.
>>>
>>> This is purely KASAN_GENRIC and only on x86-64.
>>> JIT will emit exactly what compilers emit for generic
>>> which is __asan_load/store. This is as stable ABI as it can get
>>> and we don't want to deviate from it.
>>
>> OK, I supposed that's fair. You did throw me off point with your
>> performance comment. But if you decide to add SW_TAGS support at some
>> point, I think this discussion needs to be revisited.
>>
>> But please add a comment saying that those functions are only exposed
>> for BPF JIT and they are not supposed to be used by other parts of the
>> kernel. And in case you do end up adding a new config option, guard
>> the public declarations by a corresponding ifdef.
> 
> I feel concerns of misuse are overblown.
> Being in include/linux/kasan.h doesn't make them free-for-all
> all of a sudden, but if you prefer we can just copy paste:
> +void __asan_load1(void *p);
> +void __asan_store1(void *p);
> into bpf_jit_comp.c
> 
>>> The goal here is to find bugs in the verifier.
>>> If something got past it, that shouldn't have,
>>> kasan generic on x86-64 is enough.
>>
>> FWIW, I suspect HW_TAGS KASAN already just works with JITed BPF code.
> 
> Ohh. Good point. Looks like modern arm64 cpus in public clouds
> don't have that enabled, so one would need pixel phone to
> catch verifier bugs via hw_tags.

This comment got me curious, and acckktually if we *really* want to,
we can get some KASAN_HW_TAGS testing for BPF already.

The first option is emulation, since QEMU supports MTE [1], e.g.:

    qemu-system-aarch64 -machine virt,mte=on ...

This is of course slow, because it runs in software, so it's
infeasible to run this for every signle patch on BPF CI. But we could
run it on schedule on the base branches or smth like that.

[1] https://qemu-project.gitlab.io/qemu/system/arm/virt.html

The second option is set up an AmpereOne machine on Oracle Cloud
(assuming they are available, haven't checked), because apparently [2]
those CPUs run with MTE.

It's a bunch of infra work and spending, but it is doable if it was
a priority.

[2] https://arxiv.org/abs/2511.17773


> So we still need this x86-specific jit kasan.
> I guess eventually it can be removed when hw_tags support is widespread.

