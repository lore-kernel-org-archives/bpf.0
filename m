Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A9239B97C
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370514; cv=none; b=trW5+vXx2e5Dgsrjydwy8u5X4d2NjlTtD8cdgjakboDQ5E/dgWLJoC0W40UpGVdn90inXmMEM6CNIsSGi3jAv7s1JIbdWbFMfmhGkNTf4ldfXMGyDH0r6lCqeFHFoZX3ZhACxIQ+AxR6Y4/0PfaaiDWDsLgE+9Awtx4g2ahzl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370514; c=relaxed/simple;
	bh=7MatbDgQaWgyh+g+DD4yZjrx8Tdr7YMJC0zFSYrDllM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvG8GfaGQ43Qkqp8kCwGJ1gNzEPmaB0WPY2ZOq5kSlbqXQUuDfxsqgcZyh+oLZpIhfpgJvlYcbl+yg/i6SR3x5cGnILU47dGQsN9AJ9l0Jz+azltztU9Nk064j+84gnr1d9QTif/gfQNbBZT0ijNkjG5KBQZN49Qu1tOoxiW/a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=vbxFv6Bp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="vbxFv6Bp"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c742d4df00cso20329a12.1
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774370512; x=1774975312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MatbDgQaWgyh+g+DD4yZjrx8Tdr7YMJC0zFSYrDllM=;
        b=vbxFv6BpcqIkm4AeKu4gyPUI1iEFsAyCEl24gZHOyAdza8EdaWF5k2vTgofZ8ULd7U
         SqbNmZmGm/cq7IpxfaILIWCpyFxg6OYMHvNFlwTfZSL3t/w4+m2fdTQmjybYB0lEPGJZ
         025SQy1ldvBeNF3XEuLBqzWR6Q3Ix96oRIurRN5aHrY03Ujnz/f7Kq4hkgbI0SZr2nav
         FKAa+6zZAHE37XN+BBgNeXhsnwhEJNoY8eQD+wWd0stw1it+HNWScHefkkGc+BeXGcv9
         JiLzcQlcits5/rHdm/3u1O9BGE9iDfJbJj8R+iX7beD+Q3czz/kzf7E+4UAN3IBbjezu
         5s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774370512; x=1774975312;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7MatbDgQaWgyh+g+DD4yZjrx8Tdr7YMJC0zFSYrDllM=;
        b=TOfgKPGmQXdJdi34VTJtu0vOl9pdLWQlWL3JoB0PdwCtf7aKS3SdnoohYPnm2iU1Jp
         3bv7aDPbGasSm1WNJhaPA7iBmN6UtvbTTykAMORMy00mPE9v5ovwVmgbx1rGq1CjhYV/
         g3E5ReXkMi0V58H5pv5Jd1DXEqZX44wfNhMuz2KOcRMvhgdB/3Wtf44q0ZRSfTvrJ7eY
         DtVaKCj8m2qVNkSmtjpFmMnup42oaDUtf6idt8hj4/B44nr3Z0oAqwvisj0FHihLZvyS
         MQM7yeJ3QrQDCE628dNKn6zciD93jwf2zu48XgKldPLzIVabRc2U0q/xqB9eKybXckRn
         TvvA==
X-Forwarded-Encrypted: i=1; AJvYcCVAvRX11/kynFuC55qlUmpyjuSRTiDKIJcxN89h1p9cj5SImHoUpNyiRk6po9AGlfSAGiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXSkpPuqJDJAo7W1QVNZz2nlge4Ex43Y7jcWo+JB8+zxWoyLRu
	+0j0BcU9B3TtU840IpEAu1K9MPsXNT6KBncbtWBzr6Q8dz5zeA8FsyUn//rUmul2hog=
X-Gm-Gg: ATEYQzzuXdFaW7GlD500GeFnwi6PpWjw3H+RpWzLgA3MLDUmDIWZjixjwk8tJOew1NG
	/8gGE4Z4DZPaYath2NHHk2EFDi7Tk5fQdETa4d5miBk7fgYDikKVVgJBdSh8yppYCO+e5EduQfX
	JwWSfsLL2LM3+zop29kPYAmWuq6VPcWuaiCfmvdEa6Cjzl16ojH1sKqr1PiaPz0Td1k1NiJwD3b
	PqaJTZHtImcR60uKDyWYzEAjZZGVrwV/tS8Oo/X+yolOKVOnxAugregvD84fkATUZMOsm34D99X
	90LgF5Y4B4eDWn2zyVI6geQJ1dU+GjWlO/WYhGuAf/q08BbhIoN3brayxI7S+y2guYSqa49r5BM
	FIvZhm12ZpoA7/9ECu6B1H31vI9mtP1qd12B7Uq5cCSq4eOK5QKd6dnHE4rAEjXhR62azGdqGWa
	XYc6pY
X-Received: by 2002:a17:902:db0e:b0:2b0:5a4c:726f with SMTP id d9443c01a7336-2b0a4e0f962mr38951665ad.15.1774370512477;
        Tue, 24 Mar 2026 09:41:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516b96sm191790655ad.7.2026.03.24.09.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 09:41:52 -0700 (PDT)
Date: Tue, 24 Mar 2026 09:41:51 -0700
From: Joe Damato <joe@dama.to>
To: Matteo Croce <technoboy85@gmail.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] e1000e: add basic XDP support
Message-ID: <acK+z8Udlg1qyDeu@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Matteo Croce <technoboy85@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
References: <20260320132356.63194-1-teknoraver@meta.com>
 <20260320132356.63194-2-teknoraver@meta.com>
 <1d708196-7b89-431f-bb17-177564196894@gmail.com>
 <CAFnufp0LRVxwh50cLrg=hUe6itshTqrNy53HkvBWk6MQ7uL0KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp0LRVxwh50cLrg=hUe6itshTqrNy53HkvBWk6MQ7uL0KA@mail.gmail.com>

On Sun, Mar 22, 2026 at 03:11:56AM +0100, Matteo Croce wrote:
> Il giorno ven 20 mar 2026 alle ore 22:23 Mohsin Bashir
> <mohsin.bashr@gmail.com> ha scritto:

[...]

> I addressed all the comments and I'll send a v4 soon, thanks!

I was paging through the code last night and I was wondering: have you
considered splitting this patch into multiple smaller patches?

It would probably make it easier for reviewers to read and comment on.

Just my 2 cents since you are sending a v4.
