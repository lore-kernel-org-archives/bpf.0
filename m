Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27D1BD9C9
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 01:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845387; cv=none; b=jU0nTjpnZYB+WuceRrhvtD9tdnrhLHsCNhjjpb5bI+ajORNgZ91cKEobfUSIAtrv15n8bsGlrl0AnUEmzjH+tP/cFj33xFCp8DIu62N2t8kJpoNzilee0zp6LuaO6IFh5W5zJoiRf1LF8a+Fwe/3xxbUsImX9XsRHwvxcxSKL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845387; c=relaxed/simple;
	bh=p7Uqjh1oUHatVz7b4wm55gPf7KwXAFhCF+7bkVvn5JQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZvRKAxsgaaDzriBP5IidE52P1FwDyVHya4ZcIXicTLL6Ti40gqzh1rwsDRvfOjEqhFg2bWhQmgQJ66WaNvb04xcSVoddhrUB16aUotf9dJ82UMZlSnfp/hleE1C3JC6dQRwnkr5c6xN7WJyfqZ+UfTXXw74OCVEBxpzH1wP3jQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW3Nvz12; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW3Nvz12"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be06c02f66so1611693eec.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 17:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772845386; x=1773450186; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p7Uqjh1oUHatVz7b4wm55gPf7KwXAFhCF+7bkVvn5JQ=;
        b=GW3Nvz12ok0cwZsOSOkKGg876+Cd3URPgKbAkgamsfhjV8UnKpGc6Ex2yfYb0LPFAS
         Fef95Xsa9SIxGxbY8CU3QAL6BwqQoDwRApetx2WfALERVNZQueQpSKL1XSggqgTJs81j
         M80XL4xbBcrzFra9UaqhRMVuSMJm57/jrgvtsLXhkxR9jCLkIUyqsgrPBsi3jUeWkppE
         MGJYJ7ImRBwNJkFO9obZorD8/oTG6cvJ5EtCje3qnVWDEtnVdnUeSF8ynge5QJNI38gr
         qc18slTirBdStsM/7khyMhdv47OU3vEztY53z5KAzunCG+0Nu05WvwAUyTDsUp080zEf
         WrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845386; x=1773450186;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p7Uqjh1oUHatVz7b4wm55gPf7KwXAFhCF+7bkVvn5JQ=;
        b=tthgvIYOgvBflB3Uo78KnCo35Kc2TKQ6FyzT7WiaD3E6jqnDTKaEDjf3EUieQS8th4
         3RTJfEoRkkT2lmuMc5CFp9ZVY43qXfpDvmWBztu0P36CLImGLaOVCSq07WHLWl8AzS1v
         Wofkc4X2ijitmKo0NgnCXoqBC0wrXUCUMw2eX8kRGh1JlS6M38vVL0K0MN4QKuXcfhi2
         r7TvQJRFfneaoI7VwL9CJgp+UbHvD0LcV9HuRL8LA2Bs6zSgIMklm746v3+LhVXuzaSp
         N77Ad+nNB3n3cVg15qu8pEgb77X0ELGoSxci18LnlQl0+Ux/sqyJ7tYA5MmacSXuzfPb
         /02w==
X-Forwarded-Encrypted: i=1; AJvYcCXgFWbjiMYW0oGGmlh8lFmz7hXOOTHVEuuKhHQOwnXSYfa+hc6nYeQwwyP9z2UlHNF+BDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7lVGk4lZRxp1y6msy+GVRDh7gvc1UY3JqiHS1BXQhCGAnOSj
	vhJGKjEEhkZvVnXBuWslYqZ5RsHVs0VgY56KUwHnoaFVAxvv3zMEYqgG
X-Gm-Gg: ATEYQzz9fCNhuRiKPg0+nnd5w6FOZq1hdUYXtyz7EgjAxuNYCKiAxIt9mUS7suwRzv5
	Hm8PeHBlvQS1BlOjouvwrPrIwTlzubwT0yPulqYki3qGNnPYAd7fJpN5xS1CPSSwBVdPsPNy9sr
	yd6bHdoPQP/rCwrp3RUZrL/7fOVCW7q+pzqcYAKhiIYXQUnwto7vrnNsG7BXk1VvrtIEYnrmuVQ
	5Q5SblVxv1j+WHw6hNoVaMtqYndwrzGtGhnLzL2tU2c5ossTI6tyxrpiqYYUR89Twv1KYrZBuqb
	YJEzp5BQrC1LIjrxJOFXlDXcDkZIXpGB8iiYklynk+GCbKd/aqNgbr5fqobM1ipInhacb52TCbV
	xiKArS/N7oKQTNdguTNv/TskI7aowDNEv6QusRuFyB4QhZHGlCwaDZFClIvbCDgaI6teM0NCcrF
	3oAGmfSHyG8zfekC7jD++70WMbPt6UoEFnLf2m2ZzNCduy1p+sR3ax0Jrdz+RzjaGvdunk30T+q
	l5GgM5kulnV24E=
X-Received: by 2002:a05:693c:2c97:b0:2be:2a15:efe0 with SMTP id 5a478bee46e88-2be4dfdd2f9mr1391783eec.10.1772845385769;
        Fri, 06 Mar 2026 17:03:05 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:d24:8c8e:7600:6b8c? ([2620:10d:c090:500::f1c6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f82850fsm3042970eec.9.2026.03.06.17.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:03:05 -0800 (PST)
Message-ID: <0b1d7e7b594a8d2edb66b72783b4e9350aba6265.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: collect only live registers in linked regs
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, emil@etsalapatis.com, martin.lau@kernel.org,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Fri, 06 Mar 2026 17:03:03 -0800
In-Reply-To: <28ff0a701e78a62c807b7564e4332bb1412ee44fe28c133c173c668fb07dbd52@mail.kernel.org>
References: 
	<20260306-linked-regs-and-propagate-precision-v1-1-18e859be570d@gmail.com>
	 <28ff0a701e78a62c807b7564e4332bb1412ee44fe28c133c173c668fb07dbd52@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-03-07 at 00:55 +0000, bot+bpf-ci@kernel.org wrote:
> > Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> This commit fixes a bug introduced by commit 0fb3cf6110a5 ("bpf: use
> register liveness information for func_states_equal"), which made
> func_states_equal() filter register comparisons by live_regs_before
> but did not update collect_linked_regs() to match. Should a Fixes:
> tag be added?
>=20
> Fixes: 0fb3cf6110a5 ("bpf: use register liveness information for func_sta=
tes_equal")

Yep, that's accurate, forgot the fixes tag.

>=20
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>=20
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/227876=
54290
