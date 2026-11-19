Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795054231;
	b=QONDhbMMrHopSdmo4eChIKkNLltE12oAIziWSxqUfIdd33U3dqyYy4lir2TFIdKJ0rwE
	 AhOjJ/isJ7DlbHIVM+IcGfX3ZT9vuUW9aUDIZ74FGzIhlctrxOxUifrF7EJd0d/yD+Rbf
	 WAsdNNaq0XgLqOA3qNDJ7Hzj92AQY71J5zi/HOKsclgZvmEWksSn7KvhefEYWr+jCUKXm
	 Y9jZOPyVgYXdDCv/NrU3Bn/yuAdrTZBOvt0k40vCKnuek4MZZoUuBbTszteq3Ph/gbjsu
	 avM0pNDt79O/Vx6waO+zOAXz9j89o9ArAjRUwU2KUBTp5gGoNU4MJqmGuKfm7K58GpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795054231;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=EVb9oTo87qFSpDYevxSBCFoP0b6eBkjgQPT7OWDpQcM=;
	b=CzOXRQL9OV1couf4jPcyjIEglHbd4PMKEcPwtOzpo9/OhIGTw4G7tQoA3O/fxpEGQsco
	 RfepIyh7bbz1ME5yHm+xNw/6tr3tEBYll3woYeBXYmWckyxigc0lmcQfOa8f9YL11tFJb
	 JaYH9wxJrqZHdcYLTiw1u349uGVlEq1T/7B5+AaLcEub2L+hTWfUy1tJ9bRQuHJeI0UUL
	 +38HgRWYLw4LiOFDw6rlrG0am53DQkrE5PKyhoHWhAeE9OyhWm2bA0MiSWDWmaMQbrs7P
	 JjGftZ+g3c8bpTlsvtIbZoNASrRY5pIl4YBI9WZJFi8S2PK+/LqjbVs7qv5UQDTRiGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ISiIbAXG;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E4606A32C;
	Thu, 19 Nov 2026 02:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 446E4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ISiIbAXG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=EVb9oTo87qFSpDYevxSBCFoP0b6eBkjgQPT7OWDpQcM=;
	b=ISiIbAXG2okbrip3TxvjkKeiP3+8J5AOr27kQ2IbXcIXttr9xryqwS1EyBrFVn
	sLlvYHhyIA6zEawsOQml12rSpxVXzNYlSwlKeKw2EA2zd80qi/wuUrgvjQprLsCz
	qebXEjhQVsf88R41gsRLEXDlx45AsYufuWyCBh9YxkdNs=
Message-ID: <2d570d81-9773-4104-9475-9f50e359f363@163.com>
Date: Thu, 19 Nov 2026 10:09:44 +0800
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
Subject: Re: [PATCH bpf-next] selftests/bpf: Run all summarization freplace
 cases
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, andrii@kernel.org,
 eddyz87@gmail.com, ihor.solodrai@linux.dev, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20261118073309.125424-1-luyun_611@163.com>
 <DMYT6CELPKLL.3IH95CNKKXFUP@gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <DMYT6CELPKLL.3IH95CNKKXFUP@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAHOX5oWv5q7qg_Gw--.8789S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4fJF4DAr4DAF4UXw4ruFg_yoW3Jwc_Ar
	n2grWkuw40g3s7G3W0krnxuryj9F4kXrZxJrs3XrZ8Aa97XrWruFWv9r1S9F4fGFW8JFZI
	vF1Sqr1Yk3yfujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_qjgDUUUUU==
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AkL2Wr+WmkDOQAA3q


在 2026/11/19 09:49, Alexei Starovoitov 写道:
> On Tue, Nov 17, 2026 at 11:33 PM Yun Lu <luyun_611@163.com> wrote:
>> derive the group count from mains. This restores four packet-data
>> cases and enables four sleepable-program cases.
> The four sleepable cases will fail on arm64 and s390x.
> Their targets have no __arg_ctx:
>
>    int main_might_sleep(struct pt_regs *ctx)
>    int main_does_not_sleep(struct pt_regs *ctx)
>
> pw-bot: cr

Hi Alexei,

The bpf-ci also confirmed that all four cases fail on arm64 and s390x.
The verifier rejects the target before it reaches the intended RCU
read-lock check.

I'll add __arg_ctx to the ctx parameters of main_might_sleep() and
main_does_not_sleep() in v2 version.

---

Thanks,

Yun Lu

