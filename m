Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630331DDC35
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453146; cv=none; b=Gllb1SGgnh8fp6ZxWT4gb7auy+apygwjLk9abHRybozZD7tv803sZoeR2sUx/ZiTafefa4wgrhlBizKBVEiR0E2ubP3xsETpmWEzzNejfJUV0yuN/3QF0pth4O8X3Z11jDZcAWiDgyqzD5G4YSXiQ56vTQIjImXg65hKrROpZpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453146; c=relaxed/simple;
	bh=sgecYvQhKq4U2RscfJ4NnwE2GDJNL7ZAhTu6sMY1QiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azN77qVGuktIw6M+VzISGjwes8ia/tCmaezltmhf1Upu3bPy4jsecixccrmW5q3LkC0TB/qVKngZoE8Ry9OSrVjoi7H//Rmq+KFO1MhjJGV8pGE18lCAD4gCX4TdIsjWv1AsojhNaVyn22htZMTPe/s4h3jFwhxnOb83LJiZtj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hriEjwoo; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hriEjwoo"
Message-ID: <6f7bfa86-7f9c-4ac3-baff-88b541e6a48a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780453133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vb5TnOmWnuGapTnrJDYzMK+Rxy0MkJ+vJQCeVT/JNfw=;
	b=hriEjwooCIthUa4o539X0ZeQj5z1v5vzC3gjiamWGsmIwhX3UsjNlQTvR5ztoKtNJxPzdX
	xK34SVfJJTB8iWp22NS6ozZi16Db2i2TZz9jMWwAlsgD/52D4eljFjNe1nkPSOq9sFlxI9
	KLV+YPr8JlRtBS8KBgjEBD305hFdYJ8=
Date: Wed, 3 Jun 2026 10:18:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] btf: reject to register duplicated kfunc
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, Song Chen
 <chensong_2000@126.com>, martin.lau@linux.dev, ast@kernel.org,
 alexei.starovoitov@gmail.com, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 kaitao.cheng@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260602110710.19642-1-chensong_2000@126.com>
 <d4054d34-430c-4360-8392-a21f8ebacff4@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <d4054d34-430c-4360-8392-a21f8ebacff4@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/6/26 01:13, Yonghong Song wrote:
> 
> 
> On 6/2/26 4:07 AM, Song Chen wrote:
[...]
>> +
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>> +    mutex_lock(&btf_module_mutex);
>> +    list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>> +        if (btf_mod->btf == btf)
>> +            continue;
>> +        id = btf_find_by_name_kind(btf_mod->btf, func_name, kind);
>> +        if (id >= 0) {
>> +            pr_err("kfunc %s (id: %d) is already present in module
>> %s.\n",
>> +                    func_name, id, btf_mod->module->name);
>> +            mutex_unlock(&btf_module_mutex);
>> +            return -EINVAL;
> 
> Let us avoid the above mutex_unlock and 'return -EINVAL', just do
>     err = -EINVAL;
>     break;
> 

Better to use guard(mutex)(&btf_module_mutex)?

Thanks,
Leon

>> [...]
