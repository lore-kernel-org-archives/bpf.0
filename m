Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E20335B63F
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795694; cv=none; b=WhahpZs1D652sjIhvyCFhzsUr2Yig+DOASE7Oi/MMwP2Dy2e0Bcm1SMtmkQgYFnmJ0Q42nGGFy46TNSo5F7w5TFcuegn0DL2RLte7FEGNzl58eYyJ0OV0gJko5Ge3vVt942y1uC5RiR4TMiM2ZUp9AyCI9HvkY/npC6IKfK06Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795694; c=relaxed/simple;
	bh=aQmfxg7NQpvGz9XaY5eGgk1AWvqY2YAH6p7UeRcAVIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdtP/Q6rmtD0vhHuzmndlgfcz49QYmP30JwsZgJpWNzSBtUV/++/iKyZXYZyDZTnQW/sZlwMWmeLIlDDXuuOTcqmxDuoGf9BgSEYpHSg3zdPaOEq99uV6ndYz0VJ4hLoS+ZpwuhuztPdP+PCI34gVykgfduhmCXLnVSWqCvUFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJoelv2H; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJoelv2H"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43eb05b1875so2705437f8f.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795680; x=1777400480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ey1/flgNoHl/BMtWwmVozPsjz6fm2TXt8LsvNUUYd8c=;
        b=oJoelv2HHEVJnzn6fnmH8P6XhUL/qLzKdzJeg6fPIWUdz6xtf0A5UPHXH7BgykZZFK
         HggTElADNEdJUN4i26O5eM8XYGcDjFL/h9O1xMVnY9LxgCEaE+DfFJpAupdt+1Ikhpi8
         hq9TwZXNbtTPmy43l90iDTsnIHhPd8oNVCJlZ9HiX8G/fdVzdDei+99m+CPs3osyozgm
         2Wkxe973kQKDxlImQoVSyH5PWiWMBz3C5UPAXytBSqwQG48DBy6biM4+lJmcW6xg8T2w
         UKf6VX7CoXsVf77AdZWJGSfDQczxxPaEug4OdKrNboaRt3SGnXfF1mAts6d2MOC6rDn3
         4W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795680; x=1777400480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ey1/flgNoHl/BMtWwmVozPsjz6fm2TXt8LsvNUUYd8c=;
        b=TsCV5Zg+zckMQ1LWVHbAANE6TcTsM/kHpumllgtoHw4iWq/RnqSScM8PjNZVc0+P2t
         sKa3p9a4xgJrP/SmAAyLlnj8BFyxlu68yYXBaL07joHRNpuVoNZFaBx712MDxnZkvHcA
         UHCr8Cja8N7xV3GD4rljUOqX1LGCRMKc3WT314BYBscT4nF4PCR+/PNk7nZNmQ6I4Qi+
         2M5FXi7yW7a22pRfeVXukJLeDqAu8+G3CZ/p6LrqiElSXiqGLTm0qJng/4pea+3oOVwq
         9nkCeVqcBk8z6QK6HLgsaJGPC6DOw9lBAVZOEe7j8ykYmV5o8HjiwqycIREJgddm8Drw
         0hvA==
X-Forwarded-Encrypted: i=1; AFNElJ90nbgz/5kID1XyDq6ll61G2mfj8AUKsIElNz7sqX656hkucyuVGvIoeqv9Mvn0iJ6R6Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LFTCDnpScm+RNKoH6lp7fIwuCXJXBzG+buNnRk2bT+eOAavx
	y8mPdltvvvI8n19rHIsf7ETVFulWkKXDYQBnnJOOv5g8ZmqWhdhp1dl9
X-Gm-Gg: AeBDiesGqWWOjpdjg2GhJTHO5ZnHTjhuIll5nRlpORAOmemzNR5diskFyBmgyspDQ13
	ZDamcrXm/FRaouC4gTBIQ0QxSBaV//8u4i30u9XDuRzEa2zziRQLMD8e7bEY0KS0tkJSqAUQAwD
	qqf26+mzFbrpz8rReH0Dv7tAsjBWNrCRhppvg2Mf4C8Xuy8gCkbmAHOMGe2tBpDjfm/6OhvcYz3
	PCcgoe9JXWqnMgJVWHewTIaHnrmuqsjEoSkx78p6Jb2msgRTguO+7TPcTupgguMhKes5ryVWUcK
	2d2FkVUf6e9tRB5xxIEJRJ5D/Ku6DjFGE2CEL/7Q+onGKtE7grMM/jr/jQwcxupL8PAfvTaj708
	XKtNmYXNEsq/KA6aoblM/7bLg3EIM5Co2fGF2KJtrXvLF4V1slrpm4T/SMgBuJVsvv6Camy2YQV
	e90I1f6vLZvdVGBEvjNP3S9hhzYwjN2beaiKAIvDa1D2Anv01rEqT5NrgVHP/WEQxgD2DcLRg7q
	DddeeFr2+/wzV2wX/mgQALKojxEEWwGDZSX7tVbmSLYq9F0BAaCtMQesxwBGBBRrQ0Xnt5IFRfL
	OaE4DpgsmB7BAHWq/okfT0q+lnWyWN+c3BBpZMwl9VGprx65V6EACw==
X-Received: by 2002:a05:6000:2082:b0:441:1c18:f779 with SMTP id ffacd0b85a97d-4411c18f7c5mr10736741f8f.37.1776795680060;
        Tue, 21 Apr 2026 11:21:20 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0026dd69ace0c02e6e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:26dd:69ac:e0c0:2e6e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1365sm41235025f8f.7.2026.04.21.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:21:19 -0700 (PDT)
Date: Tue, 21 Apr 2026 20:21:16 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, ebpf@linuxfoundation.org,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: drop xdping tool
Message-ID: <aefAHLdVZaOmf1Os@mail.gmail.com>
References: <20260417-xdping-v1-1-9b0ce0e7adf8@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417-xdping-v1-1-9b0ce0e7adf8@bootlin.com>

On Fri, Apr 17, 2026 at 05:33:02PM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> As part of a larger cleanup effort in the bpf selftests directory,
> tests and scripts are either being converted to the test_progs framework
> (so they are executed automatically in bpf CI), or removed if not
> relevant for such integration.
> 
> The test_xdping.sh script (with the associated xdping.c) acts as a RTT
> measurement tool, by attaching two small xdp programs to two interfaces.
> Converting this test to test_progs may not make much sense:
> - RTT measurement does not really fit in the scope of a functional test,
>   this is rather about measuring some performance level.
> - there are other existing tests in test_progs that actively validate
>   XDP features like program attachment, return value processing, packet
>   modification, etc
> 
> Drop test_xdping.sh and the corresponding xdping.c userspace part. Keep
> the ebpf part (xdping_kern.c), as it is used by another test integrated
> in test_progs (btf_dump)

The xdping_kern object file is just used in bpf_dump to check we can
parse the license as expected. You can replace that by any other test
with a GPL license (ex., btf_type_tag_percpu.bpf.o) and remove
xdping_kern.c.

[...]

