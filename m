Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75B254B03
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790408867; cv=none; b=Gj/rVyuSQZEcSVCG/fus6dHmZc6N8gbnnqy7nMXVo9k6MLuPkpBkfZpj03C4HjgbU+nZ3IapG7Z6AQYbbjnHwNp+F2Bdfji4TZ0nd+WIRdvpdyGg962kJXGjd44eAIYnJZenmlF3N0m1SW/3t6jmjyAiMhbhqmbDQ1wuNRTYaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790408867; c=relaxed/simple;
	bh=gtIEBs9r//V4MPvIUydNEVyzb63vKo76hU09HZRVPdk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=AJ7rRjNgs/mv0OaEeIuSCXfAYCKSAjMkTk4gkqUvzJ2omzold2LkJXX8hurL5aRLtDKuRItvrIMIq4orLCfzSjiOBUeEwwkYBFb8rpGegr4zpxzzJKhg6c3w+qPxWNqKDwXsqjTlQKS2zFF3khhyJdCL/8JDayt6TSCmbscVPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyh6Kxxy; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyh6Kxxy"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so539804a91.0
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790408866; x=1791013666; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gtIEBs9r//V4MPvIUydNEVyzb63vKo76hU09HZRVPdk=;
        b=hyh6KxxyJRn/sxmOksEyN3sY9laYBq2/7zendoZC9r02VlBr5w/JzpxKgnckNCBB1T
         PfcHSZ1qzWhJGRkqFdXzfiBVd9DRT5dMhnMd6CEHqIlvzTxXWA7DjoX1EEeI5XA6kesz
         GtLMfBq7ydq+eIVTj44sBKHYgnrGjqEkwvwfLZjIFJEEgawg5O8h3SFsZP6iGo2SMkDb
         s8dgxPUGWDipl76YKypTSA9aBth3EKlQMi8Cky8I+VCp1SMqatgncEpHbw4djY0cPnck
         q4qxfGnNEgfgPW4+1PL4Z3XiEZUEN/RzPUU1fxzWu47quhtQBhh7V57e+woabaLKej2P
         pUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790408866; x=1791013666;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gtIEBs9r//V4MPvIUydNEVyzb63vKo76hU09HZRVPdk=;
        b=FkW1r0/CckdeT5IElTxO1uOn5OBKLPcsSWEP6bcchPJ8VoW1hGBgUMGtM03z3q01qa
         2Id+vGZU4CWkv3Ii718epXo1t5AA7CSGV0+XJPiMv9Vcg32cF9BNPpfPESp0lRzAYW0z
         ct6XbH74I07r9w7bMemW6Wk8KF8T5wtIVBF9FBe2WewWtTgKj2k0q7kj/RNQzmyvX1It
         3sq8Opt5ADIu3mHV6FFiiwxVArz0M9e4QLDYFhda7jgFyKqNDNMqoZd3mXRXy2i8UG7p
         B2mDIgD36T9uZfKitltMof0QRueGP/kRO69VM0Jaqm9/6+rMKkOxOHifJeinRMf70+vO
         C0Qg==
X-Forwarded-Encrypted: i=1; AKwUvBwhcEV5XNTl0287qGMCFP4cODc8Jzvumcl888pWVAkNP1dyMs/ya6h69c/ooGQVYONZcok=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCecNEg/hSNU4+kqXIgqhOlYyS7zNU4w3PQrD9apgBiaO7a+XS
	K/YF+AAECYXSkG7TxxoqFIPjDXdYqW5IGBzYl2FXDGlFfAaWQ3tIvF7P
X-Gm-Gg: AYBFou1WT3aQPiaPXo2ylpG5dqEmKLwVm18//uv3BEPbqtu5cObYEPQn5/QYdurYds7
	M9e3+Et+GUTu53Y+BSQZrk9AwS07Hvg1sJ9dYSH2vuCFHxablddOXLKPTttqN8VbqUEot99Q2Ed
	lhF3ABuYpAQU0cRBbfYpfKIbR1EPiYFreEe8IessHbv4Ts6O9uncAueo3ctVIIYUnyWouChCf1I
	GAk0vHLOWEhhIra9EOauaotWlHVTMRSno22zjZ2iniLE7goG+Ap6nZOilyvD+jPDeaeRFEvjKRX
	afyGVtiQS+RjT1SWu38t+PhjjrKoOsOJNDJGjJt4EIPolbg0dz3ngFfcOa8FBw+TUiRoo812hO3
	+TwD9d0UV0WxlolqODQRppG7QJSPsQr+TNlw65GH/YBTKz3Ms0ugj0DU9woEeD5ljiQCRQuCh/m
	tYhCMVsfhAk0Au4Oe4U0fkfZgsoPgxF5RR5gbRvCUm6gXyncOTXFIY5tGkw7nX/gTrAV3ORcdKX
	0VQZmjPAH9LE11/1V8kFCEFHXVYjy5D+VuePQQXQC2HG5iB0a6ZH1VM9DsP1ufNe2WsIdIGau1O
	h3HfLh2px1qMv6o=
X-Received: by 2002:a17:90b:4a05:b0:3a0:b61e:e321 with SMTP id 98e67ed59e1d1-3a0b61eea8cmr3049942a91.26.1790408865792;
        Sat, 26 Sep 2026 00:47:45 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589f7esm8531588a91.10.2026.09.26.00.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 00:47:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Sep 2026 07:47:43 +0000
Message-Id: <DLP2Z120OC61.TTRUEZ9MMG5K@gmail.com>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf v3 3/7] bpf: Add sleepable arena page allocation
 path
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
In-Reply-To: <DLOQESM8SNGA.2ASMGV6KHJ4WB@etsalapatis.com>
References: <20260925203939.4105-1-emil@etsalapatis.com> <20260925203939.4105-4-emil@etsalapatis.com> <DLOPQUOW1A97.1KXFXSEUUNSFT@gmail.com> <DLOQESM8SNGA.2ASMGV6KHJ4WB@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 25, 2026 at 09:57 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> The nr_pages_in_flight is there for the edge case where multiple concurrent
> allocations in the arena inflate memcg usage close to the limit, then a non-arena
> related allocation fails/triggers OOM. If we're fine with that happy to remove
> it since it's a bit of a tacked-on hack.

Yes. Let's remove it.
An arena that is populated up to the memcg limit does the same
to other allocations in that memcg.

> I'll replace it with __GFP_RETRY_MAYFAIL on alloc_pages() so that the allocation
> doesn't accidentally trigger the OOM killer. AFAICT it can do so otherwise.

confused...
Patch 2 already adds __GFP_RETRY_MAYFAIL to bpf_alloc_page().
