Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163205;
	b=fNzefhubWISd7COOSKu+tBGbcH0Mv31JGBs+G4BPJpoSIbJrwBuN7xSx9DfCB0A7K+6r
	 tUM/1S/SXQAQlI0iWAqKaUM4Z1/trWwqkouBriaDOkFeZf2pLBSuYBwiWM5lzpqgoLpia
	 WE54QD4Fj8TlZ1LbC+4TfiUSwd2jOh3m/YtY7BWMebnXKp5Sol2h212cIRu95PNxROcCd
	 PG2f/WkfWSs0vScpwC5l2u5iODtmKOxZ8IejY9zvKHSCCJGbBhfXu7lZXFDmaGWYu2iNx
	 zlHKy5suZOKoaTUics5AdbzNTlm6S1n8vL53d2DGTdhntLnJ2OErpwaYZTCVJjuiv0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=rQIWtygHHf7xmN0aUe0ttNuOIlSKO0PSN3wdFVNV8fw=;
	b=xxTIc2SMxFX70PT5o9V7kvCppBx3BwYbGwqbx0U/t3k+zKqW68yP0iYlL7RlyOW1VrKI
	 k5QWRD5uzWLr0o4WRsKiFVv6gHWP5YF4m6yw96ghq23ElsCr6nJIczMjaF+flpif37bH1
	 1W/Xt4bfKsZSGtDKyQ7NcKJQSIPyizTJFum+O6tg9NIYcZ5GX4yDJvjTM+p5gSsmU3xiV
	 jyouFk+abHl0Rha7lv+zS6s30O20bnMv13Av/nbiYb2ddDh8ZrJGhs57eMdBr/PVTImcL
	 46IYuZ39NDxZoaMjW9fIWgIkBD/msOVEuWGIOtjY/A9eT0eh2n3OoTvzcaUlPUGPEyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7vk1sh2;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD3606A321
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 04:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1AD3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7vk1sh2
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so279376a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 21:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793163204; x=1793768004; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQIWtygHHf7xmN0aUe0ttNuOIlSKO0PSN3wdFVNV8fw=;
        b=J7vk1sh2/0umoock0GOM98Hs7eKrgdvhVZdvPny20lEnNmMFG+sZKbpXzMLCz9/ShJ
         N1mRnDwmh0dcTegFhdVE332h4oIAjUZLlpx2h05Gj6Ue8jc0TyTuD/vWzK9MThMrsy/L
         pyNiB9MIaKgLl2q5e5v3+PFkJWSEV77t1uDQcsjLZhRqMiGK4dbHaE7PIBwby2dGzuk/
         J2EzM93RHDXHPFls2oPL2tSAlpacwIUHmpcF9EWQNnuX9soYh/Yl+7L61jcJQKYk03qN
         GLQtbD5X9EVM3wfPdyi0Db5r2txRE+xeJrYYBxOEk0QxFeikF1Jh7iU4l1Pr1KU4N2Nh
         wjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793163204; x=1793768004;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQIWtygHHf7xmN0aUe0ttNuOIlSKO0PSN3wdFVNV8fw=;
        b=nER/h9XX3wKUPPMClyJ8/UOeygFIYzLqKkSHML7GZPeWtcQ5SnBF+WHJXNvdascpaI
         joFRVi0Hl3rg+YQvmz4XX8tCsH1LigBi/V4ySkKR7kqy9KkNnJIV/V9Kh074qSC2R+eF
         1rZ1wVJAq2o/6S1AiRThF0CjjHXPt0sVDyOyFNyYhWo0OJq7+guZCD5yAssi+UJ3xa/5
         kXajvYyYsP4j8cPa8A7LCvABDUUZYB54NLrIgdonjtxwwJGovZ8kcd9lT8mrArd6I5r1
         ww98jH4kJ5+ICivXtxqbx1BF6hPXTIH9ao6KszzS4gS9JGXukkAQgnRmRxRvj3c4NAFe
         mAJA==
X-Forwarded-Encrypted: i=1; AKwUvBxn3QRqAcAeqv1RxsaQe7tuZymYQZayMfcy5GzJUw1v9lLS9eQP2WDCTJqgws3KM+TbC0c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUJxMAdG4QAOnHiaRvW4XleA8WYM8oeDMr+5v2BbfVdbN9E4K+
	16wU3HNU14B84MMsp2Vb3mPOzeOuoVZWZZL97uoJVKb9JY5dwdQLCoAd
X-Gm-Gg: AYBFou3ydIUIYTkLLGOk9zibeswWb/wfnxM8zAKeStw7tXRQXzuqzhrBY6WeTiyAxVZ
	3qEZqkHFZLW3/czLeBM2xELl+UqV4+7fwKspFWb7rcTtzUYf4/f3aRWbNP6oJX7Kf2xTDa4IIVJ
	K/EQRsMhSQm1Vqwn56SsFRT+Fah+U8yf+mU4rlv3XQqAd1vllwYYlnBJ9Ylx4zCGpp8vfLYRrVu
	GjlS5s8gkG933e98I/ZFJaQG5MPOtXvB7yNbmOLymgzVMY4sqhElO6GAqqHCP9nH6Ei9mmT2/eB
	rIJLQmoB600C402kAkFXdmAs1DZiSjjy0rpK3PLI+tAgS5Bz7D27pmVrFFMIgDej+aRgk7Y3qXD
	ZS4OSJ5g5QHnSamCFaYfcEqSPNdN2gxOW7fKTyIjUHObAVVhWtpPpE7V1dxQ/GrSy0393k63b5o
	Pd5F+2w25fWs1/r25OPL32I67m4mTo6ML0yppE7H8XFt7lrJNnaHJjM1uNuJtDMyOt5SHHt5ifE
	b8uy4c5/M07iGtNRlnpyWobCQYzh1nqTx6dZuKYNqju6abmmmLezN+1M6CSsO2z3ug4pCQMwzqe
	stXHfop3kPElWoBoQQc9jKbCBn0foXQgfarp1QpVxgwIuexhCJYk7aTSZ1E4JymF6T7ozbFWgUd
	ign6PxychgE6pBuneasTJE/7PiB/OnMlvaQ==
X-Received: by 2002:a17:90b:1b0f:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3ae580a8351mr963232a91.18.1793163204197;
        Tue, 27 Oct 2026 21:53:24 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a4a9264sm1085503a91.0.2026.10.27.21.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 21:53:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 04:53:23 +0000
Message-Id: <DMG7AZEN64J2.2UOXWPDX3UJBX@gmail.com>
Subject: Re: [PATCH v2 bpf 18/19] bpf: Keep stack arguments in
 arch_bpf_timed_may_goto()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <mason@kernel.org>, <ihor.solodrai@linux.dev>
In-Reply-To: <c889c8567595aadae63d644145f1dca5d1e8135d0aea98d82fb7fa1f2ba5953d@mail.kernel.org>
References: <20261027190314.1440199-19-alexei.starovoitov@gmail.com> <c889c8567595aadae63d644145f1dca5d1e8135d0aea98d82fb7fa1f2ba5953d@mail.kernel.org>
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

On Tue, Oct 27, 2026 at 12:48 PM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> Is may_goto the only such case?  LD_ABS/LD_IND look like they have the same
> problem, and nothing in this series covers them.

[...]

> Should LD_ABS/LD_IND be handled as well, for example by setting
> no_stack_arg_load and calling invalidate_outgoing_stack_args() in
> check_ld_abs()?

yeah. It's an old bug, not from this patch.
check_ld_abs() has it since commit 0f6bd5e7a804 ("bpf: Support stack
arguments for bpf functions"). It takes hand written asm and CAP_BPF to
hit it. LLVM doesn't emit such code, same as with may_goto.
Low prio fix. Will get to it eventually.
