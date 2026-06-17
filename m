Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F03783DE
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 22:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735521; cv=none; b=N4Inw9O8nwd0vnNvz75GNSK+9rqICVPeSnmJ9dM+LXOndUGstzutytnKKek02RknjKX4Z/w8f/Y7ly6dlVhR99Oqsr9MdA+v289GrltTYqpDX+cyZl4PqdSc5eNaeoriXi6F7RH7YDwzVEbCOPKVJXZrZp2QuuryV5ppMD+xoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735521; c=relaxed/simple;
	bh=LP6MOKxT6AVOaaxrfVFy3683XaMrVlsM2YzouGc7spc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BU36eiKP1mTHsK4TNFWqJMVzanG2liIXY2Cg3ICb2XnmeJiouPO3W1an0O3A88KU5xrLRGpwWiYA2bi2pFKJnAMB49V6RyS3p3z5A1JB9KGtrv/8Z/PmflJw7GS9uDjIfJPT+cH/E/9NQSVkSEcefnTpMLn5ZsPJq2Nve2UqzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mzFDW0pr; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mzFDW0pr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781735506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=932P7j4+kVPkCsbzaJNwD/gpMUS7xJYuYYBSNyy6MMw=;
	b=mzFDW0prvbckaS+i1HZkAb+l0HQkoF84AwC74+AzNGZwtQNi2RdM1MK5p2ztt2WiqWt3uS
	OZsKMgl8fmU4jxcdWPCkNWGklacmBCa6Sny6t2EHuGoIV1bHAvCHF9qNack3nZzZ8RaXdk
	XoLHkokSK//4lElYheSKb8MYNF3DigU=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: JP Kobryn <jp.kobryn@linux.dev>,  Shakeel Butt <shakeel.butt@linux.dev>,
  Andrew Morton <akpm@linux-foundation.org>,  Alexei Starovoitov
 <ast@kernel.org>,  bpf <bpf@vger.kernel.org>,  linux-mm
 <linux-mm@kvack.org>,  LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/bpf_memcontrol: mark BPF memcg kfuncs static
In-Reply-To: <CAADnVQJ=q7hJkt=ekLD_a5KjJ_+icdwgsY61rujjLMKAKByvWw@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 17 Jun 2026 14:06:31 -0700")
References: <20260617202147.78347-1-jp.kobryn@linux.dev>
	<CAADnVQJ=q7hJkt=ekLD_a5KjJ_+icdwgsY61rujjLMKAKByvWw@mail.gmail.com>
Date: Wed, 17 Jun 2026 22:31:38 +0000
Message-ID: <7ia4cxxosss5.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jun 17, 2026 at 1:22=E2=80=AFPM JP Kobryn <jp.kobryn@linux.dev> w=
rote:
>>
>> The kfuncs in bpf_memcontrol.c are not called by in-kernel C code. They =
are
>> only referenced by BPF programs and resolved through BTF.
>>
>> Since no external linkage is needed, mark these functions static.
>>
>> Fixes: 5904db9891f8 ("mm: introduce BPF kfuncs to deal with memcg pointe=
rs")
>> Fixes: 5c7db3239c9f ("mm: introduce bpf_get_root_mem_cgroup() BPF kfunc")
>> Fixes: 99430ab8b804 ("mm: introduce BPF kfuncs to access memcg statistic=
s and events")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202606150332.Xy4Egd9s-lkp@=
intel.com/
>> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
>> ---
>>  mm/bpf_memcontrol.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
>> index 716df49d7647..eff79bb2c758 100644
>> --- a/mm/bpf_memcontrol.c
>> +++ b/mm/bpf_memcontrol.c
>> @@ -20,7 +20,7 @@ __bpf_kfunc_start_defs();
>>   *
>>   * Return: A pointer to the root memory cgroup.
>>   */
>> -__bpf_kfunc struct mem_cgroup *bpf_get_root_mem_cgroup(void)
>> +__bpf_kfunc static struct mem_cgroup *bpf_get_root_mem_cgroup(void)
>
> sashiko disappoints. It couldn't notice that kfuncs should not be static.
> We have few "__bpf_kfunc static" in net/ipv4/
> that work by sort-of "luck", since their addresses are taken.
>
> In general kfuncs cannot be declared static.

It seems like it thought hard on it but failed based on the existing
code and a bit vague documentation in Documentation/bpf/kfuncs.rst:

  kfunc definitions should also always be annotated with the ``__bpf_kfunc``
  macro. This prevents issues such as the compiler inlining the kfunc if it=
's a
  static kernel function, or the function ...

So it reads like bpf kfuncs can be static.

This is the reasoning from the logs (a dismissed concern, to be precise):
{
      "type": "Dead Code / Linker Error",

      "description": "Marking kfuncs as static could cause the compiler
      to optimize them away, breaking BPF verifier BTF resolution.",

      "reasoning": "The patch adds `static` to multiple `__bpf_kfunc`
      annotated functions that are not called anywhere in C
      code. Normally, a compiler would remove unused static functions or
      fail to expose them in object files, which could prevent the BTF
      ID generation logic (`resolve_btfids`) from finding them. However,
      the `__bpf_kfunc` macro expands to include `__used` and
      `__retain`, which strictly instructs the compiler and linker to
      preserve the functions in the object file regardless of
      usage. Additionally, `resolve_btfids` and `BTF_ID_FLAGS`
      successfully parse and resolve `STB_LOCAL` static symbols, making
      this change completely safe and correct.",

      "locations": [
        {
          "file": "mm/bpf_memcontrol.c",
          "function_or_symbol": null,
          "line_range": null,
          "why_this_location_matters": "This applies to all the
          functions modified by the patch."
        }
      ]
    }


Thanks
