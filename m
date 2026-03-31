Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294225F7B9
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923875; cv=none; b=efU9BGw5LSCo8ng/Mmc8GKVwvf20azoPG47FpJpcj7KHt0ML5lx7NwInDY9sRHm1GLOWuJA8Y31AYnNynUTrsc2UrMqSD1Gk32CXNLPGP58Qnd6SYCW6xL7D06TJJm1zbQc1rHTkM4lTjHlYOepYZaI5+Emp4/wGwxIK5sJxOg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923875; c=relaxed/simple;
	bh=kky3wGi3/UmHx17R0H3hiz+A2PJpZg/5dbV6If8bbX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKXlyShR5sOz1z1UzKypU7OBmjfiTC7Xgu6lLi3HxWxP8n3yvUODW3EinNVd1gX/m3y4MDawpwBUo893nWxlJJIB95bprINGAM/3MU8eQCDCJocyU4ueWzav0j5Y+MEvw0Qc9Qru8/S+ZPnK1xaGBRtM9/02v9E/UgsDJeR+sKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vEfMfzoz; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vEfMfzoz"
Message-ID: <f28c4e9f-eb44-4db8-844c-400bf66e88c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774923862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86re5MfwmJbAP59tH1WEF6f9JvbkHObE5R0FqbUZR48=;
	b=vEfMfzozsgSoKHhCKacyfXjCZa6oyDqGWmAQeQyyFRLzDS+bEsWJ55PesiYvJ2+5e5ANOA
	5IgrCsccoYX1HzygZTnZc7uOt0aMNwv0VigYB1poEejOZgJDI273YqeR2b1vIrtRs6c8jJ
	DH3sztrBdwhXvblE8jDDeSH8PPrvxKo=
Date: Tue, 31 Mar 2026 10:24:14 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf, x86: patch tail-call fentry slot on
 non-IBT JITs
Content-Language: en-US
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 X86 ML <x86@kernel.org>,
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
 <4b0e7341-f2e2-4ad2-8c9e-b482a1b1cbfb@linux.dev>
 <CADFiAc+4hKQGSEo9XRvrNuTTK4LXwCfAqPMR3AMxiNBtZTc4mw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CADFiAc+4hKQGSEo9XRvrNuTTK4LXwCfAqPMR3AMxiNBtZTc4mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/3/26 00:46, Takeru Hayasaka wrote:
>> Sounds like you are developing/maintaining an XDP project.
>>
>> If so, and the kernel carries the patches in
>> https://lore.kernel.org/all/20230912150442.2009-1-hffilwlqm@gmail.com/,
>> recommend modifying the XDP project using dispatcher like libxdp [1].
>> Then, you are able to trace the subprogs which aim to run tail calls;
>> meanwhile, you are able to filter packets using pcap-filter, and to
>> output packets using bpf_xdp_output() helper.
>>
>> [1]
>> https://github.com/xdp-project/xdp-tools/blob/main/lib/libxdp/xdp-dispatcher.c.in
> 
> Thank you very much for your wonderful comment, Leon.
> This was the first time I learned that such a mechanism exists.
> 
> It is a very interesting ecosystem.
> If I understand correctly, the idea is to invoke a component that
> dumps pcap data as one of the tail-called components, right?

It is similar to xdp-ninja/xdp-dump.

However, this idea has one more step forward: it is to trace the
subprogs instead of only the main prog.

For example,

__noinline int subprog0(struct xdp_md *xdp) { bpf_tail_call_static(xdp,
&m, 0); }
__noinline int subprog1(struct xdp_md *xdp) { bpf_tail_call_static(xdp,
&m, 1); }
__noinline int subprog2(struct xdp_md *xdp) { bpf_tail_call_static(xdp,
&m, 2); }
SEC("xdp") int main(struct xdp_md *xdp)
{
	subprog0(xdp);
	subprog1(xdp);
	subprog2(xdp);
	return XDP_PASS;
}

All of them, subprog{0,1,2} and main, will be traced.

In this idea, it is to inject pcap-filter expression, the cbpf, using
elibpcap [1], and to output packets like your xdp-ninja.

It works well during the time I maintained an XDP project.

[1] https://github.com/jschwinger233/elibpcap

> Thank you very much for sharing this idea with me.
> If I have a chance to write a new XDP program in the future, I would
> definitely like to try it.
> 
> On the other hand, I feel that it is somewhat difficult to apply this
> idea directly to existing codebases, or to cases where the code is> written in Go using something like cilium/ebpf.
> Also, when it comes to code running in production environments, making
> changes itself can be difficult.

Correct. If cannot modify the code, and the tail calls are not called
inner subprogs, the aforementioned idea is helpless to trace the tail
callees.

> 
> For that reason, I prototyped a tool like this.
> It is something like a middle ground between xdpdump and xdpcap.
> I built it so that only packets matched by cbpf are sent up through
> perf, and while testing it, I noticed that it does not work well for
> targets invoked via tail call.
> This is what motivated me to send the patch.
> 

I have similar idea years ago, a more generic tracer for tail calls.
However, as Alexei's concern, I won't post it.

> https://github.com/takehaya/xdp-ninja
> 

It looks wonderful.

I developed a similar tool, bpfsnoop [1], to trace BPF progs/subprogs
and kernel functions with filtering packets/arguments and outputting
packets/arguments info. However, it lacks the ability of outputting
packets to pcap file.

[1] https://github.com/bpfsnoop/bpfsnoop

Thanks,
Leon

> Once again, thank you for sharing the idea.
> Takeru

