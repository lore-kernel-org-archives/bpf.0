Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD281E5724
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804868; cv=none; b=HCF4UdyegAHLc+6oe+BON4gzx+SXsaJEr+70OL/RpNCEe8oMuha+oAoZO8o54jl6VhKy/YfJh1/lVJYt/bmWwsK1mwerntYdtyCgFJQ+g8u7g7GWQ20bOATWlxg++6JP3qSdBvo/1Xa2KYN5aOcFzjHZSeMcDQe/y6Iy0OTki1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804868; c=relaxed/simple;
	bh=lrNAo5o5J32vSMC/U45YIP3FUzp4KMhFYNSZ+pBLktg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PG9keDoizsLRZ5SrJLs5baPf4M2QBM68eEVv+mXf8gFCbr/DukOM5o6pL0rAwcKOj+AvQqajoMXE8eq7t+JotrVORWg3mdlTwOlLBZ93nzFWg3sA+I5jVzSeCoyuwPUsydbVF9s60uqSy0QNb0a/mTX1u6/tC+4KSv7/cDPi3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AFWgePAk; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AFWgePAk"
Message-ID: <1bfdbc2c-0913-48ef-ab8d-8021e0944884@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778804864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbNeWSuRNX1d1NVzpudKnFGDqs5n3rgMzCUDqnC/7gk=;
	b=AFWgePAkncPUwd3BzTBfBsF9ipzJxHEXT3UXsxVobULreQX5+uMpnVXPdp6xqnJH0WPJ5G
	2SMu69Em147SO8AUZkOCcc8d+8NHKPaa0NMlnY/YPctLMx4gBg5ogVuyQud3AsQWhKh7Dw
	/G4ToWMn0hUQoFSXWsEjH9241D1+ils=
Date: Thu, 14 May 2026 17:27:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 3/3] bpf: Cache build IDs in sleepable stackmap
 path
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Puranjay Mohan <puranjay@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
References: <20260514184727.1067141-1-ihor.solodrai@linux.dev>
 <20260514184727.1067141-4-ihor.solodrai@linux.dev>
 <CAADnVQKA+uTzZECqijzRhjfY7MNxr-ehMzjY0ea0S=QWk+KRYA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKA+uTzZECqijzRhjfY7MNxr-ehMzjY0ea0S=QWk+KRYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/14/26 5:24 PM, Alexei Starovoitov wrote:
> On Thu, May 14, 2026 at 11:48 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Stack traces often contain adjacent IPs from the same VMA or from
>> different VMAs backed by the same ELF file. Cache the last successfully
>> parsed build ID together with the resolved VMA range and backing file
>> so the sleepable build-ID path can avoid repeated VMA locking and file
>> parsing in common cases.
>>
>> Suggested-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  kernel/bpf/stackmap.c | 56 ++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 53 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
>> index c1e96df360c3..8a18c9645933 100644
>> --- a/kernel/bpf/stackmap.c
>> +++ b/kernel/bpf/stackmap.c
>> @@ -226,13 +226,33 @@ static void stack_map_get_build_id_offset_sleepable(struct bpf_stack_build_id *i
>>                 .vma = NULL,
>>                 .mm = mm,
>>         };
>> -       unsigned long vm_pgoff, vm_start;
>> +       struct {
>> +               struct file *file;
>> +               const unsigned char *build_id;
>> +               unsigned long vm_start;
>> +               unsigned long vm_end;
>> +               unsigned long vm_pgoff;
>> +       } cache = {};
>> +       unsigned long vm_pgoff, vm_start, vm_end;
> 
> cache logic cannot go into bpf. it's not a fix.
> So either drop it or the whole thing into bpf-next.
> Which is probably better.

I'll send a v5 targeting bpf-next shortly. Thanks.

