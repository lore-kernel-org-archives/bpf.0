Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2626F46F
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775413788; cv=none; b=D42I7IG7kMrG1py77RKUeLFuQNvTuX5+VK8C7uW9bIdaSSpLU7H2IRU2iyBKUxurkt0uZYX+EAx1/SCUWAmyXMn6erGigHwt6mii9RGgbkTuZdnkor25JSmfOb827rpa28KKerWYnfGWrJm7NDlC8rLEqRrD0C2wWWjDkqtOBGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775413788; c=relaxed/simple;
	bh=oAnv6ayjlBqwCrBysV75Y//wW0T2tMpCu9+isu7+q68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHoFUK0pUQqawu4HZVZZrikvbf8+4nZREnFwGH2NdBoE6jZ7FERLj4/rKZlIfx0Rd8jvUqHvFKNzCwRMspwKgrPwdbWnNq3mCDkNFVyv1Q/ysgtL87liuJCsUTlCkQBwqBk8lD41RvMIdUZLLxL/Qm8PtmXE7yAqvJg+exWXDz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aA/lRCgR; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aA/lRCgR"
Message-ID: <230953f5-f64d-4f58-ad2e-f3ea9358aff0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775413784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LAexB/abfOf7YIEn7wchzPj5V35CrSOHhVRfPpRfnE=;
	b=aA/lRCgRM+4nGS734YKIG0K89iPk2KlUcIUwTN30U14X1/lRibaZfGjPeNXj/gTRIuTL0N
	QoY8xl++mmH43CUR758Gmop5fdQqecc6XmCuQNLI1p4Ta/OPj6B95/BhRDlqSQzisfepf3
	D6oLbEBhD7bJhTsweae2Uc/2zFTYgFo=
Date: Sun, 5 Apr 2026 11:29:22 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpf() system call writes out of bounds of user supplied buffer
Content-Language: en-GB
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Jesper Dangaard Brouer <brouer@redhat.com>,
 KP Singh <kpsingh@google.com>, Neill Kapron <nkapron@google.com>,
 Carlos Llamas <cmllamas@google.com>, Eric Dumazet <edumazet@google.com>
References: <CANP3RGcL+LFNBk-+9Z5W+8Nyj1+rxCkgR=EiQiLdHW22dSKvgg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CANP3RGcL+LFNBk-+9Z5W+8Nyj1+rxCkgR=EiQiLdHW22dSKvgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/3/26 4:22 PM, Maciej Żenczykowski wrote:
> Took a *while* to track this down, as it then results in random
> memory/heap/stack corruption and segfaults, but:
>
> kernel/bpf/cgroup.c -- __cgroup_bpf_query()
>
>         if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
>
> doesn't verify this is in bounds of the uattr + length passed in from userspace.

If the uattr indeed has less than needed space, then for
         if (copy_to_user(&uattr->query.revision, &revision, sizeof(revision)))
                 return -EFAULT;
the kernel will return -EFAULT to user space.

Maybe userspace didn't handle the return code properly and causing
user space corruption and segfaults. This shouldn't be a kernel issue.
Maybe I missed something?

>
> I *think* there's likely lots of other such copy_to_user() problems,
> but this is the one that bit us on upgrade from 6.16 to 6.17
>
> It was added in:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/bpf/cgroup.c?h=1209339844601ec1766f4ff430673fbcfe42bb51
> bpf: Implement mprog API on top of existing cgroup progs
>
> But it seems to be just generically bad style...

