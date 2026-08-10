Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC4332604
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390258; cv=none; b=Dn239h8x28csQC8WoGo+x35BGNLue8ZTRfZ9JzWRDIkLK1mJ6BIgd+QOyYb0AZrEchCTlAlQobaJq4gYkUkYkyeW0jOE4uNiFaE8dFszqgrmj/bnGL3WPVx5/xWcaeiMKVVUtLMnDKmet3n0Iqegb0j7ljuIJkdpoS71BBWpDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390258; c=relaxed/simple;
	bh=ez/LWSIdBA/RKNAM9CkBfCrfJtyE+IThwKhIJNgo0/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=StlIH2n7BAu3EV9JBlOOYAno/ojI+bWAFjy1k4FDfUUnOh6iEBLhtnlk5T66bok9HVxAMiXLwwfNr3pULRjUOGWIN4Dmw5eEGYYqpqV/eAowhUsMbfgMsdXMQc8eeNZGCRHXFoD8KLejbAzoz46BN32KQG20Xr93V5ZkBl9eY9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPzVDE83; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPzVDE83"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso25472145ad.2
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390256; x=1786995056; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ez/LWSIdBA/RKNAM9CkBfCrfJtyE+IThwKhIJNgo0/8=;
        b=qPzVDE838jUAeu/fHtRRnRCUDX7PpACXzMK/T1/TRDx0m2vZX5dU9cXrjcNHx1DvfA
         yjKRejqOPVOun1oS5+XqCfF1ZJ/MZyrSoKXi2L7NPE1DC19ZMwBjD9S0e5sI3fp/Ragj
         aeUFWdlm4gT7wdQkQDRSqP59Tm9xwTgocgBDhNAgXX/jmIbRhq44OjJkaOggcYx8X5Qw
         azBgGlRDv/IbMd8ckROUC2tJHlW84oBXJ1IU+7wTSyug6cmH9TdFaqUxa/7SkotJcyvT
         fNHafUZ9CeJbA5H/DVKAuVSSNDOwvixrr9qGVNnNpJGZs9lIyiEnTOfNtYLkuDuP3Fgj
         eFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390256; x=1786995056;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ez/LWSIdBA/RKNAM9CkBfCrfJtyE+IThwKhIJNgo0/8=;
        b=IrPlxefy2TDj56zj53IB8gAuaZ96jOjiAIIHP2/jTVkXwhAcV88Pu7Boti6B4dI9WY
         FL9jHHK8GGc4+9LGg7eZKklwaSuNUJKqPhhb+e0dw7R6F3I4Mlvm8iZZEwBwEXLTRtmq
         fY50+0GMrQYvtb5ILyBlN7st405nmL9xGkgxXPVtBxHx/Pa0UX9QLfX8Nc75ENKVeHP+
         qV6tS0CaHP9AOVIcBJ7YLl7kEx/toqROo5VakMapSBKelcrGhOY+Ku0DwCH7BoCGG3pq
         a1wKJGm1T1KRKqk7PrFTAcywdP0XqtpcV2Cu6l0WMuQS2lVQzVEQXD2BrAIcloy3n8Gy
         9JEA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7ZfUrmemCF24E3poc7nOx/aYL3P+ag5ECZm+Ypxx3V0p3EqXprjTUb97BtYLqK3J8TFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50IZEF1i4LOOHEMN3E2ot0xxxlMOPZyaF5WwdYhb0yNlTkMNy
	5HXzkcY6A4TnjDLhOz9Cp3TasQpHYCifa/kt4ozFvSv90o6jlZl9THBJ
X-Gm-Gg: AR+sD13IOSKa2ZMyjIARh1pxFZSteApz6qJOUwpUwvpINI1ShoVsZvk0bDxMq9OzTCe
	AHTrhwAqjtk4sOX5SoJVB0r0fMP2Jh//Snvx+5mK2XfEVml6ceCaO9o/jsqffMOJ7RrpvYf4inA
	GcTG5wUchuBLn1IETmsOTHY3encyADOX/j3GHSrDtOnMP9moITM+Aoo5BRR/zAlqcoRacQn0Ddo
	W+1obBfrK5pSR43yHrat1aZoZxBkYhvEyaNb8VvUaLlIvVoECBkLAKMwqhKiMgRHTuwJ0NiUsYy
	9Gp9O9dCqlSqtbCQzmslsCGDbViscBYF2+UyfFgBGCdLN/wr/x+lgc1bIjv7uTTZFJ7QxYJR9TO
	c+Fw2F+3c4OR0kL7XdlPUS8D0YG6sH7+VGMiWfQaL71rUSPf0bZzUqG5tK0lVJJIxHLcI9tP/1w
	3D7rvAKJ/I36wTGOcrhpxJt0WVhLlgwr9yQGYNJbNp5ARANs/V72IBHOknByGCEFQHIT3SpbrWG
	IKEJWL88RaKwaME
X-Received: by 2002:a17:90b:448b:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-3909d8c3b9cmr27977660a91.13.1786390256493;
        Mon, 10 Aug 2026 12:30:56 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d5238e13sm737925a91.14.2026.08.10.12.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:30:56 -0700 (PDT)
Message-ID: <a3c4305c694a07aa020f4b0f0e4fe7f58672b5cd.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Account for preempt and IRQ state in
 RCU protection
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ning Ding <dingning04@gmail.com>, bpf@vger.kernel.org
Cc: memxor@gmail.com, puranjay@kernel.org, paulmck@kernel.org, Alexei
 Starovoitov	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend	 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org
Date: Mon, 10 Aug 2026 12:30:53 -0700
In-Reply-To: <20260805233940.3966981-2-dingning04@gmail.com>
References: <20260805233940.3966981-1-dingning04@gmail.com>
	 <20260805233940.3966981-2-dingning04@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-05 at 16:39 -0700, Ning Ding wrote:
> Disabling preemption or local IRQs keeps the current CPU in an RCU
> read-side critical section, but in_rcu_cs() does not account for either
> state. The verifier therefore rejects safe kptr accesses and invalidates
> pointers when another RCU source ends.
>=20
> Include preemption-disabled and IRQ-disabled state in in_rcu_cs().
> Invalidate RCU-protected pointers on RCU unlock, preempt enable, or IRQ
> restore only after the final protection ends.
>=20
> Signed-off-by: Ning Ding <dingning04@gmail.com>
> ---

Hi Ning,

Thank you for identifying and fixing this issue!

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
