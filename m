Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7A36DA15;
	Sat, 26 Sep 2026 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790455142; cv=none; b=ND2hJIo/9oXyneJvRpVy0m17u6jPstWIPk0Lq86A/lLy53b0EfXHSdufBPAGONrSC6HdKJQIC6L7Uk+XErWAdGzbMkHumgAdqBEnmqwWvyBHEUOu5HTbCfhctXlPXawMjJZ5HMnmaMK1aOh70AO72zuzNlR7YodzXunPSYzhOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790455142; c=relaxed/simple;
	bh=WcVTwGAqB8YmWIqbv12BtHyhd+b5UhezZLShFgEBfeY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gm4Y5Wa+xjswvXxS6lwRM0Zcgj/srnB7DWQW68nSJZO5HGkm2dQtg9YGOabFcC+LthtMNcnbFfKu9eNfqJlAw6lGPAtKkVNSdk7dlegD3CSoOuqpPfBIQuMsqGqo4THFovHeXomKoRO5pO2pW13Si8EwH8Vsib37OMScyXsCpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=j3wf/B0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="j3wf/B0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5F01F000FF;
	Sat, 26 Sep 2026 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790455140;
	bh=02DQCrFlxmpCYsYFSl0Uzr7hhjDE/dW47AC7GUSlrxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j3wf/B0P5XyKqxSsEjcKXOxZ68HSNPr51dRebHjrAbWlXq+djrJhmIH+okuCnxdfS
	 +4fSGzal0ks3J7vnJHvZmIZFYT+HeZMXtQ4WbVyBpFYBPSfzsyTuFZuMwi91/u4LGY
	 BaOKmTDT/+RzC+VpowJzQWh7KM47juoEXrebiBpc=
Date: Sat, 26 Sep 2026 13:38:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>, David
 Laight <david.laight.linux@gmail.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 bpf@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v6 0/3] kallsyms: Accelerate symbol name lookups by ~7x
Message-Id: <20260926133859.c8232c439184dfa17472b020@linux-foundation.org>
In-Reply-To: <20260926-ksyms-tune-v6-0-236620c65e98@gmail.com>
References: <20260926-ksyms-tune-v6-0-236620c65e98@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 13:40:11 -0600 Jim Cromie <jim.cromie@gmail.com> wrote:

> As measured by kernel/kallsyms_selftest across ~184k symbols,
> kallsyms_lookup_names() binary search takes ~6.1 us per lookup due to
> two inner-loop costs:

We don't have a kallsyms maintainer afaik.  Petr is pretty active in
there so let's give him a hopeful cc.

> 0. Candidate symbols are fully decompressed into a 512-byte stack buffer
>    before calling strcmp(), even though non-matching steps could choose on the
>    first differing character (0..N-1).
> 
> 1. Probes scan sequentially from 256:1 markers in kallsyms_names[],
>    decoding an average of 127.5 symbols per probe (~2,170 hops across a
>    17-step search).
> 
> This 3-patch series addresses both:
> 
> 0. Patch 1 introduces kallsyms_strcmp_symbol() to compare ASCII queries
>    against compressed tokens on the fly, bailing out on first mismatch.
>    Drops the 512-byte stack buffer and saves ~530 ns.
> 
> 1. Patch 2 increases marker density from 256:1 to 16:1, cutting average
>    scan distance from 127.5 to 7.5 hops and dropping lookup latency from
>    6,102 ns to 866 ns for +42.2 KiB of .rodata.
> 
> 2. Patch 3 inlines and unrolls get_symbol_seq() 24-bit reconstruction.
> 
> Results (kernel/kallsyms_selftest across ~184k symbols):
> - Baseline (256:1):  6,102 ns
> - Patch 1 (strcmp):  5,572 ns (-530 ns)
> - Patch 2 (16:1):      866 ns (7.0x faster)
> - Memory: +42.2 KiB .rodata, 0 bytes dynamic RAM

Can you better explain the tradeoffs here?  Increased memory use?  If
so how much?  Is any change in build time expected?


What isn't addressed in here (afaict) is "who cares".  Is there some
workload which is kallsyms-intensive?

This info really should be right in the first para of the [0/N], and in
detail.  What benefit does this work offer to our users?  Use cases,
example scenarios, etc.

Apologies if I missed this in earlier discussions, but if it was in the
[0/N] this wouldn't matter!
