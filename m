Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DE4385D89
	for <bpf@vger.kernel.org>; Fri, 22 May 2026 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482673; cv=none; b=tDxaGoM0ZF9Fakmev5KygD93C7S9DHv4MQAvs56GsdSqjA6ja8AE5x4lD6UfQ261J873pkALU0oH6A+hiXcno38Ry3D7DB7xKpiCPY7jkYEZlTGMPHmfODflLOjzUEuHWWX5Sx0rAKPoY2evUFWdBvKnxyHxe7FjP1NiwSw7/U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482673; c=relaxed/simple;
	bh=cCkL3mQZHLsr1rxVJo+iJqORtbkeDXoNlJ2So8OUb4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJCpTxwctzZGUyXdC8dwp+OGV5bVg6n2UD/3mgm4mMmceRE3rxry3qHG05u15ADKukF6AQBTfx7/ktv/OgdeasdXlNpV+HvirzxoT88cJHkRhr2AaOeWVVxVtP/GwArG++nsEqNs8oJRITmRoBppzJgylzW6213mJXoLXl22lfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B+4id8pc; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B+4id8pc"
Message-ID: <449e5cbd-5262-4bce-90a6-111ab1245917@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779482656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6AHYR1E/EEEjXkS4O5wspKfvfYkDFgFscHkH1KEC88s=;
	b=B+4id8pciKp6mvv8BWLObjy3HsBt22fnLK8lWy2DujhQbyQhSCZT9POkICgtlrr/KajEja
	WSZ51FhAM76Vh/Oz6FGGcRz3chrgKL3mJndCi6+v7oHM7psFgdvgXJqHDyAC3z//77NlAY
	DHx6iN8kv/u38+IVCWLgOLzX1uxVhGU=
Date: Fri, 22 May 2026 13:44:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Add nelems overflow check in btf_find_field_one()
 btf_find_field_one() multiplies a u32 nelems accumulator by each nested array
 level's element count without checking for overflow. The sibling function
 __btf_resolve_size() already guards against the same overflow pattern (btf.c
 line 2110). Currently the BTF array verifier (btf_array_resolve) rejects BTF
 blobs whose total array size would overflow u32, so this code path is not
 reachable with crafted BTF input on kernels that include that check. Add
 check_mul_overflow() anyway to keep btf_find_field_one() self-consistent with
 __btf_resolve_size() and to guard against future changes in the validation
 ordering. Fixes: 994796c0256c ("bpf: create repeated fields for arrays.")
Content-Language: en-GB
To: Himanshu Anand <anand.himanshu17@gmail.com>, martin.lau@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260522124117.13846-1-anand.himanshu17@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260522124117.13846-1-anand.himanshu17@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/22/26 5:41 AM, Himanshu Anand wrote:
> Signed-off-by: Himanshu Anand <anand.himanshu17@gmail.com>

Looks like patch subject and commit message are messed up. Please
fix it in the next revision.

Please use [PATCH bpf v2] as the tag.

> ---
>   kernel/bpf/btf.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..b767a9fcf095 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3765,7 +3765,8 @@ static int btf_find_field_one(const struct btf *btf,
>   	 */
>   	for (i = 0; i < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); i++) {
>   		array = btf_array(var_type);
> -		nelems *= array->nelems;
> +		if (check_mul_overflow(nelems, array->nelems, &nelems))
> +			return -E2BIG;

Looks correct to me.

>   		var_type = btf_type_by_id(btf, array->type);
>   	}
>   	if (i == MAX_RESOLVE_DEPTH)

