Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2C4C81
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706326; cv=none; b=sYx3l30zfeVncmaVkhj5fYq33FGFocdQXNv1ogUdukB9YcgpTB0Z5QIeCZa4WowPojINtFmEcF5LeqEU9CIE2kimPlj/HjRT15DjoNFWhOLmt23kfDtFSZhkiGzoIW3sSrdsUHUE9JHh2ZYbGcoBZBCjHGELvsed7yFiG3nrEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706326; c=relaxed/simple;
	bh=KPk0VqEkgTKE5kcP47B9rj9VdP8a5q+dUAXz6Mokabo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQ3/efqc5/5sVh/kdFHbrjKO4gfrVRY1TbXNLgQRiyporD8lHt6Q/Bd0dHICixQYZmQAHxYEz/ZCfNOSpIZyeodAEIFEFgyroKDI1pnbul202DtUl5WfsEkLD+hgOFIuUeLWcFrJURTUEC8j6ddMoS8GPsfn7NNHUQD6wG73RWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZcl+v1e; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZcl+v1e"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43b3f91a7abso1180084f8f.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 17:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773706324; x=1774311124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LM1H0TkGZQ4/8IPYzTH9t0b7D+QiEfzm8Bsq3kZE6YY=;
        b=AZcl+v1eOBQDSRhJjEQjJm4Vmwca5tb8OCybg8IdO+qSxk20EWvzWsDyGCPYZYlax1
         6jPTHcg2gRXsupyqby2zuODp/5OVc3gxg5jn++XYB61d55mvcdE3K60fH8Oy1xWaGLSx
         KSh61ZrLbk4JWvAk6ldu/3w2VepDrjENRj9oLuiI08sYdoF5/fMHcJbugWyBooM7ee0L
         tTQmFm5Kz0g7kwtOdYSMcuFI5a52xxd8axGfAXiJEiFHORaVMe45UaW9zWZaM9PQsdv7
         CIpBsGxIVJ11OriYSbjHwhsX2gS4vT6WjzdiRsp/EGsHGvwE8B5EyS22RaZ38CRlTk8w
         hAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773706324; x=1774311124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LM1H0TkGZQ4/8IPYzTH9t0b7D+QiEfzm8Bsq3kZE6YY=;
        b=iP5EWaVcvEeY9jmTKwNjypqQkQtT6nG9MKTM8SIDgxAhyOM1uHpkCW3sesUzgb0A6b
         txRKfWdxlyYFzzOKGhiaZImQpLrc/EzsUhOmeYHkr6r5v9JNTRFwot1qKqtrm9N8uYJm
         UsifZuAT1buHUt7zm1ZCyZHaFTLu+Yx3PfJF/GxLC6Qo4Uf1snf9J1YA3x7TuEFFkTJ3
         dHzQrRMZ7bTHG2I0OhQDfQYT3ThIIdR1v6Je8FXcKfyt3LdGEvDwz53aPo4pcG916DPU
         NbGVS7lYWSro87TGaUQ5NN/YE3rQFRcSoMLGF2dz2/juGfE+RTqhMPeNSrZA06C8nSMA
         iqvw==
X-Forwarded-Encrypted: i=1; AJvYcCWtXQ/0g9OA4GMunzgd7ev7uPhxJ6OJGxvaZSobBWcH6VfbJ5AG7r/LHs43D2Iq2eokSA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kpxY/z/wEPAqNVjzfg49fTzcqC3+jtbiZuTAg1+VyQs6aCoM
	S6Yvt1mGm+EXP0g/hhVzc27bdBkHpGzcXekZ6qa5INR72u7g2koZ90ex
X-Gm-Gg: ATEYQzxp+c91vpLkomV0Xwi/BIWwUd5E76YZPgqBS+zMRy5y2N6n6Lq68WiwnQzBOhB
	psAsOUo/hxBAdv2eJP4GnKIGfUtCk9vlx6zIDN/nWXjG/VYoJhYBIoCzBIRw4Hbike8z4T4sbf/
	L291shgWWVIQAfJ3prT1sLQj2PdeIHGr3VaWrPAWFTNrR9Bkn4HKmMsFdwj0qdbPRL6r7zP3isB
	mS51vLlbuZ9gF+RwvDYxvurk0XekiF7qu+D5lhF9K3yk9hYJug19Vn1qh+pQtugVQJZeALCbZ/I
	M6q4v3ywGSh75uxvReAi1tSS50H9zJfOzimDb/7k5e1wgTYJ8qpPjFbNRLVCxpp684bY4xnAXkY
	uHxkqwvJ2FF9XCaBq8I3XLesL9dGfoTeFqSy99x/TXEeXrfnvvTQNbNZAqbqrNQjWESbM962Rqr
	ex/mpz+PAvx5pilfpagZ5GrDYu8L86UMcb0wPgb3tt4ySwfVfpSyypHk0y3nfjFzr3dZ0DMKIoX
	yLHayLxnDlO9qhEC1SpuLIg6sOvpB2hvWwpMllRBV0QMBBx+oc36wkJaJoremgjsiaSI1UUbK00
	mTFZHqYBvQ==
X-Received: by 2002:a05:6000:4e9:b0:43a:4e5:73b0 with SMTP id ffacd0b85a97d-43a04e585b8mr21072634f8f.17.1773706323812;
        Mon, 16 Mar 2026 17:12:03 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00ceb2d69518440fd7.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:ceb2:d695:1844:fd7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b416e3678sm17786534f8f.17.2026.03.16.17.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:12:02 -0700 (PDT)
Date: Tue, 17 Mar 2026 01:12:00 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, shuah@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: trampoline_count: use dedicated target
 function
Message-ID: <abicUI4YQ5KkQ_Ro@mail.gmail.com>
References: <20260315054227.118344-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315054227.118344-1-sun.jian.kdev@gmail.com>

On Sun, Mar 15, 2026 at 01:42:27PM +0800, Sun Jian wrote:
> trampoline_count fills all trampoline attachment slots for a single
> target function and verifies that one extra attach fails with -E2BIG.
> 
> It currently targets bpf_modify_return_test, which is also used by
> modify_return and get_func_ip_test. When those tests run in parallel,
> they can contend for the same per-function trampoline quota and
> cause unexpected attach failures. This issue is currently masked by
> harness serialization.
> 
> Add a dedicated bpf_trampoline_count_test target and switch
> trampoline_count to use it. This keeps the test semantics unchanged
> while isolating it from other modify_return-based selftests, so it no
> longer needs to run in serial mode. Remove the TODO comment as
> well.
> 
> Tested:
>   ./test_progs -t trampoline_count -vv
>   ./test_progs -t modify_return -vv
>   ./test_progs -t get_func_ip_test -vv
>   ./test_progs -j$(nproc) -t trampoline_count -vv
>   ./test_progs -j$(nproc) -t
>     trampoline_count,modify_return,get_func_ip_test -vv

I was able to reproduce the issue here then validate the fix. I however
had to include several more tests that use bpf_modify_return_test
(get_func_args_test, kprobe_multi_test, missed, and bpf_cookie) before
I could reliably reproduce (in a loop that runs until it fails with
an unexpected E2BIG).

Tested-by: Paul Chaignon <paul.chaignon@gmail.com>

[...]

