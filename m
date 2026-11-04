Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759373;
	b=Q2lkX9Y6UJBmLn6myy0vuvb13GrzmDfw6wkcDa7tkBZir9G3cTcUlCCddUay+AzNcs1g
	 4u3+YtsCmGxJ7COisvZ9JQd+/lTSLY+EIiaGVCq9BAtPZymE9JmR+IqB/fRZBPGB43c3r
	 XqrZnTlbA0n3Xjv8mXHsRfqXpjcp6ZAI7WeCpyStuDdP5XRF8pifuwaweSVDKPrfcBZFC
	 hPl2s6i4vaxAkpx8zBiSGNOHRraJzU7X60jBNUny50y2nBaN2BRc0oWlOhx6SMFhdC2FJ
	 TX459vDCpW2HB2Vqn5F78I6ITOmYBOdOTxPhEQWCg3EW/YnosvmYPeHKa6u47QJgtYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759373;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=vsGi4BmBeRHVTW2jgG4i4tgN2XUJGHuMBIV5LuKyEBk=;
	b=yL/Ppmx6hsLpoHSiWIezuWIFzl1iNCqOsZWnblJUfQu6i3f1qqpP35P4jh0gYsbgz+vK
	 nU2Lr1DMH9gSM09YSNWWFAZRzNnTtCb3aYaujIjexqiuzhlFPH9WKvzmaFycgGzTjg4K8
	 XKboKLSh59zNbL/pGXuahTDNr+FARDCHBZr7pi15jExs6dr6D4sdE30qSnXAt0EreTfPh
	 JKTR3Ek7zJ7Q/7jYjxzcOSm+nkCRL+YVXJ3bnraDhgmdL7ml0ymP5BHgjVh/TZDwmVszW
	 W4X4WjkWVhc1e1YffvwqXy1ppApIjgaQOc3DjKez8bFvO0yaW6F75+wFQu4iuvsLyzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3Q2lxna;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB4606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DADB4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J3Q2lxna
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so109292a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759372; x=1794364172; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vsGi4BmBeRHVTW2jgG4i4tgN2XUJGHuMBIV5LuKyEBk=;
        b=J3Q2lxnaQpED9gwoIpXt1NYszjJbZAbJ1nUMofTBC2W/zyuZaEtm0r7dWql43olpOB
         7paDAz4bV0VhJ4EObXR81o5+lyQbadQAiV+UFsyT+8OrKVc8NrwY0N6YC0Q95Nsfwwa7
         9WQ1NLnQC+Q9kEPmkwNiTMii9OBsoIc4Y+L4Th2bDOyL05IbDlD6MhdcATgQ8om55NH6
         Y3Yk0nJbP3o1ied+t2b63xvqLveQ+opOGTDmFo+jUL+fTCz+0WIpcDR0PLB6iHObYl3l
         NAozFk8PsPX7J8HYMi70L+Gt6MnpezlKXyIFRZQGGoiq6nbuodf2ZfDGezu0wKWeLp6v
         GJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759372; x=1794364172;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vsGi4BmBeRHVTW2jgG4i4tgN2XUJGHuMBIV5LuKyEBk=;
        b=ZF3hmcLcLU8Oifx9k4y5z8Vhtfxz4jFCzYXLYQCm3dIgSHY+VHMbWlYy8B9A0BLU0U
         mUHMSydW6UQnmKAXTyAVzvkPFCl2EzPPSywta90y1ix8yw/A9/dikbSPnlKCpKf4eQ3K
         lqQrSG0wkVjudky83DvmG2dh8paDKJ7XSqA9zLZlDgMoOFsIEMId7x96Hw+OynDAFmbW
         n1wCxcFo3hhmXORloJtaHl//M97hMNgrr8/I1bd8FqzEkF1u+JgakYzkUsgEGEuU+LSu
         Ck9/pwS4sRJmlO9JQldYrTt+8J7hhACyhAAnKfZpOExrvm5eR/+LSYFApFHKXBxerawI
         KVZw==
X-Forwarded-Encrypted: i=1; AKwUvBzyLjCDZcDTlKdWhV+3WPZPFMYt0yS5R0SWtQ2fxDWXdsr6YcgPzaaS8sml2f0W1LzCAxg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pfh7Qm/Kn0M0WI5Z4NXRMiIgrhg0FONH6CSnqDyuG4M7gWtKv
	KKyqw5mvvW4wjSh16OFUlCJXifvYzhSfCcismTFsut+5aP7pWuknXFuV
X-Gm-Gg: AYBFou28qnPAiYcNfNZ0aaRP1nAFwe+GTA7U03rM/LUAFI+LWAH3cIgi+KPDWC4gEAl
	PQ1pG96b7k5vppL0j+kDzdm7q0NXSwf0WQ6OW04ZMLaCe+YukdJ0p/g3drRmwJEVtaR8lcs7Ql6
	AnmLHrrM9BhCZ7pUvSwDmZpfH4qzTkHrD0kk+H+T/PqrRc7U/b6LsX02aXh82WOmRmhMDRZpUam
	/2dpAEzPuABDVL0gu7Jq+p6C3vLMR5Nm2KSh6XKHA/NNlhLYdrWwPblmBdkbqxioUMwWg1aESkE
	BKE5C/aLaB87tWz/3gexsH+L80GpyhmL6eTi5Hos05abV/wbd2uCqwnwof40PnfN9/+Gr1C19ak
	iVpGSwsO8WeXdT+eCANz/FcHQLuHZeAcxviJGLJBi6KwnT0qZtPshzSiPcrIaimUBwPtxc/0+CL
	Ii3ZjB6jr4dACathbjUS8Q4H7dTnAiUckJkkeutEV9skdNEbVCnuxq31Rj6TWx63gUtfiSrfICB
	ICBhfCIBtASI75+1SiWmSqH7+HVOrivAFitMK/IFdD0zBymbzFz34YQJHDDr2dKYuSv8M68kUOT
	zkjaco45Wbh9QgytzqqvrevI4jG+9L9aQvb/s2UZ7UrWEofNUrw5A1FiGaRP3r+kFwfneYPrIIO
	guQ/xZ1+L3RPGnXTWcBOjujx8zVT4rMSrvrg=
X-Received: by 2002:a17:90b:2e90:b0:3ac:86a0:5764 with SMTP id 98e67ed59e1d1-3ae898311b8mr11287025a91.64.1793759372069;
        Tue, 03 Nov 2026 18:29:32 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c9b0ec5sm6769171a91.16.2026.11.03.18.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:29:31 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:29:31 +0000
Message-Id: <DMM2MN5EJY19.3572T5J6A88O2@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 14/14] selftests/bpf: Add tests for
 BPF_REG_ARENA_SP
In-Reply-To: <80c599809cfc3fbcfa077d05c36283e64225f6340c30ecb08407210c74e438ae@mail.kernel.org>
References: <20261104012401.1354861-15-alexei.starovoitov@gmail.com> <80c599809cfc3fbcfa077d05c36283e64225f6340c30ecb08407210c74e438ae@mail.kernel.org>
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

On Tue, Nov 03, 2026 at 06:12 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> TL;DR: Nit in selftests: the r12 instruction macros (ADJ, LDX, ST) are
> duplicated across several arena_stack test files, some hand-encoded. Suggests
> moving them to one shared header.

Not worth a respin.
The macros are temporary. They go away when compilers know r12.
