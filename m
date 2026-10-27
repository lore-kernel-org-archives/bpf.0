Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125094;
	b=d7JxM7JZqA1xldZwmDkHby3Vm4fOhDphN3EpWFykk5wPCL0cZ7wbNe9LOH08NExtA1AD
	 bYCMVBNmt1rJtyKSuNfjTxg4Jm8/ucZfSidH4egvO5EH0+E1vMbICensbU0NbA935Jat3
	 FNsH1rCBIDqD3u1GBZA/RXDFVbgaV5CTwmEC9ZfKLmRPsdidVUlsSrQM2sDJHrDXk5scB
	 1z1bgueE0rG/jfcyvZ+JyuVz4HNWxNKRAddpARh5ye7NZH+sJ7vL+u9aaB75Fsao8V+zT
	 GQvyEBt0Pa+OmpUiI+k0Z02680cqtIveMEy4FhDZ0UBmRerw6ozc8iqkqS0G3HVU5tQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125094;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ei6XMbYAS9u8x5NixcKYnlg7x4RBCPwOWVERQ5BIkkA=;
	b=zDGpJe374d0u+w4PLLHFAOa8F4WlESvrg802jKhhuD06/vJsIT1YrszkkQuM1xT/2W+E
	 iAPkuGw8B9M9Tz7nId55O94KYMDdYoo8W5t4G9no9DUIK0bK2iLrkyEf47x4l+fKJBXRl
	 r0jiduLN70X71/2aqsLMRuaXQI+9l9vU3mRqVrDrSzxgK/+s5eYx2l2JaXJkA6Eof77Ww
	 yI6nB6y35oDuscoUj6MTkGCAV6kdrM/n9bQjP8ojWJA1JdRM7YyT/wVUQOBCgvxgim5cA
	 SeJyFJq/ZkUCqqWvKvXD7AeT2bKQ3tkEcFLlWD1p8N6FggNQHMOoQBpxtcjI3NXwc3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EvU2AC9P;
	arc=none smtp.remote-ip=91.218.175.8
Received: from mta0.migadu.com (out-8.mta0.migadu.com [91.218.175.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEA4606A321
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CEA4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EvU2AC9P
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BjkTiXWt0fBbevv/KWwVwxpG6/7mMcxjAVLE/IT8TSk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793125085; v=1; x=1793729885;
 b=EvU2AC9PVpErmZ1/OaSyweNF675GRH9Q/qgTnJ7ci/7dCcMFd00jJQuIg3+R+JuURDVmVPBy
 82o6pAtZed2QLyTwq1sZTxlPp0IQ3vjehb0EGNPDCNps6PHaiZr6ktNB9SldjNK24LIefGMSPmG
 ENxualTkHBaaoQRrHJP0B8Yw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 02b3f0cfd3c9568e;
	Tue, 27 Oct 2026 18:18:04 +0000
X-Mizu-Trace-ID: 02b3f0cfd3c9568e
X-Migadu-Flow: FLOW_OUT
Message-ID: <5718c42b-6cc5-4816-9b67-2a22ddd7f416@linux.dev>
Date: Tue, 27 Oct 2026 11:17:59 -0700
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
Subject: Re: [PATCH bpf-next v2 4/8] bpftool: Skip __bpf_relocatable on
 verifier-rewritten context types
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org,
 Alan Maguire <alan.maguire@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 David Faust <david.faust@oracle.com>, Ian Rogers <irogers@google.com>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Vineet Gupta <vineet.gupta@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
 <20261023222652.3927736-5-ihor.solodrai@linux.dev>
 <CAEf4Bza2KV8ZbV2eeGyNabErZ43gY+md4WP6N7XPVL0_dw-mAA@mail.gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4Bza2KV8ZbV2eeGyNabErZ43gY+md4WP6N7XPVL0_dw-mAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/26 11:06 AM, Andrii Nakryiko wrote:
> On Fri, Oct 23, 2026 at 3:27 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> 
>> [...]
>> +
>> +/*
>> + * Anonymous records within types that need static offsets must not start
>> + * CO-RE access chains. Named records, typedefs and pointer targets are
>> + * separate types.
>> + */
>> +static void btf_c_mark_no_pai(const struct btf *btf, __u32 id, unsigned long *no_pai)
> 
> mark_static_offset to keep terminology consistent?
> 
>> +{
>> +       const struct btf_type *t = btf__type_by_id(btf, id);
>> +       const struct btf_member *m = btf_members(t);
>> +       __u32 i;
>> +
>> +       __set_bit(id, no_pai);
>> +       for (i = 0; i < btf_vlen(t); i++, m++) {
>> +               const struct btf_type *mt;
>> +               __u32 mid = m->type;
>> +
>> +               mt = btf__type_by_id(btf, mid);
>> +               while (btf_is_array(mt) || btf_is_mod(mt)) {
>> +                       mid = btf_is_array(mt) ? btf_array(mt)->type : mt->type;
>> +                       mt = btf__type_by_id(btf, mid);
>> +               }
>> +               if (btf_is_composite(mt) && !mt->name_off && !test_bit(mid, no_pai))
>> +                       btf_c_mark_no_pai(btf, mid, no_pai);
>> +       }
>> +}
>> +
>>  static int btf_c_annotate_records(struct btf *btf)
>>  {
>>         __u32 i, cnt = btf__type_cnt(btf);
>> +       unsigned long *no_pai;
>>         int err;
>>
>> +       no_pai = bitmap_zalloc(cnt);
> 
> this will cause problems for github mirror that won't have access to
> linux-internal include/linux/bitmap.h, 

Good point, haven't thought of that.


> ...I'd just open-code a simple
> bitmap or use bool array for simplicity, memory usage increase doesn't
> really matter here
> 
>> +       if (!no_pai)
>> +               return -ENOMEM;
>> +
>> +       for (i = 1; i < cnt; i++) {
>> +               if (btf_c_needs_static_offset(btf, btf__type_by_id(btf, i)))
>> +                       btf_c_mark_no_pai(btf, i, no_pai);
>> +       }
>> +
>>         for (i = 1; i < cnt; i++) {
>>                 const struct btf_type *t = btf__type_by_id(btf, i);
>>
>>                 if (!btf_is_composite(t))
>>                         continue;
>> +               if (test_bit(i, no_pai))
>> +                       continue;
>>                 err = btf__add_decl_attr(btf, "__bpf_relocatable", i, -1);
>>                 if (err < 0)
>> -                       return err;
>> +                       goto out;
>>         }
>>
>> -       return 0;
>> +       err = 0;
>> +out:
>> +       bitmap_free(no_pai);
>> +       return err;
>>  }
>>
>>  static int dump_btf_c(struct btf *btf,
>> --
>> 2.56.0
>>

