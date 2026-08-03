Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A58634C
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 01:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785720515; cv=none; b=mPcQEfIOA0p7Qa8LIPEIQU4MOsmOhQ8Z9UZh9EMDMS/XDDMyy965rM72XV2dFiQlSAvFwEbma7y90Y6A4OfFkH4fdqV+r2SwFcHFGSN2Tyrh8Yf0MAuyvbYRE9ijuVfvUEMiUNbPf3zuBkn8HQjIdRERho7XaeRmifGsTgoPz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785720515; c=relaxed/simple;
	bh=6i04O5CFp/4Pk+aYqAnASRf6c3l8QPpoW7WB5FRTflw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=TU0QS1nYB2hNn0mXjO3+SsFeOeDkrg/19nO+ICeGmjAv2tyYfvRlK8BCdayGQBiOtTwAypkUjKLD3vyQCKZ3aHNlhPMUmfDI010M+75ODPjG8qKoHK5IUsstHYUzKBFUxVLjLuKH9XXTK0P+MlMGNxhiDfi96CYKD9F6+CGkp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbYQVkKf; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbYQVkKf"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-473913157edso985940f8f.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 18:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785720512; x=1786325312; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y8r93oSZtoqKQ7VM9cC5jOx8tm9JrVZHlrCpEvzQrkw=;
        b=PbYQVkKfxfIgbU0YxQNBsVuddq1X0GeAF/weZm5/1esRrJwY3Go71zc1uoRj7Lb1DB
         mg+WIu2xyEnA0hs8N+lRKbIbA/XCKalROEZltAFLjQW0V0GKg0luf2V6gB1U+r7ThbB4
         vGFMLrbEC95F3gf6MTZOz0TYev855yuLqI9PHHlbgdVn6NIfLyoDeBkl0/YEYUoThFau
         I4Toa0SzzsTRmOZSAuWpuPBG0pPF+DHyPsV1pkOcVI2EbMvZWtAaih0KpBOoM7AHWlZM
         jy6XwBMehtCChIwA8yFsLqlZef2RBe2DcW04ZHA5ZzkmpLpBjXWSlbuqRBwe543NHJjr
         /VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785720512; x=1786325312;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8r93oSZtoqKQ7VM9cC5jOx8tm9JrVZHlrCpEvzQrkw=;
        b=WgxT9wz1TANKezkwebdTQcQ/lylkpap/Xlb1Jdzfrz6xp1K7/+0h+x/jA45dtg8YRz
         MX7VK9CpOh1pzM9efu0LSpNUpkpy7Tuf0m1wPG0mJUN9n8X7b2dM1X7fNfyclEpAP66d
         HZO+0sxD65XyIEDV1qrsb7YG7dzHC4/qabAPDGWHk0AVTsdK8oNf5Zlih4mxuH2GdeUo
         tlP+oodmd5HewPhRDsct/wpq82fw62N7WN2XXLCgrev/bsdxrqKnngacErO1ZViCXHr9
         w/tdBZcZiqexl6volYjnkilJxhlcMRASFgWi7w6FyCNnXuqQan5I4aL5mQ9TiJhTihuT
         lUjw==
X-Forwarded-Encrypted: i=1; AHgh+RqTBk2KjQlvbe0ihEUa/T/p7fDNzf+lVLrBvrTV8BFG34OvS5q9QT+mawpYK7nrdZuZKm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNXZCBiPdgmr400bTHSmK/Qzwe3AtGFyVZni+UtMONpRbfhl6
	XOFYpBtmi5+YOvhAbkF/ku+u9IawkMZ1In/HgKl1DeV8I1Uc+fapCAK6
X-Gm-Gg: AR+sD11xEnRRcwQLb5O0F5zmvw7Rt+x9EQC/ED6vSaHhBEAZY2Lgr84C5BpxbKZuDwV
	8lNqpjVqzRbA6v5bLHz+T2wHc6CAi+BQxmDeacNsXYAWgLj+5gbhMaHoyeY15A8qmI6mduzy+AW
	oPV7nPIS2y0Hqx08elB/d03MV+HH0VR0fPHYR+wmXalO8v83Lul7S2R2OZaan1/zhUcI6FskZDZ
	BbUQUT1asuvF8vIxJ+YWArf7DB+PavUwisvyUb/4VKko0UZLjkhCsgHPC3YNtbjqx5aNkcT1Ncw
	w0lK0eNt1WneTxkdcLaqf+eZgOMyQ/S3A993PtR5bDfYk2pqPrqizF2WZsgWUxQwkMHsL08W0D1
	AUqymdo5WC723vQkQC0LtAVhohQW6IGNPm7YsyggciRpuVt2EQT4fxz3DLt77C/o887JhmpKX1O
	uUjMgmnrQ1TYNQ4hBtBaHull2nkpvgSj8W+m9pWYwDWfHLlUQZwYlNZEiXpVLMRPbwWY39Xcafo
	DVbVatkdavaltDsvBV4LVGfR93R/0g1yr2LC4PO8EHw9GipyEvMbD9rhv4DztGW+DJp395qST4P
	BMMlqMjZCBP+xvkPfrDqgVRfgJxS
X-Received: by 2002:a05:600c:4444:b0:493:f6f0:d66b with SMTP id 5b1f17b1804b1-4980c6458aamr155528905e9.1.1785720512186;
        Sun, 02 Aug 2026 18:28:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49808199a68sm127648395e9.4.2026.08.02.18.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 18:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 03:28:30 +0200
Message-Id: <DKEX39L8EPN1.2NMJPDUMFKIDO@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Puranjay Mohan" <puranjay@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: arena: fix mmap_lock deadlock on arena
 lock failure
X-Mailer: aerc 0.21.0
References: <20260728060517.95183-1-jiayuan.chen@linux.dev>
 <DKEWY0MJHZ64.ALDUTQQ1RPLG@gmail.com>
In-Reply-To: <DKEWY0MJHZ64.ALDUTQQ1RPLG@gmail.com>

On Mon Aug 3, 2026 at 3:21 AM CEST, Kumar Kartikeya Dwivedi wrote:
> On Tue Jul 28, 2026 at 8:05 AM CEST, Jiayuan Chen wrote:
>> Reported by the Sashiko AI review.
>>
>> arena_vm_fault() returns VM_FAULT_RETRY when it can't take
>> arena->spinlock, but it never took mmap_lock. The fault path assumes a
>> VM_FAULT_RETRY handler already dropped mmap_lock and re-takes it on the
>> retry, so mmap_lock gets taken twice and can deadlock:
>>
>> 	do_user_addr_fault()
>> 	{
>> 		fault =3D handle_mm_fault(...);   // calls arena_vm_fault()
>> 		if (fault & VM_FAULT_RETRY)
>> 			goto retry;   // re-locks mmap_lock
>> 		mmap_read_unlock(mm);
>> 	}
>>
>> Return VM_FAULT_SIGBUS instead, for two reasons:
>>
>> 1. We could keep VM_FAULT_RETRY, but then we'd have to drop the fault
>>    lock first and cap the retry ourselves, the way __folio_lock_or_retry=
()
>>    does.
>>
>> 2. A failed raw_res_spin_lock_irqsave() already means a possible deadloc=
k
>>    was detected, so retrying just hits the same lock again.
>>
>> So returning VM_FAULT_RETRY here is overkill.
>>
>> Fixes: b8467290edab ("bpf: arena: make arena kfuncs any context safe")
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>
>> ---
>> target to bpf-next since I think it is moderate.
>> ---
>
> This looks ok to me, but after staring at this function for longer, I thi=
nk all
> kinds of non-recoverable errors should be using VM_FAULT_SIGBUS vs SIGSEG=
V.
>
> The only case with SIGSEGV should be the flag based request to disable
> allocation on lazy faults. That should include the scratch page case, sin=
ce it
> represents a hole.
>
> SIGSEGV: BPF_F_SEGV_ON_FAULT, scratch page.
> SIGBUS: lock acquisition failure, range-tree failures, page allocation fa=
ilure,
> kernel PTE install failure.
>
> All of these SIGBUS are almost improbable, but I think it would be cleane=
r to
> keep semantics clear.
>
> Could you follow up with this change? I applied this one for now.
>

For the scratch page case, I think we do SIGSEGV when the BPF_F_SEGV_ON_FAU=
LT
flag is set, but SIGBUS otherwise there too, since we could but choose not =
to
lazy allocate a page due to the program's error / bug.
