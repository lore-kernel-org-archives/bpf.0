Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27233D6FF
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771587705; cv=none; b=TMw1RSyhl/cRXL4KE4akYTSbU+CrFE43JTSOxoqbvjI5muXZHGO7ZZ6+1/TJR/Jgv86/cf4oB5UxFuNFqA7SJdsH+pmuoMwAfYKbwPZ4dRfire0ZhN2hQgPxIxyIytlfR2hRU+PNNhST+vxY2mo2517qwVCFbEm9VqS1IZOlUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771587705; c=relaxed/simple;
	bh=4WcHVq/mBoFtbakeXA8Ckz4sLPUFLeGRkbrobjpbn0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7p28rfS4O5vqVMLun0O62De6PAwuftyEEkJfu0FYC7yU0wtltDXl/C8sTOIQ8iNRbN+6NYef+IIOF4eWiu+v5QJjyBOHp/uNkVskUvCjrrhOwD4f4qiKCulOsvYsa/3I1N9O7RRVhyWzFd3LKXqBLmKpK8vXQWZS3yvU53yqXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aX8XHiJD; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX8XHiJD"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43770c94dfaso2064180f8f.2
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 03:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771587702; x=1772192502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOk6ajBtnq5VNeI1NZWqWE25yrvyUwGs5aAzkkENVww=;
        b=aX8XHiJDhukyKyo51NEqIHn1qyz5FKRNrffL/Nfc3P/SYkOOQQJ4r8OfxXDDGeL6g2
         KDfJ5B0SeWz6LEnUr1yciU9W/7Tb3E9iCxGKA9E6AhYOISSbRsfY6ESqvoJOLrD8j13l
         C9ksE6wvFRHfcO5yM4PIt9bSFgwsltxWHtguMmnruP12wUeA5MfylqCZ3SQsvQu5pgcM
         9O36pAMrxs72TU94OZrABOSFZMhITNAn4Ey8Ve0BwRXbngu9DaYLIij2gRk8Mt26MFOd
         ZfyRS8x8nJFtuie3w5c8aKkvu1Uaj0i3PBLPwOvJeVENluIEkYPADwo88xydBwOFm4MT
         bUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771587702; x=1772192502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOk6ajBtnq5VNeI1NZWqWE25yrvyUwGs5aAzkkENVww=;
        b=rCl9WEg+SXaZHCkRs5NKDdtAEuWXVvoyuvmFuml/C7sTBwnuizyAZui/2KV3EmmqSj
         KSDUS9pFlsypANs1un+YPDmpuaKHAeMYuieDDISphd1Tk7i3EYuT9ytq/Qs8nB/VhGd/
         yE2BLegH9B342tXVJSb5IzN0WYQ3U1qBICunbNChJNJAv0yevMBjIoPcyQSNiQlaPaME
         1BRVfDM+HhGhEzoO0EoeqwtzjXerVFjoJ98DdtU5tOiSH/K0ssgC7dO/8p7cRPS9pMIA
         RWSRSVIrPYFD6WdEJCmed11W1eIaUJsy6LWBR5toF7dPOxqEGoSZitbC/VfOZniuaZ42
         1TAg==
X-Forwarded-Encrypted: i=1; AJvYcCUhL0qyv4ZIqXPPP2eftZ0zWgM3zMg8TjMFrjnOgVyrG7tpRxJP0HUx8jrowTD/CCmy1WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4z11ABaw26suVoDhdVXabG9lVeJt7u0qFbltMB2JVjZ+moF1Q
	LAsOfqQzd3AkkmGzsGWQYnoCbT5x6P4sei9gza1t6o0lsMJJ6qujFUTB
X-Gm-Gg: AZuq6aL4KOK7PThp9QGAs37cT7BZDWZyPjKrmvhM3FWaxGT5MrxYwdszsHQJxyzuV9R
	aNbjzaJQshyOT/1qDAVw1mVCDtU+q5uIfNBx+EMMm2ZlABprAOhpnBlgV8FRvvDDiuNqoZDyjAH
	GHcUvKDDWfKn6MSTA+4JRZSvpWAhBcAILn3JOazNuabUVB+s80cn7DHWlzCWyhW213NVUB9B3u3
	0Q5HdxKGodt92VWpKh8f6pOysElGekAc8E5Ch8Gmx1adZmEgB+LTHsMjjmHOtyOCL+QXMOaEm0T
	rLd3S2XcNOafQLxvEbeYM6qqKwrKyVVdQ0HoXa1USto5fSE+2TjJfRvC2+UxvgdHYhQKzeJMQgp
	inKL55hK3SJW+V7DBFubPOxu5IUMUA0qt2nO2589+aWJqR24TXvbvdPPBfHpukr7aRai82swbcZ
	ZqukESwZ4cTDGBHILLdnxTxrCAy4bWDMhudG1jDMZ+VZZVL5N9/D7wxqPe99Yf/XEI+NXPryv0h
	APyFyet60bGqb+YHD5hjcqtDeA8fqgMc2doNpT/jsuSTASw3NPmjk+KwTo=
X-Received: by 2002:a05:6000:24ca:b0:435:a0f6:115d with SMTP id ffacd0b85a97d-43958df1120mr15486609f8f.4.1771587701780;
        Fri, 20 Feb 2026 03:41:41 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad009bsm53909507f8f.39.2026.02.20.03.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 03:41:41 -0800 (PST)
Message-ID: <84e2f3ad-28f0-4e9a-804f-2647cba9b30f@gmail.com>
Date: Fri, 20 Feb 2026 11:41:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] selftests/io_uring: add a bpf io_uring selftest
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: io-uring <io-uring@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <cover.1771327059.git.asml.silence@gmail.com>
 <7cc147a959ac068c55dae4f540e38e9e4ab121e0.1771327059.git.asml.silence@gmail.com>
 <CAADnVQK0RaOA9ZYZdYyQxOzLde9MR8HpMM0SexcW59A9u7X2Jw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAADnVQK0RaOA9ZYZdYyQxOzLde9MR8HpMM0SexcW59A9u7X2Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/26 19:01, Alexei Starovoitov wrote:
> On Tue, Feb 17, 2026 at 3:33 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> +
>> +static inline void write_stats(int idx, unsigned int v)
>> +{
>> +       u32 key = idx;
>> +       u64 *val;
>> +
>> +       val = bpf_map_lookup_elem(&res_map, &key);
>> +       if (val)
>> +               *val += v;
>> +}
> 
> Since these examples will be copied around, let's use
> good coding practices. Use properly named global variables
> for stats and counters, and drop this opaque array.

ok

...
>> +       unsigned to_wait = cq_hdr->tail - cq_hdr->head;
>> +       to_wait = t_min(to_wait, CQ_ENTRIES);
>> +       for (int i = 0; i < to_wait; i++) {
>> +               struct io_uring_cqe *cqe = &cqes[cq_hdr->head & (CQ_ENTRIES - 1)];
>> +
>> +               if (cqe->user_data != REQ_TOKEN) {
>> +                       write_result(-3);
>> +                       return IOU_LOOP_STOP;
>> +               }
>> +               cq_hdr->head++;
>> +       }
> 
> CQ_ENTRIES is just 8.
> Is it enough for real progs?
> Does the above approach scale ?

Depends on the workload. If you're keeping queue depth 8 with a
storage workload, it's all you need, and those don't go too high.
For net recv workloads, it's batched well if you get 8-16 CQEs per
wait, but unfortunately too often it's close to 1. You'd still bump
the CQ size in cases there are bursts in traffic.

We can come up with cases when it's higher, but what's important is
that you don't need to process all CQEs in a single BPF call. I bound
the loop at CQ_ENTRIES for convenience, but the user can set the CQ
size to whatever is needed, process some capped number every time,
and finish the rest if any next time it's called. E.g.

CQ_ENTRIES = 2^14
const max_cqes_batch = 32;

cqes_to_process = cq_hdr->tail - cq_hdr->head;
cqes_to_process = min(cqes_to_process, max_cqes_batch);
process_cqes_nr(cqes_to_process, ...);

if (cqes_left)
	to_wait = 0;

I'll make the CQ size a load time constant and clean up the
program, should make it a better example.

> I mean the above works as a bounded loop because loop
> count is small, but for 100+ you want open coded iterators.

Sure, but let's do that as a follow up when it's needed?

> In general all progs seem to be toy progs.
> Would be good to have something more realistic.

The other two programs are not toys but rather tests. Nop requests in
this one do nothing useful, but that'll be a good queue processing
starting template. Replace nops with reads and it's doing actual IO.
Add writes requests with some offset logic and it copies data b/w files.
I had such examples, but selftests is not the best place for that.
It can use abstractions, and I want to make them reusable instead
of people copy-pasting from selftests.

-- 
Pavel Begunkov

