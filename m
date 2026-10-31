Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793485917;
	b=DKL32ovGq3PUSll9FjpjDLjQtOGfjHR08hCw1JgT7trkPChb+AKEww3rQTi+fJVfDf85
	 eSu8zWblzANDRd8m3kw8lZ0903iiZVCn/2OjTpuoP9HYEgpc1KgVCWLwizjqmWUhBwM7O
	 B/vh9NSbi9H4Mg1rGGfXZxDaIkXp4Q0aUOtpkqkcZt22i3t88Uk84avWWh90TmjR7Ax8c
	 hdxMc54KsK/SxWE2AtOlQdsAT0TL9h/RbSlBwNJDCk6DSl5DTq5OCzfRWIVViUUOxGewd
	 W/JrT33P0PKMqkScq2ktV259SuwuevwgpY9ln11aQORawb+XlFZzW+8n7mkl3E1QNyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793485917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OEBcjr+1g1r2SdHsW38Cfk4i1ywgvDS8NwTKQTmk5Qo=;
	b=V2eKeGMulnakwYyahSTC4YzQUmWmw/VKTZC+XZGgxSDSgQBdq1MMhzrVlTKZSQNUkc6L
	 3VLpAYAOLqHccaYnc/d85BGYcq0k+Yqk66gyHDcqg1tkYssKm2klkFFd1MzjE1ePDUwdM
	 98WrScvLZY3YYfkVuny/nn7qmXFWSiW/8xdJZsTXJ4tt9rxJT69xqb3LHe+wMsHeISi2w
	 PuVpRTkIV5E/3UNsiIzkLHLslQv8oLkxu2lXWTiwSBfgeCfrXSb1k0hDADQc8QWdlqOwe
	 DMRj7ti4rzclGwyDg1vrmPR0xMptG+JqUzoEAyU7mYydGc1OT/8ncuadqeloFs1BJtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xx6kNVb4;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DEE606A31A
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 22:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0DEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xx6kNVb4
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso1084404a91.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793485916; x=1794090716; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OEBcjr+1g1r2SdHsW38Cfk4i1ywgvDS8NwTKQTmk5Qo=;
        b=Xx6kNVb4wYhvYzT31sot7iuYUj1XBUNvPSgqZ6SwU11Q9DHxRqSQb8LjAHChbpcivf
         m7sVRrOnojCHgTXZF2ji9XkB/wIpIrVIWRdXIV1tPFeGPkjgFposoYXfa1pO39yWQXm0
         9g8nkOUuqDz3Qg8Ypmoh3BimCUwRlpbtnwiNyQ1ap+egH35cI0qhgEgsHd3IJWBQ1s1U
         4fMKhT/zAQMTF0/ezN9vCDk/SXl0N4u39c9nyB07zWKUezCGiyBbSd+syshrdqFBnWDx
         jwHrebEKCvnN35V+fWEqNPBTflEn7lCAY8P7tP3O1QomV5QqLYyDxCbsTz0gD3RFa6GW
         8FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793485916; x=1794090716;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OEBcjr+1g1r2SdHsW38Cfk4i1ywgvDS8NwTKQTmk5Qo=;
        b=r+7wtFbblbRDtI7cWvceJiaqUL6yhaR9Wlrj9kQR+CM03drSvCGGH+8skf/F0AyL2J
         2p+oLZ2RtWiToK3nVWtdzo6ff8shlNP+YP9TvwVe8Jfqrp9cHDXoyfB7d0FUbg1hiR9O
         QOiqoZk2M+1F5j5aFz/ccRwMmkFC7DgOfMoeluzybrp5neynSGapItXy9ROaoAExl7C/
         xBGcEAiLxg+aIESVJNDoL73MWD6oXxnNX9Olup3hak/TxVX8e86iSpIjIL3N3esU81Yl
         0Pan/aasiLdWutGI1CktST9qLUi9amepjsMQ0h4k+8BV+QLL35Eb+KwWtIzuH98LL12e
         3DkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx71J+UqKcl74HnfVhtB8+R0blU7yrRTSF04qrPMh8ADXqMRExq8M2h0oViNNleOe8HHXQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUIx52FUVegvWULY9EB1AAEsL5V9jlhe3lRY0tHdB1KKc5KzYy
	wbU48m9tt4RLy4dPYQTorgQGU6bgmtm63V0Gw/uKb9X5OSVDIRj/fiCrELL13g==
X-Gm-Gg: AYBFou3bAF6/KQ21H8qx0GX2jTJ/gyHn5joUHaD1dT9qV+FN1SU64tsV2g95jRI3205
	4RMZowOFuDxsX2RoNaEcSMpcgMNS9BlgFynO9rHvY5sbkXdNGlhez8e0g17Xglz0/OrtO5uWD0m
	gnrEgSDkB25YLJzQVyfswhCfI4L77pGnvFL1kUIG36trP79drR+pcUojDECj2iZ2zHCsW/FW4H6
	gejuFb2m+ttFR98nfdEMU+jGVITLT+eCHvN8DZlYeoMfdsyiIVJLXW7wzNicEx97acHbfc4U2iP
	icnXZaFeaAa7aKBrfb+FX4wNhJvapSDVvMqkCsF+6iaHS8T2YdQH631H5aWW+UY8ssDdqT8nYll
	qFpQlqD66B25peNi96T1zK9HqxPmgKy77cQXZXDwsJj26q9SbnzIiuwglEfahrnXLtriwTjFunM
	jSKIpWWyjTArdVwYXReDxGZtUiLaQYeR0ozk9pFVuQ9n3ITe6FqgBJXA2lAsbJ9ZrpZuoNyaUDf
	3fhVVP3d+ZX4gt34Pd/9BfbNpE0GQlfBSFYzLPD8LpgWQdz05+GQ1arjzxbvZpfhjD9z8/HDyHm
	yx8nARdIh4stXyhrN7ynNutrdjNCuYk0Kc47BJQTfhryJLMdy7t1iKPmLPG1mYkCXYU7Ufg83iD
	PM2go0Ualti1n4+MT3AqHwBjy9/HZcDTOlYkSCRLaB17QfCC2mOpE3gs=
X-Received: by 2002:a17:90b:3e83:b0:3ab:c370:3684 with SMTP id 98e67ed59e1d1-3ae89767179mr4926537a91.30.1793485916194;
        Sat, 31 Oct 2026 15:31:56 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae84542a13sm8540783a91.5.2026.10.31.15.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 15:31:55 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 22:31:55 +0000
Message-Id: <DMJDP38EHFFX.320GKNPIMNH9D@gmail.com>
Subject: Re: [PATCH bpf v2 9/9] selftests/bpf: Test one may_goto time slice
 per prog invocation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
In-Reply-To: <sashiko-outbox-192196@kernel.org>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com> <20261031215543.682284-10-alexei.starovoitov@gmail.com> <sashiko-outbox-192196@kernel.org>
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

On Sat, Oct 31, 2026 at 03:12 PM sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> - [Low] selftests/bpf: missing __skip() annotation on dummy_test() in timed_may_goto.c

Not worth a respin.
It's OK vs SKIP in the report on archs where the tests don't run.
