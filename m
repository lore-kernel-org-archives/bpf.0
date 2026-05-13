Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43347B42E
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686172; cv=none; b=t45WA+xeX2HZtrrVCk3c8Lyckib9BZ3dHpYvg+umqWo0B4x1z1jeSnAYkgI7xoQLE4PxuLlEdcB6/Ce0EYjECO2yXHJOp8V8tsZi4MDIZJWbgphAvEy3mhalnY/+DY4omRACvCtwM9jlGwdLsI/khMZgpO2CXn3P/AQ3IvLgOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686172; c=relaxed/simple;
	bh=M1hEq7CvxLU6On8D8G12Fmu9StcYyNPtR454jTWVVws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FI2STXhXXUbnDFjCCtRGoyVS0xhiVh94a8mhv/IwK+gpQ4xzJsggOylHr7SgiBFL81UVt6PElBMwof75YfJICam1dkQLY9EMtmOejomaH392vfcJec1b9qPi876zsn3esOM2qUFgvi2qFFm5HjK/fEbERkp3YcckUV1DqM7bmTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTmdj9gS; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTmdj9gS"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so45058125ad.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 08:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686171; x=1779290971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVg3X9kh4YDCRW/k5ke7n61nVYb/5/0InQTRe/5tw20=;
        b=ZTmdj9gSsZaBZY1YOfdpt3eODsKmrC/NOTOs4vTqCrI88TrchikfNBMBVmbvrVBbGR
         8ciyNnPtXhvLPGTBKAi3h3teHwEpEIhzP2ttmfos6w5J634Bc3isf5wpiDNJ/KdeZEYu
         GWsABXBgJUYsd+tE2ivAi2X2pcm166Ektny0jnkPFm38aoio0lg33Z/NdH/WfeJewPNd
         /2bN5ZpTIjD9TpyBEWGGBdC/Zz8niaYdjofJ7Rwrnsb7ZIJjSCaGeEXWQ/fdiioDmfSh
         dmDqV3sHmovTENOWdJELbrgdYij1bsA1beHf5HsxxVGzfQuOktdYLYcnWFJLtFnCn+Z/
         iPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686171; x=1779290971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVg3X9kh4YDCRW/k5ke7n61nVYb/5/0InQTRe/5tw20=;
        b=ZceOnlX+pXYM5w9Msa5SL7ROepNPzTvJi33f0A3xh0rIStClzpdhOh8COKRJFWCO/7
         oBeFBybCQeJ+ZOcCXHgN+tmjEHOxFRWAT2owxmsKBTDdHslWO+/TfM9grRHQUCscwayn
         n2UAVRa+18yI1oLj9Dow0QL8cGcIKzryQYOMcqbB/nixY1+g2At/S/CFPMkUL5MWzYkg
         3/KBbYRiHCVbnPC9hTf4Fu5bRuba7pNgRektAk6pkq50x1q6BrbkDTNkJBC+gmPyoX43
         Dd2ti4rtlk+v9XHzEwcZe4ozyU3EFlcgEm1lIqBFEkI33izD961LwzE27XW8hd+yGqAI
         iNlg==
X-Forwarded-Encrypted: i=1; AFNElJ8E86HH37gbYWG/ElM0GFi/xRqlwCyDMYVqXmPAO9aoYUiIEnm1/+HpZz22OO+0i0J4FIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxThjhtx45FaqYHQ6KLY9k121QyQyxaNvk+xKuz6Ne+s1qbQXGh
	3ts8U7iaDfjB5YGLWHXJeDerJVNNuuEY1bTDBXITIZfgWiq2pR8zERhw
X-Gm-Gg: Acq92OGFiMtBqCj7DIWx/0W8MsPVv/gok1CSZii0ocCG1F+FrTy1hn1QPBtN2p4alKP
	X5pDSfwlvY7qAUMs79V/l59XQqTdQXinpCAV0zjxbrH1bR2CHNe9/0yG7wj0tYOoqCnuf97kg1J
	kHXtQaLahQiGlsuI8VHNh0saEE9PiSOzSICFDILgtUx0peVgUWIf7/y9+p3SAj8DXEvzCbT25Cr
	9e95sjE8/Fe7hwmuLgakFkXTHUJfkwH4IztE8ayI+BOz7a7snwQjr9002NipIYFT9YvVzL/yZiy
	ytxpzRY0T5tmaye5NwWqMUezSxIX7TY14TEptR+x/bOhKvtkCRmj1YHHlH/jzFqcYPAtu26L2iu
	GrTIudL1+KUPEK/75YBkhXI6TURTQAiJ+5sj68jBrJ16JTKf6kYN3OE3/cB+QEioP2WqS4RQLQI
	7FLgf6tc/0h49+6lm1
X-Received: by 2002:a17:903:388d:b0:2ba:1c8e:256a with SMTP id d9443c01a7336-2bd30222968mr34932515ad.33.1778686170670;
        Wed, 13 May 2026 08:29:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebe0e8sm182921245ad.76.2026.05.13.08.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:29:30 -0700 (PDT)
Date: Wed, 13 May 2026 08:29:29 -0700
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
Subject: Re: [PATCH net-next 1/6] atm: convert to getsockopt_iter
Message-ID: <agSYw5V5Z6Jbtjb1@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-1-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-1-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert the ATM SVC and PVC sockets, along with the shared
> vcc_getsockopt() helper, to use the new getsockopt_iter callback with
> sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
