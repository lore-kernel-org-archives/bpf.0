Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45A353A8E
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644142; cv=none; b=Tf6advVsPXFCrv6ElAQQyfjsfrnumR+cpaaDqMHrxCj0EeKfBMBkE3vC7dgFAF7ctUIjTMUz31xxXAh3e42Uv9BJl7C3HukwlDqQrUHyD6mCug7n6IZOvlph5reZimzZOrNaBL41BXCSz1XdvYHGZe1cocaTAgYQnUqI1M4CcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644142; c=relaxed/simple;
	bh=K1anK7ermLyljJdUOnkPbudUZBD0dhcLb1MXiyRyuos=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=oD9z6Qmh5Jx0SZgKl5miAVpOOvDCFkUQquyEjSrSHnWffDPDs7dowRWkucMa5mlsybQXNWl1aHJBfwfsz9/OHVsqGQiKFMrK8vrJI+NcZtQq3NPDVI7H3lem781ednvfwcrTchIVBW8k53yoZ8Ljj4QvPX0wSxPAd0dCMfnh9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6X4S+0o; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6X4S+0o"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso208880a12.3
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791644141; x=1792248941; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y9MdWwrL6HyhifnAJtfaGhfthnB3rL3CnMKkRHEj95k=;
        b=o6X4S+0oqhzURTEeTPbyBpn7MxwF85lzqqLfk98XnA1s9CxuAls6oox1rrehIrXORg
         NIyqbHx3nv7aZ8BInStvSA+8BQz+gMF2jbwNc7UdSblpcQZl6cTqUNFx3SESYMDj5nQ8
         M84cayQeaTiaHUh07QmCAiIY6ep5Edpi3jpuottDCxtskvJQX3neF1p5RZhHffvNrvP5
         44LRhNjT/+ekavSMUuGlym1DnsGUiAxHnxXAFwi1+ggeb6zgGwWh7By94OnQzfY5jdZF
         gj/jfgIoULu1JfEPvKkjeWvwp1HkM/y09G65XIfb9APnuoMTix+luSFI5DFeVzR7lc9a
         SWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791644141; x=1792248941;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y9MdWwrL6HyhifnAJtfaGhfthnB3rL3CnMKkRHEj95k=;
        b=JrFM43ZLNNhAe3IjbkbLpyhA/Y25aU8x6BOl0GiWxd/8ogpQ7StORLqTAezWkwIgiv
         L0hsauICNH+nI9i/10RoGEjeOOiCwOJe2gG8HRJ9QEk3FuYCSPmu5fziv7ABuPF5oUj/
         BAyxhRuY1Y77vpdEcIr4WeRGOxcAb7HQbZRMzZRnJ9gTURBUcyiOC4OEw4CNVbtnCwI5
         R2ofMnlVbhYGfSlY8zmUntzKSvu9Wpr5XnYMCfjjSkTC4PJtdyPLAlSVafISIGB/xHyO
         q2fZQpsBF2rLXNZTyplxT7/pPnkfg9iZ472jXMEzI8nDKK5yseq8tbdVhp3uLI4I3yEG
         fpzw==
X-Forwarded-Encrypted: i=1; AKwUvBywgvmGFWOswslR2uLcwQB30x4jK0+zc1guWDaXJ8dJRBX643vtO7wnBphY2QxDpAOSV30=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuD7MDFIBePZ4WViiLKSZSj27AYvQeVRpdyidaH1SupvduiF3l
	wZ5MNZDDbK3SU+kMjlAVChAqSDaGXKuDcp7mux2mYXUBffoz9LnotmzStbKCL/EPktk=
X-Gm-Gg: AYBFou1XTBsRi9o7qWd/fzQoliPm51q9U+qAaSE/+AbR4V5aMs8FzUXkb41xlTD+W+S
	TVYJDcLampYt6qaELBe6KvaZpO2EpD6gqmYaf1RCrZrGI6eSxK1AIei0OfH/d7pyXnvMXJrGMNV
	PgraVjxffJeOkz6fBXo55LKeDHmo33j/ey/AmzRc1MtjVDBOotIyKwkH6//R4c9LfJM5mVMCh5c
	gqhF7gj5M5e0rjvSu3c3usKbrTBnzM/+YLTRfhqGDjvwZaa/MEMbjrhdG7CyVz2NmY/RZw2bNRR
	nxxZIQpHnt/h1NzIselOCQOTDMMtl1mlGCj/9mdwFYbEzU6wOhXbFOjoORetFKbShVXe/oDWbyA
	JqTTvtQL7iGvcsQvH+fsIbBr9pDdvClg8VSH4FJ48yNX3a2B2N38w2V3d+Nw9AcsiM2WHp3Fv20
	oc7QPnQarcwL8k+pqbGiRRYdSGMtDgoUmFMhvjmml+ZUvmgL8QZUlgmEX3HmywluJeBo629rqS9
	vZWqrQCpo+rvqEBmdTYeFwBPWZNLtSF4g3LoU05QmujbKSqPPo9Pm5AO89qPOR1ppct5lR13kHL
	jyY=
X-Received: by 2002:a17:90b:4b:b0:3ab:2c2b:1030 with SMTP id 98e67ed59e1d1-3ab3a747cfcmr3883080a91.22.1791644140387;
        Sat, 10 Oct 2026 07:55:40 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f46dfesm8487649a91.8.2026.10.10.07.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 07:55:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 10 Oct 2026 14:55:39 +0000
Message-Id: <DM18UAZECYI9.1RYCRB2FYDW8S@gmail.com>
Cc: <oe-kbuild-all@lists.linux.dev>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <kernel-team@fb.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 34/51] bpf: use SCEV to widen bounded loops
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "kernel test robot" <lkp@intel.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <202610100928.qjEH6jQv-lkp@intel.com>
References: <20261009-scev-minimal-rebase-v3-34-bcba9bc53ac9@gmail.com> <202610100928.qjEH6jQv-lkp@intel.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 10, 2026 at 09:25 AM kernel test robot <lkp@intel.com> wrote:
>    ld: kernel/bpf/scev.o: in function `compute_max_iters':
>>> kernel/bpf/scev.c:2062:(.text+0x1193): undefined reference to `__udivdi3'
>>> ld: kernel/bpf/scev.c:2067:(.text+0x11b7): undefined reference to `__udivdi3'

Eduard,

the series is in bpf-next, so all 32-bit builds with BPF_SYSCALL=y
are broken there now. Pls send a follow up asap.
Every u64 '/' and the '%' in compute_max_iters() need div64_u64()
and div64_u64_rem().
The rest looks fine. base/step are u16 and imod() uses div_s64_rem().
