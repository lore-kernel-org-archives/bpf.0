Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D0F5013B9
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699500; cv=none; b=Q/uG2RtTFctQcjK16hfN3OymJ9PgsKtGK1CXp2gdB/CS4XxvoUkMIuW2rBNBHbC38JymcDYc9j09K41G/6VGuzZnaU4op2j0I0rm3LQoEpUYaCtnREgfZ7iJJHuEj8NL7hOrVCieopSRyPOg5Uk477bSCbMTYilQRH3hSYe0k1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699500; c=relaxed/simple;
	bh=lnpKMnLuqv+oX44Oz2gq1nLSEgp1cliwREafqFlWmDY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YQ4Wxp5ETdAou1Mh7DrPP4RJ4H56FrxOl7CnGSSI697JJQYAlComTSgOvFlq7VBQ7OcteNRLzVmjVOWHCNXTZbDYRijgJjCCKuVdl6e0ncbyeyboQEh9DjK9f2UjaBUU2d1HD7cpbqi4VzQ0/G36FuwBuRLg1xBTdwNik/5cUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXLZnBkh; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXLZnBkh"
Received: by mail-pz2-f37.google.com with SMTP id 41be03b00d2f7-cc7d27b7410so101855a12.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699499; x=1791304299; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vWBRVFg3TNII9e3JzDYA1qiuNTLpJveN/yke9DPuJTk=;
        b=WXLZnBkhaQdF/n4yC0ECg3VUQDF1tfB5yHqnqXisqAp9F9pakdePCmKAKHtu4mZ3C2
         5h7bRYuW4CKnad0F6ikmUcR7KhJECVan+A4XYV9UIm5yacC94ktORqUpxiTu85MNUbw6
         1Zte8PAEukPCRYONDX3xeeZZVLSnhoKgEZy4zgl/7RAG64hMciGhHjZmCmn63j+e6q+e
         jAGLTztlNpk2eHGxEhzoiMRHr4N5ZjxGrMVoVZHGRbtKyuwVTr48tfRk4RMwavxJXYI/
         /K2C3CzsFVsSqE1nr7BqgZ0nw3YG0jIGSWml4hDAYj6mbslFeGojuj9f4tmkBu7bxRrh
         JGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699499; x=1791304299;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vWBRVFg3TNII9e3JzDYA1qiuNTLpJveN/yke9DPuJTk=;
        b=XhKzm8r8w7P3Wh1o1Q685wQtwqgqahWk8AGiJE2K1GVgd9qf9nuIzqyPmKFdqoe7bT
         PLD7RzaZ3u/6i8+z8e+FLcqdNQXSpYmFjwTVEMmdmKCJYVBlbUEtqzOi6/So2Gn8URR4
         k2QwqXDRMS1DxQsJSUQRV412sDGlghwC5Wa/eKbr+u48XZC/E0OUSI4J1e7SJUbmfw9v
         BDY9pwWKRmnE5k5hMGDVdGJsow8ZMqeizmzdlpuMXE+3ecobut989A3ewsV205so4ufC
         wFxNFlLA2pISSaOFnVMz7xbgxkFkz12IR5eWlT+8+6LK815G/uGe4HzaAydT4V1R72CS
         VZkA==
X-Forwarded-Encrypted: i=1; AKwUvBxutb+PnlOtlJ4Z60iCF89/t71uT/7IPk3wIOsM4wPLcm/uUxMrqYaukQa0QDAk3eejh8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lUVIxXceuZiFAkYmrOmeCXYU1p7zhzyQLjsY54op51pK8IulaI
	wm6TSipIJQyHDPv9hknvC4ff7iPFMfV9+Af79a9j2ht9aF2l91niFTjm
X-Gm-Gg: AYBFou2Zx8/NsaPOOuMNyn/s3upG7MbKPH6oFvTCZYWIkOn3mtfCEZ6o3b5FgMi3n3B
	LOb8YWtC+3FliMXkXvtsHgXg2hBK9OntZ3ksEsIIu1mvWkreR7HNQ2c+NrxukgbNBwB7LblMM32
	/fmzQUUyCEACejAvVSsE9tH9eyXbYxjJKQe6P9dz+wxtFvO8GbJAEvalatlUhY0LuW7fuRff3/2
	ouCsXSGAvoe3THX5CNo01nFkg7vvxYeJPsa78J4mv4mGGEjumZVdhZoAldDET9MIQSNL0jlVGwx
	WtSHqQPbQ6zHA7fnlWxnb67jim2xekjLIZrEEL4JKbqTca8ISnR5cRirQQV8Bie6yerdNIppS6G
	EAnGEwQoiNi0Gwwd1/M7csNPC33I5i9tvKnKEVSs9KGfJ9Go9lGADeVWmUNYT8QxbdT1lXPJrI2
	PyPFUQvQtmmMWgpUL4FoUspyh7eMaiOe8wum5Pg11ZPjZeIFEPofkn4fXylnntpKgEKrQUWG56u
	L1bQjVX28sRsSph9BPrb/ZJpTWYgWbG2MAugJmUSpYa8xxndJ0kpqBE7vqR2gIQLJOwGmjWDfge
	235x
X-Received: by 2002:a05:6a20:9e4c:b0:3dd:a007:cb2a with SMTP id adf61e73a8af0-3de26db5242mr11967568637.38.1790699498710;
        Tue, 29 Sep 2026 09:31:38 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7d2b562d8sm109617a12.24.2026.09.29.09.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 09:31:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 16:31:37 +0000
Message-Id: <DLRXZSBSYJ2K.3UN9IME1MKDD9@gmail.com>
Cc: "Florent Revest" <florent.revest@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Linux Kernel Mailing List"
 <linux-kernel@vger.kernel.org>, "Linux Next Mailing List"
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Mark Brown" <broonie@kernel.org>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "bpf" <bpf@vger.kernel.org>,
 "Networking" <netdev@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <arvRs4KdojDnW1O6@sirena.org.uk>
In-Reply-To: <arvRs4KdojDnW1O6@sirena.org.uk>

On Tue Sep 29, 2026 at 2:56 PM UTC, Mark Brown wrote:
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   arch/x86/net/bpf_jit_comp.c
>
> between commit:
>
>   17637e1a581a2 ("bpf: Skip detached progs in trampoline images that are =
still in use")
>
> from the bpf tree and commit:
>
>   29fcf9ce4bbdf ("bpf, x86: Use global buffer for trampoline size generat=
ion")
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This

all correct. It will get fixed when bpf gets cross mereged into bpf-next.
Likely on Thu or Fri this week.
