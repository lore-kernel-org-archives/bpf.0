Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068886;
	b=mhwdAz03g2BGrWXdXJCOFUvQz3ASXv2p39CXaFM/82l2f0B0l9ya2jiTxw/VPmSgSIBQ
	 XbM2DU+OkeKG6vydgOVQHpo8n/+EKF7W5eudD14EtvZjR1wTBc06S0BaXGYmXMv+PtxkA
	 /TvyobK5Kfo4MbaFD50N4rpcxlyHW92SuRuynCMaREGqSp9liT2uuCfwp4blxhE2o8fAM
	 +0QnV+smkk41OylMhRpo6JruO+solIsYtqm2VUMrcVd/HhLY8yHP/96pw0be6f/i+fG/q
	 eGzqtkzqdaqOkjMrPmUHs/RYTxWrbFmRHfyIKz+umZksaYSounmK2HDdh9LqkwJhDyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
	b=IEO1rCtVDtUNB846+w4GKAjnqRgpqGY4gqp/UuINxJfooq/tTHsJin/rmhAKkrqXy3jX
	 WX52EewEh5qeZ0xbEfeuJ9Jq7Q9AnG9IsVR7TVMSLkHQ/XWKQRRckn8+IuC5fvYPKktI5
	 ahP0ok/9xv4ASbRGr5g9p/YkIBa39PI8VTvanzWTEkzzyPjPM8Lyp0RrwOJ3tlPURwi5O
	 JsUmrFn4jC7JzFgoyY6Ge5Hv0DLuQv0bjZUlQQMbAc42OovC7eIrpRIeKcDIAuML/22Na
	 DG1BOFc23EsQsENxyST06Bg2lHpxE3eNsbxtG+jtmf6D0yl3zNstaSSuhlmxB+TpJpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oc6cZqFa;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC3606A31E
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 02:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EEC3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=oc6cZqFa
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-185fd3a4ca3so3125918c88.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1793068884; x=1793673684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=oc6cZqFau/HqROtNMBTq8ZP3TLLLzMKPOdbVxFYEww/DOpOMHzAfKhTORNvN4KTBkp
         LUp5Moi9eFCEYu5/4XDZT8WcjpiPsCN+0zUGPUekQp2yZJY0zBe8yl4kYAkKqjEdTrbQ
         qqNSykJeEwW7qBFZEoQS1rQ+7ZwY381+e8TxKyiv+Q5rLJiCFF4PtyVkTxWHTKQMc6vO
         +lb3qFo71UgGSSnv6IseZ7y8wLhEFz6jBXh4HUpywe8jgXN4FoqKQy7CyAzCO9Yfeytz
         HBIYtHcP3MQ7eijYy79F5eSeZqsN4/+XnIDB6Cna6QVY5R0NQaf50jlOwAuklcgL/mVV
         dVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793068884; x=1793673684;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=VTlGRhjjgMzQLxq8TnptxoY9it+unl7uKYIxDj3bRzmlepRKriBEEN7suVu3J1Df2E
         VqSf+q3OyOegMCpjhToIjhzw4F4Aru+gfTCdR0pWiocXPMgYYeTIs+ZU38xiQIw4x7Nm
         F3b434Mf03Jqh4R4zIDCoHihj/0OnVDhNLgS7jYkFRiqrKFIBkMSeldVQ6snAjEO5ktd
         pEkSuX6bfpNKN5BQQSFzmjMBGR6zkJop1MP2qLq9SPTxxNhKztA6tvmjF6UhJQRQvxdL
         4wPOaUnpwmb0GmlgxywjuIFl4+rrSjjhQVw5QEa8QHv6K8iWTvb0ImYgIRXQ0kkc8fTG
         LLjg==
X-Forwarded-Encrypted: i=1; AKwUvBxPozmyhyE1Mljz6RJwc0VnxsPRqJY3D38aAcJ4/s5f878E91bUQ5hJfOGvbWFVq7ucVEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbgCDx4mFRZcgbvt5t+4b3Za5ZCN9ukf6Ec9ZRKgES6QCNVoNL
	jp5sMilw5S4hs6lNACUliQNhNmWzBQEkTtuDD9gyX7hyj/pI7hor0VAAHOboNsiV8zA=
X-Gm-Gg: AYBFou3z6BiA9cAHOuWYcHPI+crNx0z3P0GOKUKcIZQSOpVp4evSUSVZyq1QCzUd4z/
	ZTt2NadAChydh/ySIB0wYhyHxV2iPVk08BDxGEFMJtwVaUnn5EuiJDrufWRFc8LHY3hkZ5+piuA
	Oz8uPnpQ3A3gb20tUNNs1bV2rtZ79AIPhiSviywyONNAxqYqwJbtbOFZOtIeAgvURj3rhN11Wvp
	+9tKEELScXiignCjkEoDU0zpJdb0YOq9pAIlzpGpL8wDJWF8tLnS1JEbD0dcL4G8XVaOF0GA4cC
	MG9qI9TS2nCjUoRnIQH2GDckq98F8x5SfaBqLU/vQls7QCuP793O24T4T+T+5mXmfwPHNNES/Jg
	OHr3was90rT9ZpBDS/vUUnLEqdn6eDMWOEBdPSi6eFkaSBSe5FUzXzSHCNclgTkxlTFi9mp6ikc
	w17pKrkiIrZz8R8DjK8Lav3i3AWMMoDzxHNMGmPFnuv0kNPtGFIvf8XMc1zHoji58AzQcXeSA3d
	8fMQOWaOAGW5HY5b7E9kOgViTM3QFZoAyxJMyMB3CFLQk4wz4dbpppIMHSUkJCGktuPQfZiXKgM
	fqAgzgLwRkP5iO9T2mT3AQ6/8zqVvxPt6UdvkXM=
X-Received: by 2002:a05:701b:4184:20b0:191:444:425 with SMTP id a92af1059eb24-199290fe40cmr12440066c88.2.1793068884148;
        Mon, 26 Oct 2026 19:41:24 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a1bfaf25sm29293759c88.14.2026.10.26.19.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 19:41:23 -0700 (PDT)
Message-ID: <1ee97e9e-3658-41a7-a879-348f51ab547d@kernel.dk>
Date: Mon, 26 Oct 2026 20:41:21 -0600
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
Subject: Re: [RFC PATCH 01/10] scsi: bsg: Don't copy sense data to user memory
 when canceled
To: James Houghton <jthoughton@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>,
 Chris Mason <mason@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
 io-uring@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-btrfs@vger.kernel.org, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-2-jthoughton@google.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261026215226.3713941-2-jthoughton@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

