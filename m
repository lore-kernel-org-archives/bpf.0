Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80812315D33
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686487; cv=none; b=SKtHOC1MvqCkQFh38qqSPNRQcqili6ub7xERwYVOzK8FxvhEL360IgiSLUkPL1Csa9eKBywVAhl4q+pCm7IYcasw76gEVsgFW87xoV2+g7r2G28lxG2LNXoaSESWiypUP1whEn9J7HPbXvpWFep+gwRTP+UIO9wUUxX57k1RSnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686487; c=relaxed/simple;
	bh=juof8ClPWBcdbohM1aei0MyS3Zb/FxQ4cYPoANkh300=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5FrzpwcUdmkhC4hJEH9XJLOQLnlM2zgfL4k94R/2Dv46F6L5gH14VGozJSi8fw26dCL+n4qCsiSJCXQkUVeo3DfWeV8x122PPZWYKZRACRt3RqXmCpvPkBKm92acXyGQWvoImQ5SV0pNgDbb/kgIbUnp0NrWmQevFSi4WexbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imrjxX0c; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imrjxX0c"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2b9ec9443c2so42374195ad.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686484; x=1779291284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sULJalq8qpR0SDmRCBfWcTtKyEat46ygMheSeQ0h0XQ=;
        b=imrjxX0cTYlanQZ7gYA+Az1GipburGcWY5CXtIP1+67BLO5IjcuAa1fpin18csCpjJ
         qtAyaEdDRyXPHx/RA1dzqn6vMBYIszLUSqADA1w6Sw9cxYWX/O0r2EImBOvOGXMisUWc
         qCYzR4Zl3IOojPVGPvUEURhZV9DkDmno5YyicrfDs3e8nmSo01vEnbd0UT7WKEzdukk/
         KWxZvMx2YIxKk478kCwXztvMHoUO+JlxcvBo8g+BvbPD+qcTa99C4CdHWeuHrirwWbsX
         eT0USPt04nZ6be1jKwRqUyWSW/HbPsYxw3vowi0IS6Xj8yIvZsnaft2PET1bWwIxkpLf
         sJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686484; x=1779291284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sULJalq8qpR0SDmRCBfWcTtKyEat46ygMheSeQ0h0XQ=;
        b=hO0v8P6pWhNft3qxCS6PjmvtZ13KjARqvVoURTmJViCGFVjfL2C+wgbK1AiQPaq8gp
         3jSY1vDgKUrj9aR4Uuz+M9Te4BTG7+d4JbKfCbZ/flgaWF6TFuebKxOpAtyaBCzQtIl2
         0NG/VyN+EGiKmYah5TRRSBWSaUkkhT0X1OwaBrYCbIAPM4Z7RirniMvDdJuuKh4x2QY+
         Xp4KOEKMIu+rwMusx3sBAD5gLXKfLivpTVeLi4nApxFFA9+LIxWvxHEDD2VgH3SjCWzP
         0hrAlK9M2ghAnSaTjo/jApaxj6WT6gdnfCaX4L4tyWroAXvaGJowl0RsKtXto/qxlwQe
         wusw==
X-Forwarded-Encrypted: i=1; AFNElJ+g/gzlN9NE2uAKuqssBe5d3VRH9EG38BuNfMAsXGQFGEgPoH/Z1n3H7R/bRYc5zj87gco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5NGCrhE/UqvchzOMCHr21fL4sMz1vb6Fos8nfs0NNDqiqbfg
	UbYeyTaULz+n9ViJog3QutWQfRFZm6ii+Yw7qJpzZKddjLQ4w7rMzBBP
X-Gm-Gg: Acq92OEr67xPd5dCfxv8Il3CfjXaSpB4z8IFuALEUFSeeJtC12YVRsr0U93eIN9YLrl
	v3QzKFTMAIyc5Yj7kw7tf4jgmUvjGlVgJ8K3qPteZgTVH0OEuo05EUlTE7xx0D4w7hZgEvn/76f
	5nvX1rQqKHAs2jBf/VD34b9ivAhkSOqx2q/CrSXETpR7ll0AR9OZzFMoCb8Xdc90PtbzuEInjEs
	1fQrXovs9fbavkfGpvGcUyqTX8bDeasL2IvoKXIdl0z17YY4UJzgnUZvEIcJ9b3hOqgRpQlDtkf
	TBL/xuaZEZNyNC4dCwwH48PLOP7JXSlZrhYNY0vGyrXvo7UetDgHEghOPCmZxpAxJlNsebL1pTR
	0wdHNjDphKwQUUR9DzXuo95+uZK3rDIuRGAYiOxU9aUq2Y/6lGPrlY2mWONVPKpo2ebe96qQWzC
	QNBdctvHuCpcTEP+zo
X-Received: by 2002:a17:903:1aef:b0:2b9:cabe:ce37 with SMTP id d9443c01a7336-2bd526ce2dfmr298035ad.1.1778686484215;
        Wed, 13 May 2026 08:34:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebea72sm174932375ad.77.2026.05.13.08.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:34:43 -0700 (PDT)
Date: Wed, 13 May 2026 08:34:43 -0700
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
Subject: Re: [PATCH net-next 6/6] tipc: convert to getsockopt_iter
Message-ID: <agSaDOAx1HBSDoCQ@devvm7509.cco0.facebook.com>
References: <20260513-getsock_four-v1-0-fe7f0e756fac@debian.org>
 <20260513-getsock_four-v1-6-fe7f0e756fac@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513-getsock_four-v1-6-fe7f0e756fac@debian.org>

On 05/13, Breno Leitao wrote:
> Convert TIPC sockets (msg, packet, stream proto_ops) to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *sopt
> - Use sopt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> The sockopt_t parameter is named sopt to avoid collision with the
> existing optname parameter named opt.
> 
> Note: Dropped the unnecessary parentheses to make checkpatch happier.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
