Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792644701;
	b=iu29j6wqkkmAaYMuVc+93gRtvKAlr73m1nqe37zmuEgKyR1/I7dfVV33k0sm7Pawgelm
	 FhT9AGcTvH565ECwAaTDDvkRV5NbxfJbNob2hqrMDy2y0f/7oUtuC5gio4GmyuEFBomll
	 hqN2ZdsPbNfST/1InfuGx5Xv3g9lq4H9ilNujIKJopw6rzZhG9i2oyA8I3UZrrkk4f6Qo
	 j+oE0zbQOjsIkr2sV+P1DS+rGdbG+KWArRpcLyWknVCrHA/7HMm+aP6/htuyXRBcu5m3A
	 Ax0/QAuZM0WrcXJ0Xn6U+cv63gspLAaBxkyMSSclQkK2Hz3Lgj9YE9G/1Xd2z3XVDOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792644701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=DFC31NsFJ2XDzScIay+VXMbA+N/Gyxq9s/ZOy9ayIXY=;
	b=FTUAgUWwm2px7wkoDwstnZ1eFpva/vRnZT8i2XMX2UT7VFBTRj5zTywTOH6q+qZwMaly
	 gx24QipN1SRMnbshkKG59dURG4AgbsM3IIWWV0o6AnoQBM/t48Nvust2TVyZo79JTFjTM
	 qbXsDZev8/1RLTlMqPKacaWPMZmR2jvrE4LVyu1/z2H55YzjJyhQKCxEoHk5GzPqyABq6
	 bRE9jbCPV2THs1BD1QpcYfZWWKn0GEyD+5BsMcvotU5yOwZxEd0vQZ1SRVaIBoUqOao1C
	 T2PR91Ua4TXome7xmaSYOD0MQhU2XCjXMdzJK2xssMm1mdemGTihTBv8FUC0LpJpSfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s+xEObBv;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D76606A319
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 04:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7D76606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s+xEObBv
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso598534b3a.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 21:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792644700; x=1793249500; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DFC31NsFJ2XDzScIay+VXMbA+N/Gyxq9s/ZOy9ayIXY=;
        b=s+xEObBvSzv+8tBVMNm5K3hdxlyvV6gdGuyskh+Tf29P6ButleLb1Ipz4H9Vv8p1ok
         jv/s7pq1bz16Rw5t/6lfFFclmG2IgJyzpT4lEyav7qy2Pu7xc+NnsDHlULxS4QUMq9xl
         oJRiEVJP+etWqH1VgvXBCcyoo8axRLesDrw4GB/QXKMcpM5Exkp586L+ZsYEfJV09Sv2
         7PvF5dQfHGRus3NsGhZPPMpIWn3ml13Ns1k6YLNMPRt/0fpplG+4QDROzPw42aZJFQRe
         B6YR9eSrJeQeOPsWFxHuli+Yy+veovUkREyt+CNfjbhvCGSPjqh5xJ50GQDP9/LP4vnY
         9Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792644700; x=1793249500;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFC31NsFJ2XDzScIay+VXMbA+N/Gyxq9s/ZOy9ayIXY=;
        b=kcJFMW9d7WGElDHFohgDWFrro6o3rvLJDomsJPRqlaGKCvbB81hlcfV+O+BQjiKeXM
         K8AE2ToO9n2RemXToYsjmY2JwgWGFP1fhQXvGmyl0u+lQd9Gw4DUiTm22/23v9UCYgN6
         RMqzQICxC5HwF8cEi8n6EnfAdeEab2YNPHqV1a2na0WSFm9WuVdV7+9Sa4lLfPG7Zyny
         cEwCCSvkZSZXPc+EpOxuV0yFIZV82AE1CNVwXnY95jccffXnP1WDa+aDSkb749ieuSpQ
         rk9job1DPaDW0dcnT41rni5UXxVCmHfSL/zdIQy47xRDTATAP4UMdRFvT+GD4dlBO5vy
         KxNg==
X-Forwarded-Encrypted: i=1; AKwUvBxhtihtjFWEJVGq2VgxVywI9caFzUThzdY4SymklRIndvlxw8hBV+yNIYS2S4oeogK/HIc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIQ5sD4YaGizHnnyFQLBWChpTbEyYlHgDZh4t5rFSkgjTZMVCnb
	DHvxuqsmFteN6qTwT59gblGSh+Hvd9m/5bi4PTNTzTJWKrZak1gkdL6Q
X-Gm-Gg: AYBFou0uUxn/KPyEggQGO20Cm+QVTyo3vKo9d9D+q+fK2uw64e0O/AXrrdH/kyv/71u
	ZthiK4VD7/MX48q5HMpqpfYXIzBdHm2/hIBjIHv39wz5N3hXRD8Rtge5ZC5obr9jaHhHh27ZDSG
	6kzv/Nt+BKCLVnivdasDSnIwreLkMtszL+oK4m2hvsirHF4TpipbRtg4kfZdeqXWRb6vbPjzLn2
	lQSZ/D5ylrqqsmEju8PptBDkalZPFlY/cXZVCXqPDg8W5fffMBSiLXaL96fHFvHMa9vj4/lmHzV
	ipZpoAdCwccTNoyxAd2Vh58rB/aXOhIS81Ph6gEXO5DgCjf4M0XN+nHjrTNlggeZ3ikkDKL6iFn
	qvAXWWQQh578l/92DtcOAsCn7dUYTK1vyEg0/e4e8OHHtLZZGWp+prPGEyKXQ/FBeJ2c423HNcV
	FGSd0apf72Xd54hw/LD7iZOYij3RPqbYuXaa4eSgkpG2dUBn7KyJ0WkoY99UNZLxZa0C8qWmxE2
	V9AJiOFvsvVdLg0ZBUzLyhRB+ILiLgIZFQ4AcoXVolSyG52r1UYxa+OAX++drbHWlekqw/Fq9lL
	YXhDV6VcXAAVBB9aUmgaBFfSyUwy9t4RMZV0zSqC/eQj3I3WeiXPrvHPdvCj
X-Received: by 2002:a05:6a00:228b:b0:89d:f19f:5dc5 with SMTP id d2e1a72fcca58-8a089cdf21emr3765607b3a.13.1792644699895;
        Wed, 21 Oct 2026 21:51:39 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08933d1cesm1590253b3a.6.2026.10.21.21.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 21:51:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 04:51:39 +0000
Message-Id: <DMB3IDSRNEC7.1SYPQ5OXG7QR3@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <yonghong.song@linux.dev>, <martin.lau@kernel.org>,
 <mason@kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: Reject unwind_goto and unwind_exit in
 offloaded progs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>, <bot+bpf-ci@kernel.org>,
 <bpf@vger.kernel.org>
In-Reply-To: <1ffe4765-ce81-4ff6-a483-e978dce5b234@linux.dev>
References: <20261020231942.2568163-3-alexei.starovoitov@gmail.com> <1cc7789274018beba70932ec8806130f1ff07eed56b62e0afbed41385630e4b7@mail.kernel.org> <DMA2VC8SJY0S.8O3PIVXWV2J4@gmail.com> <1ffe4765-ce81-4ff6-a483-e978dce5b234@linux.dev>
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

On Tue, Oct 20, 2026 at 07:23 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
> But I don't think we should remove "nit" passes from the review bots.
>
> If people don't read commit messages carefully, and review bots don't
> either, then we are increasing the amount of sloppy or outright
> incorrect claims in the git history.

An incorrect claim in the commit log is not a nit. Bots should keep
reading the logs and keep reporting those.
The problem is that a nit is delivered the same way as a bug.
The bot said "Code looks correct" and "This isn't a bug in the code",
ended the mail with "Please fix the bug or email reply why it's not a bug"
and turned ai-review and PR summary checks red in patchwork.

> And also what's the cost of a respin with a bot fixing a bot-detected
> nit?  2 minutes? 5?

I could live with nits if they were like comments on github PR
that are easy to ignore or one click 'accept the suggestion' button,
but here we're spaming the list and people already make fun
of 'This isn't a bug...' opening.
