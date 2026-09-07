Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABCB5237AF
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788811209; cv=none; b=MZw13x2DrDYsjxYee6EUjfeOX2r1JtnpP6RQ6xAYafy7W+/1tUOTlJodspRLApULnjvIJhXfq+Rxez2QDFkzOpcLmBKeEOK8ZPNP+Pf87V7Ley15uKGd4K6VHpqAGIzfxbC2yY2yK4p17fZadYa+DflyXBQNqxdRkBeMNUmjGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788811209; c=relaxed/simple;
	bh=VrloMq6OScCabj9CKR02TTL5qYLUYZi7CQaAXNRhI1E=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=YkMiIjt1RtRHo0+nz9F0iDmIwwKoNYn9T8rsfid9af1Oka9i5by9d3wnpo4odiSOQdLEVGL/kUaK6Bg4o1GcOTQ2xU8Fzf1asawzdtcw+/18MapTqTjo63Vg/m2IQCCGW8pOoxN205rQPZxKLBrIGDoEyDXAj2LWCBHgWB+ibA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCcN+/Ob; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCcN+/Ob"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9b4b70so67024fac.0
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788811207; x=1789416007; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VrloMq6OScCabj9CKR02TTL5qYLUYZi7CQaAXNRhI1E=;
        b=iCcN+/ObXz531fUsXfUTPPSqjSO+s2oBLOj3Q2CrU2tumX0Xf56NmRv5WYVLFdf23n
         J+TpojFzOzH+WAjU4kG4AELO4A+kw3H7a6wk1AoBFf4kp+WxAOg4MqD2qHdZ6rdsct0L
         EWyN4s86EfUz8i33nuvT1pXp1i+H0ncQcVC8F1Qc8rXSH4hqhYfGC2GMFvYNr0Ck4Z2y
         SS+kvjU3Qn7hnI304ao2TbFciq6MDk51TG3Z6RezFQCg4J3bvd+hZCqlHYnVEknKr+Eq
         qGj3yGl57KBYgUeAONB73bDe0SCLWgXxjTjOXPy18P6SZrNl+5qGg+x5t1EwE3EHo3iX
         dSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788811207; x=1789416007;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrloMq6OScCabj9CKR02TTL5qYLUYZi7CQaAXNRhI1E=;
        b=QGcvk+wp9J25j3AA1+tLzGxvxYuHVqU+TZwudr6tHV75gllo+d+SE39DQNHTWpgTrx
         1ex3mvRfZO1EpaGc8lKUwbmdfb2DT5lA7Bon7eD0tVHWLXzqCMetyB/F8WmvyAyTaJAn
         eRT2zxYVkbruVh8EfiBmpLcS7OJgmbIas8Lf3LXYIjwXgn9PA5/fv0DHLVpB6d11T+gt
         duJ1MwWrspS/mp+JZkERdbjAwU4QhxEJdSNVyRE+KsmPhuIwk7/3pWPUS5s1SObhdo94
         ORMwdgGFFmxz2Vr1NKb12/hdtcF5XhuH0v1hQifnEfvtm2+YDgbLCNlBv20EnrUhweNb
         qC7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxdkiJiKg2dT6awt2wwi9iTr9S8wxEfmgZuRKclWuW8BTv92xMQUZh3m6A9lQcnOvDGa7I=@vger.kernel.org
X-Gm-Message-State: AFuF++nmQRpX2VD3SaE4qToQiUMZ24lOgHEbUNokF/pi2zalM0ENpbGW
	uXLuNPev95II36/kcn5eGuHg7LT48thsqhcgkfKqQZ7aOt7dk52p6FBf
X-Gm-Gg: AYBFou2MWjGJso/wRwNYPVUnCv5V5Dc/eFTJjZpD9RkEWvTgdDGpneoDQzlphOJSxSp
	4O4E/n847p8m0ZaI0d2z05tr8ZWvbP3LB1SYxEBLqSmiwmdsI9CHaXSt3N7DPTnWmxfmAB1kVPj
	QLxa0ZXzvk9IVKnZ8WZsLqxiqj+UW1djIHLa+I8nZNnuIzrkG87QJkwHRKWqn+a8D0vxgxWUL6O
	HHkRHIsK03z+uhDJK8U7nXee6n9Q1hnpQF0BgSmh1pjCeU0nwnkb0vZXlnrpURGzOfDTiWR8dEO
	4KegKVuGT12dljxVNOdOyEvDu4+hTDWlq0GQo7T3vRKgkXacOSgW/fGXUaxVqiC1qewsEPVAOAM
	tHoTXHt+K6FL4FmTZBH4BzZFIW5lnc0frUabCx1IGjN2Q0Gtf39F2elTSMd+K6tFkezwRPqYd7d
	hqKieYKW241FvtdXWKjTb4yoYDczhJT0bHY5ow3UVrdxNHP27BOloVxjRvWGyI4UTdlWUYUG3EI
	XAmLM5sH7NhE9pVZAZmRlEZxuFp/hnSCGHto0Ir7atx9wE5DqsHFh8=
X-Received: by 2002:a05:6820:2d0b:b0:6b5:ec3f:4986 with SMTP id 006d021491bc7-6bc27defb7bmr822289eaf.33.1788811206610;
        Mon, 07 Sep 2026 13:00:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dbedc6fasm14069610eaf.3.2026.09.07.13.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 13:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 13:00:02 -0700
Message-Id: <DL9CNDXUNKBZ.4ZPP6WKB4BPM@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, <ast@kernel.org>,
 <andrii@kernel.org>
Cc: <daniel@iogearbox.net>, <eddyz87@gmail.com>, <jolsa@kernel.org>,
 <ihor.solodrai@linux.dev>, <yonghong.song@linux.dev>, <song@kernel.org>,
 <qmo@kernel.org>, <martin.lau@linux.dev>, <memxor@gmail.com>,
 <emil@etsalapatis.com>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
 <tj@kernel.org>, <kees@kernel.org>, <bpf@vger.kernel.org>,
 <nathan@kernel.org>, <nsc@kernel.org>, <arnd@arndb.de>,
 <puranjay@kernel.org>, <yatsenko@meta.com>, <atenart@kernel.org>,
 <ojeda@kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next 14/18] btf: Make vmlinux, module inline info
 available in /sys/kernel/btf
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-15-alan.maguire@oracle.com>
 <DL9C40S8FVWA.2T4J5Y8BSF7KU@gmail.com>
 <932ffcdb-69d8-46a6-924c-4bb8fde7b6b0@oracle.com>
In-Reply-To: <932ffcdb-69d8-46a6-924c-4bb8fde7b6b0@oracle.com>

On Mon Sep 7, 2026 at 12:50 PM PDT, Alan Maguire wrote:
>
> Sure; what do you think about splitting into 2 series, with
> pahole support landing once the first series does (so we=20
> have libbpf support for the inline APIs)?
>
> patches 1-11: support for inline info across UAPI, kernel, libbpf, bpftoo=
l
> and tests
>
> patches 12- 18 kbuild support, sysfs availability

ahh, so you need libbpf support first to use it from pahole?
Sure then.

