Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66544388873
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737314; cv=none; b=Yas1NGGWPFJPNKl9FAl+PUlec2idH9KFwMMOTBt4uABWct5mZnXDlzzTfoy8U0vLcydZGiXtf00Z1tO9EJKmobEgiWk4963Rvk0nUv/Q7guUP81M9Z1iPXww+CvyjxB80w7nAuwGtuV1vCEttzuo4PrSyFkBHvXV9iKJUQf8/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737314; c=relaxed/simple;
	bh=UiHz/xGsDQIgAQXG+nBrsNQ8xpxYt+R5FWxr9mmcTWs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jM/hVJH5ywE37ZV0KqjMhHgEUQNxtWsm9RW3ry6ExdOgrorfjxAK9kzzcgOIX2LnG4HSzs+cc8J/WL7Gjcy6uAyp1n9i8rm+pVxVmH6sKQpYv+lzUgbTnLfuumFlazVvUwzjbCqICZ4KOc8aZaeAy7YC1sqmO7ov9ifliZNrlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xi851Vbc; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi851Vbc"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso9233285e9.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 23:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785737312; x=1786342112; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UiHz/xGsDQIgAQXG+nBrsNQ8xpxYt+R5FWxr9mmcTWs=;
        b=Xi851VbcPGgS4s3WmNXb3atX60p0U3J3EHsY4sUaU8IiZWGH7ooG2s0R45B/QNUnix
         BiU4xenwuEUaZELppHJJmUQOuZFWPXtkOfeIzm/2a6AIb7Pngav9a47KBjDfw6O7lNJ8
         11yvrppDNq1gEBCpiy9DcrqZfzezYbvLqckwiEIFdYZTJgspHLF6uWLHFPXLvXh0+zfk
         aeNqhQK0KrKaWORgRoPAem5neOSM7CQAh1BlWlnqMhTKGp+FBg4DYBpEucWwArQ6BEG9
         jv7CCmVOhYrzWK4bNJiAt60WcOH5CBC3p1slxGo/2Bnu6Y620AX3bWpSr6KCvg+xn9QC
         NMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785737312; x=1786342112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UiHz/xGsDQIgAQXG+nBrsNQ8xpxYt+R5FWxr9mmcTWs=;
        b=gn9xlKAjfSksccGxePMbYlhrdfxA89/Q/KWNcRX7dyqF1KifZkqBNrNeande+It27q
         f/Gli5sNg3pX8K5ga80O0ARSE7/8mfbWRN/nofLlrXslvaMvUvVqjE3ZPY9YukeovNkh
         VpUSIfVr0SZflOBcOfWMZQOrplOfoo5tlMr/r6IXUAqeM2ZcS3FsfI/0uf5wZI640Y40
         HcI77O+egA2kxPnom9+fGGN2J68XG7sm4Ksos5bkW7DvducT9fRW14c5xsqibmew6xpn
         /DqK43K0aIndNHrg1GvsJDnq9V35o/5HDqRirNhlG/yhxX9k9i2GdtTjifdjN5p4RzTl
         VXpA==
X-Gm-Message-State: AOJu0YyKlptGKZNDyCsEkbMkkvv96IQS/cA8sDZyavW5+y8a1ZyZVsJ5
	H0Rkgmq0CWMRSdWHKEKs75V53moTKLYY6QGU0x91Yg9P8QHWrL5937BU
X-Gm-Gg: AR+sD11ySj2g3FEqbKv8N5IYPAJfUXc+8D6lanZVpnBFu6pNix7m1AsOOcXu4dKYkkE
	4pV1rmsgvCfydNmbBEgxw5S7aVWn5rkrh0drklUVGuI2DPl8z92sqWF0zGo38X8SOCh+G2ZLyqT
	kXTUi1l14U9cvQRceXsjmZ3d91ZFZ9olEgQrtE0jJh36z5y9X4Uvk//yE7JTUPqLszZkK8UdOPa
	ITRV6xb6CMLobilw11rqOC+xe5xDUeup+hylZtTaavizAGXjPGZOI8rDPx8qafUbQoTEwZUh247
	tzuHeJxwCfGmPnosT8020fKahbg2E6mpQnqjccDkh/Lj/A52eclMIYYngtSxXBeRpRDJgBqjanV
	BR9fzmU85ZhtsDmZfaqmVgxubOEeNyq8e36gc/rbRx0qFmZSRaJjbK1SgC8fvrG/xX1pFLp2u4k
	cM4S/u1c0UDRJ7A1NpwBE9TU2XqrOEKHCnxuq0YGcpXc0o5ueLbRYvnPWzfdq/QDlPmi7W9fYQf
	Y1+p7eAeZJxaojY6FIMbxSFyky7Ed1aPoW9nq1ExR1GDVKY8PJth0UJKTdL+Pd+sjruMbSEyLtl
	ohvcBGPpGAJcrkTlp52/ZaNNn1Qx3A86yJ/BUDg=
X-Received: by 2002:a05:600c:4445:b0:493:a438:7f98 with SMTP id 5b1f17b1804b1-4980c694df5mr148092225e9.18.1785737311418;
        Sun, 02 Aug 2026 23:08:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980869106csm257038305e9.9.2026.08.02.23.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 08:08:30 +0200
Message-Id: <DKF31NEIMOOB.2CPM6KGVXD73K@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <martin.lau@linux.dev>,
 <davem@davemloft.net>, <greg@kroah.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in
 refcount_acquire
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com>
 <DKEUKIOKSY28.2XVQVGCKLI40C@gmail.com>
 <CAJP4iuuYfqFChH1P2=3Q6WxHbMTNnAkCagR2k+Lr4W155gCj3A@mail.gmail.com>
In-Reply-To: <CAJP4iuuYfqFChH1P2=3Q6WxHbMTNnAkCagR2k+Lr4W155gCj3A@mail.gmail.com>

On Mon Aug 3, 2026 at 7:57 AM CEST, Ning Ding wrote:
>> Same comment as the new set; split kernel commits and selftest commits i=
nto
>> separate ones. As for the fix, I think it would make more sense if
>> type_is_ptr_alloc_obj() was fixed to PTR_UNTRUSTED by definition, instea=
d of
>> having to add extra checks on top.
>
> I tried this change on bpf-next 60781269e26c. It fixes the
> refcount_acquire case; the focused tests pass 43/43, and the
> list/rbtree tests pass 176/176.
>
> But here is one concern: type_is_ptr_alloc_obj() is also used by
> type_is_non_owning_ref() and reg_btf_record(). In particular,
> type_is_non_owning_ref() is defined in terms of it. After the final
> RCU unlock, a graph-object pointer has MEM_ALLOC | NON_OWN_REF |
> PTR_UNTRUSTED. Excluding PTR_UNTRUSTED from the shared helper makes
> type_is_non_owning_ref() return false.
>
> This also seems inconsistent with d8939cb0a03c, which allowed extra
> flags, including PTR_UNTRUSTED, for metadata lookup.

I would just disallow it. I don't even know how things would be correct if =
a
untrusted owning or non-owning ref is passed around. I think the case in pa=
tch 2
is demonstrating that it's a bogus type state for being passed around into =
the
kernel.

The only meaningful correct use seems to be reading from such a pointer, fo=
r
which PTR_UNTRUSTED downgrade instead of invalidating it completely should =
be
good enough.
