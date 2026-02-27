Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66D81E5724
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229679; cv=none; b=JxfghIobHNfsTvejsxpAQsD6ut6ols9v7gARn0eYpwMoyf3Y5NfTR/Xf87ajSIJB4VLM2dqL6HjU8Hr/iLs6pi8joEBRjSsQbYtETr+J5p4SylW8yRzVoioGBC5NNjJafdHTsbipGBswdP8XY5EoiZtdgkiTqEYEjI36tTXuxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229679; c=relaxed/simple;
	bh=e79SBH+Z0ZmZ8dVPue78jP+m6mUiUq/O7xxAkiXEz1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFIjI2z0vzKY21QuaWvNUvwsOgqOeQtGDG+iIA6wm/DJCYBN5cNM3AjGviqtWkG40PWcguc87bbYNkgL2Rh0xY4K7Bq/EwuCdg2ycsv+gWS0CghE8vsPPex7fJT/5X5xbLh6xaf+4HbDMJHCVBYHN972xXipkS6wphNThoBAUsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c+V4B1d0; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c+V4B1d0"
Message-ID: <dc7fb8ff-def1-4d9f-8025-c7da49a1a902@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772229665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O9aosDff01A5vG7FDiqPHENUMGy/wtA//17/ZG5YGhg=;
	b=c+V4B1d0bRhUee5RVhRza7qcTgCdboHyBXwyNo2hkneRIhKF/oaExd6XSOlcCh/r/4HGRk
	84/lOBuFhSyF0rZonV88EFU3Vk7flqEvUj73SR1tvYu1+RA3mYMOBBdMctEAqVTNxGatGm
	CRt1RI+pMj5YUCHFPIeGUpupjsIt0vI=
Date: Fri, 27 Feb 2026 14:00:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv6 bpf-next 9/9] bpf,x86: Use single ftrace_ops for direct
 calls
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
 Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20251230145010.103439-1-jolsa@kernel.org>
 <20251230145010.103439-10-jolsa@kernel.org>
 <1b58ffb2-92ae-433a-ba46-95294d6edea2@linux.dev> <aaIAoBZGkP7RQrvc@krava>
 <aaILlSuEgaYDq41r@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aaILlSuEgaYDq41r@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/27/26 1:24 PM, Jiri Olsa wrote:
> On Fri, Feb 27, 2026 at 09:37:52PM +0100, Jiri Olsa wrote:
>> [...]
>>
>>>
>>>     With CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS ftrace_replace_code()
>>>     operates on all call sites in the shared ops. Then if a concurrent
>>>     ftrace user (like kprobe) modifies a call site in between
>>>     ftrace_replace_code's verify pass and its patch pass, then ftrace_bug
>>>     fires and sets ftrace_disabled to 1.
>>
>> hum, I'd think that's all under ftrace_lock/direct_mutex,
>> but we might be missing some paths
>>
> 
> could you please try with change below? I can no longer trigger the bug with it

Can confirm that the bug doesn't trigger with this change.
At least by the reproducer test.

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thanks!

> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 827fb9a0bf0d..e333749a5896 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6404,7 +6404,9 @@ int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  			new_filter_hash = old_filter_hash;
>  		}
>  	} else {
> +		mutex_lock(&ftrace_lock);
>  		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> +		mutex_unlock(&ftrace_lock);
>  		/*
>  		 * new_filter_hash is dup-ed, so we need to release it anyway,
>  		 * old_filter_hash either stays on error or is already released
> @@ -6530,7 +6532,9 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  			ops->func_hash->filter_hash = NULL;
>  		}
>  	} else {
> +		mutex_lock(&ftrace_lock);
>  		err = ftrace_update_ops(ops, new_filter_hash, EMPTY_HASH);
> +		mutex_unlock(&ftrace_lock);
>  		/*
>  		 * new_filter_hash is dup-ed, so we need to release it anyway,
>  		 * old_filter_hash either stays on error or is already released

