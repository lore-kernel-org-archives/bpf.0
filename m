Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8702874F8
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551201; cv=none; b=pq+4gE3hZpZFab7TxyQIouBNj6yfPDKXUmNlujMfypQe1Kq4iLF8TnmzQfyNlRez3HZ3zQdHemoc0e8Ei+VekWFzg7mqgQF2n7YHuYAc11ngIyuMq2hEDXIb4W4RjF7KuWNG5R/xqEhNZzquU8SIsoeJxog1g5RAG1CK4JRYpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551201; c=relaxed/simple;
	bh=uiO1yCBgohBje3bzV3+nO46y0cFjkNzwq825fpz3HW4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jZiSji6Edd51fEzh7jdZ1EEFj7gzl4aOkruhxjBbKdfx2tymiTjKijd4RooKR1HUmkRIq6qygtoHKEcQd0j1S4AWkidVR1BNR8zhJBKc682INKwqq+gAYOu19ZDDIYyodmSpxau0W/STXFCMIGjuM2iP4Lo89NDHTp16lUIzba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9+yTIa8; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9+yTIa8"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4233e152457so3419271fac.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551198; x=1779155998; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abwiV8FAj3WFXudebX7tZFapFqnPdETLgcUK/xD1jr0=;
        b=V9+yTIa80w28g4B/DauJ1JqPYTxsfxMQ8AzehHlRGQl/h47H5XkBvh8PDNcAbEKZIL
         hHXWIkWj/QgSVMb25I4dEeni+l8q9J+6RYgZMBBESz/o5TURzk4Cqo6JqmJWhpm9D3yI
         w+Fy/stCZkEmSGtUX495/c8A0Xpbc2a43Z3T/vX0f+1hrAsIpcOO2H5t37OB6smgcNkX
         mhT9BFE4FRafX03p37qlxkw22mswAQfHG5FK7jU5aGWvXChUmzJ37F0dVto5ptpOTmG4
         T1MICOvJL2ItHiCl23nCK5Xk+BoFafwS/I9imX8Q4OCFyNLQgv1XlrlPLtyCBxpQihZZ
         +jAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551198; x=1779155998;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=abwiV8FAj3WFXudebX7tZFapFqnPdETLgcUK/xD1jr0=;
        b=oPlZWFzGiiFU45NWqoLsGphFT8oWQBN01diKqNo5RR5gdHA2sho0JITpZwiZ1unZMl
         mhINe+4ES2IWLU+Elyr8kqdxMY0JNx7fQlC3OmKEvqpPtW9XT9ralRuflEPPcdxKZrID
         ztfE7OEWMH7e6OimIi/sfcnemffD4073ZmUTZgOvDlxEcjj5vaM4WVvKOL6u+L2PrR3V
         8UyCfKeb8I+O1mTAWIbbiFjtlu24zijV/Y3u0ya/YSIGHQ5l7VQI9a4K8kTLeW+pBbJR
         GClvAl0pQQ4ZA2rj8Y3SQ6rIRkXEb8betL8j81TvVdqS8C62LrKc5MMwayj1bzFkfCFT
         ejkw==
X-Gm-Message-State: AOJu0YwZu9r7roDQoPDD/dXkE9dynHGtNstSHVHi5AFDaMuuJ5fSfura
	y9XbPDMP+QgoLljYDu+z/xHx4vm6PC/uVdBH7qWKlMQj6c2BydKwjLdm
X-Gm-Gg: Acq92OEhJbUjUOl32EW6DhnjYq5RKYO4lu3KNhPIvfbg9L7GMGr7yUYf7p3/xBxO/GU
	mtjIgTkViOXHCWtQeaeBu6Ss6dF2jCxzus7RYDUUCZTHTD+/cgiBbG/glwx2pqE4fJatJj72YTo
	UmMWiIKnw6J7HgXumHQFB8Le8G8VvR39HFuIxJ5SizbThaD4Bcxw4RTjvXlVNSXJ+Oheb+KQGU9
	CmhBRkbGVcc1TiaEM2QwU6PSMDeZfm065sqvlcpLa/24H5YrpQXYbt0JZDoOIl1T4DsIGcHcNOS
	90F8rczMjh19oV6hru1AGbDdn9iKsF9s77fZUf3YmlZ1je4Wcu4CWUjuB1pqXcc/0WqqxvvsXvw
	bdPIjJJj1zc55FFjI0FOnuzdcJSTfKACn6KpyHx8H+7G+o59oeMMcyben/omJS0U483wZIqv8Rc
	fy9oQnkDOoWHbTC4CHDuVBvBOb+dlN7vFewruYkteSTSssttCA6Mee3nerd4J9J6SvbmaetGnY7
	bA96XFOpbHqIVxf/LLtjP8UrGM=
X-Received: by 2002:a05:6871:80c5:b0:417:a283:9c81 with SMTP id 586e51a60fabf-4358928ba76mr7224298fac.35.1778551198284;
        Mon, 11 May 2026 18:59:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355710cfccsm11979795fac.8.2026.05.11.18.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 18:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 18:59:56 -0700
Message-Id: <DIGBS3WKQN94.1YYMZM0K6CETY@gmail.com>
Cc: <bpf@vger.kernel.org>, <andrew+netdev@lunn.ch>, <andrii@kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
 <eddyz87@gmail.com>, <edumazet@google.com>, <john.fastabend@gmail.com>,
 <martin.lau@linux.dev>, <pabeni@redhat.com>, <song@kernel.org>,
 <liamwisehart@meta.com>
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, "Mahe Tardy" <mahe.tardy@gmail.com>
X-Mailer: aerc
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
 <20260511085344.3302-2-mahe.tardy@gmail.com>
 <20260511182019.69ebc7c6@kernel.org>
In-Reply-To: <20260511182019.69ebc7c6@kernel.org>

On Mon May 11, 2026 at 6:20 PM PDT, Jakub Kicinski wrote:
> On Mon, 11 May 2026 08:53:41 +0000 Mahe Tardy wrote:
>> Add BPF kfuncs that allow BPF programs to send UDP packets via the
>> netpoll infrastructure. This provides a mechanism for BPF programs
>> (e.g., LSM hooks) to emit telemetry over UDP without depending on
>> the regular networking stack.
>>=20
>> The API consists of four kfuncs:
>>=20
>>   bpf_netpoll_create()   - Allocate and set up a netpoll context
>>                            (sleepable, SYSCALL prog type only)
>>   bpf_netpoll_acquire()  - Acquire a reference to a netpoll context
>>   bpf_netpoll_release()  - Release a reference (cleanup via
>>                            queue_rcu_work since netpoll_cleanup sleeps)
>>   bpf_netpoll_send_udp() - Send a UDP packet (any context, LSM prog
>>                            type only for now)
>>=20
>> The implementation follows the established kfunc lifecycle pattern
>> (create/acquire/release with refcounting, kptr map storage, dtor
>> registration). The netpoll context is wrapped in a refcounted
>> bpf_netpoll struct. Cleanup is deferred via queue_rcu_work() because
>> netpoll_cleanup() takes rtnl_lock.
>
> We have enough bug reports as is, let's not merge unusable toys.
> For any use of netpoll by BPF:
>
> Nacked-by: Jakub Kicinski <kuba@kernel.org>

unusable toys? What are you talking about?
netpoll is already called from everywhere.
bpf_netpoll_send_udp() won't add any more bugs.

I like this netpoll approach way more then creating and keeping proper sock=
et
within bpf and all head aches of keeping it around and doing send from
good context. With netpoll all of these issues are gone.
Just bpf_netpoll_send_udp() from anywhere and it works just like it does
for dmesg.
