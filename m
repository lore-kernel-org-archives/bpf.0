Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4253F39C636
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 21:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781646436; cv=none; b=dT4Q+HV9n6SzUFcL2gGzPYNuRrrzHiXvILh23D4CdOUk9cuHdoTFBZ2yAC6/LzpMyKPijpr6Qjp4jeVVJmuVNwtT9C+tj0kj4M6IEh7VtjUnRTR4Pu1WBYOTFpizDIS+WN5q/QoRaf/wJqEMd/2m0a4puCeVYntxr3+pMESbAlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781646436; c=relaxed/simple;
	bh=EP8WzJM9f4tD04pJNHeXtemwXaQnAlZmGRo6vVnD3Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDfjFD3rkA8rBQ4OaEHRNncb/ci6yagcPGgYhuEz5KXtMwCxKtv8zOh8JGakqKNFqzm2Quk7kTVHrpIb7fjjygLu22fs5y4fNhST50jzIT76QRcIkBrjpRMzCPkSE47vG5FtUiymCY0A2htBrcswMsotqa63es2cyRujvW1lbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uwl8PbE9; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uwl8PbE9"
Message-ID: <2d2329ac-5394-4eac-926a-990c83eabaa1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781646429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ytJJED0V5o5ZE5j301pDRjAf2BxYSXlReJ3reV7A+E=;
	b=uwl8PbE93vRyCphXxIKTObalSJjhQC84FTD2BR3+9HZ+eL8a5k2SA9N04kGOxX2B1vadQZ
	lD/lPioScu/ntlU3q+7jZxAar0I+0wuWLu6ntP5c8bcag+4iAyxCwdKlOQu/9j6qDNsTeN
	LPZKVB3JYg/uvYwHiCjU/7fWGJMO0KI=
Date: Tue, 16 Jun 2026 14:47:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 05/14] resolve_btfids: Index BTF ID symbols by
 address
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
References: <20260601221805.821394-1-ihor.solodrai@linux.dev>
 <20260601221805.821394-6-ihor.solodrai@linux.dev>
 <CAEf4BzYevwUOY34KOdjRd9cv5uXdxEwy13+6vHmNo_h4ryyT5g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYevwUOY34KOdjRd9cv5uXdxEwy13+6vHmNo_h4ryyT5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/3/26 4:45 PM, Andrii Nakryiko wrote:
> On Mon, Jun 1, 2026 at 3:19 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Keep an address-sorted index of parsed .BTF_ids symbols so code that
>> the original BTF_ID symbol name can be recovered from an entry
>> address.
>>
>> Use the index in find_kfunc_flags() to scan BTF_SET8_KFUNCS entries
>> directly and match each entry back to the requested kfunc.
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  tools/bpf/resolve_btfids/main.c | 103 +++++++++++++++++++++++++-------
>>  1 file changed, 80 insertions(+), 23 deletions(-)
>>
>> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
>> index f8a91fa7584f..43512af13148 100644
>> --- a/tools/bpf/resolve_btfids/main.c
>> +++ b/tools/bpf/resolve_btfids/main.c
>> @@ -119,6 +119,11 @@ struct btf_id {
>>         Elf64_Addr       addr[ADDR_CNT];
>>  };
>>
>> +struct addr_sym {
>> +       Elf64_Addr       addr;
>> +       const char      *name;
>> +};
>> +
>>  struct object {
>>         const char *path;
>>         const char *btf_path;
>> @@ -150,6 +155,10 @@ struct object {
>>         int nr_structs;
>>         int nr_unions;
>>         int nr_typedefs;
>> +
>> +       struct addr_sym *addr_syms;
>> +       int nr_addr_syms;
>> +       int max_addr_syms;
> 
> nit: max seems misnamed, it's "capacity", so I'd choose
> "addr_syms_cnt" and "addr_syms_cap" naming (I believe libbpf does that
> relatively consistently)
> 
>>  };
>>
>>  #define KF_IMPLICIT_ARGS (1 << 16)
> 
> [...]
> 
>>         for (next = rb_first(&obj->sets); next; next = rb_next(next)) {
>>                 set_id = rb_entry(next, struct btf_id, rb_node);
>>                 if (set_id->kind != BTF_ID_KIND_SET8 || set_id->addr_cnt != 1)
>>                         continue;
>>
>> -               set_lower_addr = set_id->addr[0];
>> -               set_upper_addr = set_lower_addr + set_id->cnt * sizeof(u64);
>> +               set_addr = set_id->addr[0];
>> +               idx = (set_addr - obj->efile.idlist_addr) / sizeof(u32) + 1;
> 
> where is this +1 coming from? we have some reserved zero entry in
> .BTF_ids section? I'd understand if this was symbols table, where we
> do have zero entry, but I'm not quite following here...

We do a +1 in find_kfunc_flags() three times for slightly different reasons:

  // Here we extract the *set* flags from the header
  idx = (set_addr - obj->efile.idlist_addr) / sizeof(u32) + 1;
  set_flags = elf_data_ptr[idx];

  [...]

  // here we skip the btf_id_set header
  Elf64_Addr addr = set_addr + sizeof(u64) * (i + 1);

  [...]

  // and here we extract the flags from a pair
  idx = (addr - obj->efile.idlist_addr) / sizeof(u32) + 1;
  return elf_data_ptr[idx];

I think the way to make it less confusing is to cast the data pointer
to struct btf_id_set8 before inspecting it, and read the fields.

I'll do that in v2.


> 
> 
> 
>> +               set_flags = elf_data_ptr[idx];
>> +               if (!(set_flags & BTF_SET8_KFUNCS))
>> +                       continue;
>>
>> -               for (u32 i = 0; i < kfunc_id->addr_cnt; i++) {
>> -                       addr = kfunc_id->addr[i];
>> -                       /*
>> -                        * Lower bound is exclusive to skip the 8-byte header of the set.
>> -                        * Upper bound is inclusive to capture the last entry at offset 8*cnt.
>> -                        */
>> -                       if (set_lower_addr < addr && addr <= set_upper_addr) {
>> -                               pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
>> -                                        kfunc_id->name, set_id->name);
>> -                               idx = addr - obj->efile.idlist_addr;
>> -                               idx = idx / sizeof(u32) + 1;
>> -                               flags = elf_data_ptr[idx];
>> -
>> -                               return flags;
>> -                       }
>> +               for (u32 i = 0; i < set_id->cnt; i++) {
>> +                       Elf64_Addr addr = set_addr + sizeof(u64) * (i + 1);
>> +                       const char *name = find_name_by_addr(obj, addr);
>> +
>> +                       if (!name || strcmp(name, kfunc_id->name) != 0)
>> +                               continue;
>> +
>> +                       pr_debug("found kfunc %s in BTF_ID_FLAGS %s\n",
>> +                                kfunc_id->name, set_id->name);
>> +
>> +                       idx = (addr - obj->efile.idlist_addr) / sizeof(u32) + 1;
>> +                       return elf_data_ptr[idx];
>>                 }
>>         }
>>
>> @@ -1575,6 +1631,7 @@ int main(int argc, const char **argv)
>>         btf_id__free_all(&obj.typedefs);
>>         btf_id__free_all(&obj.funcs);
>>         btf_id__free_all(&obj.sets);
>> +       free(obj.addr_syms);
>>         if (obj.efile.elf) {
>>                 elf_end(obj.efile.elf);
>>                 close(obj.efile.fd);
>> --
>> 2.54.0
>>

