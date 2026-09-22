Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F272568FAC
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094574; cv=none; b=BDl2XWv0yjWeWortV5mkBQRs3LurRJk6ik7yeFgO3wsH9CkbF9pHAHgyzWSDmpKTakUNq0/jK5wdc3H7P9E8NSEtkt/EROt7Gc6l7mcVI7Ex/8GHTdFTslb4GSaLqVgSPRQoYTu1fW0nbXL5yBdjzD7u4uZ8cJsKG/B4kF1JkmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094574; c=relaxed/simple;
	bh=jWJKMBcUQ5Fb0Y8c/QrBciJIlFEFym7D3hLZKWfp6S4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=o+x+bakXkq/U3aZJ8Z1as7215hz3s+m1/sOaEjQOpOj9vYejnsCX812Z3Hj1pYjhHjrJHF5goS8uQ3KmmY+jWseWrbE+MvSmp1PUq4Lfv3f67EBbzTkU9wknDWJWB12ds+Tu+yWxFnr5gWYQoFQgJ02DYnDsmn9dn7XDbK6xAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjUSs9wJ; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjUSs9wJ"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso137801a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790094572; x=1790699372; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jWJKMBcUQ5Fb0Y8c/QrBciJIlFEFym7D3hLZKWfp6S4=;
        b=XjUSs9wJwjG9+/GdfuiTBOMS91yymSH0ZBlSoKmweVHsULTKy8wjODEzSEoxNbulf4
         7ZExzS18gkIMOPlnx0ibEUAePaAn2K2yQM9747ruooymY5SqLXvM9/oSzm1gRPntnNgJ
         jSTmZdOOwWoiM958dHIAp9lRTrCPme/mWqIXqbjvd3SwiGTQFeQ22NcW8CvVKinPRj8l
         2+STddSm8qy44nwX+YI3uMa0gH6IQH81JXjX2TdB0NdREMgmgtLcF1vbav+wZJsovoOu
         kKWxOjW92aNj+to8v/D4BQ2bMnCn17DC8VRZZLQ+J/ozdTap7P859BQPYnUAUalD7PsC
         nRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094572; x=1790699372;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jWJKMBcUQ5Fb0Y8c/QrBciJIlFEFym7D3hLZKWfp6S4=;
        b=i/CLhs6xI3xIDdHqSqU7Jc2Rf8vg3v06GVz/7LY+qmiRHJ8BylrzX0RZQ5xCs1MIUs
         oC//dJ0pzvaa9uJVbD9XiOCKOhyzH08varhAYSn70aMd9/akXX2Tn7NL/415dEy6bZ9G
         JagRVQqu2LpkpxZ/QrS8pD93WNmB3NY7nNDrQv9H3ah7Aofax0MJI8oSdWqo/xGBqaUg
         JPHei8oFkD1IhZdZYAvAUsMoAwib/X+mekfm797d5uZrygzLBl9nMUE1g8FKK+Nb/Iki
         vsp+ygrWGci7+B/tNhcsrFWNVKkUc2Cn6jxKXTE6kCMIBr6bTTe9317qgfnkbg4SoS+F
         2eMQ==
X-Gm-Message-State: AFuF++n6CizTsI9aewomTKGuyzdrjMYYRYytYoINWFCRvEe+aycJQZU3
	Nmj8eDIgpeQFbkPsWV3nmEPtsVrangNVxypC2luyObSXZes7ZWXygAgK
X-Gm-Gg: AYBFou1UDcqS+Ruu8JPSGquwhJ6Od0mtqlh2oiF7yZ/nv1aVl7R98bb2ZEPa++QqnTf
	7yUK1abDpghrp4ZojqwpiQIrNHIh6pDCh/Z5M31Z1p/gtESYKNBJbVK/I1OW4QXQ0ITPKTxff/p
	pUxXMiakW5WCRKPzlYuwvkCweV1qqS4ruh/wLDi6tGwpBVGDEndOBJGCwp00uJXAzcHGj6R/WRv
	waJji0V4oGQeoDvzneiV51EUXWgCY+Dmruo4AYI2Ph8mlFz/6midawbH/y6gN33ddlfbxD/AaJj
	0r3vd8nhCngRHpZFYYneL4jzhiVkAOafNIJpoh8z84MVIvuPTKe/gafCM8wiPO4C/bGMxyIQ4qU
	niXxuOGZZJ+IuNwrzQwPJp2h7i/TkbFUGdKqyLcyOhjl7qHvOMkn9gQw4BKvQPAg5wBehUVrySg
	Y2czH1gZGepkC2nzyeF5UCc49O3nDvjIjtqELImr9oNaPDgI8DmFbY81zwY6LGqq4GDgg9sUyUA
	PvgAqFzUazFVOY+9S1ZWWhL7sf5EjTc0ZLMl/o34ynVVPo1iT/d076ADmGnLToCoDEwsvOFC+hw
	lzPU4bfaAq04mA==
X-Received: by 2002:a05:6a21:8209:b0:3cd:61d5:f342 with SMTP id adf61e73a8af0-3ddf7caaa23mr54720637.9.1790094572140;
        Tue, 22 Sep 2026 09:29:32 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1b0b505bsm51603b3a.8.2026.09.22.09.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 09:29:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 16:29:31 +0000
Message-Id: <DLLZKD6BIZBS.1IZRLU3IEGEE5@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
 <daniel@iogearbox.net>, <kernel-team@meta.com>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, "Mykyta Yatsenko" <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next v2] bpf: Speed up htab lookups for u32/u64 keys
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Anton Protopopov" <a.s.protopopov@gmail.com>, "Mykyta Yatsenko"
 <mykyta.yatsenko5@gmail.com>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260921-hashtab_fast_hashfn-v2-1-79aa962ec56b@meta.com>
 <arIu1SA3F66HhMkv@mail.gmail.com>
 <026b61de-c223-496f-ada2-854e2c13c3f2@gmail.com>
 <arJ8pKywegWPY67m@mail.gmail.com>
 <c3595598-20a6-4043-87ac-06acab7d5744@gmail.com>
 <arKqk5QsR6Fq1hFe@mail.gmail.com>
In-Reply-To: <arKqk5QsR6Fq1hFe@mail.gmail.com>

On Tue Sep 22, 2026 at 4:19 PM UTC, Anton Protopopov wrote:
>> I don't think we have a lot of maps with 64+ bytes keys on the
>> hot paths, but generally looks like a useful addition.
>>=20
>> We'll need to bring xxh3 into the kernel (it's not small),=20
>> do we want to limit it to bpf only or not.

Let's not rush with xxh. Sure, it's faster, but cost to maintain
a new hash function is not trivial.

>> Either way sounds like a good direction, but maybe for another
>> patch series.
>> Anton, Alexei, any thoughts, on xxh3 direction? Do we need it
>> at all, where to put hash implementation, should it go into this patch s=
eries=20
>> or new.
>
> I think this patch is great as is, no reason to block it by xxh3.

+1.
Proceed without xxh3 for now.

