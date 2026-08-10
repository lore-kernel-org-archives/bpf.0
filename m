Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2837F007
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786396629; cv=none; b=vEuywUSEwt9npYCzdtMbLm7sjGzAKyrwCDKf3kO3fd3Kz+E8QVUqReAgC/Fovi8xVAS5y14ZH8CfaXl9m6Ny3aLTFn8WdAUONKYjkHmJisRa1HUe/DNkv2ra3PNJbjaTIUBQYaXc5OMc1O44K1e1gpzj3JYW39Y71yr9Unu2bDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786396629; c=relaxed/simple;
	bh=/eNYr7gxVXsiS8OzeIt6VKgmVPGjQFiSXlFgr5Z/Kmk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QIKMDWmyw58sqUSCyuaW+WTrEkKjCrT34qm19Rnf1IfIbwMbKWJqVkSE0kkh9Z68K4Q19zJ9eMIqkWM5b2D0hzbRIJb2O3VkFWaGsJARYGlhP9RCBrWKdddkRY9is22kXcJlLqXrvFgW/NQvsirIL+OlTGV9czMr17wJcpq82lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUbKpo3k; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUbKpo3k"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3811f512167so3325417a91.3
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786396627; x=1787001427; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/eNYr7gxVXsiS8OzeIt6VKgmVPGjQFiSXlFgr5Z/Kmk=;
        b=SUbKpo3kt04x+E+jGgF+F3MwobcvCt1/iT9nDI+kOqUFVNxOCFAlsTQkEn/ZZAu+px
         ympOvGB0W6zcgItzEgOkuzPpenPAhpIfc0vxIYcBoFIg9B0NTBP9QC3n/N7/l6EihLYo
         XZplMBqe16xnivHauMH7co+yy85er4iZDfdRQeijJV9HsZqdwEvMURCueYla5vs0SMAP
         zu75Pm0+st1rgZh2wMOpOwIfPELSX7Xm/G/3RCYdo49MH6happx67iDeVRR1rOyyTINn
         JzsqV9y2ECxp2pLwk42sfHTSj+ud4Ecne5zy1sLjpASr0ruGJedKWZddopRxLih0jcEe
         912Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786396627; x=1787001427;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/eNYr7gxVXsiS8OzeIt6VKgmVPGjQFiSXlFgr5Z/Kmk=;
        b=BZpvUXvYhB1oAMq/L44qtYcuEh/SIhLAgPCP6SupYsj82vWPx6wFQbgAj7M0xuFPLZ
         rc7O8KvZeWXqfrrzazJEciVPPdRqHo0UhQhNrPobg7AWf1+onqFjf16jDfgnczsmbAe+
         uNy1GXn3P9acVgHVl5/uzuHeaNRG9nMOxZ0NDqhVBNM5PRoGZC9M4N0/Pyr+VhBl0avh
         8fUgESmk6TGElP9lp92LWEryS+OVO9tkHTHJtlbrSGyBP682+tu7HZdt0RyyIsmywprh
         fb1Jtyn57pvBBPTxRFtxbUQ9P6xtjmDvPkIuE8j5SrSZoKjynZCGlJSfiysI9ro1BN8Y
         WJYQ==
X-Forwarded-Encrypted: i=1; AHgh+RreMXd71pHQWt84DXfLltwThssI5SIWOzFnp4GK585fFFsBleaUReGAaeUgeQX9XDLt1ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqj0aWu6HNj2C0dED8sDYG/Gi9ES1XPaUHEbUiIPx9BTToho4H
	9TlQmVa+JuomHD5EbquMUubfG5nBZAVUEdFK32fEhzw5VeFditdSgk/s
X-Gm-Gg: AR+sD10RZgquxItxML1ysAeWsqgF06NUcE5P2+7UHOl1BOipB6+TZMv+Ii5wbBD00bc
	hsSqV1YREJo+y5lxmVxtYxQ6GExMe0Nep01m8gRyXKqekwh/BQT4sXD0Qj4nh1XyE+ATUe5x7lq
	eAJweGUhQCnOb1FerxOoMjbSs9I5Xqdp8lKmAs9OoF6fRf36Rg1+2VM4R8HOgNy8F+AQAQ8+Dsr
	yopy7yv9G+Yr1HxnIGblBlq+jS8Bp11ULnZ2FKnBIuMg8TEC2/2WKhqL+8HqPnBiKbYnqdQP7+Y
	N2BJExcrQcGoHgJVuriqbVCc0XjrVnkZ8zAl4e5anVnx4qx0hEUHhAH33/wGTEOaF+vLjtgsjZ7
	X35on8VZ1SbaMuAp4QRe9eMWPaaFGR8oEetjZ7Qky411O5x5VjGplpnP/PinsO3UUJ3u7W80z/+
	PrLwrc5n+SvQ6OyNs9DKm0i/ydYbG/eiLkn6RhiYz3VVz03pBogVSYT0bH5Dv65M2M/m93OIkuL
	FLdTrE0swnxEMhZYpbVpcJ/PHbS
X-Received: by 2002:a17:90b:2dc1:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-392cc9369f8mr4512493a91.3.1786396627113;
        Mon, 10 Aug 2026 14:17:07 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392d51c333bsm1022849a91.8.2026.08.10.14.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 14:17:06 -0700 (PDT)
Message-ID: <96eceba605b2cb7e93b3e33abf545a02c4eeb1cd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Eliminate dup/restore of
 insn_aux_data
From: Eduard Zingerman <eddyz87@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis	
 <emil@etsalapatis.com>, Yonghong Song <yonghong.song@linux.dev>, Anton
 Protopopov <a.s.protopopov@gmail.com>
Date: Mon, 10 Aug 2026 14:17:03 -0700
In-Reply-To: <5a4528f019c8d2638c019a2f37475cccc16a9503.1785240296.git.xukuohai@huawei.com>
References: <cover.1785240296.git.xukuohai@huawei.com>
	 <5a4528f019c8d2638c019a2f37475cccc16a9503.1785240296.git.xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-07-28 at 20:25 +0000, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>=20
> The dup/restore of insn_aux_data was introduced to resolve the
> inconsistency between insnsi and insn_aux_data arrays, which occurs
> on the failure path where insnsi was rolled back to the original
> state before constants blinding, while insn_aux_data was not.
>=20
> After JIT failure, there is only one user, bpf_clear_insn_aux_data(),
> that requires insnsi and insn_aux_data to be synchronized. It accesses
> both insnsi and insn_aux_data using the same array size and index.
>=20
> However, the access to insnsi in bpf_clear_insn_aux_data() is not
> necessary. It is checked to skip the second slot of an ldimm64 instructio=
n,
> whose jt is never set and can be absorbed into the jt check itself.
>=20
> So remove the access to insnsi from bpf_clear_insn_aux_data(), and add a
> specific length field for insn_aux_data to allow it to have a different
> length from the insnsi array. Then remove dup/restore of insn_aux_data.
>=20
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---

Hi Xu, sorry for the delayed response, the patch lgtm.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
