Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524371;
	b=aluxemEa4uvWu9LNiqm0l9sLFx0Gk2VtdNdRhFkkN0CEuNDaOG1gnvv/afG0IGWWAQFj
	 KjyK8vyHln4EeU3Ovlwu/6kT2CVCJpfSyTI0OiqalhSTcO57HmJWIdBWB3gmEyggi9W1D
	 p/e1eNfNhruVzWKB1oCgLEg0Dtl/mZbMf+jms2yLA046j+hN57Tu3Fl16ufNZLsxLEcj6
	 bopqikTS/aMfFtcmJEONhr+bqCMD6KeFIayum8RDIHpv2n3oCqKwCBm4JE9CyUIJ4bCQ+
	 yPbEqbOkLiDK4O/4oT3xRtAJFvHIwCd4iNQpCNfBf740eK2gXwL2YG77uBpNAqFlX6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6trqBoJ56xYgdQud8NXsoRNtJ3zJM5ETuqiuCBryNlo=;
	b=R4s06krsoEB9DFp8SVXwBn6/kJfrEgVmu4mIjeghQn4lyvu1sPE+i1zlX2XSDyViAAFT
	 aoS/lAFM+ny3bGZY91oMSLEZR67mWfCRB5r0oTjYpYL8AiFCai/9I/XFf6L22see0yW80
	 eaCPVEjEvNI9+GpqXlvBDoRmOrjVjWOBsYSsqFnvitvrnGdCuSZJmH3RNJ3zo68WJ85yf
	 JF3xIqcaJf4tjftsqQyiEHafIv9DL67Q7JhVO+cHgYQpXDLEF8xRmFx43AD25lYCAJ8ks
	 OFqeI+DWQk4Ugh14Hvv1cumoNJVKQPFWn/skruqVHbyWJQe+93dKLmQCNqbpzhD01VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZTCQ8S3;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D9606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 12:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F8D9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZTCQ8S3
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb85e07aadso54294365e9.1
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795524369; x=1796129169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6trqBoJ56xYgdQud8NXsoRNtJ3zJM5ETuqiuCBryNlo=;
        b=zZTCQ8S3hZBne4ZjiN3l9wL6060OrIV3qZe+AteLMqg9NmV5kpF+3toueCXf+niT7H
         esihTRf+h4WqwNs2NKdOZMFGtxPezWvo2/vW6d7r77x2y0da1DSt+yP6uqAEpEEVYrDd
         3WLj7WocdNHYy8lAAy0+feX5prmtlouqKwjZ7BCoOJtUe15evZg4etx4xXOVWvQc7M3m
         iMO9qtDfjBblhgziCAtvMOyTgayCwWpLsVD+KMffqV4Tm4peBMtuL3TkOwYVNkyOpc6y
         F5hkpCMEhSBoPe3buwdIydZ+/FP1vHrABvTvH82yHnZMDe83gtAYE6UfXRwSU1a1FhrC
         T4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795524369; x=1796129169;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6trqBoJ56xYgdQud8NXsoRNtJ3zJM5ETuqiuCBryNlo=;
        b=H6IGhOg5V9juDsXgHJnLvmfn+ctvVDF/PYVMV/VP0dMfCw6calTxhoHkHf1zHWbqMw
         XLofEzPOWKCgzapLiihebXMgjXyEhWeXQ13E4vmjlnox/MC99N7WWgHFxzFxm3GkIX4A
         p9WedOzkzo+vfs5Hn67bAQ65SyaryPlF82QVuH+lzLoDwby0f6nx1GsoTOT2UbD7PRlu
         p868ZGd26PX3OcRnca+IVA2fZbi1INZ3w0Ks9W06ou/OSkwhR2TFxEaGGHNot+PEJ6Qx
         G6mBUZgm9qSBd2OrJse89MN+28ig09R6yqY2k8fPqF1v0sRcfvPnrifxPMoxRbAtH97J
         PYig==
X-Forwarded-Encrypted: i=1; AL+hErENwXxxWQL6jol6PcBYWyEQvU46lE079fcwMVtOBSc4jgKLGzZtGpQP1gyRw57TodBpBT8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Renxv2FC9qZ7/RUmtJ4wxk6xYHQyzlI1558MQRttAm5egk4yg
	U72ijd1TEGzfWWXteQHNIv3l2AaGm3Csc17wHwNKcrdDqcyJvLUgXWvv
X-Gm-Gg: AZFdTZdQCAUhOcM5Xe6VxBsV+XyWSo8XgSL26l3HgItpcGQWoQikRMVomCs5toxWm+x
	MFPXXxnlpsgSdBgsHPRqv2XgLZrXejlXoc7lRBa0AAgygB/d0Ewmso3IyoUALqnoqFoQyEV0D1k
	LO9l3kU5j/7ZR/FyxpTkeDAp1usU198qCNtX2mk9pAW1JlgR3bKX8L/bU8nSVGN/WYQltW6r5rV
	IvgyKuTif9hJAXtXjvW+h6ECtKE7RrLSQraG2zJXHXJJKse+Q8QpXqPLEeuafOcW0WTTjCa0QSX
	oSOgSzwVLI++duPjkIkVjIS3DMie690+Wb+6tnYSV9IIUSoIRxssVHwAN3diwXlvaTyO7ubSxCh
	CyIv18rkF79g7LHzzq/rgD7/Bm1W+AEZHf5coLzgeKbLjAzfYUajYxreqronVGBlz+ZnP/unOGi
	VisYfGumsB3SS9tZr+DLptUf0lQXgB3Qj/9gQKA/lYu8Z2TbvRda7fsOowhTajkPqV0hIqYTCkT
	TB2c3rpwGwi4L3DglOfBa2xNe4ji1voj1Sdxf/6Mr0hb08lgNg8NqJjZq0pxz1di7ky83722uVi
	Zj2ZBO729bJqRbvzgWQKjZXgT4+uZ0JYif/ayNOKJckCsna9UEN4D8H5QN6aMSHoBkGKy6D3o1x
	pf2lS+6T8dLY=
X-Received: by 2002:a05:600c:848d:b0:4bb:6687:5386 with SMTP id 5b1f17b1804b1-4bb8880c7f1mr314677025e9.19.1795524368698;
        Tue, 24 Nov 2026 04:46:08 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:f439:1824:d72d:b195? ([2620:10d:c092:500::4:5f10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm595020245e9.13.2026.11.24.04.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 04:46:08 -0800 (PST)
Message-ID: <77c60169-13c4-40f9-9657-2f6ac67379ff@gmail.com>
Date: Tue, 24 Nov 2026 12:46:07 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] libbpf: bpf_program__clone() uses a stale module BTF fd
 after object load
To: =?UTF-8?B?5rSb?= <wanghai8081@gmail.com>, bpf@vger.kernel.org
References: <CAPig4syGNH7_LGZrHyQismhLZ9zanbDAAkwjcWtiFcWfpB6v0g@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAPig4syGNH7_LGZrHyQismhLZ9zanbDAAkwjcWtiFcWfpB6v0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/24/26 9:08 AM, 洛 wrote:
> Hi,
> 
> Urein (2581269643@qq.com) and I ran into a problem with
> bpf_program__clone() when cloning an fentry program targeting a
> kernel module. The clone works after bpf_object__prepare(), but
> fails if we call bpf_object__load() first, even though the object
> loads successfully.
> 
> Environment:
>   libbpf: 4f05fb027a08a8a66d03916cf6a68a91e2c720ea
>   Kernel: 6.8.0-149-generic, x86_64
> 
> We also reproduced this with libbpf v1.8.0.
> 
> The BPF program is:
> 
>   #define SEC(name) __attribute__((section(name), used))
> 
>   char LICENSE[] SEC("license") = "GPL";
> 
>   SEC("fentry/ip_tables:ipt_do_table")
>   int clone_target(void *ctx)
>   {
>       return 0;
>   }
> 
> After opening the object, we prepare it and call bpf_program__clone()
> on clone_target. This works:
> 
>   bpf_object__prepare(): 0
>   bpf_program__clone(): 77 (ok)
> 
> Calling bpf_object__load() between those two calls gives:
> 
>   bpf_object__prepare(): 0
>   bpf_object__load(): 0
>   bpf_program__clone(): -22 (Invalid argument)
> 

The usecase we targeted for clone was to make it possible to load a
single program from the object without loading the full object.
I don't think we intended it to work after bpf_object__load().
Do you have a concrete production usecase for bpf_program__clone()
where you need to clone a program after object is loaded?
Did you try to use program load strategies?
https://lore.kernel.org/bpf/20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com/
In veristat we switched to load strategies from bpf_program__clone(),
perhaps it could work for you too.

> Looking at the code, the initial program load caches the module BTF
> fd and type ID in prog->attach_btf_obj_fd and prog->attach_btf_id.
> At the end of object loading, bpf_object_cleanup_btf() closes the
> module BTF fd, but the cached fd number remains in the program.
> 
> The subsequent clone copies those cached values into its load
> options. Since attach_btf_id is already set,
> libbpf_prepare_prog_load() skips target resolution, leaving the
> clone to use the closed fd.
> 
> We checked this by opening a fresh BTF fd for ip_tables and passing
> it through opts.attach_btf_obj_fd. Cloning after object load then
> succeeds. Adding an unrelated MANUAL program to the object also
> makes it succeed, because has_manual_progs defers BTF cleanup.
> 
> We also tried reusing the closed fd number. After filling the free
> fd slots with BTF fds for x_tables, the clone loaded successfully
> with the original type ID. On this kernel, that ID refers to
> ipt_do_table in ip_tables, but xt_compat_match_to_user in x_tables.
> 
> We haven't attached or triggered that clone; this observation is
> based on the load result and the corresponding BTF entries.
> 
> The clone API documentation requires a prepared object, so we would
> expect cloning to work after a successful object load too.
> 
> Would keeping the module BTF fds open until object close be a
> reasonable fix? Alternatively, cleanup could invalidate the cached
> attach information so the next clone resolves the target again.
> 
> We're happy to send a fix and a regression test. Please let us know
> which approach you'd prefer.
> 
> Thanks,
> 洛
> Urein

