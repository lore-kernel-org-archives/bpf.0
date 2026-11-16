Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865750;
	b=WQIHbi46YlU7HdOCvfHw5nc9FUCX6i7wvAf0gDowhvI81Qmq5bBkHQUdkeLmboTDiS23
	 5zQ1TnuL4X5E9LOU60k6eaboW2d7mG8i05IAY/U8c+QsE6Ai6D/gfBL1V1+r+wd3Dr+sV
	 MwimKol+B9lYUGoATlFTp8w96gQ3jwDrhtYao1aL582vLO40X9W6oEEtLiYHAufwwre+i
	 tfFR2YzM9dnw4lMrmN8y6WHlXORvW6fR/onG096uG4S6pgEXoZSfKq1e7Mnv1zJEk4pN6
	 OwZylTJqi3XrUs3R9JiPc4ywWBhf/QTte12xsfajb5RekmTimEqI3o6obXjPN2vcirA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865750;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=yJuKOBNNYnk1ty+KHw/zCYtkc5H0NaB5Yj6zALlwHps=;
	b=zKWl25v1oK0Fqm4p6f/Gp2rIAAAzv+cyLfzJO82YlGnwS+SeGs2ldvSkfdLeLys27sJ9
	 ObnTgKd1fqyDjMZshcn2muptCRZp7SQXsyX2Oirj8HgqS3YnHd+Mxy+BquOwXF4mZKsV7
	 9suorX4UQ2zu1TclCyKKvwgVuQJQVXu/TXDGwuOc+KSCKz8hx05bzcUkVbgv667diWhDV
	 2gW78XUUBVx5S3Q2FwCsbzieRcekKLEsRizlab3729w2G3CanP1SUHWgjfKejk+fjbGjK
	 6g7Dtdq25BarkXXgEXHM/idj7UMEVln91WogmNZ+UesF9WrBsvrd8qmZoMzMxRtAR8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="J1UhoB/9";
	arc=none smtp.remote-ip=91.218.175.64
Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F9606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 21:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE6F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=J1UhoB/9
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Oi5wYhbLjwdZu+R9/Qn3xoP1Vc2SrBmiTpo0zBudxz0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794865747; v=1; x=1795470547;
 b=J1UhoB/9/+fOB3vHOjJ5A4h6AVVjN3hYuRW08wofnUttUirmkSUBjzTI6JlepQw2+2X8w00F
 qbZoCe52zWoPnLFc3Tah3Vv8LNItCZodcMUgTslNN0BgB9TMjL9NpL/PcPghH8Msfwhbw/cAVm7
 eU/6cwrzJKyL4Rkbhdesh5p0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5853fed9c1d37e21;
	Mon, 16 Nov 2026 21:49:07 +0000
X-Mizu-Trace-ID: 5853fed9c1d37e21
X-Migadu-Flow: FLOW_OUT
Message-ID: <2e6d98fe-527f-4188-bca0-c9db1ad92bce@linux.dev>
Date: Mon, 16 Nov 2026 13:49:02 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] local_lock: do not put btf_type_tag on the lock
 guard type
To: Chris Down <chris@chrisdown.name>
Cc: dennis@kernel.org, tj@kernel.org, cl@gentwo.org, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, acme@kernel.org,
 yonghong.song@linux.dev, eddyz87@gmail.com, martin.lau@linux.dev,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, llvm@lists.linux.dev
References: <20261110012235.1024461-1-vineet.gupta@linux.dev>
 <20261110012235.1024461-3-vineet.gupta@linux.dev>
 <20261113115810.cd33f9ed58c02dd9@chrisdown.name>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261113115810.cd33f9ed58c02dd9@chrisdown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/26 11:58 AM, Chris Down wrote:
> Hi Vineet,
>
> Vineet Gupta <vineet.gupta@linux.dev> writes:
>> 	typedef local_lock_t __seg_gs
>> 	__attribute__((btf_type_tag("percpu"))) lock_local_lock_t;
>>
>> 	typedef struct { local_lock_t __seg_gs
>> 	__attribute__((btf_type_tag("percpu"))) *lock; } class_local_lock_t;
>>
>> Both put the tag on local_lock_t, an aggregate: the first on a typedef of
>> it, the second on the pointee of the guard's member.
> The typedef is the aggregate case, and it's the only one of the two that
> GCC warns about. But the second one is just the "T __percpu *p" spelling
> that 1/2 keeps the tag for. _T->lock really is a pointer to per-cpu memory,
> since local_lock() passes it to this_cpu_ptr(). So the tag is correct
> there. This patch drops it from the guard's lock member and the
> constructor's argument as well, not only from the typedef. I think it
> should keep the tag on those two and only drop it from the typedef.

Yes you are right, the patch conflated them. And although the warning is 
same as in patch 1, there typedef is actually involved


>> Every variant of an
>> aggregate shares one DIE, so there is nowhere to record it, exactly as for
>> DECLARE_PER_CPU() of a struct. clang writes the annotation into DWARF
>> without complaint, but pahole does not translate it from that position,
>> so with today's toolchains it reaches BTF from neither compiler.
> That's true of the typedef, but not of the member. With clang 23 and
> pahole 1.32 the lock member comes out as PTR -> TYPE_TAG 'percpu' ->
> local_lock_t, the same as any other per-cpu pointer.

Yep it was wrong for the member. My config was lacking 
CONFIG_CONTEXT_ANALYSIS_TEST and hence it missed this part.

> For the typedef, clang 23 puts the annotation on the typedef's own DIE, as
> you say, so there is somewhere to record it. It's only pahole that doesn't
> pick it up yet. You also mentioned GCC patches for type tags on typedefs
> in the pahole thread [0]. Once those land, does this warning go away?

Correct, although [0] you referred to is a different, likely won't fix.
The fix you have in mind is PR125888 [1] and the patches are here [2]
This addresses the For BTF, as you say, pahole doesn't convert 
annotation from a typedef DIE so the

>> Unlike the per-cpu declarations this changes no BTF at all. A tag in that
>> position was never recorded, so there is nothing to remove, and the one
>> percpu TYPE_TAG that does reach a local_lock type comes from those casts,
>> which keep it. An x86 defconfig built with clang is identical with and
>> without this patch: 152551 BTF types and a 6828300 byte .BTF either way,
>> and .text is unchanged. The patch removes a GCC diagnostic and no more.
> The defconfig BTF only stays the same because nothing in a defconfig uses
> these guards. lib/test_context-analysis.c is the only user in the tree.
> With CONFIG_CONTEXT_ANALYSIS_TEST=y, class_local_lock_t,
> class_local_lock_irq_t, class_local_lock_irqsave_t and
> class_local_lock_nested_bh_t all lose the percpu tag on lock with this
> patch applied.

Yep I was missing that.

> Nothing in BPF looks at those types today, so this doesn't break anything.
> But it does remove correct annotations to get rid of a warning that is
> only ever caused by the typedef itself. When the guards were added, the
> type was only ever used as _type *. The typedef came later with
> 3931d4b98039 ("cleanup: Basic compatibility with context analysis"). If
> GCC isn't going to accept the tag on a typedef, could this be limited to
> that typedef in cleanup.h instead, so the guard's pointer keeps its tag?
> As far as I can see, lock_##_name##_t is only ever used through a
> pointer, in DECLARE_LOCK_GUARD_1_ATTRS().

I think GCC supporting them seems like a reasonable ask - fixes have 
been posted, lets see.

But to recap, I will drop this patch since it only needs to handle the 
warning which can't be fixed in source and relies on the GCC fix.

The point of this series was to do any needed kernel source changes 
which can't be addresses in GCC.
e.g. PR128480 [3] was deemed invalid/wont-fix on GCC side.

> [0] https://lore.kernel.org/r/252c53f3-3f06-40f4-9cd3-795eb298687c@linux.dev

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=125888
[2] 
https://inbox.sourceware.org/gcc-patches/20261112191815.884167-1-vineet.gupta@linux.dev/
[3] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=128480

Thanks again for chiming in.
-Vineet
