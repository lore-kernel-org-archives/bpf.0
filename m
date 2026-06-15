Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDDF36EA8E
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560413; cv=none; b=F2PNlJ9XonxTYLpMM3JoniLmy4+VreUUVEIFs9BNth2m+WeIoogSNWXzd96KYl7KJeL+R7dlwup6W6LMPLPjqy+YaD7GNwUuHF+DMdw9v9aEotOF55XTHySgtr6n8pRJQWaaOiVnWyN9PSta2vyWvsipmXPw16Y4Mwrd/XuCF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560413; c=relaxed/simple;
	bh=krc4C0aOyhys5IHF7Q2ZQw6WG6LZf9FhuifvQZV5D4c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YbScp/lYnm2b38ox7aqzDIm7yPsMoSczmvTScu18gZj3yDOTt7basJ6r+UzmLWXalyc7BCAxhCyucBPvz7Rrc397eof/ue0lV7X3widQHGRSJVd5jQ+ONm2f5ptD4vdCvJBvK2gGBTdvtgun45F+nOGrD4MK5td6MlQj9+YAXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=UOgGDNjU; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="UOgGDNjU"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304e83724bfso5283598eec.0
        for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 14:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781560410; x=1782165210; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uAi4ngEJufnnfkL8J9c+G1dQ4aqUKqtbYnmsEnXy/4=;
        b=UOgGDNjUSkMxnhWsso44wgJ6V8Eaitqxor5UO+LP6c0+w3Q9n6COEk4+Pqz7O51QVw
         3AUzdq4uVzlrV/yqryBw1qD3drXkXIESq9K3xmNn4RAgpEvPR15CSalTX1HUFyGoW8mD
         DN5GK4pXjXwaOse3YTFgtHJB8qNVe5yrKh0w1Ael0ESd3XL8SPDBYJk+CNqplaqzQERi
         2BQ3JI6+mncm7EqFaDwUT8KWC69/uAIvcXHaTeptAt3OhKQkdclQTHM7KWHWeKQ33OEB
         ZIdMoUN9cwVj8py1zeSOVRcirWa/SIpHO9BAOj6t3uPjtuIqfZoTUAIuUKWjcCG5RYoI
         Q9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560410; x=1782165210;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uAi4ngEJufnnfkL8J9c+G1dQ4aqUKqtbYnmsEnXy/4=;
        b=ri4FXxMxsmt4nXYM1n/rCxf3dNVQO5L2Es+t7al/d8kDU+QEtMcoCAX97fGggF8ERk
         ba5kanXHye0Q3zxB1fF1td1z7HJjHzhRAOx9Ni55I4R6W2cYUMT7CLH9rIzU+LXN2jbk
         pmUvdv6kSGD8Stjn1gUyu+VNsmbYG38SGNUm5iz/vEfAhWDyQJArqZmYlYwVzi0yDPn0
         5Kh/C1beiP+LTaCCKFQ+YdUXSERsMsMsa+VokFXw7uu63DF2Txeckd1ocs1SjJbMZAVa
         2DKLllxHaRbS54bEYbHO+jeg6g4Rl6DbDs9ifclswf2tK6GmEg3lvFtP6VnefzHb1z/D
         RHOA==
X-Forwarded-Encrypted: i=1; AFNElJ81rNI5cVy97IsubFRw9ekLRwyuPZn3VTKcx/ivVNpTnxR6cx0WsIs3mDaUfR5bADj2tMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys64Q4Dg2PJ+2l7kK+/0SuCnD+efjbUW2etWlkuRDk6wsfRz89
	CrA91xL1rMuwog0e6e0fe/9FSSjiWDeqZ3d56NZDmDmL/fvzxk6EO5CDb0igI06IgVc=
X-Gm-Gg: Acq92OHnJwe8LW29nq2tVZPiuN+G6XMVY6sE3L1UI8LEtniWd43OvhLVciuOK4rEBoV
	8l5sgsN7tG83CbJc+KDxNkhsw+aFj1sd8S29ZfIeJkjo4ag+fCAoFZPJOmmyLghYwH4FYb7zOX2
	f8zJGmvUpUzMqp2eN9+CxuoeIub1zPFHqsHqcyOebjbMwblGVKVDMblj+tWa8S+J0ocILBAw9BI
	Q1vMJx+Xc0ytlHYZrUS+s3uNabyOG1S2hEdWf9OFKR/e0MWlgh1v3OBpyOYpPeY7QZjztT0IJQC
	DcHHJqtpZJ4DWP1BIfMQvbn6+xTXWGHjGY2zRC/k0Txo0QNl3PLzZ9c3RbJOceqCegyuNJrd/U6
	riDCWtMzdUWkzzK9m5yeK/fqCyIdRMomyc0JCLtaM+Bxz4r20OTZTNYjrYd8OzMBkHO8zdP6v8n
	MRJr+W
X-Received: by 2002:a05:7301:2f85:b0:304:c520:4e14 with SMTP id 5a478bee46e88-30ba59d5cafmr689519eec.11.1781560410391;
        Mon, 15 Jun 2026 14:53:30 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::bff7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0828sm17835533eec.10.2026.06.15.14.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 14:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 17:53:28 -0400
Message-Id: <DJ9YGGSOPDXL.25P9XNKMTW64H@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <mattbobrowski@google.com>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Vineet Gupta" <vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: Allow type tag BTF records to succeed
 other modifier records
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615180614.4376-1-emil@etsalapatis.com>
 <0930f05c6aff27dd5680c10fed14bd369df42400.camel@gmail.com>
In-Reply-To: <0930f05c6aff27dd5680c10fed14bd369df42400.camel@gmail.com>

On Mon Jun 15, 2026 at 2:57 PM EDT, Eduard Zingerman wrote:
> On Mon, 2026-06-15 at 14:06 -0400, Emil Tsalapatis wrote:
>> As of recently, Clang is able to attach type tag records to modifier BTF
>> records. This is useful for using typedefs that encompass a base type
>> and a type tag, e.g.:
>>=20
>> typedef struct rbtree __arena rbtree_t;
>>=20
>> Modify btf_check_type_tags() so that it allows this sequence of records.
>> The function now only checks for record loops in BTF modifier record
>> chains. Rename to btf_check_modifier_chain_length to reflect this.
>>=20
>> Also expand the BTF modifier traversal code to take into account that
>> type record can be interleaved with other modifier records. In effect
>> this means traversing all modifiers to collect the type tags.
>>=20
>> Also modify existing selftests to now accept modifier records (const,
>> typedef) that point to type tag records.
>>=20
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>> Cc: Vineet Gupta <vineet.gupta@linux.dev>
>> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Looks correct, two nits below.
>
> [...]
>
>> @@ -5860,11 +5866,10 @@ struct btf_struct_meta *btf_find_struct_meta(con=
st struct btf *btf, u32 btf_id)
>>  	return bsearch(&btf_id, tab->types, tab->cnt, sizeof(tab->types[0]), b=
tf_id_cmp_func);
>>  }
>> =20
>> -static int btf_check_type_tags(struct btf_verifier_env *env,
>> +static int btf_check_modifier_chain_length(struct btf_verifier_env *env=
,
>>  			       struct btf *btf, int start_id)
>                              ^^^^
> Nit:                      formatting

Ack.

>
>>  {
>>  	int i, n, good_id =3D start_id - 1;
>> -	bool in_tags;
>> =20
>>  	n =3D btf_nr_types(btf);
>>  	for (i =3D start_id; i < n; i++) {
>
> [...]
>
>> @@ -7024,19 +7021,43 @@ bool btf_ctx_access(int off, int size, enum bpf_=
access_type type,
>>  	info->btf_id =3D t->type;
>>  	t =3D btf_type_by_id(btf, t->type);
>> =20
>> -	if (btf_type_is_type_tag(t) && !btf_type_kflag(t)) {
>> -		tag_value =3D __btf_name_by_offset(btf, t->name_off);
>> -		if (strcmp(tag_value, "user") =3D=3D 0)
>> +	while (btf_type_is_modifier(t)) {
>
> Nit: similar logic is repeated in the btf_struct_walk()
>      Can it be abstracted away? E.g. by adding some sort
>      of `collect_type_tag_flags` that would accumulate the
>      bits for MEM_USER, MEM_PERCPU, MEM_RCU?
>

I was thinking maybe of having the matching strcmp()s be a callback,
then having common code for iterating over the tags. I will refactor
for the next version.

>> +		const char *new_tag;
>> +
>> +		if (!btf_type_is_type_tag(t) || btf_type_kflag(t))
>> +			goto skip_modifier;
>> +
>> +		new_tag =3D __btf_name_by_offset(btf, t->name_off);
>> +		if (strcmp(new_tag, "user") =3D=3D 0) {
>>  			info->reg_type |=3D MEM_USER;
>> -		if (strcmp(tag_value, "percpu") =3D=3D 0)
>> +		} else if (strcmp(new_tag, "percpu") =3D=3D 0) {
>>  			info->reg_type |=3D MEM_PERCPU;
>> -	}
>> +		} else {
>> +			/*
>> +			 * If we fail to match on the tag value just ignore it.
>> +			 * Tracing programs have the same BTF as the function
>> +			 * being traced, possibly including type tags BPF is not
>> +			 * aware of. We cannot possibly account for them so ignore
>> +			 * them.
>> +			 */
>> +			goto skip_modifier;
>> +		}
>> =20
>> -	/* skip modifiers */
>> -	while (btf_type_is_modifier(t)) {
>> +		/* Only a single tag value supported. */
>> +		if (tag_value) {
>> +			bpf_log(log,
>> +				"func '%s' arg%d type %s has multiple type tags\n",
>> +				tname, arg, btf_type_str(t));
>> +			return false;
>> +		}
>> +
>> +		tag_value =3D new_tag;
>> +
>> +skip_modifier:
>>  		info->btf_id =3D t->type;
>>  		t =3D btf_type_by_id(btf, t->type);
>>  	}
>> +
>>  	if (!btf_type_is_struct(t)) {
>>  		bpf_log(log,
>>  			"func '%s' arg%d type %s is not a struct\n",
>
> [...]

