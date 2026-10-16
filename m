Received: from mta1.migadu.com (out-6.mta1.migadu.com [95.215.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42E52ED33
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169806; cv=none; b=GgBPm1hjlJ+MDeZQQ/UVQSvxMr1elOCyxa2PPY/125lldB5IXYK/3kpsLDdzJcQdjjxFFW+5p5gZXhlvI/ssx1TkCD5A68dAcScgNozLvsvrL+jWr+KxWtnIXcX3LrmG7vHVXvtPu0bRGU7nGUeVh4XrrUQLJLgM/N5Ny0lq0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169806; c=relaxed/simple;
	bh=21nlTXF1Ye0xW4Rhf8DSUPZD0UBWhSD2gXLELUgsPxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6q+tbS2+GjlzEMlQdiA/XbyR6n+iS1Tvm5jtJVKdzhlbeaCC9bD8qiZyLegF4dIEjqNYUl6a1oIgDjLoYuM6eqrIrfZYYt1lSiHhu7Awz8AzNNXISAKyuOdiCxmhda3lgwTxyrc2RzyT5WHbbJ4JG1WOQcRcLA9NhgKhG5LxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c2aDv7Vv; arc=none smtp.client-ip=95.215.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c2aDv7Vv"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=21nlTXF1Ye0xW4Rhf8DSUPZD0UBWhSD2gXLELUgsPxc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792169802; v=1; x=1792774602;
 b=c2aDv7Vv9gjRR48uf4jj8BPJ0a2RmWy0A+4dRVQBEoCq4/okeIiXgOvfQlHoHXQRqVfbuyE0
 wRIRlb6d/oRa6Nf97ASrrrHQVqMAd/YQ7k+C1qPphtvwZeWI+ccG+8UxdgR/DvbK2EEQUGAKwMC
 3TWOO+e4bNaD5L8J+hHl9650=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eac7551d6365e4cb;
	Fri, 16 Oct 2026 16:56:42 +0000
X-Mizu-Trace-ID: eac7551d6365e4cb
X-Migadu-Flow: FLOW_OUT
Message-ID: <3bf3d88d-bc40-40d8-a8ef-5d139aa38318@linux.dev>
Date: Fri, 16 Oct 2026 09:56:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 00/11] bpf: Follow up by-value struct and
 __int128 argument support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261013170910.2126673-1-yonghong.song@linux.dev>
 <DM5X4L58MG5M.2AK0D6DRZ5ERF@gmail.com>
 <a420e9de-4546-4be8-9fc0-d9e9c9fa6fb3@linux.dev>
 <DM6DYYV4XVKO.G5S77C0FGIYG@gmail.com>
 <dfa562d4-23fb-46ff-bbf9-5a56d2e51860@linux.dev>
 <DM6EOZ20E9ON.3KR4R7QU4SOJR@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DM6EOZ20E9ON.3KR4R7QU4SOJR@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/26 9:34 AM, Alexei Starovoitov wrote:
> On Fri, Oct 16, 2026 at 09:22 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> This one can exercise for s390x, x86_64 and arm64. Do you think it is worthwhile?
> ohh. makes sense then.
> Patch 4 fixes s390 too. Without it s390 trampoline sees arg_size 16
> for v, does mvc 16 bytes from 0(%r3) and restores r2-r4 only.
> callee_odd() will be the only test for that and CI runs s390x.
> Then LO/HI has a user in tracing_struct_int128_tracer.c. Keep it there
> and drop it from tracing_struct_int128.c.

I will use BPF_PROG2 macro which sounds better to have LO/HI thing.
See progs/tracing_struct.c.

>
>> Two other bpf functions, which has stack arguments, need rejection with
>>     ... && !defined(__TARGET_ARCH_s390)
> Same #if as in progs/stack_arg.c ?
>
> If it turns out to be more than that it can be a follow up too.

I will do a follow-up for this since I didn't test riscv yet.

