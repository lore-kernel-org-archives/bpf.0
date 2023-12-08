Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E42pjds6"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96CD54
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 20:37:52 -0800 (PST)
Message-ID: <39853044-6139-41ab-87b4-0d9972722226@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702010270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EVVGC+pDfqN5MkCHTiCHQ6KtlU1POIkUDJH86yPwMsc=;
	b=E42pjds6jfU/duIckTqDd50zy5v/m8aousSLjjx+BL+ef+wYtfXQP5PoSY7D/hwQ7ysAJo
	TlRJTpJ6HHlQCAaCJlrnQ39gLfQrVMoK4OfN9fnoJeKnCZshZcHjYWS/1Zhc9fuItpSX10
	nmBJryGomnVzTI896UMqHSMaj8jc6yw=
Date: Thu, 7 Dec 2023 20:37:40 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_cpumask_weight() kfunc
Content-Language: en-GB
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20231207210843.168466-1-void@manifault.com>
 <20231207210843.168466-2-void@manifault.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231207210843.168466-2-void@manifault.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/7/23 1:08 PM, David Vernet wrote:
> It can be useful to query how many bits are set in a cpumask. For
> example, if you want to perform special logic for the last remaining
> core that's set in a mask. Let's therefore add a new
> bpf_cpumask_weight() kfunc which checks how many bits are set in a mask.
>
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

