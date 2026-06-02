Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DA1CAA65
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780371085; cv=none; b=TmW5yZsdIDsEuPVjlNQ/soyH+nDETXW3XUtV7hN0kuSbJSt9R9B0vARs3KE7PiZFC6Sv0p8+dseu2Xy7jJATbScTVmyQbYgaFa+Jw4Kn4myEbLdWG5hygCL8/9MW/YA8jRbsGi/ehoIEmgEKc10M+NsGQIP8/2fxzT3o613QUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780371085; c=relaxed/simple;
	bh=cFYh/v+iZPRRLSnWvnURhHY04Yl25CMeUZW2Zz4RvZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHMZk8XQJMFnj/YTjXqnqC7p/rIYOH+xOlP40aFjpFi7F9aOpIUZ4cinFw3+806M7eiMg/7un+hnZ1/xb33J05O0iPdNvIXjhNNdz74o/6soG1E4OrR7N6lyq9mrtLePdKGY99tIJiXhimF/29tAVkZtX8qPqp5VUZqEURtCiQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=soVy4sz1; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="soVy4sz1"
Message-ID: <ac9096c9-dee7-4bb0-9741-6758fc278a48@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780371071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFYh/v+iZPRRLSnWvnURhHY04Yl25CMeUZW2Zz4RvZk=;
	b=soVy4sz1+iTds4/Pt2yhWxp/0iqx7xqxTYPv9X43/W4p9cOsjcUlFANETjFZ95jVNU/sfd
	2RxKm4kB0sxIhuK2NpSunnP3xU1ldLZ6GhRo5XiWxe40ugvMyM49G3gz8g5C7SxEggUcbD
	mfZqnx85lDxIPNzVWgcUrcrS18BWdIw=
Date: Mon, 1 Jun 2026 20:31:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Tighten cgroup storage cookie checks for prog arrays
Content-Language: en-GB
To: "malin (R)" <malin89@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, cenxianlong
 <cenxianlong@huawei.com>, Chenzhe <chenzhe@huawei.com>,
 "ameryhung@gmail.com" <ameryhung@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, YiFei Zhu <zhuyifei@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <b160365f172b48f395e7edb7e1f879b9@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b160365f172b48f395e7edb7e1f879b9@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/1/26 6:51 PM, malin (R) wrote:
> Hello Yonghong,
>
>> The patch looks okay to me. But can you add a selftest for this?
> OK, we will send v2 patch with added selftest.
>
> By the way, as the AI review bot found, this patch idea is already proposed by Amery.
> https://lore.kernel.org/bpf/20251203195050.3215728-1-ameryhung@gmail.com/
>
> Should I add something like Suggested-by for him or something else?

Change 'him' to 'her'.

I think you can mention this in commit message.

>
> Thanks
> Lin

