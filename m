Received: from mail-ej2-f3.google.com (mail-ej2-f3.google.com [74.125.228.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDEE443E5B
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138871; cv=none; b=fjNemiW1AszCu6Hp9qMmCers/11moqxb8ro6RdKlrVICQpP34MW6W5/xn7fcG/gO23lhqHc1p06+Iy9fn5QJM2L3t4VFKHJZDp9aFBgHSb+PE9WK4vq5ywQIPzx++H6eADU3Cm9cttmdxUOtdDh8XPmfXJxTlK6XAdaolvF0thM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138871; c=relaxed/simple;
	bh=GQK0Peds9I7KUMB7R8rkxQQmjsehlzQVUOhctRGDiU4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=q9b2XBw4BZsJeXdNW/LcRRBwQi2/SP8S6Gs3xBo66iheIx6IiDmVd1RtGMB5q+sO8Ws2a37vr70UyNi1KE/oIYa45f4++gGQJI4HJlvgqETM1yKONm1aaf5lRIpuXsMhh6Beh+lqqE3/Ryv/e452A+eR5236/Ci1OLEkKshxizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfN3hQW6; arc=none smtp.client-ip=74.125.228.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfN3hQW6"
Received: by mail-ej2-f3.google.com with SMTP id a640c23a62f3a-c15dc93e168so349357066b.1
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784138865; x=1784743665; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7KxN0L3gv7/RdHQHqJVTM6RwHNzjV3feXG/+TNo5Yuw=;
        b=SfN3hQW66tRSVdtokz/HIs9d12tMiJFWClnVWkMqfHVwTFCy/zISpbBaErn6/eFhNF
         8I3vuusYu7dOoeYFac3MhyduSSR6Y3cEuWISz/kenK7Sdm4SpqDkSmtseG7p8il9NZyo
         C5TUxeNeEZ+VzUrtaQcCMtv6n1sIXXGHivIbRoUKHD7ZtC0A7sY7X4yc/SWv3D7vmKE5
         esx0RUuoxOiCG/KyF+3b0bWcU5PC/emiWKxm0hQ0mQLWhObD/7j8sCdNQqpBZA0ecME9
         fN93K3NQnDZs6Vcl6ezHdDNvWAyD/7d0244QcCO5GoJBFrh3VPS6Key0dMuJfDBsZEQz
         bf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784138865; x=1784743665;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7KxN0L3gv7/RdHQHqJVTM6RwHNzjV3feXG/+TNo5Yuw=;
        b=gpzw0QHN0bL9ZauEnX9t4O245ldLlqpeQOGe7Tnvn5MYC3qdfDc01vxirer5fyUogL
         mzNs3QKPaQpbEXAlcwv0tW3d+Ygi/WTHRXnitYzDNmZUeR3uxXY5dHD0FPtrEZtongEy
         CzxuKnl+EAgS9wBx4Ih4FpoWNvi5m+iKi+/YRPRxLqBpr9g58doVdC1t0VKapFnLso1o
         jJrQt7KHkQJfJT1JLgpLtReeYkSsQaN8Un9wuxTWE2Iua5zVdp+doU00x2oubnFUDQUK
         YNxF5F11xPjrDU4Tv/4CKKf5bJvjA8YlHcu9wNl94reI5P1uyXTVFxRUetqezCMvJrlK
         6UHg==
X-Gm-Message-State: AOJu0YzlTyapJeNUa/q49TFLwtNFcQysbhmxlQrlgWvuBJ+1LNPyIzMC
	sei5nJ6aIEAEtIokS8iVQvEhCY4i6TjKtDfs8TTWtF4NWATMyUBGMEna
X-Gm-Gg: AfdE7clScJaqyeHDviSZD1DLzO9Kx+K7btlL1yWAc0qdoSorQSTp1qnCzcEdwI5C8Zc
	a5yj43qDfa+r9Bwo1oufqoBVOhK6fMJF5hUcRRDFa2njgW3b2l8Jr01DGB4FQlM+S/bilrfJXfO
	VLuxXLGuJJURY4eqynI3mXPZVg1EKpceVtjERzMMWsjBRZBb+UqxDKedda03EkDuiGQ7M9VeYoS
	1f/as6gLJ2l4GiBF3pfl+3OxoyVDM2RlSS6oyJHm83NevDRqtxKRpNrFWK5k+kOlTI3LlQ83eOx
	+4zbfwXKgZJTjAGXT3Utw7ROr9Z+EfScIyiIMObZrbPQbTWXMprq8fmMR42vrp6fiXxOL0Q/0pr
	Hrs7R8mKQYnKGXMAMRhhxIJ7N19Th5C1kyURxSvAqQ0aIO2ADkEN1cMMxSiJ3hcbHvhIonghmMb
	lB66BXyHM731Q9dTuhurtPYKbFDv4538iTqIb4i896h3Ae2LlYff3qetIBdmDKF+DUSMlqmhc0V
	2smDfscKCdhse7ugv3LOz5ku2M1ZXa/7uoAQKjakMBu9McseRbI2s8=
X-Received: by 2002:a17:906:7305:b0:c16:4df6:1768 with SMTP id a640c23a62f3a-c16794753d9mr251675666b.42.1784138864668;
        Wed, 15 Jul 2026 11:07:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16871262casm74339466b.6.2026.07.15.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Jul 2026 20:07:43 +0200
Message-Id: <DJZCFZ2YF8V7.XFGQH4GPJCD@gmail.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Disable raw mdoe for bloom filter
 map_peek
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Amery Hung" <ameryhung@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260715172127.2416388-1-ameryhung@gmail.com>
 <20260715172127.2416388-2-ameryhung@gmail.com>
 <20260715173852.DE47D1F00A3A@smtp.kernel.org>
In-Reply-To: <20260715173852.DE47D1F00A3A@smtp.kernel.org>

On Wed Jul 15, 2026 at 7:38 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] bpf_map_pop_elem() and bpf_map_peek_elem() leak uninitialized ke=
rnel stack memory on queue and stack maps if the map's spinlock is contende=
d.
> --
>
> --- Patch [1]: [PATCH bpf-next v1 1/2] bpf: Disable raw mdoe for bloom fi=
lter map_peek ---
> commit 89de02f623877f9e477f4639136b8a23b2fbbd7c
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: Disable raw mdoe for bloom filter map_peek
>
> This commit prevents an information leak by disabling raw mode for
> bpf_map_peek_elem() when used with a bloom filter. It notes that unlike
> queue or stack maps, bloom filters use the value buffer as an input and
> do not fill it.
>
>> bpf: Disable raw mdoe for bloom filter map_peek
>
> [Severity: Low]
> This isn't a bug, but there is a typo (mdoe) in the commit subject line.
>
>> bpf_map_peek_elem() tags its value argument ARG_PTR_TO_MAP_VALUE |
>> MEM_UNINIT, telling the verifier the callee fills the buffer. This holds
>> for queue/stack maps, but not for a bloom filter, which reads the buffer
>> as an input to test set membership and never writes it.
>
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch, but
> since the commit message mentions that the MEM_UNINIT assumption holds fo=
r
> queue and stack maps, does it hold true if the map's spinlock is contende=
d?
>
> Looking at __queue_map_get() in kernel/bpf/queue_stack_maps.c:
>
> 	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
> 		return -EBUSY;
>
> And similarly in __stack_map_get():
>
> 	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
> 		return -EBUSY;
>

We should probably do memset(value, 0, qs->map.value_size) like the case be=
low
in the branch returning -EBUSY.

> If the lock fails (e.g. due to deadlock detection), these functions retur=
n
> -EBUSY immediately without zero-initializing the output memory. Since the
> verifier assumes the buffer is initialized due to the MEM_UNINIT tag, cou=
ld
> a BPF program read uninitialized kernel stack memory if bpf_map_pop_elem(=
)
> or bpf_map_peek_elem() is called on a queue or stack map and hits this
> contention path?

