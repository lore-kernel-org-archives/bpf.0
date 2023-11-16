Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DzCdVATe"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B881192
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 19:34:17 -0800 (PST)
Message-ID: <95c2b494-ce8a-422b-918e-8ae4853ab9f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700105656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hfj98r1RUf05ReDEmwIF2LjiRP9glPD+KMKS9nDF6Y=;
	b=DzCdVATezfQ6/FLY6Xis/fjn0jTfNE3hQu4QmbGPYsqE7r/+w2L5JDZOKfJFx5EwtKa2Ts
	1f7IUl/yzPCu8arnh7SYex5MWFoaDV3o/2ea9hkaE6dAD4uly8WEx9p1CK+1fyn1v3LicS
	2UdxZz0IBb3sX0fJRuXCy4t/fY15fu8=
Date: Wed, 15 Nov 2023 22:34:10 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] bpf: bpf_iter_task_next: use __next_thread() rather
 than next_thread()
Content-Language: en-GB
To: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@fb.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20231114163237.GA897@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231114163237.GA897@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> Lockless use of next_thread() should be avoided, kernel/bpf/task_iter.c
> is the last user and the usage is wrong.
>
> bpf_iter_task_next() can loop forever, "kit->pos == kit->task" can never
> happen if kit->pos execs. Change this code to use __next_thread().
>
> With or without this change the usage of kit->pos/task and next_task()
> doesn't look nice, see the next patch.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

