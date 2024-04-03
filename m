Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563713FE2E
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 03:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712116764; cv=none; b=PNIwwMscLN84wAsKw7qtGZ1T21PwMGAlka1hXWe43yZ7bgn9RT4/i4S6WteahV5mqr8h2TPy2swWXdvGVYRCkLuaQVIsJOgLufPk9PFyP/81LD74eG1VbbX+vo/k7yUUdumlTWwy0Mx/YdIWT2EwNJajZtmnpUmfDIpyy4rGOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712116764; c=relaxed/simple;
	bh=F4+Sg28rLD4dddq8PCOLJyguSpotNbjvEH897YBL8uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlDy9YPGD5qtEP/+3PUbkpYGGa6kLvAGijilxrxm90Ig6zCGdup3284YBhUSTWbMlYA+kM9jp4fAQouh3ALiAeGswoRZJJRpHa3KM9XLVLmetUl2nMXkIWYNnYnemwYE/7RJigBl2tQ9IkpBRb0PNHOCdd4c9rc6PdoMgGyAzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DYocQscY; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DYocQscY"
Message-ID: <02d29315-13ee-45c1-984e-13c98e88247b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712116761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4+Sg28rLD4dddq8PCOLJyguSpotNbjvEH897YBL8uM=;
	b=DYocQscYzrpszaBpRxEF4Fi4EaJPuxRGhiEoTyxA5roakT4BEyoSWtzKg9B88SPrG5PWXI
	ralqMy4jiGZmunp6uYqAG5gOuVDwErS0J+c8YsloGXZqvp5ypwLpwdVHTSVidM7w/D1KIw
	BZYrbskEWSDibawJ7bWs+YvgQ2kgzhs=
Date: Tue, 2 Apr 2024 20:59:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in trie_delete_elem
Content-Language: en-GB
To: Aleksandr Nogikh <nogikh@google.com>,
 Alexander Potapenko <glider@google.com>
Cc: syzbot <syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
 song@kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000f9ce6d061494e694@google.com>
 <2ee098ec-a46f-44fa-8719-049331c4c206@linux.dev>
 <CANp29Y4WcXr7vd=cvdtxRWaPxOKzr97f9L+BXtm07AGGiW2j2A@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CANp29Y4WcXr7vd=cvdtxRWaPxOKzr97f9L+BXtm07AGGiW2j2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/1/24 11:36 PM, Aleksandr Nogikh wrote:
> Hi,
>
> On Mon, Apr 1, 2024 at 8:55 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 3/26/24 12:00 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> =====================================================
>>> BUG: KMSAN: uninit-value in trie_delete_elem+0xc0/0xbe0 kernel/bpf/lpm_trie.c:448
>> Unrelated to the bug itself, with KMSAN is enabled, qemu cannot boot my vm
>> any more. Anything special I need to do in order to boot a KMSAN kernel?
>>
> Does the kernel print any specific errors to the serial console while
> booting? Or nothing at all?

In my case, nothing at all.

>
