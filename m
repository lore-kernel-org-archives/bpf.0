Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703819;
	b=GpArnLaiMVJUzUsPZQy2UmHCC4W5VyIogecP5WgQS/TNY69fKUDFHCzOd5KZlG29ksNh
	 9drgVoGeL0dN9JwTCI8LRQzdtRdN3yOZ1cZE31T3Io3tv9qVGvB8hSWKNEcHcSYdZxTL0
	 XhMrlElUA+Yx6MlQljY9SQI37amCqV5P5hF0NEOglyb8NlsBl5JuiDIfNfQUnFS09BxNI
	 R/HABRtnMEuqQ6hChs4ikAYrU6y8HDZgPhH8vVzj3Ua6jCaMY/gKl9Sw4IBwto+H5OnIg
	 VDhNoKU75LcZV9WnvnrUqHTjtliCRIQUubi/80w8rPfBX/4bstyH/Kd+K/SaETHd1UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703819;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=SyMjPxEHghkwGhRTZpVd7OX72NBhKtbfP1nFSzvk1f4=;
	b=26Hma+kpBB5ANDcKBWqSPRS+DXOgHElZETwJKl+icSKBcWTSMnZCPacpJTVktd+zRHoH
	 IdiCVuQbRng6wUxNw9xTWiM1piEczAjjYttWdQHkU7X8Ufey45pgw/H635LXi6zXnn4YD
	 ZkX7svRCAoGp8nd2MiA13LwFJ//bN5/IvCpbuq+3R52EF32c1QFT2uyscfG7LpUpWmW4a
	 0R02yRdPnqqp/6LC0YJ94pMboIhm4IwkL/QcV1m8pUSZ7sh3vQNN+os0a5PuZELpmbpit
	 V9q15BUibzdTnUp0sqvXFdGiv0ARrMJ49IneYA8jg3zQBvH6yMagXcfNikGddhcPIcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IXeMLIQv;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AD3606A326
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79AD3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IXeMLIQv
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so67856515e9.3
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 06:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795703818; x=1796308618; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SyMjPxEHghkwGhRTZpVd7OX72NBhKtbfP1nFSzvk1f4=;
        b=IXeMLIQvfySUGPeai+iyNZ/hUDce64qblcATogHX726gnCewg1gJU0NwT3kow2fR6O
         AzHusSV7c6MvnY145WjqAlsTLqFG7v/bTYszuTz4CiuV2aJkCjWjfdXUMQ4F0LdyanAG
         2dmBDJIH2eQUSp4IgaP3td2Tl49FKhiKGjv4W48l///hpxZOtAF9TH2E6i4XpSWZpcXe
         lGEEni8wbUBWxd/2aZywJTAytlW9LGUoyPdOpzQcSvZ09OkZ3Qx4PtMW68nf2f3PqrBH
         YlMrfcJV1U+MWm729UQOqtyJGHaJ+B4zHwr9/pRK6AindNxknCYEBdYIDL8zq0CZa5yb
         GiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795703818; x=1796308618;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SyMjPxEHghkwGhRTZpVd7OX72NBhKtbfP1nFSzvk1f4=;
        b=Hl1/cjqEb3sPuKhxjBP7xgB9jvMNZi0Z+7swyM7y2gTstvSg63sziQBT36fMwnUDWP
         uFdduyQ9PPcRhMKWaunrkELG8kv5zxge9wO/3qU+v2KzmItLAmsH5yzpbymmM+O8JY2P
         A6m0wEqqDZDYhoiKX++2ZMyBvU0id2IIitTCUjQO1Yr6S3S3Pvy/2dMT0h+MGHrXU3Z7
         i+RljjJSNQgHp0wBpSK3EoJrkCDe2AYCUXuuDRmwS8+q9BGmTN6hcIo3iOUj+CioLNVo
         vhHZMHLA4dSmm/F8AlfVHt3aoGMmI8uUCbopZgWtdiDC9KYZtbomaxGl+SkYhdwDSyML
         8hvA==
X-Gm-Message-State: APuU4Z8fZa+js6dz0Bw2PZs9Q/8CQPCXqXsi3WTOStvPCmrvm8Fzk60g
	uvDPl9GL9YhH5Q4tTfK5Hj5f1sc2iY9pfe6sgnKbcSspz4R01/pc06IOIWXhWA==
X-Gm-Gg: AZFdTZcQMtX/gh8xMU44epUpnjIsPJTxEghhJzPkL8x672IZmL8l9vvk3KicCxUGgPt
	rzkkoDNdKQlyzmluLtvtCxqzQ7A52vHLvdRqPist0XOrLrS7lyCJeBkqm9P0CeftViBuhDs54Mu
	+GLrZL1ZrwLr6iHXGMeAr1trmZXiUZLAlmflEeJNKuJt7hn9JuPUkfL2jGCIwkpmAXD9VJ1lgD4
	u1qM2jGBbOO/GbXT/AVSWnnjwZdhzyUEdUc8NSnEQg+B+OdpiTuiv4WXBj11gheNfJxf+7QJzj8
	4v0JZiuQvJQXQjlsd+E/Ma4Y+ewb9h8WO2yK3nGJ79JSM4MMegDN0p4LhplzN4LZPb+32xPg9nj
	ylElGdzS+3GJajYkO6D6eDVFXHFkyTDX5ymHFsS19nSkNdDCa9tf3YLiuU8dWa+0OApfQOHpiUC
	ItHbMy9xJarrbQEGWZ1mKu+uEMmay5elaqL8B/1BME82/oXQ96p6mL73lm/Ks3SbgvFt/88iEFE
	LwHu000OHVqF3VF43IeFkYKthl+a67jQEeaZfBXoUCa3TuQVZVVg4SY56YTFJze80laKqMx4zVL
	MpkKdWJm6kFXJnmsIkPzaOaD4nHoQ7eJh4AlcQ==
X-Received: by 2002:a05:600c:4e87:b0:4a7:6bc7:f778 with SMTP id 5b1f17b1804b1-4bb88938d38mr445041075e9.30.1795703817870;
        Thu, 26 Nov 2026 06:36:57 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b39b6sm560823795e9.12.2026.11.26.06.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:36:57 -0800 (PST)
Date: Thu, 26 Nov 2026 14:48:34 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: Test functions which must
 have no fmod_ret tag
Message-ID: <awhGwnquBmvvliHf@mail.gmail.com>
References: <20261126142915.1106330-1-a.s.protopopov@gmail.com>
 <20261126142915.1106330-8-a.s.protopopov@gmail.com>
 <sashiko-outbox-235702@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-235702@kernel.org>

On 26/11/26 02:27PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] selftests/bpf: fmodret_untagged.c duplicates fmodret_retval.c
>   BTF tag test
> --
> 
> commit 6b9f59cbaa78b14e32ed408a9747440fae862df8
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> selftests/bpf: Test functions which must have no fmod_ret tag
> 
> This commit adds a BPF selftest that loads vmlinux BTF and verifies that
> specific kernel functions are not tagged with bpf_fmodret_retval:.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c b/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c
> > new file mode 100644
> > index 0000000000000..9f4b0586fe8f0
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/fmodret_untagged.c
> > @@ -0,0 +1,58 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Functions which return errors, but which the build must not tag as fmod_ret targets */
> > +#include <test_progs.h>
> > +#include <bpf/btf.h>
> > +
> > +#define TAG "bpf_fmodret_retval:"
> 
> [ ... ]
> 
> > +/* Has the build tagged the function FUNC_ID, or any function if FUNC_ID is 0? */
> > +static bool tagged(const struct btf *btf, int func_id)
> > +{
> > +	int id;
> > +
> > +	for (id = 1; id < btf__type_cnt(btf); id++) {
> > +		const struct btf_type *t = btf__type_by_id(btf, id);
> > +		const char *name = btf__name_by_offset(btf, t->name_off);
> > +
> > +		if (btf_is_decl_tag(t) && (!func_id || t->type == func_id) &&
> > +		    !strncmp(name, TAG, strlen(TAG)))
> > +			return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +void test_fmodret_untagged(void)
> > +{
> > +	struct btf *btf;
> > +	int i, id;
> > +
> > +	btf = btf__load_vmlinux_btf();
> > +	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
> > +		return;
> > +	if (!tagged(btf, 0)) {
> > +		printf("%s:SKIP:no CONFIG_BPF_FMODRET_SCAN\n", __func__);
> > +		test__skip();
> > +		goto out;
> > +	}
> > +	for (i = 0; i < ARRAY_SIZE(funcs); i++) {
> > +		id = btf__find_by_name_kind(btf, funcs[i], BTF_KIND_FUNC);
> > +		if (ASSERT_GT(id, 0, funcs[i]))
> > +			ASSERT_FALSE(tagged(btf, id), funcs[i]);
> > +	}
> > +out:
> > +	btf__free(btf);
> > +}
> 
> [Severity: Low]
> This isn't a bug, but could these untagged vmlinux function checks be folded
> into tools/testing/selftests/bpf/prog_tests/fmodret_retval.c instead of adding
> a separate standalone test file?
> 
> test_fmodret_retval() in that file already loads vmlinux_btf, checks for
> CONFIG_BPF_FMODRET_SCAN, and scans BTF_KIND_DECL_TAG entries for
> bpf_fmodret_retval: via tagged_errors().  Adjusting tagged_errors() to start at
> id = btf__base_btf(btf) ? btf__type_cnt(btf__base_btf(btf)) : 1 would let
> test_fmodret_retval() check these vmlinux functions directly without
> duplicating the BTF load, tag lookup, and skip handling.

Will do if v3 will be needed.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261126142915.1106330-1-a.s.protopopov@gmail.com?part=7
