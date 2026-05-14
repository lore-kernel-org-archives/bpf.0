Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EAC2C3757;
	Thu, 14 May 2026 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761917; cv=none; b=qASshv4zrBeHq6T0uu2KC9srplvZ4VccT+XVJcGElk78F0cFTJBpStdgJNlZRGkFLpNWgaTb1y78ahKGKe11xkHYbOBIkIubEQ9wfKpiekcd+dZ/cOwfcrd8CAu1/83HMAV07oxIPKHTPNJ+GCU4CuVG+oD8vxGXwzjBUL0i5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761917; c=relaxed/simple;
	bh=kIPj8dnpUnGnW77T7q3AfWbYX6oyox+wWBq6VKTGhqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKCvoweduWnYxMFUf0g+Qq+qVt7troTjrsxPSCaAyMbF7p2ZrGeuJQ+LCNznJddsHzjRRizOVkaUcTviKJQ7+mlwYnVzGWEF6nowG70G/Hg1H5TqAMJOONKo6qSxEjwRT1Yf5gZjOPsiNgXIBp2JqFMpFb56btrXg+lHkmDX6D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=PiC2Gxo+; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="PiC2Gxo+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=di93et8aWDdEaIMhz3uXtuUhFcdccqIgJmR9d3H8E2Y=;
	b=PiC2Gxo+rZg4sTQPI+51O1c/vYh5XVM+LEpktq9RIqDwj1TsC8BO5m0J9fKlKc
	JeqUXPyFTtYX06OAD0/1s/dBKvNQqbwZV/3bVu/Ch8SiW13H+LRnnIvN1hnGKXns
	1rfHjWQ16zvLkdpvrQOifqfI6K4bhJhMua+kI8TwDkHz8=
Received: from [IPV6:2408:8210:480a:2590:67b8:4623:bebc:2a2] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgD3f2NkwAVqdUsGBA--.46346S2;
	Thu, 14 May 2026 20:30:29 +0800 (CST)
Message-ID: <2c83ae10-a56b-466e-abe5-b90566d4a7c5@126.com>
Date: Thu, 14 May 2026 20:30:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] kernel/bpf/verifier: Support module kfunc
 resolution via instruction offset
To: Kaitao Cheng <kaitao.cheng@linux.dev>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, alexei.starovoitov@gmail.com
References: <20260510030147.27900-1-chensong_2000@126.com>
 <0ab234d3-ed23-40c3-82aa-d93fa5900386@linux.dev>
Content-Language: en-US
From: Song Chen <chensong_2000@126.com>
In-Reply-To: <0ab234d3-ed23-40c3-82aa-d93fa5900386@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PykvCgD3f2NkwAVqdUsGBA--.46346S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFWrCry8AFW3Jw13Aw1fJFb_yoW5ZrWrpF
	W8JFs0kF4vyw13Cw42va1jvFy2ya1ktw47KF90ya4akr90qr1vyF4Ikr45uasYyr1jk3WI
	vFWIqF9Fva4jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZo7NUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBpQUlpGoFwGXJqAAA3K

Hi,

On 5/12/26 11:56, Kaitao Cheng wrote:
> 在 2026/5/10 11:01, Song Chen 写道:
>> Use the instruction's 'off' field to indicate the source of a kfunc.
>> When libbpf resolves a kfunc, it sets insn->off to 0 for vmlinux
>> kfuncs or a non-zero module ID for module kfuncs.
>>
>> The verifier now checks insn->off to determine where to look up the
>> kfunc address: off == 0 searches in vmlinux, while off > 0 searches
>> in the corresponding module BTF. This enables proper resolution of
>> module kfuncs that may override vmlinux kfuncs with the same name.
>>
>> This works in conjunction with the libbpf change that prioritizes
>> module kfuncs during BTF resolution.
>>
>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Signed-off-by: Song Chen <chensong_2000@126.com>
>>
>> ---
>> changelog:
>> v1 --- v2:
>> libbpf has already specified which module this kfunc belongs to as
>> ebpf code onwer's expectation, then verifier uses
>> find_kallsyms_symbol_value to search kfunc's addr.
>> ---
>>   kernel/bpf/verifier.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>   mode change 100644 => 100755 kernel/bpf/verifier.c
> 
> In general, the second and following parts of a multi-part patch should be
> sent as a reply to the first part so that they all thread together at the
> receiving end.  Tools like git and quilt have commands to mail out a set of
> patches with the proper threading.
> 

you mean "git send-email 0001-*.patch 0002-*.patch 0003-*.patch", i 
didn't know that before, thanks so much.

>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> old mode 100644
>> new mode 100755
>> index 159b25f8269d..3b2e4552a3d4
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3303,6 +3303,7 @@ static struct btf *__find_kfunc_desc_btf(struct bpf_verifier_env *env,
>>   		 */
>>   		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
>>   		     kfunc_btf_cmp_by_off, NULL);
>> +
> 
> Unnecessary change.
> 
>>   	} else {
>>   		btf = b->btf;
>>   	}
>> @@ -3498,7 +3499,16 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
>>   	if (err)
>>   		return err;
>>   
>> -	addr = kallsyms_lookup_name(kfunc.name);
>> +	if (offset) {
>> +		struct bpf_kfunc_btf kf_btf = { .offset = offset };
>> +		struct module *mod;
>> +		struct bpf_kfunc_btf *b;
>> +		b = bsearch(&kf_btf, btf_tab->descs, btf_tab->nr_descs,
>> +            sizeof(btf_tab->descs[0]), kfunc_btf_cmp_by_off);
> 
> Tip: before submission, you can run scripts/checkpatch.pl to check for formatting issues.

Many thanks, i did checkpatch every time, but i probably forgot it this 
time, sorry about that. As the reviews' comments, looks like this patch 
has its shot, more attention will be paid on v3.

> 
>> +		mod = b->module;
>> +		addr = find_kallsyms_symbol_value(mod, kfunc.name);
> 
> struct bpf_kfunc_btf b, kf_btf = { .offset = offset };
>      ......
> addr = find_kallsyms_symbol_value(b->module, kfunc.name);
> 

will do.

>> +	} else
>> +		addr = kallsyms_lookup_name(kfunc.name);
>>   	if (!addr) {
>>   		verbose(env, "cannot find address for kernel function %s\n", kfunc.name);
>>   		return -EINVAL;
> 


best regards,

Song

