Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7CD2931D5
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790438059; cv=none; b=jyuhX9lagrY9GftvJTdnoEyhEm7SGKkoUiOE1Fhnypcfx1qP7fV6ZegzKbepZeSUMChJ5m9L+JJ56pguXerG6TovT9B61X84qlDUq3P7OmNuH8W/s6Wab6yGK1IoSsRnakqSuLUBTZTsxkIqWC1V0/qWkxbamdxhybeSbgj7z1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790438059; c=relaxed/simple;
	bh=PzBpwvsDbjD2AZMXDO9+maqrqgZZSRE43v8TkDRxLQY=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=jBVa80W1JaKu7pS/0gNdQ2ej8j+y0sWxu/c7jADRyW94lpiC/yTVsmg9H9vNST6dGmXxfywwXvUEDV1bteM64Wsx1U0mg7qzQ67DGeMdZElUbuz0aFO3o/cW1aaIMw18+KPcLATF/L1mUwz/ClScc064XoixUAu6XaKXlxSmxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bArLohMM; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bArLohMM"
Received: by mail-pz2-f39.google.com with SMTP id d2e1a72fcca58-88103e47f72so768881b3a.2
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790438058; x=1791042858; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z4cyMs2sSLIDwTqCXOHr9G9ZFSBdLPXR3gsGCVRAfxU=;
        b=bArLohMMda585HTG4VjGp8TZloKrj+VsDgnUL7WNOW5EkPzFHCUQTo73LJ1cAdy9FI
         /kApGUF4mKubPni4vv8mC+e7bQLvDPG2aGK64UDEpSSVPfQ9xRFXaTgNW+d+mrGFIBIR
         OCb/Vy7oquHH4jfSyAt1+yZm9iEdYRnVWBA6qM0U1PAJztd0xAvFkWdUIIGSc4pfJqLP
         UCMZE7atXb4huMhClEuVwKgy1ZT3CHG7jBmoWqNOOzkJKAPqiIurKo8sVgGx15cl4jl9
         s9bDMBETOL4JSKZE5h2/Yx2yqt4WF7s2nK5/wQWKKN1sblRXuhbD9NI8YUqUIKkbGlYI
         2UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790438058; x=1791042858;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z4cyMs2sSLIDwTqCXOHr9G9ZFSBdLPXR3gsGCVRAfxU=;
        b=FnxNKUvlUGG3QK3g8YoC8A1TEKGxmeMv+pZEpT/tHov5AvlgXtyAWlvKEmrM7dGcAe
         1jKnqHk6k3mLpEEJPk5o0Y7X1rE6NzpeC+hWsHpjeOtmruFWdjEVY3dklIBGzLpjXxE8
         MLRUBi+RIRdvohlXqMXFS19XeU8F57avlShkZ1KXx4eM8o7JSi4XVPq//cAhZvEAdcJI
         zQOmf8FWn/JwLoQA8ViyhTXtzVsBLLH9hTBuiPa6Karg9zdg+zg6gw6SvWonCvqYLkoX
         0cP4I760PzdXc9x+mfKdAw8/e/VgW/5afQoYJ5fzqFnW0TB5J6i9UVKSDBuFouI+DwtI
         JYFg==
X-Forwarded-Encrypted: i=1; AKwUvBxlQKT83thM14FNABdAtvAi4p0X90hQD4dkBKd5MTYmuONT6WQLPdtMuOO2+9cGrPYImTA=@vger.kernel.org
X-Gm-Message-State: AFuF++lYbU4rd5xhhIsYdjlXu9bfFnE+8BXQKBmccVfVGuy2jl0aK4Qr
	OeCmdOdXSLPEG5sbpFrbYb+C4B4jnLTBwhgwZbhrEqM8xbPw2ZPLroIK
X-Gm-Gg: AYBFou3i3kN6GvLMZZBiR1Uyg9/PQKZPnWbw/XEXR+x5eceeNSm6THAI8sN3cwL4baP
	GBAy4feQWS38GV2Qlcs6MLcVr5BTx1sIC8CrZ0+OLmKGTB64ConE68pGtjOAaM0QdOfKuUfZVZk
	NKIcLlzz1aDNZxLtuzp4URqzEhv5925f1DsZ3Lm9HtyyfPLGGhmPFThmdIuG/Seb/yoyNRU3Jda
	4Ng7TWxFfSNwwNDnp/4LCKZWLIszRMLyVevqNFOvGzKq4ZjVc+HSRZfyHr592923ttJexZQHh5n
	s1jSIOiuvHS9A2PTDFzDz26Zm0TXKhBYNsFipebAPadD6GS2XVdi59tHE2AonkSAeBAbiVl1T6P
	E/n/I/POrBtLAsSX+QRhGaumWZcam1XgqZW98nPPoE5ND0S8LFYQBUWlPp34sx9cCo4Z/R0c53I
	zuG99pOM8yJEExyQ84gtVqXLD/kmOnYHIgJPNCYiFDbZB3J2v6PJbh0PQpiXS1cLwzUmz9FV4BP
	E3epahCetmIq6z9i9mPnbqpTrJTvqvSOk6+o2lAwOPCA3jD4dih1bTMNqWFfPeE73KhsC+JY4Ms
	Z8Bh
X-Received: by 2002:a05:6a21:e10b:b0:3dd:a196:53a6 with SMTP id adf61e73a8af0-3de0e989cf4mr7821009637.72.1790438057731;
        Sat, 26 Sep 2026 08:54:17 -0700 (PDT)
Received: from localhost ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7a3bb2d5asm360342a12.17.2026.09.26.08.54.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 08:54:16 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 15:54:15 +0000
Message-Id: <DLPDBJRPGCUI.1R1AW302XC9UT@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <memxor@gmail.com>
Subject: Re: [PATCH bpf-next 18/36] bpf: compute immediate dominators
In-Reply-To: <20260926-scev-minimal-rebase-v1-18-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com> <20260926-scev-minimal-rebase-v1-18-c8e5ab5ba79f@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 26, 2026 at 07:20 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> +static int idoms_intersect(struct bpf_verifier_env *env, int a, int b)
> +{
> +	int *postorder_nums = env->cfg.postorder_nums;
> +	int *idoms = env->idoms;
> +
> +	while (a != b) {
> +		while (postorder_nums[a] < postorder_nums[b]) {
> +			a = idoms[a];
> +		}

This walks the idom chain one insn at a time.
For a prog that is a long run of
  if (err) goto out;
'out' has N predecessors and compute_subprog_idoms() calls this
for each of them. The k-th call walks back over k branches.
That's N^2/2 steps, and the outer loop runs at least twice.
All of it before do_check(), for every prog, loops or not.
Same issue as Daniel's commit 3852e19cb954 fixed just yesterday.

SCEV needs dominators only inside loops.
Can it be computed for insns with scc != 0 only ?
and probably a bound for a big loop body.
