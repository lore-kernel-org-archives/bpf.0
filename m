Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54132931C6
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 02:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254378; cv=none; b=dSFo9VLCwGBxU1uSvD02XmpvdchmeAPtwnHdHaOlcVtLarrkny2VpveUmdb46Dexg1yRvFD5qqAl4AbnLU11QzU3j7bkyxfXPclipkcsV5RKYTfREQrsLVq0Rwv5lh6yNsqhdrBWWtrDgCgN6BlDdYeftQtI1YZdUhTeELlxmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254378; c=relaxed/simple;
	bh=Ja0XyoAvhI3Xt3LRW6htgUJuKsQFPC/S2C0fYkpT+P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTLK1O1apLfeOh+hu4YBR7MuYHGDE8m7hrnUKmXibneSNiU92t8qxWpsgj6LquEpiC4bkboD4NwhN4ZCrl0QP0qCC35LuIMPPpDkiuK5KFdtKLs8jBPMSvIrt64rbvshiDzwDvHUVyiFgv+2UlpdI/YpacrOU1Xx4lnA2sBaIAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OamFIAy4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OamFIAy4"
Message-ID: <b76ade17-44cb-4e60-97fc-41ba55258691@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784254374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsTmuXwOvoneEY4iONWCqa5zdFZFDoCDBf0GmtOvujs=;
	b=OamFIAy4vAxqZPv3h2qcyKWoBSk6y8u5bJ9HAYOLC/mQpmJhmoRR27H31aGR8iDMYRo4G3
	+sPaGlP1PWkazZ4kiQcVP8pmJS4TkqECGTeA6XNDVGKhhtDQgmvMJi4WCdreQ+1q74HUc6
	QkQvn1de3+rRCj1IdG5pw8QaLJymj4o=
Date: Fri, 17 Jul 2026 10:12:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
To: Vincent Thiberville <vincent@harfanglab.fr>,
 "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <d255172d-d9e9-4116-9243-975cf4bdf3d0@linux.dev>
 <MR1P264MB33143D31DA8982ADB2E0D808B7F72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <90c32de0-feac-4e63-9757-2a1d115be08c@linux.dev>
 <MR1P264MB331493FEEA2ACE6C2AEA5EB9B7C72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <MR1P264MB331493FEEA2ACE6C2AEA5EB9B7C72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/7/26 19:27, Vincent Thiberville wrote:
> On 1/7/26 04:49, Leon Hwang wrote:
>> By changing 'r0 = 0' to nop, I can reproduce the BUG with bpf-next code:
> [...]
>> With this diff, the internal BPF_ADDR_PERCPU insn is supported in the interpreter.
> 
> Thank you for the investigation and further details.
> 
> Is a fix planned? This bug impacts stable versions of the kernel and is fairly
> easy to trigger notably on Debian 13. With some ebpf programs, simply
> enabling `bpf_jit_harden` on Debian 13 means a guaranteed kernel panic.

The fix is on the way [1].

Once the fix gets applied, it should be backported to kernel 6.12 with
prerequisite patch [2].

[1] https://lore.kernel.org/bpf/20260715141122.15783-4-leon.hwang@linux.dev/
[2]
https://lore.kernel.org/bpf/20260708101806.18885-1-yangtiezhu@loongson.cn/

Thanks,
Leon

