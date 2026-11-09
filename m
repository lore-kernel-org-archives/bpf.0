Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232691;
	b=MeRZhHnqmSOHpwbzB1arHx77z/T3Pl5plnmvOqS5x/zk7qOir9Vgs/u+DvI0pKpo+RUx
	 9Nq1NMBlAXsQzphQoQjBOpil2e8LzyfOlRD2soFbHpOhNW6sz2AyWKTB/DIANribEPkF4
	 jItlcDU53k2YDw5dG5Vd8yt3a0NlL5qUZa5YzGyqpQFfSxWu6XNJyIrSqEgouJLDYsj1C
	 6UNxVv+7PmuqnwTHvz0rZrVa6khM6T1adQWASYWpQ27WCPb2nDOUpYNuTW5TdPIcwH0t3
	 NFmtev/zcKWAT0nu+pys7xWv862frJo89T6lGOSk6n1w83iluTBOaQ1oN1ntRSVgaog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232691;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=dZDeE2xZH0nMQ26DQzLtMh8DKmBlzuXu6Jf57xM5sMI=;
	b=F/GzyvcdVHPpJWxHm/9BZmCCIFH8F3Chxw6a3CJwW6ODKHBgnJFkQmhEh1tDU6/LCAe5
	 PgU5nTp56akceJw8NivPMdOqDbQ1GAsLngYMWuHxSJGjQNg3Wx+lWnnGHSQ05bxUwHgM/
	 c379sKwUgtVgu1jxbSQ04UcuR3YDMeubEDEv/enFwtJ5sXXzQBv+Aewf+61wHarKv2LQb
	 a/FbMjPRcEMj+PHKb8UTutFPAjyKSHMUIcy31LQpoYErYrbuybd5YTC8zF1vzx6QzGQQU
	 Hl8CODqRMz05gbc0s5r98tsS/BT57tFpg7681ovsRKQJPKOhboThR0Sr4Uhn54MSzEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UZW5AGHG;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E89B606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 13:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E89B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UZW5AGHG
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so7164055e9.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 05:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794232689; x=1794837489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZDeE2xZH0nMQ26DQzLtMh8DKmBlzuXu6Jf57xM5sMI=;
        b=UZW5AGHGlEx2E+nZP4jsvhT1FNyoMEUY4w9pUGwgzeK9NOkJ3ztKF7kVIMxNoUzxIE
         6W+UTexBMBL6wQA0ePAIOe1EdRIHXFudhiZmFv8Nn1PAEFiribHiIfvWnwNBCsGaQxE3
         pfc9Vflfi/6TXcny332RHT4bEG0zRHAXu1vNMDD7+EaaCUJMySoRZbTlpLjGnkPlB+Eh
         CnYwFV+462uFf65CO7GX+KYh1U7Lt8GO8Hy8vawjTWD0foyOwk6bBFAAkgQl5E/hJ2pP
         5MGc4dYdJaZ0UdHKirtQtikNDDB8mPBGHZkP7WXclDOE8Gr3Q7fCd9gtQ/LZbP+yP+yi
         mxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232689; x=1794837489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dZDeE2xZH0nMQ26DQzLtMh8DKmBlzuXu6Jf57xM5sMI=;
        b=Ali394OoBE7jsiKP9IrnJjDCbEPWyaKodeWI09nOZvBFHrTOlFmxZvDhO/UY0t4iaW
         e+kfN/tJyeIBOYqsMJlMEqV+y3DEB97JMO321py60ysvvHb34w4wojZZr6lCU8sgTHNN
         keFT7KWISBe2B9lJ5NIQvK+P9gsOhDG1RlWnjsFTXTN0w6xfBERlRsOH3XGM1e3oyKbG
         k7yR8Hd1L6b+cXhtkZCxfALczi1ddNQdE2wOhE2uaqVHNTPl8oxsBE1q+KdJGT6QArBR
         G10UxKhtpFJtTe8sAytetpcARAMkLEd0afXY+uJ+1kTcNB6ppuhrbXlr1eRndut/GRYt
         eOCw==
X-Gm-Message-State: APuU4Z91mtAafXrw/9ay4PecuaMqTjMSVXG+Grs0HCBohXF7zISt24jE
	qfvfcAHk57jutR1KgF4pck1r39ss1NIKelP5fDzLfL40oCrs8LzqiD29uIQjOg==
X-Gm-Gg: AYBFou1+imEowaqKC6nLX2HIjm1vQutoWJVAuHYC0DogCc2Lyda41/sHLtfUY2r8h5r
	IiR4tEjgy9aGLb2mcNBIMYFyLWThyax9d/qGgRnDmtn66lEiwoHN0+DdK7uoaYHtiovCJpvlJ1t
	RZVTodf/hSje25dxwo9RZHVuZAraKjCrFu99w5EN/AJ/RwZi+MuXPQHwui8loVBYFP18LNS0stg
	6NxwmrWXdbNzpE2ROV1UqXptb4Ok3SvcyF1Bts1nf782Ug2kv393WLzvW8uIeoC8BEn1fchgz78
	CZqkAQ4F0ukgE48IXzkgdCQd6ugDVwBFhEmoYy1IgoirsX9CaI97GE6EMj1o3InoovT7AaO++aS
	DA3KN3oE0mMXuKs+aPpDuAcTfmeAcQ8+y8odiLlCS+g8TgvRFbx983vjP4Z4nYXYnqyi+j4uTVN
	ZzQyWkxhNnqaG6J4ubTDosqGijmBAkgZhkfh4+q8d+ZiihcSBggoiyzgFRCuwE9VJPyV+OMHN1N
	A+LLeAYoZ8jLRZuWbUKahmyrfrvNt0ky84ry5mbJdw1/d5OEW4tvFLlgbo7cl4/hxD0Fz7e473l
	mS/r7gB/Qs5PI6I7IC+stukcyQtWzkNDT3vK
X-Received: by 2002:a05:600d:84ca:10b0:4b9:ff69:19ac with SMTP id 5b1f17b1804b1-4b9ff6919f8mr13489005e9.11.1794232688967;
        Mon, 09 Nov 2026 05:58:08 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e32b46a3sm252430215e9.6.2026.11.09.05.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:58:07 -0800 (PST)
Date: Mon, 9 Nov 2026 14:09:42 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 16/18] selftests/bpf: Test fmod_ret
 candidates found by bpf_scan_ir
Message-ID: <avHUJhNSgifusdtc@mail.gmail.com>
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
 <20261106210314.1767267-16-a.s.protopopov@gmail.com>
 <sashiko-outbox-202287@kernel.org>
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
In-Reply-To: <sashiko-outbox-202287@kernel.org>

On 26/11/06 09:09PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] selftests/bpf: missing KASAN and KCSAN exclusions for
>   bpf_testmod_retval.o
> --
> 
> commit 628c6eb28eaac0eeb5e557c0b787a65b02cd6e06
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> selftests/bpf: Test fmod_ret candidates found by bpf_scan_ir
> 
> This commit adds bpf_testmod fixtures and BPF selftests to verify the
> fmod_ret target tags generated by the bpf_scan_ir compiler plugin and the
> verifier's enforcement of restricted return values.
> 
> > diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
> > index 031c7454ce65f..475df9a7680ea 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/Makefile
> > +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
> > @@ -23,7 +23,16 @@ MODULES = bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
> >  
> >  $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
> >  
> > -CFLAGS_bpf_testmod.o = -I$(src)
> > +bpf_testmod-y := bpf_testmod_main.o
> > +# The functions for bpf_scan_ir use clang extensions and need the plugin
> > +bpf_testmod-$(CONFIG_CLANG_PLUGIN_BPF_SCAN_IR) += bpf_testmod_retval.o \
> > +						  bpf_testmod_retval_strong.o
> > +# Coverage instrumentation makes every path of the fixtures dirty
> > +GCOV_PROFILE_bpf_testmod_retval.o := n
> > +KCOV_INSTRUMENT_bpf_testmod_retval.o := n
> > +KMSAN_SANITIZE_bpf_testmod_retval.o := n
> 
> [Severity: Low]
> Should KASAN_SANITIZE_bpf_testmod_retval.o and
> KCSAN_SANITIZE_bpf_testmod_retval.o also be set to n here?
> 
> bpf_testmod_retval_private_store() and bpf_testmod_retval_private_memset()
> use __attribute__((optnone)) to keep their stack writes and memset in the
> IR until OptimizerLast.  When CONFIG_KASAN or CONFIG_KCSAN is enabled, the
> sanitizer pass runs before bpf_scan_ir and instruments those operations
> with shadow stores and runtime calls (__asan_report_store4, __asan_memset,
> __tsan_write4), which bpf_scan_ir rejects as side effects, causing the tags
> subtest in test_fmodret_retval() to fail.

Added KCSAN and UBSAN (just in case, neither is enabled in tests).

> Sashiko AI review · https://sashiko.dev/#/patchset/20261106205523.1765622-1-a.s.protopopov@gmail.com?part=16
