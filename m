Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84A2BE033
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606219; cv=none; b=erHiI0I+6Xruqn/6mkdGni97tkGyn9djrK1EWDj7DACfS/Jj+PuAJHd5C5Am69Y4J2mdfHQHNWg5M5OyyxWMWpHwat2B0W6ubf3ecdEAiO68nrEfsjvPWupq32uIqYvo9qfHsMNjte+tKgTyXJVteiGVKT9nVjDojzS+Dg+nnBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606219; c=relaxed/simple;
	bh=T02keRFlBlrY/+86JFOaQMxuONXtNhvXhKcKlvDGoa8=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=jhZ3K0BTx730x9gNN5vutd/h36QoLzKGJC8ZdqsVQXxaRpr5BKn4UEhiex94NOkPfxcL/t2E89ruY+G96o+zcgyl/x/q6ubbse35j4aiuK1q4K1LbcJAj03ZwTl3ii2x+wQjBVvPtRbW9GRtPoTPOZueRt5f2ah2hnKXYd8/Sp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfFybxzL; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfFybxzL"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db1ca069c8so2561575ad.3
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 17:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789606217; x=1790211017; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=siq+PPXgaarU3t04UeiEmHGKP9jdCNlM1DGY8W35Lgw=;
        b=cfFybxzLCtbqqaczQvPTeuS160FLsWRtX/LAh1eW9x6JFxzErZQKxrlELAsQZ2O+Hr
         oCgx3/FkiGVnrtcjhMNSIeSb24e/Oe6RJ8UvOvOs5TVJR7jJ3YJNP2+M4Xqdh0RC/ohu
         aulBfYhqUi+SBMij9Rwm8V+Td9U+W037/Nz4oHmFiagI0sA/zXHp5oQAUTwSvXbVsQpB
         9diZQofhhwFJeSP2LROFMl+pjTlroM5RFNg7h/qugeGOqaYPL8YDqcwwE6l1QtG1AXTs
         E5SeRae4BUOKItoER4CbvWkxz56HK+eTGuU4XLrpiEAf4zdBSoC1z9EecERk1/NAetdL
         G+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789606217; x=1790211017;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=siq+PPXgaarU3t04UeiEmHGKP9jdCNlM1DGY8W35Lgw=;
        b=DmSBPHVlUGSPdSOcIfb9N/J1Wi4Gil5OMspqLXMjdp1hJjN0siH1Mg8v2xEatjwJiN
         VJT2RZt3WkELwrWvIdu7v+RqLYBJqRIi5ANSTKICHcqHNyvkus4oU9u0GeoRT1JsVCLk
         rPsOgm9sIGmKLoEFWeGhDqv2/HoRZKs11/24qY98uCKmq/lY9wTcZlglxxvzjvOGqNo5
         f6YbBEM32YqcOW/BCJsXBABtt52H7eGfRizOw9YzDbIzUmX4t9rsN/D4SkWv4II33Q/f
         JrHrmJLT2T8897NUX0AwMuQC3c8Mauiz+kAbOGIilRscpO5aGX3JaTzQkY3DGJIEQAct
         mfhw==
X-Forwarded-Encrypted: i=1; AKwUvBw3grsQ29WzOAw4usdyq0S6aXoNKZ+lcDikEKo/J223oKi4eD8uFyIA+I4UpolVWW5kmmQ=@vger.kernel.org
X-Gm-Message-State: AFuF++m043CNLQ8s+FyZkm/HgLydSTn5oQALq0LcHzL7SUhtlZEpm13c
	gcbBTGSICnuPIdsBaD9c702GIUxk1Cb+6LiLVCEDzQdMrRyWINa4dxHO
X-Gm-Gg: AYBFou1UWvr30G+SWD1wBndxyTloJj5vJ6K9Tz2gm2A0AvrjCR3usOZcOPQftuwyN4v
	toywec4PgQLqgKZculPEa5rHo5R5KpNiLRXppxBsItny8+jQQIFAYvYBoPCwTjuoE4F8S88ZX86
	4ZNe0w7wdKnU3wcwIP/m8SLjByg12mT1TirDFfu3mABMRrtBDKxEsxZm8wnpDt05PSA/LulFb8z
	7BVHAeBweRFnAD9FlEXdzLxzEBN1wmKo+NyaQQc7RtlUL1wckE4gva1O0PRmeVn2si2ReosOgBm
	A6HGbL/Yc3vBmuNG8wGWVoqHO5BL6gKXyQRBxY63PPJa/ucC/NAba4EVuuxBaYyXt7EAJ4CwUlQ
	w7U0Q1SsOdaKATf6E0O3emLv7oZziEpF0iGZ4z0P8SkhwYJHIcz0crqOxSrxZrbdJq2guYBMwVa
	SF1zilTJLfkuStpAW9pjcLBC19tIfxtXLIm8vKSNQIl9/en1ajF3L7bPTz3m9ZxMWa6f08ipyzr
	g0omHcx69qh5Jl2nAzudL26bwHKEvcGY/HYB9UFSz2FYofXHf7/nX1NtVIVSxhzKqu9+5in4wRo
	+a0MNQ==
X-Received: by 2002:a17:902:f603:b0:2ca:e19c:986 with SMTP id d9443c01a7336-2dd8dc0f6ffmr101808675ad.1.1789606217011;
        Wed, 16 Sep 2026 17:50:17 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89eba176sm18198135ad.36.2026.09.16.17.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 17:50:16 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 00:50:16 +0000
Message-Id: <DLH6GI0M7GQH.3MTAVNEGD97AV@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Nicholas Carlini" <npc@anthropic.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v5 09/10] selftests/bpf: Check callback map
 value lock identity
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260916212102.597335-10-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com> <20260916212102.597335-10-memxor@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 16, 2026 at 11:20 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> diff --git a/tools/testing/selftests/bpf/prog_tests/cb_refs.c b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> index 78566b817fd7..490e15e7126d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cb_refs.c
> @@ -13,7 +13,7 @@ struct {
>  } cb_refs_tests[] = {
>  	{ "underflow_prog", "release kfunc bpf_kfunc_call_test_release expects referenced PTR_TO_BTF_ID passed to R1" },
>  	{ "leak_prog", "Possibly NULL pointer passed to helper R2" },
> -	{ "nested_cb", "Unreleased reference id=4 alloc_insn=2" }, /* alloc_insn=2{4,5} */
> +	{ "nested_cb", "Unreleased reference id=5 alloc_insn=2" }, /* alloc_insn=2{4,5} */
>  	{ "non_cb_transfer_ref", "Unreleased reference id=4 alloc_insn=1" }, /* alloc_insn=1{1,2} */
>  };

\robot voice

This is the hunk that doesn't apply. The two context lines above are
not what bpf-next has, and on b
pf-next leak_prog still expects
"Unreleased reference id=4 alloc_insn=3" for an acquire done inside a
for_each callback, so it will need the same +1 after patch 8 hands out
an id to R3 at callback push time.

Chasing verifier-internal id numbers in expected strings is fragile.
While rebasing, either drop the id from these patterns (match on
"Unreleased reference" and alloc_insn) or at least fold the expectation
update into patch 8, so test_progs is green at every step of the
series.

pw-bot: cr
