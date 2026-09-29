Received: from mta0.migadu.com (out-119.mta0.migadu.com [91.218.175.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AEF3E5EEA
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700030; cv=none; b=gYEa+Rbc3+utLahvQ/IlhDU8oj8iTuziAbcILlWzzYHJlDIqhJeVsf9tNVVZVTmLymdijnSAdYJM4fa+ISjjrGkVVjrHnJliAntYC6CB+uxFIsdaJ1vMqtVFDC2XOyKrEMx+N7ycqfjIpGSJI2ltUlJkeSOJRTjv3QQaFS8rvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700030; c=relaxed/simple;
	bh=b0wtkCumHj47AlqzSYju7wocOXpo4eeAEpqH4JBRcpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taH9Be/X5RbFu283g9Fm3UjsQN31B+CGsuKrPRDlcNI7QvVLi+Oju4qJa++PYuzFBNbIga3tosmIhj7VpPIuGsay1Twov2jd53kIxNaMRLNNUZcjJ95dY9u/xdiuqONrtiEHKs3RX77GsAE+1QBZT7+trTGr1KHJNIFrM1bSaVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sOZSXejp; arc=none smtp.client-ip=91.218.175.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sOZSXejp"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b0wtkCumHj47AlqzSYju7wocOXpo4eeAEpqH4JBRcpk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790700024; v=1; x=1791304824;
 b=sOZSXejp/UaD8bd2mDEnjz8TzVWLFjQw9SMhdCnVP/QYhHC1SBmlgfHJ4lUSroMUmjZ1TNYX
 kxBR0rr1ezReTuPfJcp3Xe+j/asWis/aW01cnW8pvcAj2cgGI54R4wFYlHVShUDgcykwQpDeT70
 slkZsP4hhBEfE/ovv6Hl2n8s=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b7ed18462f7d8b4f;
	Tue, 29 Sep 2026 16:40:22 +0000
X-Mizu-Trace-ID: b7ed18462f7d8b4f
X-Migadu-Flow: FLOW_OUT
Message-ID: <e1594fd1-0fd6-46ce-b111-7bc731b3d0bc@linux.dev>
Date: Tue, 29 Sep 2026 09:40:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 00/17] bpf: Indirect calls of bpf subprogs
 (callx)
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 patchwork-bot+netdevbpf@kernel.org
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, Emil Tsalapatis <emil@etsalapatis.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
 <179022901639.1337807.12766583921039284951.git-patchwork-notify@kernel.org>
 <a25b9150-55ba-41ef-8de9-0067b4576278@linux.dev>
 <DLRKNUWD51KM.3URQDVOWL0BRY@gmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DLRKNUWD51KM.3URQDVOWL0BRY@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-09-28 11:04 p.m., Alexei Starovoitov wrote:
> On Mon, Sep 28, 2026 at 04:13 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>> We're testing clang 21->22 bump on BPF CI, and something is broken
>> when compiling callx selftests:
>>
>> 2026-09-28T22:12:12.4226025Z error: Undefined temporary symbol
>> .Lswitch.table.call_by_switch
> 
> That's a bug in llvm 22. Not related to callx.
> With -mcpu=v4 BPFAsmPrinter::doFinalization() is supposed to remove
> private arrays of blockaddress that were converted to gotox jump tables,
> but it removes all private const arrays of pointers.
> clang turns the switch in call_by_switch() into such array of
> pointers to functions.
> Yonghong fixed it in llvm 23:
> commit 9fc458a1d95b ("[BPF] Fix erroneous removal of non-jump-table globals")
> It landed after 22.1.8, so no release of 22 has it.

I see, thanks.

> 
>> What's the requirements for callx? Does it need bleeding edge clang?
>> If so, let's explicitly skip relevant selftests for clang < N?
> 
> No. clang generates callx for years. clang 21 is fine and 22 is fine
> with v2 and v3.
> 
> I'd bump CI to clang 23.
> 
> A bunch of other tests require __clang_major__ >= 23 already.

Even if we bump our CI to 23, I don't think we want the default
selftests build to remain broken with 22 due to a compiler bug.

I'll see if we can gracefully handle the bug there.

