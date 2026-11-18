Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007865;
	b=b5SX4byVlAzv0UxNh7uUDZrJAvz7iIoHnidvp0NU5VZR9c69UBaHdikRNDieK9RfqF6e
	 WixdWNDcrKmMH1hr8Moe70R74PPlGgQVBUzoAy9GJD58H4J8RR+JHPAmmbjh37kM/5bIs
	 VuOdX/4+tVqkDKIDOyOOIxRUBXptLUZBLj+AmjVBoMKDzxaMJ4zpSYydQWlbuznUSKllK
	 xfvsrMo3o4XVOmpF7FtCWwn8x8LlgsqUXgJ6T85LS3ibxWydvTFctDAUdB+p7lVs67Pc2
	 JMhJd0MeOW4sjvKWqEkimhXXmpUvBowYqVTdYcmMHpUAdfGgj9ZYIU7H8/hgcfY6RWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007865;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ou7VqJIvrJwbDof8WuTCn2yqRr3nuLImwl+n8z/KCYU=;
	b=dEPX8VzLP3Oe0oONm2Zqvm+659YcoHQ/0NIYuDCz2FUXkBdeb7kH2lc+Wj6z/vyWY3YO
	 mS9LlHURUsV2YdZqgy2RsLx8AQqnZNRWRMwyaofsevXhhSSMmyIymw+vRJdsx6GqPT376
	 KoSUXMLx/sS1QkgEjA5bO7Kg4IxABEbUWIFKZ7CykWm/E/8QkR4vbNKxLnKIqH87ZDcPZ
	 wXhzODDTjFSRPITRXJMldWF5SJtLfUaFf2XsyfYhOjaVtVikkfQKlLeepleq6g8l6byeC
	 DbHaC68LcCUWXdz05mL8ZtrvJq0ZbeNgTzKYaYrNF6AHbSElUuZTj6lFd2T+7GN9nXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wRuLXZI5;
	arc=none smtp.remote-ip=95.215.58.47
Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C152606A333
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 13:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C152606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wRuLXZI5
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/ZzSIR3rPfPXJJtOS8PvCdyzoY8bbs32yVXQ2eK08Ew=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795007862; v=1; x=1795612662;
 b=wRuLXZI55fFf4X88ZVUxePGmdNFnkBpJPhJ5pfnszsresV0CwftRxx0PxzRELfa+UBAfZcMO
 FQOInKGpTqEv5BS5eDRQ8sUT32bNtNTkQwggRCG8l0wsmd759p4mOgBuhycUrmPvr+EK5cJvEop
 luJovKH0Z0iVLm04/TBuf5y8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 663fd380a80634db;
	Wed, 18 Nov 2026 13:17:42 +0000
X-Mizu-Trace-ID: 663fd380a80634db
X-Migadu-Flow: FLOW_OUT
Message-ID: <0da8e4bf-ad3d-4a69-a1af-b2be9c63160c@linux.dev>
Date: Wed, 18 Nov 2026 21:17:36 +0800
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
Cc: cui.tao@linux.dev, cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, daniel@iogearbox.net, linux-kselftest@vger.kernel.org,
 cuitao@kylinos.cn, ameryhung@gmail.com
Subject: Re: [RFC PATCH v14 0/4] blk-iocost: BPF struct_ops cost model
To: tj@kernel.org, josef@toxicopanda.com, axboe@kernel.dk, ast@kernel.org,
 alexei.starovoitov@gmail.com
References: <20261118131029.797007-1-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20261118131029.797007-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello, Alexei,

在 2026/11/18 21:10, Tao Cui 写道:
> This series lets a BPF program take over the cost model of one
> device. The BPF model provides calc_cost() for charged IOs plus two
> transfer coefficients for the completion-time sizing, io.cost.model
> selects between the attached model and the builtin one, and enabling
> and disabling the controller stays with io.cost.qos.
> 
> The builtin model is a linear formula derived from a handful of device
> parameters, and the right formula is device specific. A BPF model can
> be adapted to the device and updated without rebuilding the kernel.
> 
> The series is based on next-20261117.

p1 changed quite a bit since the version you acked, mostly from
tj's review and Sashiko's testing reports, so here's a quick
summary.

The flag enum and the model accessors are renamed. The merge flag
is now enum iocost_calc_flags with IOCOST_CALC_MERGE, calc_cost()
takes a calc_flags parameter, and ioc_model()/model become
ioc_bpf_model()/bpf_model so the builtin model is no longer
represented as a NULL model. The named enum also makes the flags
discoverable through BTF.

calc_cost() now has the same pricing scope as the builtin model:
bios with no data and no flush state and ops other than reads,
writes and zone appends cost nothing, flushes are passed through
so the model can price them from the bio flags, and
completion-time sizing now follows the model's transfer
coefficients.

On attach iocost holds its own reference on the struct_ops map,
so a model cannot go away while it is pricing. A dead owning map
reports -ENODEV instead of -EBUSY now, and the autop stepping
timestamps are cleared at attach so a stale pre-attach profile
cannot fire a step at the model=linear switchback.

The attached and attached_link updates also moved out of
ioc->lock: rq_qos_mutex already orders all their accessors, and
ioc->lock is only needed for publishing bpf_model to the timer
and show paths.

I'm still carrying your Acked-by. Since p1 changed quite a bit,
I'm happy to drop it until you've had a chance to take another
look if you'd prefer.

Thanks,
Tao
