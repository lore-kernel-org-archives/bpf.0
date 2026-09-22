Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B52656B847
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096391; cv=none; b=dxIYRdRLhiX8UC8ONrP2Lp9inQRRelqce5pMlo9ISX9B25IhlwL94k7Mf3cfIYehg5gQT2Y0vBbVZIn5O+mlUBeMrb8VXAt/GR1DPezu3wRQp9+gNbhtksirIEXWc8jHTRVDagNyL2L83PKeYg+w+Op23tGpwRHAtsPRVrclffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096391; c=relaxed/simple;
	bh=jFYLSHbuqEWLXAoNfCyfzPhAbd+uWuCImNDMjuxDksw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSBaRvpXKgbA+EHSEsMn4GuMsiLZ3XSWXgTsapCgKRETJAr1d1RDnrqGFBao95j+oWf1xqEtaNNrGVz/HQSeCp+JEeb3t8dd8VbHRIYOA/tXG45+Sv/ocJI7Cn2CY6Eay26Ty7U8a2X4RIpGS4Uh1R7xu7ruaCog0MgUdXzhTPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TwqrO/7n; arc=none smtp.client-ip=91.218.175.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TwqrO/7n"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jFYLSHbuqEWLXAoNfCyfzPhAbd+uWuCImNDMjuxDksw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790096386; v=1; x=1790701186;
 b=TwqrO/7nP2qAkqx251aGi+0Tj4diIIbJCT0FFxS6eaE228GZcLxDr5fMURE5fyHWZA6KHMhT
 XdXAYfHqUTsSuLlbzgFMqDs2HbWAPlKsprTD87hBPpwG9f7v1zgg2nnHGK12VLYSm1lB0kdGiDL
 x78YrfWQqKqcr1eoaP6A2ycQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c2e5b3af44d5ec3e;
	Tue, 22 Sep 2026 16:59:45 +0000
X-Mizu-Trace-ID: c2e5b3af44d5ec3e
X-Migadu-Flow: FLOW_OUT
Message-ID: <e356ea48-b9a6-429e-bf30-18c0e079e01a@linux.dev>
Date: Tue, 22 Sep 2026 09:59:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 2/4] libbpf: Render decl_tags in btf_dump
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 bpf@vger.kernel.org
References: <20260917012037.1396254-1-ihor.solodrai@linux.dev>
 <20260917012037.1396254-3-ihor.solodrai@linux.dev>
 <CAEf4BzYXbPCAjbEg=E-VR-7owN3hGqE32OVTWRrWhPqDQVnC4w@mail.gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYXbPCAjbEg=E-VR-7owN3hGqE32OVTWRrWhPqDQVnC4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/17/26 4:59 PM, Andrii Nakryiko wrote:
> On Wed, Sep 16, 2026 at 6:21 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> [...]
>> ---
>>  tools/lib/bpf/btf_dump.c | 94 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 94 insertions(+)
>>
> 
> series looks good, just small nits below

Hi Andrii, thanks for the review.
Sorry I didn't reply earlier, wanted to get that REF_TYPE_FRAME stuff out.

> 
>> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
>> index 635fa969e145..1e8236c8b9a5 100644
>> --- a/tools/lib/bpf/btf_dump.c
>> +++ b/tools/lib/bpf/btf_dump.c
>> @@ -77,6 +77,11 @@ struct btf_dump_data {
>>         bool is_array_char;
>>  };
>>
>> +struct decl_tag_desc {
>> +       __u32 target_id;
>> +       __u32 tag_id;
>> +};
>> +
>>  struct btf_dump {
>>         const struct btf *btf;
>>         btf_dump_printf_fn_t printf_fn;
>> @@ -93,6 +98,11 @@ struct btf_dump {
>>         const char **cached_names;
>>         size_t cached_names_cap;
>>
>> +       /* decl tags, sorted by (target ID, tag ID) */
>> +       struct decl_tag_desc *decl_tags;
>> +       size_t decl_tags_cnt;
>> +       size_t decl_tags_cap;
> 
> nit: decl_tag_cnt, decl_tag_cap, "count" expects singular noun before
> it: "table count" not "tables count"

ack

> 
>> +
>>         /* topo-sorted list of dependent type definitions */
>>         __u32 *emit_queue;
>>         int emit_queue_cap;
>> @@ -192,9 +202,37 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
>>         return libbpf_err_ptr(err);
>>  }
>>
>> +static int btf_dump_cmp_decl_tags(const void *a, const void *b)
>> +{
>> +       const struct decl_tag_desc *x = a, *y = b;
>> +
>> +       if (x->target_id != y->target_id)
>> +               return x->target_id < y->target_id ? -1 : 1;
>> +       return x->tag_id < y->tag_id ? -1 : 1;
>> +}
>> +
>> +static int btf_dump_push_decl_tag(struct btf_dump *d, __u32 id, const struct btf_type *t)
>> +{
>> +       const struct btf_type *target = btf__type_by_id(d->btf, t->type);
>> +
>> +       if (!target || (!btf_is_composite(target) && !btf_is_typedef(target)))
> 
> target shouldn't be null with correct t->type, don't add defensive checks

According to comments, decl_tags technically can refer to a type that
is not the BTF yet:

tools/lib/bpf/btf.c:3314-3323:

  /*
   * Append new BTF_KIND_DECL_TAG type with:
   *   - *value* - non-empty/non-NULL string;
   *   - *ref_type_id* - referenced type ID, it might not exist yet;
   *   ...
   */
  int btf__add_decl_tag(...)

Granted, I wouldn't expect this to be a real use-case. But if we
decide to drop checks like this, then I think we should be explicit
about "no incremental dump", and maybe simplify relevant code a bit.

> 
> but also why this artificial limitation on the kind of thing that is
> tagged? memory savings?

Yeah, I guess the effect of this is memory savings, but that wasn't
the motivation.  I just thought "why collect tags that we are not
going to dump?".  But the index can collect everything, it shouldn't
affect the dump. Do you think we should do that?


> 
> 
>> +               return 0;
>> +
>> +       if (libbpf_ensure_mem((void **)&d->decl_tags, &d->decl_tags_cap,
>> +                             sizeof(*d->decl_tags), d->decl_tags_cnt + 1))
>> +               return -ENOMEM;
>> +
>> +       d->decl_tags[d->decl_tags_cnt++] = (struct decl_tag_desc) {
>> +               .target_id = t->type,
>> +               .tag_id = id,
>> +       };
>> +       return 0;
>> +}
>> +
> 
> [...]

