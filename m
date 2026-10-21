Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549417;
	b=lqZc4eDpRy2PcmN/NERe+I1bWZAwZpZN4ouabHlHyAkih+CV3OX2gJ15D+6asbfs+TeL
	 CY4kng0H92hFeu6yigYMEpqI5I1sQxoksH0cBtww5nVp77qIij+7bfl6SX2mIEyVf6OQC
	 KV89+p21ruvOdRjxZmWPG7OkTYFcGZIn8EExb8FhqCvi9d1PUwu+pK5K+gw4fzD+uLK7A
	 +E6naZjMuI4HSE068ZuGheadsdWu/9f/SDElx3QvS7t0hok82QkhFv3XQH5+k0qLU8kRG
	 nCO7NyRn+DB12XH5tHL++HjJTSFz1k4RdInBm5H1Dm1drp7W+H1TUa+x9uGvESI/+Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=ouuFtypaEJ9ckJXUmMEhOp8/mEcn0FyKt1h6MgNlrj4=;
	b=zqYqxpI+gxkNVCJgbwVjx4ERjHm6hYP0un/5rnqoZFYZ4pdzFLauGDM7MUkyHQ2MwLXe
	 kzUAHL3UsqzjLZe1E1WqOhwtaofIp7Z04XePF4Q+jW5ogKWnfJdkZsT8ryMJ25VKv8qr0
	 kycIg8300TyZA+lo+1ZTJXzDdCojMJiR5ma3FCWjs3SYR48C/vV4cKB1/4oayFyE7rJH8
	 /4ILVTCXTKn5Utumpu4EUUKhQcEVtua9ViGhhpAKs/zK4wBDRvBKDosX43vadlmXzEOGs
	 3uw8aljAjkfWp4vHeg1cOFwdTwT2S967QwO2PHdBNxiVuxREbTZDP82BZ3zZ3Pri3LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=mvTRJBiN;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96E4606A320
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 02:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B96E4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=mvTRJBiN
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f36c18b75so16864085a.1
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 19:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792549415; x=1793154215; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ouuFtypaEJ9ckJXUmMEhOp8/mEcn0FyKt1h6MgNlrj4=;
        b=mvTRJBiNayBZ832CCECJySz+ba/5fJXFzuDem1u7b+ZYvUSUNCsDV9z9w1eSMNPqOh
         wQfrXPnvUwf73h8+wZr5mR4HHDf0uwB+bzUjRXnQDDjCeoHwhrRoMviHfsKae+xXqk68
         MACjf9bd2krFLykEoKwkred2e/6I32/5xwEw7sv3wpvdXlPtzBVy9CVCMXJzsQ0vKxJK
         iL8TXTsz+O5axi5LOdJi6hdyulbqG155qB0x0UUy9QRNdXmW1UBpBPCwxML/AKOMMqlD
         /tAD7DVi+Cs7D4C8Ru4uy75DOcwvkAWYE5oFwnxtSe4AFxne9eNB4s/9ck75elf/q9GT
         7JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792549415; x=1793154215;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ouuFtypaEJ9ckJXUmMEhOp8/mEcn0FyKt1h6MgNlrj4=;
        b=IZvfwV3GJzpFXs/VtOg8U/XiKfbkMEOdTBd7PXK0EBhKjUNrRRP6reAjghg3J8KrqD
         RjdAUAvuxiApMCSEvQvolJVSolrn3jnfBY0OIVZ6pU/BHL3ZSWI4kcZwb4NzLmCtQo1l
         yMdpfqTqZZXlHbfdP3lBCPzaFf/248RSzZcdrpZ2fiZg9dfqzmCYaw07FiKNoy56/UXk
         xXCZrIsVNc9h0a4jiiEeCfCXPkMTX5yOUkIc4mQFO+AV80rcgIIjN7ODnVQW+TU7e58z
         0T1FT7zOYT1g5w0fxdBS1TEfBj0YucvSkc8oPQ+dOGBVP7W9DlAZ0QMeHJLLVnZBqqjc
         ZSfw==
X-Forwarded-Encrypted: i=1; AKwUvByZlXQgIdOgWR7J0PfuT3iohJ4Gevl7sOJwwJDXu+7DdQQlpUfCLV66ITuS7R5e0mU//FA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkTaOz/4uijWpS0PFpBV+dM6oIcYclselQ+xer9udetvNfr9yW
	wdDYCKdJQMohfnkMNl+2yE8jVckqCCg2ci7A4jq7Xbt4wtyWTrp1tinq3pHs5kWNmkk=
X-Gm-Gg: AYBFou2Lpbr18fJgxbNQytAbUnenIBAIsr6UoODoy2+uEYplJZ/EPJW1qCZmCdw5Gnz
	j5jIvoZS9FehSgYMrwrwIZ4CCr0NWxOsr7+nh1O6XfI28N+pJTsWx4GXUnBMELzcUT4XEWG+F59
	WgEq85IURPSkt+xdY/PoetHqFTG+AiqZ/oRferniQAOwHJTcJqEAKBvm1wYD6kvhO5b4csO2eP/
	0msht5WMT2LVHZoPCYMtyk6E+QO4ecVU/OWyynPm8BLkxvRPcw63bX0Mdr2jrQ8UFuhzZQPXuK5
	Ozt1mu2rtMk5BIKPNYpmkt0/AKeHaSOTXVW5MGNoevsxiyK6mMfNB3vxdzWKqIf255ndz/msh6x
	korO8Mvl76ps+ZfDlUbzWICNefdNInLrQUe5kRLrjcUbl9BQwgDSbXXsJ+CtoO5/qA2Md6BIA79
	f/3M6HoamnfFO0qE1kZ02hPSgOm8psosmP4EiWRj/MMjdn2AEFSc6V6wpD9nAXCsxT/mwsjI8uG
	Vaav5z9WD3Q+0N7+4zWUN9jOnXBYxXtCcjvM2r0EgT52vyhjVnXqNc6w9NRefk2Lqqg2Pg+Lsjt
	J9X8vqJSZamMo8vN9lh0kGA8dpFE
X-Received: by 2002:a05:620a:4621:b0:93f:a7e:e0f0 with SMTP id af79cd13be357-93f57fd3b6amr186072885a.82.1792549415263;
        Tue, 20 Oct 2026 19:23:35 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56de57e8sm135743885a.25.2026.10.20.19.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:23:34 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v3 bpf-next 1/5] sched: fix stale get_pref_llc()
 stub for !CONFIG_SCHED_CACHE
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
 eddyz87@gmail.com, memxor@gmail.com, mingo@redhat.com, peterz@infradead.org, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org, 
 akpm@linux-foundation.org, david@kernel.org, gourry@gourry.net, 
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, shakeel.butt@linux.dev, 
 roman.gushchin@linux.dev, yu.c.chen@intel.com, zhao1.liu@intel.com, 
 tim.c.chen@linux.intel.com, lizhe.67@bytedance.com, bpf@vger.kernel.org, 
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261019064157.29885-2-laoar.shao@gmail.com>
References: <20261019064157.29885-1-laoar.shao@gmail.com>
 <20261019064157.29885-2-laoar.shao@gmail.com>
Date: Tue, 20 Oct 2026 22:23:29 -0400
Message-Id: <179254940965.1919196.7604748267690139512.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-19 14:41 +0800, Yafang Shao wrote:
> Commit b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_grp
> to fix UAF") switched get_pref_llc() from taking a struct mm_struct * to
> taking the task's struct sched_cache_group *, but only updated the
> CONFIG_SCHED_CACHE definition and its caller: the stub in the
> !CONFIG_SCHED_CACHE branch kept the old mm_struct parameter.
> 
> Fixes: b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_grp to fix UAF")
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Chen Yu <yu.c.chen@intel.com>


Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

Please submit fixes like these separate from your series.

-- 
Gregory Price (Meta) <gourry@gourry.net>
