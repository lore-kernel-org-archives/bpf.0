Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793494749;
	b=WWqowNYUGIvIEOWNUIIJH6mq6w+lRteV51Uk2BetCiksI0G7+jzSG6R2Ylidn4GwfM09
	 ScF1L1dgysxJE9okghL4tWLDVvBlCLt0G2nY5096nqiY/yP70zScgPr0cVtwRJY7CCjVY
	 CLEGPa50OYvTuNMawco4BxCDsODfetwC7kKqPHnjsKCn4Kmq3bpuKaxGek3A1dcxjglye
	 tTSCne2kiaTZ/mLEnXmjnZeff9Wur/4cvk6iuBlkWYtCi772wi5uE/HC/di/9HLns30fy
	 sMSsbFoe897lszcK8ByfDtlpO3X0uQFOroyTTCMEpc4Azoa0Qu1llI44HKw80HZMyVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793494749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=PRYSgurAOIt4+aBdsRsGfnET3k61sZs24m9Ee/nOO+g=;
	b=d+0xaD/VGvZAFRi2YOSyLhw/Yp6a/sHHQyKeylmneBV/3lNhQHoBCV/NxjEhgYLmqYD0
	 vq5tgvlH6aUQqcGvXB25MYBkhBAhsqp92Pu89HvFPS5IZtt4BHF6uhmcqoqQ9m63kGlZX
	 E09HbDHz4BQzWM4qHg9mAk37428JhUzEMhxQTcf156kaZz1sodIkdpw/VzYBD1mWPpAI8
	 /D/942DtT9lttofIXZIpkDgQI25Qu/t2sue5Owpexmk2Bw478evJZmBN3Yj9CvKLtzceC
	 P5vrhdjadCFaE0QCgm0fTf2HHjS0TGulUwGnyXRxmIZXKUKJ7SrOpqXCDPNV9e1UVuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B8606A31C
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 00:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF5B8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-89f85edd210so692150b3a.2
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 17:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793494743; x=1794099543; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRYSgurAOIt4+aBdsRsGfnET3k61sZs24m9Ee/nOO+g=;
        b=T3ukN4yKFkPtgMsFX5x1SEOOKz8GBupCamU8i49SWxdqc3wJiL3c5ySJZxdXRgKQzF
         Wrpl1NNK50XzEYomT/rGTZcURo+d4zhfepIKbfpct2Z3RUIIxxVf//kRTcHezlh/hC5W
         l4TlCcsf9+Nv8k7V3YJDVjDNnIepGxJuF5RX8xDEVcw3JMzdHC9UtHN9FzUmZsu/NLxi
         riut+UyVD0lcxeYv3q4wWvH6SP12XEXG3o5fiNVF6O74lyHedkdGEPVsPRNdYWWOiaKb
         W3/pFP1tdEGyjIIj2RxijaCTeu1hUVkYukPABn23eCxO3bJLOh2FESkL0/z5PHrzMzKq
         Prcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793494743; x=1794099543;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRYSgurAOIt4+aBdsRsGfnET3k61sZs24m9Ee/nOO+g=;
        b=del5gJLiDPDpArUNmQdTNuiIy68kVKYSE5knoO/+DA+3Z8KEgqJ6RJNaO3XjjrZAi5
         soTdm66JRKLBl+pR1nG1lrfHW/BIjJUzmk4EHLLqgbllI9oQ8nnYDkxlaxx+407qJDw3
         pHeq/pL3qMeaUJTBup9D6rLvTr6uXFyuTt7lhkg4Hv4xL0mjI9nPr9ncWtkYjMlgkON9
         SmMajgnbnhV2OdktHh+6knmcDW8tPSETVR8txg4vyFs7TXOP/N8kNs18diAtNy/HOYxH
         VwPpQheHspjCCZOc0YZVp6GHrch0lgD/J72TEFrgLjjR3yrWHWK6dF1sgWnKCSP0GjyY
         3hKw==
X-Forwarded-Encrypted: i=1; AKwUvBwg90HFJvATkhcxDtDMGge5SHETLE0ATP3iXqzuiubgcqQ7txnfpOyqdgXaCAtPyY/5LuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9i7jcYx525D9sFgtYzgiYvAcv/jwv+cIsKh+0PVM7FqbPDF2Ki
	rTxbjDTEJY7ByQbrGkba8emdNNENmL5DpF8uHgns2dnDpiAvlxO91iRT
X-Gm-Gg: AYBFou3c2IR0XF63Zc1krnnwPHbqgvxpxeDCRcrka79WOivTN6uGteXgoESSq4OmxuA
	drTcXBXPEFddOaJjEHTXvCowyJ3NruahLT35G63HpN2rnn7aTF9als2Tgoe+TL2J9ucrvJ7TNpC
	dfOppcCYoE2ZEhaLZJYmnXktlD8Z38fj85LPzbODnEKhPFc6+SH5BHGDQA09Aw286Nx/+5aZcc2
	yvZGWkJHQMxMdonvYcKzlEdPahR9WbxFRTebh+8H8RsGnDcw2QIAqwtfx8ko4b4cZli8s5QE7Mi
	dw+goyGREypyWmRAwHiH9Nm3Ei84J10q9TSmkOtXCZLeretxNvqnwK0+pFJ6UpnKFCbPfiz7F4C
	S/rZkZZ2mjdNEcRRqNe13N3AlsMh9gYeNl1c3Kx8oJelk6qubxoh4ok1Q3+5pG1wdOo3EvDX3Ir
	ccRMc/qfKR3c9MpWawtMzxD5yvSJLp2e/V6tWUW9Djah30F1lZNM/zedya1HEtzJ0hl6HH3WVQK
	slle6oHbLGkvTKcEk6hbjp+uONNiAmMgLujcMjpQwRVo6g5zyoTWBQ9OGXUJTMQTNf0OweiffbN
	VRT3P0sMlXSw5kHaYZO15LuzIL+joHbl/Kjv1d/SkEFDLZygPZt/9/1LOb8YJ7EbAWRP47QFUFo
	zDFrpovqJa/rVZdvpv+sJF1n36b3Jd/EU1g==
X-Received: by 2002:a17:90b:3909:b0:3ac:a203:e095 with SMTP id 98e67ed59e1d1-3ae89536c23mr5122823a91.7.1793494742778;
        Sat, 31 Oct 2026 17:59:02 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae87fc548fsm5145835a91.4.2026.10.31.17.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 17:59:02 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 00:59:01 +0000
Message-Id: <DMJGTQ2WDH27.A1UOC3ON9WJM@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Vineet Gupta" <vineet.gupta@linux.dev>, <bpf@vger.kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <memxor@gmail.com>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: don't count skipped reg_bounds
 cases as skipped tests
In-Reply-To: <20261028211921.1055711-1-vineet.gupta@linux.dev>
References: <20261028211921.1055711-1-vineet.gupta@linux.dev>
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

On Wed, Oct 28, 2026 at 02:19 PM Vineet Gupta <vineet.gupta@linux.dev> wrote:
> @@ -1581,7 +1582,7 @@ static int verify_case_op(enum num_t init_t, enum num_t cond_t,
>  	    !assert_reg_state_eq(&tr2, &te2, "true_reg2")) {
>  		if (reg_state_needs_two_arcs(&fe1) || reg_state_needs_two_arcs(&fe2) ||
>  		    reg_state_needs_two_arcs(&te1) || reg_state_needs_two_arcs(&te2)) {
> -			test__skip();
> +			*skipped = true;
>  			return 0;
>  		}

Applied. Thanks.

Eduard,
unrelated to this patch, needs_two_arcs() returns true for an unknown
register:

  needs_two_arcs(U32, [0; U32_MAX], S32, [S32_MIN; S32_MAX])
    lo = 0x80000000, hi = 0x7fffffff
    lo > hi && 0 <= hi && U32_MAX >= lo

That's the full circle. It is one arc.
A random 64-bit range has unknown low 32 bits.
So reg_bounds_rand_*_u64_u64 and the like ignore every MISMATCH, it seems.

Should it return false when r1 or r2 is the full range?
