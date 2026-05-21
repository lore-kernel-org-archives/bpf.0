Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8FD1C84A0
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346845; cv=none; b=GgVS1xI6WqZS5Z7ARUuyCC9N+5XZcGCLZu/XJgsAk7YsnkePPNXpb34f1Da3U3rdA+zESPymXOUvq5ivM0mbCLoJAKTVUsMyFK3zn1WVJr7AUIE/j/l+wmHYffxSJ+MbS8qlxplEz6q/otVNc+RUIu7VyjCpm1otzxgIx1aMWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346845; c=relaxed/simple;
	bh=BS0fGzXbKfEg3NPGeP858gXyAzpXGJF5jn+eF6WbGdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thAcpDwUNoifzpTotVaVuAlbQc2HlwEORwdpp20lG2RdSd5MFbSARJGkCcNej45O8VtdnQ5SHsKaTRoXXshDquemm5opfzqYfkZDj44yE4dwWyvGe0j7eYBTS7tr1J+JQalnJ1pMvCzKRivxUrYa+i0ULJ9r7cGInsGNDCUB2w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uksaI4hM; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uksaI4hM"
Message-ID: <9e300669-8793-41a2-84a1-98fb8195e263@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779346837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4jVmpmnD2ykAokas/X3lk9Wju6nk7/v9FrN61iDdtk=;
	b=uksaI4hMnPFVdDq4c5Bb3ZjpEiYNcHN/F+CjLaJToiS+RJV2UtylKqYjKBZPMcwGZmZGI5
	4ZqE0DUVMaXXSb5rBgEp3kWuETBIVsskg4oWfnCrMmxQunwFe/5RowftvQpZwq9cOYh7Wu
	0sBsmINv8JZnSO8aLY4iYcPlD6TaqDA=
Date: Thu, 21 May 2026 14:59:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 4/8] bpf: Introduce the bpf_list_del kfunc.
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
 martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, skhan@linuxfoundation.org, memxor@gmail.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260521032306.97118-5-kaitao.cheng@linux.dev>
 <d1fb9e986434b92188b3b37514336794c49a807c0378badceda45c3c14bb9739@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <d1fb9e986434b92188b3b37514336794c49a807c0378badceda45c3c14bb9739@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/5/21 12:08, bot+bpf-ci@kernel.org 写道:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 59855b434f0b..804c201c28f3 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f3cf8d85bea0..35eebb5e7769 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
>> @@ -11671,7 +11674,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>>
>>  	switch (node_field_type) {
>>  	case BPF_LIST_NODE:
>> -		ret = is_bpf_list_push_kfunc(kfunc_btf_id);
>> +		ret = is_bpf_list_push_kfunc(kfunc_btf_id) ||
>> +		      kfunc_btf_id == special_kfunc_list[KF_bpf_list_del];
> 
> This isn't a bug, but Eduard Zingerman suggested in v10 adding a
> is_bpf_list_del_kfunc() helper for consistency with the existing code style
> (similar to is_bpf_list_push_kfunc()). This would maintain the pattern used
> throughout the codebase for checking kfunc types.
> 
> Reference: https://lore.kernel.org/bpf/ca14a6fd8a1f3ce1e64c70b6d9ea2baf8df913ae.camel@gmail.com/

The reason for using is_bpf_list_push_kfunc() is that it groups multiple parallel
"kfunc_btf_id == special_kfunc_list[*]" checks into one helper, making the code
easier to reuse. If we added is_bpf_list_del_kfunc() here, it would only wrap a
single KF_bpf_list_del check, which is unnecessary. Also, more helpers such as
is_bpf_list_first/last may be added later, and overusing is_bpf_list_* helpers
would make the code more redundant.

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26204125015

-- 
Thanks
Kaitao Cheng

