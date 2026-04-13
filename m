Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAA39DBC4
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776120005; cv=none; b=Q/9VF5g3KOY9OueFjYsEU4dfSarrDJXGEWJ6/JyJp9vfeT4mPDkMRn5EFI81aCN00eJoLb8LZWtWrXKwoz9RvyH6LyMwXnKzdaU/oMop/ZPl5jwvEaQ7Se58ueAhTOZ9gUO2Dk0nNhAUGYEulhKrdW4uNfcjx5RXTH38eJXRM4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776120005; c=relaxed/simple;
	bh=o8j0HcKJ/ShQlAu1BPWSLiWIyV32ihnNyxP/cspRXZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZIUuzw4QeFAEo1yn4PflQKGjLm1DG/DRVQKk5ioKExPBnSsqmMT630SOSmlNaQE2TWH7P3JO4P5jk4Tycrov5pj//kpcdxZrG1GX5Oyy3SWKrzrEU0j9BK4MvwYY0mSW0cL9ne9v69DpM3zleMKyE4WXJ2mblhYvvvG1yDRaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M4iWeeyM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M4iWeeyM"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50d864c23bdso3778051cf.1
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776120001; x=1776724801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXmshHEGfUZrSf+lquGF+QofFMmntKl9l9tt16k3VqQ=;
        b=M4iWeeyMp6kac0987AgLPI+FTuEFSBtp3bB9MD1OHEj+w/fJeX+i0seaNTp74Om8N6
         hUhdKWCRqk/g+Dd13NSyPBVCtidL++E1UbRmTpVy70NKsruKc8RvgqYIq9PvFP1WASso
         72ZA89y+Cdc5S7F62Ajnu7e+uUrq8Rid9I0uBzCEYnrUuTt5Hb9GQXT4lTSxu6WyCqmy
         w5bGavDPhjobiSwJzZiBFYhOrbCBmHW3Hp1SnFb2LGhJQYhZhpK6q2rn7dxaLi+qCatk
         jpD1kdLmm2BcXaBfoJuoaDWmBuRcj1UC6TVoVEQ4J0qxQZpPWRqujX4KxLu4ZjAKexd6
         hJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776120001; x=1776724801;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXmshHEGfUZrSf+lquGF+QofFMmntKl9l9tt16k3VqQ=;
        b=IwYKl4YhpcPhelg0rYSuybJBwrRhfVHRneN4N5KgzGJmIBZvXMEubKXqZrkzkH0KIx
         Ua2urM7+VR8gsbHR9AGTmT+xxgf6lKJeLKLVECNkF3UeuBX35UmEEX6cwROWGQyzKad3
         eu9DRo1fpesGltwMeT+FwhKNXo9JQV62nJ4KEtlnOUCpG9p6yZKJLRW4myy9M0w0R4Vr
         ZpkasqwBTrgAYG6EcliZJ4qVU97RqqBEqZVXMiAa1T158/pJmBXvzXTqtW5KNYvU/X01
         UuQiQXY3M/X2RqK3SfBRXmt13E9xJ5xlD47jezcQBtp5p0WcKmhtiaBXsXeZydjK8wEI
         5eTg==
X-Gm-Message-State: AOJu0Yy5a76JXy9hSHr42sdSRgeylo/H+kFq/7yTbS/yINB1uMI2ir5g
	eZ6LoMGQCV0Cbt6JYu5UmOsyo64wbE23hobNIZi7L/3Inp6tM0WrNH90QsmbSSpCRA==
X-Gm-Gg: AeBDievk6+jHfjeW/I4JHvKVmUPzYFRcp7+dsbUS1RqLksuximvW0jHyM7xoN0UX2/x
	WwKSmsVqc/IYWyryZ1CIeQ10Hv7YG+8I9wCNGnbLlqtPUcMg7ofceWKFK8f4rsVbTtW0w3E8oB1
	r8JMUurUKDQRKBDllFSNgHpLeJk4RUcMKeuZBcluHb8s84SWjL0fFUYmMcCnaCsGkkDpBHEynod
	YBWTA+tWcYQDNH0/1UQxSH2hwDc7luK0N42zi90fdiqrlJaGNJ635H5m2U3NhqvSAAi1OLttFwC
	db/QW2nHhWJ2+umJLA9Hrv4YdcHl0FVdjZ0xWLj5hHt7X4ngroBbV0/oMA8CB2bJLy4sNRXVQ0/
	a6SEtV+Vs/8npmRVEjyr2j/CMF+lfoh29+RfVVYY2nJVYs3dVfRGKRVOCemCqRcb/XMjohxZCPJ
	b9qwjK9UKFvcFHp1YLIWvGO3XMCrLj98yHTQalAZ4+xxI=
X-Received: by 2002:a05:622a:5815:b0:4ff:cb72:7c03 with SMTP id d75a77b69052e-50dc4260c50mr3392491cf.3.1776120000683;
        Mon, 13 Apr 2026 15:40:00 -0700 (PDT)
Received: from [192.168.1.27] ([130.44.176.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb9833c6asm973381385a.42.2026.04.13.15.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 15:40:00 -0700 (PDT)
Message-ID: <6b329a63-14f2-4546-aa4a-82da87f47a6d@google.com>
Date: Mon, 13 Apr 2026 18:39:59 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: Fix use-after-free in arena_vm_close on
 fork
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com
References: <20260413194245.21449-1-alexei.starovoitov@gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <20260413194245.21449-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/13/26 3:42 PM, Alexei Starovoitov wrote:
> @@ -486,10 +498,11 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
>   	arena->user_vm_end = vma->vm_end;
>   	/*
>   	 * bpf_map_mmap() checks that it's being mmaped as VM_SHARED and
> -	 * clears VM_MAYEXEC. Set VM_DONTEXPAND as well to avoid
> -	 * potential change of user_vm_start.
> +	 * clears VM_MAYEXEC. Set VM_DONTEXPAND to avoid potential change
> +	 * of user_vm_start. Set VM_DONTCOPY to prevent arena VMA from
> +	 * being copied into the child process on fork.
>   	 */
> -	vm_flags_set(vma, VM_DONTEXPAND);
> +	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTCOPY);

i think on older kernels, VM_DONTCOPY alone isn't enough, due to the 
whole MADVISE_DOFORK mess.  Linus added something to catch this in

https://github.com/torvalds/linux/commit/0b2758f48f22b173963f39e553d0ecd05f3b4433

(Just a note to any backporters out there...)  =)

thanks for the fix

barret


>   	vma->vm_ops = &arena_vm_ops;
>   	return 0;
>   }

