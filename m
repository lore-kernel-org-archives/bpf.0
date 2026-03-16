Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E3B625
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773666294; cv=none; b=pt3q8iIsWggf4RP9HRKrQKvb7m7kwLvgxVnxhDYiZHR/7jk+yqXvrEIgXqvzb4lzau6iStBdbnMTjOnD2dZ3ettfQqMZcimV+PoOvNKq15CJ46bJNLvDgna17wolz8Eeebw1msj8DzMDZ0QEQdCEy7AA0zcqCEIuYrFBWTwvFWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773666294; c=relaxed/simple;
	bh=coROkVKO2LP6M4Zm/yvO7bdjOMBXJEvIaFPryU8r1zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pt31NiuzBeyfIbAs5OMsc0qlKZ0iAdDUlxyBlgGWJUvAHLRSOnapbFlpqVoNXePoaJyKZoKNHl7mt6154sNpxBTS4iDxMFlM57wisP7bs+psSz/aLkkKKU+T3hARDdnKeoGE6+wgB1YGbwc+MVbaPf7UODACpiyHlX9+N2eiQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6sqqN0w; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6sqqN0w"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483487335c2so43983575e9.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773666291; x=1774271091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WuEn7ehp2dcDf/0JXcNA12V/0d3/A/jz0zpMPpL9KQE=;
        b=R6sqqN0wbUrF9FiSnor0XVW2yML1aDuSaqsr8WJ1x/5LCsPLKiQfCw2BPCFKQTneyF
         ItgiuldKahpHSz7PpaKEhW/C9D3ISO0u7fYDtgWfClQZzdpTGhX5Fw1iqK8CDfEi+WZX
         OyLd6XKETkZBGihex1xjIunIiUHbvxWEsoT+dPYw5bEkBj+YtJTARZogoJ6SHCLZMCoh
         uR3rEDWVOdHTzfe0IGjuCFcFeyTy0JsSmRfoG2vRECnwpPnQSQClLhbiG4PdjbPVMY0z
         oPWuXEtz2w/4h6gXA40JGWvDVZ1s1eroc+roKinrFX0OuTH2O7fTNPOMcMpmGaj7mo7H
         Ud1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773666291; x=1774271091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuEn7ehp2dcDf/0JXcNA12V/0d3/A/jz0zpMPpL9KQE=;
        b=C4doGkN4v03SUNCxS6p3Nit9xmbLWzStoJkw31NCV5chtMnHrVaAz9PCFSRnTweDK3
         7t15TJ2a8s2+xnINUse+ADYfC7aiF9unteL2idNuPPq6+KNIGaGZiikq2rv7Xo/8T6+d
         K3VNAcG9nkCKNLcBOmJvBLiJJcXXiMlefGAh0w9JOMsvzuNNHqCQPS0q6Zaj7CVRuL/r
         frgqcCZr84EKiiXz2DSsC0YSVwb+uM5VEhwrictaPOtxuQzC6Ad1+ey3bEcsuRNf+3Cv
         4feWi+7X+EaRA262WdaJacNajcpaRMgz1mg9T1+oVqVwMkWA0XNDQXpzLnzWCH0Hg5wP
         R/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCULu3+n9p0ju5BB2b3Tm57JaiNliD9/RBXd/aePVgT0cVo5TIRcdwjpfgIxSq0R6ysyGDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKyRCsjy7x5H6UJu+JEUw8cx3tG2/I9209CoERDbi23xJT1z5R
	y0tlW2iMIsc/ttHbWoYvmiwndXCU7FODrveNoo5edpnRaeWhyyHsPuvu
X-Gm-Gg: ATEYQzxj46+RGcljLsaAGSRbd2VOs4R8tkTypeB9cC4fyIfFxsM+JE122gZkwKZeMKM
	NFLQwTRyxXOxbnEzfDiBTeKHzXK5T6hDX6YsA0vMcQ3GX8RWCEM4bq427t4zdqqE3CHVuzP3lsc
	e+RqaPo4ehADKyjSLl06mk/rx2lZ0/O354YEKArU1mtbxdCq764lxqRKhIysQzVS+3U7ojC0DPv
	JwQDPQiEQM88Si8pkJyw6Y/jISZjesZQgC0qq5vmu9X4Vhxe7u/UKK0UhupRDoKtqD8tzBXHl2B
	ewD/AHj+lmkUhU5Yjo5UG4wMAVLLxhpO7bo+SY7/jtXXG1qKDEq8fmxVgAgZe/5xBSEmuAEjJ48
	5tgAebpMSF1k7eiRcBP3uFX5/okMrVn8aXxZB4Kx/WjN7exvM4gEWMgz6oxYB/NTG/GaC4X4EuZ
	mmMQ9pRFQyxtDp0197Ter6u6wKajxNjQVXHDOA2+LVS1wHMcZG5HbkVkHWHT5buLtZ2OwDnVwIt
	5CqR4VEK6gg6XWCs8jAUfYkewKuQj5BwGcbCoJa0mMGCT8a7nnEg4u8K1ombZ0pUtfB6NzGxrfE
	YXVv2GWf/XY=
X-Received: by 2002:a05:600c:8488:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-485566d2fdcmr203737915e9.9.1773666291248;
        Mon, 16 Mar 2026 06:04:51 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0077fb9a9968087a66.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:77fb:9a99:6808:7a66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485564043a2sm130013895e9.2.2026.03.16.06.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:04:50 -0700 (PDT)
Date: Mon, 16 Mar 2026 14:04:48 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] selftests/bpf: Check alignment flag if
 expected result is REJECT
Message-ID: <abf_8FcnQr50CCTn@mail.gmail.com>
References: <20260310064507.4228-1-yangtiezhu@loongson.cn>
 <20260310064507.4228-2-yangtiezhu@loongson.cn>
 <DH02R7I6EAUH.16649BMB7V1N8@etsalapatis.com>
 <fe04d981-fc83-0ba6-4dee-8fc0c953e09f@loongson.cn>
 <abKHi9Pr5iUbIQZI@mail.gmail.com>
 <7ea56716-fd5f-1740-e634-1dec4196dd2c@loongson.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ea56716-fd5f-1740-e634-1dec4196dd2c@loongson.cn>

On Thu, Mar 12, 2026 at 07:06:38PM +0800, Tiezhu Yang wrote:
> On 03/12/2026 05:29 PM, Paul Chaignon wrote:
> > On Thu, Mar 12, 2026 at 02:59:57PM +0800, Tiezhu Yang wrote:

[...]

> > > -#14/p Dest pointer in r0 - succeed, check 5 OK
> > > +#14/p Dest pointer in r0 - succeed, check 5 OK (NOTE: not executed due to
> > > unknown alignment)
> > 
> > As stated in my previous answer, this note would be incorrect: the
> > program was executed in test case #14 because it was rejected, not
> > because of unknown alignment.
> 
> OK, please ignore this patch.

I think the second patch in this set is still worthwhile, so maybe
resend it on its own?

Paul

> 
> Thanks,
> Tiezhu
> 
