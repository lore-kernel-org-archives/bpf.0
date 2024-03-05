Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB853809
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632488; cv=none; b=cX9MwYQmtI4+kWJXGHLWRu43Td+Ty/89SP69xcLn2RP779S1YgdBTIY7aDs5IEv2JlhVf3++Tw30+YgbX6gqgC1V7QHMb3WOrC5iqaTDq1br74x4mL2uf4nNbSEOsJT8PISEBWBxcNOFIVq49mjt06hW2ejOZcUbpTL0shxgzPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632488; c=relaxed/simple;
	bh=AMx1dmra42f3wIPKtAuPQKSUqiiqQ5uj/y1GbLTkA5o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IvGKdmiUj6hkJiHnjcl79emFZ971yxY3s2vuWCqgGtkXaQXEfErGMrmUihR9ZA9lLhAf5Of0tEp/2s1nLMapUkV6qVPA+zazTB3EfKzXFr+dakg+Ph+TWz39TlkVgitsrXGB19N8nKldcdvA76ggGnNKAgLDVlvSM5veE4wm/JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lq3oDdYQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq3oDdYQ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51344bebe2fso2086771e87.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709632485; x=1710237285; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AeajML2Bnj7amM6UoOo+K7DQuVelOuxRHP0EHUaZSvs=;
        b=lq3oDdYQGAknoYEIiim7q8sXPnsRDYp77gTfVFLFL6Wj/Djnn3PEBt4Uov1lNjuHhA
         vfBaKH08EwKZxwc/6M5W8shiv5PjzMiVRj097hbpAGHxGmGb1wxsQJXCxqTDdyzt0V6C
         mJb5p90OZz4tTDvRP4PzwUQvxHzUP5Ieq04JGDvJCRj/R05RPUrI+d2HurOF52EVOrTz
         FkHsGNUwDW7+rxbMrKbn+Oz7Z4ikzDH0jD5t/22ZArbI9OB8mZW8d6qBIGnG2kRadGZ2
         e8AtdYd37WuDe3mrRIgjy/kKqFQKtNJxizu+192xQ0qogaMt3RwPlUJ0nQXJmXNpWjcg
         XiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709632485; x=1710237285;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeajML2Bnj7amM6UoOo+K7DQuVelOuxRHP0EHUaZSvs=;
        b=YkmYg3rXl/2CKGiM+BfJ+l2UhF76ArWUtAYwphyJE1LwJyYq1ZCEtGwW+whrWdbr7x
         icEW2HMW1GMwR77Hw8iuC4ZzjHoHEruMFE4xwbJPAnDK6XrA3oHWvf+QYJAgW6GKq69Y
         Jt5DECk5I1d4i1UJPSzVnAfx8ngIMQTGbzx3HwpH/om27ptA9TDNO3hvbPWgE2vrTpiK
         VGbD9Fj4CcqfyLcz60JZCySf9eczG5KiNdsY2oNOrWto8EMB87QiqlHX+9NW8GyC+1Y4
         FA1Ycs3J+9SRHsYb3YZnfCn8UDIMT6wGvSQlwZEl5bYtM8Fv9nnlFJ2X0J/u4AkDLkUX
         u0GQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1iF795sh1WAixYurKdW0f/paBBXLmQ3CYZ6d0cMzLcdYnGMs5lnPgbI0g9Y13qnyqDCGOpMdf+GmP06SwqKkczEOf
X-Gm-Message-State: AOJu0Yw52gMsmbFyhhHk4IKF9gWuBrDYDQ6HDIqkhzAIs95UTjuGLRbK
	hhCxFI/I2yhr/fo0f0HefLj6/xamH6OQKhEnzsb3t++ZHx66haXh
X-Google-Smtp-Source: AGHT+IET3YRm4DXjTVWqjZzC14CaM5JPjkgTQFfx0A58A00cboF5g4Uny99e6E9KD4v+dtgwz87o9Q==
X-Received: by 2002:a19:430e:0:b0:512:ef0f:ccae with SMTP id q14-20020a19430e000000b00512ef0fccaemr809012lfa.25.1709632484513;
        Tue, 05 Mar 2024 01:54:44 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709063e1700b00a42f6d48c72sm5900897eji.145.2024.03.05.01.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:54:44 -0800 (PST)
Message-ID: <cddfcd3e4188d1f85132455f4510b97b4f3ac0ae.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 07/15] selftests/bpf: test autocreate
 behavior for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com, sinquersw@gmail.com
Date: Tue, 05 Mar 2024 11:54:43 +0200
In-Reply-To: <6c4a8146-d152-028f-f2c6-0ace7c77ccd3@iogearbox.net>
References: <20240304225156.24765-1-eddyz87@gmail.com>
	 <20240304225156.24765-8-eddyz87@gmail.com>
	 <6c4a8146-d152-028f-f2c6-0ace7c77ccd3@iogearbox.net>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 10:51 +0100, Daniel Borkmann wrote:
[...]

> > diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocrea=
te.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> > new file mode 100644
> > index 000000000000..883f938d518c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> > @@ -0,0 +1,76 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include "struct_ops_autocreate.skel.h"
> > +
> > +static void cant_load_full_object(void)
> > +{
> > +	struct struct_ops_autocreate *skel;
> > +	char *log;
> > +	int err;
> > +
> > +	skel =3D struct_ops_autocreate__open();
> > +	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open"))
> > +		return;
> > +
> > +	if (start_libbpf_log_capture())
> > +		goto cleanup;
>=20
> nit: This cleanup path triggers freeing of uninitialized log pointer.

Thank you for noticing, I will double check all tests and post v4
after collecting some additional feedback.

[...]
