Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720DD368D5E
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309184; cv=none; b=MhCSwvKprNjgZPM53HHHAvk9ECkS19R+Q1y412zuq4AsTjAMorJXriSohVsZt9SyyYvwLDGt2jtGmJ8EWMDuUkDJUTppjIcQqc3r60BOzCdP8gJ9IvBxc9rU6qhZFeN/mz4yiNjSTgbDWHQbWgQan1EgMpnF73Dr8pxBXJBXiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309184; c=relaxed/simple;
	bh=zkgzcPiM97rc0S6TjcXijaCroXS3ki3QLJ2F7L4B3OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPbm376P+Z8KcR9SOe1vevy+/nMPkEoF7qm0GNyW8cfWrkuSWzFo2wFFGC0IbdTdS0Py38vbiViBbttGgZlEkVSKw2MROE7noIBsEfHUiKOoYAWkNS9CzHejByM8MbuJqmKiCbYxU91jb55PP3RdXL7iT9zsqNwZJJJ+mBSqTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CFqzbUvc; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CFqzbUvc"
Message-ID: <d520bda3-4eca-4ea6-b423-990935a0d3c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782309180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/9pZJlHpMdXgadRpz+8VRUR/QVFe1YS13n2B65x7Qc=;
	b=CFqzbUvcgf6rD+0uLkTBOTlrbupg70NmWia/ySyd0lJb8UY2sRuYyr1Fjd8CtVYJniv09V
	eSWZ/p01MccP8v1cbSahz/xz2z3YzLEoqTuPSrvJF+vnOh0OC32nQYtc6q525jSRj+sEVf
	Lh+rdLEPtZLienXKyCyK8ylVRYl7Afs=
Date: Wed, 24 Jun 2026 06:52:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves v7 0/5] pahole: Encode true signatures in kernel
 BTF
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, kernel-team@fb.com
References: <20260623040704.2732530-1-yonghong.song@linux.dev>
 <ajp70MRjHvCJNeyv@krava> <d270a215-264f-4c5c-9d7f-0b1568815e31@oracle.com>
 <b1b73cef-f25a-443d-8557-4cfe92938b46@oracle.com> <ajujJM9N0_QpB_3d@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ajujJM9N0_QpB_3d@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/24/26 2:28 AM, Jiri Olsa wrote:
> On Tue, Jun 23, 2026 at 05:02:30PM +0100, Alan Maguire wrote:
>
> SNIP
>
>>>> hi,
>>>> I tried to get the numbers from my setup and noticed that some new
>>>> functions were included in BTF compared to the current version
>>>> (functions diff attached below)
>>>>
>>>> like for "arp_process" function the current pahole gives me:
>>>>
>>>>    arp_process : skipping BTF encoding of function due to unexpected register usage for parameter
>>>>
>>>> but it's included in BTF generated with the new pahole.
>>>>
>>>> in addition to your explanation above also one of the commit says:
>>>>
>>>>       - a parameter with no location, a constant value, or (for non-clang) no
>>>>         register found is marked optimized out
>>>>
>>>> please check below, it seems like 2nd argument of arp_process has no location,
>>>> so iiuc it should not be included in BTF, right?
>>>>
>>>> thanks,
>>>> jirka
>>>>
>>>>
>>> thanks for catching this; it looks like we return a bit early before detecting
>>> missing locations in the non-true-signature code. If you get a chance, would you
>>> mind trying the attached patch to see if it fixes the problem?
>>>
>>> If the fix works and Yonghong is happy with it we can add it as a followup
>>> and land the true signature series to save another round.
>> actually sorry that patch leaked true signature partial names for gcc; updated
>> patch attached.
> hum, I can't apply either of them, but I see that change on top of:
>    alan-maguire/dwarves-true-sig-v7
>
> but on that branch I can still see arp_process function in the btf
>
> please let me know if I should try some other branch

Jiri,

Please take a look at v9: https://lore.kernel.org/bpf/20260624052553.3139112-1-yonghong.song@linux.dev/

It has version 7 plus Alan's changes in version 7 comments. I forther added a
few changes related to llvm and another patch to resolve some inconsistency.

Thanks!

Yonghong

>
> thanks,
> jirka

