Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761714;
	b=MxCx6wZG9w4OFW4/xpIAdVqZAjQLsqH82VLYcVciWYCwh339taZMaAtaBloW8os3Dht+
	 uP0mhwL99b2copFWpRST4Velf9WrR7eWxiiZ67YjVZ287x7CE0bLHgMgPKh6FjP3FxXos
	 x4t/dosURKNwdEag6DIatc7Ueq7yHH97Pso4L1AVHkJQ3cQslCx8ST8+27axg3r6qmMgR
	 4748jn+UnEMuUonbXIN/RrT8ajZGCXP1CZKUnsVf9W3isrej/t7zSZ7tjnvz5g5PE5lC4
	 Lp711V4STsl5nFYl3TypAANCohy7ToV+pBL21t84Wmbgoeqgu4GmIJMDWw8I5MH+pbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761714;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=28TICR5om8gEAA17u0Mkh2XWQT59vv9alAkSUCUqe0U=;
	b=AbgdkVUKnjz4SXKDqQK4zm1v0nRzQrOEAwEGnLqdlOyWwCXwp2J0qkXf3TMe51gdt3s2
	 AfBRNKoHnzqT8A6JCMrsW1+yU28Rw0yP658PWyuQKvPGH159fkjcWMTiz9l2hvZeRh3HG
	 6DH36cKMdiqu40caNMDxOEi6ninGMAzGxmoW3KveGAQcZlRGMHJ+ZsCNnRkIitaVKojan
	 ramBwsm5EKPUPZTwwHMI4A2LknZLNb0OWt09J9JKUP23Z1Jr9T4bOfv3vziGOKP+saOjh
	 J7G15n+NXxCKOIIKgvFejfXIW2hsCCs4L05DJvUYzMolu9mZSZQ8aZ34rijHK8Swsog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.251
Received: from mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FC6606A329
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 03:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24FC6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZvICwksGFdvGheOHbOECoxnMVa3CC+IOa71TpIVxlVo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793761710; v=1; x=1794366510;
 b=sJGdFMO/1wRKo4GYdURwIYpO5u0qXaUqYZjCIgqeg432nHuAX2K2jiiapWbd6g2PXiqB9qtD
 cRB3NtLbgzC5w2Ie5Zm+9ludyRlTx7CeaPCXu4sPEZBGLuK0tpep+SL6aJKoip41nL6adGvPF+H
 yHSmAxoj4f9NWpwvZTR3RPmE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b902d48028398e0a;
	Wed, 04 Nov 2026 03:08:29 +0000
X-Mizu-Trace-ID: b902d48028398e0a
X-Migadu-Flow: FLOW_OUT
Message-ID: <0e226208-57ab-4311-9a83-5b13adf768d1@linux.dev>
Date: Wed, 4 Nov 2026 11:08:24 +0800
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
Subject: Re: [RFC PATCH v12 1/4] blk-iocost: add BPF struct_ops cost model
 support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, tj@kernel.org,
 josef@toxicopanda.com, axboe@kernel.dk
References: <20261103132613.1952975-1-cui.tao@linux.dev>
 <20261103132613.1952975-2-cui.tao@linux.dev>
 <DMLQC758A2C3.175VOTFQ2Z8HD@gmail.com>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <DMLQC758A2C3.175VOTFQ2Z8HD@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Alexei,

在 2026/11/4 00:51, Alexei Starovoitov 写道:
> On Tue, Nov 03, 2026 at 05:26 AM Tao Cui <cui.tao@linux.dev> wrote:
>> @@ -3223,7 +3306,6 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
>>  	return 0;
>>  }
>>
>> -
>>  static int ioc_weight_show(struct seq_file *sf, void *v)
> 
> Unrelated change. Tejun pointed at this hunk in v11.
> 
Right, Tejun already pointed this out in v11, but I missed it when
preparing v12. I'll restore the blank line in the next revision.
> Overall makes sense to me:
> Acked-by: Alexei Starovoitov <ast@kernel.org>
Thanks for reviewing and for the ack.

Tao

