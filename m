Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096C3806C0
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068894; cv=none; b=HWUems+S6/Cf8Kir+Znb4+hkske+qwxw1W6yFbaFR8w+4ruIDsC5z9g+RjdF8+XOIDBx1MvT8kLTpZK9XQ/Uo0dN12FmXtkHwZ8w0mKGxrXt1YRs+wz5S9G6FckzjJ+6lqhxFf22tLkADawx9q3WL+1Lgv9zf6yiOzlfDmY5yX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068894; c=relaxed/simple;
	bh=7A9ZpEZbKk2iiD92RLl5Lh5AkPl+6qKepwJ6WWb4ID4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQUhy1g2bcUY+SkKMwpliX/1rPW9uGd6g2B8s6yerI5HyKswlsXna3mpRzc2fTn4Du4c6WWt05DjDIGNzj2yuCsI8Z2/ziaFCboPC2xnb9g/MR975TfeBtAPPYkIRZYWGxfBpEpHeiQLfPGhNGd4PwmK9EzXYe8L5ibsTdwmR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrGnSica; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrGnSica"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so2977830f8f.0
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 01:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776068892; x=1776673692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Klu0nNo90giPUx0v6OjxXyfb9Qq9VeAPH6GNB3XZETI=;
        b=QrGnSicaxNe/xmEI02N9CRIZpO7eKgPVYOSXiC1cCSuHyYrbjhhxEHTNEA9GPwoeKd
         Fi4cEb7ZWpfMRE/xWP9hgxWUcIg8T3iGndQ1VR1K98tfnfZ+6VBPEJRI/PruWa61qDIL
         PNOY0Cjo50z1YG2dS3BDJ18cJj4ug4cHENL7+fvZ/8O3k7tvUD7cqNbo/9UUnla+AdtL
         n36Mg/geeZBtKZayHdz880dn5+kg/EIz9sGCN6DHybP6VEa1MO7r+3aiy4uh8Vj57fw/
         WKFKdqqB91jNUzqF075zP/VhU14VLtnewS5u48loWpojW6FVKuDW6aL/uYmrcC3+Az+B
         DltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776068892; x=1776673692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Klu0nNo90giPUx0v6OjxXyfb9Qq9VeAPH6GNB3XZETI=;
        b=B7nOezUknwrWuW3Z1JTFNj9fbI5cXxmw6AmhhL3IRbma/FseKkiy8km3f527vEw4+r
         ExM5P8ys/2wy7qCNCeUO3syeq0+L814OWaHpcsI7OQpsjeJY15f3l1mGfv4ydaeyaDLo
         p2BMyXe6qvelyDM3LAXIlPVYfvsjplNgkC6vTd/TS0OxiNSfj5DLtFkJMmL9s4unscUJ
         tz08miz9vtzR7Jr0RNNr+tEWpWa55FxqxWl6sqeXK/MmOwgny1gQGjR5beXgRQYrZX98
         lQsldl/R72jQP/T/PT26cMO7CGeWfn1BROwk12yqht3uJSkKvlJe0Nrs25WISRu2MfEw
         m8Qw==
X-Gm-Message-State: AOJu0YyBNMfoOwLk8AsI/BcNm+yRUfYlhx2gU1S76J9d9m4PL60U/gMh
	51JW4FyIDhqXVBJxii1EcaN40nZtW1fICK8p2nePtIvvlie44XM/vsvz
X-Gm-Gg: AeBDievk1u2UblBQ4iQsyOzzkFEAkx6GH7ugI3Yv++7poS5p1xqQV9rW7X2nQEDQKz7
	RE9mOE/piOxhMjqiRSvrTA4DvcFvpYDAi9wa0002RgahqtYo2NpKLjErUs14i4NPa7rhi1uQ0mn
	rQblCg9Equ/iLV9CL2x1WCjmqc1WrA1OGqAIt4bMMoWmI5kq2mv9MRalB6mEeTLhFyZZNKt4wzZ
	hDN/l7lwRzQdVA6iXijq3HU70kn9fz5BGqQX7DLiLz0i90Ji6KL/01t6HVvu8mJ1zTkfdVf06co
	j0tRLTLEiPDWQqigdSu8AwbIBNBgTEC6q+sdIzwDRkzonPSBk8LKTm+8P4bQ7RZIzVD16Q4KsXS
	TbLH2EbV0JN9i451u0WEn77HvRK7KjaEfMDUrguUHxzV9T74w1t1u5g8kMCd49Trm8YzK56Ad8W
	pmOqTayOgKBVtd0qXr1AhbX/nTdwps3KUJ0QSmzBQmLmNDVuOQ4RtT+13QRyOJt2tgC04uV/Q6M
	wOS6svM2xM=
X-Received: by 2002:a05:6000:25c8:b0:43d:7dcf:ae26 with SMTP id ffacd0b85a97d-43d7dcfb1f9mr17729f8f.34.1776068890889;
        Mon, 13 Apr 2026 01:28:10 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:1086:f5f1:32fc:93b3? ([2a02:8109:a307:d900:1086:f5f1:32fc:93b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm31752357f8f.24.2026.04.13.01.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 01:28:10 -0700 (PDT)
Message-ID: <d1a95002-84f5-41f2-9178-f212c653840f@gmail.com>
Date: Mon, 13 Apr 2026 09:28:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 00/18] bpf: Introduce resizable hash map
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <CAADnVQ+nBB9a-5fR=b1Ty-N=LUnc1gmEZ_R2z8mSNZzaZC23pQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQ+nBB9a-5fR=b1Ty-N=LUnc1gmEZ_R2z8mSNZzaZC23pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/13/26 12:11 AM, Alexei Starovoitov wrote:
> On Wed, Apr 8, 2026 at 8:10 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> Benchmarks and s390 tests depend on the
>> https://lore.kernel.org/linux-crypto/20260224192954.819444-1-mykyta.yatsenko5@gmail.com/
> 
> Is it going into this merge window?
> 

It should, the patch has been applied to linux-crypto on 7-Mar. I 
realized it also fixes a bug only after that, so no fixes tag on the patch.

> Please include all perf numbers right in the cover letter.

