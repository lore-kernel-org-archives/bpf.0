Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D67E348C66
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787951233; cv=none; b=JFX09Oyr8YMr6TtPc/e8Q5ZtRAf02fzFLpjCYGqQ54Mg3fhgiB+RIz/vhux21v/b33D7U4d6PkyutzeHZmx23TmBi+KYALeQojruVNLgnrfUqUm7LmsYQeeShVqYlijFpjnYb8q9l1L1Vpzj9Amvt7FhEKb78R3T05OfeGUOHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787951233; c=relaxed/simple;
	bh=rgJ9BnCuRCuqewsLD4ZvuhjYJb20nsY1c4BG4Eoib2g=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=IyqqRfFTX6J5q3I4298geYWDfef0eMErnQ40M2hagDT1Ljjx+kgj8lo1+au+corEVrs896TeE6oiz1GzFj4JtQQqsmHbHvEgKtqlF+QmHmWzRXHf4FW+V7KEi2N7p5KcbhCjZsmC+8QxEnDDrbBTAir9vr8xgDTczlA7sH0Q1nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViGf1L8X; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViGf1L8X"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47528970fbdso580832f8f.1
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787951230; x=1788556030; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s+xApWHFlcAD9ScbsbJspW/eUqW4O4eLPOKcYbniiu8=;
        b=ViGf1L8X65d2w2H0VOFmKW9VqDWkiBGi2R1Q0ZXYNo8Mn3UyUDeqGlXav2RaN/f/sm
         WUfXdTgbCUNqgjUevzfK4Udp3yYOyiazNftY9iMC8fwWhsqBsEK6suVoQlsPY0d4V32m
         gZOw+oW/UeyVP7YZ1xBVtdgWUVjIcEovEFj88OSX7GbuvjUDtlppaB3JJM2WKI3sjrQ7
         6q2TAr3TgLXuvDXXKychQxRfMJVuHmOTJLd6rXlrJqym4wNfY8AtDsCEfoSlvxHAbiza
         pXUlkb4HazJ+1GLBOOLFkfnAbTR8U1YwUmGlj47llomjOvgs7p/Ap7prpF6bPumBvuIm
         5yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787951230; x=1788556030;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s+xApWHFlcAD9ScbsbJspW/eUqW4O4eLPOKcYbniiu8=;
        b=UR/JgWKO5PdiQsxOdJAOxfhQZUJmqVXPOJmbtYWAslvOJl/eWCF+j0M4+onp5B5sZh
         HKy0ABDORiL8jaEiDgcbet79GaF74IHCC/jhSSmpi3MkL+VyacFN0gs3akXgrBhj7s2G
         mb2d/Kz4k9cPFY3KDhHSH7DXiGIQZeE9KS7lRAJ8utNCLQuawFUhmCwwN6Po85HvZGFc
         pzAQ62qrNnPXS4wt8bKmLqtfDhujho5bF+MLLIM2lLtv6mXOtI2fIuJTVFazHbh4wPJa
         hOoqlbdptqzG0/nSpXZGAs4jWfNBHrWai27KfO15+pWmABTT/tAVLwRgQdZGmCbndFl2
         jJiw==
X-Forwarded-Encrypted: i=1; AHgh+Rpjk3DWNtUQHNP5lOa5laFy1ZK5SzcvsDa3mDWud5pXOe3woKJUBbPmLlcRp91yOvjDrSg=@vger.kernel.org
X-Gm-Message-State: AFuF++n5OLs0ijmB5X4Rc7d2VFVJmN72RoKe1UbbLCqWqQnv3f/Qp2Lu
	slfY4v//XZuhRg3Ry5qDrXavH9PCFaruHDxsX+p2NSfMYadlZ+ZzvA9D
X-Gm-Gg: AR+sD13h3+Sw0poJJN6jWsv6d8XSwX4+xOaYi98qjZx7ti0Imn5Zsi/SVO20GekU25A
	/EGG4l1nSMlJ9hqvSlKNi4L+3hMZlDvCVZBhDrw/pCJ+7xRiwieXwND61WIEpo3sV2oaqSV/t5+
	5bX8JAtZ592ZENR7msFa7cC+AVsA2byn3gjW8Q1Q6BX7CxNzA/khn5M3r/cXpHkXc0m+K6PJ7NL
	X8XQY+f+boz/SkQhm9oBdmojrfDBsJMLKMlxs419JZ8zI1aVa54+TevuuHCXhcJ7SmzH3xo9R5S
	f1bNOBCV+NHH8ARIKvyba4nJPQRPiN7W/fbJOfCiOZkrCMbgfPD/PAyfOysN3Bm1FX3kyXKYCeX
	pClQ5Ljugp5DvyQfAS78E1Ey9M4CsJHgXS8KhogGP5Yw2WdkTy+24LF7Q4z1jIAXRml65+z5rat
	pmTss4QGG0ir8oyi9X3gL2YTkHFcedv3LQGamWwJBn3Rj/exW4WeMOymvv9/UTM/U5K/IyFCXnS
	D3eZquigdl8JTdU+J1jrwC/Gaa5guum6WTsuDyDs4a0d9ldgB8PnRLX8qWNC94mam4HPVJBa7Fu
	tViu56jHJdYnPVp+oFVZovFkiTAsIzHXDi/aVA==
X-Received: by 2002:a05:600c:4585:b0:499:b402:6c0 with SMTP id 5b1f17b1804b1-49b91c265d7mr138746125e9.3.1787951229566;
        Fri, 28 Aug 2026 14:07:09 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dc0f57sm91854115e9.2.2026.08.28.14.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 14:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 23:07:08 +0200
Message-Id: <DL0VTAZE10HC.3R4HIC6S0U3P1@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Shakeel Butt" <shakeel.butt@linux.dev>, "Hui Zhu" <hui.zhu@linux.dev>
Cc: "Roman Gushchin" <roman.gushchin@linux.dev>, "JP Kobryn"
 <inwardvessel@gmail.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Barry Song" <baohua@kernel.org>, "Geliang Tang" <geliang@kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, "Hui Zhu"
 <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v5 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
X-Mailer: aerc 0.21.0
References: <cover.1787826402.git.zhuhui@kylinos.cn>
 <5dfdc7800469eac4e9a240f2422ba65d4ef4c4ba.1787826402.git.zhuhui@kylinos.cn>
 <apHk86Y8araBlXcq@linux.dev>
In-Reply-To: <apHk86Y8araBlXcq@linux.dev>

On Fri Aug 28, 2026 at 9:53 PM CEST, Shakeel Butt wrote:
> On Thu, Aug 27, 2026 at 06:36:29PM +0800, Hui Zhu wrote:
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> Add bpf_proactive_reclaim(), a sleepable kfunc which performs one
>> proactive reclaim pass on a given memory cgroup, similar to a write
>> to memory.reclaim but without retrying until the target is reached.
>>
>> The kfunc refuses to reclaim if the calling task is already in a
>> reclaim context, as a nested reclaim would corrupt the outer reclaim
>> state.
>>
>> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
>> ---
>>  mm/bpf_memcontrol.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> index 716df49d7647..297ff7f05042 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>> @@ -6,6 +6,7 @@
>>   */
>>
>>  #include <linux/memcontrol.h>
>> +#include <linux/swap.h>
>>  #include <linux/bpf.h>
>>
>>  __bpf_kfunc_start_defs();
>> @@ -159,6 +160,49 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct =
mem_cgroup *memcg)
>>  	mem_cgroup_flush_stats(memcg);
>>  }
>>
>> +/*
>> + * Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
>> + * current->reclaim_state, so a nested call would corrupt the outer
>> + * reclaim state. Reclaim windows are marked with PF_MEMALLOC;
>> + * reclaim_state is also checked because it is installed slightly
>> + * before PF_MEMALLOC.
>> + */
>> +static bool bpf_in_reclaim_context(void)
>> +{
>> +	return (current->flags & PF_MEMALLOC) || current->reclaim_state;
>> +}
>> +
>> +/**
>> + * bpf_proactive_reclaim - proactively reclaim memory from a memory
>> + *                         cgroup
>> + * @memcg: the target memory cgroup to reclaim from
>> + * @size:  the amount of memory to reclaim, in bytes
>> + *
>> + * Trigger one proactive reclaim pass on @memcg, similar to a write to
>> + * memory.reclaim, but without retrying until @size is reached.
>> + * Must not be called with a filesystem lock held: the reclaim path
>> + * may deadlock on it via filesystem shrinkers.
>> + *
>> + * Return: The amount of memory reclaimed, in bytes, or 0 if @size is
>> + * smaller than a page or the task is already in a reclaim context.
>> + */
>> +__bpf_kfunc unsigned long bpf_proactive_reclaim(struct mem_cgroup *memc=
g,
>> +						unsigned long size)
>> +{
>> +	unsigned long nr_reclaimed;
>> +
>> +	if (size < PAGE_SIZE || unlikely(bpf_in_reclaim_context()))
>> +		return 0;
>
> I have been thinking about this more and more and after looking at the re=
asoning
> behind your check current->reclaim_state and also Sashiko's comment on NO=
IO/NOFS
> contexts, I am more convinced that this kfunc can not be a simple sleepab=
le
> function. We need more than that. We need clean process context as well s=
imilar
> to the userspace poking memory.reclaim. Something like kthread or workque=
ue.
>
> Kumar & Andrii, is there a way to restrict a kfunc to only be called from
> special BPF threads/workqueues? Is there some similar concept in BPF worl=
d?
>

Yeah, I think the concern is valid. E.g. inode_rmdir() is sleepable but wil=
l be
problematic here, I think. My first instinct was if bpf_in_reclaim_context(=
) +
nofs/noio save-restore might provide enough protection to let it be callabl=
e
from generic sleepable contexts, but I guess that will disable invocation o=
f
filesystem shrinkers unconditionally.

So my suggestion would be to fix the context to BPF_PROG_TYPE_SYSCALL. Ther=
e, we
should be able to init and schedule timers which poll specific state and ar=
ms wq
execution etc. It then remains invocable from sleepable async contexts (wq,
task_work) or the syscall program, all of which should be ok. Once BPF kthr=
ead
lands we can let it be callable from those threads as well, but that is for
later.

> [...]
