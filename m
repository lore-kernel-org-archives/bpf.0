Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D828727D
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546854; cv=none; b=YWhMDwKYyHbzc6fhgFKZeCMNHxA0CzrMkxaUmNqE0JmIEOjUhWM9GO8DnJ86rymtHO62bLPFR2YaS1Az0dtcyYq2D8hkAlo5NFJiZ4b3m4Dw8F+ZXjJnYbymQrR0WlAXiPlQ1D8d+sGrTKn9+30NAgua4bGJaq3QQA5A7cOjNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546854; c=relaxed/simple;
	bh=rZcwqTKzBmQ9xeyFfvycFgI34PEL2PGDppu7vMC1dxo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RvQCxkK+QTXFnZ5hYKuTCYa3ZnvPcQFnVdnqD3YPIK+HjgIKTo2gDUAnFwMgbyWUlGVJVrtjniz6sDSWmTgdTN2NnBGLbGtESeF9KXSK2cAvjF1TVQhZns008TwXGcwScuLTggaHzuzodo4ofz3JRk2LlN4i+7SJjIz92M+fAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MXrV5wPR; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MXrV5wPR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769546849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p62oMbD2WGIl31iE58AjJBexIFrmv0YyTyX0OQvm33U=;
	b=MXrV5wPR59IDMmslYF9So3TZUiPFv26eBfOnddXc6nMgRjMhB+pPURPChm0vE2CuMcyCMe
	TivIEtPADaLv6IkiwsRuiagd892Hf21vczCj5R9zqXFJFBfDwlb7Uvj2u7I0qDsgo1EeRD
	oxHDJcrrjld+4Lxv4mpaOFiYGYO71jw=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>,  Alexei Starovoitov <ast@kernel.org>,
  Matt Bobrowski <mattbobrowski@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 08/17] mm: introduce bpf_oom_kill_process()
 bpf kfunc
In-Reply-To: <9a2c5f29-b45c-4ff3-a8f4-51d207a82d38@linux.dev> (Martin KaFai
	Lau's message of "Tue, 27 Jan 2026 12:21:03 -0800")
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
	<20260127024421.494929-9-roman.gushchin@linux.dev>
	<9a2c5f29-b45c-4ff3-a8f4-51d207a82d38@linux.dev>
Date: Tue, 27 Jan 2026 20:47:11 +0000
Message-ID: <7ia48qdilr5c.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 1/26/26 6:44 PM, Roman Gushchin wrote:
>> +static int bpf_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
>
> The filter callback is registered for BPF_PROG_TYPE_STRUCT_OPS. It is
> checking if a kfunc_id is allowed for other struct_ops progs also,
> e.g. the bpf-tcp-cc struct_ops progs.
>
>
>> +{
>> +	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
>> +	    prog->aux->attach_btf_id != bpf_oom_ops_ids[0])
>> +		return -EACCES;
>
> The 'return -EACCES' should be the cause of the "calling kernel
> function XXX is not allowed" error reported by the CI. Take a look at
> btf_kfunc_is_allowed().
>
> Take a look at bpf_qdisc_kfunc_filter(). I suspect it should be
> something like this, untested:
>
>         if (btf_id_set8_contains(&bpf_oom_kfuncs, kfunc_id) &&
> 	    prog->aux->st_ops != &bpf_oom_bpf_ops)
>                 return -EACCES;
>
>         return 0;

Oh, I see.. It's a bit surprising that these .filter() functions
have non-local effects...

Will fix in v4.

Thank you, Martin!
