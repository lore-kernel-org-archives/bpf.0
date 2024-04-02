Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64515A48E
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081706; cv=none; b=uKAKPelr4eI7HHKjqeFRzK+Jr4AXC5RU7eWChva1hEsn5NXI6KOOgBPG9EBxf8YHVAQ4lJZOfxOYlmsAH1a4p5SyGezKHi0NCKwN5xfA2AZS7krR75UFWG7Hj404LaPKaPIKCuaYLK0Yv6c4e7XzPlVRYqcTsBhrDZO5HiBP274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081706; c=relaxed/simple;
	bh=46KRqglWord9rtMJP1zH3v5q6uz/1865w6V7OrJf2L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4kRUM+fFLp0mUssnV+LYbEBNUe4CzMMWP1hJNeBkFh5AOOz/k81YBtmd63OMUQ4t65rhqKg0Tcf113oPXRq3GSB6JBP6LhPP5qB5KwSEsAYddhxZtvtHGW6tonh8tLJsbC0l5THzKkxsy4bk7iRzWBqUxlrWiMSSqjfgkVa4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QrrTfE5e; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QrrTfE5e"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4e60a64abcso21697466b.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 11:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712081703; x=1712686503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46KRqglWord9rtMJP1zH3v5q6uz/1865w6V7OrJf2L8=;
        b=QrrTfE5eHT9Ks7P91fL9DWFfHfSPMbXGPLy61CxZpOMOXgBWxr6K9tzWe7KV1LXtIL
         udB6dXq7MEVactyVz7QR1KUUbajVJ+MjxUDGIw51tVRm6QDeSG7+V04e/rkmQFJfu+cC
         po/iuhj8u9lncJwajFBU46fPI5Rc/XtxZamDbI1cHO4RinWnQJ/TFgiNtFEnKhdw0dXz
         YPeHgAwj8QB41RsA0p1iprvkWLRrtQdI6Z56jNtRs2YZXNj+e7AGtswL08ODqeYamH8T
         Xl6oz2QuH0fGXg2NhozatSLqwzp2v3nCEyi/UTXQ4QIMmgBYkd4fi8k6XBioVPldu+F6
         aYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081703; x=1712686503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46KRqglWord9rtMJP1zH3v5q6uz/1865w6V7OrJf2L8=;
        b=jEPF/djVg+A+FBp1WWC7bo99jMJ4+6AIs0pqpkVsaM9zCyUcfq/sWVQe4u4NDr5x8Y
         XVePrNsMPyFBm00Aiqkdqlz2VX0Kg0wVmX12LgYlR4upsC4g042yOAAgnGxzX4ZRv6ex
         q+sMD9z4vmgGw1I+RFi+kF9xIiaBo1WxqxuXZbP1O5jMbjSoO66lcoQvGXNUnTcsL11u
         GJlHux1quJL7y7A2mGw0AGPbmaBkXmA3N2jTC3xTrY2q5Z87lX+5mX9j4xu3nW60mp6s
         VfZjmgLgFgquDk7ezGNICB/2qC1MNw//6U2jTCg+jhKObGusx/EwNZcjr7wVWUCtBc4W
         zvPg==
X-Forwarded-Encrypted: i=1; AJvYcCU8SmUPiCmiU2cEhBkvyMBeNrjrs55/Kveqq6p5C5I9wF9m3NRZrXRhlK4ZcFmiWX2rg6sxJt15c4ZxTEVzTUWYbXSK
X-Gm-Message-State: AOJu0YzV/0EI49/KMLyad+DgPv5SCHYZiw9kNrz1Zmq23NTj2xfT8dko
	DPd8VfIQoPU4NgDI0AAgytQttzA7trV75MrvzrxpU75dzGLnubb1JS+KNrd4U9nmkeIqfMU6/+V
	LltV9sfcDVzyUsd8BiAdP9y/k8dhlHVzfbK29
X-Google-Smtp-Source: AGHT+IHP5t0nrM9tmIdN/vj1cEcR9X51TIZOinjwJqg520IJ7wC6cLJyegvw1MPl9rlRhm9Xs3DTLyD/c/Q7svlAuPk=
X-Received: by 2002:a17:906:488:b0:a4e:1d5f:73ae with SMTP id
 f8-20020a170906048800b00a4e1d5f73aemr216379eja.12.1712081703092; Tue, 02 Apr
 2024 11:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com> <20240329191907.1808635-2-jrife@google.com>
 <007e30b4-31aa-41b0-9e19-f7e2a385773e@linux.dev>
In-Reply-To: <007e30b4-31aa-41b0-9e19-f7e2a385773e@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Tue, 2 Apr 2024 11:14:45 -0700
Message-ID: <CADKFtnScmu+57KURFEUG5s8Qcx6NfAgF1XNfjT+fSZNLqV4amQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 1/8] selftests/bpf: Introduce sock_addr_testmod
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Martin and Andrii,

> This function can be made as a new kfunc in bpf_testmod.c. The
> sock_create_kern() could be moved to here also. Take a look at the
> register_btf_kfunc_id_set() usage in bpf_testmod.c and how those registered
> kfunc(s) can be called by the bpf prog in progs/*.

Thanks for the feedback. I will explore this approach and see if I can
get rid of the additional test module.

-Jordan
