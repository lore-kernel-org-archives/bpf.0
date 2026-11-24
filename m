Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501683;
	b=p7YKpCk50olV7ARMvb/0aNNpDOX+8k9tScrd4soa5WCB+9vdA5Ro7O6btgl8/JDvW4/Y
	 akr9TpgM0HTuwATAslCOVgdmdYIkCT4oF+eNNbBkWO8e651LXg8WfAbByjJ9p0eLgWde4
	 A1kkx/mnPU7hSyl8BAq1lODhsUYLqYA2iL3BZNit5aZAAI4lTsGBQVWembwyZ1gQpxe/X
	 5ODMOWWDZ5Pi8+iDnYfSlh2HLx1FXPWt0N1oPSyvGu6mp6pH2Nzvp2ziKOlYG2SDE1yiW
	 vIfefYY11ItcqZmyHpbR9EFZlOIqbgpz5RTS8YIXpZcUMaQ31WIx48OM9dmr01ifN6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=8CAifW3Lq2rK8dqR915PsF3RJe0oEqOH/K9Z6lx0UBA=;
	b=Z5X+aF2DRkHDG9lcBB5z9553E9pzPJostt2fKTy65zuT8nz6cK9Cx41ybn5ZKCaVuLaV
	 zqoParmjksXsPfBy/zRCpEjpRWbSKG0Q+5n5oztOghPj071g4DnV4WPnQsLgXxD9zh5cI
	 eAI8lCov9vk1dbycUqS2SkURrgbQp2RcF6WUbTuFDO9fa2dx63uxxXceaXgONP8m7EWDc
	 lQojZgPcXAC3d0GaSbrsB5mRq5UjlYrB6x1qtfRK1v8zuJ7ibJd38x757CNg/8nfLs9WB
	 vGBRxo9EqiO1aqEbnytsPrBXFdCuM9GbT9oK4I0iPX8bFE517HXUjoYqQUWyM60RdAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WVxso20Q;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECBA606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 06:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ECBA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WVxso20Q
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a070781f63so1864937b3a.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795501682; x=1796106482; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8CAifW3Lq2rK8dqR915PsF3RJe0oEqOH/K9Z6lx0UBA=;
        b=WVxso20Qjjyqp7QfrtJDoYzErRHcAWmWsSS0WJPEmulzXkDXBAzkuDEHa9MmlCxO9L
         Mnc0ZBoxnmIdVluyj4NQ3UKIzfiNopiGitcsr2FTVGqxkEb+uHQ6YIrP5dxen7uC4iy5
         qRo3hors8bgy/TTDzJHgZ+wYblP3vZkwzN1SdI5GGbpV2PXlyL5T4bcffoXlEaxGWnxL
         V5pdbk+3Y4hPxW+xZPpCqrHld72Oj+41govyY5cnTMjnq8h2xMGpqbdMSWEIkb4yDQpL
         i9aPrdZsX4i8q3Im5FT3UL3PfvXlhlCdFw+oIQeknoQiwDV0I/Z50sNfUQgMdUkK05Id
         b7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795501682; x=1796106482;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CAifW3Lq2rK8dqR915PsF3RJe0oEqOH/K9Z6lx0UBA=;
        b=pUgTzauxLAue6cbtaZjnL0TJ5q6lWuXfnX38zYJ7vqjmOP8ixxOw6kPCNCVd2s9IMM
         7qnGmEqNlX5qI/e2Y0yac0UWgUKeUCqjwenKhdWZmUNDwhvHBpk/VdDU6YIsdgzgPR/t
         KD/aMtc+s7ZoqkoQo55euAZI0YXfNIcwd0LxH4ShgbXr7tp4WfDFHHcKx0nzTBPMwMgM
         2xaS+hZBv6v9ET71rnboNmdoQu4bkDdKOaim02Nko2mlNFWyrxaMgneo9CfqfaL+9SNP
         fkvjoTxAjmIdRvvkqljZhH4lkq/EQ1S1FjRD+gK73x6X+B5MJUM8fETk4kaCWtGr/cqw
         O8Dg==
X-Forwarded-Encrypted: i=1; AL+hErGi1YG2zpQfQO/E6s+e0P0pevxwecwYyZtY0/Cck8qPEqpV866jEgDh84R0fh3BU04E2Jo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/afr4ycpYVFo8QJXP80a005Xv5Iao6yZOxfEkqd7wsFmD5iz1o
	3hcYojKQsoiWse4v6drqu6BJHZafk3drsQGWmEkLL6PXIHEicfsJTcmW
X-Gm-Gg: AZFdTZcuVv3yBoEqHO9JJh12zFlioJUV9DtQ1Ygotl8n6y/HVJDdVbrulC/rxxV9MgM
	o2DS55LiEvj+5Pw8xxbYa+JwqVPI1azT1sJND09OJYxjEYlKksGmw+1YsI/5Fahqntd+Y8b/ujY
	1YSRbvB4PigqXwJ5G4jyPyJnazSq3wNLoo1TPemyYO9D/+EqDlaNjEqJHa9Sgg2yYgvahXqXWUu
	MYLq2gBg9bpHMk2SJFVQMQJR88OpVw0KaDq5rxRhBXi+M5uXzWdcezZJyvHfuuEIlFHBzRpZ/oH
	o8TwPTpXopIr7PJi/+uNPdhM+bh/mwOJLDa+7aDBgEhY8aPXSMr8Q5DbyqrJnzkhveg9Qt/qaCv
	81104N6RJjk4e4lW36FxQgTIUFRGtBUII0oDKO03wg8339Xeb26I4EF2teoS05hIYF+GqTiiQD5
	e8cZArMMvcXsIgHumf/6J7Zc6MQ+U16GXWqAjfKnSb46nIgRDcNSfGVal/5WD+M8+6tJdaK5X0x
	nuj1p/+dy14RhPDDzuu3yXI3jFZDA644FWCnp3NKCUCBlgWBc3+lPjNEDHWQdqTI8yCGCYmYCUf
	9jM9KJYuFAQAPU3ET1aoqUTYa7OcFXtwBqxDqGCTETkdtTg7sR3kZqt8+ni8eukiCXIP/cHZQwO
	njKzU2pFaYKgBkbWMos66//yAujzmMH1ulwEG5i2vpnXjOunnvmJEXb4=
X-Received: by 2002:a05:6a00:410e:b0:87c:e6aa:30ec with SMTP id d2e1a72fcca58-8c87d31f4ccmr11608144b3a.49.1795501682157;
        Mon, 23 Nov 2026 22:28:02 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45756sm6666168b3a.27.2026.11.23.22.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 22:28:01 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 06:28:01 +0000
Message-Id: <DN3885A9PVWV.2FTTIEAKU4QXI@gmail.com>
Cc: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>, "Puranjay
 Mohan" <puranjay12@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai Lau"
 <martin.lau@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Mykyta Yatsenko"
 <mykyta.yatsenko5@gmail.com>, <kernel-team@meta.com>, "Liam R. Howlett"
 <liam@infradead.org>, "Suren Baghdasaryan" <surenb@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>, "Shakeel Butt" <shakeel.butt@linux.dev>, "Pedro
 Falcato" <pfalcato@suse.de>, "David Hildenbrand" <david@kernel.org>, "Jann
 Horn" <jannh@google.com>, <linux-mm@kvack.org>, "Chris Mason"
 <mason@kernel.org>
Subject: Re: [PATCH bpf v6 2/3] bpf: switch task_vma iterator from mmap_lock
 to per-VMA locks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
In-Reply-To: <awSELWmIo2LA3bM8@gremlin>
References: <20260408154539.3832150-1-puranjay@kernel.org> <20260408154539.3832150-3-puranjay@kernel.org> <awGZWsCp6v63H_py@gremlin> <DN267JUKDRNS.2VMV07CQ58R4X@gmail.com> <awSELWmIo2LA3bM8@gremlin>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 10:36 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> Probably then mm doing this is the right way to fix it, so let me have a look at
> this and send a patch.

Thanks.

> But yeah, let's also revisit this open code and have the VMA API give you what
> you need properly as a follow-up.

Yeah. true.
