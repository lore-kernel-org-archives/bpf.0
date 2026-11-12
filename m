Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794471411;
	b=fsAqQT0CMtm2f5Hrwmx76/ddpufFFr6cQMELp9Dt6RvFLvRRaBmJmFH14MbhLvWIMSIg
	 pqhnjdgJPqms3RlWsDF2P6jEHKz5A98w7hS07oZSzk9ryh4aXRzZusGpBGPXyFykXVSkr
	 eQoOV/P1vqyhpXtlOe5jv//IQ40xAbbpsvlQj1lrxj/umf6nwCp4mDuGwasLrSLVZ2kU6
	 8vxWNgZpR1x00jm0YK00AZtSCySgZ4AtRY91i/6v1H9O6RdQb0+xGawXN6iGM22NDHBRl
	 9gq31cExgSSP/M8pdluSA1F7xZO+GQ9E9rh2aQPZEtCO5ssQBr2V25FquPo73ZdSo/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7a0tlXjZIjM2y8jRkqPsXOqBGSfZhqpDFXwLVtg4q7g=;
	b=JStfPnGvUIickc+V/vXjzO9PR+yhoxMQSctfPPp4FnTApPMNLtug4Mh3oTtI4pDnqtlA
	 xsM70rwaAlHn31p2m0AYE/TMoZPrLzGsUuvXm8Hrs3uOioZ6HeOLGYKD7UtJG6beSfDdC
	 Vm5OHVy1Prz74TdGmII2KwurlNFr/34Q7IaI4t02qgBTcBw6P9bxAL8NpeCw3jIdXdP4R
	 CBomXaxupSfjcav0pWlkbpOT5v3rZkvyLFOT0WXNoe3aFC12sImrrDcHjTtuZtDAIR8zf
	 LAw18wEerEILsaki9Cr82CvlZyDMbvbhd8bS1n1Vd95cEHW5q2E58Yfb/hvBY1kdVZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoPdHi1B;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73A606A327
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 08:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E73A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoPdHi1B
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2eb0f1b592bso15432775ad.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 00:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794471410; x=1795076210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7a0tlXjZIjM2y8jRkqPsXOqBGSfZhqpDFXwLVtg4q7g=;
        b=FoPdHi1BEIGYGOBQ8jpJJIMmkvpoD/bZN9zxseg4DWxtKOIMnkgyW2NgswJLpCTZGz
         p1+TfM59lcC2EW57qxPryBMIphXUQabOQu4Jx3o0cQEA5eVZW+q3z4oJDaTU65prWjun
         xPePBDtG7BRbz22ciNdE54qMSG4epM5qM0kXyzzkDipV444UesJJDbPG36nehwmBBehr
         XpRkNix741MvHry8gMqmK4NqzYLWkh2hZ5suL84EPYn1Fx0TkWq1AU+EG6SsbPXWULUX
         KOumUjbA6kskBFStVoYgOt8c9Gmi/rcShFFGhETqGd0IDRbejzeHrKPwCPTnsu1EVgph
         a86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794471410; x=1795076210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7a0tlXjZIjM2y8jRkqPsXOqBGSfZhqpDFXwLVtg4q7g=;
        b=g9kNp18EhSEED7BeCo6f5RB6Prs+5N/E4Iq26VMU67DAM1RtUftq/KqLTAv5qaSPiu
         mFPsdQtZ7tQLnvh3PTtqbctYod/TsBZDTGpWBmYpqXhNsAo00QuDm0yn5K2e5NjAQo/r
         qyEHSP+JSLW7YGOPE9kR3U7+L0fEBCIOtJF1dtUcQirM+9FnT8z8l8Aawgn+km2dR3mx
         OWssE+URRMYqCpGvYooZP2bh45eP8ilQ1TpoZbmuH/LOKMi7y/Hn74I8Dw/6ihswoVhd
         iu5Cc9u7w5TFhKGRttPLFG/9cn7Lj3KsDPdomwSXIW0f7PLW7oXpX1WhKC+zXMn3Q/o+
         6xPw==
X-Forwarded-Encrypted: i=1; AL+hErEKWixMVxcTmLMC6LJAjBMBbfrLvJtuo7sgvpPqvvBsm/ND6QHyOAV77jZP+wSNLYZfYPU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9O54vvMh5IPwddYYDRgnIRSZ02JuxI1uymbWAT+gIK7SaXFvdi
	vZDbNcOElwFPuIgEZ3idA02Z/hqJUvAt9l9yHIs+uh+LlbEye9oZ6Jff
X-Gm-Gg: AYBFou3OOKHWjXHIVfQSL0xGEM/juYZA2TcA6h89rofqS9cJiTWBvjNC7/gk4ZLaz/6
	luR38PD0pvDfwChm4yJOPBfjhtIsc5LccUyfkXoO3LFCUspaq3CskEjbiiYhYdSYWYbV16HBsMA
	RgtM5laNF0iR/XC7Rl45rnoW82GEX7wSExZmdiofTKs+DB9t3TvXdLVF/UPNqnQfPavXBbhTzYR
	k1/kXdtjrbFGDA3kxtfUqUeBOWTgi74hLUkXXS3iBHm4cuMZG58xHT397Ocf5aLWvo84NuPhDSQ
	xXTp9bdq6cHowdDMvR5Rk/gTfPj0qkPGMekCH09Z+9IeGhd3TzrH8miCCMrL8LUOp8zH9vb98J5
	xOIkL1Fx7HNo1tmTRXOWDq1E6gpmcqXhV8BtTDusqcJAgVY8LjvWx5WNlDI2Sm2HDZvAVHr/hH+
	XrTvBQlav9Rcq6FJVaRyIG3PtJxCTgoBBKM90oTUr8UJM3Sk2l7IGJXyAPuyq+3Czv0ZLo+ArPG
	FU0z8b42v+Kxjg1XcooK/aHYusCl5MgH9cgYi67HOVDTNDRSGz/YBiPhM84ZoWjZk25BEL0tCRk
	b6pq/jlgZhyWROrhNx4XeVkkKa4hgxOOIyenkvHeUoJ+R92Q4ASKEn14/CDWjteDyjlUNIS9E/8
	87zzqVHml
X-Received: by 2002:a17:902:f707:b0:2e5:38bf:cb43 with SMTP id d9443c01a7336-2edd7432537mr55445995ad.2.1794471409521;
        Thu, 12 Nov 2026 00:16:49 -0800 (PST)
Received: from thinkpad.tail59a646.ts.net ([112.199.224.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4dc3bsm29970705ad.17.2026.11.12.00.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:16:49 -0800 (PST)
From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] uprobes/x86: Emulate ENDBR as a NOP
Date: Thu, 12 Nov 2026 16:16:42 +0800
Message-ID: <20261112081643.3983403-1-hang.zhengyang1010@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112080406.GA2668804@noisy.programming.kicks-ass.net>
References: <20261112-uprobe-endbr-v1-1-284a47a5ae3e@gmail.com> <20261112080406.GA2668804@noisy.programming.kicks-ass.net>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Nov 12, 2026 at 09:04:06AM +0100, Peter Zijlstra wrote:
> Uh, no. We must not allow uprobe on ENDBR. If we ever get userspace IBT
> (people are actually looking at that), then putting a probe on it will
> make indirect function calls #CP.

You're right, I missed that. I'll drop this patch.
