Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A525A359
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 03:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778558257; cv=none; b=YiHvIC91AjKpSTzseHgBt4h2qyDx0hXfC/3I/B3xl2GQOMhStsHvOHQM2T4QHdtRm3q28+z15sh6VWtlzy/Btz5k2IJXSTaRdMDdfIJgBoLNDUPMYRxYxbdDn9pdks5AkYAAj7ll08jg9IOCDfJedbq/K3VZoHMTN/mbN8KdtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778558257; c=relaxed/simple;
	bh=ryUhE62dj8O7kq7HedNTionw8EZhk8ovnUug1hgL2yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0iTa0OPC+7TGJdgZ8dbhJBYeW7zr6jXy6qXZ2gPegNlY/wvui3F8wvb+E+R7Tl66wB0S8aBjLtOrfR1agddVvbYbJMfSdgZTq+tF5yL8YYg9QQTHoK9NvweFHuCTR2Q7oTeutsC7c43ZDJUeYYscv6BMp/3JDRaGFKUTkhAqyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w3442UHY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w3442UHY"
Message-ID: <0ab234d3-ed23-40c3-82aa-d93fa5900386@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778558252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrJS8tKQM0az0LGWTgbF5v0nFYUb89ACheIaZvOjUBk=;
	b=w3442UHYOi9RxJksp6Dzt8KDY29Tlci04oFusMcK3LrhRb/NG/3I82hun5mK6LTg+Bn2C0
	5C1vhd6J4nBKRyyD4MSbOp+0K2SmBq9wcciYfs4HpPZbQVzEIcxRTX515BvjUtkr9QMcXM
	x2NPSBnGyd+t2KJKw7y647JX7hVKmHU=
Date: Tue, 12 May 2026 11:56:39 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 2/2] kernel/bpf/verifier: Support module kfunc
 resolution via instruction offset
To: Song Chen <chensong_2000@126.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, alexei.starovoitov@gmail.com
References: <20260510030147.27900-1-chensong_2000@126.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <20260510030147.27900-1-chensong_2000@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/5/10 11:01, Song Chen 写道:
> Use the instruction's 'off' field to indicate the source of a kfunc.
> When libbpf resolves a kfunc, it sets insn->off to 0 for vmlinux
> kfuncs or a non-zero module ID for module kfuncs.
> 
> The verifier now checks insn->off to determine where to look up the
> kfunc address: off == 0 searches in vmlinux, while off > 0 searches
> in the corresponding module BTF. This enables proper resolution of
> module kfuncs that may override vmlinux kfuncs with the same name.
> 
> This works in conjunction with the libbpf change that prioritizes
> module kfuncs during BTF resolution.
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Song Chen <chensong_2000@126.com>
> 
> ---
> changelog:
> v1 --- v2:
> libbpf has already specified which module this kfunc belongs to as
> ebpf code onwer's expectation, then verifier uses
> find_kallsyms_symbol_value to search kfunc's addr.
> ---
>  kernel/bpf/verifier.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>  mode change 100644 => 100755 kernel/bpf/verifier.c

In general, the second and following parts of a multi-part patch should be
sent as a reply to the first part so that they all thread together at the
receiving end.  Tools like git and quilt have commands to mail out a set of
patches with the proper threading. 

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> old mode 100644
> new mode 100755
> index 159b25f8269d..3b2e4552a3d4
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3303,6 +3303,7 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>  		 */
>  		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>  		     kfunc_btf_cmp_by_off, NULL);
> +

Unnecessary change.

>  	} else {
>  		btf = b->btf;
>  	}
> @@ -3498,7 +3499,16 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>  	if (err)
>  		return err;
>  
> -	addr = kallsyms_lookup_name(kfunc.name);
> +	if (offset) {
> +		struct bpf_kfunc_btf kf_btf = { .offset = offset };
> +		struct module *mod;
> +		struct bpf_kfunc_btf *b;
> +		b = bsearch(&kf_btf, btf_tab->descs, btf_tab->nr_descs,
> +            sizeof(btf_tab->descs[0]), kfunc_btf_cmp_by_off);

Tip: before submission, you can run scripts/checkpatch.pl to check for formatting issues.

> +		mod = b->module;
> +		addr = find_kallsyms_symbol_value(mod, kfunc.name);

struct bpf_kfunc_btf b, kf_btf = { .offset = offset };
    ......
addr = find_kallsyms_symbol_value(b->module, kfunc.name);

> +	} else
> +		addr = kallsyms_lookup_name(kfunc.name);
>  	if (!addr) {
>  		verbose(env, "cannot find address for kernel function %s\n", kfunc.name);
>  		return -EINVAL;

-- 
Thanks
Kaitao Cheng

