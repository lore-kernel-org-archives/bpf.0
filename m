Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3B34D91F
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116157; cv=none; b=l0G8HGk16OT74hxXRN3MT6jQ/4TQrTDjJCk0W6QdOXWEtP3jovmQEMUIiDX5I7R9rT/G/Ze/oWGIKEzFIIgMMjitIoSqFpDP40aHt6HUzMtWFUOboKcI79JGS8qdEgbeRxRUUye7HGCfUXDEJgPnBJDfRqfle9nBpFWaf3kSCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116157; c=relaxed/simple;
	bh=XeCC+QwADRgBYYy+sV3a0cmsO7MHwysfHbiWbHS7/p4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=dCeREDjGAe70VTHJBKq1JrmKsZBN6SyAlOYCokQOFE8Tk7yooM3s8G49/J3PAftInDuO0/4yV6jHzbgBdkWHf+5BEdQtN8E9oBd84BxIIod7vSDGiTqMRBSSWUb3VeH4M7NcmA2W/fcZ+uZC9i5hjoL6xsvMJ0W4568ivB7RBaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvPN2pih; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvPN2pih"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso2548962a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792116156; x=1792720956; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hnHIBEYcvc+7lyURaq4Sd45WKeYqlYDHTj/eD/bNuQo=;
        b=OvPN2pih9i+U/HeSGOFm9RRU6HAVG6xX8BU5ZKmewuBe1oG/uEqQKAveyyUWa4rEVY
         PAKk4AE27nhv3HGN+hSNHC0yVngsMBKR95MYtxwUlIL+HHrhZZyAH3NrpLXJF9a8h2HN
         BXENRq+taChhj9xasmn1Vg0lZLhaRS5iQ5Jp0MfNANMmc5iAFvtE/c6SdfXCEt546n09
         9HLj7AlQ1bdjcwq93bXniab93poAiCS20ta4Urcx7Ukf0Cq75b4vp9VNb2FtNIIsB7V5
         bfJpOEgO6sh+c68rbkSvyVGZxsWkA0Tq5xYS+qXQFiyedCApJ72Vcllw1KZFleGPLcgE
         46Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116156; x=1792720956;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hnHIBEYcvc+7lyURaq4Sd45WKeYqlYDHTj/eD/bNuQo=;
        b=LIYTW0fD3L0iy7J1kYg+ps71A7UqK9gVzgZJYC4bvBmQtYGQneAXsghLXtPmQRHnOr
         NKI1SnyJUrS+1boLDkPJEjn+7R0gRNDAJlJDSq1Lmojk3F1u/4Q0XNlJ2IDAURUSq+nj
         +NaPJyX2ya8IrMIH8XjxfNACQF6XVNU3f4gXWREHla6iJnL2T0Et/IJXDWhXAhQaq8RP
         HtXwTgRquyGL+BnUGSwqSgia2GRVqQAKwEVTpaLp5hJAXKbfWwGYI3cKr7e+IdB9kVhQ
         fZRH8yvmr5ijvRKpaqnZLtpp2XKAhzd8dNVM0RkBPkjuotes6qT4/CE0gHuPc6NVesuI
         qWbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzh3tisXGFA+ri92U/R/dAjeu5FG03h3dhcS4bv0ipW2cLlzVfzgQKvlsZqf7OYdVPVN8s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9tyfDh+D2zWnfdp9+2aXHJ8p839PP8x+MWfidf9By1xyvs+lE
	hfZM1T72btsS/qfZ+T+xomUeYQBozjicLxsdE/o/HKOACNxrRNViuNvXOpkGfA==
X-Gm-Gg: AYBFou3JOZUhuzT9tqiu+/KXKWzf3FEG8Wo4HtJg5RLyQ5yvj1E2PibNi/5aNZeSroP
	Q73UuXrzCBUU6sItMIyzSWkihxtvIqIz4FVKOj9HlUIhgiHll4zW1W1JPMk3BOUSgUV7ZBBv8of
	4iWn7G0Q9NowJq0NXLGY1gzs0jA7PhoAoP3g+UCMxTnsOhCrbY7OkT25aIPkvnD3vCQ9ZB4xNfZ
	5xXav4Go38Z4cCZekps/umGzM9mi2KuWKYSRPmbudTWA/dK5fkKb7TqL0VQZP7Vai5vVeF+zf35
	lwgF2QuiSVNa9azVHe0Qyy+n/lA0oOxSsXTviACKh/+qa0RRmLFJ1hn8PXre0hCO0CBibkyGp2h
	wsVpP05+U06TjFcu57w4pUUj2ddvuTLzlFztP49i3gpi/S0y+kZIp8Wf3wmsBkEnEA0PGI7arL0
	vDw/TyhIfvq1oLbw3JWBqfIXSvTfPkztzwazk+KWCgh2uJ+/4QKszXnKtJoXt5RY4baf9mjM46z
	0z5rfOOnQ3TlWNlkjvTofam/J4rSUZG1wEzktIYTjoajZpig6SMEUmh/nIrCF80+RyYu6leaJPH
	dVQ=
X-Received: by 2002:a17:90a:38e3:b0:3ab:a188:b8ab with SMTP id 98e67ed59e1d1-3aba188be6emr9607436a91.1.1792116155979;
        Thu, 15 Oct 2026 19:02:35 -0700 (PDT)
Received: from localhost ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac9474b52fsm7661513a91.9.2026.10.15.19.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 19:02:34 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:02:34 +0000
Message-Id: <DM5W5NS8V9ER.34N5H0EAW44K5@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 1/8] bpf: Use mapping tree to zap arena VMAs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <20261014233442.8392-2-emil@etsalapatis.com>
References: <20261014233442.8392-1-emil@etsalapatis.com> <20261014233442.8392-2-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Oct 14, 2026 at 11:34 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> This refactoring is necessary to avoid deadlocks between arena_vm_fault
> and page zapping in subsequent patches.

[...]
> @@ -89,6 +89,7 @@ struct bpf_map_ops {
>  	/* funcs callable from userspace (via syscall) */
>  	int (*map_alloc_check)(union bpf_attr *attr);
>  	struct bpf_map *(*map_alloc)(union bpf_attr *attr);
> +	struct file *(*map_get_file)(struct bpf_map *map, int flags);

This is quite heavy.
The deadlock is there only because arena_vm_fault() in patch 7 sleeps
on opref with mmap_lock held. See my reply there.
