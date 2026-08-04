Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35146C849
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838047; cv=none; b=Ajv61yh4u+rpsZFWBDKN4ulN4foOWkcO+grEccKdJlbEz+mQk3wrJuM6i0KJxENF5I+HUgZJssRueJ+55FRXOVUshFHRylEqrNfO4P7cL5de/7WKFoj0tRTLKTTQFSzbaUinP1nRQ7EC/t9VCakXq/GLcPLgSrGe7iBXC4ulWGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838047; c=relaxed/simple;
	bh=jepb+VUTDpbcYOcoiP3c8KCXVj2f5l9bEEJUCWbsoek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KaGEPTuDvXhdaj+pUuPC6smDRS04c8mYJNRAUvq+wBwjaKTEcNgOnGcjcKQK7kbK9fJk2ipCf8nwe7k4vru7zxCGuNMCTzWHYl1K1oxuC9xiHY6bj+CbauGw1PSQ0P2yfDeu/Invhjw/80SKfsC91lh2GRAIBzlZZz6awBdjzKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NgUpmUg7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NgUpmUg7"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso5704511a12.3
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 03:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1785838044; x=1786442844; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jepb+VUTDpbcYOcoiP3c8KCXVj2f5l9bEEJUCWbsoek=;
        b=NgUpmUg7cQii/IkFbGxBuBK00C8eBks2U+xWy0LE9cz//yNS9Zz/F280DcPWxnm/ds
         75ubtCxGsi8bohJvB/I+V4vYGsOI/qNd29uEiNj0G5vsWXFTYhcyZb8zSepxNGxGLTwS
         k1L18HbNKW72YJeOu5FPXDyn0f3M6K5rgdq5QnxPJrHBdt82WgNi+xxUZUQa2cLWxzC0
         zVg+psjfgLhJFCVnefQF7Px6r/JxnxQ+z9x7R7Aht0Wg6aeMsnX1X8ZBnWtRHgDnZ9yy
         NDkCqFysjUJzedLAYsFn24GKqPnwc+auWtmMsQ+2r6LCH/aHiRVw92CGEB5URnD9brhG
         jgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838044; x=1786442844;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jepb+VUTDpbcYOcoiP3c8KCXVj2f5l9bEEJUCWbsoek=;
        b=lYPM9bcs8wf1AWyzViiU8hGsS4iYIuTHDFYin33I/a8T1sufs2LJYBHVNxDnz2PFDN
         L9TaYaLPsKkZG2zb3AjPRTU2Q86Si/50CMUuS/MFoeWTDU++9stSib9o7ZGbVV4Rf/bp
         C9MQBo0WUPrtNxfN19UcunHA89Ri7tF0NZ2q+g0LDzhRsb7FQugbIkWck43LNUiMihZS
         GpNwAqNUgAOHw4EzEVHjMzwnbbIV/YVW/S8Vi/tjPxM442Ae0ea0Fq4WouGdV+zFuowH
         DKWKj1QsRLVKsioy9U2bxl0GwKLAe8lCEP08Gb8p5ibjreHVHcD6QYzjzshlgAlszMa0
         yv3w==
X-Forwarded-Encrypted: i=1; AHgh+RqKhJCdPlQ+khrmg4u6Vz2rIjD/8llze5RI5GotgVrdBc3+y6J9sKjDShfrSM4zjxPxZdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+yNor0fcz+zYipVXZa3zbGrQFMRHhZZtf3GGQIPAlu4tyEAL
	n86UXodRS+9C5LnUQe/Dp6yM91CMdvA4wcfwA1ZtWGxSsOV9oLC8mp5Z6IXLWVKTu20=
X-Gm-Gg: AR+sD10LrRehnYm+cZEnYmSbsjWkmkduCRfJTbqD94lxutvCYZn7UbfeKmsMSFbOJV8
	8DynPD3frH0pVWco1Ei5hTEt1tKv9cFyKlQN66HSgH9pm8ryy6/5e6tfqIDMPNfFcsjL7L3DcYh
	Ego36j0Ed34x+UajkYLM4mRbJcfnVfD2M1bQm+c5+8406jdlpRLwhY9Z6ZHWwXvwaTl89C255Ca
	Tb6MQ47MfGixfLWIOPSzL8yVekEcm6aMfD8CFUmvG/X77b5FyhYolzFQ8jDjbExq+TCEs1SakCE
	uTVx70awgSKI+WJ3lo7Xyt3OGBT86cy0BXK2M5sQoaZcPkfRmEEJ5fEJY8sXPdEW/SOjLT/WDoo
	ySE+iQdXeLBV+GUzvwHlPAV8mg2IbUll+G6xJug0WD+qp8IGh/+lwiKQmhnkYIM/TBBL9ouKt7R
	J6ZgLBp/g69L494iSv44EibcRC8VHXRBovRlUhAMc4yA9G7wABLtbQWWFcqzeY14M=
X-Received: by 2002:a05:6402:24c7:b0:698:428e:9177 with SMTP id 4fb4d7f45d1cf-6a0a7c899c3mr9512823a12.11.1785838044186;
        Tue, 04 Aug 2026 03:07:24 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c5a09acsm6317456a12.4.2026.08.04.03.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:07:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Kuniyuki Iwashima
 <kuniyu@google.com>,  Willem de Bruijn <willemb@google.com>,  Jiayuan Chen
 <jiayuan.chen@linux.dev>,  Joe Stringer <joe@wand.net.nz>,
  bpf@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: Extract shared reqsk-to-listener upgrade
In-Reply-To: <20260803-sockmap-lookup-tcp-leak-v2-1-306e025bfe66@rbox.co>
	(Michal Luczaj's message of "Mon, 03 Aug 2026 11:00:42 +0200")
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
	<20260803-sockmap-lookup-tcp-leak-v2-1-306e025bfe66@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 04 Aug 2026 12:07:21 +0200
Message-ID: <87bjbiyzae.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 03, 2026 at 11:00 AM +02, Michal Luczaj wrote:
> __bpf_sk_lookup() and bpf_sk_lookup() duplicate the same sk_to_full_sk()
> reqsk-to-listener upgrade. Extract it into a helper.
>
> Leave the currently unreachable WARN_ONCE as a defensive assert.
>
> No functional change.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
