Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45023EAB0
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773294623; cv=none; b=fcwQxbCvs50+VfxVCh0UcxyGwI5zPJ0uJE+nN5PAex1Y289v8tTnsNaXjuhlkZCz469qqZnjXSZumigPWqZglVra7rxyJf5qolltcaKOE+1TctjUz8MsZ0KqS2prUJx5Qw0tz2UsUjoembafmrK5Mg8QfaLiroE1Iex4OEyvBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773294623; c=relaxed/simple;
	bh=eMb3ctEh5sA8KPpbEREQ7h4yCbQa6Mtie7l4Y1BbonY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfQTtQfOhMdQZ2P+LCJu5V1K7iFCfhkEzW178Y3PpKifc4W4NWHqObm2H7KwlPlr/3FsnwqigTMYLoSZvM0z2+5pSNZ5WMGySOzrAiPUS8guHWvL7RlYvQIdfBYQTBpbmpzDLa9av740BG5GP18LenSnXwF7LgSsXvgRneYZNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BRs/F9i4; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BRs/F9i4"
Message-ID: <46583200-ee0e-41dd-a0a9-8944ad710a9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773294618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDHIYbwxTD8pm6HibIHbI6Umqj9334i6QIp2bBQLiFk=;
	b=BRs/F9i4oIxGALCNq8PcoBOWRfF44rPZwrNyGBSS1M1h5M1eJPzNtqVWiJCpiRIhIHkBVe
	qawOsAkLRxj6smmEPMIJjbV8rqoa5tkjye/eDnHIuuUYyE5vkLluWScuj46YA0Xrp0oNt0
	j13GSCQXvj1o4plbVPSmBkeBrNAlQe0=
Date: Thu, 12 Mar 2026 13:50:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Verifier support for sleepable raw
 tracepoint programs
Content-Language: en-US
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bot+bpf-ci@kernel.org,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, yatsenko@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
 <26aec9bced7c1d13ca1d7bbe344485c2bdd7b85bcf4489cef17293f6e278528f@mail.kernel.org>
 <CAP01T77gknuNiiVKny-cThb6b-dFxGPmPKx1eMryLoN2AkHo8w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAP01T77gknuNiiVKny-cThb6b-dFxGPmPKx1eMryLoN2AkHo8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/3/26 07:07, Kumar Kartikeya Dwivedi wrote:
> On Wed, 11 Mar 2026 at 19:53, <bot+bpf-ci@kernel.org> wrote:
>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>
>> [ ... ]
>>
>>> @@ -25435,6 +25441,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
>>>               case BPF_MODIFY_RETURN:
>>>               case BPF_TRACE_ITER:
>>>               case BPF_TRACE_FSESSION:
>>> +             case BPF_TRACE_RAW_TP:
>>>                       return true;
>>>               default:
>>>                       return false;
>>> @@ -25464,7 +25471,7 @@ struct bpf_attach_target_info tgt_info = {};
>>>       }
>>>
>>>       if (prog->sleepable && !can_be_sleepable(prog)) {
>>> -             verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
>>> +             verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, struct_ops, and raw_tp programs can be sleepable\n");
>>
>> The updated error message adds raw_tp but still omits fsession,
>> which is listed in can_be_sleepable() just above. Should this
>> read "fentry/fexit/fmod_ret/fsession, lsm, iter, uprobe,
>> struct_ops, and raw_tp"?
>>
> 
> We can ignore AI for now, Leon has a change for this.
> 
Just to confirm the change: is it
https://lore.kernel.org/bpf/20260303150639.85007-2-leon.hwang@linux.dev/?

If yes, it is to add "fsession" to the verbose log message in
check_get_func_ip(). Then, the AI review is correct: "fsession" was
missing here.

After searching for "fexit" in verifier.c, "FENTRY/FEXIT" can be updated
to "FENTRY/FEXIT/FSESSION" in bpf_check_attach_target(), and "fsession"
is missing in some comments. I'm not sure whether it is worth a patch to
do such cleanup work.

cc Menglong

Thanks,
Leon

