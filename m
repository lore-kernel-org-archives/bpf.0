Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B035A3B5851
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944658; cv=none; b=d9/OItpHCX/Nx6QNkYDGU278wl/JCivYnFppe+u5X+UCnCdAkfQNKYCxmaAjMYHedZpa5c1sbgvR7bpIJrp1X6BEoYkowekXY/umoOKcEd8S5R0Z+GsHzlF9t5WHxR+WJyTmFYDzA4Nh/AGZ8mGvpwHojpy6Os5YdnqMSyTu/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944658; c=relaxed/simple;
	bh=3//G4a1mKsVNXJDkKS+wQ0Xx29A7KXOPO8fhkdtVhek=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KmuaNpjHtT1oDRv8+K5mOSQawjyYpIWjvgY4Bz4ovJHWR3fRr6TTY5wIpzaaO8oeTlsny7rs05RNAiF5JlxjtdqP0HiJLuqwybCzkfUoV7GgjV1EGnDcMfRP+Ow964nDoPKPgD4lXwqVtU3NgvIINUekzw75WTHxlSHcSou2NsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWohgijk; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWohgijk"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso38773825e9.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780944655; x=1781549455; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkrrnLM3onj1xHYtuHjv+MBj3GHzhIKYTT4eqYq97Q8=;
        b=YWohgijkHMgye7ExQn/HhgbyD0U1geAxx5jz+11kPGrxCRTyGWPnTyYOqKE/0meLJS
         5cEWYG+Jk9X8e1UjU0113nTrE6JOwAZEaTOOjrrdCTHxCNuHbxcUYULqZ/2oRdlbueDl
         AH7dSyY4L+9+hIB8WkBoRLabRf4eAuzPWjePKuDXIn9hHFU7cWdUUsTv7wMY9p/HmBXd
         G7WkXwHTCfDYdWwONIHbeyMfYTw8GmxjlmzvN7hPTZTvdHBREZtundpENyiiBjVIq/SV
         341q8UBR/OWiZqXHtLX7fS2zrHFkS0cSbvttaKoRaHoybnTDMMZRomlSJs5uhLYTcUvf
         YtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780944655; x=1781549455;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FkrrnLM3onj1xHYtuHjv+MBj3GHzhIKYTT4eqYq97Q8=;
        b=JYmbB8FCaEf41prV61fRZXlLe0GVYufCIwIjthqgGAQ8Eqg6RlQMPmwey5ZosgANBF
         6z28rQb128QKIH+S5YQn2VEEF6AmNe1TsMoYYb8rnFisslFaGuYFJH9wj5mNIm2zOZ9f
         M2boTfnU2sBbLJdgOL34BH7jB0XiOBrRUvV7xWNqPdjyWRNzrjHN/0AFtGgs3/fXWV8G
         emiJJjT1zSjJNSPMsRVJ4fnGY+e4XGTlqBkFVAqlRoSf+/fRi1BUqYYekL9bnP3sR5uH
         vHW35EAGj1ksBc3wVBpzuPw5I1Lod9CAiwHoVrkdbhEur26cL929L4KKQAVP9ECgep1R
         iTPA==
X-Gm-Message-State: AOJu0Yw/ybflSWgWLghZ/cMp0lQz3HdN4xWwLZRp0ZiiIGnTlSS6OaSc
	nLqIdhECb8Wg8V2s1D8+tF5dF1Qx5aZf1l3Ynu1Pv/t/MPmcvm+X4g92
X-Gm-Gg: Acq92OE5FLJ9nZrZq8szuF5KvKLJIE307Jgi2pVHr9FEk0Zg7pv1YAkmvIp4zQmkeA2
	H8kbYlumlzXLsFY1/DX4/fPi93M4z5BtOsXV50SC7i9NowSBL3p7Ws8dcUIXsXbwpRdbhfWbbH7
	Fyf5NDxrb8evsWPjYeQ1xsjKNCtKpOq6YpeJwDHwalcRMPpa45zD7pmfHm2ZW210i8y8jZKbv3U
	C/nbQuULqefcGAl5/H+Qo0JVhyCDlIZJdmdlk6IELw64y75FzNj9XfRBpAn7bOQibd/QeOEuGvt
	LWTJBwo9wn6Rm4fZZ7e3LHh0Fs8ueFpLk/P4KPJqS963+wIXXFCw+ZxDAbZ/V8l7BQvesksVjMd
	mjLjGnLZBnXXx2pWHVg4v7bjY8GCs/HTv/HjjiXT9LT0ZDUL5iE1nd5OX6hhNy2JRdJZkEns8+X
	n6F9OenyzcVExdrbpoQnJh3YLUgDyjEpDT2rfRylTUBMeqn3DUrj0geZ0O3x4MAcR1EkNU1gARe
	Vs4wdcSFIprB1QpZawnM8hlgSHUSl1TavQaBX+uEs5308GAjNUEulyDmzJZd8nz0gSBVh1ub4Ya
	mFbWD5bCpWM=
X-Received: by 2002:a05:600c:1c1e:b0:490:44eb:c1e0 with SMTP id 5b1f17b1804b1-490c26056a4mr295891695e9.21.1780944654854;
        Mon, 08 Jun 2026 11:50:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f34413csm53905213f8f.21.2026.06.08.11.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 11:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 20:50:54 +0200
Message-Id: <DJ3W6VAVBZXA.1I914ZIIXG9K5@gmail.com>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 3/5] bpf: Cancel special fields on map value
 recycle
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Justin Suess" <utilityemal77@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260608144841.1732406-1-memxor@gmail.com>
 <20260608144841.1732406-4-memxor@gmail.com> <aicB9SZfVnUV1rz-@zenbox>
In-Reply-To: <aicB9SZfVnUV1rz-@zenbox>

On Mon Jun 8, 2026 at 8:01 PM CEST, Justin Suess wrote:
> On Mon, Jun 08, 2026 at 04:48:36PM +0200, Kumar Kartikeya Dwivedi wrote:
>> From: Justin Suess <utilityemal77@gmail.com>
>>
>> Map update and delete paths currently call bpf_obj_free_fields() when a
>> value is being replaced or recycled. That makes field destruction depend
>> on the context of the update/delete operation. For tracing programs this
>> can include NMI context, where referenced kptr destructors, uptr
>> unpinning, and graph root destruction are not generally safe.
>>
>> Introduce bpf_obj_cancel_fields() for the reusable-value path. It only
>> performs NMI-safe cleanup for timer, workqueue, and task_work fields.
>> Fields that need full destruction are left attached to the recycled valu=
e
>> and are destroyed by the final cleanup path instead.
>>
>> Switch array and hashtab update/delete/recycle paths to this cancel
>> helper. Keep bpf_obj_free_fields() for final map destruction and for
>> bpf_mem_alloc destructors. Preallocated hashtabs do not have allocator
>> destructors, so teardown continues to walk the normal and extra elements
>> and fully destroy their fields.
>>
>> This deliberately relaxes the eager-free semantics of map update/delete
>> for special fields. Programs that relied on a recycled map slot becoming
>> empty immediately after update/delete were relying on behavior that
>> cannot be implemented safely from every BPF execution context without
>> offloading arbitrary destructors.
>>
>> There is a chance this change breaks programs making assumptions
>> regarding the eager freeing of fields. If so, we can relax semantics to
>> cancellation only when irqs_disabled() is true in the future. However,
>> theoretically, map values that get reused eagerly already have weaker
>> guarantees as parallel users can recreate freed fields before the new
>> element becomes visible again.
>>
>> Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
>> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>> Co-developed-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> ---
>> [...]
>>  void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
>>  {
> Would a WARN_ON_ONCE for in_nmi in bpf_obj_free_fields help spot these
> kind of bugs in the future?
>
> Usually calling bpf_obj_free_fields in_nmi won't result in a deadlock
> unless specific conditions are met (ie last reference to a refcounted
> object, using a workqueue, etc).
>
> Adding a check here would quickly surface bugs of this class.
>

In general, the idea makes sense when errors are impossible, but people
increasingly run with panic-on-warn enabled, which sort of beats the purpos=
e,
hence I'd rather avoid it.

If you think about it, there are several guardrails that protect us here. F=
irst,
we maintain a whitelist for stuff that is invoked in the bpf_obj_cancel_fie=
lds()
path, so we don't inadvertently start operating on any new, possibly unsafe=
,
fields. Second, the free path mostly happens in the map destruction path no=
w,
hence we need to worry less about random contexts it could be invoked in an=
ymore.

>> [...]

