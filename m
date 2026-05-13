Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4DA492529
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686221; cv=none; b=lmCU1lHXjAC9U3UZ4KmKbm+Cfbnk/nkNd9dVzbmUQllo2m9X9XY2zSlqRG/3UI48G79RE110Kbgkiwg0WIX4nq3827E+OIiPqX56Zjtdf1xx2HmiicgVIphg0y+Z0PCD3Ou0aaCsDFLFxEHf6BPy4FxKR/Kz8GeVdFbkRvums3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686221; c=relaxed/simple;
	bh=Rd7C5pIyq6OPAFpxl7D+tvMh9VkGH7FniJDQxl22aEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceUTrLzVwyTE9VPPYn93rP35Iwk10EfSgdi7yiQvyW0umCWx8D9DJzYdpXBmJC3P2Gu6TpVHGX2+KO2dfRAbDxzLon2KuXhgz5qXylB2iYZYvDb0cVF7NO3v6yYFoHfVW3I6VPVZemD9gqXYjHd2geIp7YzH9NeY6Al2CX27enw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK1KqgKV; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK1KqgKV"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-83538fbd0b2so2798213b3a.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686219; x=1779291019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPiUqnotsQbH12PdnNU+eakW9jTUpN3Bb+mdu+U6uUI=;
        b=XK1KqgKVKKahwbs+G2BluT/VTSOjPO8KWsoSKiGZQHNeovUR+vI8A+3ezj6Xhyjtgd
         tn1ttCf8QE/IRZs9ukC834PMS4LgYqUjZqwnk/fDp7DeM/bmVkbDItLVJi1pc5L+P0tm
         dQGYjscyxFXCV+bP/qq3eV5DZBvvZbC3PWH81m2tJxuGSFEALflJioLrl5I250cSTJRX
         igUM4RBGnYdS0UcRnFYGmV+EhlKyviak5QL+vvpU4mgj40/w4U5+ulm6pMj+lYCB47ar
         jdlqPSDtZkcLj6Q7f0ldV8kjAOnFkoMsE+Aq8el61PFDmfRh03mxMkuHi9Q+zH8r1X/0
         C17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686219; x=1779291019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPiUqnotsQbH12PdnNU+eakW9jTUpN3Bb+mdu+U6uUI=;
        b=RjVer5/RYDa5Zg83k8L2EjDB/mkl/E/26YyVNkvp+Oa2SIamACroR8YzEChmcfP+Ba
         uEIe4iunDr4RnU//aLv0zkdamgRYe6lLYx4J/v5wXFhrrG696kP93QjDjpZ/jjCbdKiG
         GYntdb9khJJUszzSNCUsh+kqNAKl85aPW1ybax0voYI9daORsjUAvoXZaLJAw25qiicF
         ZnLUBFQ1G9Uiwusfak4APGGZz2RjBsK125xf+OmlNhnoPxJFPdxIyaGTxpsgQfP+xScb
         HFmGFo8zLf/1nlYtd/0JHghnfjr+E4ct8mMfXRU0jHqeiTywxqVL/+0ATpZ1MIl8XMPQ
         xVFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Mi/WtLE/VZGSUFOo4fHH9vQEFPquwqXEFWJs5jHpI3qhk1yf+UuQkWzJDBXwWZptGbOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysv80/z1YGlSV28ky7tXeh0AxgtKakdJVjbGYjD9P5VOzpuKRk
	ZjF4y98Tn1mynQ2wHkoUjxgVWvbrTVaaMR71cnvOaJ5nL127n/0vfAgO
X-Gm-Gg: Acq92OFfq4qfRmpmW+FJcx/tJm/GOAbwUQ/ur5egnA5oqVvM67NP/NY3kkhMLC7pabq
	zs3xXJwiiNlruc2k0lHRNuV/sEwSOaH2YCEHvKY4O+UczUU0g1Uk4lMb7KtFvFnonzGRQKDdT07
	Ylno8l5GapOpF1Hy0P7ULuFX64Cl/2BMHrUQVOoOrWMQYCasYRrfr2H15OMHAajfZr207Xcw5UA
	qWu9wflmMNcyzqNtweox2sx20zGV5el8QRfOLYGZ8WvfqYMgiWwEcp9uNENgYpAtBW20JTiCtZT
	AeDksoJhWet4L8TcyxR0BCv7bLlK/WfrMOF0A5NEUM4YmrZX5zv0UjmcaGKv1FxMduxQ9QtyGEh
	QZL3WccdBHrGIYIg7Latxm/aqt2HPgySY5a0l0bGNwrTAPbDe0Mgs7/QMTJO8rzcH2rZkwEohVS
	s+9EDZLOI5VS4WXHoU
X-Received: by 2002:a05:6a00:22c7:b0:835:3730:571e with SMTP id d2e1a72fcca58-83f03e91a86mr3976162b3a.5.1778686218924;
        Wed, 13 May 2026 08:30:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf0cesm33281534b3a.46.2026.05.13.08.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:30:18 -0700 (PDT)
Date: Wed, 13 May 2026 08:30:17 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/6] xdp: convert to getsockopt_iter
Message-ID: <agSZAkPavoKMEF-K@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-2-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-2-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert XDP socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
