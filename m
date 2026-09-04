Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCB247606E
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522069; cv=none; b=PFcAN9W1My9tn2p6xPbvf2WJuY+VwtL4NdhDf5fH0g4baSO0I2vdij87djU20mIX10SmZ8MZ8uxKIUryQ/XtB/zPJ3YMaBtdkqSoQe38Ga+sVxpiFGg2bWMgGRJtIZJSx+Ijks59OX9BEWKZHQ9gn0gGcXKLM5GU7Y/cPiomsBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522069; c=relaxed/simple;
	bh=Q8HU4Dj/jZbI8IsVvRVh0PhoSicULEYOCiGQmKItAgU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=knJpDwvwPP/baR8HMSANu3kYA+ElJiSnalon6Fem5yKbO2NOxlp617klJpjgqjvLkac6EYpIGiqm8XuYvQJel9V4Uw2mqVMG9pgOuqUXOIL7z5ubO8aZLLHzBrpQM0pVsYPYI795Y/S3obkynagydLQrRhdfDVaN4X0w7S0nbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJnINDWu; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJnINDWu"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so2790275e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788522066; x=1789126866; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZsQlt8wlSmLLCcmfC4UkszaLNl9vEWULZiFqjg7Do5U=;
        b=sJnINDWuel7m8FfwGsmm1xqtE99Y88KIAmpO/O6qfkqQ8imlseo4e5XTTFSHeSlnIy
         XA+cxi2+QJNG4AVO1wurS95RJ/7VnNVc7x7wkf0gvwVux0qsTp77UKBIc1q4T/xmsFpd
         OPgeTnf3sNXynrOuJWa3BESC4ZRH6Vx+9h/sF6Vcn1bzaLVApsnL6J7KOeuD4bJrH8Mx
         tcrguufBbXG5yIxlMEKIan+4vZOwWEibsRFecdzck8PbyD4LXcaI+worG8y/VSimZZK/
         3XF/5fxlQYF3DZflQeTlx5CT75RvS8F80nkkjzrEpkNn7Yr9d38Iue4FtGTcsRBxUhyU
         +ZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788522066; x=1789126866;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsQlt8wlSmLLCcmfC4UkszaLNl9vEWULZiFqjg7Do5U=;
        b=k2HZsuQvdOC17dI2r3+CJBq/K1zcZmd3W96G4AlwuV5+ZS7Z4YBcGWfxFehQu6iJ1Y
         iEQWqzM0kICgVEmKGFK+t13wHkvyh7XyVavfuxLjDo1Bg7d0mthNPKZMTmbaJE1+DvAu
         y+D9aNvu86hgPqrl0M42BKlga/r+cJyJ51dA89/Up33LbfVNpQxfrkus0011+07fs0BB
         0ZFY+g6/jeiVxRG8uL25kpGVG5vC1yAh3ce5sAG9BNDcKS6CfGTny4DdD5HcMqihCY+7
         k6PKAkw08M7xzhmpb5pH0LM/44qdswdlZz+e8/jDw9V7t3z2Bb9BkUZTyXVy7i+Zhsd4
         lZSw==
X-Gm-Message-State: AFuF++mo1wJ3kVNSd0+JRutk7ZqgahrXNIOko7V3t+5spllw/uWKoLgE
	XLvk2EC8OcJ6GsjIUpYFhcEuyy0/uBaBq4ehDo2xB8pFGqF1MczadSlv7iJFVA0F
X-Gm-Gg: AYBFou0I1pUwxDrQIFYVCW0SHE/HSyFdxB4hA1iIsD15BuD6q1Cl/tVpiI7uPD46ypd
	Bu8unZRpoyweEG8lbs6OX1p3GIfODZDd8XHeWB/fRMFKP2Yl5oG6nYuYrySRdto9mzs61Zfj2vO
	wTfkXkzGTnI2QMKVfEEymxfwcso7UV3Kn7l4EMsyyFqjo4i5U2OZD3HxODgXg9v59Kbvu+nd0SG
	MerROrGuvSryB7RJfEMW/+TRCWGyfuoDQBy2oJG905WxWKJAtbLzMwHwEuJOCz/KIqssLViJLWj
	+PyQOSLcnNyVhocQpHtWIH1ofrjvHOQJ1HUWMau2DmD3fTEg6BSNp3eJPKgVxmOkyCR6W5n13KX
	F6Kw/sDXgF1k01tLx1HusAGR0QxbB9aKa6V0vW97zwuLGwWnnhchNIrPftqaSsMRJHOpl2GSPsP
	TdN+Ki3B9b8drs/jzeuYSFx3L7ZbyNlzkm0N2LE6M9HoiT/9t9/2qIY+gGbwq2fe3JP+/VYeqc6
	5AmSJiBRMMHcULunc23de4PD8zfH2S9frTd2YvmrAqX8MbSQANBJkFEfFgB0lVbEo65WfEls+dX
	+s9g1IFmitx5eNTdONdKidzQvXo=
X-Received: by 2002:a05:600c:a05:b0:49c:fc6e:a3dc with SMTP id 5b1f17b1804b1-49cfc6ea772mr26999985e9.27.1788522066073;
        Fri, 04 Sep 2026 04:41:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbe5b252sm35649685e9.3.2026.09.04.04.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 04:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 13:41:05 +0200
Message-Id: <DL6I5PYM23L1.MZTSPKRDHLOI@gmail.com>
To: <sashiko-reviews@lists.linux.dev>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v1 3/8] bpf: Cancel special fields when recycling
 rhtab elements
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260904104203.345917-1-memxor@gmail.com>
 <20260904104203.345917-4-memxor@gmail.com>
 <20260904113744.BE0BB1F00A3D@smtp.kernel.org>
In-Reply-To: <20260904113744.BE0BB1F00A3D@smtp.kernel.org>

On Fri Sep 4, 2026 at 1:37 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Replacing bpf_obj_free_fields() with bpf_obj_cancel_fields() dur=
ing map updates and deletions violates BTF-001 and causes cross-key resourc=
e leakage.
> --
>
> commit 87b60bb947c49832ff2d2552730fd3c5124e6130
> Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
>
> bpf: Cancel special fields when recycling rhtab elements
>
> This commit modifies rhtab map operations to use bpf_obj_cancel_fields()
> instead of bpf_obj_free_fields() when replacing or deleting elements. Thi=
s is
> done to avoid releasing referenced kptrs and other complex fields in NMI
> context, aligning with array and hash map behavior.
>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 527cc5716ee8c..cc60e99ffbe92 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>
> [ ... ]
>
>> @@ -2967,8 +2957,8 @@ static int rhtab_delete_elem(struct bpf_rhtab *rht=
ab, struct rhtab_elem *elem, v
>>  		rhtab_read_elem_value(&rhtab->map, copy, elem, flags);
>>  		check_and_init_map_value(&rhtab->map, copy);
>>  	}
>> -	/* Release internal structs: kptr, bpf_timer, task_work, wq */
>> -	rhtab_check_and_free_fields(rhtab, elem);
>> +	bpf_obj_cancel_fields(&rhtab->map,
>> +			      rhtab_elem_value(elem, rhtab->map.key_size));
>>  	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>
> [Severity: High]
> Does changing this to bpf_obj_cancel_fields() leave stale special fields =
in
> the memory cache?
>
> Since bpf_obj_cancel_fields() does not drop kptrs or list heads, these
> references appear to remain in the element when it is freed to the cache.
> When a new element is later allocated from the cache in
> rhtab_map_update_elem():
>
>     elem =3D bpf_mem_cache_alloc(&rhtab->ma);
>     if (!elem)
>         return -ENOMEM;
>     memcpy(elem->data, key, map->key_size);
>     copy_map_value(map, rhtab_elem_value(elem, map->key_size), value);
>
> Because bpf_mem_cache_alloc() does not zero memory and copy_map_value()
> skips special fields, will this cause the new key to inherit the old key'=
s
> populated list head or kptr?
>
>>  	return 0;
>>  }
>
> [ ... ]
>
>> @@ -3029,7 +3018,7 @@ static long rhtab_map_update_existing(struct bpf_m=
ap *map, struct rhtab_elem *el
>>  	 * kptrs/etc. still sit in the slot. Cancel them after the copy
>>  	 * to match arraymap's update semantics.
>>  	 */
>> -	rhtab_check_and_free_fields(rhtab, elem);
>> +	bpf_obj_cancel_fields(map, old_val);
>
> [Severity: High]
> Does replacing the free operation with bpf_obj_cancel_fields() here viola=
te
> the requirement to clean up special BTF fields during map updates?
>
> When overwriting an existing map value in-place, failing to free existing
> kptrs or list heads seems like it causes them to outlive the update. Will
> this leave stale resources bound to the key indefinitely?
>

Both are deliberate changes.

>>  	return 0;
>>  }

