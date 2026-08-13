Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018A33E7174
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611992; cv=none; b=ElGiiO2xNS6d2X9pReTADe5dOE6ZXux9v+Uba3NjWQJc3324MCPTezcmuEpXqLzc49LPEmSIsNek6Oc1uCIE0OVdfOlpT9r+otwelbqg4WVnzinS8LcoacKrp+ESYCB6r3dy/foh1NorhjDToy6a+vFBHK+eLXymxnB+1fDyh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611992; c=relaxed/simple;
	bh=fZVaZ7TjMrKw7+i2lbImOkpXxSg4IUmytFvvhSuahqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JlZ2HY9eJCOHZch3iX3z8+laycUC53ur9ARMBXhCte5uMO/20ChzelKGs8Ung2FfZcWLjTuSAnb/Y0dN2tCVhLY3YXBj124WnhBaAQ3rd5IsOLUaNIRKdm7mXo1YcylCgJ21K04f+fVTCvCyl/lJ4Y1zpeaA+uWWbljj0kjk2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WcGjmYme; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y25KmcrE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcGjmYme";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y25KmcrE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786611987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9N33LkksLPfNjIlTNbni8jbzLx2tB4hZrFzuYLnaQlE=;
	b=WcGjmYmeCpvCejdzjX7/vnYtkd2LQ47ZWrljQbzddI2Uir/CC/0KOGseER+x6l3/b3z2jz
	eTZnQLJNorfww58Rx4f4QkHpaX4re4m7EaCvy0OMZlqXWbiwD0+xkXg5eqtUvv2QxRGzFb
	FbyccHE4uiPYge3qIrVtZ857lMVJqPs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-xRxCI0YYOUWdzYZ9Kr9sxA-1; Thu, 13 Aug 2026 05:06:26 -0400
X-MC-Unique: xRxCI0YYOUWdzYZ9Kr9sxA-1
X-Mimecast-MFC-AGG-ID: xRxCI0YYOUWdzYZ9Kr9sxA_1786611985
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47fecbb553bso1584240f8f.2
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786611985; x=1787216785; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9N33LkksLPfNjIlTNbni8jbzLx2tB4hZrFzuYLnaQlE=;
        b=Y25KmcrEbPrKqaM41MtTogq9QEbFTjLISnEHcpgYhWx+5QXirB5IvxGrzXfxGNcLMM
         EaJDM8JX37dvRMT7gaqn2p5xQ2YI1Iaz0Q6T2NhTeVfJ+wXyZ0cyrghbtfkMUWYOsoTG
         epJS8LZ3RY34EwZ5G3o3XXjXGdQzM2EXI36AcNKzeQxuzg5lJSRzQS6khzWc1q/OA8vp
         9xe+0L5Nrk/bzeYRaZ+TnSec6cMDremv4yS6yBjfRr2wpJYjYyg1WEzK5ze9Y9Lf1mXK
         MPdrNXG1aPacmLzDaFZlUVaBTEO4n6xukCMuuzP8GK2b/fDF0YCZRN5YL9sAQs5d1++p
         r6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786611985; x=1787216785;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9N33LkksLPfNjIlTNbni8jbzLx2tB4hZrFzuYLnaQlE=;
        b=hRInF2xInq1wjRXcNjtRxYE5M7JN42SoA63fBv21y/dr8Qxk1JnrHepnKiMEpI2+xF
         NHWBRa4WeA8t91g2dsGeZrzVw1Ww+UyLa83aSLU/ChOrboBs9XO6HzBCLFxI+98vA4Bn
         Zed47mI/ZKRGKe0dYprZK9OHDt8P70Ed+CGp+Fe1Nge9KK1+cLelDvCFc5BIeILTVcXT
         l60HqfAnk7QLwVtsuU4h00Oz/nPNA1a689nPv7oy6K2SwPt61HW6hpCxjWxrCZzhXvK5
         sSKOTOdljuNn9lNoVrfMnU6fXkKiWtw6E4au3kh3zAmYrY2mxxhs7xFa1OV3eKPOAc6f
         NGDw==
X-Forwarded-Encrypted: i=1; AHgh+RpXMdzwkV415uWhTE2Lk7PoR9G/ATesm4wJ9PhhI9lCQY/x9Eh7Kct7zqm62CMfw9E5ZOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbYkiiYT7DBtK6/HJf4Z1v4BcoBF1inu8aVsOY16gjKQ6EzU5b
	QcRLnwmJl3E2MRdn7p/EA5Gf8cDrCKrcyCEBx15GCI7izVQGDSiNMW/McyhBSQIsU3y2Sxvv2N9
	NcEvrO07vo8R1j7XCnBt1tYTvx5ApwBxd0uyLda27Atk3GtRfFiCicw==
X-Gm-Gg: AR+sD12ez2rZgqfFTb+eDEvONsS7ebySBCXY0ZX166m5l57UYUPLj5c4yFSnqiga2Qx
	671+SsiXabLf8tHGChmycOJ6kHI3TonsfdNS9Rl6GEoKBqp7fEmJxH4x1MSDrWn0BQ40eAxYE7T
	umBj1+ozjooOS8QZOgIBLYW8Lbq+cvYjMfsrxtywo+5wuHq0rsOqu6I7yH7HzeyJOYmjrAVR8WS
	eDVVxiuS6lQszVV+G3Lp7B5Ne9/kMn4xWa32v7/FpL+tpGsVjqdiXxccdJpvBH83S/bxuJNSdRr
	rx3JnQaK4tR22CJUYLI9i6wHkyoVC8aUS5RXvYpTUD1iuSBaA4Lgfdqi5dsqPmeWMg5vlVSbI/n
	7iJZ6rQRQvI+OQ36ZT6SjiejVUgIBbMkSQdM530ORCIz8LApf9bSK2myNGZGqkD3wJP8DdTQ6oH
	8=
X-Received: by 2002:adf:e193:0:b0:474:18d9:8371 with SMTP id ffacd0b85a97d-4815a011050mr5799189f8f.28.1786611985362;
        Thu, 13 Aug 2026 02:06:25 -0700 (PDT)
X-Received: by 2002:adf:e193:0:b0:474:18d9:8371 with SMTP id ffacd0b85a97d-4815a011050mr5799073f8f.28.1786611984862;
        Thu, 13 Aug 2026 02:06:24 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5613e2sm6119566f8f.6.2026.08.13.02.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 02:06:24 -0700 (PDT)
Message-ID: <0c4e75f9-f7ce-41c9-aef9-a3b3b474c695@redhat.com>
Date: Thu, 13 Aug 2026 11:06:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: cls_bpf: reject dev-bound programs bound
 to a different device
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: stable@vger.kernel.org, vega@nebusec.ai,
 Victor Nogueira <victor@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>,
 Quentin Monnet <qmo@kernel.org>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, bpf@vger.kernel.org
References: <20260809094418.901607-1-jhs@mojatatu.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260809094418.901607-1-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/26 11:44 AM, Jamal Hadi Salim wrote:
> cls_bpf_prog_from_efd() obtained a SCHED_CLS program via
> bpf_prog_get_type_dev() but never verified that a device-bound (offloaded)
> program's bound netdev matches the TC netdev the classifier is being
> attached to. This let a program loaded with prog_ifindex for device A be
> attached via cls_bpf + skip_sw to device B; deleting device A then
> destroyed the program's offload state while it was still attached to
> device B, triggering a netdevsim WARN (panic with panic_on_warn=1).
> 
> Mirror the XDP attach path (net/core/dev.c) and reject the attach with
> -EINVAL when a dev-bound program's bound device does not match the
> target device.
> 
> Fixes: 6c8dfe21c435 ("cls_bpf: allow attaching programs loaded for specific device")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
I understand that Jakub prefers going with this patch (with a correct
fixes tag), so waiting for such tag landing here ;)

/P

