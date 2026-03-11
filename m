Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B141E8320
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270523; cv=pass; b=Ta2SklIkZQHkZI4PJ1uiTzc5y/wAdkpVx3D86cu4lt/VDr1BjdpfpsWrPX6uamGtR2trHrfVHo3y4FM6hAkfzgEOzHbMdYz9ot1KFl5M/HEN9AHfEPe6V1vNRNY7/qNVsePsDEhytK1pS9ti36McVW65S2wXlaZkOLpzx7tHBYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270523; c=relaxed/simple;
	bh=A5ce4UaFUjUdZqJywYRz0tohnq/zqXrAj5p6kWa9S8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hP9Yru0lm/a98iGnOcOy/AfqeiYeG9FedtRqTmhhKenf3uWy/OEC+1zMnO+IZx4W3iaVxu8hNqIxgRPhlbY0ifplSf32y3NsEtmuTfgM70y9YxPF/YVMUFosjciAPeewOfbEU2RQOOCcQ2tjRlWfpysXNGcDq4LsDruaNATxEMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AawYeoQ6; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AawYeoQ6"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-439c56e822eso407059f8f.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 16:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773270520; cv=none;
        d=google.com; s=arc-20240605;
        b=QEdQF5YbiM8liljneqHxjaPL1RlSTXKZzUzwggnIUkkib0XdW8TRN2vNhunVqBAqVQ
         PBSfOLFQ0/hJ6RIR+2F1JuFGjlQXBEBmCaoEidPKqcknSX7s9yC7cs8jehnx35x5n9ds
         JGfuNCN1K2F8oN4cUPUElDFYJjHHnqLprUxUC2hCzkqFBS5sPxpGuzZfWYLu4zlDD2vX
         za7tR5+n+GBqo3jhmJ4fqwfvxVhDSGeOvUbWj0wyG16aGy9zWpqfMxbFoIDvc9hTL2Dr
         UQzOBPGUpjSnNKYJaB62MLOqbfMCocLVsoK4CTU+E0o68zBu7cX7DUT/HGpDFKOsXQcS
         zdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ObBiwrIkl34XRQHZ6g0LKxnd7XywZyI+Zh4huASOv4s=;
        fh=mV8Uwy03aTQpEc71kkKqimIDFbwq2oIhKiU5zAUO9K0=;
        b=Ieju392As9O7lhg2kBmv7S0OI2jJ5W0Rc+3YywcLc3E6LcODvR2+BqPRDNpjoSFaJR
         Lj9q9GhTge8sBgZ80fo0OYf+lvphN4UsyrI9zLGLZBl1WJEAVfodvS/jW8MSlZqiPRQo
         yJI4xr9OMzQayHzxLbbuvifEgDCxWO/gXye3p3mPYn4LMuDTjDz41pbckf123cwZyZTL
         +m7xBJIV1dRVJ/RlhhRR9DVnblurYMETqdyHbwgYybLLdFFLLmdQBuLZWt8yeNNhkLgc
         cPsZuz6AyJMt/40RQ+3CYUL7TuTgJYxDXUzZe6phWLzjx44UWiTIgLIqr3KknvLTxrcA
         ZvrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773270520; x=1773875320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ObBiwrIkl34XRQHZ6g0LKxnd7XywZyI+Zh4huASOv4s=;
        b=AawYeoQ6Lio/DB3ZPjxpamHrYE35SBRJYnMyhVoCNpGgeujoot5DO26l7KhhHmwM3Y
         4R8lcjrmSzfbKkIQjUuru+xw3LId1oEqb36UwaA0mbWKO6chZbzSpsGtE4T6/c9Cnt5K
         5okr3y2N36iks8mQFgPwImDFPGtxWKLxKTBaPNLyURaGySq438HvYQoO1+KRUI0iBzGV
         lRf23bw4UXSlFPpMKYJsy/2i8jxmCZdz49MWLzngHf4XlhNzigjel5jKHQ/3zefxnyhA
         Qkhp3XMoCMJpm5c+eRNuRdxkyG7OBj5vmwmnh1dN+zAtRrFX0LQ27EZil6KtM9NMBmBA
         6f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773270520; x=1773875320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObBiwrIkl34XRQHZ6g0LKxnd7XywZyI+Zh4huASOv4s=;
        b=gtEVSJbny4StS0eEI9V7JEf5ZfCH13QnlzSN8XapHaIpTolBZoQ+c/lCt2nn/TjOHz
         iIVyNLY0wxuRn3hJoIvRiKZKUpe4Ozkee2+0CCyF0lm/WOAHrfRllxlv3w2DXRUTHmff
         kHDUuhoI5ZzQraRBmR3YqXETuXGQrGquOQrIc+q44Q1vHU1NYSYZ5QvI4vbAQ+wOxE3j
         Bi4lzykvqidrK2FQrP52Zo/2PD6SoPsI0J4NE6DBkypChMdqmmZINfTqEPgPpFg1m7NZ
         6RSwJaRC15u3ipXFgMjyjV4+zW1hJIcce1AugJ13L1vIyvGTlBeYiN/mc7lSIT3hjEBY
         vZwg==
X-Gm-Message-State: AOJu0YwNVgtVwnfolKejw7lcYAX6FEXS3VfT6g92eOh8uQZWMjdGdQZH
	7Z1JBnCgiwOyxBlZWBm3E6X2oGooNw7aNPyLrNaHUAPX0LZVEQ46C8AVta9stJ5romCZnbvZ5oy
	3c/+yizNKOUj24ZvJyVk3i7zgH5yAUAk=
X-Gm-Gg: ATEYQzxuh2OA4spAQXFCDXvyNhYOsw+0Mgh9b9N5WW8JKCGrHcLwsnUKNQDdjhJM1q7
	IRW+H9vDN+65W+TgR7SmcRqAbJ0xLdrGvyKpw9G7D4mB2QboDaytOA4M3Of4jm+o401YSR0lYtI
	PmQp2UUUeCINL/2I7soQpOzy9lHKm95x+Hbtrof4dalHem2DbR0+U7bvv6LTdTBOkU8V8cLKryg
	gplHtmIKAwjFAkxyXLukoPbhvXRn7vCaF/ijyU/ACt5jflv3WOHMsBFQnU+RXcwmIFCkGXp2DNV
	HgAirt3eS3Cg8xkEC+XgcnQmFY+IyB74lgO0G5zk+r0/kpWMCwKq8GgnTpcTJNksOHYCW/I=
X-Received: by 2002:a05:6000:18a8:b0:439:c81f:b96d with SMTP id
 ffacd0b85a97d-439f8224ef8mr8637271f8f.51.1773270519937; Wed, 11 Mar 2026
 16:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-sleepable_tracepoints-v3-0-3e9bbde5bd22@meta.com> <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
In-Reply-To: <20260311-sleepable_tracepoints-v3-2-3e9bbde5bd22@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 12 Mar 2026 00:08:03 +0100
X-Gm-Features: AaiRm51TG4ChRJE8cYKPkdt4aZFAQZQ9WB4BKbjOt76HC9LrL9uaTNi26L2KZW0
Message-ID: <CAP01T756MsV43dVGgQv+1B1pHMqmX6akQc7Un_YN2U9qtZ2jEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: Verifier support for sleepable raw
 tracepoint programs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 19:24, Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add BPF_TRACE_RAW_TP to the set of tracing program attach types
> that can be loaded as sleepable in can_be_sleepable().
>
> Reject sleepable programs that target non-faultable tracepoints
> at load time in bpf_check_attach_target(), providing a clear
> verifier error message.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
