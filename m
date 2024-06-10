Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E986FC7
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 05:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998267; cv=none; b=KNVc54y9MuU5DSDtPtoRqY79sjh6p7TtHeyGZZ4yfO5BM3tt6oYuTn17UHCQPPnvagFFRC0DpbaxrGxAjhz+hZTM5Na5UoTqCuuES5amYDYTzOIwKRaPuFNQ9oVGJd3FYatdvYdgwD1eHTgruvXes6lZlgyZBqy0/r8ffUzZ0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998267; c=relaxed/simple;
	bh=KDTL3aKkV2gikhJOD5Lxd+1HBtvlwfgQXdXV9ru+d0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mz2Og8qAmtgmUo2ZDEYG6dSYE+7UeEKOu4ViJDgG2lrSwabkCYmmr3FLKiUo9lfn6arzw1xzFm7ZkW1KAIi0SEmN+DUVVvHb2P9yVZXVwHDGhB4s1A4vCVLY+7+WsxcuCC1dqCg7wdek9siPnZZ6NuXD1AsUoz/ee4wE6+jRZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fP7XxXN5; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fP7XxXN5"
X-Envelope-To: alexei.starovoitov@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717998263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDTL3aKkV2gikhJOD5Lxd+1HBtvlwfgQXdXV9ru+d0Q=;
	b=fP7XxXN5U4PqYkMTC21RtsrhCA1mcNgM3Lk/Dl7b/5r3wnWw2FjMvN3PWAQQ4Y7+L7E7Bq
	r4EQHktnnmXHyjpSd7h6jTUeOvf8obxICbNI6I0h4T88oIfI0yx0ySvTaN/WoS4Q5KR+MF
	tP/Cp7TeKqcU0lplBkKYZzcyYf0B7do=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: martin.lau@kernel.org
X-Envelope-To: memxor@gmail.com
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: kernel-team@fb.com
Message-ID: <8159281b-6e98-4ae2-a1d6-2957f5956ba9@linux.dev>
Date: Sun, 9 Jun 2024 22:44:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/4] bpf: Support can_loop/cond_break on big
 endian
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 memxor@gmail.com, eddyz87@gmail.com, kernel-team@fb.com
References: <20240608004446.54199-1-alexei.starovoitov@gmail.com>
 <20240608004446.54199-4-alexei.starovoitov@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240608004446.54199-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/7/24 5:44 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add big endian support for can_loop/cond_break macros.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

