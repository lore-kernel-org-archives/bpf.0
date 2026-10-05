Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB93296BA9
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212336; cv=none; b=AmCFay45uO1tos/n7PCV2iDt07c+4Coet5kXws3budEC+B1cgKrNTfiWQnGd7+jYUwDxqaPQfY0edgsaNYOcXVyEQ7tPToAdbP7etFcAqturBAg/8Lng6ewyhkAcZKcAVr31npHbSryIDNRGOCAp7eTeCK6brNJ2YrZeN4hHXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212336; c=relaxed/simple;
	bh=FkejWneu860TICRiCvnW81F/s8X4+QiaaJlWG1DO1EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAzT8ZnfNdc217PGEzOZS++d4wuGdIVZDdDwpd3r8Esz2cDNGRnwYTG5kyZt6fFfGcEf3kH3ShJtpKrZFR5KfChyvvl94gYKcDm8k5PIgiH5aHkYsTv7YH8W7EUUfuuMCnwR/FLsfJJ3PioTeam7/JMRiyrxuVuVWBEcSktLVvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=k7TlPjaF; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="k7TlPjaF"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9BFA380B79;
	Mon, 05 Oct 2026 16:58:45 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id coUFbeWszKyz; Mon,  5 Oct 2026 16:58:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1791212325; bh=FkejWneu860TICRiCvnW81F/s8X4+QiaaJlWG1DO1EI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k7TlPjaFRrL01kMQ86pRqtTmD6RapzcNbqJPATzt6mQMxZldQJpz3RLa6WyzbACm5
	 P+qIzgqqjx7g8K9wEnI+hMJyTiTwhuOqKu0HexSRwCHHqWVYZDocnIsO0SP89IXir9
	 AkeAIkC85SEdA/KDCm5lbusyMq/66kJnWi4Jo11KrFA4pivUiQgQ0dBoVcWRxdonAv
	 9NJLICiHy5amoyleEu4I/Ol460NKJCDPcgIZmAkYU6e1oO7W037ELWAyY7c6cRcEzD
	 d+wkiwxb3xyl68izPB8dCbHh8mKpK7IICYEeHp03GSDhVHrx4XfCrjMrkoaDw4DSd/
	 aeDv1+VBRCycw==
Message-ID: <e9812369-5936-4c76-90eb-1c23858d2e64@disroot.org>
Date: Mon, 5 Oct 2026 15:58:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 1/3] bpf: Fix incorrect handling of user flags in
 bpf_percpu_array_update
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20261004111007.3216186-1-maghasi@disroot.org>
 <20261004111007.3216186-2-maghasi@disroot.org>
 <7b661c7e-3d01-4361-8d0c-84c97866b404@linux.dev>
Content-Language: en-US
From: Masoud Aghasi <maghasi@disroot.org>
In-Reply-To: <7b661c7e-3d01-4361-8d0c-84c97866b404@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/10/2026 04:10, Leon Hwang wrote:
> Hi Masoud,
> 
> Please wait some time, say 24 hours, for human reviews before sending
> the next revision.

Hi Leon, noted. thanks for the review.

> 
>> @@ -438,7 +438,8 @@ int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
>>  	u32 size;
>>  	int cpu, off = 0;
>>  
>> -	if (unlikely((map_flags & BPF_F_LOCK) || (u32)map_flags > BPF_F_ALL_CPUS))
>> +	if (unlikely((map_flags & BPF_EXIST) && (map_flags & BPF_NOEXIST)) ||
>> +	    unlikely((u32)map_flags & ~(BPF_EXIST | BPF_NOEXIST | BPF_F_CPU | BPF_F_ALL_CPUS)))
> 
> Probably, we can add these two macros in include/linux/bpf.h.
> 
> #define BPF_EXIST_FLAGS (BPF_EXIST | BPF_NOEXIST)
> #define BPF_CPU_FLAGS (BPF_F_CPU | BPF_F_ALL_CPUS)
> 
> Then, this 'if' can be simplified to
> 
> if (unlikely(((map_flags & BPF_EXIST_FLAGS) == BPF_EXIST_FLAGS) ||
> 	     ((u32)map_flags & ~(BPF_EXIST_FLAGS | BPF_CPU_FLAGS)))
> 
> Also simplify htab_map_check_update_flags() in the next patch by the
> same way.
> 
> Thanks,
> Leon

Sounds good to me. I will apply it to the v5 if there are no objections.
