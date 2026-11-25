Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795593110;
	b=kyVyLC9s8Y1Uzwn1lqold17SRRDhXaDvKVwxEKkNcIcqtfpIjyzaI/3DqyzzRW9tQI9d
	 C7hGeWB35allQQMbTDqiXfh5AzLJ1Akrdc4nbF44IhrEyH/PeAOTLOjvxH3Us3oAYHmX4
	 STsIiYqKLYoiBbubFhXMm1po9JQGsKd0X5tGB0ooU/NwqbCG1WNR0H1UcadjClvuXw6fL
	 W1qpfbD15BYk935Sb6iUTXr1x6I3ZjEQuAyC+n0dXgYwZsmVXUtt0/9lXngrWzLMXmzhI
	 nd+OXkBt4JAoIqQvwVNCBzK9UqtDKS+E2z+Xb2LuVDzzHOe59okpDGxa1M8Z9H6DyQg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=p0lhzOtnwWQvl01Hd5IyLv/vRq0/clLzuGz4CTZBUII=;
	b=jV4ofBAXNLGV9X4U/vC1t2xqd7MpaI/77Q09HnbCk+wdOnW7bsMJqEWEzJREfHPVEfwl
	 fO2sdE08C5UsXFB5PsjWxw+7JTDfC0Mj/MVAxJZbnnLWtZtFanLv3Mw/ejE8hctuUedVY
	 I2+Me0t+0jctZInAHZdN4tuEuVRNbT6jWNG+ju11+m75sx40B2zXL2LFi56zpXmglHY7V
	 g/IE2cRwz9UXYGXe8ZIfr1TzzWamCQGnePyEbIJjYEafmDJLWFu3/4GxRgEMdc5tbXcmr
	 +tdr/Y6fT4COxMyqRlLxLSob3SeohGHcGf06ujWr85K1RcVqJQ2FJxDObAIyEJnfznQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RRaYQcAJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB8606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 07:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CAB8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RRaYQcAJ
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c511c0e2826so621415666b.0
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:51:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795593109; cv=none;
        d=google.com; s=arc-20260327;
        b=WNHBomer1i9LTtvs85ty6rJLQ4GA5s0BqaQii/SjSsMhVSTk5bnQAEzvfIFN6Rp8qF
         IHob/+u79h4bp2fXWNE2ttYHbqaSrck+wuh+jz7vhXgrASwXsvvsgpbhPZzvalJy8pCr
         ghYSo3H2l4LaQ/60cz8U+/V0K03i4zGIbtKhZRN1TEUAxZyra1hkHd1Z08uEON1qFVQR
         cbcP2e2FrQj4CgXceSOMT7OMp8UOsGlxUWr8Mmt9JNApP7E3byRXeRNQSlADKAcHgdBF
         TQdU7YPHHuU6IOs5uzZptnbFogJNVCNh6tgTzpT/RCvUN3q37QAjuD0F8SvqndqDfhaf
         hMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=p0lhzOtnwWQvl01Hd5IyLv/vRq0/clLzuGz4CTZBUII=;
        fh=uzW/aLP2/86v7l+LofbsNYLAO3bdrqC3uwuWNhc7gqw=;
        b=UeleAs8HFmtsizomARSwCUJadngD6VLWTtsiNQLljM6MTToUE07qPtpsNxIgoGM1Yr
         OjjCRFx5o+OBtQt3nZmShaDEeiA9LmkROuuN4HaoB3WDXAK+2mVYoWVlckbbzHwEenF5
         UosrO2HMJELMpFpqLJfbKR822RQWhQ/njFL82sd9IIQtmqsyMIq/f+23+BoGO4xDNhOY
         jgGVkk+Iq1Yq3BTNtHzDL/NNcV9/xEhNEVV+8FAIdNyX9HhUrVDIkcOwOsatoGnOkOL4
         6Elm+WZNq7dtWETf8EcgWtYnaI1GuIWHz7KksUdK4yhClm+rfaCNNZQiCLZFP6VTWxzQ
         h3uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593109; x=1796197909; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0lhzOtnwWQvl01Hd5IyLv/vRq0/clLzuGz4CTZBUII=;
        b=RRaYQcAJnTw6cYto2S1sQjfWCZLUqnUsXeLy6b3+ylJTBVQv0gaibjWyVaO9AfJ2ab
         Euor6O6Ab2303Cn/+k/0GOVIBYR+c0odqtBWScaUAdIpmvIlA6OULFQKkLxa92vL6gTv
         nWC8buQiBjU40qwRFdh7TdK16MW3UpTlaOko3BqhrsAJ4Yw+9b9A2jd602Pfga4wCB2J
         wg2MHIm0jpOw9S6hmOkXUXsfkAoBWNoePOjAa4UTGMcrLPGcKJX+KR+cYpTBJDa1+Yb+
         +c9vTHEheOWRFOMs2PkyVKluwC1h6X7357JRkc1IZy/OtWt7EwjiZHpuwUaZt8st8AD2
         77OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593109; x=1796197909;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p0lhzOtnwWQvl01Hd5IyLv/vRq0/clLzuGz4CTZBUII=;
        b=LESTz3vaOxoWYsHpTGvk+2OGfwqdsm6sPEZdsZUd6hr630nSkvISVY8hjvAz5V55P7
         sXsNcqn5nq36iXZQEVzxDiJ8HeNtoAHxSQ85w+qUd9VuDrjFQkb0kM9XK8ZQZZHr6ZPQ
         48waiR0VA0+T9P0soq+/bp5FZ8OWIP9t+Uc+DXUeOA0RpjMtkGWYolTvzulGmxzLgsua
         ZsHApUXshaIVvV6JqcrTkunc0hoNjvVw4zx82F0K1sRbwLjslnormRtvEoGHiLUw4BMk
         EV3s65+3GqCdOTbFqriX+71GOgVyKxn5GCUSmKUwzZbqnhLw3HK9qfCtMyV9xVgj3zGh
         31LQ==
X-Forwarded-Encrypted: i=1; AL+hErH2+Ubjpx7dnJRE/Q5+Hyd2k2JSZpBrXxKwC3+KLvNtmfjDEvMQMK27OIG0FgL/Pdf7T7w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ibef6pgR3d43+11MAAb7CV9Jfd1SH7+BHLYD5+xOJiF7869WN
	o8tfBrPOudmFgqgpNAfZ2JkHq0tIuBHhurQUzopksa3eURG3pia36lPdBcPSKQ+2Hhha8aqlFvd
	Fmaxrp6uCQH166bf3DfZJcFv+UOIgUKY=
X-Gm-Gg: AZFdTZfAivnf6ICDS6l/hpEaRukcdNk0wyOh7BD9+oplZPvuH1NuotW2RIhOswfrT8z
	39/d58OoWMMsa7AkvN8Kdv1ioxsBbP4QugsPn3NgtAPWVhwdmB93PwLnZpGXu5ZceRZRaXEq0VB
	beC/y1iJ0iAbOWn/8OetYgQXVepefgx8lpPD9I//zqC+XnDh+cI4r4TJ71sFGnlt3w3YRiZUIB4
	J0tGBUcO/eKnTgSFJKjNqEo3q4urEqXoVUKdLMXjTO9svXLhqR3q2Di6PoGedmziRMepFKaqzsB
	BCuThr885Mf31efq8L9Fo/LlipHEHv2GxIIVKn+ps1SE2xMKTr40360S14IImdCeqHRk4mg4rMy
	r5voYW6YshGKwyF4erBfvNVPcHVR3YCp1ZD5DGq8=
X-Received: by 2002:a17:906:dc91:b0:c40:231:6ea1 with SMTP id
 a640c23a62f3a-c513ac48cd7mr1278296066b.43.1795593108680; Tue, 24 Nov 2026
 23:51:48 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123124855.1021-3-filzador@gmail.com> <179552678713.3135.6451619234057473485@kernel.org>
In-Reply-To: <179552678713.3135.6451619234057473485@kernel.org>
From: =?UTF-8?B?0KTQuNC70LjQv9C/INCh0YPQtNCw0LrQsNGB?= <filzador@gmail.com>
Date: Wed, 25 Nov 2026 10:51:35 +0300
X-Gm-Features: Aa3M54rUw3T1CYpg45U3lzI0YpZnJlQtwZYt4-OEkXvGNy-umReq1Lk88Wbudxg
Message-ID: <CAFwykAwbXLiLkn1N+WwaQzCiVW764_RPjFSm35g3MAQHzNN0pQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/5] vmxnet3: keep the previous XDP program when
 attaching fails
To: netdev-bot+sashiko@kernel.org
Cc: ronak.doshi@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, u9012063@gmail.com
Content-Type: text/plain; charset="UTF-8"

Thanks. Both points on 2/5 are valid, and so are the low ones on 4/5.
v3 will:

- on a failed attach, bring the device back up without XDP and return
  the error; on a failed detach, complete the detach (no program,
  reference dropped, return 0), as dev_xdp_detach_link() ignores the
  error;
- close the interface if the device cannot be restarted, with
  dev_close() rather than vmxnet3_force_close(), since the device is
  already quiesced with IRQs freed and force_close would free them
  again;
- change the redirect target feature only after success;
- count the two body buffer allocation failures in drop_total, and
  say in the 4/5 commit message that the non-XDP rx path changes too.

pw-bot: cr
