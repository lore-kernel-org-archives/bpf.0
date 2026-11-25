Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638228;
	b=rM5sSLNwu1ixyI0qr8on/r0FIp9vwHKSBLWWhcN8CyNH+1CD/QW4cVDSpa3+DUHRzDUo
	 MrjKhWZAo9dG33RHSXcpE5LVjslUvusgnISCr8ZoTfAJrUi0d6JYQjdMb//qhDhGWvEms
	 Ua5WprBWPn1Xy4eS3bW6TbXDI5YahzungszbfkQVUQYvdtH6Q8a80PmPHiIyl9++YEJLi
	 knYpIdH91gtEIgWlCkPMbzaRcyuyYW8+pDKFtfd+pAG72aIfe9wau2K7RpY4f7mHGtdaM
	 nTTnjU3G7yqpAGbgC1mgUMvYA6x0/jL0bDx+xIVmdMLI6zPb/6BL106ZD4cSbSed/KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638228;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=hKUU2imahZE4B9a0pwQkizpFVuU4ssI550E629F+HU4=;
	b=a3gqWOrUFhmrcSjj3lizHx4nJZNRGjrqNlMM3NAEhrRyjepZOw+wUmPYgotoDvadoiPb
	 8Lg19/suN/9q2O85nqF//rO2TvjJvtD4PuGJf2/1giicvyrYWYPmlXt31mRVNqk1rxAkv
	 QGvs1S54sIZm2mtAegkpo4jvIXK1ulIKq/ssWTvKCgwqWTR3Q2qBA0F6HMOKjkieC1RUY
	 MV6C/SExNhsBa4HLSYXZgaCh1VCMn3Osu2ETwGrX8vaACeRW9k6lFzLXlgbHLZfSS6E8w
	 UiMH6zy4krybsiUd+XeiTF6Rf1r47vh/3trq6fnGaeBom/sdj9GJJ0kGLgtU+TM3MDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w0DU1h2I;
	arc=none smtp.remote-ip=95.215.58.175
Received: from mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680BC606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 20:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 680BC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w0DU1h2I
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fdrz78OYlKMGHh6IXGtV5XttBhxWpJMlzeekMNBSw3k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795638225; v=1; x=1796243025;
 b=w0DU1h2Iu7iOo5sYgszHSa2bYau5G741zzfxIlhRUY4uRk8oGxMFoJi3sj3Sj8bU1t3mZIeo
 +qhSzLfqJqJybM2BJIFx/c7EQGh9J0GVhY7Rc+S+q7qWFm27v5HJDsbJQ6DHZ4cLyPfEKvwTS3w
 vZ5fmeV8kCyGDXA5HfvDf85E=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 92300b7e95544926;
	Wed, 25 Nov 2026 20:23:44 +0000
X-Mizu-Trace-ID: 92300b7e95544926
X-Migadu-Flow: FLOW_OUT
Message-ID: <4f83adb6-29d7-44d0-8dbc-beb28231a8b5@linux.dev>
Date: Wed, 25 Nov 2026 12:23:39 -0800
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
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 mikeba@sentinelone.com, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Martin Kelly <martin.kelly@crowdstrike.com>,
 Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
 tyler.wilson@crowdstrike.com
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <44034fa7-91ab-4777-ba72-0037a6932b56@linux.dev>
 <DN3ZR4IBQUKK.2KZHQUDH3ZRAC@gmail.com>
Content-Language: en-US
From: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
In-Reply-To: <DN3ZR4IBQUKK.2KZHQUDH3ZRAC@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 8:02 PM, Alexei Starovoitov wrote:
> On Tue, Nov 24, 2026 at 06:06 PM JP Kobryn (CrowdStrike) <jp.kobryn@linux.dev> wrote:
>> The patch below is a proof of concept scoped only to x86_64 trampolines.
>> It was validated with the bpftrace prog that precedes the patch, along
>> with jited assembly dump to inspect the new private frame API calls.
>> Overhead measured was roughly 60ns, but this was just a first take and I
>> believe it can be optimized especially in the JIT area. If it makes
>> sense, this could be integrated into the series or sent as a follow-up.
> 
> If you want to redesign private stack please take inspiration
> from insert_arena_stack_get(). Much lower overhead and no artificial limits.

Thanks for taking a look. Since it looks like v4 will conditionally disable
preemption for run context entry to exit, this concept does not have to be
tied to this series.

We'll pursue the private stack work separately, but will continue testing
revisions of this series.
