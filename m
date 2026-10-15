Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229DA1BC08F
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093164; cv=none; b=Vp0Hp0aIDL0ZQpID48NW4shbe5pob1zCDGijmseBT2I5LemIVvgjKqGxLc/VhNzRmjfVzCI592xZNgKF7NhXAMztNb5izvNKQDByIhdZxjsM/yMo51SXTXI9na3YrM9ViCwo6CkAfOVu3ck6l/T69ZJ+EcVF2/gS/Q8oEYQP4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093164; c=relaxed/simple;
	bh=F3AX/E6Xmwn8ebVsXlNomkOY4ibINmc6mhSYBLicdNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONISc4TKKCujhy2hDfLBcQUlVYyOD1J9pxctIwz+rk1cLMt1Yq/QM2pQxZNcvQ9yXYk0bxP+3ydYQEmgODvhFoDD3C4KI0VXCLZZ0C5vN/Z/dkEhToTimVIHF/szkfE25ciI8bgQIgf+MW8paZpdsYwfz+3vP0MFbfiSfY8k4ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Vq1d/jgm; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Vq1d/jgm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=9QZJ2coFQ5IrqIpWQWgu61j6TIUgAzMxUB//n+RwD4U=; b=Vq1d/jgmpIs6AXhgyiilSurzz3
	Jw50EPS5Q3VX83QnWMbFMpbOn4DmRw37dRJVI2XWExM8mUlpSYm9ubf0ATi6dNF+jZGNLqPp42l7Y
	asMpU9mCFZNOv5rgK8vsG0LwFKmCFFyOozEsp19X1ePNlYvWkIjI3teBQFy3udmOFitnSziKU4sOm
	89nDrfKi/yIhdMZxaYBpjK660eH7CNLKwZcyItS/eKSkvb4lrfGYMLi33Bjm1qdttOCcAsTy3qALB
	cLHnAfH2gtfVYrg4twQvclw+S367Eoa1IeEqSlszc1L1h9cRu1Uq90wuEWe3g3V6ASMGwX6CLdsRl
	yzF1cD7Q==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHRIN-000B2e-21;
	Thu, 15 Oct 2026 21:39:19 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHRIN-0008Lu-0h;
	Thu, 15 Oct 2026 21:39:19 +0200
Message-ID: <f0983a6f-71a6-48b8-aae7-38c9b5574991@iogearbox.net>
Date: Thu, 15 Oct 2026 21:39:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 02/18] bpf, x86: Omit the displacement byte for
 zero offsets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: memxor@gmail.com, yonghong.song@linux.dev, puranjay@kernel.org,
 bpf@vger.kernel.org
References: <20261013171230.523677-1-daniel@iogearbox.net>
 <20261013171230.523677-3-daniel@iogearbox.net>
 <DM5N33KZWMCJ.AE5D51WCR236@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <DM5N33KZWMCJ.AE5D51WCR236@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28154/Thu Oct 15 08:24:22 2026)

On 10/15/26 8:56 PM, Alexei Starovoitov wrote:
> On Tue, Oct 13, 2026 at 07:12 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> @@ -1120,18 +1120,26 @@ static void emit_movsx_reg(u8 **pprog, int num_bits, bool is64, u32 dst_reg,
>>   static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
>>   {
>>   	u8 *prog = *pprog;
>>
> [...]
>> +	if (!off && !base_needs_disp(ptr_reg)) {
>> +		/* No displacement */
>> +		EMIT1(add_2reg(0x00, ptr_reg, val_reg));
> 
> progs/verifier_jit_convergence.c depends on the size of these insns.
> It's the reproducer for
> commit c8831bdbfbab ("bpf, x64: Fix a jit convergence issue").
> The code between 'if r1 == 0x0 goto l0' and l0 is 125 bytes when
> the last 'goto l9' is 2 bytes and 128 when it's 5.
> That's the je <-> jmp cycle.
> There are three zero offset loads and stores in there,
> so it's 122/125 after this patch.
> 'r2 += 0x1' and 'r3 &= 0x1' in patch 8 make it 120/123.
> je fits into imm8 either way.
> The test still passes, but it doesn't test anything.
> Pls add few insns to the test to get the distance back.

Thanks, I'll take a look to address it.
