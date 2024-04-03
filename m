Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EDF56B70;
	Wed,  3 Apr 2024 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154999; cv=none; b=Mfg23J4sr9NoBplY2q+uZU+WLUJhKnq4zKP+x9BRgVviUMPIf5X/q2677Yt/Dip3v+NJMZnvVhyroBRMw7SveMiMR1JLK8UawDYp04uLVpuQbdDMxDgSy29nXucOsjXJEXEQJlW0+dv7Y+OTdjfa8YpL4R1RHlEweSinYRy1mUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154999; c=relaxed/simple;
	bh=wtryFZmz9L5MMjPv8jxFilEAGkNNYXS5MUcwlNkp3cU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Mk2jhRgmDenmVc9RX2gpBBO9BF2dJhQO7tEkRase2KSZ5oPZSsiiZdKkdATcxFVciGCHHkbonGuC35eWds7VjGdOh7ailK3U7f1KKZYKITxNlUOu/XkQaEzB3EsSsa4bmlPIDlXl7KP7Grm4+ixh80XiDXs4Rl/ugnvvKAz+jnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fWLVUWT0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fWLVUWT0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=bZLC0mhIiZ7QjY8sUD7A0lgCAo690O82GwJBkqGJPYA=; b=fWLVUWT0X4AenO87bxk/kokg23
	p++vPk/1Kk4j2Tn0rxQqbCdM1JVI5ByjHKI9/i7sn07XO4oduPKWSuV7CI+TG6AgUUW++I6bh1b4E
	sLsnP35j0aFXI2t8+CgkkOlHc3bIdlKvBd7Rdt0UcYdeGOiFLXeVyPy/aqKeGmlcriX8UTmZ1mHvI
	DF3hULQWMjPkjW/1cIJu9B50JO3AEZcHBbQrP3HHh3gKZmdxwuS5QEjaJRqsSbx/kV/hXzKuRAA4d
	UpLzVMjd4XoH2ABsK/RfQUxEzmzjj9YPs6ddMx/10oKSRX3Z0C6xQSbDbdOHlD4oWv8lI5eNMrk6y
	CTFPFlug==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rs1j0-000OLZ-Bz; Wed, 03 Apr 2024 16:36:26 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rs1iz-001hAe-2V;
	Wed, 03 Apr 2024 16:36:25 +0200
Subject: Re: [PATCH bpf-next] rethook: Remove warning messages printed for
 finding return address of a frame.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: mhiramat@kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 andrii@kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com
References: <20240401191621.758056-1-thinker.li@gmail.com>
 <CAEf4BzbbneDHp=sD4+5RmuK=U9vg8Uo_M6XEXdKWrZ_MkjFocw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1bbd6200-bb06-f8d2-c22a-39245425b6b1@iogearbox.net>
Date: Wed, 3 Apr 2024 16:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbbneDHp=sD4+5RmuK=U9vg8Uo_M6XEXdKWrZ_MkjFocw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27234/Wed Apr  3 10:25:27 2024)

On 4/2/24 6:58 PM, Andrii Nakryiko wrote:
> On Mon, Apr 1, 2024 at 12:16 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> rethook_find_ret_addr() prints a warning message and returns 0 when the
>> target task is running and not the "current" task to prevent returning an
>> incorrect return address. However, this check is incomplete as the target
>> task can still transition to the running state when finding the return
>> address, although it is safe with RCU.
>>
>> The issue we encounter is that the kernel frequently prints warning
>> messages when BPF profiling programs call to bpf_get_task_stack() on
>> running tasks.
>>
>> The callers should be aware and willing to take the risk of receiving an
>> incorrect return address from a task that is currently running other than
>> the "current" one. A warning is not needed here as the callers are intent
>> on it.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   kernel/trace/rethook.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
>> index fa03094e9e69..4297a132a7ae 100644
>> --- a/kernel/trace/rethook.c
>> +++ b/kernel/trace/rethook.c
>> @@ -248,7 +248,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>>          if (WARN_ON_ONCE(!cur))
>>                  return 0;
>>
>> -       if (WARN_ON_ONCE(tsk != current && task_is_running(tsk)))
>> +       if (tsk != current && task_is_running(tsk))
>>                  return 0;
>>
> 
> This should probably go through Masami's tree, but the change makes
> sense to me, given this is an expected condition.
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Masami, I assume you'll pick this up?

Thanks,
Daniel
