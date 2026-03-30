Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B063B8943;
	Mon, 30 Mar 2026 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774861666; cv=none; b=OeY0eXiLoDx11SVFw+bKRvXvclHuZfduR+kwrGwxD6A/YWN6vkTqUgyO5VBD0fzOXFz2DLT3GiLLh03tHKTlhSjqjgmJ9+M42k6phV8WLh9eVRumI/6SNR/xk0nzI0fN5T4YJmywac2FczWs/5xeWwMiYuEKnc7JGMOrXSjMqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774861666; c=relaxed/simple;
	bh=B6PZfVeG7snpqwW2Dj2BcofsI5G8BWCMHmjYcpSMZ8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KS1Bv7rRHj6k7iLoDTM1BPChwT/EA8nW1MKOpBJAFXKjLGvjP0GZTK5WAEJ8E1vTAYgdWejMp7wedUKlP8H6slki/OI3RpqgPXyHN4nYkLy1o4zYjwd2MxsAlimGN5rcxUPTtIUz5eObJtEGgNZLV3kR/qMqcTJLk+fVK0SkSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wKcebj5x; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wKcebj5x"
Message-ID: <4b0e7341-f2e2-4ad2-8c9e-b482a1b1cbfb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774861662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eedqsRaw3mwJSZ/9l+mCaxc+9OYTIiN/zRg8cpwfdus=;
	b=wKcebj5xfXxM1Fw495xOyB2jzCiJKB9ou6uzKzTaLVi9/bz6ODPm2dfB2gI90j2p/qzLPv
	6BHDPN/DWoFGuFswV1e/BU/ctuwpx5ObQtV/ktCTdan0S29tEqbOFV/B6Eo06i9McyJQB8
	TE4AWlgw0sHXvx7QGwN9qFajMww6L0Y=
Date: Mon, 30 Mar 2026 17:07:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
Content-Language: en-US
To: Takeru Hayasaka <hayatake396@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf <bpf@vger.kernel.org>, X86 ML <x86@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20260327141616.1961457-1-hayatake396@gmail.com>
 <20260327141616.1961457-2-hayatake396@gmail.com>
 <CAADnVQLh76CWYJCJXgOst43FcJOrPP2Y0wcwGPX71QqmiD+7pA@mail.gmail.com>
 <CADFiAcLvdjE7zwqf-hpH01jnbxtnWQNoj4+zBwK0+RU80-k9bg@mail.gmail.com>
 <CAADnVQLR6Y94wKo1G_4w0-xTPdR8ws38oGu3xfHOXxNKcqjyWA@mail.gmail.com>
 <CADFiAcJtjVHYVQeYJ_znVsjiJkEBmLfOafp5srY0HQMGwVtiQQ@mail.gmail.com>
 <CAADnVQ+0EwaJXgS1WSDf12+Ds2Uxbh9KMpDcyq+gyZjcQ_6+dw@mail.gmail.com>
 <CADFiAcJFy-n5Zz+Wj1dWEH0WcK+PhKXi7cbvdsLnPhMXRcVktg@mail.gmail.com>
 <CAADnVQJmqKVZC1gkvAaAmO9V=cnYPO0UYB6Wyp6Shko4tZeUQg@mail.gmail.com>
 <CADFiAcJCrS0wjkPcGU9sCYQukEoegeZG7JMkqhGDYq5C43nfXA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CADFiAcJCrS0wjkPcGU9sCYQukEoegeZG7JMkqhGDYq5C43nfXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28/3/26 00:30, Takeru Hayasaka wrote:
>> see how cilium did it. with pwru tool, etc.
> 
> Thank you for the suggestion.
> As for pwru, I had thought it was not able to capture packet data such as pcap,
> and understood it more as a tool to trace where a specific packet
> enters the processing path and how it is handled.
> 
> For example, in an environment where systems are already
> interconnected and running, I sometimes want to capture the actual
> packets being sent for real processing.
> On the other hand, if the goal is simply to observe processing safely
> in a development environment, I think tools such as ipftrace2 or pwru
> can be very useful.
> 

Sounds like you are developing/maintaining an XDP project.

If so, and the kernel carries the patches in
https://lore.kernel.org/all/20230912150442.2009-1-hffilwlqm@gmail.com/,
recommend modifying the XDP project using dispatcher like libxdp [1].
Then, you are able to trace the subprogs which aim to run tail calls;
meanwhile, you are able to filter packets using pcap-filter, and to
output packets using bpf_xdp_output() helper.

[1]
https://github.com/xdp-project/xdp-tools/blob/main/lib/libxdp/xdp-dispatcher.c.in


Thanks,
Leon

