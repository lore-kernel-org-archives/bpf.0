Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mw3YMccg"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8E9171C
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 20:39:52 -0800 (PST)
Message-ID: <c456bb34-d3ca-43e2-8728-718eda6b442c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702010390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjrWzXk/m3XscEpRSIbLLG+smAp+5Bs848NK5I6vCWE=;
	b=Mw3YMccgxOa6MBQlVQhpJFLZymYjmiX6rOTtvX1Akg8P80TKP7VWdrfKxu6zvxjHrCL86L
	iZd2q1o3iWn20X8jzkwVdoOEgTORHCyS8oU2sDwR98HXGuYaMKfaJhPQpVv0atg9i+lFxa
	VV+SLF/GLv0qWVuzSlwoqI+vR7jZZMw=
Date: Thu, 7 Dec 2023 20:39:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for
 bpf_cpumask_weight() kfunc
Content-Language: en-GB
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20231207210843.168466-1-void@manifault.com>
 <20231207210843.168466-3-void@manifault.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231207210843.168466-3-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/7/23 1:08 PM, David Vernet wrote:
> The new bpf_cpumask_weight() kfunc can be used to count the number of
> bits that are set in a struct cpumask* kptr. Let's add a selftest to
> verify its behavior.
>
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

