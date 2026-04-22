Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784BEEC0
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867544; cv=none; b=hAvWuFsLGGfO0LsCE4XWoMU3k9vtVA2Nua6ljywrpFB1U282DE5sTwJcG40Tr00ZOkh08EVTpFFpW3TEzMZXLJvzsfSmAx86nzXzt3henOCvwU2JJRUZejoAkS9IV64+x1sdYr5+GUUc2fUTCuNIN1jAZV8lXM/QmtCTvtaDPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867544; c=relaxed/simple;
	bh=L/Xjtuzf3mdbzH0p75wubv0mq55/Avm8HswlfOchKJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWcNY6kjw6LoY9nOo+Lu6cKxv6L98QGd28UsLJxNbsW+zhhr79r9Tjq3qc9qfhFCY+e3HNRYnztesTuqCVohuiERMfoqZjLSE0uBOIN6m034SGiw5EJqME3q1umdB9bTe06i6XIFjbFlH+TRvOReSXB7HptuTA1+2SoWlf5w/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnFSyO26; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnFSyO26"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso43610465e9.0
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776867542; x=1777472342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=665rCXZQSOBBkjx3qyXfo//6Hp6CnUJ/01ikDwC7DMQ=;
        b=YnFSyO26jNXHrbSBlKwwP6SZr79OZ0yBuRuOP48sTah+wVksw9kSJzwkaB40ka4Urm
         F/Xa7Yp2R2gvhzmHbTi7LV/9Oelj/nsyJho2oauT0KeJJbnAhgnndrJdmXlhJgCzoz37
         mGAdrMCc2Td5WgmCM+zAiG9Kvzsxm+X16RrS4Uj4W+0OjGnv7n1xpYWbs+WzeUx/7v7u
         PVd+vSUeBcQlMC/KKOrExtZDRSkTEIXStdlC+dk4rlGsWJxOwPczOfpoyU9EPacmtkQK
         t8IdqEni2x0FgZP2VuSr0a3m/XxPURRjMCtGOwM61ScpkRowt6pxIRF2Nd6a4HiZFwYz
         luxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776867542; x=1777472342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=665rCXZQSOBBkjx3qyXfo//6Hp6CnUJ/01ikDwC7DMQ=;
        b=Kq+vgdEWXIVrsyvitkuLDjxpMObQDsIW72re0GSpQvLOTGeKXm80hA0EpcYY9jsCfp
         x7zSpq1vNCufTr2kxCTGfPfW4Xgird82dTRsU9bvoLyVpzdBNtEqnMCeXacxg97kGSL3
         G9vfqu+VHP7RmuGUKUTH54LNtfNAYwDEk9yqwkEVra8hP8DZpm3fkq+E0seDmaBvTdAg
         vxemz5L4S+3J3QgTFEsEpOZP9vN8eqyWw9RsfMBYf7Y/Z+7jBnmP6AoGDMZ80rsFXvrG
         q8n0+wcWEASM2zPW4DAIel3Jy4M33b2WQNAeXnbaiLj9ntfHbKq45IG9T7paiJhQPQxX
         94FQ==
X-Forwarded-Encrypted: i=1; AFNElJ/h/wWM3OoYTP1F/euH33lhQ3KE87Bw0DNgI7EvR6cDwoBmY6Wxg/9bUCLeWcswZsO9Um4=@vger.kernel.org
X-Gm-Message-State: AOJu0YybzS68RI9d5aS+5sDDz2cjx20/pCnmBQGPiY4vrJlpGSTVrZqx
	4ZADtXeIUS9tT1ed5RqTvpOk2sqnEpcybPdw0hbG1Az/WGNgfwfXs1B2
X-Gm-Gg: AeBDiets2wH/Ohw99j7L4i+aipu9p5Lfww5gBQn6maUCjokvkV3oWJ95QM/2ASfP8xL
	5WE4/mxYGQEOPp9ZoYNedbpQqYoFiJY2LJgdTclCYGmXPKEATUtqYbSpoStSi7fzomUuP5KNfhE
	OlDYMcKcWMMK/iyRmb+jSndYRthdzQtpZayd/ZVT5cxwVxNMVHgACt8R9g+T7sFDJdGcj46nLZc
	wtkmn4JVdQTClFq9KueLAwcY9cg1hbrausWpb0SdeiAySJw9bpErDRyKFG0hDKerVHLecJHQ6ug
	xRcSgpbUD0r5qSgzbeH4hlyTpge9JnT7vKccPPogTgENDiDZIV2H/rljKdMj6xPoCYrJyvHbUw4
	4G78PHDQyuaHdBsAL+keKVPjzkQzxlQm9zkj8nU8lSwwFKPzxgJCZsFiG188dGZU2VVAmYls2kk
	02kKOaenTui0przb66A9VvbsxXZ8lIepBzuaMMGj9qTPH7F4MdXP+ItJwaxevZ3UL3OnJd0L4Xt
	iJacVPB6Q==
X-Received: by 2002:a05:600c:5294:b0:48a:563c:c8d6 with SMTP id 5b1f17b1804b1-48a563cd0eemr96796095e9.7.1776867541504;
        Wed, 22 Apr 2026 07:19:01 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:4807:7c72:b2bd:e787? ([2620:10d:c092:500::5:1502])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc177dafsm554336465e9.4.2026.04.22.07.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 07:19:00 -0700 (PDT)
Message-ID: <c2e8527a-0cae-47a5-8c43-2ae2c08bc1ab@gmail.com>
Date: Wed, 22 Apr 2026 15:19:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: Fix type size overflow in
 btf_type_size_unknown
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 bpf@vger.kernel.org, sashiko <sashiko-bot@kernel.org>
References: <20260422103206.533695-1-alan.maguire@oracle.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260422103206.533695-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/26 11:32 AM, Alan Maguire wrote:
> A layout section with a large elem_sz/vlen can lead to a 32-bit
> overflow in btf_parse_type_sec() at the point where a large
> type_size is added to the next_type [1]; a sufficiently large type_size
> on a 32-bit system could lead to the bounds check
> 
> 	if (next_type + type_size > end_type)
> 
> not triggering (since next_type + type_size wraps to a value low
> in the 32-bit address space).  This would lead to a bad value for
> next_type when we add the type size.  Avoid this by ensuring that
> the type_size we return from btf_type_size_unknown() falls within
> the range of <current type, end_type>.
> 
> [1] https://lore.kernel.org/bpf/20260417170712.74E77C19425@smtp.kernel.org/
> 
> Reported-by: sashiko <sashiko-bot@kernel.org>
> Fixes: 2ecbe53e0e991 ("libbpf: Use layout to compute an unknown kind size")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Beginner question: how does targeting bpf tree helps libbpf patch, it's 
not available unless we sync to github and release a new libbpf version, 
isn't it?
I would rebase this on bpf-next: it does not apply cleanly on bpf-next 
and dealing with conflicts for this change does not sound amazing.

>   tools/lib/bpf/btf.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index ceb57b46a878..d48ac5460d1d 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -420,9 +420,11 @@ static int btf_parse_layout_sec(struct btf *btf)
>   static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
>   {
>   	__u32 l_cnt = btf->hdr.layout_len / sizeof(struct btf_layout);
> +	const void *end_type = btf->types_data + btf->hdr.type_len;
>   	struct btf_layout *l = btf->layout;
>   	__u16 vlen = btf_vlen(t);
>   	__u32 kind = btf_kind(t);
> +	int type_size;
>   
>   	/* Fall back to base BTF if needed as they share layout information */
>   	if (!l) {
> @@ -448,7 +450,13 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
>   		return -EINVAL;
>   	}
>   
> -	return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
> +	type_size = sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
> +	if ((size_t)type_size > (size_t)(end_type - (const void *)t)) {
> +		pr_debug("Overflow in type size %d for kind %u\n",
> +			 type_size, kind);
> +		return -EINVAL;
> +	}
> +	return type_size;
>   }
>   
>   static int btf_type_size(const struct btf *btf, const struct btf_type *t)

