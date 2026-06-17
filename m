Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC639A7F2
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781734425; cv=none; b=LryOvN9a2e31jDVt9QLI+zndf0d5OzSZG2WvcxXpBNwXkCX5uCkfdnTL7PMBW/MkFXOqAXMKNibdJZ9gXymz3wiPJyW2IGMD+Nwp6ObVO4UuY7Mjn7oPasJoO4GxKxB77MqX13k17/LXTPIHg9jbSkiw66kbzHZ+Gu7I3AlY+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781734425; c=relaxed/simple;
	bh=h60UtavNL2iJvnKSr/9X/l/H/sFibtSs6cNSiIs7Pck=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Vjl0i1q08f6jORn5FlbJvy1aZXO58nGJXt1SjwoCVa6f3KXVo0x6z1eZSfp40kHzNTAoIyDOs0S32Eo3qDZwYN9YrpJG4Wr5LbU89k6wbjrHk1VDHOBLJxEivGm0FgEyeNQSiW8KGiSBGpXyNrf+ToFJ6kO6o5d+xX5LwLRoWgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQWh5GSN; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQWh5GSN"
Message-ID: <326b85af-c41a-4387-90a0-60720111934d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781734420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXCtT0v0EUXn/TCjNbtIDqQixZXo8p0dSnCceCqrUHI=;
	b=JQWh5GSNswOXAIAtOLthK4YPH2rXesoew2oocgmabfDNY7GrFI8VhZRmTZRJPDLnO1EF9I
	t0DX9XKg74MguhSeDG9tLRPRPOHHoeHsiusXKx78qWz4Waug8hmuYjlw8AJdElsRs+/kv/
	7H6AZ8tLjCt0tjcl4f1LnXwjZfG0Mp8=
Date: Wed, 17 Jun 2026 15:13:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] kasan: Fix false-positive wild-memory-access on x86
 under 5-level paging
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260610175651.647515-1-ihor.solodrai@linux.dev>
Content-Language: en-US
In-Reply-To: <20260610175651.647515-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/10/26 10:56 AM, Ihor Solodrai wrote:
> 
>  [...]
> 
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 2b8e73f5f6a7..b5f430f2dbb6 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -9,6 +9,13 @@
>   *        Andrey Konovalov <andreyknvl@gmail.com>
>   */
>  
> +/*
> + * check_region_inline() and addr_has_metadata() can run very early.
> + * For example, in an interrupt taken while identify_cpu() has the CPU
> + * capability bits temporarily cleared.
> + */
> +#define USE_EARLY_PGTABLE_L5

Hi everyone.

Bumping the thread, as it's not clear how to proceed.

From the discussion, we've got three approached to the bugfix:

  1. USE_EARLY_PGTABLE_L5 in generic KASAN

  This one is probably the simplest. We add USE_EARLY_PGTABLE_L5 to the
  files that call addr_has_metadata(). It's KASAN / LA57 specific.

  The downsides are a performance hit pointed out by Kiryl, and that
  it's an arch-specific switch in generic KASAN.

  2. local_irq_save/restore in identify_cpu() - Kiryl's suggestion

  This looks like a better fix addressing the actual problem of cleared
  capabilities being accessed from interrupts.

  An open question for me is whether this fix is complete, and whether
  the scope of irq_save/restore is right. We might also be ok with it
  even if it's potentially incomplete.

  3. Static key for LA57 in KASAN - sketched in the thread

  This is essentially a bit better implementation of (1). Still KASAN /
  LA57 specific.

So my question to maintainers is what approach seems best?
I am open to other suggestions if any.

So far this is mitigated on BPF CI with no5lvl boot param, but the bug
is real, and I believe we should fix it in the kernel.

Thanks!


> +
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>

