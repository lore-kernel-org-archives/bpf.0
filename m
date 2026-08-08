Received: from out-178.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FB44052DD
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193273; cv=none; b=SO49d2dXRkP5gQyaSVYs1Hn1aFqaoVzdyJP51QMs063PB9D5p2EcbaNPRA2ErAaqL5/Uzr1tpjQaRk1hyWMZiy3VVHExdj4UK3esmDKgAzqGTDMeZVByqT8UIwinBnWwfSZtOQFWwCttrZf9t1z+twF0UcBsgA6OMD42dk4Qegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193273; c=relaxed/simple;
	bh=0otcCA1DmxNt4rfh2OvMyHoHUt/Zq6czaH///ila2cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aqmlk1VGHsllu5hnoL1s3XEP1NNNbBiKp6ImwIEfHqfRP5hXAvq+gljV/Fcz/gmbVkwgwH9wZmD6wL6TikWwwlCy76rR38ogCjnqJChznkkARhguD4ENqDihjQYaVbnEenr093QJpQnNYxSqjx5KrK9WEitVSYThzbwyDmuoopM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cKKx9MtO; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cKKx9MtO"
Message-ID: <57e4b32a-ec20-4ad3-b8cb-07b42f14855a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786193254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0otcCA1DmxNt4rfh2OvMyHoHUt/Zq6czaH///ila2cI=;
	b=cKKx9MtOZ6KvoSVrav4lp7RPyQKJMkWQ1Cj0u4ejRfeGcXCC+A70CsiNQZId36PwdUE+yc
	C1dy3/UocPbXiWnOJx6PHfdOcryQM3CRvVfpa9ratO+uWgZJ/gB0y06qYaIm50z0BzGvtA
	gGlbBGqZLBo2evdZyDAYPh7v0nu/bAA=
Date: Sat, 8 Aug 2026 20:47:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/5] selftests/bpf: Add ksock kfunc test
To: Mahe Tardy <mahe.tardy@gmail.com>, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
 liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
 ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-4-mahe.tardy@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260807171532.125149-4-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/8/26 1:15 AM, Mahe Tardy wrote:
> Add a selftest that exercises the ksock kfuncs end-to-end. One syscall
> bpf setup program creates a ksock context and connects the socket.
> Another LSM sleepable bpf program looks up the context and send test
> data. The userspace harness creates a network namespace and a new socket
> on loopback, run the setup and send syscall bpf progs then check that
> the userspace socket received the data from bpf.
>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

