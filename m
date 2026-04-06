Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F742EDD70
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 06:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775455425; cv=none; b=t33YsLGuAKt9C4SKHjdQUdqL9oqERKqfRCxY6GtOLLNl+9wHUmtH/UfworRmps6wmBH8ghVuMnbCBB3jd8BhmyScuUdOzsdo/kzAVPHbPbbU7tUngrC++xVT+U/SLDk8mx6vVlK506szQxcWk30euYR8EiTQb2dR58ALK9WMT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775455425; c=relaxed/simple;
	bh=EHv8UrosY+X4ihq4in2Gb3VnfbtgK3LHPrG7tapif9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+safJxyCwYgr7uH1KtFVOCb75ovkb+8ELGMGjThlHpbG+Altv202EU3GOA40lW9EJPXjyduuOcem+f97A9KvYSWC7pkc0nMlCHpasgS1DTrS3e/w+TQ81lWFKRlxQY7kA3zNWUheFr9x6VV+DM0TUU3PPxJASOpZ0nQzvXeu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iz0PaxXz; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iz0PaxXz"
Message-ID: <5f37fcf2-05f7-47d3-b412-1515ee19fbea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775455421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/f1oDTyiui/eYpNv9rpCuy7TBj7jb+o7n5doemsJKyQ=;
	b=iz0PaxXz3U47q0LIzCTaXuhswhCHYfgrcMqtMFudEgfYyOolSQzSiX6rj3UJYUzH4NJsZk
	/AlHSJew8LfGpSLhE8rbuQC8qJoIXGt4nzL0LcUqOMvhUK+WG4iyDHV9984prPJxi3ZR+o
	52TG/Ss0Wg1cTVjJHCmdtS7zCaux1jE=
Date: Sun, 5 Apr 2026 23:03:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf
 functions
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
 <20260402012742.3917613-1-yonghong.song@linux.dev>
 <CAADnVQ+y1jZZTyNcXghD0UQ+JzD0pEu=icSP7=+QY4b=9dzv7A@mail.gmail.com>
 <924fde92-d28f-471d-9f0a-0c176958139c@linux.dev>
 <CAADnVQJdTffT5sdqZVdWX9W-jG2vPjiPAA0OT3iMPPsY9-KFmA@mail.gmail.com>
 <074ee11d-3f63-4e6c-b66d-c60a834cbb25@linux.dev>
 <CAADnVQ+9OdBFnUAXND-MW7epFnqwj9f2w-w0xPD7T73sTMj9Zw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQ+9OdBFnUAXND-MW7epFnqwj9f2w-w0xPD7T73sTMj9Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/5/26 9:51 PM, Alexei Starovoitov wrote:
> On Sun, Apr 5, 2026 at 9:29 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>> For 6th argument JIT emits these two stx/ldx as moves to/from x86's r9.
>> For stx case, we should move the bottom stack value (6th argument)
>> to r9 and pop the bottom stack slot (8 bytes).
> That doesn't sound right.
> Passing 6th argument should not involve stack manipulation at all.
> No push and no pop.

The following stack layout can avoid the above push/pop issue:

    incoming stack arg N -> 1
    return adderss
    saved rbp
    BPF program stack
    tail call cnt <== if tail call reachable
    callee-saved regs
    r9 <== if priv_frame_ptr is not null
    outgoing stack arg 1
    outgoing stack arg M -> 2

After the above pushing (outgoing stack arg M -> 2),
if bpf-to-bpf, push the outgoing stack arg 1.
If kfunc, move outgoing stack arg 1 to r9.

