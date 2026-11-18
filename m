Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966939;
	b=Ln9QJCMI178lI43F79V/U6v+rrBKgHNB6FHQhUhluccpRC/vBzQcMWRCrEe4jOOZkc8G
	 xrh2qsvjfy8k+6UM2dbVsEZ8sSZ/XphgyINJBoQa1G6zCRQKmN6G/sqHBe+ih5Z3FRYU3
	 OS2HK3qXT5iTyb0N6eG8RPSnoBkRrsLOp7+fs3SwWFuhawiARDqu0Md8VdPgeRaNrGe+g
	 LDrlnGEPdmLSd5WfEFuTzxJSa/fdaqPQM+3UidFxgA6LNqtsmPHvuNv4h8HQZBwi8lS+B
	 ENd5TlEBUhLnFveT0K7SoN2Gt9vfX1v31omV0/BV0YCj6+dfbLl/NvO0boje62vp9pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966939;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=n6+eDFFvL/Wsk0eeysYpdGNLwTPv8Y7kp0pCYvn78f0=;
	b=pstKmv8sDnRuEIkAPYKl087OxAiQwErWhDKw+B7TbppfYojH7Tk8dxYBykRab+HQsRag
	 DYkvd7bgEwwYZJaB3yWqzN7GHWh2j0ZspGN9REsibDNUTUyvlbqs2OwraJydxtXsq4pNt
	 Ma33WNpvXGZtGfFlaha8n+KuakjFmUqONCQ/iRJ5o2A2x2fjHQytTe7vsHLa11gZfrCEu
	 oIkQB/arEqG4hB7NWiW13ZSV7CrIScmiMLal6b8+QMirI0SuRjzDTGZK6fyWRXprClHeN
	 0aNR+UYWYn38jsFru/WSA5k9kDbZRJnhDRQd6tzQEC250tXZ9Y9klGuuqjOC0aLedZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ll9K8i3P;
	arc=none smtp.remote-ip=91.218.175.153
Received: from mta0.migadu.com (out-153.mta0.migadu.com [91.218.175.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F156606A338
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 01:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F156606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ll9K8i3P
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=inCj9hgFOM+3wUeyAcIWcO42wDOsOp5Vk/7hHTYE1G8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794966936; v=1; x=1795571736;
 b=ll9K8i3PEqv1Y0gmSPSktE5e9ytiF5pjOpxcl50vYyTPcDrElpFn1KoYwJZjXi/aLKpiO/vj
 Fa2Jv5+ev8VmEm3963FvwqFkZOo/UQNnAMmz5NQAjqRlczG/zwC5u25S9b2WwOQy53SgrXPlXzc
 /8ctTemJKTGCRgDv4dTFO0j4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0ae421e0b46adfb2;
	Wed, 18 Nov 2026 01:55:23 +0000
X-Mizu-Trace-ID: 0ae421e0b46adfb2
X-Migadu-Flow: FLOW_OUT
Message-ID: <8922213b-d734-4f43-9648-97b3fce1cfc6@linux.dev>
Date: Wed, 18 Nov 2026 09:55:17 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/9] bpf: Add log support for tracing
 link_create
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20261114150610.84507-1-leon.hwang@linux.dev>
 <20261114150610.84507-2-leon.hwang@linux.dev>
 <DMX8G01GB597.2KEEFI12YK9V0@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DMX8G01GB597.2KEEFI12YK9V0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/26 13:22, Alexei Starovoitov wrote:
> On Sat, Nov 14, 2026 at 07:06 AM Leon Hwang <leon.hwang@linux.dev> wrote:
> 
> tldr: pls use uapi names where possible:
> 
>> +		bpf_log(log, "tgt_prog_fd and btf_id must be both set or both unset.\n");
> 
> The uapi fields are target_fd and target_btf_id.
> tgt_prog_fd and btf_id are arguments of this function.
> Patches 2, 3 and 4 say target_fd for the same field.
> 
>> +			bpf_log(log, "Only allow re-attach for tracing and lsm progs.\n");
> 
> I think this one misleads. A freplace prog can re-attach.
> It has to pass target_fd and target_btf_id.
> The comment above the check says so.
> 
>> +			bpf_log(log, "Invalid attach_btf.\n");
> 
> attach_btf is a field of bpf_prog_aux. The user never set it.
> NULL means that the prog was loaded with attach_prog_fd.
> Such a prog can't re-attach at all.
> 
>> +		bpf_log(log, "Invalid kprobe_write_ctx.\n");
> 
> Another bit of bpf_prog_aux.
> The rule is that both progs write to pt_regs, or none.
> 
>> +			bpf_log(log, "Invalid tracing attach_type.\n");
> 
> LSM progs get here too.

Ack. Will update the log messages.

Thanks,
Leon

> [...]

