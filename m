Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230505;
	b=Lzv73KTJhixEB5t0swobnoo8dh8MAgEr2Xh7cByoXuMQqucLjVRp1y0i8vBHD60913k1
	 /Z0zplYYTVY/pufgkAr/FNOmvRDumLsUAYJ9oekhzqBqcUOT+dXy9bQIEAe+R4mr0NN1Z
	 St4+h/D5UGpuJAm89TRJcpN9uhWfz6yeVUOSj2G4jt0FHu9NdoNafHCoF4+aXQ+LlUfCE
	 lQZMbmQ71sBfE6G9mxMObfVw43OzXopn/uNH9xffu2OQzr7mMyqf3XdJ+Dvku2gDK/g4y
	 I+HrPLA/wC08mFrq8e47j2BPX7Qei1WEQwSaxw9UjAsMuKQq/G1DgvByQqIIXAyi+eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pEuxbvXtluYllCu/vc7sHN+QRKtfy44dRwIe6mCBUE4=;
	b=dVfgj0xcutsVitA4H//2DElBARiMb9Gsjq+bZQUy4zIL9q0WrJ1j/5fhSOpW1L1aZjq0
	 5CPWtS9GAncAfly92oHgas1HhJmWh9tyP8FE5zNGnniH/JZtpyVvhRAVFRd1set4eYUGT
	 aYFQ6NWuPpwZzkrVIW5tTY+m1vZVnEw43zFG0Zpqu6tBfh3atA4c7tgZsIsAGCnee6SMI
	 Ctdc12vsFLwnOMnZLP0oTnS50IdSjvvoj8OTAiGik8rYCzcQkVA4NwLZzZnmj8hvx2ed+
	 xwm+f7IuhYS7ccvtgUazMOonC/QbwOdbb/LYlgOA3ElrH2GbTnLSMUsYU6EZK3UWhMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQd+G5lX;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A86606A322
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 13:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31A86606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FQd+G5lX
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491aaed7565so529238f8f.2
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 05:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794230502; x=1794835302; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pEuxbvXtluYllCu/vc7sHN+QRKtfy44dRwIe6mCBUE4=;
        b=FQd+G5lXaGVwlAm/J2w2LE1vuYTaMrYEK29bnurj4i5xIPn873J/s2JLTcfDJ7LJnA
         e9Bi4u2cNDz/I7/25Dwv9o0k00a92rwVUUWieHNjAPzEY2isAu7bI+0wgShNQ5xrQVHZ
         iVtZFxsoxU0FmJjFznjXPh8m3C2B/NZUeVo+E/oEGrwKVruJCzfHfbhxtL8UGNbLk5rx
         913Wkg5hQ5dp7seaqWrxNNPbv/dW2SHu+pqIybIj7hg5yiYrcEgGD8bq7Jic6a6OfQpi
         QF85I+9IQ2haSw45KyUYdy80QpMMijPh3SIKQeXYxoYJrlEaKkXiVa0Fmc2uVFlzhVqc
         CycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230502; x=1794835302;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEuxbvXtluYllCu/vc7sHN+QRKtfy44dRwIe6mCBUE4=;
        b=IDfzHZAoikybLQ1UrWRHr3mUu3uVXeJmRD4w1X/gUFS8/T4WnhOYYkxpMB9NObUQkZ
         LiPuE+3X3QzD/6KDJDwxJ6xYxfua+v5jyUeWX4W2F2B7Lmr+N7HUjS6/MFaa0k5+GgT8
         7nZYIdAWZJ9U1CAxjQz9kAn9bW4KJhFG6JwfA5XgATEtAz5eYFjHsEFeX0P2KbavDhqz
         i7BsEHpOe6OONMAiFi55rWd59YWnenuG4o37SNgFutx3iiGBHNRZiLOs2BbI9RDYYPCO
         4MUkLEAKCOr8wqkInQ+RLDUqT7Dl2OsnTX4R4Dzf3kY+1VU31sZKcRPhZFoSnaMtbCSk
         kyNQ==
X-Forwarded-Encrypted: i=1; AL+hErE/3NkVEZ+yQlwwt5b+GhUCptnRG19bxSrWp0m88t0Q1aNeBr6pQoy/7WRXNMv6LywcgTQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w93+wFGakQLKKr8oulj8KERoLEbxILydWZ/Sd3hmAZEJ81Qlo
	GuOc/ny2RHUYlHGmZ4CUsBhrhi3latKJce3hELR7tP65pRbpLm3FjF+e
X-Gm-Gg: AYBFou1NRV7VzRLJ0zfm3jvalp5FeF+SIZsa9oXCCzstYkYjF0p0Q9f95agULey9h0z
	Bxx7Ejid23BUavoOCR4/sGT05PfK0cqj3g2P0Lay0DZi055yIuy2zQbju20dHq5yJtq2t6u3AXn
	LLCOOMQdE0hu4vbwbFxdpUgWy1ImFyXBbGX5/4nygbTdDZp/NUGQ8EXgM4v7e/qVH4er3IxhDbS
	v8pNWYadIzYtZ7guSVxIU1eFSFBbv3BuJzP3icbuhZZLE7kgrsKDWmVC7y1jGIdBSeYZAWwZymf
	eu1Jc6a24CJjL2yvEnTVKmsIe7ZnNIIISPTr/LwwlY5PYmeLYrsxv09IvU5r1aHlc3tSfurpfAk
	dAulmMxXbUZW/G3Dh5eTbIgUtdf7GcDdkDD/j+T5r3q9L1J0lfNNTEjsTFUzptgjM7zc13Zwz3Z
	VETEjxl66nS0w8hOUhMY+Vj/ETyxtdp9rFcFhUGkmWQvbnZj0oR/NrV1yBXj87v+I18m3knx66o
	S37G4TKNlVIGNMtMqjFv0I6EbGwGoks6TuPVJWq6OSK0ujyfFjV7xtpYBLH3VSa5D14WHCaA0tM
	hVEJfKUrHrlgKOALNBcoYnrgQKqhygKgMwUNCFq/IvwfIcvU/FYRJ6IvKQ==
X-Received: by 2002:a05:6000:98e:b0:488:654b:ccd8 with SMTP id ffacd0b85a97d-4957f21a79emr6492891f8f.6.1794230502289;
        Mon, 09 Nov 2026 05:21:42 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596ea51cbsm10925707f8f.27.2026.11.09.05.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:21:41 -0800 (PST)
Date: Mon, 9 Nov 2026 13:33:12 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, almagui@kernel.org,
	john.fastabend@gmail.com, qmo@kernel.org, brauner@kernel.org,
	kpsingh@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, sashal@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH v1 bpf-next 15/18] resolve_btfids: Tag fmod_ret
 candidates as targets
Message-ID: <avHLmNLouxZX5z-e@mail.gmail.com>
References: <20261106210314.1767267-15-a.s.protopopov@gmail.com>
 <82dc259cd905abb5ad4fcbb8151553fb8680d4d71b1e52babd3e2d588a90656b@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82dc259cd905abb5ad4fcbb8151553fb8680d4d71b1e52babd3e2d588a90656b@mail.kernel.org>

On 26/11/06 09:50PM, bot+bpf-ci@kernel.org wrote:
> > resolve_btfids: Tag fmod_ret candidates as targets
> 
> TL;DR: Nits only in resolve_btfids fmodret.c: duplicated alias-walk code in
> mark_traceable_function(), its unused bool return, and possibly obsolete
> section names (.meminit, .cpuinit, .devinit) in section_cannot_be_attached().
> 
> > diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> > new file mode 100644
> > --- /dev/null
> > +++ b/tools/bpf/resolve_btfids/fmodret.c
> 
> [ ... ]
> 
> > +static bool mark_traceable_function(struct elf_function_list *list,
> > +				    Elf64_Section shndx, GElf_Addr address,
> > +				    enum ftrace_site_kind kind)
> > +{
> > +	size_t left = 0;
> > +	size_t right = list->nr;
> > +	size_t first;
> > +	size_t i;
> > +	bool found = false;
> 
> [ ... ]
> 
> > +	if (first != SIZE_MAX) {
> > +		while (first && list->functions[first - 1].shndx == shndx &&
> > +		       list->functions[first - 1].value ==
> > +						list->functions[first].value)
> > +			first--;
> > +		for (i = first; i < list->nr &&
> > +		     list->functions[i].shndx == shndx &&
> > +		     list->functions[i].value ==
> > +					list->functions[first].value; i++) {
> > +			list->functions[i].traceable = true;
> > +			found = true;
> > +		}
> > +		return found;
> > +	}
> > +	if (kind == FTRACE_SITE_PATCHABLE || !left)
> > +		return false;
> > +
> > +	/* The nearest preceding function owns the call site. */
> > +	first = left - 1;
> > +	if (list->functions[first].shndx != shndx)
> > +		return false;
> > +	while (first && list->functions[first - 1].shndx == shndx &&
> > +	       list->functions[first - 1].value == list->functions[first].value)
> > +		first--;
> > +	for (i = first; i < list->nr &&
> > +	     list->functions[i].shndx == shndx &&
> > +	     list->functions[i].value == list->functions[first].value; i++) {
> > +		if (!function_contains(&list->functions[i], address))
> > +			continue;
> > +		list->functions[i].traceable = true;
> > +		found = true;
> > +	}
> > +	return found;
> > +}
> 
> This isn't a bug, but mark_traceable_function() has two near-identical blocks
> that walk back to the first alias at a (shndx, value) pair and then loop
> forward over the aliases.  The second differs only by the
> function_contains() test.
> 
> Could the walk back use function_at(list, shndx, list->functions[first].value),
> with one forward loop that takes the containment test as a condition?  Then
> the two copies would not need to be kept in sync.
> 
> Also, this isn't a bug, but is the bool return of mark_traceable_function()
> meant for something, such as a -v count of unmatched ftrace sites?  None of
> its callers in mark_relocated_ftrace_sites() and read_ftrace_site_range()
> read the value, so could it return void and drop 'found'?

Both makes sense, will fix.

> [ ... ]
> 
> > +static bool section_cannot_be_attached(const char *name)
> > +{
> > +	return section_prefix(name, ".init.text") ||
> > +	       section_prefix(name, ".exit.text") ||
> > +	       section_prefix(name, ".noinstr.text") ||
> > +	       section_prefix(name, ".meminit.text") ||
> > +	       section_prefix(name, ".memexit.text") ||
> > +	       section_prefix(name, ".cpuinit.text") ||
> > +	       section_prefix(name, ".cpuexit.text") ||
> > +	       section_prefix(name, ".devinit.text") ||
> > +	       section_prefix(name, ".devexit.text");
> > +}
> 
> This isn't a bug, but are .meminit.text, .memexit.text, .cpuinit.text,
> .cpuexit.text, .devinit.text and .devexit.text still emitted anywhere?
> 
> In include/linux/init.h, __meminit is now either empty or __init, and the
> __cpuinit/__devinit annotations were removed.  Neither vmlinux.lds.h nor
> scripts/module.lds.S places these sections, and modpost lists only
> .init.text and .exit.text as init/exit text.
> 
> If they are gone, could section_cannot_be_attached() be reduced to
> .init.text, .exit.text and .noinstr.text?
> 

Makes sense, will fix. Thanks robot.

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42294987431

