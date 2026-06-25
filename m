Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0664338906
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 13:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394760; cv=none; b=kHfgayRV+IAX4lCWv/bSMFegj4j4pKPZKNv9rP33IthHR5xUsdGn4Fx1/07MbwWpfj1kF9CCjAy2fewEvGrXLePqUQvd1JIueciP+9ThOe0R+SguvAQoy8ZEaAJ9OpKkPzveARfQOagVWt3RIBUnEfjk1jZOLreZLf2yAYAqhTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394760; c=relaxed/simple;
	bh=+kdBpGeCCh3VUHhZsZ/4EJAxob800T1QKFGk864OpTQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1WahNxP4ITF+91mpnVve3b4a5FAGjJnJQ4fXNKUKX5OXAEOFZ1FCfwpHZxKkWOSmqwHbmpsou5ViTxxjtaARRDa2Kn7pM5U6U5CaBY+cfTFRpbPxMIohrrFidcu1EYK2gyeur9dH265n6lDw89ufhGYHS+jt04zCFA+UR4625s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fzucqzwi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzucqzwi"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49249072f03so13070825e9.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394757; x=1782999557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f4pR9K1dxaeISN5nLk9a9H7V77qeKeERtll7p7KH46E=;
        b=FzucqzwivK8xmREkSS/Z/KLx4t7ifE8Tob6iXKXyzgvOnJThNRrxV1ajtiD6mwZO1O
         Av672lmi+JIOZrwsCFWPlIALcvzzM69WH+Hlhr2P0X7kmZNWdLfzxTcpGzQD/j63ykGX
         v3WcdVF8eRfvEAq+tNUxm3iUhw6zaaqFfXKdn/sUH5XdrmWBPHidvIJg6OGGWcyOv/QH
         ac9bU4BVmEb6qVOkJkNas1Trzy+D+Rd8XQGr12rqZgJNcLHzVqpx0GZy8A3pbRWaDvAf
         cYsHpFz/Gg5xr8bJl0Lo9ejJ3qpnngKUPBU9zAve0Ia/xVNSLR4s5o5doDxrtgStpJ1I
         1yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394757; x=1782999557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4pR9K1dxaeISN5nLk9a9H7V77qeKeERtll7p7KH46E=;
        b=AAK4fL2p8bjYehCZDVZ17pTVLpy+4mhG0g7lXeoZFSrLv1zYznhomeossSYwk1eG82
         wNkgEqU9YYv2xvRmqpViOhZS/aVYZBJ9H4W1RUESngFDGcYkP/EIJLOsBtceZHr0WkX8
         T41cyEpMtficLvjgiZagv8PU/XZi4BkaKybs25kwx2K2+8wU8D/PwREEuQ3tKqsoNem4
         orw3YxbGgpF/5CkJ4qo0IW7rOpTgNm1Q3iI+hkMYa+dZMTVv88/aG5xoIMJ4HGGh0Uph
         X3fRNeXv+11fwn1PXn1RK3Bj7Wqhp56TBIpCO0BgJGN8qob16I06MdoFn67da9X+k5Zl
         1h1A==
X-Forwarded-Encrypted: i=1; AFNElJ/MlN6YXoR5Vz03wA4ov/5ycaXQ4u53SR/1HSOYU+80wmrd8FGBgooc0UbgG8BvpDOWreI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhiIbfyY+dZCcrtJFOCywlpeVxf8fKv8jQ6K7u9sb5XxuLqLD3
	jiVtfbIiuCUHVhPtk6MK5m6RqJLQYPwVjlXLG280G0lfd4bhK/a42xDc
X-Gm-Gg: AfdE7cnVTfU+6R8ner+X3GOft7+8PYikGpqzdRGTY+U5oazRRHnHJdp+qKodxiQ+Zqa
	pv0tmhkaN2Ul9+ucqpCPEL1PRY0XnbieQEvmyxZualAW5gYr/ov/Aj4OlXaooH7/EfLoFuENr5Z
	0Oo6P4WxB/LYcXBzyjzak0TzRs0YekYOhDV9m+p8XuGdf62pfKJb6QiY1kfn+tq0/8aw8GHVlCT
	uLiYqkztfn2k8V9WHeWZWCRowMIW2qDI1YZWjFm5cL7NPtheM1bjR/qpV1QxIL6POj3MoBOuLh9
	bap/PBo0E1hMe8RXnIeyHIHmmLI2TPEg/uBOqSOjnugy2p1ANs6yzvq1WgRNFS+GP3zqNKsp3pT
	Pf6LS1zd1eriyJIKAjWRaZojxVe3w17tcUQyu3PFbCv90az2mSdhiMRTiqAztpLNidV9USpaQbP
	2xs1yq
X-Received: by 2002:a05:600c:a403:b0:492:4e1c:120 with SMTP id 5b1f17b1804b1-4926689988fmr31107965e9.32.1782394757186;
        Thu, 25 Jun 2026 06:39:17 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660addddsm63819605e9.6.2026.06.25.06.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 06:39:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Jun 2026 15:39:14 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 04/13] uprobes/x86: Unmap trampoline vma object in case
 it's unused
Message-ID: <aj0vgiPpnmwrfL3H@krava>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-5-jolsa@kernel.org>
 <ajv5lxWjNHBAUa9r@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajv5lxWjNHBAUa9r@redhat.com>

On Wed, Jun 24, 2026 at 05:36:55PM +0200, Oleg Nesterov wrote:
> On 05/26, Jiri Olsa wrote:
> >
> > In case the optimization fails, we leak new-ly created trampoline
> > vma mapping (in case we just created it), let's unmap it.
> >
> > Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> 
> 
> but I am a bit confused... It seems that this change doesn't depend on
> the previous 03/13 which removed VM_DONTCOPY ? So I think this patch
> could come as 3/13 after "Remove struct uprobe_trampoline object".

ok, will move it

> 
> And the subject looks misleading to me. A tramp vma may become "unused"
> if (say) we remove some optimized breakpoint, afaics it will be never
> unmapped. Perhaps it should say something like "don't leak on failure".
> 
> But this all is really minor, please ignore.

np, will change

thanks,
jirka

