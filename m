Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973143;
	b=NEvSaz/zp5+cmtDhsfRMi16hpxCxqrridNrjnZKWNe2tj95CuOFpXvtxwLvUSMh/kA0T
	 3CLLw9qVxBxFA44ioDypocLuIWjqk2wzP89HVCCJ11xzuLXJeJyjfY4FZ9GSVQcU04VbQ
	 jf78Do1P1qDoFukBt/R+vQew51OOGjFPD3WEe69K0XyCMn7hlMlflJPDATLF2qWPmKfqN
	 AojwHk0pveM1bvsJyEb7JsyQg6klxMXLtCem5Cf3jB9JszVNXcn5egKjbxlRUWO3jUWKT
	 9M/ezfuryMxjqasF78V3To4nbzhbT8Nu8T1o0tWUkWpCvI0alrGTMjXHa3j/CEYp8Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f7qkgX7ESuYJEi65BD2oZdm27r2FwJ6aXncoGqVoKbE=;
	b=O+lNOxM0H61LhK2H/GpSi7u+4U+7HjpyezMDt8Nnem1xsa/d8aIpLDxJMXSiwEtxEJlQ
	 bsGkyBBDgFrMcrGIUWLL+ziOP/le8zYMK/lMwgJ56R+zKrbdXHAV/xrFngn4Mpfmhuybe
	 NLhJU6My2jREUpPE1+r6eazEUDyDBCLCvU3plKLb1xIp9IjFd4maVTU8TfI9BvVpQp0w3
	 +qMJFK7vNMk1mmjWMxK0DnLHYdHHrqmGGlmaFJJUKKAc+tRGV69K0DottWfDhiZLBqpUm
	 UYpKzGe/K+OK2kxVttMEDQkFBvBDQBAVG4btcIXJmSr9LCQUTVVKVU53RY9uL/rkIcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RoYswwVZ;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D259606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 13:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D259606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RoYswwVZ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so5853585e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793973141; x=1794577941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f7qkgX7ESuYJEi65BD2oZdm27r2FwJ6aXncoGqVoKbE=;
        b=RoYswwVZbYIFWm6q8dvuesjQQghyibbBzmpxWuXxHnAq1xAl3PN+62DnYL5zQsCZ1B
         4Yg8Is4fuA/ZQ2rN1j5+5Dt0wj0cloOHZAimzxIknBsUhu9VaT1Zl/yfPqa6+rZuwKhS
         0QVAOduIuJ66MUyqB2DtffAlD/uIhqbMTnPwHPR5kseHQPeSAbLd5C4Cq8sfrSIaqeEb
         /lpz+q6LNZPDypgRplx/WuuJaRnOueQzQSf+tlogRudRUSonj8kWzm1Dp8GIjCE/Lu+Y
         aD9Wk7HPGU+KWueQOc9NFBuPgGDye59kuN2GZWPKKp9y3/w+a2I/gMQ049rY/wjHQZvg
         a4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973141; x=1794577941;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f7qkgX7ESuYJEi65BD2oZdm27r2FwJ6aXncoGqVoKbE=;
        b=2KNHf/aGUOKC3ksKFnZI+LQCLEBRYa6GIGM+KsVTsEiLg0kT9YQkSPuLfu4ydMd0t5
         eWSgpvdiu/OdzRnc0rV41tk4KSsDoBevPfMUuJdsdDF36FJPNF6EB1r3V9m5BgJ3AOqX
         BEKYYKn8QOYA6woIozVTADC5EwqjxV4tebVhUdMsg9zaUf87QWtj6+XzlcrFjicMdt+0
         JFzwDjTVNAFHM6Uw6HPb8fE7dYkWB7zMlIkjCaUQgf3p9jsefRbVWHzpwr273Pz4C/K/
         BEnWgnl1vMhe+VJtKuywAf7L5I2TkFDgu6dsbN0FcBlJc3rqf8AZCfvp+wu0ArsPBv1Y
         1pZw==
X-Forwarded-Encrypted: i=1; AKwUvBxo6wlvDVzZQy3yVUzjCsKRYoum3Ghv9h0JzNEagfBUnSCNipQ83rvIsZFWiEcKwcjm0C8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3HfLShgCihBf/QK2/jC/paqun4pcaBwGI9ZdZNDq1f3VLvy8A
	wTDUXKpl4yhF/TorkUz+2b/tf8k80J3KyJsynM2l8lcFlEWAlRIVHetC
X-Gm-Gg: AYBFou3kOrCyfkYZkuSy9kok4mWZn5+TNnYUVmEtWITo/fERn15zCslrgfswuSNePc8
	/OvWmfAdkplNALcCORYDT8ee/sQKeSeANWHEU+/t6qLulpzApWBW+PnuBCMt9lx+CkHvctHQ4ms
	V3tZbfDJo1197YYpYNBIkiquz12jB/9eHAPK9lqwOU4/DGr0vN7DHrMwP8/lTaIw2DSsI5f9EFM
	u6hxF/JYcFAERRnkUDfmNTxelhZ1ikJPtQfmYtNlTR+fuRNg3rfBD1FJNx8Sz06hbOnjtPEandK
	4JSUaOTjrQMkVMSYrw1TTs7VvAedEPilheEaOFTWHdpAZv8Opcx+EPyL3HUH+GNkzmoeiFRkE2v
	s+cSLuBHSkW/jappFR/zW+x987RfSNExOJiq44myWaQ1Ok4FSMA3MUA/0dcjufwe+V9E/8eg0j2
	tc/Yih4gfEJFo2T4Vwd0kSUJoSvgCwPWts1pH0aSuTJLcmLYwoA5yNUf/qpUuNOQAA/CpmuX6pO
	Ck7CVyTZgggUU3WaPh0C7KT2do+s5AxqkGtRoDy5o4e8/20KNdNXExrgJ75iYIgdYt077QO2dLv
	FoqZfLRRZbO9ebc=
X-Received: by 2002:a05:600c:811b:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-4b6deb5fe17mr43147355e9.26.1793973141312;
        Fri, 06 Nov 2026 05:52:21 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6e24012c3sm56107585e9.13.2026.11.06.05.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:52:20 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Nov 2026 14:52:18 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: Re: [PATCHv3 bpf-next 2/8] bpf: Add user memory kfuncs
Message-ID: <au3bkmPTBnpVU-9m@krava>
References: <20261105102343.311331-1-jolsa@kernel.org>
 <20261105102343.311331-3-jolsa@kernel.org>
 <CAEf4BzY+1a8v8AHcr1AfUBR24uMitU7gEe2_1Npwp-8_kagU3w@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY+1a8v8AHcr1AfUBR24uMitU7gEe2_1Npwp-8_kagU3w@mail.gmail.com>

On Thu, Nov 05, 2026 at 04:34:40PM -0800, Andrii Nakryiko wrote:

SNIP

> > +/**
> > + * bpf_copy_to_user() - Copy data to the current task's address space
> > + * @unsafe_ptr__ign: Destination address in the current task's address space
> > + * @src:     Source address, in kernel space
> > + * @src__sz: Number of bytes to copy
> > + * @flags:   Reserved for future use; must be zero
> > + *
> > + * Faults in the destination and writes the way ptrace(PTRACE_POKETEXT) does:
> > + * a private mapping doesn't have to be writable. A partial copy is not undone,
> > + * the bytes before the fault stay written.
> > + *
> > + * The caller must coordinate with other threads so they do not execute the
> > + * destination range while it is being modified, and ensure execution begins
> > + * only after the copy completes.
> > + *
> > + * Return: 0 on success, -EINVAL if @flags is non-zero, or -EFAULT if the copy
> > + * fails or is partial.
> > + */
> > +__bpf_kfunc int bpf_copy_to_user(void __user *unsafe_ptr__ign, const void *src,
> > +                                u32 src__sz, u64 flags)
> 
> you'll eventually want bpf_copy_to_user_dynptr (we already have
> bpf_copy_from_user_dynptr), so might as well add it from the get go?

ok, might be useful will check.. will send as follow up

thanks,
jirka


> 
> > +{
> > +       int ret;
> > +
> > +       if (unlikely(flags))
> > +               return -EINVAL;
> > +       if (unlikely(src__sz > S32_MAX))
> > +               return -EINVAL;
> > +       if (unlikely(!src__sz))
> > +               return 0;
> > +       ret = access_process_vm(current, (unsigned long)unsafe_ptr__ign, (void *)src,
> > +                               src__sz, FOLL_FORCE | FOLL_WRITE);
> > +       return ret == src__sz ? 0 : -EFAULT;
> > +}
> > +
> 
> [...]
