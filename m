Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635743;
	b=B4yturwF1pE7X9gdtSV7sW5mrVtauU6cLOU77UsW9tSfyRMA0dNxh0ebz9WT4O6m7F47
	 fPizlBsUQeoToelrTrums5+PhFeBVtxqADUeDUKqtxbt2tBizhD5dbtUCaPNpf3rsTcGG
	 0QxYzKzGJ+aG70wuAGwu9hbjAZR5gtXWPJqb+5swSLEjwo0cZSHtmluagt9eErpbQGUOX
	 XGn+zAHJvEYUVuVhKV2s7jKsjfyxhKrssbZjgXfB4fVJKpp2BVaSiTQbqjEnIiBt+chAR
	 vz//MiizlKqqRyQycew/h3n/j9mo0EfynIv+deHF+g1EbcfNQ5BIquHW4IftdrJjmMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635743;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=XxjX1g1mQUEUPhKLrpLxYSgZ8S+x7GSgwLX7BwyjX7g=;
	b=VbG0t/yW1BTCR63EacDcdHKvNmZM8FGB3t7l6wsfhCHyHwDCURC7U1iJ8Pgfm6T8Z5uH
	 PgLY0jatkATaz5AJN3SEXPE8XovwcqSrvTf3hIw50sQvqMprtN7Qzdct92QFI96b0qgSJ
	 7U80oDAR5QiG0bJxYOZZLUNlcCoR8MGC1C2/XiDdWYTayvehTkoodgoWFPkHOG2PCXbI4
	 Jvsezvwfx3HLsx6gstEXMLRbr/XbY4zH+BHP7O3cnRfZYMFMTTvaIuVWwnMKXMElSxhk9
	 HVB4tRWBC0P8jYK+FqktZYJYRH5djbc0HC7hy0sVvkSNChRdqlGEdt10etIYGUW+eUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sS0MesHX;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01B606A31E
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 02:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C01B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sS0MesHX
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070755c8cso673004b3a.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 19:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792635742; x=1793240542; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XxjX1g1mQUEUPhKLrpLxYSgZ8S+x7GSgwLX7BwyjX7g=;
        b=sS0MesHX2nvWA2URY0k8Cne+sfJOI5PDPY0/f9zuTS95LHs/n/U9E8Pa4fzDUDcan+
         Y9rcsec7bezD6Guv7ewLXhN25+qbv8/QYe+Nt37G/XwT4gtFsAw4dBx/scmdeSeprx8F
         yyYmOQOxj61oR9X1k4gckGNgfuwxjCdGgyxCQFj1M4GVJ4knVIsYp4O+Vpxpl2Ncu06y
         c78So+Vegffz8XffqmKkG/C++ukW6P3hjj0QtBPdRBMEZ3yxU/7oayY14RY5Y/KYxQ1q
         zYqw5lr40dCQEe9v04A1K2soetRjLIKPH5jCosRLRnOIYPu5etD6U75ESDrikvZjJQvJ
         nS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635742; x=1793240542;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XxjX1g1mQUEUPhKLrpLxYSgZ8S+x7GSgwLX7BwyjX7g=;
        b=RsViUFejiIY4QGajXmAOZnxKZ7QjHkiRuLBJT13+VAaHOYS/XjaSmAC7eeWHEfELC8
         1vISuf49IB2NcPG1QNOUnwPmtGejD/0cviCA/QIvmfCEZDUxOeZMsV1jqx5p1NHGR0Yz
         peSeCJGO8tf+XowcJU9yFsDzvVmrL8hJVhO2pONqr14n7Y8AGqOjJwBMvBU2pfJIQoj2
         TN+/mKf3xhdsl51bHzMi4elHUW/KsuZgJ6z7DMfndBE52/9hLL2D+Y82lHHW6vP55ZSL
         2jLa6VT838jlwNcXFVFspVnRlf38X1UjPSoNecDgIpLF7lHD+YntwgiQHjyaFNoaZS4Z
         ABxA==
X-Forwarded-Encrypted: i=1; AKwUvBxQE5AwbjPCajWehaPwXSkByJTmPPiLt0vxdQXKC1XnrO4F3K+8EGHHqN6PMZCJjzwcqes=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9JVllhgaoMkuhcy8O59n0ovYHU39MSj0ZNMB3L1YMWi4Ddb9z
	g4Hdwk0YHY7TGcKOyyaEExIDmZukNn6ljPqtvbkjgPEvK8fUNdGgvRU9
X-Gm-Gg: AYBFou1RYRIU96GZRoLHxSDuljm1vvqr2EEaJyn0Zn2gZW78I7IO7e3ngP5xJiqCLnP
	CIQ1Rf4VkuzcOekyL+smDv1pqfVGfnVUGuVJo7RbOM7cWpcVHKaHDCk55szQ+58KjINBGeaB2ea
	IWfQYyIsBSIL/9BEb5OSi1zC7FwiaLjcmxE5WLpQUPhE0ucGQquJgV8WxNiyExtJrWLlYEVxhw6
	cHRjpm4HhNRoZzhIEMlVOENp5m/KUgXiPg7u6pF5LampPQHza1SIeDrM8VOILpv6jkR3j2cod3Y
	aSKWB8poR/NEVu4JvKx2ERpM0T99n8UkqFHf8C7c+XKxYd914TQYyGRkNi0Be5E4wmxIkUgKmKw
	r8bFH9xAkRWj/zoVBdxtL3RKxLIWcvzFg2TbKoirPDZuo69AtFFvJmUKnmJE/VGU27aNCxP0L/n
	tYCxQJhXlHM0T9CzA779gODwMCR2OOScTo5VuVgtp9/fuNkcJxTYOLckNIqxrl1dOmg22w5XiBP
	TbvxGkCw6hkGzDdZnOgUp12e5NlCvamV0S53p1VPLvv30RW7n/Rx9ZWc8dM93NCU4vq2CDs41cc
	9iR2+IE/uEVKn1gQn9oFVumvr5fMMvbMk5xAWzfxWYiA+H8VYifyNLpLG0Vu
X-Received: by 2002:a05:6a00:b49:b0:89f:37a0:b2cb with SMTP id d2e1a72fcca58-8a089eba62amr2905819b3a.49.1792635742236;
        Wed, 21 Oct 2026 19:22:22 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b4206sm1450303b3a.18.2026.10.21.19.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 19:22:21 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 02:22:20 +0000
Message-Id: <DMB0C24NTIST.YQZ2Y3E0I1I1@gmail.com>
Subject: Re: [PATCH bpf-next 9/9] selftests/bpf: Test uprobes and fork()
 with busy mmap_lock
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <oleg@redhat.com>, <peterz@infradead.org>,
 <mhiramat@kernel.org>, <jolsa@kernel.org>, <akpm@linux-foundation.org>,
 <liam@infradead.org>, <ljs@kernel.org>, <surenb@google.com>,
 <david@kernel.org>, <vbabka@kernel.org>, <jannh@google.com>,
 <hughd@google.com>, <kees@kernel.org>, <mingo@redhat.com>,
 <tglx@kernel.org>, <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-perf-users@vger.kernel.org>
In-Reply-To: <sashiko-outbox-180860@kernel.org>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-10-alexei.starovoitov@gmail.com> <sashiko-outbox-180860@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
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

On Wed, Oct 21, 2026 at 07:10 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
>> +#define AREA_MAX	(64UL << 30)
>
> [ ... ]
>
>> +	area = mmap(NULL, AREA_MAX, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
>> +	if (area == MAP_FAILED)
>> +		goto err;
>
> [Severity: Medium]
> In tools/testing/selftests/bpf/prog_tests/uprobe_busy_mm.c, does AREA_MAX
> overflow on 32-bit architectures when passed to mmap() in hold_mmap_lock()?
>
> Should AREA_MAX be sized appropriately for 32-bit architectures as well?

No. uprobe_multi link is 64-bit only.
bpf_uprobe_multi_link_attach() returns -EOPNOTSUPP on 32-bit and
three of four subtests attach with it.
