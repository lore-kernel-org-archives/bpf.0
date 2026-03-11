Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627292D8382
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258921; cv=none; b=WY2zNkqlxbTbzgeQDpbPHuqh+DwwC8/6kprLdYV2XK3vI/rFJGv2ryGLyJiFuwDmr1rXLwrAFX7ktX2W6xJtps+GcgDGP5+TXMAq4sk1AR3uaQ72T56KlC4aAshQAJ3zVA6PVraXGCBmvQ9f5RVJ0R50C/LTB/mOm+pbtli7eWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258921; c=relaxed/simple;
	bh=BHDWq/45MfFO5yNQjGCL8oY3k5T9a98VeRuTNFQWstI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jfx4VOUgUwfYaFtionb2NFeT0OFzub2C6b3bxDW8GRdx/BRKyd/z2bB8HG7gDHeC3NRnuwEL1FTcbSPgMeVdHf1BctQGYCnVn60Y9ncCA0Le6FMjwDmak5S/AFNkBt7XYfV8yBKdOzrRYIOvrnN6oRM+cUIyBOMx8OHksqCypnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jnv64jkf; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jnv64jkf"
Message-ID: <2309925c-97dd-4298-bbe3-304a0d35670f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773258917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dfN/GY+17Pl6E+btdR9KfRLibARFQ/OClYBJDY94cU4=;
	b=Jnv64jkfv9Byvmh3YjOeYbOzAc61QhoXsBRv85Ni5uied3NVm16A6Kp/B9wkjzumYYoaaT
	B9wxVDu9WMlcBoEqOuHpYndUDNG/jEwx2cJEarhpiyIsi6CdabQC2J9Ixp3aCVEcD1MVzU
	2uNjyzop/3Gx6LGRkbVfLh9HZ9YmW54=
Date: Wed, 11 Mar 2026 12:55:03 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Release module BTF IDR before module unload
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, ameryhung@gmail.com,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, grbell@redhat.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, song@kernel.org, yonghong.song@linux.dev
References: <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev>
 <20260311130321.1055808-1-memxor@gmail.com>
 <65de5cff-4675-4f56-8e2e-fae68ece4865@linux.dev>
 <CAEf4BzaHWs1hhkhcFJRoza98R+zB8LnhSi4_00SXNgan+rAB0Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAEf4BzaHWs1hhkhcFJRoza98R+zB8LnhSi4_00SXNgan+rAB0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/11/26 12:17 PM, Andrii Nakryiko wrote:
>> For struct_ops prog, the module refcount is not held in prog->aux->mod.
>> I don't think it has to since it is not directly attached to the module.
> 
> If we have something referencing a module, we should probably get and
> keep refcnt on it, no? Why would we have a pointer to a module we
> cannot be sure is still alive when we access it, sounds too
> error-prone to me.

> 
>> For struct_ops map, it attaches the struct_ops prog to the module, so
>> the module refcount is held. It should be fine.

The module count is held but it is held by the struct_ops map. The 
struct_ops prog doesn't use the module and doesn't have a pointer to a 
module after it is loaded.
